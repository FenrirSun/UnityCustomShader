//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_TEXILLUMIN_ON;QT_FLUX_ON</Exclude Keyword>
Shader "TS_QT/Light/Transparent/Lambert" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_AlphaTex ("Alpha Texture", 2D) = "white"{}
	_Alpha("_Alpha", Range(0,1)) = 1
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.1
}
SubShader {
	Tags { "Queue"="Transparent" "RenderType"="Transparent" }
	LOD 1000
	Blend SrcAlpha OneMinusSrcAlpha     

	CGPROGRAM
	#define QT_FOG_ON
	//#define QT_HITED_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_Lambert noforwardadd alpha noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
	
	#pragma target 3.0

	void surf (Input IN, inout SurfaceOutput o) {
		fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
		ZEngine_Clip;
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = c.rgb;
		o.Alpha = c.a;
	}


	//顶点处理
	void YHVertex(inout appdata_full v, out Input data)
	{
		data = (Input)0; 

	#ifdef QT_SHADOW_ON
		Shadow_Vertex(v,data);
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
	
	#ifdef QT_FOG_ON
		Fog_Pixel(IN,o,color);
	#endif
		
		//最终颜色处理
		color = FinalColor(color);
	}

	ENDCG
}



SubShader{
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 300
		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM

		//#define QT_HITED_ON
#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_Lambert noforwardadd alpha noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass

#pragma target 3.0

		void surf(Input IN, inout SurfaceOutput o) {
		fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
		ZEngine_Clip;
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = c.rgb;
		o.Alpha = c.a;
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
