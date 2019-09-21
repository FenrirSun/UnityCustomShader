Shader "Tomcat/Character/CustomDeffuse" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Diffuse (RGB)", 2D) = "white" {}
		_BumpMap("Bump map", 2D) = "white" {}

		_LightAttenFalloff("LightAttenFalloff", Range(0, 1)) = 0.5
		_LightAttenBase("LightAttenBase", Range(0, 1)) = 0.5

		//_Fresnel("Fresnel map", 2D) = "white" {}
		_FresnelColor("Fresnel Color", Color) = (1,1,1,1)
		_Fresnel_intensity("Fresnel_intensity", Range(0, 1)) = 0.3
		_Fresnel_EXP("Fresnel_EXP", Range(0, 5)) = 1.5
	}
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow nolightmap

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed4 _Color;
		fixed _LightAttenFalloff;
		fixed _LightAttenBase;
		//sampler2D _Fresnel;
		float _Fresnel_intensity;
		float _Fresnel_EXP;
		float4 _FresnelColor;

		struct Input {
			float2 uv_MainTex;
			//float2 uv_BumpMap;
			//float2 uv_Fresnel;

			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			half NdotV = max(0, dot(o.Normal, IN.viewDir));
			NdotV = clamp(NdotV, 0.02, 0.98);

			o.Albedo = c.rgb;
			o.Alpha = c.a;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));

			//float4 _Fresnel_var = tex2D(_Fresnel, IN.uv_Fresnel);
			float4 _Fresnel_var = _FresnelColor;
			float3 emissive = _Fresnel_var.rgb * pow(1.0 - NdotV, _Fresnel_EXP) *_Fresnel_intensity;
			o.Emission = saturate(emissive);
		}

		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
		{
			fixed nh = max(0, dot(s.Normal, halfDir));
			fixed4 c;
			atten = atten * _LightAttenFalloff + _LightAttenBase;
			c.rgb = s.Albedo;
			c.rgb = (s.Albedo * _LightColor0.rgb * nh) * atten;
			UNITY_OPAQUE_ALPHA(c.a);
			return c;
		}

		ENDCG
	}
	Fallback "Mobile/VertexLit"
}
