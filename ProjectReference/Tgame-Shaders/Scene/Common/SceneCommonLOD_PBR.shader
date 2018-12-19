///LOD 300 Bump + Re +ForwardAdd +Amb
///LOD 200 Re + Amb
///Update 17.4.13:use Shadow Mask mode for bump&Specular after baking
Shader "TSHD/Scene/SceneCommonLOD_PBR"
{
	Properties
	{
		_MainTex ("Main Texture", 2D) = "grey" {}
        _BumpScale("Bump Scale", Float) = 1.0
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5
		//_GlossMapScale("Smoothness Factor", Range(0.0, 1.0)) = 1.0
        _SpecColor ("Specular Color", Color) = (1.0, 1.0, 1.0, 1)
        _SpecGlossMap("Specular(RGB),Smoothness(A)", 2D) = "white" {}

        _FogVal ("Fog Density",Range(0,1)) =1.0
        _FogHeiDen("Height Fog Density",Range(0,1)) =0.0
        
		[HDR]
		_EmissionColor("EmissionColor", Color) = (0,0,0)
        _EmissionMap("Emission", 2D) = "white" {}

	}
    SubShader
    {
        Tags { "RenderType"="Opaque" 		"Queue" = "Geometry+100"}
        LOD 300

		CGPROGRAM
        #pragma surface surf StandardSpecular  vertex:vert finalcolor:fogColor exclude_path:deferred  exclude_path:prepass   nofog
        #pragma target 3.0
        #pragma multi_compile_fog

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _SpecGlossMap,_EmissionMap;

        fixed _BumpScale,_AmbScale;
        fixed4 _Color;
		float4 _EmissionColor;

        half _Glossiness;

        fixed _FogVal,_FogHeiGlobalScale,_FogHeiParaZ,_FogHeiParaW,_FogHeiScale;


        struct Input {
	        float2 uv_MainTex;
	        float2 uv_BumpMap;
            float2 fogCoord : TEXCOORD5;
        };

        void vert (inout appdata_full v,out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
            float4 pos = UnityObjectToClipPos (v.vertex);

			UNITY_TRANSFER_FOG(o, pos);
			o.fogCoord.y =saturate((worldPos.y +_FogHeiScale)  *_FogHeiParaZ +_FogHeiParaW);
        }

        void fogColor(Input IN, SurfaceOutputStandardSpecular o, inout fixed4 color)
        {
				#if defined(FOG_LINEAR) ||defined(FOG_EXP)|| defined(FOG_EXP2)
            #ifdef UNITY_PASS_FORWARDADD
				UNITY_APPLY_FOG_COLOR(IN.fogCoord, color, fixed4(0,0,0,0));
            #else
				fixed3 orCol =color.rgb;
				UNITY_APPLY_FOG(IN.fogCoord, color);
				color.rgb = lerp(orCol,color.rgb,_FogVal);
				fixed3 HeiFog =lerp(unity_FogColor,color.rgb,IN.fogCoord.y); //Height Fog
				color.rgb =lerp(color.rgb,HeiFog,_FogHeiGlobalScale);//Height Fog Density
            #endif
			#endif
        }

        void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
	        half4 c  = tex2D(_MainTex, IN.uv_MainTex);
            half4 specGloss = tex2D(_SpecGlossMap, IN.uv_MainTex);
	        o.Specular = specGloss.rgb *_SpecColor.rgb;
	        o.Smoothness = specGloss.a *_Glossiness;
           
            //o.Normal = UnpackScaleNormal(tex2D(_BumpMap, IN.uv_BumpMap),_BumpScale);
			half4 packednormal =tex2D (_BumpMap, IN.uv_BumpMap);
			half3 normalLocal;
			#if defined(UNITY_NO_DXT5nm)
				o.Normal = packednormal.xyz * 2 - 1;
				o.Normal .xy *= _BumpScale;
			#else
				o.Normal .xy = (packednormal.wy * 2 - 1);
				//#if (SHADER_TARGET >= 30)
				//    // SM2.0: instruction count limitation
				//    // SM2.0: normal scaler is not supported
					o.Normal .xy *= _BumpScale;
				//#endif
				o.Normal .z = sqrt(1.0 - saturate(dot(o.Normal .xy, o.Normal .xy)));
			#endif

			o.Emission =tex2D(_EmissionMap, IN.uv_MainTex).rgb *_EmissionColor.rgb;

            
	        
            o.Albedo = lerp(c.rgb,c.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
        }
        ENDCG
        }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        CGPROGRAM
        #pragma surface surf Lambert exclude_path:deferred  exclude_path:prepass  noforwardadd   novertexlights 

        sampler2D _MainTex;
        fixed4 _Color;
        half _AmbScale;

        struct Input {
	        float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o) {
	        fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	        o.Albedo = lerp(c.rgb,c.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb

        }
        ENDCG
    }

        FallBack "Mobile/VertexLit"
}
