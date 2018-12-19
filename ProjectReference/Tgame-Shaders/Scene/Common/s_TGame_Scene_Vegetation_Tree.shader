Shader "TSHD/Vegetation/Vegetation_Tree" 
{
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}

        _Cutoff ("CutOut", Range(0,1)) = 0.5

        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
	  	_DiffMulti ("Diffuse Multipiler",Range(0,3)) = 1
		 
		 // KeyWork开关
		[MaterialToggle(USE_VERTEXANIM)] _UseVertexAnim("UseVertexAnim", Float) = 0
		
		// VertexAnim
		_VertAnim_Offset	("VertAnim_Offset"		, Range(0,2)) = 0.01
        _VertAnim_Speed 	("VertAnim_Speed"		, Range(0,10)) = 0
        _VertAnim_Frequency ("VertAnim_Frequency"	, Range(0,60)) = 0

		 //_Wind("Wind params（XZ for Direction,W for Weight Scale)",Vector) = (1,0.2,1,0.1)
   //     _WindEdgeFlutterFreqScale("Wind Freq Scale",float) = 0.1

		 // 
		 _FogVal ("Fog Density",Range(0,1)) =1.0
		 _OccAmount ("OCC (vertexColor.r)", Range(0,1)) = 0

		 _EmissionColor ("Emission Color", Color) = (1,1,1,1)
        _EmissionVal("Emi Mask(vertexColor.g)",Float) =0.0
		 
    }
   
    SubShader
    {

        Tags { "RenderType"="TransparentCutout" "Queue" = "AlphaTest" "IgnoreProjector"="True"} //Queue is nodig (anders fout)
        
        Cull [_Cull]
        
        LOD 200
        CGPROGRAM
        
        // 需要一个addShader 来正确的渲染CutOut后的阴影
		//#pragma surface surf LambertBump alphatest:_Cutoff vertex:vert_veg finalcolor:fogColor exclude_path:deferred  exclude_path:prepass nometa  noforwardadd addshadow nofog
        #pragma surface surf Lambert alphatest:_Cutoff vertex:vert_veg finalcolor:fogColor exclude_path:deferred  exclude_path:prepass nometa  noforwardadd addshadow //nofog
		//#pragma target 2.0
				//#pragma multi_compile _ LOD_FADE_CROSSFADE
        #pragma multi_compile __ USE_VERTEXANIM
        #pragma multi_compile_fog

		fixed _DiffMulti,_AmbScale,_FogVal,_WindEdgeFlutterFreqScale;

        fixed4 _Color,_EmissionColor;
        sampler2D _MainTex;
            
        //fixed _lightmapRemove;
		 //float4 _Wind;

        //sampler2D _MatCap;
        fixed _OccAmount,_EmissionVal,_EmiAmount;
        
        struct Input
		{
			fixed2 uv_MainTex;
			//half fog; 
			float fogCoord : TEXCOORD5;
			half occ;
			//fixed2 matcapUV;
			half3 emiCol;
		};

        fixed _VertAnim_Offset;
        fixed _VertAnim_Speed;
        fixed _VertAnim_Frequency;
      
	
        void vert_veg (inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input,o);
            #ifdef USE_VERTEXANIM
				// Wave 1
				float3 winDirection = float3(1,0.5,0.5);
				v.vertex.xyz += normalize(winDirection+v.normal) * v.color.g * sin((( v.color.b * 3.141592654)+ _Time))*0.08;// * _GlobalWindAmount;
				v.vertex.x += sin((v.vertex.y + _Time * _VertAnim_Speed) * _VertAnim_Frequency) * _VertAnim_Offset * v.color.a;// * _GlobalWindAmount;

			#endif

	    	float4 pos = UnityObjectToClipPos (v.vertex);
			UNITY_TRANSFER_FOG(o, pos);

			o.occ =lerp(1,(1 - v.color.r),_OccAmount);
			o.emiCol = v.color.g* _EmissionColor.rgb *_EmissionVal;
    	}   

	void fogColor(Input IN, SurfaceOutput o, inout fixed4 color)
        {
		#if defined(FOG_LINEAR) ||defined(FOG_EXP)|| defined(FOG_EXP2)
            #ifdef UNITY_PASS_FORWARDADD
                color.rgb = lerp(fixed3(0,0,0), (color).rgb, saturate(IN.fogCoord));
            #else
		        fixed3 orCol =color.rgb;
				UNITY_APPLY_FOG(IN.fogCoord, color);
		        color.rgb = lerp(orCol,color.rgb,_FogVal);
            #endif
		#endif
        }


        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c	= tex2D(_MainTex, IN.uv_MainTex) * _Color;
            //fixed4 mc 	= tex2D	(_MatCap, IN.matcapUV); 
            
            fixed4 final = c ;

			 o.Albedo = final.rgb* IN.occ;
			 o.Albedo +=final.rgb *IN.emiCol;
			 o.Albedo = lerp(o.Albedo,o.Albedo *UNITY_LIGHTMODEL_AMBIENT,_AmbScale)*_DiffMulti;
   
            o.Alpha = c.a;    
                 
        }           
        ENDCG  
    }
    FallBack "Mobile/VertexLit"
}




