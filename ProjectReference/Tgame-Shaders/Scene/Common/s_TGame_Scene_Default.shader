Shader "TSHD/Scene/Default" 
{
	Properties 
	{
		_Color ("Color", Color) = (0.5,0.5,0.5,1.0)
	  	_MainTex ("Diff(RGB)", 2D) 	= "white" {}

		// CullMode
    	[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
    	_FogVal ("Fog Density",Range(0,1)) =1.0
	}

	SubShader 
	{
	    Tags { "RenderType" = "Opaque" }

	    LOD 150
	   	Cull [_Cull]

		CGPROGRAM
		//#pragma surface surf Lambert noforwardadd exclude_path:deferred exclude_path:prepass
		#pragma surface surf Lambert  vertex:vert finalcolor:fogColor  exclude_path:deferred  exclude_path:prepass nofog  
		#pragma target 2.0
		#pragma multi_compile_fog

    	// Basic
		fixed4 _Color;
		sampler2D _MainTex;

		fixed _AmbScale;
		
		fixed _FogVal,_FogHeiParaZ,_FogHeiParaW,_FogHeiGlobalScale;

		struct Input
		{
			fixed2 uv_MainTex;
			fixed4 color : Color; 
			float2 fogCoord : TEXCOORD5;
		};

		void vert(inout appdata_full v, out Input data)
		{
			UNITY_INITIALIZE_OUTPUT(Input, data);
			float4 pos = UnityObjectToClipPos (v.vertex);
			float4 worldPos =mul(unity_ObjectToWorld,v.vertex);
			UNITY_TRANSFER_FOG(data, pos);
			data.fogCoord.y =saturate(worldPos.y  *_FogHeiParaZ +_FogHeiParaW);
		}

		void fogColor(Input IN, SurfaceOutput  o, inout fixed4 color)
		{
		#if defined(FOG_LINEAR) ||defined(FOG_EXP)|| defined(FOG_EXP2)
            #ifdef UNITY_PASS_FORWARDADD
                color.rgb = lerp(fixed3(0,0,0), (color).rgb, saturate(IN.fogCoord.x));
            #else
				fixed3 orCol =color.rgb;
				UNITY_APPLY_FOG(IN.fogCoord, color);
		        color.rgb = lerp(orCol,color.rgb,_FogVal);
				fixed3 HeiFog =lerp(unity_FogColor,color.rgb,IN.fogCoord.y); //Height Fog
				color.rgb =lerp(color.rgb,HeiFog,_FogHeiGlobalScale);//Height Fog Density
            #endif
		#endif
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			// Diffuse
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color ;
			o.Albedo = lerp(c.rgb,c.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
			o.Alpha = c.a;

		}
		ENDCG
	}
	Fallback "Mobile/VertexLit"
}