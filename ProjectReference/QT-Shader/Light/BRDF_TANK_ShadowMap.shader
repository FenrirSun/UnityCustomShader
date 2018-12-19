//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_TEXILLUMIN_ON;QT_FLUX_ON</Exclude Keyword>

Shader "TS_QT/Light/BRDF_TANK_ShadowMap" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_QTBumpMap("Normalmap", 2D) = "bump" {}
		_AlphaTex ("Alpha Texture", 2D) = "white"{}     //r:反射贴图 g:漫反射贴图 b: 高光贴图
		_BRDFMap ("BRDF",2D) = "white"{}
		//_MaskMap("Mask",2D) = "white"{}
		//_CoatMap("Coat Map",2D) = "black"{}
		//v_inc("v_inc", float) = 0.3          //履带滚动
		BRDF_k1("diff k", float) = 0.3          //漫射光权重
		BRDF_k2("spec k", float) = 1                   //镜面光权重
		_pow("Specular Pow", float) = 1  //对高光图求幂数
		//coatWeight("coat weight",float) = 1    //涂装纹理强度
		//coatScale("coat Scale",float) = 1  //涂装缩放
		//TankWheelSpeed("wheel speed",float) = 0   //履带速度
		shadowAlpha("Shadow Brightness",float) = 0.3 //和BRDF的明暗交界线保持统一
		bias("bias", float) = 0.005  //阴影计算偏移值，建议在0.002~0.01之间
		diffBias("diff bias",float) = 0.1  //

		_RoleReflectDiffWeight("reflect diff w", Range(0,10)) = 1
		_RoleReflectEnvWeight("reflect env w",Range(0,5)) = 0
		//_ReflectCubeTex("Reflect Tex",Cube) = "_Skybox" { }
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "Geometry+400"}
		LOD 1000
		
		CGPROGRAM

//*#ifqtdef editor
	#define QT_FOG_ON
	#define QT_VERTEX_COLOR
	//#define QT_ROLE_REFLECT_OFF
	//#define QT_TANK_WHEEL
	//#define QT_ROLE_SHADOW_OFF
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
	#pragma multi_compile QT_ROLE_SHADOW_ON QT_ROLE_SHADOW_OFF
	#pragma multi_compile QT_TANK_WHEEL QT_TANK_WHEEL_OFF
//endqtdef*/


		#pragma target 3.0

		//uv坐标，v增量，用于履带滚动
		fixed v_inc;
		//fixed coatWeight;
		//fixed coatScale;
		fixed _pow;

		//float4 _QTBumpMap_ST;

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

			o.Alpha = 1;
			//o.Specular = alpha.b;
			o.Gloss = alpha.r;///saturate((alpha.b - 0.5) * 2);

			//fixed2 nromalCoord = TRANSFORM_TEX(IN.uv_MainTex, _QTBumpMap);
#ifdef TANK_NORMAL
			o.Normal = alpha.a * UnpackNormal(tex2D(_QTBumpMap, IN.uv_QTBumpMap)) + (1-alpha.a) * ZEngine_Normale;
#endif
			//o.Normal = UnpackNormal(tex2D(_QTBumpMap, IN.uv_QTBumpMap));

			//o.Albedo = tex2D(_QTBumpMap, IN.uv_QTBumpMap);
		/*	if (alpha.a > 0.1)
			{
				o.Normal = UnpackNormal(tex2D(_QTBumpMap, nromalCoord));
			}
			else
			{
				o.Normal = ZEngine_Normale;
			}*/
		//	o.Normal = ZEngine_Normale;


#ifdef QT_ROLE_SHADOW_ON
			QT_ShadowUV_NL_Depth = IN.QT_ShadowUV_NL_Depth; //x,y 表示uv，z表示NL，w表示depth
#endif
//#ifdef QT_ROLE_SHADOW_ON
//			fixed shadowLight = Shadow_Light(IN, o);
//			o.Specular = pow(alpha.b, _pow) + shadowLight * -2;
//		//	o.Albedo = shadowLight;
//			//o.Specular = Shadow_Light(IN, o);
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
		#else
			ReloReflectEnv_Pixel(color);
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
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry+400" }
		LOD 300

		CGPROGRAM

		//*#ifqtdef editor
//#define QT_FOG_ON
#define QT_VERTEX_COLOR
//#define QT_ROLE_REFLECT_ON
#define QT_TANK_WHEEL
#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
#pragma target 3.0

		//uv坐标，v增量，用于履带滚动
		fixed v_inc;

	fixed _pow;

	void surf(Input IN, inout SurfaceOutput o) {

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
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
		o.Albedo = c.rgb * _Color * alpha.g;

		o.Alpha = 1;
		o.Gloss = alpha.r;

		o.Normal = alpha.a * UnpackNormal(tex2D(_QTBumpMap, IN.uv_QTBumpMap)) + (1 - alpha.a) * ZEngine_Normale;

		o.Specular = pow(alpha.b, _pow);
	}

	//顶点处理
	void YHVertex(inout appdata_full v, out Input data)
	{
		data = (Input)0;

#ifdef QT_TANK_WHEEL
		data.vertexColor = v.color;
#endif



	}

	//像素处理
	void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
	{
		ReloReflectEnv_Pixel(color);

		//最终颜色处理
		color = FinalColor(color);
		//color = fixed4(1, 0, 0, 1);
	}

	ENDCG

	}

Fallback Off
}
