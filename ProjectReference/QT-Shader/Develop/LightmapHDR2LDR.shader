Shader "TS_QT/Develop/LightmapHDR2LDR"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "Assets/Resources/QTShader/QTUnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			half3 MyDecodeLightmapRGBM(half4 data, half4 decodeInstructions)
			{
				// If Linear mode is not supported we can skip exponent part
#if defined(UNITY_COLORSPACE_GAMMA)
# if defined(UNITY_FORCE_LINEAR_READ_FOR_RGBM)
				return (decodeInstructions.x * data.a) * sqrt(data.rgb);
# else
				return (decodeInstructions.x * data.a) * data.rgb;
# endif
#else
				return (decodeInstructions.x * pow(data.a, decodeInstructions.y)) * data.rgb;
#endif
			}

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

			float4 frag (v2f i) : SV_Target
			{
				float4 c = tex2D(_MainTex, i.uv);

				c.rgb = MyDecodeLightmapRGBM(c, unity_Lightmap_HDR);

				float4 nc = c;
				float maxValue = max(c.r, c.g);
				maxValue = max(maxValue, c.b);
				if (maxValue <= 1)
				{
					nc.a = 0.1375f;
				}
				else
				{
					nc.a = log2((maxValue * 0.1f + 1));// Mathf.Log((max * 0.1f + 1), 2);
					nc.r = c.r / maxValue;
					nc.g = c.g / maxValue;
					nc.b = c.b / maxValue;
				}
				 
				//float4 c = tex2D(_MainTex, i.uv);
				//float4 nc;
				//nc.rgb = MyDecodeLightmapRGBM(c, unity_Lightmap_HDR);
				//nc.a = 1;

				return nc;
			}

			
			ENDCG
		}
	}
}
