Shader "Tomcat/Scene/Transparent_Diffuse" {
	Properties{
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
	}
	SubShader{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 300
		ZWrite On
		
		CGPROGRAM
		#pragma surface surf Lambert exclude_path:deferred exclude_path:prepass alpha:fade
		#pragma target 3.0

		fixed4 _ColorTint;
		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _ColorTint;
			o.Albedo = tex.rgb;
			o.Alpha = tex.a;
		}

		ENDCG
	}
	FallBack "Legacy Shaders/Transparent/Diffuse"
}
