//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Particles/RectWarn" {
	Properties {
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_Width ("Width", float) = 1
		_Length ("Length", float) = 1
		_LightRate("Light Rate", float) = 4
	}

	Category {
		Tags { "Queue"="Transparent+50" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask RGB
		Cull Off Lighting Off ZWrite Off

		SubShader {
			Pass {
		
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
		//		#pragma multi_compile_particles
			
				#include "Assets/Resources/QTShader/QTCGShader.cginc"

				sampler2D _MainTex;
				fixed4 _TintColor;
				float _Angle;
			
				struct appdata_t {
					fixed4 vertex : POSITION;
					fixed2 texcoord : TEXCOORD0;
					fixed4 color : COLOR;
				};

				struct v2f {
					fixed4 vertex : POSITION;
					fixed2 texcoord : TEXCOORD0;
					fixed4 verColor : TEXCOORD1;
				};
			
				float4 _MainTex_ST;
				fixed _Width;
				fixed _Length;
				fixed _LightRate;

				v2f vert (appdata_t v)
				{
					v2f o;
					
					fixed deltaLength = _Length - 1;
					fixed deltaWidth = _Width - 1;

					v.vertex.z += deltaLength * v.color.r;
					v.vertex.x += deltaWidth * 0.5 * sign(v.vertex.x);
					
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
					o.verColor = v.color;
					return o;
				}
			
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 c = tex2D(_MainTex, i.texcoord);
					clip(c.a - 0.001);
					fixed currTime = fmod(_Time.y, 6.28);
					c.a *= (sin(_LightRate * currTime) + 1) / 4 + 0.5;
					c = 2.0f * _TintColor * c;

					FinalColor(c);
					return c;
				}
				ENDCG 
			}
		}	
	}
}
