Shader "Tomcat/Character/Skin_Lightmap_2" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Bump map", 2D) = "bump" {}
		_LightFalloffTex("LightFalloff Map", 2D) = "white" {}

		_LightAtten("LightAtten", Range(0, 1)) = 0.5
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf CustomHalfLambertB noforwardadd exclude_path:deferred exclude_path:prepass addshadow nolightmap
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _LightFalloffTex;
		fixed _LightAtten;

		#define FALLOFF_POWER 1.0

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf(Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			o.Alpha = c.a;
		}

		inline fixed4 LightingCustomHalfLambertB(SurfaceOutput s, half3 viewDir, UnityGI gi)
		{
			half NdotL = dot(s.Normal, gi.light.dir);
	        fixed diff = max (0, dot (s.Normal, gi.light.dir));
		    fixed4 c;
			float4 falloffSamplerColor = FALLOFF_POWER * tex2D(_LightFalloffTex, float2(NdotL, 0.25f));
			float3 combinedColor = lerp(s.Albedo.rgb, falloffSamplerColor.rgb * s.Albedo.rgb, falloffSamplerColor.a);

		    //c.rgb = combinedColor * diff * gi.light.color;
			c.rgb = combinedColor * diff * gi.light.color.r * _LightAtten;

		    #ifdef UNITY_LIGHT_FUNCTION_APPLY_INDIRECT
		        c.rgb += s.Albedo * gi.indirect.diffuse;
		    #endif

		    c.a = s.Alpha;

			return c;
		}

		inline UnityGI UnityGI_Custom(UnityGIInput data, half occlusion, half3 normalWorld)
		{
		    UnityGI o_gi;
		    ResetUnityGI(o_gi);

		    // Base pass with Lightmap support is responsible for handling ShadowMask / blending here for performance reason
		    #if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
		        half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
		        float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
		        float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
		        data.atten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
		    #endif

		    o_gi.light = data.light;
		    //o_gi.light.color *= data.atten;
		    o_gi.light.color.r = data.atten;

		    #if UNITY_SHOULD_SAMPLE_SH
		        o_gi.indirect.diffuse = ShadeSHPerPixel(normalWorld, data.ambient, data.worldPos);
		    #endif

		    o_gi.indirect.diffuse *= occlusion;
		    return o_gi;
		}

		inline void LightingCustomHalfLambertB_GI (
		    SurfaceOutput s,
		    UnityGIInput data,
		    inout UnityGI gi)
		{
		    //gi = UnityGlobalIllumination (data, 1.0, s.Normal);
		    gi = UnityGI_Custom(data, 1.0, s.Normal);
		}


		ENDCG
	}

	FallBack "Diffuse"
}
