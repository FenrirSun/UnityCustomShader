// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

///Upadat 18.2.11:Add Spe After Baking LM
Shader "TSHD/Scene/Wet/T4M 2Tex2Bump_PBR" {
Properties {

	_SpecColor ("Specular Color", Color) = (1, 1, 1, 1)

	_ShininessL0 ("Layer1 Smoothness", Range (0.03, 1)) = 0.2
	_Splat0 ("Layer 1 (R)", 2D) = "Black" {}
	_ShininessL1 ("Layer2 Smoothness", Range (0.03, 1)) = 0.2
	_Splat1 ("Layer 2 (G)", 2D) = "Black" {}

    _BumpSplat0 ("Layer1Normalmap", 2D) = "bump" {}
	_BumpSplat1 ("Layer2Normalmap", 2D) = "bump" {}

    _Tiling1("Layer1:xy,Layer2:zw", Vector)=(1,1,0,0)

	_Control ("Control (RGBA)", 2D) = "white" {}

    _FogVal ("Fog Density",Range(0,1)) =1.0
    _FogHeiDen("Height Fog Density",Range(0,1)) =0.0

	[HideInInspector]_MainTex ("Never Used", 2D) = "white" {}
} 

CGINCLUDE
    sampler2D _Control;
    sampler2D _BumpSplat0, _BumpSplat1, _BumpSplat2;
    sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
    fixed _AmbScale;
    fixed _ShininessL0;
    fixed _ShininessL1;
	        fixed _FogVal,_FogHeiGlobalScale,_FogHeiParaZ,_FogHeiParaW,_FogHeiScale;
    float4 _Tiling2, _Tiling1;
ENDCG

SubShader {
    Lod 300
	Tags {
		"SplatCount" = "4"
		"Queue" = "Geometry+100"
		"RenderType" = "Opaque"
	}
    CGPROGRAM
    #pragma surface surf StandardSpecular  vertex:vert finalcolor:fogColor exclude_path:deferred  exclude_path:prepass   nofog
    #pragma target 3.0
	#pragma multi_compile_fog

    struct Input {
	    float2 uv_Control : TEXCOORD0;
		 float2 fogCoord : TEXCOORD5;
    };


        void vert (inout appdata_full v,out Input o) {
    
            UNITY_INITIALIZE_OUTPUT(Input,o);
            //half3 worldNormal = UnityObjectToWorldNormal(v.normal);
            float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

			float4 pos = UnityObjectToClipPos (v.vertex);
			UNITY_TRANSFER_FOG(o, pos);
			o.fogCoord.y =saturate((worldPos.y +_FogHeiScale)  *_FogHeiParaZ +_FogHeiParaW);
        }

		void fogColor(Input IN, SurfaceOutputStandardSpecular o, inout fixed4 color)
        {
			#if defined(FOG_LINEAR) ||defined(FOG_EXP)|| defined(FOG_EXP2)
            #ifdef UNITY_PASS_FORWARDADD
				UNITY_APPLY_FOG_COLOR(IN.fogCoord, color, fixed4(0,0,0,0));
            #else
				fixed3 orCol =color.rgb;
				UNITY_APPLY_FOG(IN.fogCoord, color);
				color.rgb = lerp(orCol,color.rgb,_FogVal);
				fixed3 HeiFog =lerp(unity_FogColor,color.rgb,IN.fogCoord.y); //Height Fog
				color.rgb =lerp(color.rgb,HeiFog,_FogHeiGlobalScale);//Height Fog Density
            #endif
			#endif
        }


        void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
	        half4 splat_control = tex2D (_Control, IN.uv_Control);
	        half3 col;
            //half3 orNor =IN.worldNormal;
	        half4 splat0 = tex2D (_Splat0, IN.uv_Control *_Tiling1.xy);
	        half4 splat1 = tex2D (_Splat1, IN.uv_Control *_Tiling1.zw);

            o.Normal =half3(0,0,0);
	        col  = splat_control.r * splat0.rgb;
            o.Normal += splat_control.r * UnpackNormal(tex2D(_BumpSplat0, IN.uv_Control *_Tiling1.xy));
            o.Specular  = splat0.a * splat_control.r ;
	        o.Smoothness= _ShininessL0 * splat_control.r;

            col += splat_control.g * splat1.rgb;
            o.Normal += splat_control.g * UnpackNormal(tex2D(_BumpSplat1, IN.uv_Control *_Tiling1.zw));
	        o.Specular += splat1.a * splat_control.g;
	        o.Smoothness+= _ShininessL1 * splat_control.g;
            o.Specular *=_SpecColor.rgb;

            o.Albedo = lerp(col.rgb,col.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb


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
    #pragma surface surf Lambert  exclude_path:deferred  exclude_path:prepass  
    #pragma target 3.0

    struct Input {
	    float2 uv_Control : TEXCOORD0;
    };

    void surf (Input IN, inout SurfaceOutput o) {
	    half4 splat_control = tex2D (_Control, IN.uv_Control);
	    half3 col;
	    half4 splat0 = tex2D (_Splat0, IN.uv_Control *_Tiling1.xy);
	    half4 splat1 = tex2D (_Splat1, IN.uv_Control *_Tiling1.zw);

	    col  = splat_control.r * splat0.rgb;
        col += splat_control.g * splat1.rgb;

	    o.Albedo = lerp(col.rgb,col.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	    o.Alpha = 0.0;
        }
    ENDCG  
    }

    FallBack "Mobile/VertexLit"
}