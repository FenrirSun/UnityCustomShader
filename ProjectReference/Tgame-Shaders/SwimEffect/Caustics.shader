// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "TSHD/Swim Effects/Caustics" {
    Properties {
        _Texture ("Texture", 2D) = "white" {}
		//_HorizontalAmount("Horizontal Amount", Float) = 1
		//_VerticalAmount("Vertical Amount", Float) = 6
		//_Speed("Speed", Range(1, 100)) = 6
        _Color ("Color", Color) = (0.5,0.5,0.5,1)
        _WaterLevel ("Water Level", Float ) = 22
        _DepthFade ("Depth Fade", Float ) = 10
        _Intensity ("Intensity", Range(0, 1)) = 0
        _DistanceVisibility ("Distance Visibility", Float ) = 0
        [HideInInspector]_Fade ("Fade", Float ) = 1
    }
    SubShader {
        Tags {
            //"IgnoreProjector"="True"
            "Queue"="Transparent"
            //"RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //#define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            //#pragma multi_compile_fwdbase
            //#pragma exclude_renderers d3d11_9x 
            //#pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _Color;
            uniform float _WaterLevel;
            uniform float _DepthFade;
            uniform float _Intensity;
            uniform float _DistanceVisibility;
            uniform float _Fade;
			//uniform float _HorizontalAmount;
			//uniform float _VerticalAmount;
			//uniform float _Speed;

            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
				o.uv0 = TRANSFORM_TEX(v.texcoord0, _Texture);
                //o.uv0 = v.texcoord0;
				//o.uv0 = TRANSFORM_TEX(v.texcoord0, _Texture);
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light

				/*float time = floor(_Time.y * _Speed);
				float row = floor(time / _HorizontalAmount);
				float column = time - row * _HorizontalAmount;

				i.uv0 = TRANSFORM_TEX(i.uv0, _Texture);
				half2 uv = i.uv0 + half2(column, -row);
				uv.x /= _HorizontalAmount;
				uv.y /= _VerticalAmount;*/

                float4 _Texture_var = tex2D(_Texture, i.uv0);
                float _inverse = (-1.0);
                float3 diffuseColor = lerp(float4((saturate((_Color.rgb*_Texture_var.rgb))*(1.0 - saturate((((_WaterLevel+_inverse)*_inverse)+i.posWorld.g)))*saturate((i.posWorld.g+(_inverse*_DepthFade)))*_Intensity*saturate(max(0,dot(lightDirection,i.normalDir)))),0.0),float4(0,0,0,1),saturate(pow((distance(i.posWorld.rgb,_WorldSpaceCameraPos)/_DistanceVisibility),_Fade))).rgb;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
