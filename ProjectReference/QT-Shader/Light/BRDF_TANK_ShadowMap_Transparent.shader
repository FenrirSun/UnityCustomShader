//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_TEXILLUMIN_ON;QT_FLUX_ON</Exclude Keyword>

Shader "TS_QT/Light/BRDF_TANK_ShadowMap_Transparent" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaTex ("Alpha Texture", 2D) = "white"{}     //r:反射贴图 g:漫反射贴图 b: 高光贴图
		_BRDFMap ("BRDF",2D) = "white"{}
	
		BRDF_k1("diff k", float) = 0.3          //漫射光权重
		BRDF_k2("spec k", float) = 1                   //镜面光权重
		_pow("Specular Pow", float) = 1  //对高光图求幂数

		shadowAlpha("Shadow Brightness",float) = 0.3 //和BRDF的明暗交界线保持统一
		bias("bias", float) = 0.005  //阴影计算偏移值，建议在0.002~0.01之间

		_RoleReflectDiffWeight("reflect diff w", Range(0,10)) = 1
		_RoleReflectEnvWeight("reflect env w",Range(0,5)) = 0
		specEnhanceOqapue("Spec Enhance Oqapue", Range(0,1)) = 0
		//_ReflectCubeTex("Reflect Tex",Cube) = "_Skybox" { }
	}
	SubShader {
			Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
			LOD 1000
			Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM

	#define QT_FOG_ON
	#define QT_VERTEX_COLOR
	//#define QT_ROLE_REFLECT_ON
	#define QT_TANK_WHEEL
	//#define QT_ROLE_SHADOW_OFF
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow alpha nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
	#pragma multi_compile QT_ROLE_SHADOW_ON QT_ROLE_SHADOW_OFF

		#pragma target 3.0

		//uv坐标，v增量，用于履带滚动
		fixed v_inc;
		//fixed coatWeight;
		//fixed coatScale;
		fixed _pow;

		void surf (Input IN, inout SurfaceOutput o) {
			
			#ifdef QT_TANK_WHEEL
			fixed wheelCoe = saturate(-(IN.vertexColor.r - 0.99));
			fixed wheelV = (IN.uv_MainTex.y + v_inc);
			//fixed signCoe = sign(wheelV);
			wheelV = sign(wheelV) * fmod(wheelV, 0.125);
			wheelV = wheelV - IN.uv_MainTex.y;
			IN.uv_MainTex.y += wheelV * wheelCoe;
			#endif

			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			//ZEngine_ClipBlue;
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			//fixed4 mask = tex2D(_MaskMap, IN.uv_MainTex);
			//fixed4 coat = tex2D(_CoatMap, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color * alpha.g;

			//o.Albedo = (1 - coat.a * (mask.r * coatScale)) * o.Albedo + coat.a * coat.rgb * (mask.r * coatScale) * coatWeight;

			//fixed coatFlag = saturate(sign(mask.r - 0.001));
			//o.Albedo = coatFlag * (mask.r * coat.a * coat.rgb * coatWeight + (1-coat.a)* o.Albedo) + (1 - coatFlag) * o.Albedo;

			o.Alpha = c.a;
			//o.Specular = alpha.b;
			o.Gloss = alpha.r;///saturate((alpha.b - 0.5) * 2);
			//o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			o.Normal = ZEngine_Normale;


#ifdef QT_ROLE_SHADOW_ON
			QT_ShadowUV_NL_Depth = IN.QT_ShadowUV_NL_Depth;
#endif
			//fixed shadowLight = Shadow_Light(IN, o);
			//o.Specular = pow(alpha.b, _pow) + shadowLight * -2;
		//	o.Albedo = shadowLight;
			//o.Specular = Shadow_Light(IN, o);
//#else
			o.Specular = pow(alpha.b, _pow);
//#endif
			
			//o.Alpha = IN.uv_MainTex.y;
		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0; 

		#ifdef QT_TANK_WHEEL
			data.vertexColor = v.color;
			//TankWheel_Vertex(v,data);
		#endif

		#ifdef QT_ROLE_REFLECT_ON
		ReloReflectEnv_Vertex(v,data);
		#endif

		#ifdef QT_ROLE_SHADOW_ON
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

		//#ifdef QT_SHADOW_ON
		//	Shadow_Pixel(IN,o,color);
		//#endif

		#ifdef QT_FOG_ON
			Fog_Pixel(IN,o,color);
		#endif
		
			//最终颜色处理
			color = FinalColor(color);
			//color.r = o.Alpha * 8;
			//color.gb = 0;
			//color.a = 1;
		}

		ENDCG
		
	} 


	SubShader{
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 300
		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM

//#define QT_FOG_ON
//#define QT_VERTEX_COLOR
//#define QT_ROLE_REFLECT_ON
//#define QT_TANK_WHEEL
#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_BRDF noforwardadd nometa noshadow alpha nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
//#pragma multi_compile QT_ROLE_SHADOW_ON QT_ROLE_SHADOW_OFF

#pragma target 3.0

		//uv坐标，v增量，用于履带滚动
		fixed v_inc;
	//fixed coatWeight;
	//fixed coatScale;
	fixed _pow;

	void surf(Input IN, inout SurfaceOutput o) {

		fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
		o.Albedo = c.rgb * _Color * alpha.g;

		o.Alpha = c.a;
		o.Gloss = alpha.r;
		o.Normal = ZEngine_Normale;

		o.Specular = pow(alpha.b, _pow);
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
