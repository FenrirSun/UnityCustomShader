// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/WarterMaskTest" {
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Fill("Fill", Range(0, 1)) = 0.5
		_A("振幅(最大和最小的幅度)", Range(0, 0.1)) = 0.01
		_W("角速度(圈数)", Range(0, 50)) = 10
		_Speed("移动速度", Range(0, 30)) = 10
	}

	Category
	{
		Lighting Off
		ZWrite Off
		Cull back
		Fog { Mode Off }
		Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" }

		Blend SrcAlpha OneMinusSrcAlpha
		
			SubShader
			{

				Pass
				{
					CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					#include "UnityCG.cginc"  

					sampler2D _MainTex;
					fixed4 _Color;
					float _Fill;

					float _A;
					float _W;
					float _Speed;

					struct appdata
					{
						float4 vertex : POSITION;
						float4 texcoord : TEXCOORD0;
					};

					struct v2f
					{
						float4 pos : SV_POSITION;
						float4 uv : TEXCOORD0;
					};

					v2f vert(appdata v)
					{
						v2f o;
						o.pos = UnityObjectToClipPos(v.vertex);
						o.uv = v.texcoord;
						return o;
					}

					half4 frag(v2f i) : COLOR
					{
						if (_Fill == 0)
							discard;

						if (_Fill < 1)
						{
							float2 uv1 = i.uv;
							uv1.y = (_A * sin(_W * uv1.x + _Speed * _Time.y));

							if (i.uv.y >= uv1.y + _Fill)
							{
								discard;
							}
						}

						fixed4 c = _Color * tex2D(_MainTex, i.uv);
						//fixed ca = tex2D(_MaskTex, i.uv).a;
						//c.a *= ca >= _Progress ? 0 : 1;

						return c;
					}
					ENDCG
				}
			}

			SubShader
			{
				AlphaTest LEqual[_Progress]
				Pass
				{
					SetTexture[_MaskTex]{ combine texture }
					SetTexture[_MainTex]{ combine texture, previous }
				}
			}

	}
	Fallback "Transparent/VertexLit"
}