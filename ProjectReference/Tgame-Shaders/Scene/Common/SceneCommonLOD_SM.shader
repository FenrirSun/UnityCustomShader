///LOD 300 Bump + Re +ForwardAdd +Amb
///LOD 200 Re + Amb
///Update 17.4.13:use Shadow Mask mode for bump&Specular after baking
Shader "TSHD/Scene/SceneCommonLOD"
{
	Properties
	{
        //_AmbScale ("Ambient Color", Range (0.0, 1)) = 0
		//_ColorScale("Scale Color After Baking", Range (0.0, 3)) = 1
		_MainTex ("Main Texture", 2D) = "white" {}
        _BumpScale("Bump Scale", Float) = 1.0
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _SpecularMap ("SpecularMap(RGB for Specular,A for Refletion Mask)",2D) = "white" {}
        _SpecColor ("Specular Color", Color) = (1.0, 1.0, 1.0, 1)
        _Shininess ("Shininess", Range (0.01, 1)) = 0.078125
        _ReflectVal("Reflect Value",Range(0,1)) = 0.2
        _RefFluseVal("Reflect Distortion",Range(0,1)) =0.8
        _WetColor ("Wet Area Color", Color) = (0.2, 0.2,0.2, 1)
        _FogVal ("Fog Density",Range(0,1)) =1.0
        _FogHeiDen("Height Fog Density",Range(0,1)) =0.0
        
	}
    SubShader
    {
        Tags { "RenderType"="Opaque" 		"Queue" = "Geometry"}
        LOD 300

		CGPROGRAM
        #pragma surface surf BlinnPhong vertex:vert finalcolor:fogColor exclude_path:deferred  exclude_path:prepass nometa  
        #pragma target 3.0
        #pragma multi_compile_fog

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _SpecularMap;

        fixed _BumpScale,_AmbScale,_RefFluseVal,_RefLerp,_ColorScale;
        fixed4 _Color,_WetColor;
        fixed4 _ReflectColor;
        half _Shininess;
        float _ReflectVal,_GlobalColScale;
        fixed _FogVal,_FogHeiGlobalScale,_FogHeiParaZ,_FogHeiParaW,_FogHeiScale;


        struct Input {
	        float2 uv_MainTex;
	        float2 uv_BumpMap;
	        float3 worldRefl;
            half2 viewDirRim;
	        INTERNAL_DATA
            float2 fogCoord : TEXCOORD5;
        };

        void vert (inout appdata_full v,out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            half3 worldNormal = UnityObjectToWorldNormal(v.normal);
            float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
            half3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos)  +  _WorldSpaceLightPos0.xyz  );
            o.viewDirRim.x =saturate(1.4f -saturate(dot(worldViewDir , worldNormal)) );
            o.viewDirRim.y =1-_RefLerp;
            float4 pos = UnityObjectToClipPos (v.vertex);

			UNITY_TRANSFER_FOG(o, pos);
			o.fogCoord.y =saturate((worldPos.y +_FogHeiScale)  *_FogHeiParaZ +_FogHeiParaW);
        }

        void fogColor(Input IN, SurfaceOutput o, inout fixed4 color)
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

        void surf (Input IN, inout SurfaceOutput o) {
	        half4 c  = tex2D(_MainTex, IN.uv_MainTex);
            half4 speCol =tex2D(_SpecularMap,IN.uv_MainTex);
            _SpecColor.rgb *=speCol.rgb;

            o.Gloss = _SpecColor.a;
	        o.Specular = _Shininess;
           
            //o.Normal = UnpackScaleNormal(tex2D(_BumpMap, IN.uv_BumpMap),_BumpScale);
			half4 packednormal =tex2D (_BumpMap, IN.uv_BumpMap);
			half3 normalLocal;
			#if defined(UNITY_NO_DXT5nm)
				o.Normal = packednormal.xyz * 2 - 1;
				o.Normal .xy *= _BumpScale;
			#else
				o.Normal .xy = (packednormal.wy * 2 - 1);
				//#if (SHADER_TARGET >= 30)
				//    // SM2.0: instruction count limitation
				//    // SM2.0: normal scaler is not supported
					o.Normal .xy *= _BumpScale;
				//#endif
				o.Normal .z = sqrt(1.0 - saturate(dot(o.Normal .xy, o.Normal .xy)));
			#endif
            
            half refMask =saturate( speCol.a -IN.viewDirRim.y) ;
            // we make normal of wet to be flat
            half3 tempNor =lerp(o.Normal,half3(0,0,1),_RefFluseVal);
            o.Normal =lerp(o.Normal,tempNor,refMask);    

             //50% darker in wet area
            half darkValue =lerp(0.5,1.0,IN.viewDirRim.y);
            refMask *=_ReflectVal;
            o.Gloss =lerp(o.Gloss,o.Gloss*(darkValue-0.3),refMask);
            c.rgb =lerp(c.rgb,c.rgb *darkValue*_WetColor, refMask);
	        
            o.Albedo = lerp(c.rgb,c.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	        half3 worldRefl = WorldReflectionVector (IN, o.Normal);
            half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, worldRefl);// use ref probe as reflection source
            half3 reflcol=DecodeHDR(skyData, unity_SpecCube0_HDR);
            reflcol *= refMask;
            o.Emission = reflcol.rgb ;;
        }
        ENDCG
        }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        CGPROGRAM
        #pragma surface surf Lambert exclude_path:deferred  exclude_path:prepass nometa noforwardadd noshadow noambient novertexlights 

        sampler2D _MainTex;
        fixed4 _Color;
        half _AmbScale;

        struct Input {
	        float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o) {
	        fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	        o.Albedo = lerp(c.rgb,c.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb

        }
        ENDCG
    }

        FallBack "Mobile/VertexLit"
}
