// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

///Upadat 18.2.11:Add Spe After Baking LM
Shader "TSHD/Scene/Wet/T4M 4Tex4_TriPlanar" {
Properties {
    //_AmbScale ("Ambient Color", Range (0.0, 1)) = 0  
	_SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
	_TexPower("TriPlannar Blending Power", Range(1, 20.0)) = 10.0
    //[MaterialToggle(_TRIPLANAR12)] _TriPlanar12("Layers12 TriPlannar", Float) = 0
	[MaterialToggle(_TRIPLANAR34)] _TriPlanar34("Layers34 TriPlannar", Float) = 0
	_Splat0 ("Layer 1 (R)", 2D) = "white" {}
	_Splat1 ("Layer 2 (G)", 2D) = "white" {}
	_Splat2 ("Layer 3 (B)", 2D) = "white" {}
	_Splat3 ("Layer 4 (A)", 2D) = "white" {}

    _Tiling1("Layer1:xy,Layer2:zw", Vector)=(1,1,1,1)
	_Tiling2("Layer3:xy,Layer4:zw", Vector)=(1,1,1,1)
	_Control ("Control (RGBA)", 2D) = "white" {}


	[HideInInspector]_MainTex ("Never Used", 2D) = "white" {}
} 

CGINCLUDE
    sampler2D _Control;
    sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
    fixed _AmbScale,_TexPower;

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
    #pragma surface surf Lambert  vertex:vert exclude_path:deferred  exclude_path:prepass  //fullforwardshadows noforwardadd 
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

	        col  = splat_control.r * splat0.rgb;
            col += splat_control.g * splat1.rgb;
	        col += splat_control.b * splat2.rgb;
            col += splat_control.a * splat3.rgb;

			col.rgb =saturate(col.rgb);
	        o.Albedo = lerp(col.rgb,col.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	        //o.Alpha = 0.0;
			 o.Alpha = 1.0;

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
		//#if _TRIPLANAR34
		half4 splat2 = tex2D (_Splat2, IN.uv_Control *_Tiling1.xy);
		half4 splat3 = tex2D (_Splat3, IN.uv_Control *_Tiling1.zw);
		//#else        
		//	half4 splat2 = tex2D (_Splat2, IN.uv_Control *_Tiling2.xy);
		//	half4 splat3 = tex2D (_Splat3, IN.uv_Control *_Tiling2.zw);
		//#endif


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