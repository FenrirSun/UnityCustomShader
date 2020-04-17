Shader "Tomcat/Character/Skin"
{
    Properties
    {
        [Header(Base)]
        //漫反射颜色
        _Color("Main Color", Color) = (0.0, 0.0, 0.0, 0.0)
        //漫反射纹理
        [NoScaleOffset]_MainTex("Main Textrue", 2D) = "white" {}
        //阴影衰减
		_LightAttenFalloff("LightAttenFalloff", Range(0, 1)) = 0.3
		_LightAttenBase("LightAttenBase", Range(0, 1)) = 0.5
        //法线纹理
        [NoScaleOffset]_BumpMap ("Normal Map", 2D) = "bump" {}
        _BumpFactor("Normal Factor", Range(-5,5)) = 1 
        //mask贴图，r通道用于_LightAttenBase， g通道用于_MatCap
        [NoScaleOffset]_MaskTex("Mask(r:atten;g:matcap)", 2D) = "white" {}

        [Space(10)]
        [Header(MatCap)]
        //Material Capture纹理
        [NoScaleOffset]_MatCap("MatCap", 2D) = "black" {}
        _MatCapIntencity("MatCap Intencity", Range(0, 1)) = 0.3
        _MatCapSpec("MatCap Spec", 2D) = "black" {}
        _MatCapSpecIntencity("MatCapSpec Intencity", Range(0, 1)) = 0.3
        _MatCapColor ("MatCap Color", Color) = (0.2, 0.2, 0.2, 1)

        [Space(10)]
        [Header(Specular)]
        //高光颜色
		_SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
        [PowerSlider(5.0)] _Specular ("Shininess", Range (0.03, 1)) = 0.078125
		_Gloss ("Gloss",Range (0.01, 1)) = 1

        [Space(10)]
        [Header(ShadowRim)]
        _ShadowRim("Shadow Rim Tint", Color) = (1,1,1,1)
        _ShadowRimRange("Shadow Rim Range", Range(0,1)) = 0.7
        _ShadowRimThreshold("Shadow Rim Threshold", Range(0, 1)) = 0.1
        _ShadowRimSharpness("Shadow Rim Sharpness", Range(0,1)) = 0.3
    }
    SubShader
    {
		Tags { "RenderType"="Opaque" }
		LOD 200

        Pass
        {
            Name "FORWARD"
            Tags { "LightMode" = "ForwardBase" }

            Blend Off
            Cull Back
            ZWrite On
            CGPROGRAM

            #pragma fragment frag
            #pragma vertex vert
            float4 _Color;
            float4 _ShadowRim;
            float4 _MainTex_ST;
            float4 _MaskTex_ST;
            float4 _MatCapMask_ST;
            float _BumpFactor;
            float _Specular;
            float _Gloss;
            float _LightAttenFalloff;
		    float _LightAttenBase;
            float _ShadowRimRange;
            float _ShadowRimThreshold;
            float _ShadowRimSharpness;
            sampler2D _MainTex;
            sampler2D _BumpMap;
            sampler2D _MaskTex;

            #include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
            #include "../CGIncludes/MatCap.cginc"
            #include "../CGIncludes/ShadowRim.cginc"

            // #pragma multi_compile_instancing
            #pragma multi_compile_fog
            #pragma multi_compile_fwdbase
            // #include "HLSLSupport.cginc"
            // #define UNITY_INSTANCED_LOD_FADE
            // #define UNITY_INSTANCED_SH
            // #define UNITY_INSTANCED_LIGHTMAPSTS

            //顶点输入结构
            struct VertexInput
            {
                float3 normal : NORMAL;
                float4 vertex : POSITION;
                float4 tangent : TANGENT;
                float2 UVCoords: TEXCOORD0;
            };

            //顶点输出(片元输入)结构
            struct VertexToFragment
            {
                float4 pos : SV_POSITION;
                float4 diffuseUVAndMatCapCoords : TEXCOORD0;
                float3 vlight : TEXCOORD1; 
                float4 TtoW0 : TEXCOORD2;  
                float4 TtoW1 : TEXCOORD3;  
                float4 TtoW2 : TEXCOORD4; 
                SHADOW_COORDS(5)
            };

            //------------------------------------------------------------
            // 顶点着色器
            //------------------------------------------------------------
            VertexToFragment vert(VertexInput v)
            {
                VertexToFragment output;
                //漫反射UV坐标准备：存储于TEXCOORD1的前两个坐标xy。
                output.diffuseUVAndMatCapCoords.xy = TRANSFORM_TEX(v.UVCoords, _MainTex);
                output.diffuseUVAndMatCapCoords.zw = TRANSFORM_TEX(v.UVCoords, _MaskTex);
                //顶点位置
                output.pos = UnityObjectToClipPos(v.vertex);

				TANGENT_SPACE_ROTATION;

				//坐标转换
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;  
                fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);  
                fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);  
                fixed3 worldBinormal = cross(worldNormal, worldTangent) * v.tangent.w; 
                
                output.TtoW0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);  
                output.TtoW1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);  
                output.TtoW2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);  

                //环境光和顶点光
                #ifndef LIGHTMAP_ON
                    #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
                        float3 shlight = ShadeSH9 (float4(worldNormal,1.0));
                        output.vlight = shlight;
                    #else
                        output.vlight = 0.0;
                    #endif
                    #ifdef VERTEXLIGHT_ON
                        output.vlight += Shade4PointLights (
                            unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
                            unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
                            unity_4LightAtten0, worldPos, worldNormal );
                    #endif // VERTEXLIGHT_ON
                #endif // !LIGHTMAP_ON

                TRANSFER_SHADOW(output);
                return output;
            }

            //------------------------------------------------------------
            // 片元着色器
            //------------------------------------------------------------
            float4 frag(VertexToFragment i) : COLOR
            {
                fixed4 c = 0;
                c.a = 1;
                float3 worldPos = float3(i.TtoW0.w, i.TtoW1.w, i.TtoW2.w);
				fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				fixed3 viewDir = normalize(UnityWorldSpaceViewDir(worldPos));
                //fixed3 halfDir = normalize(lightDir + viewDir);
                fixed3 mask = tex2D(_MaskTex, i.diffuseUVAndMatCapCoords.zw).rgb;

                //法线
				fixed3 normal = UnpackNormal(tex2D(_BumpMap, i.diffuseUVAndMatCapCoords.xy));
                normal.xy *= _BumpFactor;
                normal.z = sqrt(1.0 - saturate(dot(normal.xy, normal.xy)));
				normal = normalize(half3(dot(i.TtoW0.xyz, normal), dot(i.TtoW1.xyz, normal), dot(i.TtoW2.xyz, normal)));
                //底色
                fixed3 albedo = tex2D(_MainTex, i.diffuseUVAndMatCapCoords.xy).rgb * _Color.rgb;
                //光照阴影
                UNITY_LIGHT_ATTENUATION(atten, i, worldPos);
                //这里用viewDir虽然丢失了真实的遮罩，但是对质感的模拟更好
	    		fixed nh = max(0, dot(normal, viewDir));
                //光照衰减
				atten *=  _LightAttenFalloff + _LightAttenBase * mask.r;

                //环境光
                c.rgb += albedo * i.vlight;
                //阴影边缘
                half3 stereoViewDir = calcStereoViewDir(worldPos);
                half svdn = abs(dot(stereoViewDir, normal));
                half ndl = dot(normal, lightDir);
                half4 shadowRim = calcShadowRim(svdn, ndl);
                //基础光 
				c.rgb += albedo.rgb * nh * atten * shadowRim;
                //高光
				c.rgb +=  _SpecColor.rgb * pow(nh, _Specular * 128.0) * _Gloss;
                //材质捕获颜色，这里用的是叠加模式
                c.rgb += calcMatCap(normal, i.vlight, viewDir) * mask.g;

                UNITY_OPAQUE_ALPHA(c.a);
                return c;
            }
            ENDCG
        }
    }
    Fallback "VertexLit"
}