//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Particles/Smoke" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_SmokeMap1 ("Smoke Texture 1", 2D) = "white" {}
	SmokeDir1 ("Smoke 1 Dir", Vector) = (0,0,0,0)
	SmokeWeight1("Smoke 1 Weight",float) = 0.5
	_SmokeMap2 ("Smoke Texture 2", 2D) = "white" {}
	SmokeDir2 ("Smoke 2 Dir", Vector) = (0,0,0,0)
	SmokeWeight2("Smoke 2 Weight",float) = 0.5
	//_Noise ("Noise Texture", 2D) = "white" {}
	//NoiseSpeed("Noise Speed",Vector) = (0,0,0,0)
	//OffsetRate("Offset Rate",float) = 0.1
}

Category {
	Tags { "Queue"="Transparent+50" "IgnoreProjector"="True" "RenderType"="Transparent" }
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
	//		#pragma multi_compile_particles
			
			#include "Assets/Resources/QTShader/QTCGShader.cginc"
			sampler2D _SmokeMap1;
			sampler2D _SmokeMap2;

			//sampler2D _Noise;
			//fixed2 NoiseSpeed;

			fixed4 _TintColor;

			//fixed OffsetRate;

			fixed2 SmokeDir1;
			fixed2 SmokeDir2;

			fixed SmokeWeight1;
			fixed SmokeWeight2;
			
			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f {
				fixed4 vertex : POSITION;
				fixed2 texcoord1 : TEXCOORD0;
				fixed2 texcoord2 : TEXCOORD1;
			//	fixed2 texcoord3 : TEXCOORD2;
				fixed4 color : COLOR;
			};
			
			float4 _SmokeMap1_ST;
			float4 _SmokeMap2_ST;
			//float4 _Noise_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
				
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord1 = TRANSFORM_TEX(v.texcoord,_SmokeMap1);
				o.texcoord2 = TRANSFORM_TEX(v.texcoord,_SmokeMap2);
			//	o.texcoord3 = TRANSFORM_TEX(v.texcoord,_Noise);
				o.color = v.color;
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				//fixed4 noiseColor = tex2D(_Noise, i.texcoord3 + NoiseSpeed * _Time.y);
				//OffsetRate = NoiseSpeed * _Time.y;
				//i.texcoord1 += noiseColor.rg * OffsetRate;
				//i.texcoord2 += noiseColor.rg * OffsetRate;
				fixed4 c1 = tex2D(_SmokeMap1, i.texcoord1);
				fixed4 c2 = tex2D(_SmokeMap2, i.texcoord2);
				fixed4 c = c1 * SmokeWeight1 + c2 * SmokeWeight2;

				c = 2.0f *_TintColor * i.color * c;

				//c = 2.0f * _TintColor * i.color * c;

				//c = c1 * SmokeWeight1 + c2 * SmokeWeight2;

				FinalColor(c);
				return c;
			}
			ENDCG 
		}
	}	
}
}
