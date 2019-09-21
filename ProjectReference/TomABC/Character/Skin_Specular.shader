Shader "Tomcat/Character/Skin_Specular" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Bump map", 2D) = "bump" {}

		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		[PowerSlider(5.0)] _Shininess ("Shininess", Range (0.03, 1)) = 0.078125
		_Gloss ("Gloss", Range (0.01, 1)) = 1

		_LightAttenFalloff("LightAttenFalloff", Range(0, 1)) = 0.5
		_LightAttenBase("LightAttenBase", Range(0, 1)) = 0.5

		//[Toggle(Legacy)] Legacy ("Legacy", Int) = 1
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow
		#pragma target 3.0
		//#pragma shader_feature Legacy

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed4 _Color;
		//fixed4 _SpecColor;
		fixed _Gloss;
		half _Shininess;
		fixed _LightAttenFalloff;
		fixed _LightAttenBase;

		#define FALLOFF_POWER 1.0

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o) {
		    fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		    o.Albedo = tex.rgb * _Color.rgb;
		    o.Gloss = _Gloss;
		    //o.Alpha = //tex.a * _Color.a;
		    o.Specular = _Shininess;
		    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		}

		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 viewDir, fixed atten)
		{
			// #ifdef Legacy

			// 	fixed nh = max(0, dot(s.Normal, viewDir));
			// 	fixed4 c;
			// 	atten = atten * _LightAttenFalloff + _LightAttenBase;
			// 	c.rgb = s.Albedo.rgb * nh * atten;
			// 	UNITY_OPAQUE_ALPHA(c.a);
			// 	return c;

			// #else

				// float desaturate = saturate((dot(s.Albedo.rgb,float3(0.3,0.59,0.11))*4.0+-2.0));
				// float3 desaturateColor = float3(desaturate,desaturate,desaturate);

	    		fixed4 c = 0;
	    		fixed nh = max(0, dot(s.Normal, viewDir));
	    		float spec = pow (nh, s.Specular * 128.0) * s.Gloss;// * desaturate;
				atten = atten * _LightAttenFalloff + _LightAttenBase;
				c.rgb = s.Albedo.rgb * nh * atten;
				c.rgb += _SpecColor.rgb * spec;
				UNITY_OPAQUE_ALPHA(c.a);
				return c;

			//#endif
		}

		ENDCG
	}
	FallBack "Diffuse"
}
