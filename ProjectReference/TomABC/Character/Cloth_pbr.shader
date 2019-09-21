Shader "Tomcat/Character/Cloth_pbr" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Bump map", 2D) = "white" {}
		_RoughMap("Roughness", 2D) = "white" {}
		//_OcclusionMap("Occlusion", 2D) = "white" {}
		//_Occlusion("Occlusion", Range(0,1)) = 0.5
		//_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard noforwardadd exclude_path:deferred exclude_path:prepass addshadow nolightmap nofog
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _RoughMap;
		//sampler2D _OcclusionMap;

		struct Input {
			float2 uv_MainTex;
		};

		//fixed _Occlusion;
		//half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			//o.Metallic = _Metallic;
			o.Smoothness = 1 - tex2D(_RoughMap, IN.uv_MainTex).r;
			//o.Occlusion = tex2D(_OcclusionMap, IN.uv_MainTex).r * _Occlusion;
			//o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
