// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Fairy Tails/Player_Face_NoLight" {
    Properties {
        _Hit ("Hit", Float ) = 1
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _Wid ("Wid", Float ) = 1
        _Hei ("Hei", Float ) = 1
        _Tile ("Tile", Float ) = 0
		_Alpha ("Alpha", 2D) = "white" {}
		_Alphabias ("Alphabias", Range(0, 1)) = 0
        //_FallOffstep ("FallOffstep", Float ) = 2
        //_FallOffColor ("FallOffColor", Color) = (1,1,1,1)
       // _FallOffPower ("FallOffPower", Range(1, 2)) = 1
       // _RimLightSampler ("RimLightSampler", 2D) = "black" {}
		[HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque" 
            "Queue" = "Transparent"
            "RenderType"="Geometry"
			}
		 LOD 100  

            Blend SrcAlpha OneMinusSrcAlpha
            Cull back
			ZTest LEqual
            
            Fog {Mode Off}

			Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            //uniform fixed4 _LightColor0;
            uniform fixed4 _MainColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Wid;
            uniform float _Hei;
            uniform float _Tile;
           // uniform fixed _FallOffstep;
            uniform fixed _Hit;
            //uniform sampler2D _RimLightSampler; uniform float4 _RimLightSampler_ST;
           // uniform fixed _FallOffPower;
            //uniform fixed4 _FallOffColor;
			uniform fixed _Alphabias;
            uniform sampler2D _Alpha; uniform float4 _Alpha_ST;
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
               // LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                //TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                half3x3 tangentTransform = half3x3( i.tangentDir, i.binormalDir, i.normalDir);
                half3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                half3 normalDirection =  i.normalDir; // Perturbed normals
                //half3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
               // half3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
               // half attenuation = LIGHT_ATTENUATION(i);
                half4 MainTex = tex2D(_MainTex,TRANSFORM_TEX(i.uv0.rg, _MainTex));
                float2 UV_tc_rcp = float2(1.0,1.0)/float2( _Wid, _Hei );
                float UV_ty = floor(_Tile * UV_tc_rcp.x);
                float UV_tx = _Tile - _Wid * UV_ty;
                float2 UVt = (i.uv0 + float2(UV_tx, UV_ty)) * UV_tc_rcp;
                float4 Diff = tex2D(_MainTex,TRANSFORM_TEX(UVt, _MainTex));
                float4 Alpha = tex2D(_Alpha,TRANSFORM_TEX(UVt, _Alpha));
				clip(saturate(Alpha.r) - 0.5-_Alphabias);
                //half LightFallOff = max(0,dot(normalDirection,lightDirection));
               // half StepFallOff = floor(LightFallOff * _FallOffstep) / (_FallOffstep - 1);
                //half If_LeA = step(StepFallOff,0.5);
               // half If_LeB = step(0.5,StepFallOff);
               // half3 If_Output = saturate(saturate((StepFallOff+0.5))*_FallOffPower*_FallOffColor.rgb);
                half3 CombinColor = Diff.rgb*_MainColor.rgb*_Hit;
                //half2 RimLight = half2((saturate((0.5*(1.0+LightFallOff)))*clamp((1.0 - abs(dot(normalDirection,viewDirection))),0.02,0.98)),0.25);
                half3 finalColor = CombinColor;
/// Final Color:
                fixed4 col = fixed4(finalColor,saturate((Alpha.r-_Alphabias)));
                return col;
            }
            ENDCG
        }
               
    }
    FallBack "Diffuse"
   
}
