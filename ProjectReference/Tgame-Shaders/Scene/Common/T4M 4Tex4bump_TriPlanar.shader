// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

///Upadat 18.2.11:Add Spe After Baking LM
Shader "TSHD/Scene/Wet/T4M 4Tex4Bump_TriPlanar" {
Properties {
    //_AmbScale ("Ambient Color", Range (0.0, 1)) = 0  
	_SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
	_TexPower("TriPlannar Blending Power", Range(1, 20.0)) = 10.0
    //[MaterialToggle(_TRIPLANAR12)] _TriPlanar12("Layers12 TriPlannar", Float) = 0
	[MaterialToggle(_TRIPLANAR34)] _TriPlanar34("Layers34 TriPlannar", Float) = 0
	_ShininessL0 ("Layer1Shininess", Range (0.03, 1)) = 0.2
	_Splat0 ("Layer 1 (R)", 2D) = "white" {}
	_ShininessL1 ("Layer2Shininess", Range (0.03, 1)) = 0.2
	_Splat1 ("Layer 2 (G)", 2D) = "white" {}
	_ShininessL2 ("Layer3Shininess", Range (0.03, 1)) = 0.2
	_Splat2 ("Layer 3 (B)", 2D) = "white" {}
	_ShininessL3 ("Layer4Shininess", Range (0.03, 1)) = 0.2
	_Splat3 ("Layer 4 (A)", 2D) = "white" {}
    _BumpSplat0 ("Layer1Normalmap", 2D) = "bump" {}
	_BumpSplat1 ("Layer2Normalmap", 2D) = "bump" {}
	_BumpSplat2 ("Layer3Normalmap", 2D) = "bump" {}
	_BumpSplat3 ("Layer4Normalmap", 2D) = "bump" {}
    _Tiling1("Layer1:xy,Layer2:zw", Vector)=(1,1,1,1)
	_Tiling2("Layer3:xy,Layer4:zw", Vector)=(1,1,1,1)
	_Control ("Control (RGBA)", 2D) = "white" {}
    //_RefMap ("Reflection Map(R for Refletion Mask)",2D) = "white" {}
    //_WetColor ("Wet Area Color", Color) = (0.2, 0.2,0.2, 1)
    ////_RefLerp("Reflect Lerp",Range(0,1))=0.0
    //_ReflectVal("Reflect Value",Range(0,1)) = 0.5
    //_RefFluseVal("Reflect Distortion",Range(0,1)) =0.8
    //[HideInInspector] _ReflectionTex ("Reflection", 2D) = "black" { }

	[HideInInspector]_MainTex ("Never Used", 2D) = "white" {}
} 

CGINCLUDE
    sampler2D _Control,_RefMap,_ReflectionTex;
    sampler2D _BumpSplat0, _BumpSplat1, _BumpSplat2, _BumpSplat3;
    sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
    //fixed4 _ReflectColor,_WetColor;
    fixed _AmbScale,_ReflectVal,_RefLerp,_RefFluseVal,_TexPower;
    fixed _ShininessL0;
    fixed _ShininessL1;
    fixed _ShininessL2;
    fixed _ShininessL3;
    float4 _Tiling2, _Tiling1;
ENDCG

SubShader {
    Lod 300
	Tags {
		"SplatCount" = "4"
		//"Queue" = "Geometry-100"
		"Queue" = "Geometry+100"
		"RenderType" = "Opaque"
	}
    CGPROGRAM
	//dont support poitligh shadow for compatication, forwardadd  for poit Lighting
    #pragma surface surf BlinnPhong  vertex:vert exclude_path:deferred  exclude_path:prepass  //fullforwardshadows noforwardadd 
    #pragma target 3.0
    #include "UnityCG.cginc"
	#pragma multi_compile  __ _TRIPLANAR34

    struct Input {
		float3 worldPos;
		fixed3 powerNormal;
		//half3 worldRefl;
        //half4 viewDirRim; //xy:Rim, zw:blending.xy
	    float2 uv_Control : TEXCOORD0;
        //INTERNAL_DATA
    };

		half4 GetTriPlanarBlend( sampler2D tex,half3 worldPos,half3 blending,half2 tilling) 
		{   
			half4 xUV =tex2D(tex,worldPos.zy *tilling);
			half4 yUV =tex2D(tex,worldPos.xz*tilling);
			half4 zUV =tex2D(tex,worldPos.xy *tilling);
			half4 blendCol =xUV *blending.x + yUV * blending.y +zUV *blending.z;
			return blendCol;
		}

        void vert (inout appdata_full v,out Input o) {
    
            UNITY_INITIALIZE_OUTPUT(Input,o);
            half3 worldNormal = UnityObjectToWorldNormal(v.normal);
            float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
            //half3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos)  +  _WorldSpaceLightPos0.xyz  );
            //o.viewDirRim.x =saturate(1.4f -saturate(dot(worldViewDir , worldNormal)) );
            //o.viewDirRim.y =1-_RefLerp;
			#if _TRIPLANAR34
			half3 powerNormal = pow(abs(worldNormal), _TexPower);
			powerNormal = max(powerNormal, 0.0001);
			float b =powerNormal.x +powerNormal.y + powerNormal.z;
			o.powerNormal = powerNormal/b;
			#endif
        }

        void surf (Input IN, inout SurfaceOutput o) {
	        half4 splat_control = tex2D (_Control, IN.uv_Control);
	        half3 col;

			#if _TRIPLANAR34
				half4 splat0 = tex2D (_Splat0, IN.uv_Control *_Tiling1.xy);
				half4 splat1 = tex2D (_Splat1, IN.uv_Control *_Tiling1.zw);
				half4 splat2 = GetTriPlanarBlend(_Splat2,IN.worldPos,IN.powerNormal,_Tiling2.xy);
				half4 splat3 = GetTriPlanarBlend(_Splat3,IN.worldPos,IN.powerNormal,_Tiling2.zw);
			#else
				half4 splat0 = tex2D (_Splat0, IN.uv_Control *_Tiling1.xy);
				half4 splat1 = tex2D (_Splat1, IN.uv_Control *_Tiling1.zw);
				half4 splat2 = tex2D (_Splat2, IN.uv_Control *_Tiling2.xy);
				half4 splat3 = tex2D (_Splat3, IN.uv_Control *_Tiling2.zw);
			#endif

            //half refMask =saturate(tex2D(_RefMap,IN.uv_Control).r -IN.viewDirRim.y) ;
            o.Normal =half3(0,0,0);
	        col  = splat_control.r * splat0.rgb;
            //o.Normal += splat_control.r * UnpackNormal(tex2D(_BumpSplat0, IN.uv_Control *_Tiling1.xy));
			o.Normal += splat_control.r * UnpackNormal(tex2D(_BumpSplat0, IN.uv_Control *_Tiling1.xy));
            o.Gloss = splat0.a * splat_control.r ;
	        o.Specular = _ShininessL0 * splat_control.r;

            col += splat_control.g * splat1.rgb;
			o.Normal += splat_control.g * UnpackNormal(tex2D(_BumpSplat1, IN.uv_Control *_Tiling1.zw));
			o.Gloss += splat1.a * splat_control.g;
	        o.Specular += _ShininessL1 * splat_control.g;
	
	        col += splat_control.b * splat2.rgb;
			#if _TRIPLANAR34
				o.Normal += splat_control.b * UnpackNormal(GetTriPlanarBlend(_BumpSplat2,IN.worldPos,IN.powerNormal,_Tiling2.xy));
			#else        
				 o.Normal += splat_control.b * UnpackNormal(tex2D(_BumpSplat2, IN.uv_Control *_Tiling2.xy));
			#endif
			o.Gloss += splat2.a * splat_control.b;
	        o.Specular += _ShininessL2 * splat_control.b;
	
            col += splat_control.a * splat3.rgb;
			#if _TRIPLANAR34
				o.Normal += splat_control.a * UnpackNormal(GetTriPlanarBlend(_BumpSplat3, IN.worldPos,IN.powerNormal,_Tiling2.zw));
            #else        
				o.Normal += splat_control.a * UnpackNormal(tex2D(_BumpSplat3, IN.uv_Control *_Tiling2.zw));
			#endif
			o.Gloss += splat3.a * splat_control.a;
            o.Specular += _ShininessL3 * splat_control.a; 

            // we make normal of wet to be flat
   //         half3 tempNor =lerp(o.Normal,half3(0,0,1),_RefFluseVal);
   //         o.Normal =lerp(o.Normal,tempNor,refMask);    

   //         //50% darker in wet area
   //         half darkValue =lerp(0.5,1.0,IN.viewDirRim.y);
   //         refMask *=_ReflectVal;
   //         o.Gloss =lerp(o.Gloss,o.Gloss*(darkValue-0.3),refMask);
			//col.rgb =saturate(col.rgb);
   //         col.rgb =lerp(col.rgb,col.rgb *darkValue*_WetColor, refMask);

	        o.Albedo = lerp(col.rgb,col.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	        //o.Alpha = 0.0;
			 o.Alpha = 1.0;
            //half3 worldRefl = WorldReflectionVector (IN, o.Normal);
            //half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, worldRefl);// use ref probe as reflection source
            //half3 reflcol=DecodeHDR(skyData, unity_SpecCube0_HDR);
            //refMask *= IN.viewDirRim.x;
            //reflcol.rgb *= refMask;
            //o.Emission = reflcol.rgb ;

			//o.Albedo =splat2.rgb;
            }
        ENDCG  
        }

    SubShader {
    Lod 200
	Tags {
		"SplatCount" = "4"
		//"Queue" = "Geometry-100"
				"Queue" = "Geometry+100"
		"RenderType" = "Opaque"
	}
    CGPROGRAM
    #pragma surface surf Lambert  exclude_path:deferred  exclude_path:prepass //novertexlights noambient  //noforwardadd 
    #pragma target 3.0
    #include "UnityCG.cginc"
	//#pragma multi_compile  __ _TRIPLANAR34

    struct Input {
	    float2 uv_Control : TEXCOORD0;
    };

    void surf (Input IN, inout SurfaceOutput o) {
	    half4 splat_control = tex2D (_Control, IN.uv_Control);
	    half3 col;
	    half4 splat0 = tex2D (_Splat0, IN.uv_Control *_Tiling1.xy);
	    half4 splat1 = tex2D (_Splat1, IN.uv_Control *_Tiling1.zw);
		half4 splat2 = tex2D (_Splat2, IN.uv_Control *_Tiling1.xy);
		half4 splat3 = tex2D (_Splat3, IN.uv_Control *_Tiling1.zw);

	    col  = splat_control.r * splat0.rgb;
        col += splat_control.g * splat1.rgb;
	    col += splat_control.b * splat2.rgb;
        col += splat_control.a * splat3.rgb;

	    o.Albedo = lerp(col.rgb,col.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	    o.Alpha = 1.0;
        }
    ENDCG  
    }

    FallBack "Mobile/VertexLit"
}