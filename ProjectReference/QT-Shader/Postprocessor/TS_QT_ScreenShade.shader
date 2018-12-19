
Shader "TS_QT/postprocessor/ScreenShade" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_ShadeTex ("Shade", 2D) = "white"{}
		_ShadeInt ("Shade Intensity", float) = 1
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
			sampler2D _ShadeTex;
			float4 _MainTex_ST;
			fixed _ShadeInt;
			
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
				half4 shade = tex2D(_ShadeTex, i.uv);
				c.rgb = lerp(c.rgb, shade.rgb, shade.a * _ShadeInt);
				c.a = 1;
				return c;
			}
			 
			ENDCG
		}
	} 
	FallBack Off
}
