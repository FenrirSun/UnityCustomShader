// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TSHD/Water/Water_Surface_Flow"
{
	Properties 
	{
		// WaveNormalMap
		[NoScaleOffset] _WaveMap ("Wave Normal Map", 2D) = "bump" {}
		_WaveZIntensity  ("Bump Scale factor", Range (0,2)) = 1.0
		_WaveBumpSpeed ("Wave Bump Speed", Range(-1, 1)) = 0.5
		_Tiling 	("Tiling", Range(10, 200)) = 40
		_FlowTex ("Flow Map(RG),Noise(B)", 2D) = "black" {}
		_FlowMapOffset0("Flow Offset0",float) =1.0
		_FlowMapOffset1("Flow Offset1",float) =2.0
		_HalfCycle("Half Cycle",Range (0.01,2)) = 1.0

		//[NoScaleOffset] _Foam ("Foam texture", 2D) = "white" {} 
		//_FoamTiling  ("Foam Tiling", Range (0.01,100)) = 1.0
		//_FoamPow ("Foam Power", Range (0.01, 10.0)) = 5.0
		//_FoamSpeed ("Foam Speed", Range(-10, 10)) = 0.5
		//_FoamMultipiler ("Foam Multipiler", Range (0, 20.0)) = 2.0
		
		_MainTex ("WaterMap Deep(R),Alpha (G)", 2D) = "white" {}
		_EdgeFactor ("Edge Factor", Range (0, 5.0)) = 1.0
		// Color
		_Color0  ("Color1", COLOR)  = (0.509,0.862,0.960,1)
		_Color1  ("Color2", COLOR)  = (0.058,0.058,0.137,1)

		[MaterialToggle(USE_SOFTEDGE)] _UseSoftEdge("Use Soft Edge", Float) = 0
		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess ("Shininess", Range (0.03, 10)) = 2.0
		// CubeMap
		_Cubemap ("Cubemap", Cube) = "_Skybox" {}
		_CubemapInstensity ("Cubemap Intensity", Range(0.1,1)) = 0.5
		
		[MaterialToggle(USE_REFLECTION)] _UseVertexAnim("Use Realtime Reflection", Float) = 0
		//_ReflectFactor("Reflect Factor",Range(2,10)) = 5

		_ReflectVal("Reflect Value",Range(0,1)) = 0.2
		_RefDisFactor ("Reflection Distortion", Range(0, 50)) = 10
        [HideInInspector]_ReflectionTex ("Reflection", 2D) = "black" { }

		_DepthFactor ("Depth Factor", Range(1, 30)) = 5
		_DistortionFactor ("Refraction Distortion", Range(0, 100)) = 50
		_InvRanges ("Alpha OffSet(X), Depth OffSet(Y) ,Alpha Scale(Z),Amb Scale(W)", Vector) = (0.0, 0.5, 1.0, 1.0)
		_LightDir ("Light Direction(XYZ)", Vector) = (1.0, 1.0, 1.0, 1.0)
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
	}
		CGINCLUDE

		#include "UnityCG.cginc"

		// 波动图以及Tiling,Speed
		sampler2D _WaveMap;
		fixed _Tiling;

		sampler2D _MainTex;

		fixed _FoamTiling,_FoamPow,_FoamSpeed;
		fixed _FoamMultipiler;

		half _WaveZIntensity,_WaveBumpSpeed,_Shininess,_ReflectFactor,_RefDisFactor;
		half _EdgeFactor,_ReflectVal,_FlowMapOffset0,_FlowMapOffset1,_HalfCycle;
			
		// 两个基本颜色
		fixed4 _Color0;
		fixed4 _Color1;
			
		// CubeMap
		samplerCUBE _Cubemap;
		fixed _DepthFactor;
		fixed _DistortionFactor;	
		fixed _CubemapInstensity;

		half4 _InvRanges,_LightDir;
			
	ENDCG


	SubShader 
	{

		Tags { "Queue"="Transparent-10" "IgnoreProjector"="True" "RenderType"="Transparent" "DisableBatching" = "True"}
		//Tags { "RenderType"="Opaque" "IgnoreProjector"="true" }
		LOD 300
		Cull [_Cull]
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		//GrabPass { "_GrabTexture" }
		
		Pass
		{
			CGPROGRAM
			
			//#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#pragma multi_compile_fog
			#pragma multi_compile __ USE_REFLECTION
			#pragma multi_compile __ USE_SOFTEDGE
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			
			float4 _MainTex_ST;
			// GrasPassTexture
			sampler2D _GrabTexture;
			float4	  _GrabTexture_TexelSize;

			sampler2D _ReflectionTex,_FlowTex,_Foam;  
			float4	  _ReflectionTex_TexelSize;
			// CameraDepth
			sampler2D_float _LastCameraDepthTexture; 

			struct a2v 
			{
				float4 vertex	: POSITION;
				float3 normal	: NORMAL;
				float4 tangent	: TANGENT; 
				float4 texcoord : TEXCOORD0;
				
			};
			
			struct v2f
			{
				float4 pos		: SV_POSITION;
				float4 uv		: TEXCOORD0;
				//float4 bumpUV		: TEXCOORD7;
				//float4 foamUV : TEXCOORD8;
				// 用于切线空间的计算
				float4 TtoW0 : TEXCOORD1;  
				float4 TtoW1 : TEXCOORD2;  
				float4 TtoW2 : TEXCOORD3; 
				UNITY_FOG_COORDS(4)
				// 屏幕位置
				float4 scrPos : TEXCOORD5;
				// 用于修复GrasTexture反向问题
				float4 uvgrab : TEXCOORD6;
				
			};
			
			v2f vert(a2v v) 
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				o.pos = UnityObjectToClipPos(v.vertex);
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				float4 wpos = mul (unity_ObjectToWorld, v.vertex);
				o.uv.zw = wpos.xz / fixed2(_Tiling,_Tiling);
				o.uv.xy =TRANSFORM_TEX(v.texcoord.xy, _MainTex);

				// Bump UV动画速度
				float speed	=frac( _Time.x* _WaveBumpSpeed);
				o.uv.zw +=speed;
				//o.foamUV.xy =wpos.xz/fixed2(_FoamTiling,_FoamTiling);
				//o.foamUV.zw =o.foamUV.xy;
				//float foamSpeed	=frac( _Time.x* _FoamSpeed);
				//o.foamUV.xy +=foamSpeed;
				//o.foamUV.zw -=foamSpeed;
				// 世界位置，法线，切线，副法线
				float3 worldPos 		= mul(unity_ObjectToWorld, v.vertex).xyz;  
				fixed3 worldNormal		= UnityObjectToWorldNormal(v.normal);  
				fixed3 worldTangent 	= UnityObjectToWorldDir(v.tangent.xyz);  
				fixed3 worldBinormal	= cross(worldNormal, worldTangent) * v.tangent.w; 
				
				// 转到切线空间
				o.TtoW0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);  
				o.TtoW1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);  
				o.TtoW2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);  
				
				// 屏幕位置
				o.scrPos = ComputeScreenPos(o.pos);
				COMPUTE_EYEDEPTH(o.scrPos.z);
				// grabUV
				o.uvgrab =ComputeGrabScreenPos(o.pos);

				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
				
			}
			
			fixed4 frag(v2f i) : SV_Target 
			{
				// 世界位置
				float3 worldPos = float3(i.TtoW0.w, i.TtoW1.w, i.TtoW2.w);

				// 视图向量
				half3 viewDir	= normalize(UnityWorldSpaceViewDir(worldPos));

				//Flow Map
				half3 flowMap =tex2D(_FlowTex,i.uv.xy).rgb;
				float cycleOffset =flowMap.b;
				float phase0 = cycleOffset + _FlowMapOffset0;
				float phase1 = cycleOffset + _FlowMapOffset1;

				//Foam part
				//half2 testZW0 =flowMap.rg ;
				//half foamPart =abs(testZW0.x -0.5) +abs(testZW0.y -0.5);
				//foamPart =saturate(0.6-foamPart);
				//foamPart =pow(foamPart,_FoamPow) *_FoamMultipiler*cycleOffset;

				//
				flowMap = flowMap*2 -1;
				float flowLerp =  abs( _HalfCycle - _FlowMapOffset0 ) / _HalfCycle ;

				half4 bump1	= tex2D(_WaveMap, i.uv.zw+flowMap.rg*phase0);
				half4 bump2	= tex2D(_WaveMap, i.uv.zw+flowMap.rg*phase1);

				//half3 foamColor 	=lerp(tex2D(_Foam, i.foamUV.xy+flowMap.rg*phase0).rgb
				//,tex2D(_Foam, i.foamUV.xy+flowMap.rg*phase1).rgb, flowLerp )*foamPart;

				half4 normalT = lerp( bump1, bump2, flowLerp );
				half3 bump 	= UnpackNormal(normalT).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);
	
				// 用GrapTexture+offset做扭曲
				// 目前重新计算grabTextureUV来修复反向问题
				i.uvgrab.xy += bump.xy * _DistortionFactor  * i.uvgrab.w * _GrabTexture_TexelSize.xy;
				fixed3 grapColor = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD(i.uvgrab));

				// Normal转换到世界空间
				bump = normalize(half3(dot(i.TtoW0.xyz, bump), dot(i.TtoW1.xyz, bump), dot(i.TtoW2.xyz, bump)));

				// 最基本的颜色通过Fresnel来混合两个基本颜色
				//fixed  fresnel		= pow(saturate(dot(viewDir, bump)), 0.3);
				fixed  fresnel		= saturate(dot(viewDir, bump));
				fixed3 finalColor	= lerp(_Color0,_Color1,fresnel);
				fixed depthFactor 	=1.0;
				half4 projTC = UNITY_PROJ_COORD(i.scrPos);    
				#ifdef USE_SOFTEDGE
					// 边缘查找				
					float sceneZ		= LinearEyeDepth (tex2Dproj(_LastCameraDepthTexture, projTC).r);
					float objectZ		= i.scrPos.z;
					float intensityFactor = saturate((sceneZ - objectZ) / _EdgeFactor);  
					
					_Color0.a *=intensityFactor;
					intensityFactor =1-intensityFactor;
							
					// 通过深度混合扭曲后的GrapTexture
					depthFactor   = saturate((sceneZ - objectZ) / _DepthFactor);//saturate(objectZ / _DepthFactor);
				#else
					//fixed3 waterMap =tex2D(_MainTex, TRANSFORM_TEX(i.uv.xy, _MainTex)).rgb;
					fixed3 waterMap =tex2D(_MainTex, i.uv.xy).rgb;
					depthFactor = saturate(waterMap.r+_InvRanges.y);
					_Color0.a *=saturate(waterMap.g*_InvRanges.z +_InvRanges.x);
				#endif
								//如果没有折射贴图，则完全取finalColor
				finalColor			=grapColor.r >0 ? lerp(grapColor,finalColor,depthFactor) :finalColor;
				//finalColor			= lerp(grapColor,finalColor,depthFactor);
				//finalColor =lerp(grapColor,finalColor,_Color1.a );

				// 最后添加CubeMap的部分，通过Fresnel来混合
				fixed3 reflDir		= reflect(-viewDir, bump);
				fixed3 reflCol;
				#ifdef USE_REFLECTION
					//Use reflection Probe instead of our cubebox!!!
					fixed3 reflection1 =texCUBE(_Cubemap, reflDir).rgb *_CubemapInstensity;
					half refDis = _RefDisFactor  * projTC.w * _ReflectionTex_TexelSize.xy;

					projTC.x += bump.x *refDis;
					//projTC.y += 0.5*bump.y *refDis;       
					fixed4 reflection2 = tex2Dproj(_ReflectionTex, projTC);
                
					reflCol =lerp(reflection1.rgb,reflection2.rgb,reflection2.a*depthFactor);
					//reflCol =reflection1.rgb +reflection2.rgb;
				#else
					reflCol =texCUBE(_Cubemap, reflDir).rgb *_CubemapInstensity;
				#endif

				finalColor +=reflCol*_ReflectVal*depthFactor;

				//Spe

				half3 h = normalize (normalize(_LightDir.xyz) + viewDir);
				half nh = max (0, dot (bump, h));
				half spec = pow (nh, _Shininess*128.0) * _SpecColor.a;
				finalColor +=_LightColor0 .rgb * _SpecColor.rgb * spec;

				//foam
				//finalColor +=foamColor;

				// Fog
				UNITY_APPLY_FOG(i.fogCoord, finalColor);
				return fixed4(finalColor, _Color0.a);
				
			}
			
			ENDCG
		}
	}
	
		SubShader
	{
   //Tex soft edge,NO refraction
		Lod 200
		Cull [_Cull]
		Tags { "Queue" = "Transparent-10" "IgnoreProjector"="True" "RenderType"="Transparent" "DisableBatching" = "True"}

        Blend SrcAlpha OneMinusSrcAlpha
        //ZTest LEqual
		ZWrite Off

		Pass
		{
			CGPROGRAM
			
			//#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#pragma multi_compile_fog
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			half4 LightingPPL (SurfaceOutput s, half3 viewDir)
		{

			half4 c;
			c.rgb = s.Albedo;
			//c.rgb = (s.Albedo * diffuseFactor + _SpecColor.rgb * specularFactor) ;
			c.rgb *=_InvRanges.w;
			c.a = s.Alpha;

			return c;
		}
				struct Input
		{
			float4 position  : POSITION;
            float2 uv_MainTex;
			//float3 worldPos  : TEXCOORD2;	// Used to calculate the texture UVs and world view vector
            float4 tilings :TEXCOORD3;
			float3 worldView  : TEXCOORD2;	// Used to calculate the texture UVs and world view vector
		};

			void vert (inout appdata_full v, out Input o)
		{
            UNITY_INITIALIZE_OUTPUT(Input,o);
			//o.worldPos =mul(_Object2World, v.vertex).xyz;
			half3 worldPos =mul(unity_ObjectToWorld, v.vertex).xyz;
			o.position = UnityObjectToClipPos(v.vertex);

			//o.tilings.zw = o.worldPos.xz / fixed2(_Tiling,_Tiling);
			o.tilings.zw = worldPos.xz / fixed2(_Tiling,_Tiling);
			o.tilings.xy = v.texcoord;

			// Bump UV动画速度
			float speed	=frac( _Time.x* _WaveBumpSpeed);
			o.tilings.xy =o.tilings.zw + float2(speed,speed);
			o.tilings.zw =o.tilings.zw - float2(speed,speed);
			o.worldView =worldPos -_WorldSpaceCameraPos;
		}
		
			void surf (Input IN, inout SurfaceOutput o)
		{

			float3 worldView = IN.worldView;
			// 合并水波动画
			half4 bump1	= tex2D(_WaveMap,IN.tilings.xy);
			half4 bump2	= tex2D(_WaveMap,  IN.tilings.zw);
			half3 nmap 	= UnpackNormal((bump1 + bump2)*0.5).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);

            o.Normal = nmap;

			// World space normal (Y-up)
			half3 worldNormal = o.Normal.xzy;
			worldNormal.z = -worldNormal.z;

			//worldNormal =o.Normal.xyz;
            float3 mainC =tex2D(_MainTex,IN.uv_MainTex).rgb;
            float depth =mainC.g;

// Calculate the depth ranges (X = Alpha, Y = Color Depth)
            half3 ranges = _InvRanges.xyz * depth;
            ranges.y = saturate(1.0 - ranges.y);

            half4 col ;
            col.rgb = lerp(_Color1.rgb, _Color0.rgb, 0.5);
            col.a = saturate(ranges.z +ranges.x);

            // Initial material properties
            o.Alpha = col.a;
            o.Specular = 1.0;
            o.Gloss = _Shininess;

            half fresnel =saturate( dot(-normalize(worldView), worldNormal));
            fresnel = 1-fresnel;

            half3 reflection = texCUBE(_Cubemap, reflect(worldView, worldNormal)).rgb * _CubemapInstensity;

            half3 refraction = col.rgb;

            o.Albedo = lerp(refraction, reflection, fresnel );
        
		}

			struct v2f_surf {
			  float4 pos : SV_POSITION;
			  float2 pack0 : TEXCOORD0; // _MainTex
			  float4 tSpace0 : TEXCOORD1;
			  float4 tSpace1 : TEXCOORD2;
			  float4 tSpace2 : TEXCOORD3;
			  float4 custompack0 : TEXCOORD4; // position
			  float4 custompack1 : TEXCOORD5; // tilings
			  float3 custompack2 : TEXCOORD6; // worldView

			  UNITY_FOG_COORDS(7)
			};

			float4 _MainTex_ST;

			// vertex shader
			v2f_surf vert (appdata_full v) {
			  v2f_surf o;
			  UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
			  Input customInputData;
			  vert (v, customInputData);
			  o.custompack0.xyzw = customInputData.position;
			  o.custompack1.xyzw = customInputData.tilings;
			  o.custompack2.xyz = customInputData.worldView;
			  o.pos = UnityObjectToClipPos (v.vertex);
			  o.pack0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
			  float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			  fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
			  fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
			  fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
			  fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
			  o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
			  o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
			  o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

			  UNITY_TRANSFER_FOG(o,o.pos); // pass fog coordinates to pixel shader
			  return o;
			}

			// fragment shader
			fixed4 frag (v2f_surf IN) : SV_Target {
			  // prepare and unpack data
			  Input surfIN;
			  UNITY_INITIALIZE_OUTPUT(Input,surfIN);
			  surfIN.position.x = 1.0;
			  surfIN.uv_MainTex.x = 1.0;
			  surfIN.tilings.x = 1.0;
			  surfIN.worldView.x = 1.0;
			  surfIN.uv_MainTex = IN.pack0.xy;
			  surfIN.position = IN.custompack0.xyzw;
			  surfIN.tilings = IN.custompack1.xyzw;
			  surfIN.worldView = IN.custompack2.xyz;
			  float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
			  fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

			  SurfaceOutput o;

			  o.Albedo = 0.0;
			  o.Emission = 0.0;
			  o.Specular = 0.0;
			  o.Alpha = 0.0;
			  o.Gloss = 0.0;
			  fixed3 normalWorldVertex = fixed3(0,0,1);

			  // call surface function
			  surf (surfIN, o);

			  fixed4 c = 0;
			  fixed3 worldN;
			  worldN.x = dot(IN.tSpace0.xyz, o.Normal);
			  worldN.y = dot(IN.tSpace1.xyz, o.Normal);
			  worldN.z = dot(IN.tSpace2.xyz, o.Normal);
			  o.Normal = worldN;

			  c += LightingPPL (o,worldViewDir);
			  c.a = o.Alpha;

			  c.rgb += o.Emission;
			  UNITY_APPLY_FOG(IN.fogCoord, c); // apply fog
			  return c;
			}

ENDCG

			}


		}


	Fallback "Legacy Shaders/Transparent/VertexLit"
}
