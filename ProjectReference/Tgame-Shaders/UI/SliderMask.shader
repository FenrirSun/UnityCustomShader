// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/SliderMask"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_MinFill("MinFill", Range(0, 1)) = 0
		_MaxFill("MaxFill", Range(0, 1)) = 1
	}
	SubShader
	{
		Lighting Off
		ZWrite Off
		Cull back
		Fog{ Mode Off }
		Tags { "Queue"="Transparent" }
		LOD 100

		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				//UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			fixed _MinFill;
			fixed _MaxFill;
			//float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				if (i.uv.x < _MinFill)
					discard;

				if (i.uv.x > _MaxFill)
					discard;

				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
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

	Fallback "Transparent/VertexLit"
}
