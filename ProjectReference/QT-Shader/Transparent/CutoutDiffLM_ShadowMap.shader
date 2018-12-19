//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_OFF</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON;QT_SCENE_POINT_LIGHT_G0_ON</Exclude Keyword>
Shader "TS_QT/Transparent/Cutout/DiffuseLM_ShadowMap" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaTex ("Alpha Texture", 2D) = "white"{}
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.1
	}
	SubShader {
		Tags {"RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="True"}
	//	Tags { "RenderType"="Opaque" "Queue" = "Geometry+500"  "IgnoreProjector"="True"}
	//	Tags { "Queue"="Geometry" "IgnoreProjector"="True" "RenderType"="Opaque" }
		Blend SrcAlpha OneMinusSrcAlpha
		ZTest On
		ZWrite On
		LOD 200
		
		CGPROGRAM

//*#ifqtdef editor
	#define QT_FOG_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
	#pragma multi_compile QT_SCENE_POINT_LIGHT_G0_OFF QT_SCENE_POINT_LIGHT_G0_ON
	#pragma multi_compile QT_SHADOW_ON QT_SHADOW_OFF
//endqtdef*/

/*#ifqtdef high
	#define QT_FOG_ON
	#define QT_SHADOW_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap novertexlights finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
	#pragma multi_compile QT_SCENE_POINT_LIGHT_G0_OFF QT_SCENE_POINT_LIGHT_G0_ON
//endqtdef*/

/*#ifqtdef middle
	#define QT_FOG_ON
	#define QT_SHADOW_OFF
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap novertexlights finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
	#pragma multi_compile QT_SCENE_POINT_LIGHT_G0_OFF QT_SCENE_POINT_LIGHT_G0_ON
//endqtdef*/

/*#ifqtdef low
	#define QT_FOG_ON
	#define QT_SHADOW_OFF
	#define QT_SCENE_POINT_LIGHT_G0_OFF
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap novertexlights finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
//endqtdef*/




		#pragma target 3.0

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			ZEngine_Clip;
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color;
			o.Alpha = alpha.a;

			o.Alpha = step(_Cutoff, alpha.a) * _Color.a;
		}

		//顶点处理
	void YHVertex(inout appdata_full v, out Input data)
	{
		data = (Input)0; 

	#ifdef QT_SHADOW_ON
		Shadow_Vertex(v,data);
	#endif

	#ifdef QT_STATIC_REALTIME_LIGHT_ON
	StaticRealtimeLight_Vertex(v,data);
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

	#ifdef QT_SHADOW_ON
		Shadow_Pixel(IN,o,color);
	#endif

	#ifdef QT_STATIC_REALTIME_LIGHT_ON
	StaticRealtimeLight_Pixel(IN,o,color);
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
	Fallback Off
}
