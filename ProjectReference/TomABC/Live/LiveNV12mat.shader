Shader "Tomcat/Live/LiveNV12mat"
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

				float3x3 convermat = float3x3(
					1.0f,    1.0f,    1.0f,
					0.0f,    -0.343f, 1.765f,
					1.4f,    -0.711f, 0.0f
				);
			float3 yuv;
			yuv.x = tex2D(_TexY, i.uv).r;
			yuv.yz = tex2D(_TexU, i.uv).rg - float2(0.5f, 0.5f);
			float3 rgb = mul(convermat, yuv);
			rgb = GammaToLinearSpace(rgb);

			return fixed4(rgb,1.0f);
			}
			ENDCG
		}
	}
}
