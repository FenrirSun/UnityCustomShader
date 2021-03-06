﻿// Upgrade NOTE: replaced 'defined FOG_COMBINED_WITH_WORLD_POS' with 'defined (FOG_COMBINED_WITH_WORLD_POS)'

Shader "Tomcat/Character/Skin_Specular2" {
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

		
	// ------------------------------------------------------------
	// Surface shader code generated out of a CGPROGRAM block:
	

	// ---- forward rendering base pass:
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }

CGPROGRAM
// compile directives
#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma target 3.0
#pragma multi_compile_instancing
#pragma multi_compile_fog
#pragma multi_compile_fwdbase
#include "HLSLSupport.cginc"
#define UNITY_INSTANCED_LOD_FADE
#define UNITY_INSTANCED_SH
#define UNITY_INSTANCED_LIGHTMAPSTS
#include "UnityShaderVariables.cginc"
#include "UnityShaderUtilities.cginc"
// -------- variant for: <when no other keywords are defined>
#if !defined(INSTANCING_ON)
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: no
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _MainTex
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 19 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
		//#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow
		//#pragma target 3.0
		////#pragma shader_feature Legacy

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

		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
		{
			// #ifdef Legacy

			// 	fixed nh = max(0, dot(s.Normal, halfDir));
			// 	fixed4 c;
			// 	atten = atten * _LightAttenFalloff + _LightAttenBase;
			// 	c.rgb = s.Albedo.rgb * nh * atten;
			// 	UNITY_OPAQUE_ALPHA(c.a);
			// 	return c;

			// #else

				//float desaturate = saturate((dot(s.Albedo.rgb,float3(0.3,0.59,0.11))*4.0+-2.0));
				//float3 desaturateColor = float3(desaturate,desaturate,desaturate);

	    		fixed4 c = 0;
				return c;
	    		// fixed nh = max(0, dot(s.Normal, halfDir));
	    		// float spec = pow (nh, s.Specular * 128.0) * s.Gloss;// * desaturate;
				// atten = atten * _LightAttenFalloff + _LightAttenBase;
				// c.rgb = s.Albedo.rgb * nh * atten;
				// c.rgb += _SpecColor.rgb * spec;
				// UNITY_OPAQUE_ALPHA(c.a);
				// return c;

			//#endif
		}

		

