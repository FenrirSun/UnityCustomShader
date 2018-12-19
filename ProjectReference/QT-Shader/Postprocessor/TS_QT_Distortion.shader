Shader "TS_QT/postprocessor/Distortion" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
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
			sampler2D _DistortionNoise;
			float4 _MainTex_ST;
			float4 _DistortionNoise_ST;
			float _DistortionIntensity;
			float _speedX;
			float _speedY;
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv1 : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
			};
			
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv1 = TRANSFORM_TEX(v.texcoord, _MainTex);
				v.texcoord.xy += _Time.y * fixed2(_speedX,_speedY);
				//_speedY = 1;
				//v.texcoord.x += _Time.y * _speedX;
				//v.texcoord.y += _Time.y * _speedY;
				o.uv2 = TRANSFORM_TEX(v.texcoord, _DistortionNoise);
				return o;
			}
			
			half4 frag(v2f i) : COLOR
			{
				half4 noiseColor = tex2D(_DistortionNoise, i.uv2);
				i.uv1 += (noiseColor.rg - 0.5) * 2 * 0.05 * _DistortionIntensity;
				half4 c = tex2D(_MainTex, i.uv1);
				return c;
			}
			 
			ENDCG
		}
	} 
	FallBack Off
}
