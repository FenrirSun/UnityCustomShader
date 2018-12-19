// Upgrade NOTE: replaced 'UNITY_INSTANCE_ID' with 'UNITY_VERTEX_INPUT_INSTANCE_ID'



Shader "TS_QT/Waibao/Waibao_Shader1" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
		_AlphaTex("Alpha Texture", 2D) = "white"{} 
		_BRDFMap("BRDF",2D) = "white"{}
		BRDF_k1("diff k", float) = 0.3
		BRDF_k2("spec k", float) = 1
		_pow("Specular Pow", float) = 1

		_RoleReflectDiffWeight("reflect diff w", Range(0,10)) = 1

	}
		SubShader{
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry+400" }
		LOD 800

		Pass{
		Name "FORWARD"
		Tags{ "LightMode" = "ForwardBase" }

		CGPROGRAM

#pragma vertex vert_surf
#pragma fragment frag_surf
#pragma target 3.0
#pragma multi_compile_fwdbase nodynlightmap nodirlightmap noshadow
#include "HLSLSupport.cginc"
#define UNITY_PASS_FORWARDBASE
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "AutoLight.cginc"

#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))

		// Original surface shader snippet:
#line 22 ""
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif


		struct Input
	{
		fixed2 uv_MainTex;
		float2 uv_QTBumpMap;

		fixed4 vertexColor;


	};

#define QT_ROLE_SHADOW_OFF
#define ZEngine_Normale fixed4(0,0,1,0)

	fixed4 _Color;
	fixed _Cutoff;
	sampler2D _MainTex;
	sampler2D _AlphaTex;
	sampler2D _QTBumpMap;
		fixed _pow;
		fixed _RoleReflectDiffWeight;



		fixed BRDF_k1;
		fixed BRDF_k2;
		sampler2D _BRDFMap;
		fixed specEnhanceOqapue; 

		inline fixed4 LightingQT_BRDF(SurfaceOutput a1, fixed3 a2, half3 a3, fixed a4)
		{
			fixed a5 = dot(a1.Normal, a2);
			fixed a6 = (a5 + 1) / 2;
			fixed3 a7 = -a2 - 2 * dot(-a2, a1.Normal) * a1.Normal;
			fixed a8 = (dot(a7, a3) + 1) / 2;
			fixed3 a9 = tex2D(_BRDFMap, fixed2(a6, a8));
			fixed b1 = a9.b * a9.g * a1.Specular;
			fixed b2 = a9.r;

			fixed4 c;
			c.rgb = (BRDF_k1 * a1.Albedo * _LightColor0.rgb * b2 + BRDF_k2 * _LightColor0.rgb * b1) * (a4 * 2);
			c.a = a1.Alpha + b1 * specEnhanceOqapue;

			return c;
		}

		inline void ReloReflectEnv_Pixel(inout fixed4 color)
		{

			color.rgb = color.xyz * _RoleReflectDiffWeight;

		}

	void surf(Input IN, inout SurfaceOutput o) {


		fixed4 b3 = tex2D(_AlphaTex, IN.uv_MainTex);
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
		o.Albedo = c.rgb * _Color * b3.g;

		o.Alpha = 1;
		o.Gloss = b3.r;

		o.Normal = ZEngine_Normale;


		o.Specular = pow(b3.b, _pow);

	}

	void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
	{

		ReloReflectEnv_Pixel(color);
	}


#ifdef LIGHTMAP_OFF
	struct v2f_surf {
		float4 pos : SV_POSITION;
		half2 pack0 : TEXCOORD0;
		float4 tSpace0 : TEXCOORD1;
		float4 tSpace1 : TEXCOORD2;
		float4 tSpace2 : TEXCOORD3;
		fixed3 vlight : TEXCOORD4; 
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};
#endif
	// with lightmaps:
#ifndef LIGHTMAP_OFF
	struct v2f_surf {
		float4 pos : SV_POSITION;
		half2 pack0 : TEXCOORD0; // _MainTex
		float4 tSpace0 : TEXCOORD1;
		float4 tSpace1 : TEXCOORD2;
		float4 tSpace2 : TEXCOORD3;
		float4 lmap : TEXCOORD4;
		UNITY_VERTEX_INPUT_INSTANCE_ID
	};
#endif
	float4 _MainTex_ST;

	// vertex shader
	v2f_surf vert_surf(appdata_full v) {
		UNITY_SETUP_INSTANCE_ID(v);
		v2f_surf o;
		UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
		UNITY_TRANSFER_INSTANCE_ID(v,o);
		o.pos = UnityObjectToClipPos(v.vertex);
		o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
		float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
		fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
		fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
		fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
		fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
		o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
		o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
		o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
#ifndef LIGHTMAP_OFF
		o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
#endif

		// SH/ambient and vertex lights
#ifdef LIGHTMAP_OFF
#if UNITY_SHOULD_SAMPLE_SH
		float3 shlight = ShadeSH9(float4(worldNormal,1.0));
		o.vlight = shlight;
#else
		o.vlight = 0.0;
#endif
#ifdef VERTEXLIGHT_ON
		o.vlight += Shade4PointLights(
			unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
			unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
			unity_4LightAtten0, worldPos, worldNormal);
#endif // VERTEXLIGHT_ON
#endif // LIGHTMAP_OFF

		return o;
	}

	// fragment shader
	fixed4 frag_surf(v2f_surf IN) : SV_Target{
		UNITY_SETUP_INSTANCE_ID(IN);
	// prepare and unpack data
	Input surfIN;
	UNITY_INITIALIZE_OUTPUT(Input,surfIN);
	surfIN.uv_MainTex.x = 1.0;
	surfIN.uv_QTBumpMap.x = 1.0;
	surfIN.vertexColor.x = 1.0;
	surfIN.uv_MainTex = IN.pack0.xy;
	float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
#ifndef USING_DIRECTIONAL_LIGHT
	fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
#else
	fixed3 lightDir = _WorldSpaceLightPos0.xyz;
#endif
	fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
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

	// call surface function
	surf(surfIN, o);

	// compute lighting & shadowing factor
	UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
		fixed4 c = 0;
	fixed3 worldN;
	worldN.x = dot(IN.tSpace0.xyz, o.Normal);
	worldN.y = dot(IN.tSpace1.xyz, o.Normal);
	worldN.z = dot(IN.tSpace2.xyz, o.Normal);
	o.Normal = worldN;
#ifdef LIGHTMAP_OFF
	c.rgb += o.Albedo * IN.vlight;
#endif // LIGHTMAP_OFF

	// lightmaps
#ifndef LIGHTMAP_OFF
#if DIRLIGHTMAP_COMBINED
	// directional lightmaps
	fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
	fixed4 lmIndTex = UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd, unity_Lightmap, IN.lmap.xy);
	half3 lm = DecodeDirectionalLightmap(DecodeLightmap(lmtex), lmIndTex, o.Normal);
#elif DIRLIGHTMAP_SEPARATE
	// directional with specular - no support
	half4 lmtex = 0;
	half3 lm = 0;
#else
	// single lightmap
	fixed4 lmtex = UNITY_SAMPLE_TEX2D(unity_Lightmap, IN.lmap.xy);
	fixed3 lm = DecodeLightmap(lmtex);
#endif

#endif // LIGHTMAP_OFF


	// realtime lighting: call lighting function
#ifdef LIGHTMAP_OFF
	c += LightingQT_BRDF(o, lightDir, worldViewDir, atten);
#else
	c.a = o.Alpha;
#endif

#ifndef LIGHTMAP_OFF
	// combine lightmaps with realtime shadows
#ifdef SHADOWS_SCREEN
#if defined(UNITY_NO_RGBM)
	c.rgb += o.Albedo * min(lm, atten * 2);
#else
	c.rgb += o.Albedo * max(min(lm,(atten * 2)*lmtex.rgb), lm*atten);
#endif
#else // SHADOWS_SCREEN
	c.rgb += o.Albedo * lm;
#endif // SHADOWS_SCREEN
#endif // LIGHTMAP_OFF

	YHFinalColor(surfIN, o, c);
	UNITY_OPAQUE_ALPHA(c.a);
	return c;
	}

		ENDCG

	}

		// ---- end of surface shader generated code

		#LINE 71


	}
		Fallback Off
}
