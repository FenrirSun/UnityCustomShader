Shader "Tomcat/Scene/Transparent_BumpedDiffuse" {
	Properties{
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
		_BumpMap("Normalmap", 2D) = "bump" {}
		_BumpFactor("Normal Factor", Range(-20,20)) = 1 
	}
	SubShader{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		LOD 300
		ZWrite On
		
		CGPROGRAM
		#pragma surface surf Lambert exclude_path:deferred exclude_path:prepass alpha:fade
		#pragma target 3.0

		fixed4 _ColorTint;
		fixed _BumpFactor;
		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _ColorTint;
			o.Albedo = tex.rgb;
			o.Alpha = tex.a;

            fixed3 bump = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            bump.xy *= _BumpFactor;
            bump.z = sqrt(1.0 - saturate(dot(bump.xy, bump.xy)));
            o.Normal = bump;
		}

		ENDCG
	}
	FallBack "Legacy Shaders/Transparent/Diffuse"
}