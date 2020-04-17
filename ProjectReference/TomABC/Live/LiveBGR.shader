Shader "Tomcat/Live/LiveRGB"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
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

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _ViewPort;

			v2f vert (appdata v)
			{
				v2f o;
#ifndef RENDER_CAMERA
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
#else
				float4 rect;
				o.vertex.xy = _ViewPort.zw * (v.uv * 2 - 1.0f) + _ViewPort.xy;
				o.vertex.wz = 1.0f;
				
				if (_ProjectionParams.x >= 0)
				{
				   //o.uv.y = 1 - v.uv.y;
					_MainTex_ST.y = _MainTex_ST.y * -1.0f;
					_MainTex_ST.w = 1.0f - _MainTex_ST.w;
				}
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

#endif
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				col.rgb = GammaToLinearSpace(col.bgr);
				return col;
			}
			ENDCG
		}
	}
}
