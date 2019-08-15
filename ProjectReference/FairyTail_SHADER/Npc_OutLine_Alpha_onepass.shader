// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Fairy Tails/Npc_OutLine_Alpha_onepass" {
    Properties {
        _Hit ("Hit", Float ) = 1
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        //_ColorR ("ColorR", Color) = (1,1,1,1)
        //_PannerColor ("PannerColor", Color) = (0,0,0,1)
        //_PannerPower ("PannerPower", Float ) = 1
        //_MaskMap ("MaskMap", 2D) = "black" {}
        //_PanU ("PanU", Float ) = 0
        //_PanV ("PanV", Float ) = 0
        //_UTiling ("UTiling", Float ) = 1
        //_VTiling ("VTiling", Float ) = 1
        //_NormalMap ("NormalMap", 2D) = "bump" {}
        _FallOffstep ("FallOffstep", Float ) = 2
        _FallOffColor ("FallOffColor", Color) = (1,1,1,1)
        _FallOffColorMap ("FallOffColorMap", 2D) = "white" {}
        _FallOffPower ("FallOffPower", Range(1, 2)) = 1
        _RimLightSampler ("RimLightSampler", 2D) = "black" {}
        _SAGMap ("SAGMap", 2D) = "white" {}
        _OutLineColor ("OutLineColor", Color) = (0.3529412,0.3529412,0.3529412,1)
        _OutLinePow ("OutLinePow", Float ) = 1
        _OutWidth ("OutWidth", Float ) = 1
        _FresnelPower ("FresnelPower", Range(0, 5)) = 2
        _FresnelColor ("FresnelColor", Color) = (0,0,0,1)
        _MatCap ("MatCap (RGB)", 2D) = "white" {}
        _LerpS ("LerpS", Range(0, 1)) = 1
        _ReflectPower ("ReflectPower", Float ) = 1
        _Alphabias ("Alphabias", Range(0, 1)) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent+1"
            "RenderType"="Geometry"
			"Reflection" = "RenderReflectionTransparentBlend"
        }

        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
			ZTest LEqual
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows   
            #pragma target 3.0
            #pragma glsl
            uniform fixed4 _LightColor0;
            uniform fixed4 _MainColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            //uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform fixed _FallOffstep;
            uniform fixed _Hit;
            uniform sampler2D _RimLightSampler; uniform float4 _RimLightSampler_ST;
            uniform fixed _FallOffPower;
            uniform fixed4 _FallOffColor;
            uniform sampler2D _SAGMap; uniform float4 _SAGMap_ST;
            uniform sampler2D _FallOffColorMap; uniform float4 _FallOffColorMap_ST;
            uniform fixed _FresnelPower;
            uniform fixed4 _FresnelColor;
            uniform float _LerpS;
            uniform sampler2D _MatCap;
            uniform fixed _ReflectPower;
            uniform fixed _Alphabias;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                float2 cap	: TEXCOORD7;
                //float3 shLight : TEXCOORD7;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                //o.shLight = ShadeSH9(float4(mul(_Object2World, float4(v.normal,0)).xyz * unity_Scale.w,1)) * 0.5;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 worldNorm = normalize(unity_WorldToObject[0].xyz * v.normal.x + unity_WorldToObject[1].xyz * v.normal.y + unity_WorldToObject[2].xyz * v.normal.z);
				worldNorm = mul((float3x3)UNITY_MATRIX_V, worldNorm);
				o.cap.xy = worldNorm.xy * 0.5 + 0.5;
                o.pos = UnityObjectToClipPos(v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                half3x3 tangentTransform = half3x3( i.tangentDir, i.binormalDir, i.normalDir);
                half3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float nSign = sign( dot( viewDirection, i.normalDir ) );              
                i.normalDir *= nSign;  
/////// Normals:
                //float2 i.uv0 = i.uv0;
                //half3 normalLocal = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0.rg, _NormalMap))).rgb;
                half3 normalDirection =  i.normalDir; // Perturbed normals
                half3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                //half3 halfDirection = normalize(viewDirection+lightDirection);
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
                half attenuation = LIGHT_ATTENUATION(i);
                half4 Diff = tex2D(_MainTex,TRANSFORM_TEX(i.uv0.rg, _MainTex));
                //float4 m = tex2D(_MaskMap,TRANSFORM_TEX(i.uv0.rg, _MaskMap));
                //float3 Diff = lerp(col.rgb,(col.rgb*_ColorR.rgb),m.r);
                //half2 UV2 = i.uv0;
                //float4 T = _Time ;
                //float Uspeed = (T.r*_PanU);
                //float Vspeed = (T.r*_PanV);
                //float2 UVspeed = (float2((UV2.r*_UTiling),(UV2.g*_VTiling))+float2(Uspeed,Vspeed));
                //float3 Pan = (_PannerColor.rgb*tex2D(_MaskMap,TRANSFORM_TEX(UVspeed, _MaskMap)).b*_PannerPower);
                half4 SAG = tex2D(_SAGMap,TRANSFORM_TEX(i.uv0.rg, _SAGMap));
                clip(saturate(SAG.g) - 0.5-_Alphabias);
				//half3 emissive = saturate(m.g*Pan);
                fixed4 mc = tex2D(_MatCap, i.cap)*_ReflectPower;
                half LightFallOff = (SAG.r*2*max(0,dot(normalDirection,lightDirection)));
                half StepFallOff = floor(LightFallOff * _FallOffstep) / (_FallOffstep - 1);
                half If_LeA = step(StepFallOff,0.5);
                half If_LeB = step(0.5,StepFallOff);
				half3 If_Output = saturate((saturate((StepFallOff+0.5))*_FallOffPower*_FallOffColor.rgb*tex2D(_FallOffColorMap,TRANSFORM_TEX(i.uv0.rg, _FallOffColorMap)).rgb));
                //half3 If_Output = saturate((saturate((StepFallOff+0.5))*_FallOffPower*_FallOffColor.rgb));
                half3 CombinC = Diff.rgb*_MainColor.rgb*saturate(lerp((If_LeA*If_Output)+(If_LeB*1.0),If_Output,If_LeA*If_LeB))*_Hit;
                half3 CombinColor = lerp(CombinC,CombinC+(mc*2.0)-1.0,saturate(SAG.b - _LerpS)) ;
                half2 RimLight = half2((saturate((0.5*(1.0+LightFallOff)))*clamp((1.0 - abs(dot(normalDirection,viewDirection))),0.02,0.98)),0.25);
                half3 Fresnel = pow((1.0-max(0,dot(i.normalDir, viewDirection))),_FresnelPower)*_FresnelColor.rgb*2.0;
                half3 finalColor = Fresnel  + (lerp((CombinColor),(_LightColor0.rgb*CombinColor),saturate(((attenuation*2.0)-1.0)))+(Diff.rgb*0.5*tex2D(_RimLightSampler,TRANSFORM_TEX(RimLight, _RimLightSampler)).r));
/// Final Color:
                return fixed4(finalColor,saturate(SAG.g-_Alphabias));
            }
            ENDCG
        }
              
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
