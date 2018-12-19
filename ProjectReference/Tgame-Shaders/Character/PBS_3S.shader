///Upadte 11.18,Remove Occ & Emission,MainTex insteand of  EmissionMap
///Update 17.3.13:Unity 5.4 specular support
///Update 17.4: add colorMask mode ;add new 3S mode from Sigraph 2011,remove _NORMALMAP_OFF &&  _RIM_OFF
///Update 17.11:Unity 2017 && AddForward
///Update 18.3: 4th Color mask
Shader "TSHD/PBS_3S" {
	Properties {
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo", 2D) = "white" {}
		_TargetLightValue("Target Light Value",Range(0.0,1.0)) =0.5
		_SHAddLerp("SH Add Dir light value",Range(0.0,1.0)) =0.0
		_SHScale("SH Scale Value",Range(0.0,1.0))=1.0

		_Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5

		_Glossiness("Smoothness", Range(0.0, 1.0)) = 1.0
		_SpecColor("SpecularColor", Color) = (0.2,0.2,0.2)
		_SpecGlossMap("Specular", 2D) = "white" {}
        _GlossMapScale("Smoothness Factor", Range(0.0, 1.0)) = 0.5
        [Enum(Specular Alpha,0,Albedo Alpha,1)] _SmoothnessTextureChannel ("Smoothness texture channel", Float) = 0
        _BRDFTex ("SSS Map(RGB),", 2D) = "white" {}
		_CurvatureTex ("Curvature Map(R),Thickness(G),SSS Mask(B)", 2D) = "black" {}

		_BumpScale("Scale", Float) = 1.0
		_BumpMap("Normal Map(RGB),Curvature Map(A)", 2D) = "bump" {}

		_BumpinessDR ("Bumpiness R", Range(0,1)) = 0.1
		_BumpinessDG ("Bumpiness G", Range(0,1)) = 0.6
		_BumpinessDB ("Bumpiness B", Range(0,1)) = 0.7

		_ScatteringOffset ("Scattering Offset", Range(-1,1)) = 0.0
		_ScatteringPower ("Scattering Scale", Range(0,2)) = 1.0  

		_LookupTranslucency ("Lookup Translucency", 2D) = "gray" {}
		_TranslucencyPower ("Translucency Scale", Range(0,3)) = 1
		_TranslucencyRadius ("Translucency Radius", Range(0,2)) = 0.5

  //      _OcclusionStrength("Strength", Range(0.0, 1.0)) = 1.0
		//_OcclusionMap("Occlusion", 2D) = "white" {}
		
		_EmissionColor("EmissionColor", Color) = (0,0,0)
        _EmissionMap("Emission", 2D) = "white" {}

		//Color Mask
		_ColorMaskMap("Color Mask Layers(RGB)", 2D) = "Black" {}
		_ColorLayer1("ColorLayer1(R)", Color) = (0,0,0)
		_ColorLayer2("ColorLayer2(G)", Color) = (0,0,0)
		_ColorLayer3("ColorLayer3(B)", Color) = (0,0,0)
		_ColorLayer4("ColorLayer4(A)", Color) = (0,0,0)

		//RIM LIGHT
		_RimColor ("Rim Color", Color) = (0.8,0.8,0.8,0.6)
		_RimPower ("Rim Power", Range(0,5)) = 3.0
		_RimLevel ("Rim Level",Range(0,3)) = 0.5
        _RimDir("Rim Direction(W>0 Direction Rim,or esle Full Rim)",Vector) =(1,1,0,1)
        //_Thickness = Thickness texture (invert normals, bake AO).


		// Blending state
		[HideInInspector] _Mode ("__mode", Float) = 0.0
		[HideInInspector] _SrcBlend ("__src", Float) = 1.0
		[HideInInspector] _DstBlend ("__dst", Float) = 0.0
		[HideInInspector] _ZWrite ("__zw", Float) = 1.0

		_SpecularMapColorTweak("Specular Color Tweak", Color) = (1,1,1,1)
	}
	
	SubShader {
		Tags { "RenderType"="Opaque" "IgnoreProjector"="true" }
		//Special Queue for nor Grab by Command Buffer
		//Tags { "RenderType"="TransparentCutout" "IgnoreProjector"="true" "Queue"="Transparent-400" }
		LOD 250
		
		Blend [_SrcBlend] [_DstBlend]
		ZWrite [_ZWrite]
		CGPROGRAM

		#pragma surface SurfSpecular StandardSpecularSSS  interpolateview vertex:StandardSurfaceVertex finalcolor:StandardSurfaceSpecularFinal nolightmap  exclude_path:deferred exclude_path:prepass //noforwardadd fullforwardshadows addshadow keepalpha nometa
		#pragma target 3.0

		// Standard shader feature variants
        //#pragma shader_feature _NORMALMAP
        //#pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
        #pragma multi_compile __ _ALPHATEST_ON 
		//Normal map Default
        #pragma multi_compile  _NORMALMAP _NORMALMAP_OFF
        #pragma multi_compile _SPECGLOSSMAP_OFF _SPECGLOSSMAP
        #pragma multi_compile _EMISSION_OFF _EMISSION
        //#pragma multi_compile _RIM_OFF _RIM 
        #pragma multi_compile _SSS_OFF _SSS
		 #pragma multi_compile _COLORMASK_OFF _COLORMASK
        //The most importan vartiants for other lighting : SHADOWS_SCREEN 
        #pragma skip_variants   SHADOWS_SOFT DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE FOG_EXP FOG_EXP2 
		//#pragma skip_variants   FOG_EXP FOG_EXP2 
		#pragma multi_compile_fog

		uniform half3 	_SpecularMapColorTweak;
        uniform sampler2D _BRDFTex,_ColorMaskMap,_CurvatureTex,_LookupTranslucency;

		uniform half _RimPower,_SubPower,_ScatteringOffset,_ScatteringPower,_SHAddLerp,_TargetLightValue,_SHScale;
		uniform fixed4 _RimColor,_ColorLayer1,_ColorLayer2,_ColorLayer3,_ColorLayer4;
		uniform fixed _RimLevel,_TranslucencyRadius,_TranslucencyPower;
        uniform  float4  _RimDir;

		half _SHAddGlobeFactor;

		uniform float _BumpinessDR;
		uniform float _BumpinessDG;
		uniform float _BumpinessDB;
        #include "UnityStandardInput.cginc"

        struct SurfaceOutputSkinShader
	    {
		    half3	Albedo;		// diffuse color
		    half3	Specular;	// specular color
		    half3	Normal;		// tangent space normal, if written
			half3 OriNormal;
		    half3	Emission;
		    half	Smoothness;	// 0=rough, 1=smooth
            half	Occlusion;	// occlusion (default 1)
		    half	Alpha;		// alpha for transparencies
		    half	Curvature; //
			half SSSMask; 
			half3 Translucency;
	    };

		//-----------------------------------------------------------------------------------------------------
			//	half4 BRDF2_Unity_PBS (half3 diffColor, half3 specColor, half oneMinusReflectivity, half smoothness,
			//half3 normal, half3 viewDir,
			//UnityLight light, UnityIndirect gi)
			half4 BRDF2_Unity_PBS_3S(half3 diffColor, half3 specColor, half oneMinusReflectivity, half smoothness, half curvature, 
		half sssMask,half3 translucency, half3 normal, half3 oriNormal,half3 viewDir,
		UnityLight light, UnityIndirect gi)
		{
			half3 halfDir = Unity_SafeNormalize (light.dir + viewDir);

			half nl = saturate(dot(normal, light.dir));
			half nh = saturate(dot(normal, halfDir));
			half nv = saturate(dot(normal, viewDir));
			half lh = saturate(dot(light.dir, halfDir));

			// Specular term
			half perceptualRoughness = SmoothnessToPerceptualRoughness (smoothness);
			half roughness = PerceptualRoughnessToRoughness(perceptualRoughness);

		#if UNITY_BRDF_GGX

			// GGX Distribution multiplied by combined approximation of Visibility and Fresnel
			// See "Optimizing PBR for Mobile" from Siggraph 2015 moving mobile graphics course
			// https://community.arm.com/events/1155
			half a = roughness;
			half a2 = a*a;

			half d = nh * nh * (a2 - 1.h) + 1.00001h;
		#ifdef UNITY_COLORSPACE_GAMMA
			// Tighter approximation for Gamma only rendering mode!
			// DVF = sqrt(DVF);
			// DVF = (a * sqrt(.25)) / (max(sqrt(0.1), lh)*sqrt(roughness + .5) * d);
			half specularTerm = a / (max(0.32h, lh) * (1.5h + roughness) * d);
		#else
			half specularTerm = a2 / (max(0.1h, lh*lh) * (roughness + 0.5h) * (d * d) * 4);
		#endif

			// on mobiles (where half actually means something) denominator have risk of overflow
			// clamp below was added specifically to "fix" that, but dx compiler (we convert bytecode to metal/gles)
			// sees that specularTerm have only non-negative terms, so it skips max(0,..) in clamp (leaving only min(100,...))
		#if defined (SHADER_API_MOBILE)
			specularTerm = specularTerm - 1e-4h;
		#endif

		#else

			// Legacy
			half specularPower = PerceptualRoughnessToSpecPower(perceptualRoughness);
			// Modified with approximate Visibility function that takes roughness into account
			// Original ((n+1)*N.H^n) / (8*Pi * L.H^3) didn't take into account roughness
			// and produced extremely bright specular at grazing angles

			half invV = lh * lh * smoothness + perceptualRoughness * perceptualRoughness; // approx ModifiedKelemenVisibilityTerm(lh, perceptualRoughness);
			half invF = lh;

			half specularTerm = ((specularPower + 1) * pow (nh, specularPower)) / (8 * invV * invF + 1e-4h);

		#ifdef UNITY_COLORSPACE_GAMMA
			specularTerm = sqrt(max(1e-4h, specularTerm));
		#endif

		#endif

		#if defined (SHADER_API_MOBILE)
			specularTerm = clamp(specularTerm, 0.0, 100.0); // Prevent FP16 overflow on mobiles
		#endif
		#if defined(_SPECULARHIGHLIGHTS_OFF)
			specularTerm = 0.0;
		#endif

			// surfaceReduction = Int D(NdotH) * NdotH * Id(NdotL>0) dH = 1/(realRoughness^2+1)

			// 1-0.28*x^3 as approximation for (1/(x^4+1))^(1/2.2) on the domain [0;1]
			// 1-x^3*(0.6-0.08*x)   approximation for 1/(x^4+1)
		#ifdef UNITY_COLORSPACE_GAMMA
			half surfaceReduction = 0.28;
		#else
			half surfaceReduction = (0.6-0.08*perceptualRoughness);
		#endif

			surfaceReduction = 1.0 - roughness*perceptualRoughness*surfaceReduction;

			half grazingTerm = saturate(smoothness + (1-oneMinusReflectivity));

		#ifdef _SSS
				half3 NormalRed =lerp(oriNormal, normal, _BumpinessDR);
				half3 NormalGreen = lerp(oriNormal, normal, _BumpinessDG);
				half3 NormalBlue = lerp(oriNormal, normal, _BumpinessDB);

				half3 diffNdotL   =0.5 + 0.5 * half3(dot(NormalRed, light.dir),dot(NormalGreen,  light.dir),dot(NormalBlue,  light.dir));
				half finalCurvature =saturate((curvature+  _ScatteringOffset)* _ScatteringPower);

				half3 diff =half3(
					tex2D(_BRDFTex, half2(diffNdotL.r, finalCurvature)).r,
					tex2D(_BRDFTex, half2(diffNdotL.g, finalCurvature)).g,
					tex2D(_BRDFTex, half2(diffNdotL.b, finalCurvature)).b
				);		

			half3 translucencyPart = translucency* saturate((1-nl)*dot(normal, (viewDir-light.dir) * _TranslucencyRadius ));

			half3 color = lerp(diffColor   * nl,  diffColor *(diff+translucencyPart) ,sssMask) * light.color    + specularTerm * specColor * light.color * nl
    			+ gi.diffuse * diffColor
				+ surfaceReduction * gi.specular * FresnelLerpFast (specColor, grazingTerm, nv);
		#else

			half3 color =   (diffColor + specularTerm * specColor) * light.color * nl
							+ gi.diffuse * diffColor
							+ surfaceReduction * gi.specular * FresnelLerpFast (specColor, grazingTerm, nv);
		#endif

			return half4(color, 1);
		}

//----------------------------------------------------------------------------------------


        half4 LightingStandardSpecularSSS(SurfaceOutputSkinShader s,half3 viewDir, UnityGI gi)
        {
            s.Normal = normalize(s.Normal);
	        // energy conservation 
	        half oneMinusReflectivity;
	        s.Albedo = EnergyConservationBetweenDiffuseAndSpecular (s.Albedo, s.Specular, /*out*/ oneMinusReflectivity);
	        // shader relies on pre-multiply alpha-blend (_SrcBlend = One, _DstBlend = OneMinusSrcAlpha)
	        // this is necessary to handle transparency in physically correct way - only diffuse component gets affected by alpha
	        half outputAlpha;
	        s.Albedo = PreMultiplyAlpha (s.Albedo, s.Alpha, oneMinusReflectivity, /*out*/ outputAlpha);
	        //half4 c = UNITY_BRDF_PBS (s.Albedo, s.Specular, oneMinusReflectivity, s.Smoothness, s.Normal, viewDir, gi.light, gi.indirect);
			half4 c = BRDF2_Unity_PBS_3S (s.Albedo, s.Specular, oneMinusReflectivity, s.Smoothness, s.Curvature,
							s.SSSMask, s.Translucency,s.Normal, s.OriNormal,viewDir, gi.light, gi.indirect);
	        c.rgb += UNITY_BRDF_GI (s.Albedo, s.Specular, oneMinusReflectivity, s.Smoothness, s.Normal, viewDir, s.Occlusion, gi);
	        c.a = outputAlpha;
			
	        return c;
        }


		half3 ShadeSHPerPixelLerp (half3 normal, half3 ambient, float3 worldPos)
		{
			half3 ambient_contrib = 0.0;
			half3 orAmb =ambient;
				//half3 orAmb =UNITY_LIGHTMODEL_AMBIENT;
			#if UNITY_SAMPLE_FULL_SH_PER_PIXEL
				// Completely per-pixel
				ambient_contrib = ShadeSH9 (half4(normal, 1.0));
				ambient += max(half3(0, 0, 0), ambient_contrib);
			#elif (SHADER_TARGET < 30) || UNITY_STANDARD_SIMPLE
				// Completely per-vertex
				// nothing to do here
			#else
				// L2 per-vertex, L0..L1 & gamma-correction per-pixel
				// Ambient in this case is expected to be always Linear, see ShadeSHPerVertex()
				#if UNITY_LIGHT_PROBE_PROXY_VOLUME
					if (unity_ProbeVolumeParams.x == 1.0)
						ambient_contrib = SHEvalLinearL0L1_SampleProbeVolume (half4(normal, 1.0), worldPos);
					else
						ambient_contrib = SHEvalLinearL0L1 (half4(normal, 1.0));
				#else
					ambient_contrib = SHEvalLinearL0L1 (half4(normal, 1.0));
				#endif

				ambient = max(half3(0, 0, 0), ambient+ambient_contrib);     // include L2 contribution in vertex shader before clamp.
				#ifdef UNITY_COLORSPACE_GAMMA
					ambient = LinearToGammaSpace (ambient);
				#endif
			#endif
			ambient =lerp(orAmb,ambient,_SHScale);
			return ambient;
		}

		inline UnityGI UnityGI_BaseSH(UnityGIInput data, half occlusion, half3 normalWorld)
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
			o_gi.light.color *= data.atten;

			#if UNITY_SHOULD_SAMPLE_SH
				o_gi.indirect.diffuse = ShadeSHPerPixelLerp (normalWorld, data.ambient, data.worldPos);
			#endif

			#if defined(LIGHTMAP_ON)
				// Baked lightmaps
				half4 bakedColorTex = UNITY_SAMPLE_TEX2D(unity_Lightmap, data.lightmapUV.xy);
				half3 bakedColor = DecodeLightmap(bakedColorTex);

				#ifdef DIRLIGHTMAP_COMBINED
					fixed4 bakedDirTex = UNITY_SAMPLE_TEX2D_SAMPLER (unity_LightmapInd, unity_Lightmap, data.lightmapUV.xy);
					o_gi.indirect.diffuse = DecodeDirectionalLightmap (bakedColor, bakedDirTex, normalWorld);

					#if defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN)
						ResetUnityLight(o_gi.light);
						o_gi.indirect.diffuse = SubtractMainLightWithRealtimeAttenuationFromLightmap (o_gi.indirect.diffuse, data.atten, bakedColorTex, normalWorld);
					#endif

				#else // not directional lightmap
					o_gi.indirect.diffuse = bakedColor;

					#if defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN)
						ResetUnityLight(o_gi.light);
						o_gi.indirect.diffuse = SubtractMainLightWithRealtimeAttenuationFromLightmap(o_gi.indirect.diffuse, data.atten, bakedColorTex, normalWorld);
					#endif

				#endif
			#endif

			#ifdef DYNAMICLIGHTMAP_ON
				// Dynamic lightmaps
				fixed4 realtimeColorTex = UNITY_SAMPLE_TEX2D(unity_DynamicLightmap, data.lightmapUV.zw);
				half3 realtimeColor = DecodeRealtimeLightmap (realtimeColorTex);

				#ifdef DIRLIGHTMAP_COMBINED
					half4 realtimeDirTex = UNITY_SAMPLE_TEX2D_SAMPLER(unity_DynamicDirectionality, unity_DynamicLightmap, data.lightmapUV.zw);
					o_gi.indirect.diffuse += DecodeDirectionalLightmap (realtimeColor, realtimeDirTex, normalWorld);
				#else
					o_gi.indirect.diffuse += realtimeColor;
				#endif
			#endif

			o_gi.indirect.diffuse *= occlusion;
			return o_gi;
		}


		inline UnityGI UnityGlobalIlluminationDefault (UnityGIInput data, half occlusion, half3 normalWorld)
		{
			return UnityGI_BaseSH(data, occlusion, normalWorld);
		}

		inline UnityGI UnityGlobalIlluminationRef (UnityGIInput data, half occlusion, half3 normalWorld, Unity_GlossyEnvironmentData glossIn)
		{
			UnityGI o_gi = UnityGI_BaseSH(data, occlusion, normalWorld);
			o_gi.indirect.specular = UnityGI_IndirectSpecular(data, occlusion, glossIn);
			return o_gi;
		}
        
        void LightingStandardSpecularSSS_GI (
	        SurfaceOutputSkinShader s,
	        UnityGIInput data,
	        inout UnityGI gi)
        {
		//Maybe cause flash
		//#if UNITY_SHOULD_SAMPLE_SH
		//	half3 tempgilight =data.light.color +(_TargetLightValue -_LightColor0.a);
		//	data.light.color =lerp(data.light.color ,tempgilight,saturate(_SHAddLerp- _SHAddGlobeFactor));
		//#endif

		#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
			gi = UnityGlobalIlluminationDefault(data, s.Occlusion, s.Normal);
		#else
			Unity_GlossyEnvironmentData g = UnityGlossyEnvironmentSetup(s.Smoothness, data.worldViewDir, s.Normal, s.Specular);
			gi = UnityGlobalIlluminationRef(data, s.Occlusion, s.Normal, g);
		#endif

		//#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
		//	gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
		//#else
		//	Unity_GlossyEnvironmentData g = UnityGlossyEnvironmentSetup(s.Smoothness, data.worldViewDir, s.Normal, s.Specular);
		//	gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal, g);
		//#endif
        }

///
	    struct Input
	    {
		    float4	texcoord;
	    //#ifdef _PARALLAXMAP
		    half3	viewDir;
            half NDL;
            half3 worldNor;
			half3 oriNor;
	        //#endif
        #if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
	        float fogCoord;
        #endif
	    };

		void SurfSpecular(Input IN, inout SurfaceOutputSkinShader o)
		{
           //#ifdef _PARALLAXMAP
           //     IN.texcoord = Parallax(IN.texcoord, IN.viewDir);
           // #endif

            #if defined(_ALPHATEST_ON)
                o.Alpha = Alpha(IN.texcoord.xy);
                clip(o.Alpha - _Cutoff);
            #endif
            //o.Albedo = Albedo(IN.texcoord.xyzw);	
			half4 MainTex =tex2D (_MainTex,IN.texcoord.xy);     
            half3 albedo =  MainTex.rgb;
            o.Albedo = albedo *_Color.rgb;	

			#ifdef _SSS
				half4 curvatureMap = tex2D ( _CurvatureTex, IN.texcoord.xy );
				o.Curvature =curvatureMap.r ;

				half depth = curvatureMap.g;
				half translucencyStrength = depth* _TranslucencyPower;
				depth =saturate(1-depth);
				float d = depth * depth/ _TranslucencyRadius;
				half3 translucencyProfile = tex2D(_LookupTranslucency, half2(d, 0)).rgb;
				o.Translucency = translucencyStrength * translucencyProfile;

				o.SSSMask=curvatureMap.b;
				//o.OriNormal =normalize(IN.oriNor);
				o.OriNormal =IN.oriNor;
				//o.Albedo =o.Curvature;
			#endif

            #ifdef _NORMALMAP
	           	//o.Normal = NormalInTangentSpace(IN.texcoord.xyzw);
				o.Normal = UnpackScaleNormal(tex2D (_BumpMap, IN.texcoord.xy), _BumpScale);
            #endif

	            half4 specGloss = SpecularGloss(IN.texcoord.xy);
	            o.Specular = specGloss.rgb;
			#ifdef _SPECGLOSSMAP
				o.Specular *= _SpecularMapColorTweak;
            #endif
	            o.Smoothness = specGloss.a;
                //o.Occlusion = Occlusion(IN.texcoord.xy);

			#ifdef _COLORMASK
				half4 colorMaskTex =tex2D(_ColorMaskMap,IN.texcoord.xy);
				o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer1.rgb,colorMaskTex.r);
				o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer2.rgb,colorMaskTex.g);
				o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer3.rgb,colorMaskTex.b);
				o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer4.rgb,colorMaskTex.a);
			#endif    

			#ifdef _EMISSION
				// o.Emission = Emission(IN.texcoord.xy);
				half3 orEmi =tex2D(_EmissionMap, IN.texcoord.xy).rgb;
				#ifdef _COLORMASK
					orEmi =lerp(orEmi, orEmi*_ColorLayer1.rgb,colorMaskTex.r);
					orEmi =lerp(orEmi, orEmi*_ColorLayer2.rgb,colorMaskTex.g);
					orEmi =lerp(orEmi, orEmi*_ColorLayer3.rgb,colorMaskTex.b);
				#endif
				o.Emission =orEmi * _EmissionColor.rgb;
			#else
				//o.Emission =_EmissionColor.rgb;
				o.Emission = o.Albedo*_EmissionColor.rgb;
			#endif   


            //#ifdef _RIM
            //half rim = 1.0f -saturate(dot(normalize(IN.viewDir),o.Normal));
            half rim = 1.0f -saturate(dot(IN.viewDir,o.Normal));
			half rimMask =_RimDir.w>0 ? saturate(dot(IN.worldNor, _RimDir.xyz)) : 1;    
            o.Emission += (_RimColor.rgb *pow(rim,_RimPower)) *_RimLevel*rimMask;
            //#endif
		}

        void StandardSurfaceVertex (inout appdata_full v, out Input o)
        {
	        UNITY_INITIALIZE_OUTPUT(Input, o);
            //o.worldNor = normalize(UnityObjectToWorldNormal(v.normal));
			o.worldNor = UnityObjectToWorldNormal(v.normal);
	        fixed3 lightDir = _WorldSpaceLightPos0.xyz;
	        o.NDL =dot(o.worldNor , lightDir)*0.5 +0.5;
	        o.NDL  = max(0,o.NDL);
		#ifdef _SSS
			o.oriNor = o.worldNor ;
		#endif
        #if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
	        float4 hpos = UnityObjectToClipPos(v.vertex);
	        UNITY_CALC_FOG_FACTOR(hpos.z);
	        o.fogCoord = unityFogFactor;
        #endif
	        // Setup UVs to the format expected by Standard input functions.
	        o.texcoord.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
	        //o.texcoord.zw = TRANSFORM_TEX(((_UVSec == 0) ? v.texcoord : v.texcoord1), _DetailAlbedoMap);
        }

        inline void StandardSurfaceSpecularFinal (Input IN, SurfaceOutputSkinShader o, inout half4 color)
        {	
        #if defined(_ALPHABLEND_ON) || defined(_ALPHAPREMULTIPLY_ON)
	        color.a = o.Alpha;
        #else
	        UNITY_OPAQUE_ALPHA(color.a);
        #endif
        #if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
        color.rgb = lerp(unity_FogColor.rgb,color.rgb,saturate(IN.fogCoord));
        #endif
        }

		ENDCG
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
	
	CGPROGRAM
	//#pragma surface surf MobileBlinnPhong exclude_path:prepass nolightmap noforwardadd halfasview interpolateview
	#pragma surface surf Lambert exclude_path:prepass nolightmap noforwardadd halfasview interpolateview noshadow 
	#pragma multi_compile _COLORMASK_OFF _COLORMASK

	struct Input {
		float2 uv_MainTex;
	};
	sampler2D _MainTex,_ColorMaskMap;
	float4 _EmissionColor;
	fixed4 _ColorLayer1,_ColorLayer2,_ColorLayer3,_ColorLayer4;

	void surf (Input IN, inout SurfaceOutput o) {
		fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		o.Albedo = tex.rgb;
		#ifdef _COLORMASK
			half4 colorMaskTex =tex2D(_ColorMaskMap,IN.uv_MainTex);
			o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer1.rgb,colorMaskTex.r);
			o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer2.rgb,colorMaskTex.g);
			o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer3.rgb,colorMaskTex.b);
			o.Albedo =lerp(o.Albedo, o.Albedo*_ColorLayer4.rgb,colorMaskTex.a);
		#endif    
		o.Emission =o.Albedo*_EmissionColor.rgb;
		o.Alpha = tex.a;
	}
	ENDCG
	}

    CustomEditor "PBS3SGUI"
    FallBack "Mobile/VertexLit"

}
