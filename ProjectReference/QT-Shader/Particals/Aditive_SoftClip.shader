//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "Hidden/TS_QT/Particles/Additive SoftClip" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
	_TestValue("test value",float) = 0
}

Category {
	Tags { "Queue"="Transparent+50" "IgnoreProjector"="True" "RenderType"="Transparent" }
	//Tags{ "RenderType" = "Opaque" }
	Blend SrcAlpha One
	//Blend SrcAlpha OneMinusSrcAlpha
	ColorMask RGB
	Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }
	
	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma multi_compile_particles

			#include "Assets/Resources/QTShader/QTCGShader.cginc"

			sampler2D _MainTex;
			fixed4 _TintColor;
			//float4x4 QT_World2UIRootMatrix;
			//float4x4 QT_World2UIPanelMatrix;
			//float4x4 QT_NGUIMatrix;
			//float4x4 QT_ParticalRootMatrix;
			float _TestValue;

			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f {
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
				float2 worldPos : TEXCOORD1;
			};
			
			fixed4 _MainTex_ST;

			float4 _ClipRange0 = float4(0.0, 0.0, 1.0, 1.0);
			float2 _ClipArgs0 = float2(1000.0, 1000.0);

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);

				//float3 tempV3 = mul(unity_ObjectToWorld, v.vertex);
				//o.worldPos = mul(QT_World2UIPanelMatrix, tempV3);

				//o.worldPos = mul(QT_NGUIMatrix, v.vertex);

				o.worldPos = mul(unity_ObjectToWorld, v.vertex);

				o.worldPos = (o.worldPos.xy)* _ClipRange0.zw +_ClipRange0.xy;
				//o.worldPos += 1
				/*o.worldPos += 100;
				o.worldPos /= 200;*/
				return o;
			}

			sampler2D _CameraDepthTexture;
			fixed _InvFade;
			
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 color = 2.0f * _TintColor * i.color * tex2D(_MainTex, i.texcoord);
				// Softness factor
			float2 factor = (float2(1.0, 1.0) - abs(i.worldPos)) * _ClipArgs0;

				color.a *= clamp(min(factor.x, factor.y), 0.0, 1.0);
				FinalColor(color);
				
				/*color.a = 1;
				color.rgb = i.worldPos.y;*/
				return color;
			}
			ENDCG 
		}
	}	
}
}
