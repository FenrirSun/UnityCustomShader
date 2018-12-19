//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_OFF</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON;QT_SCENE_POINT_LIGHT_G0_ON</Exclude Keyword>
Shader "TS_QT/Light/Transparent/LambertLM_Cutout_RealLight" {
		Properties{
			_Color("Main Color", Color) = (1,1,1,1)
			_MainTex("Base (RGB)", 2D) = "white" {}
		_QTBumpMap("Normalmap", 2D) = "bump" {}
		_AlphaTex("Alpha Texture", 2D) = "white"{}

		LightMap_RealHighLightScale("Real Light Scale", float) = 0
			//BlinnPhong_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 0)
			Lightmap_finalShininess("Shininess", Range(0.001, 5)) = 0

			LightMap_AdjustDiff("LightMap_AdjustDiff", Range(0,5)) = 0
			_Cutoff("Alpha cutoff", Range(0,1)) = 0.1
		}
			SubShader{
			Tags{ "RenderType" = "Opaque" }
			LOD 1000

			CGPROGRAM



#define QT_FOG_ON
#define QT_STATIC_REALTIME_LIGHT_ON
#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
#pragma multi_compile QT_SCENE_POINT_LIGHT_G0_OFF QT_SCENE_POINT_LIGHT_G0_ON
#pragma target 3.0

			//fixed4 _Color;
			//sampler2D _MainTex;
			//sampler2D _AlphaTex;//r:自发光/流光遮罩  g:?  b:高光贴图

			float4 _QTBumpMap_ST;

		//surface
		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			ZEngine_ClipRed;
			//clip(c.a - _Cutoff - 0.001);
			o.Albedo = c.rgb;
			o.Alpha = 1;
			o.Specular = alpha.b;
			fixed2 nromalCoord = TRANSFORM_TEX(IN.uv_MainTex, _QTBumpMap);
			o.Normal = UnpackNormal(tex2D(_QTBumpMap, nromalCoord));
			//TanSpaceNormal = o.Normal;
		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0;

#ifdef QT_STATIC_REALTIME_LIGHT_ON
			StaticRealtimeLight_Vertex(v, data);
#endif

#ifdef QT_SCENE_POINT_LIGHT_G0_ON
			PointLight_Vertex(v,data);
#endif


#ifdef QT_FOG_ON
			Fog_Vertex(v,data);
#endif


		}

		//像素处理
		void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
#ifdef QT_STATIC_REALTIME_LIGHT_ON
			StaticRealtimeLight_Pixel(IN, o, color);
#endif


#ifdef QT_SCENE_POINT_LIGHT_G0_ON
			PointLight_Pixel(IN,o,color);
#endif

#ifdef QT_FOG_ON
			Fog_Pixel(IN,o,color);
#endif


			//最终颜色处理
			color = FinalColor(color);
		}

		ENDCG
		}



			SubShader{
			Tags{ "RenderType" = "Opaque" }
			LOD 300

			CGPROGRAM



#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
#pragma target 3.0

			//fixed4 _Color;
			//sampler2D _MainTex;
			//sampler2D _AlphaTex;//r:自发光/流光遮罩  g:?  b:高光贴图

			float4 _QTBumpMap_ST;

		//surface
		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			ZEngine_ClipRed;
			//clip(c.a - _Cutoff - 0.001);
			o.Albedo = c.rgb;
			o.Alpha = 1;
			o.Specular = alpha.b;
			fixed2 nromalCoord = TRANSFORM_TEX(IN.uv_MainTex, _QTBumpMap);
			o.Normal = UnpackNormal(tex2D(_QTBumpMap, nromalCoord));
			//TanSpaceNormal = o.Normal;
		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0;
		}

		//像素处理
		void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			//最终颜色处理
			color = FinalColor(color);
		}

		ENDCG
		}

			Fallback Off
	}
