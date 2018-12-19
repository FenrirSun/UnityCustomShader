struct Input
	{
		
	#ifdef QT_T4M_ON
		fixed2 uv_Control;
		fixed2 uv_Splat0;
		//fixed2 uv_Splat1;
		//fixed2 uv_Splat2;
		//fixed2 uv_Splat3;
	#endif

	#ifdef QT_WARP_ON
		fixed4 grabUV;
	#endif

	#ifdef QT_UI_EDGE_LIGHT_ON
		//fixed3 _viewDir;
		fixed3 _worldNormal;
	#endif 

	#ifdef QT_FOG_ON
		fixed2 uv_MainTex; 
		fixed depthValue; //带深度的surface结构体，可以用于实现雾效等特殊效果
		float2 uv_QTBumpMap;
	#else
		fixed2 uv_MainTex; 
		float2 uv_QTBumpMap;
	#endif

	#ifdef QT_SIMPLE_WATER
		float2 uv_QTBumpMap2;
		float2 uv_QTBumpMap3;
		float2 uv_QTBumpMap4;
	#endif

	#ifdef QT_SIMPLE_RIVER
		float2 uv_QTBumpMap2;
		//float2 uv_QTBumpMap3;
	#endif

		//fixed4 color;
#ifdef QT_VERTEX_COLOR
		fixed4 vertexColor;
#endif

	#ifdef QT_SCENE_POINT_LIGHT_G0_ON
		fixed3 vlight;
	#endif

	#ifdef QT_SHADOW_ON
		fixed4 QT_ShadowUV_NL_Depth; //x,y 表示uv，z表示NL，w表示depth
	#endif
	#ifdef QT_ROLE_SHADOW_ON
			fixed4 QT_ShadowUV_NL_Depth; //x,y 表示uv，z表示NL，w表示depth
	#endif

	#ifdef QT_STATIC_REALTIME_LIGHT_ON
		//fixed3 LightMap_LightDir;
		fixed3 LightMap_ViewDir;

		half3 MeshNormal;
	#endif

	#ifdef QT_ROLE_REFLECT_ON
		fixed3 reflectCoord;
	#endif

	#ifdef QT_PLANE_REFLECT_ON
		//fixed2 mirrorUV;
		fixed3 worldPos;
	#endif

	#ifdef QT_TANK_SCAN
		fixed unitScanValue;
	#endif

	};