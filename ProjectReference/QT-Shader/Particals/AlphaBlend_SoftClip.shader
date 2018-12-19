//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "Hidden/TS_QT/Particles/Alpha Blended SoftClip" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	ColorMask RGB
	Cull Off 
	Lighting Off 
	ZWrite Off

	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		//	#pragma multi_compile_particles
			
			#include "Assets/Resources/QTShader/QTCGShader.cginc"
			sampler2D _MainTex;
			fixed4 _TintColor;
			//float4x4 QT_NGUIMatrix;

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
			
			float4 _MainTex_ST;
			float4 _ClipRange0 = float4(0.0, 0.0, 1.0, 1.0);
			float2 _ClipArgs0 = float2(1000.0, 1000.0);

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				o.color = v.color;// fixed4(1,1,1,1);// v.color;
				//o.worldPos = mul(unity_ObjectToWorld, v.vertex);
				//o.worldPos = mul(QT_World2UIRootMatrix, o.worldPos);

				o.worldPos = mul(unity_ObjectToWorld, v.vertex);

				o.worldPos = (o.worldPos.xy)* _ClipRange0.zw + _ClipRange0.xy;
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				float2 factor = (float2(1.0, 1.0) - abs(i.worldPos)) * _ClipArgs0;
				fixed4 c = tex2D(_MainTex, i.texcoord);
				//clip(c.a - 0.001);
				c = 2.0f * _TintColor * i.color * c;
				//c.a *= _TintColor.a;
				c.a *= clamp(min(factor.x, factor.y), 0.0, 1.0);
				FinalColor(c);
				/*c.rgb = c.a;
				c.a = 1;*/
				//c.rgb = _ClipRange0.z * 50;
				return c;
			}
			ENDCG 
		}
	}	
}
}
