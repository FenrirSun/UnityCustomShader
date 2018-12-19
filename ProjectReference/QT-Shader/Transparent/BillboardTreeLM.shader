Shader "TS_QT/Transparent/Cutout/BillboardTreeLM" {
		Properties{
			_Color("Main Color", Color) = (1,1,1,1)
			_MainTex("Base (RGB)", 2D) = "white" {}
			_AlphaTex("Alpha Texture", 2D) = "white"{}
			_Intensite("Intensite",float) = 1
			_Cutoff("Alpha cutoff", Range(0,1)) = 0.1
			tree_WindScale("Wind Scale",float) = 1

		}
			SubShader{
			//	Tags {"RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="True"}
			Tags{ "RenderType" = "Opaque" "Queue" = "Geometry+250"  "IgnoreProjector" = "True" }
			//	Tags { "Queue"="Geometry" "IgnoreProjector"="True" "RenderType"="Opaque" }
			//Blend SrcAlpha OneMinusSrcAlpha
			ZTest On
			ZWrite On
			LOD 200
			//Cull Off

			CGPROGRAM
#define QT_FOG_ON
#define QT_VERTEX_COLOR
#define QT_BILLBOARD_TREE_WIND_ON
//#define QT_BILLBOARD_TREE_ON
//#define QT_STATIC_REALTIME_LIGHT_ON
//#define QT_WIND_ON
#include "Assets/Resources/QTShader/QTShaderLib.cginc"
			//	#pragma surface surf QT_Lambert noforwardadd finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
#pragma surface surf QT_Lambert noforwardadd noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
#pragma multi_compile QT_SCENE_POINT_LIGHT_G0_OFF QT_SCENE_POINT_LIGHT_G0_ON
#pragma multi_compile QT_BILLBOARD_TREE_ON QT_BILLBOARD_TREE_OFF
#pragma multi_compile QT_WIND_ON QT_WIND_OFF
#pragma target 3.0

			fixed _Intensite;

			void surf(Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			ZEngine_Clip;
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
//#ifdef QT_BILLBOARD_TREE_ON
			o.Albedo = c.rgb * _Color * IN.vertexColor.rgb * _Intensite;
//#else
			/*o.Albedo = c.rgb * _Color;
#endif*/
			//o.Normal = ZEngine_Normale;
			//TanSpaceNormal = o.Normal;
		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0;

//#ifdef QT_SHADOW_ON
//			Shadow_Vertex(v,data);
//#endif
			data.vertexColor.rgb = v.color.rgb;

#ifdef QT_BILLBOARD_TREE_ON
			BillboardTree_Vertex(v, data);
#endif

#ifdef QT_WIND_ON
#ifdef QT_BILLBOARD_TREE_WIND_ON
			BillboardTreeWind_Vertex(v, data);
#endif
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
