Shader "Tomcat/Scene/BumpedDiffuse" {
	Properties{
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
		_BumpMap("Normalmap", 2D) = "bump" {}
		_BumpFactor("Normal Factor", Range(-25,25)) = 1 
	}
	SubShader{
		Tags { "RenderType" = "Opaque"}
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert fullforwardshadows exclude_path:deferred exclude_path:prepass
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
			//o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex)) * _BumpFactor;

            fixed3 bump = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            bump.xy *= _BumpFactor;
            bump.z = sqrt(1.0 - saturate(dot(bump.xy, bump.xy)));
            o.Normal = bump;
		}

		ENDCG
	}
	FallBack "Legacy Shaders/Diffuse"
}