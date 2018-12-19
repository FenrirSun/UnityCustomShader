//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_OFF</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON;QT_SCENE_POINT_LIGHT_G0_ON</Exclude Keyword>
Shader "T4MShaders/ShaderModel2/Diffuse/T4M 4 Textures Bigmap" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_QTBumpMap("Normalmap", 2D) = "bump" {}
		_QTDetailBumpMap("Normalmap", 2D) = "bump" {}
		_Splat0 ("Layer 1", 2D) = "white" {}
		_Splat1 ("Layer 2", 2D) = "white" {}
		_Splat2 ("Layer 3", 2D) = "white" {}
		_Splat3 ("Layer 4", 2D) = "white" {}
		_Control ("Control (RGBA)", 2D) = "white" {}
		_VertexScale("Vertex Color Scale", Range(1,2)) = 1

		LightMap_RealHighLightScale("Real High Light Scale", float) = 0
		BlinnPhong_Shininess("Shininess", Vector) = (1,1,1,1)
		LightMap_AdjustDiff("LightMap_AdjustDiff", Range(0,2)) = 0
		DetailNormalScale("Detail Normal Scale", Vector) = (0,0,0,0)
	}
	//单pass渲染  
	SubShader {
		Tags {
		"SplatCount" = "4"
	   "RenderType" = "Opaque"
	   "Queue" = "Geometry+300"
	   "ForceNoShadowCasting"="True"
		}
		LOD 800

	CGPROGRAM

//*#ifqtdef editor
	#define QT_FOG_ON
	#define QT_VERTEX_COLOR
	#define QT_T4M_ON
	//#define QT_STATIC_REALTIME_LIGHT_ON
	#define QT_SHADOW_OFF
	#define QT_LM_DETAIL_NORMAL_OFF
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
	#pragma multi_compile QT_SCENE_POINT_LIGHT_G0_OFF QT_SCENE_POINT_LIGHT_G0_ON
	//#pragma multi_compile QT_SHADOW_ON QT_SHADOW_OFF
	//#pragma multi_compile QT_LM_DETAIL_NORMAL_ON QT_LM_DETAIL_NORMAL_OFF
	#pragma target 3.0
			

	sampler2D _Control;
	sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
	sampler2D _QTDetailBumpMap;
	fixed _VertexScale;

	void surf (Input IN, inout SurfaceOutput o) {
		//采样控制图
		fixed4 splat_control = tex2D(_Control, IN.uv_Control).rgba;
		
#ifdef QT_LM_DETAIL_NORMAL_ON
		//细节法线采样
		fixed2 nuv0 = frac(IN.uv_Splat0) * 0.5;
		fixed3 lay0B = UnpackNormal(tex2D(_QTDetailBumpMap, nuv0));

		fixed2 nuv1 = frac(IN.uv_Splat0) * 0.5;
		nuv1.x += 0.5;
		fixed3 lay1B = UnpackNormal(tex2D(_QTDetailBumpMap, nuv1));

		fixed2 nuv2 = frac(IN.uv_Splat0) * 0.5;
		nuv2.y += 0.5;
		fixed3 lay2B = UnpackNormal(tex2D(_QTDetailBumpMap, nuv2));

		fixed2 nuv3 = frac(IN.uv_Splat0) * 0.5;
		nuv3 += 0.5;
		fixed3 lay3B = UnpackNormal(tex2D(_QTDetailBumpMap, nuv3));
		//细节法线合并
		fixed3 dn = (lay0B * splat_control.r * DetailNormalScale.x + lay1B * splat_control.g * DetailNormalScale.y + lay2B * splat_control.b * DetailNormalScale.z + lay3B * splat_control.a * DetailNormalScale.w);
		//法线和细节法线合并
		fixed3 t_projN = n;
		t_projN.y = 0;
		t_projN = normalize(t_projN);  //法线的平面投影

		fixed3 t_binormal = normalize(cross(fixed3(0, 1, 0), t_projN));
		fixed3 t_tan = normalize(cross(t_binormal, fixed3(0, 1, 0)));

		float4x4 detailMat = float4x4
			(t_binormal.x, 0, t_tan.x, 0,
				t_binormal.y, 1, t_tan.y, 0,
				t_binormal.z, 0, t_tan.z, 0,
				0, 0, 0, 1);

		fixed3 detailOffset = mul(detailMat, float4(dn,1)).xyz;
		fixed3 finalNormal = n + detailOffset;
		//fixed3 finalNormal = fixed3(n.x + dn.x, n.y + dn.y, n.z + dn.z);
		o.Normal = normalize(finalNormal);
#endif
#ifdef QT_STATIC_REALTIME_LIGHT_ON
		
		//采样法线贴图
		fixed4 tranSpaceNormal = tex2D(_QTBumpMap, IN.uv_Control);

		//解压法线
		fixed3 n = UnpackNormal(tranSpaceNormal);

		//发光系数
		Lightmap_finalShininess = BlinnPhong_Shininess.x * splat_control.r + BlinnPhong_Shininess.y * splat_control.g + BlinnPhong_Shininess.z * splat_control.b + BlinnPhong_Shininess.w * splat_control.a;
		
		o.Normal = normalize(n);
#endif
		//颜色采样
		fixed4 lay1 = tex2D(_Splat0, IN.uv_Splat0);
		fixed4 lay2 = tex2D(_Splat1, IN.uv_Splat0);
		fixed4 lay3 = tex2D(_Splat2, IN.uv_Splat0);
		fixed4 lay4 = tex2D(_Splat3, IN.uv_Splat0);
		
		//颜色合并
		fixed4 fc = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay4 * splat_control.a);

		//最终颜色
		o.Albedo = fc.rgb * _Color.rgb * IN.vertexColor.rgb * _VertexScale;
		//镜面强度
		o.Specular = fc.a;

		o.Alpha = 1;

		//o.Albedo.rgb = detailOffset;// o.Normal;// float3(tex2D(_QTBumpMap, nuv1).ba,0); 
	}

	//顶点处理
	void YHVertex(inout appdata_full v, out Input data)
	{
		data = (Input)0; 

		data.vertexColor.rgb = v.color.rgb;

	#ifdef QT_SHADOW_ON
		Shadow_Vertex(v,data);
	#endif

	#ifdef QT_STATIC_REALTIME_LIGHT_ON
		//#ifdef LIGHTMAP_ON
		StaticRealtimeLight_Vertex(v, data);
		//#endif
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
		//#if LIGHTMAP_ON
			StaticRealtimeLight_Pixel(IN, o, color);
		//#endif
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
		
		//color.rgb = (o.Normal + 1) * 0.5;
		//color.a = 1;
		//最终颜色处理
		color = FinalColor(color);

	//	fixed4 lay3 = tex2D(_Splat2, IN.uv_Splat0);
	//	color.rgb = tex2D(_Control,IN.uv_Control).b * lay3.rgb;

	//	color.a = 1;
	}

	ENDCG 
	}



	//低端版shader
	SubShader{
		Tags{
		"SplatCount" = "4"
		"RenderType" = "Opaque"
		"Queue" = "Geometry+300"
		"ForceNoShadowCasting" = "True"
	}
		LOD 300

		CGPROGRAM

#define QT_VERTEX_COLOR
#define QT_T4M_ON
#define QT_SHADOW_OFF
#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
#pragma target 3.0


		sampler2D _Control;
	sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
	fixed _VertexScale;

	void surf(Input IN, inout SurfaceOutput o) {

		//采样控制图
		fixed4 splat_control = tex2D(_Control, IN.uv_Control).rgba;
		//采样法线贴图
		//fixed4 tranSpaceNormal = tex2D(_QTBumpMap, IN.uv_Control);

		//颜色采样
		fixed4 lay1 = tex2D(_Splat0, IN.uv_Splat0);
		fixed4 lay2 = tex2D(_Splat1, IN.uv_Splat0);
		fixed4 lay3 = tex2D(_Splat2, IN.uv_Splat0);
		fixed4 lay4 = tex2D(_Splat3, IN.uv_Splat0);

		//颜色合并
		fixed4 fc = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay4 * splat_control.a);

		//最终颜色
		o.Albedo = fc.rgb * _Color.rgb * IN.vertexColor.rgb * _VertexScale;

		o.Alpha = 1;
	}

	//顶点处理
	void YHVertex(inout appdata_full v, out Input data)
	{
		data = (Input)0;

		data.vertexColor.rgb = v.color.rgb;
	}

	//像素处理
	void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
	{
		//最终颜色处理
		color = FinalColor(color);
	}

	ENDCG
	}
}



