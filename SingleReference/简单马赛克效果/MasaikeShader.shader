// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MaSaiKe"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_TillSize("Till Size",Range(0.001,0.05)) = 0.005
	}
		SubShader
		{
			Pass{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				struct a2v {
					float4 vertex:POSITION;
					float2 texcoord:TEXCOORD0;
				};
				struct v2f {
					float4 pos:POSITION;
					float2 uv:TEXCOORD0;
				};

				sampler2D _MainTex;
				float _TillSize;

				v2f vert(a2v v) {
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.uv = v.texcoord;
					return o;
				}

				fixed4 frag(v2f i) :SV_Target{
					i.uv.x = floor(i.uv.x / _TillSize) * _TillSize;
					i.uv.y = floor(i.uv.y / _TillSize) * _TillSize;

					fixed4 col = tex2D(_MainTex,i.uv);
					return col;
				}

				ENDCG
			}
		}
}