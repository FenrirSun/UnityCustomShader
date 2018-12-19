// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

///Upadat 18.2.11:Add Spe After Baking LM
Shader "TSHD/Scene/Wet/T4M 3Tex3Bump_Amb" {
Properties {
    //_AmbScale ("Ambient Color", Range (0.0, 1)) = 0
	[MaterialToggle(USE_LMBUMP)] _UseLMBump("Use LightMap Bump", Float) = 0
 //   _NorFactor("Baked Normal Factor",Range(0,1)) =0.8
	//_lightmapRemove ("Lightmap Remove", Range(0,1)) = 0
	_FogVal ("Fog Density",Range(0,1)) =1.0
	_Splat0 ("Layer 1 (R)", 2D) = "Black" {}
	_Splat1 ("Layer 2 (G)", 2D) = "Black" {}
    _Splat2 ("Layer 3 (B)", 2D) = "Black" {}
    //_Splat3 ("Layer 4 (A)", 2D) = "white" {}
	_BumpL0 ("Layer1 Bump", Range (0.0, 3)) = 1
    _BumpSplat0 ("Layer1Normalmap", 2D) = "bump" {}
	_BumpL1 ("Layer2 Bump", Range (0.0, 3)) = 1
	_BumpSplat1 ("Layer2Normalmap", 2D) = "bump" {}
	_BumpL2 ("Layer3 Bump", Range (0.0, 3)) = 1
    _BumpSplat2 ("Layer3Normalmap", 2D) = "bump" {}
    //_BumpSplat3 ("Layer4Normalmap", 2D) = "bump" {}
    _Tiling1("Layer1:xy,Layer2:zw", Vector)=(1,1,0,0)
    _Tiling2("Layer3:xy,Layer4:zw", Vector)=(1,1,0,0)
	_Control ("Control (RGBA)", 2D) = "white" {}

	_EmissionColor ("Emission Color", Color) = (1,1,1,1)
    _EmissionVal("Emi Mask(vertexColor.g)",Float) =0.0


	[HideInInspector]_MainTex ("Never Used", 2D) = "white" {}
} 

CGINCLUDE
    sampler2D _Control,_RefMap,_ReflectionTex;
    sampler2D _BumpSplat0, _BumpSplat1, _BumpSplat2;
    sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
    fixed4 _ReflectColor,_WetColor,_EmissionColor;
    fixed _AmbScale,_RefFluseVal,_EmissionVal;
	fixed _FogVal,_FogHeiParaZ,_FogHeiParaW,_FogHeiGlobalScale;
    fixed _BumpL0;
    fixed _BumpL1;
    fixed _BumpL2;

    float4 _Tiling2, _Tiling1;
ENDCG

SubShader {
    Lod 300
	Tags {
		"SplatCount" = "4"
		//"Queue" = "Geometry-100"
		"Queue" = "Geometry"
		"RenderType" = "Opaque"
	}
    CGPROGRAM
    #pragma surface surf Lambert  vertex:vert finalcolor:fogColor  exclude_path:deferred  exclude_path:prepass nometa nofog
    #pragma target 3.0
    #include "UnityCG.cginc"
	//#include "T4MAddSpe.cginc"

	#pragma multi_compile __ USE_LMBUMP
	#pragma multi_compile_fog

    struct Input {
	    float2 uv_Control : TEXCOORD0;
		half3 emiCol;
		float2 fogCoord : TEXCOORD5;
    };


        void vert (inout appdata_full v,out Input o) {
    
            UNITY_INITIALIZE_OUTPUT(Input,o);
			o.emiCol = v.color.g* _EmissionColor.rgb *_EmissionVal;

			float4 pos = UnityObjectToClipPos (v.vertex);
			float4 worldPos =mul(unity_ObjectToWorld,v.vertex);
			UNITY_TRANSFER_FOG(o, pos);
			o.fogCoord.y =saturate(worldPos.y  *_FogHeiParaZ +_FogHeiParaW);
        }
		void fogColor(Input IN, SurfaceOutput o, inout fixed4 color)
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

        void surf (Input IN, inout SurfaceOutput o) {
	        half4 splat_control = tex2D (_Control, IN.uv_Control);
	        half3 col;
            //half3 orNor =IN.worldNormal;
	        half4 splat0 = tex2D (_Splat0, IN.uv_Control *_Tiling1.xy);
	        half4 splat1 = tex2D (_Splat1, IN.uv_Control *_Tiling1.zw);
            half4 splat2 = tex2D (_Splat2, IN.uv_Control *_Tiling2.xy);
            //half4 splat3 = tex2D (_Splat3, IN.uv_Control *_Tiling2.zw);

	        col  = splat_control.r * splat0.rgb;
            o.Gloss = splat0.a * splat_control.r ;

            col += splat_control.g * splat1.rgb;
	        o.Gloss += splat1.a * splat_control.g;
	
            col += splat_control.b * splat2.rgb;
			o.Gloss += splat2.a * splat_control.b;
			#ifdef USE_LMBUMP
				o.Normal =half3(0,0,0);
				o.Normal += splat_control.r * UnpackScaleNormal(tex2D(_BumpSplat0, IN.uv_Control *_Tiling1.xy),_BumpL0);
				o.Normal += splat_control.g * UnpackScaleNormal(tex2D(_BumpSplat1, IN.uv_Control *_Tiling1.zw),_BumpL1);
				o.Normal += splat_control.b * UnpackScaleNormal(tex2D(_BumpSplat2, IN.uv_Control *_Tiling2.xy),_BumpL2);
			#endif 

            //col += splat_control.a * splat3.rgb;
            //o.Normal += splat_control.a * UnpackNormal(tex2D(_BumpSplat3, IN.uv_Control *_Tiling2.zw));
            //o.Gloss += splat3.a * splat_control.a;
            //o.Specular += _ShininessL3 * splat_control.a; 
            
            o.Albedo =col.rgb ;
			o.Albedo +=col.rgb *IN.emiCol;
			o.Albedo = lerp(o.Albedo,o.Albedo*UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
            }
        ENDCG  
        }

    SubShader {
    Lod 200
	Tags {
		"SplatCount" = "4"
		"Queue" = "Geometry-100"
		"RenderType" = "Opaque"
	}
    CGPROGRAM
    #pragma surface surf Lambert  exclude_path:deferred  exclude_path:prepass nometa noforwardadd novertexlights noambient 
    #pragma target 2.0
    #include "UnityCG.cginc"

    struct Input {
	    float2 uv_Control : TEXCOORD0;
    };

    void surf (Input IN, inout SurfaceOutput o) {
	    half4 splat_control = tex2D (_Control, IN.uv_Control);
	    half3 col;
	    half4 splat0 = tex2D (_Splat0, IN.uv_Control *_Tiling1.xy);
	    half4 splat1 = tex2D (_Splat1, IN.uv_Control *_Tiling1.zw);
        half4 splat2 = tex2D (_Splat2, IN.uv_Control *_Tiling2.xy);
        //half4 splat3 = tex2D (_Splat3, IN.uv_Control *_Tiling2.zw);

	    col  = splat_control.r * splat0.rgb;
        col += splat_control.g * splat1.rgb;
        col += splat_control.b * splat2.rgb;
        //col += splat_control.a * splat3.rgb;

	    o.Albedo = lerp(col.rgb,col.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	    o.Alpha = 0.0;
        }
    ENDCG  
    }

    FallBack "Mobile/VertexLit"
}
