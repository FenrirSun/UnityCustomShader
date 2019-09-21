Shader "Tomcat/Character/Skin_Lightmap_Fresnel" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Bump map", 2D) = "bump" {}
		_LightFalloffTex("LightFalloff Map", 2D) = "white" {}

		_LightAttenFalloff("LightAttenFalloff", Range(0, 1)) = 0.5
		_LightAttenBase("LightAttenBase", Range(0, 1)) = 0.5

		_FresnelColor("Fresnel Color", Color) = (1,1,1,1)
		_Fresnel_intensity("Fresnel_intensity", Range(0, 1)) = 0.3
		_Fresnel_EXP("Fresnel_EXP", Range(0, 5)) = 1.5
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow nolightmap nofog
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _LightFalloffTex;
		fixed _LightAttenFalloff;
		fixed _LightAttenBase;

		float _Fresnel_intensity;
		float _Fresnel_EXP;
		float4 _FresnelColor;

		#define FALLOFF_POWER 1.0

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};

		fixed4 _Color;

		void surf(Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			o.Alpha = c.a;

			float4 _Fresnel_var = _FresnelColor;
			float3 emissive = (_Fresnel_var.rgb*pow(1.0 - max(0, dot(o.Normal, IN.viewDir)), _Fresnel_EXP)*_Fresnel_intensity);
			o.Emission = saturate(emissive);
		}

		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			NdotL = clamp((NdotL + 1) / 2, 0.02, 0.98);
			fixed nh = max(0, dot(s.Normal, halfDir));
			//fixed diff = max(0, dot(s.Normal, lightDir));

			float4 falloffSamplerColor = FALLOFF_POWER * tex2D(_LightFalloffTex, float2(NdotL, 0.25f));
			float3 combinedColor = lerp(s.Albedo.rgb, falloffSamplerColor.rgb * s.Albedo.rgb, falloffSamplerColor.a);

			fixed4 c;
			atten = atten * _LightAttenFalloff + _LightAttenBase;
			c.rgb = combinedColor * nh * atten;
			//c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
			UNITY_OPAQUE_ALPHA(c.a);
			return c;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
