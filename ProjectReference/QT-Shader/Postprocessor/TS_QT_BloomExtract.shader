Shader "TS_QT/postprocessor/BloomExtract" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BloomThreshold("Bloom Threshold", Range(0,1)) = 0
		_BloomMin("Bloom Min", float) = 0
		_BloomMax("Bloom Max", float) = 0
	}
	SubShader {
		ZTest Off
		ZWrite Off
		Tags { "RenderType"="Opaque" }
		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			sampler2D _MainTex;
			//float4 _MainTex_ST;
			float _BloomThreshold;
			fixed _BloomMin;
			fixed _BloomMax;

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			fixed4 ExtractColor(fixed4 c)
			{
			/*	fixed lum = Luminance(c);
				fixed diff = lum - _BloomMin;
				//sign(saturate(diff))表示如果灰度值大于_BloomMin则为1
				//((-diff) / 0.05) * saturate((diff) + 0.05) * sign(saturate(-diff))是一个渐淡过度
				//((-diff) / 0.05) 是假设，_BloomMin与lum的差距在0.05以内，则求出线性变淡系数.（除以0.05被优化为*20）
				//saturate((diff) + 0.05)  表示如果lum<_BloomMin，并且差距在0.05以内为1，超出0.05则为0
				//sign(saturate(-diff))表示_BloomMin > lum
				fixed k1 = sign(saturate(diff)) + ((-diff) * 10) * sign(saturate((diff) + 0.1)) * sign(saturate(-diff));
				fixed k2 = sign(saturate(_BloomMax - lum));
				c.rgb = c.rgb * k1 * k2;
				//c.rgb = lum;
				//c.rgb = sign(saturate(-diff));
				return c;*/


				fixed lum = Luminance(c);
				fixed k = 1/(_BloomMax - _BloomMin);
				fixed b = -k * _BloomMin;
				return c * saturate(k * lum + b);
			}
			
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.texcoord;//TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			
			half4 frag(v2f i) : COLOR
			{
			
				half4 c = tex2D(_MainTex, i.uv);
				c = ExtractColor(c);
				//half intensity = saturate((Luminance(c) - _BloomThreshold) / (1 - _BloomThreshold));
				
				//half4 gray = half4(Luminance(c));
				//c = lerp(c, gray, _GrayIntensity);
				//c.rgb = intensity * c.rgb;
				return c;
			}
			
			ENDCG
		}
	} 
	FallBack Off
}
