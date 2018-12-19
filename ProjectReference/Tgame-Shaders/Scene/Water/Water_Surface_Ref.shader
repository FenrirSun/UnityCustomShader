// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//Update 18.1.28 : Vertex Color painted && Flow Map Support
Shader "TSHD/Water/Water_Surface_Ref"
{
	Properties 
	{
		// WaveNormalMap
		[NoScaleOffset] _WaveMap ("Wave Normal Map", 2D) = "bump" {}
		_Tiling 	("Tiling", Range(10, 200)) = 40

		_WaveBumpSpeed ("Wave Bump Speed", Range(-1, 1)) = 0.5
		_WaveZIntensity  ("Bump Scale factor", Range (0,2)) = 1.0

		_FoamFactor ("Edge Factor", Range (0.01, 5.0)) = 1.0
		[MaterialToggle(USE_SOFTEDGE)] _UseSoftEdge("Use Realtime Soft Edge", Float) = 0

		_MainTex ("FlowMap(RG), WaterMap Deep(B),Alpha (A)", 2D) = "white" {}
		// Color
		_Color0  ("Color1", COLOR)  = (0.509,0.862,0.960,1)
		_Color1  ("Color2", COLOR)  = (0.058,0.058,0.137,1)

		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess ("Shininess", Range (0.03, 10)) = 2.0
		// CubeMap
		_Cubemap ("Cubemap", Cube) = "_Skybox" {}
		_CubemapInstensity ("Cubemap Intensity", Range(0.1,1)) = 0.5

		_DepthFactor ("Depth Factor", Range(1, 30)) = 5
		_DistortionFactor ("Refraction Distortion", Range(0, 100)) = 50
		_LightDir ("Light Direction(XYZ)", Vector) = (1.0, 1.0, 1.0, 1.0)

		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2

		[Header(AlphaOffSet(X) DepthOffset(Y) AlphaScale(Z) AmbScale(W))]
		_InvRanges ("XYZ only For WaterMap", Vector) = (0.0, 0.5, 1.0, 1.0)

		[Header(Used In LOD )]
		_AlphaOffSetLOD("Alpha Offset LOD",Range(-1,1)) =0
		_DepthOffsetLOD("Depth Offset LOD",Range(0,1)) =0
		_AlphaScaleLOD("Alpha Scale LOD",Range(0,1)) =1
		_AmbScaleLOD("Ambient Scale LOD",Range(0.1,4))=2
		
		[Header(Plannar Reflection Setting)]
		[MaterialToggle(USE_REFLECTION)] _UseReflection("Use Realtime Reflection", Float) = 0

		//_ReflectVal("Reflect Value",Range(0,1)) = 0.2
		_RefDisFactor ("Reflection Distortion", Range(0, 50)) = 10
        [HideInInspector]_ReflectionTex ("Reflection", 2D) = "black" { }

		[Header(Flow Map Setting)]
		[MaterialToggle(USE_FLOW)] _UseFlowMap("Use Flow Map", Float) = 0
		_FlowVactor("Flow Scale", Range(-1, 1)) = 0.5
		_FlowSpeed("Flow Speed", float) = 1

	}
		CGINCLUDE

		#include "UnityCG.cginc"

		// 波动图以及Tiling,Speed
		sampler2D _WaveMap;
		fixed _Tiling;

		sampler2D _MainTex;
		half 		_AlphaOffSetLOD,_DepthOffsetLOD,_AlphaScaleLOD,_AmbScaleLOD;

		half _WaveZIntensity,_WaveBumpSpeed,_Shininess,_ReflectFactor,_RefDisFactor;
		fixed _FoamFactor;

		half _FlowVactor,_FlowSpeed;
			
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
			#pragma multi_compile __ USE_FLOW
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			
			float4 _MainTex_ST;
			// GrasPassTexture
			sampler2D _GrabTexture;
			float4	  _GrabTexture_TexelSize;

			sampler2D _ReflectionTex;  
			float4	  _ReflectionTex_TexelSize;
			// CameraDepth
			sampler2D_float _LastCameraDepthTexture; 

			struct a2v 
			{
				float4 vertex	: POSITION;
				float3 normal	: NORMAL;
				float4 tangent	: TANGENT; 
				float4 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};
			
			struct v2f
			{
				float4 pos		: SV_POSITION;
				float4 uv		: TEXCOORD0;
				float4 bumpUV		: TEXCOORD7;
				// 用于切线空间的计算
				float4 TtoW0 : TEXCOORD1;  
				float4 TtoW1 : TEXCOORD2;  
				float4 TtoW2 : TEXCOORD3; 
				UNITY_FOG_COORDS(9)
				// 屏幕位置
				float4 scrPos : TEXCOORD5;
				// 用于修复GrasTexture反向问题
				float4 uvgrab : TEXCOORD6;
				float4 timePhase :TEXCOORD8; //XY:phase1,2;Z:intergrate;W: nDotV refine
				half4 vertCol :TEXCOORD4;
				half3 viewDir :TEXCOORD10;
			};
			
			v2f vert(a2v v) 
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				o.pos = UnityObjectToClipPos(v.vertex);
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				float4 wpos = mul (unity_ObjectToWorld, v.vertex);
				o.uv.zw = wpos.xz / fixed2(_Tiling,_Tiling);
				o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);

				// Bump UV动画速度
				float speed	=frac( _Time.x* _WaveBumpSpeed);
				o.bumpUV.xy =o.uv.zw + float2(speed,speed);
				o.bumpUV.zw =o.uv.zw - float2(speed,speed);

				//Flow
				#ifdef USE_FLOW
					float timeOri =_Time.x *_FlowSpeed;
					o.timePhase.x =frac(timeOri);
					o.timePhase.y =frac(timeOri +0.5);
					o.timePhase.z =abs( o.timePhase.x *2 -1);
				#endif

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

				o.viewDir	= normalize(UnityWorldSpaceViewDir(worldPos));
				float nDotV = saturate(dot(o.viewDir,worldNormal));
				o.timePhase.w = lerp(0,0.3,nDotV);
				o.vertCol =v.color;

				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
				
			}
			
			fixed4 frag(v2f i) : SV_Target 
			{
				// 世界位置
				float3 worldPos = float3(i.TtoW0.w, i.TtoW1.w, i.TtoW2.w);

				// 视图向量
				half3 viewDir = i.viewDir;

				fixed depthFactor 	=1.0;
				half4 projTC = UNITY_PROJ_COORD(i.scrPos);    
				#ifdef USE_SOFTEDGE
					// 边缘查找				
					float sceneZ		= LinearEyeDepth (tex2Dproj(_LastCameraDepthTexture, projTC).r);
					float objectZ		= i.scrPos.z;
					float DistanceZ  =sceneZ - objectZ;
					float intensityFactor = saturate(DistanceZ / _FoamFactor);  
					
					_Color0.a *=intensityFactor;
					//_Color0.a *=saturate(intensityFactor + i.timePhase.w);r
					intensityFactor =1-intensityFactor;
							
					// 通过深度混合扭曲后的GrapTexture
					depthFactor   = saturate(DistanceZ / _DepthFactor + i.timePhase.w);//saturate(objectZ / _DepthFactor);
					
					#ifdef USE_FLOW
						half2 flowMap =tex2D(_MainTex,i.uv.xy).rg;
						flowMap = flowMap*2 -1;
						flowMap *=_FlowVactor;
					#endif
				
				#else
					half4 waterMap =tex2D(_MainTex,i.uv.xy);

					#ifdef USE_FLOW	
						half2 flowMap =waterMap.rg;
						flowMap = flowMap*2 -1;
						flowMap *=_FlowVactor;
					#endif

					depthFactor = saturate(waterMap.b * i.vertCol. b+_InvRanges.y);
					_Color0.a *=saturate(waterMap.a*_InvRanges.z * i.vertCol.a +_InvRanges.x);
				#endif

				// 合并水波动画
				#ifdef USE_FLOW	
					half2 phase1 = i.uv.zw  +flowMap * i.timePhase.x;
					half2 phase2 = i.uv.zw  +flowMap * i.timePhase.y;

					half4 bump1 = tex2D(_WaveMap,phase1);
					half4 bump2 = tex2D(_WaveMap,phase2);
					half3 bump 	= UnpackNormal(lerp(bump1,bump2,i.timePhase.z))* half3(_WaveZIntensity,_WaveZIntensity,1);
				#else
					half4 bump1	= tex2D(_WaveMap,i.bumpUV.xy);
					half4 bump2	= tex2D(_WaveMap, i.bumpUV.zw);
					half3 bump 	= UnpackNormal((bump1 + bump2)*0.5).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);
				#endif

				// 用GrapTexture+offset做扭曲
				// 目前重新计算grabTextureUV来修复反向问题
				i.uvgrab.xy += bump.xy * _DistortionFactor  * i.uvgrab.w * _GrabTexture_TexelSize.xy;
				half4 grapColor = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD(i.uvgrab));

				// Normal转换到世界空间
				bump = normalize(half3(dot(i.TtoW0.xyz, bump), dot(i.TtoW1.xyz, bump), dot(i.TtoW2.xyz, bump)));
				
				// 最基本的颜色通过depthFactor来混合两个基本颜色
				fixed3 finalColor	= lerp(_Color0,_Color1,depthFactor);

				//如果没有折射贴图，则完全取finalColor,默认grew 贴图的A值是0.75
				finalColor			=grapColor.a >0.9 ? lerp(grapColor.rgb,finalColor,depthFactor) :finalColor;
				finalColor *=_InvRanges.w;

				// 最后添加CubeMap的部分，通过Fresnel来混合
				fixed3 reflDir		= reflect(-viewDir, bump);
				fixed3 reflCol;
				#ifdef USE_REFLECTION
					//Use reflection Probe instead of our cubebox!!!
					fixed3 reflection1 =texCUBE(_Cubemap, reflDir).rgb ;
					half refDis = _RefDisFactor  * projTC.w * _ReflectionTex_TexelSize.xy;

					projTC.x += bump.x *refDis;
     
					fixed4 reflection2 = tex2Dproj(_ReflectionTex, projTC);
					reflCol =lerp(reflection1.rgb,reflection2.rgb,reflection2.a*depthFactor);
					reflCol *=_CubemapInstensity;
				#else
					reflCol =texCUBE(_Cubemap, reflDir).rgb *_CubemapInstensity;
				#endif

				finalColor +=reflCol*depthFactor;

				//Spe
				half3 h = normalize (normalize(_LightDir.xyz) + viewDir);
				half nh = max (0, dot (bump, h));
				half spec = pow (nh, _Shininess*128.0) * _SpecColor.a;
				finalColor +=_LightColor0 .rgb * _SpecColor.rgb * spec;

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
		Lod 250
		Tags { "Queue" = "Transparent-10" }

        Blend SrcAlpha OneMinusSrcAlpha
        //ZTest LEqual
		ZWrite Off

		CGPROGRAM
		#pragma surface surf PPL vertex:vert  nolightmap nometa noforwardadd exclude_path:deferred exclude_path:prepass alpha:blend
        #pragma target 3.0


		half4 LightingPPL (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 nNormal = normalize(s.Normal);
			half shininess = s.Gloss * 128;
	
			 lightDir =normalize(_LightDir.xyz);
			// Phong shading model      
			half reflectiveFactor = max(0.0, dot(-viewDir, reflect(lightDir, nNormal)));
	
			half diffuseFactor = max(0.0, dot(nNormal, lightDir));

			half specularFactor = pow(reflectiveFactor, shininess) * s.Specular;
	
			half4 c;
			//c.rgb = (s.Albedo * diffuseFactor + _Specular.rgb * specularFactor) * _LightColor0.rgb;
			c.rgb = (s.Albedo * diffuseFactor + _SpecColor.rgb * specularFactor) ;
			c.a = s.Alpha;

			return c;
		}

		struct Input
		{
			float4 position  : POSITION;
            float2 uv_MainTex;
			float3 worldPos  : TEXCOORD2;	// Used to calculate the texture UVs and world view vector
            float4 tilings :TEXCOORD3;
			fixed4 vertCol :TEXCOORD4;
			//half3 viewDir :TEXCOORD4;
		};
		
		void vert (inout appdata_full v, out Input o)
		{
            UNITY_INITIALIZE_OUTPUT(Input,o);
			o.worldPos =mul(unity_ObjectToWorld, v.vertex).xyz;
			o.position = UnityObjectToClipPos(v.vertex);

			half2 uvzw = o.worldPos.xz / half2(_Tiling,_Tiling);
			float speed	=frac( _Time.x* _WaveBumpSpeed);

            o.tilings.xy = uvzw+ float2(speed,speed);
            o.tilings.zw = uvzw - float2(speed,speed);
			o.vertCol = v.color;
			//o.viewDir	= normalize(UnityWorldSpaceViewDir(o.worldPos));
			//o.viewDir	=normalize(o.worldPos - _WorldSpaceCameraPos);
		}
		
		void surf (Input IN, inout SurfaceOutput o)
		{
			half3 worldView = IN.worldPos - _WorldSpaceCameraPos;
			//float3 worldView =IN.viewDir;
			// 合并水波动画
			half4 bump1	= tex2D(_WaveMap,IN.tilings.xy);
			half4 bump2	= tex2D(_WaveMap, IN.tilings.zw);
			half3 bump 	= UnpackNormal((bump1 + bump2)*0.5).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);

			o.Normal =bump.xyz;

			half3 worldNormal = o.Normal.xzy;
			worldNormal.z = -worldNormal.z;

			half depthFactor 	=1.0;
			half4 waterMap =tex2D(_MainTex, IN.uv_MainTex);
			 depthFactor = saturate( IN.vertCol.b * waterMap.b+_DepthOffsetLOD);
			_Color0.a *=saturate( IN.vertCol.a * waterMap.a *_AlphaScaleLOD +_AlphaOffSetLOD);

            half4 col ;
            col.rgb = lerp(_Color0.rgb, _Color1.rgb, depthFactor);

            // Initial material properties
            o.Alpha = _Color0.a;
            o.Specular = 1.0;
            o.Gloss = _Shininess;

            half3 reflection = texCUBE(_Cubemap, reflect(worldView, worldNormal)).rgb * _CubemapInstensity;
            half3 refraction = col.rgb*_AmbScaleLOD;

            o.Albedo = lerp(refraction, reflection, 0.5 );
        
		}
		ENDCG
	}

	SubShader
	{
		Lod 200
		Tags { "Queue" = "Transparent-10" }

        Blend SrcAlpha OneMinusSrcAlpha
        //ZTest LEqual
		ZWrite Off

		CGPROGRAM
		#pragma surface surf PPL vertex:vert  nolightmap nometa noforwardadd exclude_path:deferred exclude_path:prepass alpha:blend
        #pragma target 2.0

		half4 LightingPPL (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half4 c;
			c.rgb = s.Albedo;;
			c.a = s.Alpha;
			return c;
		}


		struct Input
		{
			float4 position  : POSITION;
            float2 uv_MainTex;
			float3 worldPos  : TEXCOORD2;	// Used to calculate the texture UVs and world view vector
            float4 tilings :TEXCOORD3;
			fixed4 vertCol :TEXCOORD4;
		};
		
		void vert (inout appdata_full v, out Input o)
		{
            UNITY_INITIALIZE_OUTPUT(Input,o);
			o.worldPos =mul(unity_ObjectToWorld, v.vertex).xyz;
			o.position = UnityObjectToClipPos(v.vertex);

			half2 uvzw = o.worldPos.xz / half2(_Tiling,_Tiling);
			float speed	=frac( _Time.x* _WaveBumpSpeed);

            o.tilings.xy = uvzw+ float2(speed,speed);
            o.tilings.zw = uvzw - float2(speed,speed);
			o.vertCol = v.color;
		}
		
		void surf (Input IN, inout SurfaceOutput o)
		{
			half3 worldView = (IN.worldPos - _WorldSpaceCameraPos);

			// 合并水波动画
			half4 bump1	= tex2D(_WaveMap,IN.tilings.xy);
			half4 bump2	= tex2D(_WaveMap, IN.tilings.zw);
			half3 bump 	= UnpackNormal((bump1 + bump2)*0.5).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);

			o.Normal =bump.xyz;

			half3 worldNormal = o.Normal.xzy;
			worldNormal.z = -worldNormal.z;

			_Color0.a *=saturate( IN.vertCol.a *_AlphaScaleLOD +_AlphaOffSetLOD);

            half4 col ;
			col.rgb = lerp(_Color0.rgb, _Color1.rgb, 0.5);
            // Initial material properties
            o.Alpha = _Color0.a;

            half3 reflection = texCUBE(_Cubemap, reflect(worldView, worldNormal)).rgb * _CubemapInstensity;
            half3 refraction = col.rgb;
			//o.Albedo = refraction+reflection;
			o.Albedo *=_AmbScaleLOD;
            o.Albedo = lerp(refraction, reflection, 0.5 );
        
		}
		ENDCG
	}

	Fallback "Legacy Shaders/Transparent/VertexLit"
}
