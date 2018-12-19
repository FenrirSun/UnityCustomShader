Shader "Custom/BRDF" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaTex ("Alpha Texture", 2D) = "white"{}     //r表示流光遮罩 g:? b: 0.5~1 高光贴图（低于0.2表示cutoff）
		_BRDFMap ("BRDF",2D) = "white"{}
		BRDF_k1 ("diff k", float) = 0.3          //漫射光权重
		BRDF_k2 ("spec k", float) = 1                   //镜面光权重

		_RoleReflectDiffWeight("reflect diff w", Range(0,3)) = 1
		_RoleReflectEnvWeight("reflect env w",Range(0,5)) = 0
		//_ReflectCubeTex("Reflect Tex",Cube) = "_Skybox" { }
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "Geometry+400"}
		LOD 1000
		
		CGPROGRAM


	#define QT_FOG_ON
	#define QT_ROLE_REFLECT_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass

		#pragma target 3.0

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			//ZEngine_ClipBlue;
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color;
			o.Alpha = 1;
			o.Specular = alpha.b;
			o.Gloss = alpha.r;
			//o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			o.Normal = ZEngine_Normale;
		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0; 

		#ifdef QT_ROLE_REFLECT_ON
			ReloReflectEnv_Vertex(v,data);
		#endif

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
		#ifdef QT_ROLE_REFLECT_ON
			ReloReflectEnv_Pixel(IN,o,color);
		#endif

		#ifdef QT_TEXILLUMIN_ON
			TexIllumin_Pixel(IN,o,color);
		#endif

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

	SubShader {
	Tags { "RenderType"="Opaque" "Queue" = "Geometry+400"}
	LOD 300
		
	CGPROGRAM


	//#define QT_FOG_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass

		#pragma target 3.0

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			//ZEngine_ClipBlue;
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color;
			o.Alpha = 1;
			o.Specular = alpha.b;
			o.Gloss = alpha.r;
			//o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			o.Normal = ZEngine_Normale;
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
