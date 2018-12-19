//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_TEXILLUMIN_ON;QT_FLUX_ON</Exclude Keyword>
//地表反射装饰物，如一小洼积水
Shader "TS_QT/Light/BRDF_Ground_Reflect" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaTex ("Alpha Texture", 2D) = "white"{}  //r无用 g:透明度 b: 0.5~1 高光贴图（低于0.2表示cutoff）
		_BRDFMap ("BRDF",2D) = "white"{}
		_QTBumpMap ("Normalmap", 2D) = "bump" {}
		BRDF_k1 ("diff k", Range(0, 10)) = 0.3                   //漫射光权重
		BRDF_k2 ("spec k", float) = 1							//镜面光权重
		_PR_DiffWeight("reflect diff w", Range(0,2)) = 1
		_PR_ReflectWeight("reflect env w",Range(0,10)) = 0
	//	_ReflectTex("Reflect Tex",2D) = "white" { }
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "Geometry+302"}
		//Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		LOD 800
		Blend SrcAlpha OneMinusSrcAlpha  
	//	ZTest On   

		CGPROGRAM
		#define QT_FOG_ON
		//#define QT_PLANE_REFLECT_ON
//		#define QT_HITED_ON
		#include "Assets/Resources/QTShader/QTShaderLib.cginc"
		#pragma surface surf QT_BRDF alpha noambient noforwardadd noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
		#pragma multi_compile QT_PLANE_REFLECT_ON QT_PLANE_REFLECT_OFF
		#pragma multi_compile QT_SCENE_POINT_LIGHT_G0_OFF QT_SCENE_POINT_LIGHT_G0_ON
		#pragma target 3.0


		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			//ZEngine_ClipBlue;
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color;
			o.Alpha = alpha.r * _Color.a;
			o.Gloss =saturate((alpha.b - 0.5) * 2);
			o.Normal = UnpackNormal(tex2D(_QTBumpMap, IN.uv_QTBumpMap));
			//o.Normal = ZEngine_Normale;
		}

		//顶点处理
	void YHVertex(inout appdata_full v, out Input data)
	{
		data = (Input)0; 

	#ifdef QT_SHADOW_ON
		Shadow_Vertex(v,data);
	#endif

	#ifdef QT_PLANE_REFLECT_ON
		PlaneReflect_Vertex(v,data);
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
	#ifdef QT_PLANE_REFLECT_ON
		PlaneReflect_Pixel(IN,o,color);
	#else
		color.a = 0;
		return;
	#endif

	#ifdef QT_SHADOW_ON
		Shadow_Pixel(IN,o,color);
	#endif

	#ifdef QT_SCENE_POINT_LIGHT_G0_ON
		PointLight_Pixel(IN,o,color);
	#endif
	
	#ifdef QT_FOG_ON
		Fog_Pixel(IN,o,color);
	#endif
		
		//最终颜色处理
		color = FinalColor(color);
		//color.argb = 1;
	}

		ENDCG
		
	} 
Fallback Off
}
