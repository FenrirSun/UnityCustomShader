Shader "Tomcat/Scene/BumpedSpecular_Occlusion" {
	Properties{
		_ColorTint("Color Tint", Color) = (1,1,1,1)
		_Brightness("Brightness", Range(0, 2)) = 1.4
		_MainTex("Base (RGB) + AO(A)", 2D) = "white" {}
		
		_BumpMap("Normalmap", 2D) = "bump" {}
		_BumpFactor("Normal Factor", Range(-25,25)) = 1 
		
		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		[PowerSlider(5.0)] _Shininess ("Shininess", Range (0.03, 1)) = 0.078125

		_Occlusion("Occlusion Factor", Range(0, 2)) = 1
	}
	SubShader{
		Tags { "RenderType" = "Opaque"}
		LOD 200

		CGPROGRAM
		#pragma surface surf CustomSceneProGI fullforwardshadows addshadow exclude_path:deferred exclude_path:prepass
		#pragma target 3.0

		fixed4 _ColorTint;
		fixed _BumpFactor;
		half _Shininess;
		fixed _Occlusion;
		fixed _Brightness;
		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		struct CustomSurfaceOutput
		{
		    fixed3 Albedo;
		    fixed3 Normal;
		    fixed3 Emission;
		    half Specular;
		    fixed Gloss;
		    fixed Alpha;
		    half Occlusion;     // occlusion (default 1)
		};

        inline half4 LightingCustomSceneProGI(CustomSurfaceOutput s, half3 viewDir, UnityGI gi)
        {
		    fixed4 c;
	        half3 h = normalize (gi.light.dir + viewDir);

		    fixed diff = max (0, dot (s.Normal, gi.light.dir));

		    float nh = max (0, dot (s.Normal, h));
		    float spec = pow (nh, s.Specular * 128.0) * s.Gloss;

		    c.rgb = s.Albedo * gi.light.color * diff + gi.light.color * _SpecColor.rgb * spec;
		    c.a = s.Alpha;

		    #ifdef UNITY_LIGHT_FUNCTION_APPLY_INDIRECT
		        c.rgb += s.Albedo * gi.indirect.diffuse * _Brightness;
		    #endif

		    return c;
        }

        inline void LightingCustomSceneProGI_GI(
            CustomSurfaceOutput s,
            UnityGIInput data,
            inout UnityGI gi)
        {
        	gi = UnityGlobalIllumination (data, s.Occlusion, s.Normal);
        }

		void surf(Input IN, inout CustomSurfaceOutput o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		    o.Albedo = tex.rgb * _ColorTint.rgb;
		    o.Gloss = tex.a;
		    o.Alpha = tex.a * _ColorTint.a;
		    o.Specular = _Shininess;
            fixed3 bump = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            bump.xy *= _BumpFactor;
            bump.z = sqrt(1.0 - saturate(dot(bump.xy, bump.xy)));
            o.Normal = bump;
		    o.Occlusion = tex2D(_MainTex, IN.uv_MainTex).a;
            half o_min = 1 - _Occlusion;
            o.Occlusion = o_min + o.Occlusion * (1 - o_min);
		}

		ENDCG
	}
	FallBack "Legacy Shaders/Diffuse"
}