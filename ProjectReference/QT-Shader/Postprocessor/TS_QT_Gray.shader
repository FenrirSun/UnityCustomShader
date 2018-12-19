Shader "TS_QT/postprocessor/Gray" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_GrayIntensity("Gray Intensity", Range(0,1)) = 1
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
			float4 _MainTex_ST;
			float _GrayIntensity;
			
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
				half4 c = tex2D(_MainTex, i.uv);
				half gray = Luminance(c);
				c.rgb = lerp(c, gray, _GrayIntensity);
				c.a = 1;
				return c;
			}
			 
			ENDCG
		}
	} 
	FallBack Off
}
