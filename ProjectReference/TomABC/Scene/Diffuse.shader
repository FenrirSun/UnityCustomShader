Shader "Tomcat/Scene/Diffuse" {
	Properties{
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
	}
	SubShader{
		Tags { "RenderType" = "Opaque"}
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert fullforwardshadows exclude_path:deferred exclude_path:prepass
		#pragma target 3.0

		fixed4 _ColorTint;
		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _ColorTint;
			o.Albedo = tex.rgb;
			o.Alpha = tex.a;
		}

		ENDCG
	}
	FallBack "Legacy Shaders/Diffuse"
}