// vertex-to-fragment interpolation data
// no lightmaps:
#ifndef LIGHTMAP_ON
// half-precision fragment shader registers:
#ifdef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
#define FOG_COMBINED_WITH_TSPACE
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed3 vlight : TEXCOORD4; // ambient/SH/vertexlights
  UNITY_LIGHTING_COORDS(5,6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
// high-precision fragment shader registers:
#ifndef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed3 vlight : TEXCOORD4; // ambient/SH/vertexlights
  UNITY_FOG_COORDS(5)
  UNITY_SHADOW_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
#endif
// with lightmaps:
#ifdef LIGHTMAP_ON
// half-precision fragment shader registers:
#ifdef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
#define FOG_COMBINED_WITH_TSPACE
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
  UNITY_LIGHTING_COORDS(5,6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
// high-precision fragment shader registers:
#ifndef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
  UNITY_FOG_COORDS(5)
  UNITY_SHADOW_COORDS(6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
#endif
float4 _MainTex_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
//  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
//   UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
//   UNITY_TRANSFER_INSTANCE_ID(v,o);
//   UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  float3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
//   #ifdef DYNAMICLIGHTMAP_ON
//   o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
//   #endif
//   #ifdef LIGHTMAP_ON
//   o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
//   #endif

  // SH/ambient and vertex lights
  #ifndef LIGHTMAP_ON
  #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
  float3 shlight = ShadeSH9 (float4(worldNormal,1.0));
  o.vlight = shlight;
  #else
  o.vlight = 0.0;
  #endif
  #ifdef VERTEXLIGHT_ON
  o.vlight += Shade4PointLights (
    unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
    unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
    unity_4LightAtten0, worldPos, worldNormal );
  #endif // VERTEXLIGHT_ON
  #endif // !LIGHTMAP_ON

//  UNITY_TRANSFER_LIGHTING(o,v.texcoord1.xy); // pass shadow and, possibly, light cookie coordinates to pixel shader
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_TRANSFER_FOG_COMBINED_WITH_TSPACE(o,o.pos); // pass fog coordinates to pixel shader
//   #elif defined (FOG_COMBINED_WITH_WORLD_POS)
//     UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS(o,o.pos); // pass fog coordinates to pixel shader
//   #else
//     UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
//   #endif
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
//   #elif defined (FOG_COMBINED_WITH_WORLD_POS)
//     UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
//   #else
//     UNITY_EXTRACT_FOG(IN);
//   #endif
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_RECONSTRUCT_TBN(IN);
  #else
    UNITY_EXTRACT_TBN(IN);
  #endif
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.viewDir.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  float3 worldN;
  worldN.x = dot(_unity_tbn_0, o.Normal);
  worldN.y = dot(_unity_tbn_1, o.Normal);
  worldN.z = dot(_unity_tbn_2, o.Normal);
  worldN = normalize(worldN);
  o.Normal = worldN;
  #ifndef LIGHTMAP_ON
  //c.rgb += o.Albedo * IN.vlight;
  c.rgb += IN.vlight;
  #endif // !LIGHTMAP_ON

  // lightmaps
//   #ifdef LIGHTMAP_ON
//     #if DIRLIGHTMAP_COMBINED
//       // directional lightmaps
//       fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
//       fixed4 lmIndTex = UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd, unity_Lightmap, IN.lmap.xy);
//       half3 lm = DecodeDirectionalLightmap (DecodeLightmap(lmtex), lmIndTex, o.Normal);
//     #else
//       // single lightmap
//       fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
//       fixed3 lm = DecodeLightmap (lmtex);
//     #endif

//   #endif // LIGHTMAP_ON


//   // realtime lighting: call lighting function
//   #ifndef LIGHTMAP_ON
//   c += LightingCustomHalfLambert (o, lightDir, worldViewDir, atten);
//   #else
//     c.a = o.Alpha;
//   #endif

//   #ifdef LIGHTMAP_ON
//     // combine lightmaps with realtime shadows
//     #ifdef SHADOWS_SCREEN
//       #if defined(UNITY_NO_RGBM)
//       c.rgb += o.Albedo * min(lm, atten*2);
//       #else
//       c.rgb += o.Albedo * max(min(lm,(atten*2)*lmtex.rgb), lm*atten);
//       #endif
//     #else // SHADOWS_SCREEN
//       c.rgb += o.Albedo * lm;
//     #endif // SHADOWS_SCREEN
//   #endif // LIGHTMAP_ON

//   #ifdef DYNAMICLIGHTMAP_ON
//   fixed4 dynlmtex = UNITY_SAMPLE_TEX2D(unity_DynamicLightmap, IN.lmap.zw);
//   c.rgb += o.Albedo * DecodeRealtimeLightmap (dynlmtex);
//   #endif

  UNITY_APPLY_FOG(_unity_fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif

// -------- variant for: INSTANCING_ON 
#if defined(INSTANCING_ON)
// Surface shader code generated based on:
// writes to per-pixel normal: YES
// writes to emission: no
// writes to occlusion: no
// needs world space reflection vector: no
// needs world space normal vector: no
// needs screen space position: no
// needs world space position: no
// needs view direction: no
// needs world space view direction: no
// needs world space position for lighting: no
// needs world space view direction for lighting: YES
// needs world space view direction for lightmaps: no
// needs vertex color: no
// needs VFACE: no
// passes tangent-to-world matrix to pixel shader: YES
// reads from normal: no
// 1 texcoords actually used
//   float2 _MainTex
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// Original surface shader snippet:
#line 19 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */
		//#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow
		//#pragma target 3.0
		////#pragma shader_feature Legacy

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

		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
		{
			// #ifdef Legacy

			// 	fixed nh = max(0, dot(s.Normal, halfDir));
			// 	fixed4 c;
			// 	atten = atten * _LightAttenFalloff + _LightAttenBase;
			// 	c.rgb = s.Albedo.rgb * nh * atten;
			// 	UNITY_OPAQUE_ALPHA(c.a);
			// 	return c;

			// #else

				//float desaturate = saturate((dot(s.Albedo.rgb,float3(0.3,0.59,0.11))*4.0+-2.0));
				//float3 desaturateColor = float3(desaturate,desaturate,desaturate);

	    		fixed4 c = 0;
				return c;
	    		fixed nh = max(0, dot(s.Normal, halfDir));
	    		float spec = pow (nh, s.Specular * 128.0) * s.Gloss;// * desaturate;
				atten = atten * _LightAttenFalloff + _LightAttenBase;
				c.rgb = s.Albedo.rgb * nh * atten;
				c.rgb += _SpecColor.rgb * spec;
				UNITY_OPAQUE_ALPHA(c.a);
				return c;

			//#endif
		}

		

// vertex-to-fragment interpolation data
// no lightmaps:
#ifndef LIGHTMAP_ON
// half-precision fragment shader registers:
#ifdef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
#define FOG_COMBINED_WITH_TSPACE
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed3 vlight : TEXCOORD4; // ambient/SH/vertexlights
  UNITY_LIGHTING_COORDS(5,6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
// high-precision fragment shader registers:
#ifndef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  fixed3 vlight : TEXCOORD4; // ambient/SH/vertexlights
  UNITY_FOG_COORDS(5)
  UNITY_SHADOW_COORDS(6)
  #if SHADER_TARGET >= 30
  float4 lmap : TEXCOORD7;
  #endif
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
#endif
// with lightmaps:
#ifdef LIGHTMAP_ON
// half-precision fragment shader registers:
#ifdef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
#define FOG_COMBINED_WITH_TSPACE
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
  UNITY_LIGHTING_COORDS(5,6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
// high-precision fragment shader registers:
#ifndef UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS
struct v2f_surf {
  UNITY_POSITION(pos);
  float2 pack0 : TEXCOORD0; // _MainTex
  float4 tSpace0 : TEXCOORD1;
  float4 tSpace1 : TEXCOORD2;
  float4 tSpace2 : TEXCOORD3;
  float4 lmap : TEXCOORD4;
  UNITY_FOG_COORDS(5)
  UNITY_SHADOW_COORDS(6)
  UNITY_VERTEX_INPUT_INSTANCE_ID
  UNITY_VERTEX_OUTPUT_STEREO
};
#endif
#endif
float4 _MainTex_ST;

// vertex shader
v2f_surf vert_surf (appdata_full v) {
  UNITY_SETUP_INSTANCE_ID(v);
  v2f_surf o;
  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
  UNITY_TRANSFER_INSTANCE_ID(v,o);
  UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
  o.pos = UnityObjectToClipPos(v.vertex);
  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
  float3 worldNormal = UnityObjectToWorldNormal(v.normal);
  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
  #ifdef DYNAMICLIGHTMAP_ON
  o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
  #endif
  #ifdef LIGHTMAP_ON
  o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
  #endif

  // SH/ambient and vertex lights
  #ifndef LIGHTMAP_ON
  #if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
  float3 shlight = ShadeSH9 (float4(worldNormal,1.0));
  o.vlight = shlight;
  #else
  o.vlight = 0.0;
  #endif
  #ifdef VERTEXLIGHT_ON
  o.vlight += Shade4PointLights (
    unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
    unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
    unity_4LightAtten0, worldPos, worldNormal );
  #endif // VERTEXLIGHT_ON
  #endif // !LIGHTMAP_ON

  UNITY_TRANSFER_LIGHTING(o,v.texcoord1.xy); // pass shadow and, possibly, light cookie coordinates to pixel shader
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_TRANSFER_FOG_COMBINED_WITH_TSPACE(o,o.pos); // pass fog coordinates to pixel shader
  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
    UNITY_TRANSFER_FOG_COMBINED_WITH_WORLD_POS(o,o.pos); // pass fog coordinates to pixel shader
  #else
    UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
  #endif
  return o;
}

// fragment shader
fixed4 frag_surf (v2f_surf IN) : SV_Target {
  UNITY_SETUP_INSTANCE_ID(IN);
  // prepare and unpack data
  Input surfIN;
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
  #elif defined (FOG_COMBINED_WITH_WORLD_POS)
    UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
  #else
    UNITY_EXTRACT_FOG(IN);
  #endif
  #ifdef FOG_COMBINED_WITH_TSPACE
    UNITY_RECONSTRUCT_TBN(IN);
  #else
    UNITY_EXTRACT_TBN(IN);
  #endif
  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
  surfIN.uv_MainTex.x = 1.0;
  surfIN.uv_BumpMap.x = 1.0;
  surfIN.viewDir.x = 1.0;
  surfIN.uv_MainTex = IN.pack0.xy;
  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
  #ifndef USING_DIRECTIONAL_LIGHT
    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
  #else
    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
  #endif
  float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
  #ifdef UNITY_COMPILER_HLSL
  SurfaceOutput o = (SurfaceOutput)0;
  #else
  SurfaceOutput o;
  #endif
  o.Albedo = 0.0;
  o.Emission = 0.0;
  o.Specular = 0.0;
  o.Alpha = 0.0;
  o.Gloss = 0.0;
  fixed3 normalWorldVertex = fixed3(0,0,1);
  o.Normal = fixed3(0,0,1);

  // call surface function
  surf (surfIN, o);

  // compute lighting & shadowing factor
  UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
  fixed4 c = 0;
  float3 worldN;
  worldN.x = dot(_unity_tbn_0, o.Normal);
  worldN.y = dot(_unity_tbn_1, o.Normal);
  worldN.z = dot(_unity_tbn_2, o.Normal);
  worldN = normalize(worldN);
  o.Normal = worldN;
//   #ifndef LIGHTMAP_ON
//   c.rgb += o.Albedo * IN.vlight;
//   #endif // !LIGHTMAP_ON

//   // lightmaps
//   #ifdef LIGHTMAP_ON
//     #if DIRLIGHTMAP_COMBINED
//       // directional lightmaps
//       fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
//       fixed4 lmIndTex = UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd, unity_Lightmap, IN.lmap.xy);
//       half3 lm = DecodeDirectionalLightmap (DecodeLightmap(lmtex), lmIndTex, o.Normal);
//     #else
//       // single lightmap
//       fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
//       fixed3 lm = DecodeLightmap (lmtex);
//     #endif

//   #endif // LIGHTMAP_ON


  // realtime lighting: call lighting function
//   #ifndef LIGHTMAP_ON
//   c += LightingCustomHalfLambert (o, lightDir, worldViewDir, atten);
//   #else
//     c.a = o.Alpha;
//   #endif

//   #ifdef LIGHTMAP_ON
//     // combine lightmaps with realtime shadows
//     #ifdef SHADOWS_SCREEN
//       #if defined(UNITY_NO_RGBM)
//       c.rgb += o.Albedo * min(lm, atten*2);
//       #else
//       c.rgb += o.Albedo * max(min(lm,(atten*2)*lmtex.rgb), lm*atten);
//       #endif
//     #else // SHADOWS_SCREEN
//       c.rgb += o.Albedo * lm;
//     #endif // SHADOWS_SCREEN
//   #endif // LIGHTMAP_ON

//   #ifdef DYNAMICLIGHTMAP_ON
//   fixed4 dynlmtex = UNITY_SAMPLE_TEX2D(unity_DynamicLightmap, IN.lmap.zw);
//   c.rgb += o.Albedo * DecodeRealtimeLightmap (dynlmtex);
//   #endif

  UNITY_APPLY_FOG(_unity_fogCoord, c); // apply fog
  UNITY_OPAQUE_ALPHA(c.a);
  return c;
}


#endif


ENDCG

}

	// ---- shadow caster pass:
// 	Pass {
// 		Name "ShadowCaster"
// 		Tags { "LightMode" = "ShadowCaster" }
// 		ZWrite On ZTest LEqual

// CGPROGRAM
// // compile directives
// #pragma vertex vert_surf
// #pragma fragment frag_surf
// #pragma target 3.0
// #pragma multi_compile_instancing
// #pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
// #pragma multi_compile_shadowcaster
// #include "HLSLSupport.cginc"
// #define UNITY_INSTANCED_LOD_FADE
// #define UNITY_INSTANCED_SH
// #define UNITY_INSTANCED_LIGHTMAPSTS
// #include "UnityShaderVariables.cginc"
// #include "UnityShaderUtilities.cginc"
// // -------- variant for: <when no other keywords are defined>
// #if !defined(INSTANCING_ON)
// // Surface shader code generated based on:
// // writes to per-pixel normal: YES
// // writes to emission: no
// // writes to occlusion: no
// // needs world space reflection vector: no
// // needs world space normal vector: no
// // needs screen space position: no
// // needs world space position: no
// // needs view direction: no
// // needs world space view direction: no
// // needs world space position for lighting: no
// // needs world space view direction for lighting: YES
// // needs world space view direction for lightmaps: no
// // needs vertex color: no
// // needs VFACE: no
// // passes tangent-to-world matrix to pixel shader: YES
// // reads from normal: no
// // 0 texcoords actually used
// #include "UnityCG.cginc"
// #include "Lighting.cginc"

// #define INTERNAL_DATA
// #define WorldReflectionVector(data,normal) data.worldRefl
// #define WorldNormalVector(data,normal) normal

// // Original surface shader snippet:
// #line 19 ""
// #ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
// #endif
// /* UNITY: Original start of shader */
// 		//#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow
// 		//#pragma target 3.0
// 		////#pragma shader_feature Legacy

// 		sampler2D _MainTex;
// 		sampler2D _BumpMap;
// 		fixed4 _Color;
// 		//fixed4 _SpecColor;
// 		fixed _Gloss;
// 		half _Shininess;
// 		fixed _LightAttenFalloff;
// 		fixed _LightAttenBase;

// 		#define FALLOFF_POWER 1.0

// 		struct Input {
// 			float2 uv_MainTex;
// 			float2 uv_BumpMap;
// 			float3 viewDir;
// 		};

// 		void surf(Input IN, inout SurfaceOutput o) {
// 		    fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
// 		    o.Albedo = tex.rgb * _Color.rgb;
// 		    o.Gloss = _Gloss;
// 		    //o.Alpha = //tex.a * _Color.a;
// 		    o.Specular = _Shininess;
// 		    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
// 		}

// 		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
// 		{
// 			// #ifdef Legacy

// 			// 	fixed nh = max(0, dot(s.Normal, halfDir));
// 			// 	fixed4 c;
// 			// 	atten = atten * _LightAttenFalloff + _LightAttenBase;
// 			// 	c.rgb = s.Albedo.rgb * nh * atten;
// 			// 	UNITY_OPAQUE_ALPHA(c.a);
// 			// 	return c;

// 			// #else

// 				//float desaturate = saturate((dot(s.Albedo.rgb,float3(0.3,0.59,0.11))*4.0+-2.0));
// 				//float3 desaturateColor = float3(desaturate,desaturate,desaturate);

// 	    		fixed4 c = 0;
// 				return c;
// 	    		fixed nh = max(0, dot(s.Normal, halfDir));
// 	    		float spec = pow (nh, s.Specular * 128.0) * s.Gloss;// * desaturate;
// 				atten = atten * _LightAttenFalloff + _LightAttenBase;
// 				c.rgb = s.Albedo.rgb * nh * atten;
// 				c.rgb += _SpecColor.rgb * spec;
// 				UNITY_OPAQUE_ALPHA(c.a);
// 				return c;

// 			//#endif
// 		}

		

// // vertex-to-fragment interpolation data
// struct v2f_surf {
//   V2F_SHADOW_CASTER;
//   UNITY_VERTEX_INPUT_INSTANCE_ID
//   UNITY_VERTEX_OUTPUT_STEREO
// };

// // vertex shader
// v2f_surf vert_surf (appdata_full v) {
//   UNITY_SETUP_INSTANCE_ID(v);
//   v2f_surf o;
//   UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
//   UNITY_TRANSFER_INSTANCE_ID(v,o);
//   UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
//   float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
//   float3 worldNormal = UnityObjectToWorldNormal(v.normal);
//   TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
//   return o;
// }

// // fragment shader
// fixed4 frag_surf (v2f_surf IN) : SV_Target {
//   UNITY_SETUP_INSTANCE_ID(IN);
//   // prepare and unpack data
//   Input surfIN;
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
//   #elif defined (FOG_COMBINED_WITH_WORLD_POS)
//     UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
//   #else
//     UNITY_EXTRACT_FOG(IN);
//   #endif
//   UNITY_INITIALIZE_OUTPUT(Input,surfIN);
//   surfIN.uv_MainTex.x = 1.0;
//   surfIN.uv_BumpMap.x = 1.0;
//   surfIN.viewDir.x = 1.0;
//   #ifdef UNITY_COMPILER_HLSL
//   SurfaceOutput o = (SurfaceOutput)0;
//   #else
//   SurfaceOutput o;
//   #endif
//   o.Albedo = 0.0;
//   o.Emission = 0.0;
//   o.Specular = 0.0;
//   o.Alpha = 0.0;
//   o.Gloss = 0.0;
//   fixed3 normalWorldVertex = fixed3(0,0,1);

//   // call surface function
//   surf (surfIN, o);
//   SHADOW_CASTER_FRAGMENT(IN)
// }


// #endif

// // -------- variant for: INSTANCING_ON 
// #if defined(INSTANCING_ON)
// // Surface shader code generated based on:
// // writes to per-pixel normal: YES
// // writes to emission: no
// // writes to occlusion: no
// // needs world space reflection vector: no
// // needs world space normal vector: no
// // needs screen space position: no
// // needs world space position: no
// // needs view direction: no
// // needs world space view direction: no
// // needs world space position for lighting: no
// // needs world space view direction for lighting: YES
// // needs world space view direction for lightmaps: no
// // needs vertex color: no
// // needs VFACE: no
// // passes tangent-to-world matrix to pixel shader: YES
// // reads from normal: no
// // 0 texcoords actually used
// #include "UnityCG.cginc"
// #include "Lighting.cginc"

// #define INTERNAL_DATA
// #define WorldReflectionVector(data,normal) data.worldRefl
// #define WorldNormalVector(data,normal) normal

// // Original surface shader snippet:
// #line 19 ""
// #ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
// #endif
// /* UNITY: Original start of shader */
// 		//#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow
// 		//#pragma target 3.0
// 		////#pragma shader_feature Legacy

// 		sampler2D _MainTex;
// 		sampler2D _BumpMap;
// 		fixed4 _Color;
// 		//fixed4 _SpecColor;
// 		fixed _Gloss;
// 		half _Shininess;
// 		fixed _LightAttenFalloff;
// 		fixed _LightAttenBase;

// 		#define FALLOFF_POWER 1.0

// 		struct Input {
// 			float2 uv_MainTex;
// 			float2 uv_BumpMap;
// 			float3 viewDir;
// 		};

// 		void surf(Input IN, inout SurfaceOutput o) {
// 		    fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
// 		    o.Albedo = tex.rgb * _Color.rgb;
// 		    o.Gloss = _Gloss;
// 		    //o.Alpha = //tex.a * _Color.a;
// 		    o.Specular = _Shininess;
// 		    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
// 		}

// 		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
// 		{
// 			// #ifdef Legacy

// 			// 	fixed nh = max(0, dot(s.Normal, halfDir));
// 			// 	fixed4 c;
// 			// 	atten = atten * _LightAttenFalloff + _LightAttenBase;
// 			// 	c.rgb = s.Albedo.rgb * nh * atten;
// 			// 	UNITY_OPAQUE_ALPHA(c.a);
// 			// 	return c;

// 			// #else

// 				//float desaturate = saturate((dot(s.Albedo.rgb,float3(0.3,0.59,0.11))*4.0+-2.0));
// 				//float3 desaturateColor = float3(desaturate,desaturate,desaturate);

// 	    		fixed4 c = 0;
// 				return c;
// 	    		fixed nh = max(0, dot(s.Normal, halfDir));
// 	    		float spec = pow (nh, s.Specular * 128.0) * s.Gloss;// * desaturate;
// 				atten = atten * _LightAttenFalloff + _LightAttenBase;
// 				c.rgb = s.Albedo.rgb * nh * atten;
// 				c.rgb += _SpecColor.rgb * spec;
// 				UNITY_OPAQUE_ALPHA(c.a);
// 				return c;

// 			//#endif
// 		}

		

// // vertex-to-fragment interpolation data
// struct v2f_surf {
//   V2F_SHADOW_CASTER;
//   UNITY_VERTEX_INPUT_INSTANCE_ID
//   UNITY_VERTEX_OUTPUT_STEREO
// };

// // vertex shader
// v2f_surf vert_surf (appdata_full v) {
//   UNITY_SETUP_INSTANCE_ID(v);
//   v2f_surf o;
//   UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
//   UNITY_TRANSFER_INSTANCE_ID(v,o);
//   UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
//   float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
//   float3 worldNormal = UnityObjectToWorldNormal(v.normal);
//   TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
//   return o;
// }

// // fragment shader
// fixed4 frag_surf (v2f_surf IN) : SV_Target {
//   UNITY_SETUP_INSTANCE_ID(IN);
//   // prepare and unpack data
//   Input surfIN;
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
//   #elif defined (FOG_COMBINED_WITH_WORLD_POS)
//     UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
//   #else
//     UNITY_EXTRACT_FOG(IN);
//   #endif
//   UNITY_INITIALIZE_OUTPUT(Input,surfIN);
//   surfIN.uv_MainTex.x = 1.0;
//   surfIN.uv_BumpMap.x = 1.0;
//   surfIN.viewDir.x = 1.0;
//   #ifdef UNITY_COMPILER_HLSL
//   SurfaceOutput o = (SurfaceOutput)0;
//   #else
//   SurfaceOutput o;
//   #endif
//   o.Albedo = 0.0;
//   o.Emission = 0.0;
//   o.Specular = 0.0;
//   o.Alpha = 0.0;
//   o.Gloss = 0.0;
//   fixed3 normalWorldVertex = fixed3(0,0,1);

//   // call surface function
//   surf (surfIN, o);
//   SHADOW_CASTER_FRAGMENT(IN)
// }


// #endif


// ENDCG

// }

	// ---- meta information extraction pass:
// 	Pass {
// 		Name "Meta"
// 		Tags { "LightMode" = "Meta" }
// 		Cull Off

// CGPROGRAM
// // compile directives
// #pragma vertex vert_surf
// #pragma fragment frag_surf
// #pragma target 3.0
// #pragma multi_compile_instancing
// #pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
// #pragma shader_feature EDITOR_VISUALIZATION

// #include "HLSLSupport.cginc"
// #define UNITY_INSTANCED_LOD_FADE
// #define UNITY_INSTANCED_SH
// #define UNITY_INSTANCED_LIGHTMAPSTS
// #include "UnityShaderVariables.cginc"
// #include "UnityShaderUtilities.cginc"
// // -------- variant for: <when no other keywords are defined>
// #if !defined(INSTANCING_ON)
// // Surface shader code generated based on:
// // writes to per-pixel normal: YES
// // writes to emission: no
// // writes to occlusion: no
// // needs world space reflection vector: no
// // needs world space normal vector: no
// // needs screen space position: no
// // needs world space position: no
// // needs view direction: no
// // needs world space view direction: no
// // needs world space position for lighting: no
// // needs world space view direction for lighting: YES
// // needs world space view direction for lightmaps: no
// // needs vertex color: no
// // needs VFACE: no
// // passes tangent-to-world matrix to pixel shader: YES
// // reads from normal: no
// // 1 texcoords actually used
// //   float2 _MainTex
// #include "UnityCG.cginc"
// #include "Lighting.cginc"

// #define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
// #define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
// #define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// // Original surface shader snippet:
// #line 19 ""
// #ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
// #endif
// /* UNITY: Original start of shader */
// 		//#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow
// 		//#pragma target 3.0
// 		////#pragma shader_feature Legacy

// 		sampler2D _MainTex;
// 		sampler2D _BumpMap;
// 		fixed4 _Color;
// 		//fixed4 _SpecColor;
// 		fixed _Gloss;
// 		half _Shininess;
// 		fixed _LightAttenFalloff;
// 		fixed _LightAttenBase;

// 		#define FALLOFF_POWER 1.0

// 		struct Input {
// 			float2 uv_MainTex;
// 			float2 uv_BumpMap;
// 			float3 viewDir;
// 		};

// 		void surf(Input IN, inout SurfaceOutput o) {
// 		    fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
// 		    o.Albedo = tex.rgb * _Color.rgb;
// 		    o.Gloss = _Gloss;
// 		    //o.Alpha = //tex.a * _Color.a;
// 		    o.Specular = _Shininess;
// 		    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
// 		}

// 		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
// 		{
// 			// #ifdef Legacy

// 			// 	fixed nh = max(0, dot(s.Normal, halfDir));
// 			// 	fixed4 c;
// 			// 	atten = atten * _LightAttenFalloff + _LightAttenBase;
// 			// 	c.rgb = s.Albedo.rgb * nh * atten;
// 			// 	UNITY_OPAQUE_ALPHA(c.a);
// 			// 	return c;

// 			// #else

// 				//float desaturate = saturate((dot(s.Albedo.rgb,float3(0.3,0.59,0.11))*4.0+-2.0));
// 				//float3 desaturateColor = float3(desaturate,desaturate,desaturate);

// 	    		fixed4 c = 0;
// 				return c;
// 	    		fixed nh = max(0, dot(s.Normal, halfDir));
// 	    		float spec = pow (nh, s.Specular * 128.0) * s.Gloss;// * desaturate;
// 				atten = atten * _LightAttenFalloff + _LightAttenBase;
// 				c.rgb = s.Albedo.rgb * nh * atten;
// 				c.rgb += _SpecColor.rgb * spec;
// 				UNITY_OPAQUE_ALPHA(c.a);
// 				return c;

// 			//#endif
// 		}

		
// #include "UnityMetaPass.cginc"

// // vertex-to-fragment interpolation data
// struct v2f_surf {
//   UNITY_POSITION(pos);
//   float2 pack0 : TEXCOORD0; // _MainTex
//   float3 tSpace0 : TEXCOORD1;
//   float3 tSpace1 : TEXCOORD2;
//   float3 tSpace2 : TEXCOORD3;
// #ifdef EDITOR_VISUALIZATION
//   float2 vizUV : TEXCOORD4;
//   float4 lightCoord : TEXCOORD5;
// #endif
//   UNITY_VERTEX_INPUT_INSTANCE_ID
//   UNITY_VERTEX_OUTPUT_STEREO
// };
// float4 _MainTex_ST;

// // vertex shader
// v2f_surf vert_surf (appdata_full v) {
//   UNITY_SETUP_INSTANCE_ID(v);
//   v2f_surf o;
//   UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
//   UNITY_TRANSFER_INSTANCE_ID(v,o);
//   UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
//   o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
// #ifdef EDITOR_VISUALIZATION
//   o.vizUV = 0;
//   o.lightCoord = 0;
//   if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
//     o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.texcoord.xy, v.texcoord1.xy, v.texcoord2.xy, unity_EditorViz_Texture_ST);
//   else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
//   {
//     o.vizUV = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
//     o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
//   }
// #endif
//   o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
//   float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
//   float3 worldNormal = UnityObjectToWorldNormal(v.normal);
//   fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
//   fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
//   fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
//   o.tSpace0 = float3(worldTangent.x, worldBinormal.x, worldNormal.x);
//   o.tSpace1 = float3(worldTangent.y, worldBinormal.y, worldNormal.y);
//   o.tSpace2 = float3(worldTangent.z, worldBinormal.z, worldNormal.z);
//   return o;
// }

// // fragment shader
// fixed4 frag_surf (v2f_surf IN) : SV_Target {
//   UNITY_SETUP_INSTANCE_ID(IN);
//   // prepare and unpack data
//   Input surfIN;
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
//   #elif defined (FOG_COMBINED_WITH_WORLD_POS)
//     UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
//   #else
//     UNITY_EXTRACT_FOG(IN);
//   #endif
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_RECONSTRUCT_TBN(IN);
//   #else
//     UNITY_EXTRACT_TBN(IN);
//   #endif
//   UNITY_INITIALIZE_OUTPUT(Input,surfIN);
//   surfIN.uv_MainTex.x = 1.0;
//   surfIN.uv_BumpMap.x = 1.0;
//   surfIN.viewDir.x = 1.0;
//   surfIN.uv_MainTex = IN.pack0.xy;
//   #ifdef UNITY_COMPILER_HLSL
//   SurfaceOutput o = (SurfaceOutput)0;
//   #else
//   SurfaceOutput o;
//   #endif
//   o.Albedo = 0.0;
//   o.Emission = 0.0;
//   o.Specular = 0.0;
//   o.Alpha = 0.0;
//   o.Gloss = 0.0;
//   fixed3 normalWorldVertex = fixed3(0,0,1);

//   // call surface function
//   surf (surfIN, o);
//   UnityMetaInput metaIN;
//   UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
//   metaIN.Albedo = o.Albedo;
//   metaIN.Emission = o.Emission;
//   metaIN.SpecularColor = o.Specular;
// #ifdef EDITOR_VISUALIZATION
//   metaIN.VizUV = IN.vizUV;
//   metaIN.LightCoord = IN.lightCoord;
// #endif
//   return UnityMetaFragment(metaIN);
// }


// #endif

// // -------- variant for: INSTANCING_ON 
// #if defined(INSTANCING_ON)
// // Surface shader code generated based on:
// // writes to per-pixel normal: YES
// // writes to emission: no
// // writes to occlusion: no
// // needs world space reflection vector: no
// // needs world space normal vector: no
// // needs screen space position: no
// // needs world space position: no
// // needs view direction: no
// // needs world space view direction: no
// // needs world space position for lighting: no
// // needs world space view direction for lighting: YES
// // needs world space view direction for lightmaps: no
// // needs vertex color: no
// // needs VFACE: no
// // passes tangent-to-world matrix to pixel shader: YES
// // reads from normal: no
// // 1 texcoords actually used
// //   float2 _MainTex
// #include "UnityCG.cginc"
// #include "Lighting.cginc"

// #define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
// #define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
// #define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

// // Original surface shader snippet:
// #line 19 ""
// #ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
// #endif
// /* UNITY: Original start of shader */
// 		//#pragma surface surf CustomHalfLambert noforwardadd exclude_path:deferred exclude_path:prepass addshadow
// 		//#pragma target 3.0
// 		////#pragma shader_feature Legacy

// 		sampler2D _MainTex;
// 		sampler2D _BumpMap;
// 		fixed4 _Color;
// 		//fixed4 _SpecColor;
// 		fixed _Gloss;
// 		half _Shininess;
// 		fixed _LightAttenFalloff;
// 		fixed _LightAttenBase;

// 		#define FALLOFF_POWER 1.0

// 		struct Input {
// 			float2 uv_MainTex;
// 			float2 uv_BumpMap;
// 			float3 viewDir;
// 		};

// 		void surf(Input IN, inout SurfaceOutput o) {
// 		    fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
// 		    o.Albedo = tex.rgb * _Color.rgb;
// 		    o.Gloss = _Gloss;
// 		    //o.Alpha = //tex.a * _Color.a;
// 		    o.Specular = _Shininess;
// 		    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
// 		}

// 		inline fixed4 LightingCustomHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
// 		{
// 			// #ifdef Legacy

// 			// 	fixed nh = max(0, dot(s.Normal, halfDir));
// 			// 	fixed4 c;
// 			// 	atten = atten * _LightAttenFalloff + _LightAttenBase;
// 			// 	c.rgb = s.Albedo.rgb * nh * atten;
// 			// 	UNITY_OPAQUE_ALPHA(c.a);
// 			// 	return c;

// 			// #else

// 				//float desaturate = saturate((dot(s.Albedo.rgb,float3(0.3,0.59,0.11))*4.0+-2.0));
// 				//float3 desaturateColor = float3(desaturate,desaturate,desaturate);

// 	    		fixed4 c = 0;
// 				return c;
// 	    		fixed nh = max(0, dot(s.Normal, halfDir));
// 	    		float spec = pow (nh, s.Specular * 128.0) * s.Gloss;// * desaturate;
// 				atten = atten * _LightAttenFalloff + _LightAttenBase;
// 				c.rgb = s.Albedo.rgb * nh * atten;
// 				c.rgb += _SpecColor.rgb * spec;
// 				UNITY_OPAQUE_ALPHA(c.a);
// 				return c;

// 			//#endif
// 		}

		
// #include "UnityMetaPass.cginc"

// // vertex-to-fragment interpolation data
// struct v2f_surf {
//   UNITY_POSITION(pos);
//   float2 pack0 : TEXCOORD0; // _MainTex
//   float3 tSpace0 : TEXCOORD1;
//   float3 tSpace1 : TEXCOORD2;
//   float3 tSpace2 : TEXCOORD3;
// #ifdef EDITOR_VISUALIZATION
//   float2 vizUV : TEXCOORD4;
//   float4 lightCoord : TEXCOORD5;
// #endif
//   UNITY_VERTEX_INPUT_INSTANCE_ID
//   UNITY_VERTEX_OUTPUT_STEREO
// };
// float4 _MainTex_ST;

// // vertex shader
// v2f_surf vert_surf (appdata_full v) {
//   UNITY_SETUP_INSTANCE_ID(v);
//   v2f_surf o;
//   UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
//   UNITY_TRANSFER_INSTANCE_ID(v,o);
//   UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
//   o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
// #ifdef EDITOR_VISUALIZATION
//   o.vizUV = 0;
//   o.lightCoord = 0;
//   if (unity_VisualizationMode == EDITORVIZ_TEXTURE)
//     o.vizUV = UnityMetaVizUV(unity_EditorViz_UVIndex, v.texcoord.xy, v.texcoord1.xy, v.texcoord2.xy, unity_EditorViz_Texture_ST);
//   else if (unity_VisualizationMode == EDITORVIZ_SHOWLIGHTMASK)
//   {
//     o.vizUV = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
//     o.lightCoord = mul(unity_EditorViz_WorldToLight, mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1)));
//   }
// #endif
//   o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
//   float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
//   float3 worldNormal = UnityObjectToWorldNormal(v.normal);
//   fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
//   fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
//   fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
//   o.tSpace0 = float3(worldTangent.x, worldBinormal.x, worldNormal.x);
//   o.tSpace1 = float3(worldTangent.y, worldBinormal.y, worldNormal.y);
//   o.tSpace2 = float3(worldTangent.z, worldBinormal.z, worldNormal.z);
//   return o;
// }

// // fragment shader
// fixed4 frag_surf (v2f_surf IN) : SV_Target {
//   UNITY_SETUP_INSTANCE_ID(IN);
//   // prepare and unpack data
//   Input surfIN;
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_EXTRACT_FOG_FROM_TSPACE(IN);
//   #elif defined (FOG_COMBINED_WITH_WORLD_POS)
//     UNITY_EXTRACT_FOG_FROM_WORLD_POS(IN);
//   #else
//     UNITY_EXTRACT_FOG(IN);
//   #endif
//   #ifdef FOG_COMBINED_WITH_TSPACE
//     UNITY_RECONSTRUCT_TBN(IN);
//   #else
//     UNITY_EXTRACT_TBN(IN);
//   #endif
//   UNITY_INITIALIZE_OUTPUT(Input,surfIN);
//   surfIN.uv_MainTex.x = 1.0;
//   surfIN.uv_BumpMap.x = 1.0;
//   surfIN.viewDir.x = 1.0;
//   surfIN.uv_MainTex = IN.pack0.xy;
//   #ifdef UNITY_COMPILER_HLSL
//   SurfaceOutput o = (SurfaceOutput)0;
//   #else
//   SurfaceOutput o;
//   #endif
//   o.Albedo = 0.0;
//   o.Emission = 0.0;
//   o.Specular = 0.0;
//   o.Alpha = 0.0;
//   o.Gloss = 0.0;
//   fixed3 normalWorldVertex = fixed3(0,0,1);

//   // call surface function
//   surf (surfIN, o);
//   UnityMetaInput metaIN;
//   UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
//   metaIN.Albedo = o.Albedo;
//   metaIN.Emission = o.Emission;
//   metaIN.SpecularColor = o.Specular;
// #ifdef EDITOR_VISUALIZATION
//   metaIN.VizUV = IN.vizUV;
//   metaIN.LightCoord = IN.lightCoord;
// #endif
//   return UnityMetaFragment(metaIN);
// }


// #endif


// ENDCG

// }

	// ---- end of surface shader generated code

#LINE 81

	}
	FallBack "Diffuse"
}
