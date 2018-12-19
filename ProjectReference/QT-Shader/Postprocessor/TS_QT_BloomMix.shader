Shader "TS_QT/postprocessor/BloomMix" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_FuzzyTex ("Fuzzy Map", 2D) = "black" {}
		_MixForce("Mix Force", Range(0,2)) = 0.8
		_SourceForce("Source Force", Range(0,1)) = 1
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
			sampler2D _FuzzyTex;
			float4 _MainTex_ST;
			half _FuzzyForce;
			half _SourceForce;
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			
			half4 frag(v2f i) : COLOR
			{
				half4 c = tex2D(_MainTex, i.uv) * _SourceForce;
				half4 f = tex2D(_FuzzyTex, i.uv) * _FuzzyForce;
				
				return half4(c.rgb + f.rgb, 1);
			}
			
			ENDCG
		}
	} 
	FallBack Off
}
