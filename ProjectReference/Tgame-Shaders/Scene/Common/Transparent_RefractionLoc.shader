// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

///Script Position!
///No blending between probes!!
Shader "TSHD/VFX/Transparent_RefractionLoc"
{
	Properties
	{
        _IlluminCol ("Self-Illumination Color", Color) = (0.8,0.8,0.8,1)
		_MainTex ("Main Texture(RGB),Transparent(A)", 2D) = "white" {}
        _TransparentVal("Transparent Value",Range(0,1)) = 0.2

        _BumpScale("Bump Scale", Float) = 1.0
		_BumpMap("Normal Map(RGB)", 2D) = "bump" {}

		_SpecularMap ("SpecularMap(RGB for Specular,A for Refletion Mask)",2D) = "white" {}
		_SpecColor ("Specular Color Tweak", Color) = (0.0, 0.0, 0.0, 1)
        _SpecScale  ("Specular Scale",Range(0.0,5.0)) = 1.0
		_SpecPower ("SpecPower",float) = 50

        _RefraIndex("Refraction Index",Range(0,1)) =0.9
        _ReflectVal("Reflect Value",Range(0,1)) = 0.2

		_RimColor ("Rim Color", Color) = (0.0,0.0,0.0,1.0)
		_RimPower ("Rim Power", Range(0.5,5)) = 3.0
		_RimLevel ("Rim Level",Range(0,3)) = 0.5
        _RimDir("Rim Direction(W>0 Direction Rim,or esle Full Rim)",Vector) =(1,1,0,1)
        

	}
	SubShader
	{
        //Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        Tags { "RenderType"="Opaque" }
		LOD 200

		Pass
		{
			Name "FORWARD"
			Tags { "LightMode" = "ForwardBase" }
        

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
            //#pragma multi_compile LIGHTMAP_ON LIGHTMAP_OFF
            //#pragma multi_compile_fwdbase novertexlight nodynlightmap nodirlightmap

            #pragma target 3.0
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

            struct appdata_t {
	            float4 vertex : POSITION;
	            float4 tangent : TANGENT;
	            float3 normal : NORMAL;
	            float4 texcoord : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;       
            };
			struct v2f
			{
				float4 uvPack: TEXCOORD0;
				float4 pos : SV_POSITION;
				half4 BBoxWorldPos:TEXCOORD1; //xy:BBox pos,z:rim
       // #ifndef LIGHTMAP_OFF  
			    //half2  lmuv : TEXCOORD2;
       // #endif
              	half4 viewDirNDL : TEXCOORD2; //xyz:viewDir w:NDL

                half4 tspace0 : TEXCOORD3; // tangent.x, bitangent.x, normal.x,worldPos.x
                half4 tspace1 : TEXCOORD4; // tangent.y, bitangent.y, normal.y,worldPos.y
                half4 tspace2 : TEXCOORD5; // tangent.z, bitangent.z, normal.z,worldPos.z

                half4 proj0  :TEXCOORD6;
                SHADOW_COORDS(7)
              	UNITY_FOG_COORDS(8)
			};

			sampler2D _MainTex;
            sampler2D _AlphaTex;
            sampler2D _BumpMap;     

            fixed _BumpScale;
            fixed _RefraIndex;
			float4 _MainTex_ST;
            fixed4 _IlluminCol;
            //fixed4 _SHlight;

			sampler2D _SpecularMap; 
	    	float _ReflectVal,_TransparentVal;
            //samplerCUBE _Cubemap;

	    	fixed _SpecPower;
            fixed _SpecScale;

			uniform float _RimPower;
		    uniform fixed4 _RimColor;
		    uniform fixed _RimLevel;
            uniform  float4  _RimDir;

            uniform float3 _BBoxMin;
            uniform float3 _BBoxMax;
            uniform float3 _EnviCubeMapPos;
			v2f vert (appdata_t v)
			{
				v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f ,o);
				o.pos = UnityObjectToClipPos(v.vertex);
                o.proj0 = ComputeScreenPos(o.pos);
                //o.uvPack.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.uvPack =v.texcoord;
                // NDL
                half3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                //o.lightDir  = _WorldSpaceLightPos0.xyz;
                //world  normal
                half3 WorldNor=UnityObjectToWorldNormal(v.normal);
                o.viewDirNDL.xyz = UnityWorldSpaceViewDir(worldPos);
			    fixed3 worldViewDir = normalize(o.viewDirNDL.xyz   + _WorldSpaceLightPos0.xyz  );
			    half ndl =dot(WorldNor ,  _WorldSpaceLightPos0.xyz );
                //N dot L 
                o.viewDirNDL.w = ndl;

                half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
                half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
                half3 wBitangent = cross(WorldNor, wTangent) * tangentSign;
                // output the tangent space matrix
                o.tspace0 = half4(wTangent.x, wBitangent.x, WorldNor.x,worldPos.x);
                o.tspace1 = half4(wTangent.y, wBitangent.y, WorldNor.y,worldPos.y);
                o.tspace2 = half4(wTangent.z, wBitangent.z, WorldNor.z,worldPos.z);

				o.BBoxWorldPos.x =_BBoxMax -    worldPos ;
				o.BBoxWorldPos.y =_BBoxMin -    worldPos ;

				half rim = 1.0f -saturate(dot(WorldNor , o.viewDirNDL.xyz));
                half3 view2WorldRimDir =mul( _RimDir.xyz,UNITY_MATRIX_V).xyz;
                half rimMask =_RimDir.w>0 ? saturate(dot(WorldNor,  view2WorldRimDir)) : 1; 
                //o.rimCol =(_RimColor *pow(rim,_RimPower)) *_RimLevel*rimMask;
				o.BBoxWorldPos.z = pow(rim,_RimPower) *_RimLevel*rimMask;
				//o.BBoxWorldPos.w = 
			//SH light
            //#ifdef _SHLIGHT
            //    #if UNITY_SHOULD_SAMPLE_SH
            //        o.vLihgtspe.xyz = fixed3(1.0,1.0,1.0);
            //    #else
                    //o.vLihgtspe.xyz = ShadeSH9 (float4(WorldNor,1.0));
            //    #endif 
            //#endif 
                //#ifndef LIGHTMAP_OFF  
                //    o.lmuv = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                //#endif
                TRANSFER_SHADOW(o); 
				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
                half2 MainUV =TRANSFORM_TEX(i.uvPack, _MainTex);
                fixed4 tex= tex2D(_MainTex, MainUV.xy);
                half3 tnormal = UnpackScaleNormal(tex2D(_BumpMap,MainUV.xy),_BumpScale);
                // transform normal from tangent to world space
                half3 worldNormal;
                worldNormal.x = dot(i.tspace0.xyz, tnormal);
                worldNormal.y = dot(i.tspace1.xyz, tnormal);
                worldNormal.z = dot(i.tspace2.xyz, tnormal);
				
				half3 worldPos =half3(i.tspace0.w,i.tspace1.w,i.tspace2.w);
				//Ambient
                fixed4 col=tex*_IlluminCol *max(0.0,i.viewDirNDL.w) *_LightColor0 ;
                col +=tex;
                col *=_IlluminCol ;


                fixed atten =SHADOW_ATTENUATION(i);
        //#ifndef LIGHTMAP_OFF  
        //        fixed4 lm = UNITY_SAMPLE_TEX2D(unity_Lightmap,i.lmuv);
        //         col.rgb *=DecodeLightmap(lm);
        //#endif
             col.rgb *= atten;  
                ///LOCAL Cubmap!!!!!
                half3 viewDirWS = normalize(i.viewDirNDL.xyz);
                half3 reflDirWS = reflect(-viewDirWS, worldNormal);
                half3 refraDirWS =refract(-viewDirWS,worldNormal,_RefraIndex);

            	//Specular
                //fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos)  +  _WorldSpaceLightPos0.xyz  );
                half3 worldViewDir = normalize(viewDirWS +  _WorldSpaceLightPos0.xyz  );
                half nh = max (0, dot (worldNormal  ,worldViewDir));
				half spe = pow (nh, _SpecPower) * _SpecScale;
            	half4 specCol = tex2D(_SpecularMap,  MainUV.xy);
        //#ifdef _SHLIGHT
                //_LightColor0.rgb =1.0;
        //#endif

                fixed3 tempSpe=  spe *specCol*_SpecColor;        

                ///LOCAL Cubmap!!!!!
                /// Working in World Coordinate System.
                /// Notice: (-reflDirWS!!
                half3 intersectMaxPointPlanes = i.BBoxWorldPos.x  /reflDirWS;
                half3 intersectMinPointPlanes = i.BBoxWorldPos.y / reflDirWS;

                half3 intersectMaxPointPlanesRefra = i.BBoxWorldPos.x   /refraDirWS;
                half3 intersectMinPointPlanesRefra  = i.BBoxWorldPos.y / refraDirWS;

                /// Looking only for intersections in the forward direction of the ray.
                half3 largestParams = max(intersectMaxPointPlanes, intersectMinPointPlanes);
                half3 largestParamsRefra = max(intersectMaxPointPlanesRefra, intersectMinPointPlanesRefra);

                /// Smallest value of the ray parameters gives us the intersection.
                half distToIntersect = min(min(largestParams.x, largestParams.y), largestParams.z);
                half distToIntersectRefra = min(min(largestParamsRefra.x, largestParamsRefra.y), largestParamsRefra.z);
                /// Find the position of the intersection point.
                half3 intersectPositionWS = worldPos + reflDirWS * distToIntersect;
                half3 intersectPositionWSRefra =worldPos + refraDirWS * distToIntersectRefra;
                /// Get local corrected reflection vector.
                half3 localCorrReflDirWS = intersectPositionWS - _EnviCubeMapPos;
                half3 localCorrReflDirWSRefra = intersectPositionWSRefra - _EnviCubeMapPos;
                /// Lookup the environment reflection texture with the right vector.
                half4 skyDataLocal = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, localCorrReflDirWS);       
                half3 reflection1Loc =DecodeHDR(skyDataLocal, unity_SpecCube0_HDR);
                
                half4 skyDataLocalRefra= UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, localCorrReflDirWSRefra);       
                half3 refractionLoc=DecodeHDR(skyDataLocalRefra, unity_SpecCube0_HDR);

                fixed3 reflection =reflection1Loc.rgb*_ReflectVal; 
                
                //col.rgb = lerp(col.rgb,refractionLoc,_RefraVal);
                col.rgb = lerp(refractionLoc,col.rgb,_TransparentVal*tex.a);
                col.rgb +=reflection+tempSpe+i.BBoxWorldPos.z *_RimColor;
				//col.rgb =tex;
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
                UNITY_OPAQUE_ALPHA(col.a);        

				return col;
			}
			ENDCG
		}
	}
	FallBack "Mobile/VertexLit"
}
