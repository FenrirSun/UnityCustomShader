Shader "Tomcat/Live/LiveYUV420"
{
	Properties
	{
		_TexY ("_TexY", 2D) = "black" {}
		_TexU("_TexU", 2D) = "black" {}
		_TexV("_TexV", 2D) = "black" {}
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
			sampler2D _TexV;
			float4 _TexY_ST;
			float4 _ViewPort;
			
			v2f vert (appdata v)
			{
				v2f o;

#ifndef RENDER_CAMERA
				o.vertex = UnityObjectToClipPos(v.vertex);
#else
				float4 rect;
				o.vertex.xy = _ViewPort.zw * (v.uv * 2 - 1.0f) + _ViewPort.xy;
				o.vertex.z = 1.0f;
				o.vertex.w = 1.0f;
#endif

				o.uv = TRANSFORM_TEX(v.uv, _TexY);

				if (_ProjectionParams.x > 0)
				{
					o.uv.y = 1 - v.uv.y;
				}

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col;
				// sample the texture
				float colY = tex2D(_TexY, i.uv).a;
				float colU = tex2D(_TexU, i.uv).a - 0.5;
				float colV = tex2D(_TexV, i.uv).a - 0.5;

				//col.r = colY + 1.14 * colV;
				//col.g = colY - 0.394 * colU - 0.581 * colV ;
				//col.b = colY + 2.03 * colU ;
				
				col.r = colY + 1.403 * colV;
				col.g = colY - 0.344 * colU - 0.714 * colV;
				col.b = colY + 1.77 * colU;

				col.a = 1.0;
				return col;
			}
			ENDCG
		}
	}
}
