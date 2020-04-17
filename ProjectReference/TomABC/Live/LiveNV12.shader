Shader "Tomcat/Live/LiveNV12"
{
	Properties
	{
		_TexY ("_TexY", 2D) = "black" {}
		_TexU("_TexU", 2D) = "black" {}
		_ViewPort("_ViewPort", Vector) = (0,0,1,1)
	}
	SubShader
	{
		Tags{ 
			"Queue" = "Background" 
			"RenderType" = "Background"
			"IgnoreProjector" = "True" 
		}

		Cull Off
		ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile __ RENDER_CAMERA

			#include "UnityCG.cginc"

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

			sampler2D _TexY;
			sampler2D _TexU;
			float4 _TexY_ST;
			float4 _ViewPort;
			
			v2f vert (appdata v)
			{
				v2f o;

#ifndef RENDER_CAMERA
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _TexY);

#else
				float4 rect;
				o.vertex.xy = _ViewPort.zw * (v.uv * 2 - 1.0f) + _ViewPort.xy;
				o.vertex.z = 1.0f;
				o.vertex.w = 1.0f;
				
				if (_ProjectionParams.x >= 0)
				{
				   //o.uv.y = 1 - v.uv.y;
					_TexY_ST.y = _TexY_ST.y * -1.0f;
					_TexY_ST.w = 1.0f - _TexY_ST.w;
				}
				o.uv = TRANSFORM_TEX(v.uv, _TexY);

#endif
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed y = tex2D(_TexY, i.uv).r;
				fixed2 uv = tex2D(_TexU, i.uv).rg;
				fixed u = uv.x;
				fixed v = uv.y;
				fixed y1 = 1.15625 * y;

				fixed4 res = fixed4(
					y1 + 1.59375 * v - 0.87254,
					y1 - 0.390625 * u - 0.8125 * v + 0.53137,
					y1 + 1.984375 * u - 1.06862,
					1.0f
				);

				res.rgb = GammaToLinearSpace(res.rgb);
				return res;
			}
			ENDCG
		}
	}
}
