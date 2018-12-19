Shader "TS_QT/postprocessor/BloomFuzzyX" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BloomMin("Bloom Min", float) = 0
		_BloomMax("Bloom Max", float) = 0
	//	_BloomTex ("Bloom Map", 2D) = "black" {}
	}
	SubShader {
		ZTest Off
		ZWrite Off
		Tags { "RenderType"="Opaque" }
		Pass
		{
			CGPROGRAM
			//#define LumVec half4(0.22, 0.707, 0.071,0)

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile QT_BLOOM_HIGH QT_BLOOM_LOW 
			#pragma target 3.0
			#include "UnityCG.cginc"
			
			/*#ifdef Bloom_3
			#define r0 0.4
			#define r1 0.24
			#define r2 0.054
			#endif
			
			#ifdef Bloom_4
			#define r0 0.266
			#define r1 0.213
			#define r2 0.109
			#define r3 0.036
			#endif
			
			#ifdef Bloom_5
			#define r0 0.2
			#define r1 0.176
			#define r2 0.121
			#define r3 0.065
			#define r4 0.027
			#endif
			*/

			/*#define r0 0.114
			#define r1 0.1094
			#define r2 0.0968
			#define r3 0.07894
			#define r4 0.05932
			#define r5 0.04108
			#define r6 0.02622
			#define r7 0.01542
			#define r8 0.00836*/

			/*#define r0 0.3
			#define r1 0.27
			#define r2 0.24
			#define r3 0.21
			#define r4 0.18
			#define r5 0.15
			#define r6 0.12
			#define r7 0.09
			#define r8 0.06*/

		/*	#define r0 0.114
			#define r1 0.1094
			#define r2 0.0968
			#define r3 0.07894
			#define r4 0.05932
			#define r5 0.04108
			#define r6 0.02622
			#define r7 0.01542
			#define r8 0.00836*/
#ifdef QT_BLOOM_HIGH
			#define r0 0.114
			#define r1 0.1094
			#define r2 0.0968
			#define r3 0.07894
			#define r4 0.05932
			#define r5 0.04108
			#define r6 0.02622
			#define r7 0.01542
			#define r8 0.00836
#endif
#ifdef QT_BLOOM_LOW
			#define r0 0.2
			#define r1 0.176
			#define r2 0.121
			#define r3 0.065
			#define r4 0.027
#endif 
			
			
			sampler2D _MainTex;
		//	sampler2D _BloomTex;
		//	float4 _MainTex_ST;
			fixed _BloomMin;
			fixed _BloomMax;
			
		//	const half3 Gauss = half3(0.4,0.24,0.054);
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.texcoord;//TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			half4 frag(v2f i) : COLOR
			{
				float bx = (_ScreenParams.z - 1)*2;
			//	float by = _ScreenParams.z - 1;
				
				half4 c = half4(0,0,0,1);

				half4 tempC = tex2D(_MainTex, i.uv) * r0;
				c += tempC;
				
				tempC = tex2D(_MainTex, i.uv + float2(-bx, 0)) * r1;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-2 * bx, 0)) * r2;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-3 * bx, 0)) * r3;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-4 * bx, 0)) * r4;
				c += tempC;
				#ifdef QT_BLOOM_HIGH
				tempC = tex2D(_MainTex, i.uv + float2(-5 * bx, 0)) * r5;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-6 * bx, 0)) * r6;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-7 * bx, 0)) * r7;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-8 * bx, 0)) * r8;
				c += tempC;
				#endif
				tempC = tex2D(_MainTex, i.uv + float2(bx, 0)) * r1;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(2 * bx, 0)) * r2;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(3 * bx, 0)) * r3;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(4 * bx, 0)) * r4;
				c += tempC;
				#ifdef QT_BLOOM_HIGH
				tempC = tex2D(_MainTex, i.uv + float2(5 * bx, 0)) * r5;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(6 * bx, 0)) * r6;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(7 * bx, 0)) * r7;
				c += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(8 * bx, 0)) * r8;
				c += tempC;
				#endif
				c.a = 1;
			//	c.rgb = 0;
				return c;
			}
			
			ENDCG
		}
	} 
	FallBack Off
}
