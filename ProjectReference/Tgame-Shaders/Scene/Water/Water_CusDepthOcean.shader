//Update 17.6.1:Unity 5.6 version
//Update 4.24 :frac( _Time.x* _WaveBumpSpeed);
//Update 17.12. LOD
Shader "TSHD/Water/Water_CusDepthOcean"
{
	Properties 
	{
		// WaveNormalMap
		[NoScaleOffset] _WaveMap ("Wave Normal Map", 2D) = "bump" {}
		_Tiling 	("Tiling", Range(10, 200)) = 40
		_WaveXSpeed ("Wave X Speed", Range(-1, 1)) = 0.1
		_WaveYSpeed ("Wave Y Speed", Range(-1, 1)) = 0.1
		_WaveBumpSpeed ("Wave Bump Speed", Range(-1, 1)) = 0.5
		_WaveZIntensity  ("Bump Scale factor", Range (0,2)) = 1.0
		_WaveWind("Wave Wind",Range(0,2)) =0.5
		_WaveHeight("Wave Height",Range(0,2)) =0.5
		_Frequency("Wave Frequency",Range(0,2)) =0.5

		_MainTex ("WaterMap Deep(R),Alpha (G)", 2D) = "white" {}

		// EdgeAndFoam
		[NoScaleOffset] _Foam ("Foam texture", 2D) = "white" {}
		[NoScaleOffset] _FoamGradient ("Foam gradient ", 2D) = "white" {}
		_FoamTiling  ("Foam Tiling", Range (0.01,1)) = 1.0
		_FoamFactor ("Foam Factor", Range (0, 5.0)) = 1.0
		_FoamMultipiler ("Foam Multipiler", Range (0, 10.0)) = 2.0
		
		// Color
		_Color0  ("Color1", COLOR)  = (0.509,0.862,0.960,1)
		_Color1  ("Color2", COLOR)  = (0.058,0.058,0.137,1)

		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess ("Shininess", Range (0.03, 10)) = 2.0

		// CubeMap
		_Cubemap ("Cubemap", Cube) = "_Skybox" {}
		_CubemapInstensity ("Cubemap Intensity", Range(0.1,1)) = 0.5
		
		// 
		_DepthFactor ("Depth Factor", Float) = 5
		_DistortionFactor ("Distortion", Range(0, 100)) = 50
		_LightDir ("Light Direction(XYZ)", Vector) = (1.0, 1.0, 1.0, 1.0)
		[Header(Alpha OffSet(X) DepthOffset(Y) Alpha Scale(Z) Amb Scale(W))]
		_InvRanges ("XYZ only For WaterMap", Vector) = (0.0, 0.5, 1.0, 1.0)
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2

		[Header(Used In LOD 200)]
		_AlphaOffSetLOD("Alpha Offset LOD",Range(-1,1)) =0
		_DepthOffsetLOD("Depth Offset LOD",Range(0,1)) =0
		_AlphaScaleLOD("Alpha Scale LOD",Range(0,1)) =1
		_AmbScaleLOD("Ambient Scale LOD",Range(0.1,4))=1.5
	}

		CGINCLUDE

		#include "UnityCG.cginc"

		// 波动图以及Tiling,Speed
		sampler2D _WaveMap;
		fixed _Tiling;

		sampler2D _MainTex;
		half 		_AlphaOffSetLOD,_DepthOffsetLOD,_AlphaScaleLOD,_AmbScaleLOD;

		half _WaveZIntensity,_WaveBumpSpeed,_Shininess,_ReflectFactor,_RefDisFactor;
		fixed _FoamFactor,_ReflectVal;
			
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

		Tags { "Queue"="Transparent-10" "IgnoreProjector"="True" "RenderType"="Transparent" }
		LOD 300
		Cull [_Cull]
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off
		//GrabPass { "_GrabTexture" }
		
		Pass
		{

			CGPROGRAM

			#pragma target 3.0
			#include "UnityCG.cginc"
			#pragma multi_compile_fog
			#include "Lighting.cginc"
			#pragma vertex vert
			#pragma fragment frag

			// GrasPassTexture
			sampler2D _GrabTexture;
			float4	  _GrabTexture_TexelSize;
			
			// CameraDepth
			sampler2D_float _LastCameraDepthTexture; 
			
			float4 _MainTex_ST;
			fixed _WaveXSpeed;
			fixed _WaveYSpeed;

			
			half _WaveWind,_WaveHeight,_Frequency;

			// 边缘泡沫的贴图以及Tiling
			sampler2D _Foam;
			sampler2D _FoamGradient;
			
			fixed _FoamTiling;
			fixed _FoamMultipiler;
		

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
				float2 uv0 : TEXCOORD8;
				float4 bumpUV		: TEXCOORD7;
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
				float4 pos =v.vertex;
				float animTimeX = _Time.w * _WaveXSpeed;
				float animTimeY =_Time.w * _WaveYSpeed;
				half waveXcos = sin(animTimeX +v.vertex.x *_Frequency)*_WaveWind;
				half waveYcos = sin(animTimeY +v.vertex.z *_Frequency)*_WaveHeight; 
				pos.x +=waveXcos;
				pos.z +=waveXcos ;
				pos.y +=waveYcos ;

				o.pos = UnityObjectToClipPos(pos);
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				// Normal的UV放在了zw里面，边缘泡沫的UV放在了xy里面
				float4 wpos = mul (unity_ObjectToWorld, v.vertex);
				o.uv.zw = wpos.xz / fixed2(_Tiling,_Tiling);
				o.uv.xy = _FoamTiling * wpos.xz + 0.05 * float2(_SinTime.w, _SinTime.w);
				o.uv0 =TRANSFORM_TEX(v.texcoord, _MainTex);

				// Bump UV动画速度
				float speed	=frac( _Time.x* _WaveBumpSpeed);
				o.bumpUV.xy =o.uv.zw + float2(speed,speed);
				o.bumpUV.zw =o.uv.zw - float2(speed,speed);
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
				
				// 合并水波动画

				half4 bump1	= tex2D(_WaveMap,i.bumpUV.xy);
				half4 bump2	= tex2D(_WaveMap, i.bumpUV.zw);
				half3 bump 	= UnpackNormal((bump1 + bump2)*0.5).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);
	
				// 用GrapTexture+offset做扭曲
				// 目前重新计算grabTextureUV来修复反向问题
				i.uvgrab.xy += bump.xy * _DistortionFactor  * i.uvgrab.w * _GrabTexture_TexelSize.xy;
				fixed3 grapColor = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD(i.uvgrab));

				// Normal转换到世界空间
				bump = normalize(half3(dot(i.TtoW0.xyz, bump), dot(i.TtoW1.xyz, bump), dot(i.TtoW2.xyz, bump)));

				// 最基本的颜色通过Fresnel来混合两个基本颜色
				fixed  fresnel		= pow(saturate(dot(viewDir, bump)), 0.3);
				fixed3 finalColor	= lerp(_Color0,_Color1,fresnel);

				fixed depthFactor 	=1.0;
				half4 projTC = UNITY_PROJ_COORD(i.scrPos);  

				// 边缘查找				
				float sceneZ		= LinearEyeDepth (tex2Dproj(_LastCameraDepthTexture, projTC).r);
				float objectZ		= i.scrPos.z;
				float DistanceZ  =sceneZ - objectZ;
				float intensityFactor = saturate(DistanceZ / _FoamFactor);  
				_Color0.a *=intensityFactor;

				// 通过深度混合扭曲后的GrapTexture
				depthFactor   = saturate(DistanceZ / _DepthFactor);//saturate(objectZ / _DepthFactor);

				intensityFactor =1-intensityFactor;

				// 泡沫UV动画
				half3 foamGradient	= 1 - tex2D(_FoamGradient, float2(intensityFactor - _Time.y*0.1, 0) + bump.xy * 0.15);
				half2 foamDistortUV = bump.xy * 0.2;
				half3 foamColor 	= tex2D(_Foam, frac(i.uv.xy + foamDistortUV)).rgb;

				finalColor			+= foamGradient * intensityFactor  * foamColor * _FoamMultipiler;

				// 通过深度混合扭曲后的GrapTexture
				finalColor			= lerp(grapColor,finalColor,depthFactor );
				//如果没有折射贴图，则完全取finalColor
				finalColor			=grapColor.r >0 ? lerp(grapColor,finalColor,depthFactor) :finalColor;
				//finalColor =lerp(grapColor,finalColor,_Color1.a );

				// 最后添加CubeMap的部分，通过Fresnel来混合
				fixed3 reflDir		= reflect(-viewDir, bump);
				fixed3 reflCol		= texCUBE(_Cubemap, reflDir).rgb;

				fixed fresnelCube	= pow(1 - saturate(dot(viewDir, bump)), 10);
				//finalColor			= (reflCol * fresnelCube) + (finalColor * (1 - fresnelCube));
				fixed3 cubeMapAvg   = lerp(_Color0,reflCol,_CubemapInstensity);
				finalColor			= lerp(cubeMapAvg,finalColor,(1-fresnelCube));//(reflCol * fresnelCube) + (finalColor * (1 - fresnelCube));

				//Spe
				half3 h = normalize (normalize(_LightDir.xyz) + viewDir);
				half nh = max (0, dot (bump, h));
				half spec = pow (nh, _Shininess*128.0) * _SpecColor.a;
				finalColor +=_LightColor0 .rgb * _SpecColor.rgb * spec;


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
		#pragma surface surf PPL vertex:vert noambient nolightmap nometa noforwardadd exclude_path:deferred exclude_path:prepass alpha:blend
        #pragma target 3.0


		half4 LightingPPL (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 nNormal = normalize(s.Normal);
			half shininess = s.Gloss * 250.0 + 4.0;
	
			 lightDir =normalize(_LightDir.xyz);
			// Phong shading model      
			half reflectiveFactor = max(0.0, dot(-viewDir, reflect(lightDir, nNormal)));
	
			half diffuseFactor = max(0.0, dot(nNormal, lightDir));

			half specularFactor = pow(reflectiveFactor, shininess) * s.Specular;
	
			half4 c;
			//c.rgb = (s.Albedo * diffuseFactor + _Specular.rgb * specularFactor) * _LightColor0.rgb;
			c.rgb = (s.Albedo * diffuseFactor + _SpecColor.rgb * specularFactor) ;
			//c.rgb *= (atten * 2.0)*_InvRanges.w;
			c.rgb *= 2*_InvRanges.w;
			c.a = s.Alpha;

			return c;
		}

		struct Input
		{
			float4 position  : POSITION;
            float2 uv_MainTex;
			float3 worldPos  : TEXCOORD2;	// Used to calculate the texture UVs and world view vector
            float4 tilings :TEXCOORD3;
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
		}
		
		void surf (Input IN, inout SurfaceOutput o)
		{
			float3 worldView = (IN.worldPos - _WorldSpaceCameraPos);

				// 合并水波动画
			half4 bump1	= tex2D(_WaveMap,IN.tilings.xy);
			half4 bump2	= tex2D(_WaveMap, IN.tilings.zw);
			half3 bump 	= UnpackNormal((bump1 + bump2)*0.5).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);

			o.Normal =bump.xyz;

			half3 worldNormal = o.Normal.xzy;
			worldNormal.z = -worldNormal.z;

			half depthFactor 	=1.0;
			half3 waterMap =tex2D(_MainTex, IN.uv_MainTex).rgb;
			 depthFactor = saturate(waterMap.r+_DepthOffsetLOD);
			_Color0.a *=saturate(waterMap.g*_AlphaScaleLOD +_AlphaOffSetLOD);

            half4 col ;
            col.rgb = lerp(_Color0.rgb, _Color1.rgb, depthFactor);

            // Initial material properties
            o.Alpha = _Color0.a;
            o.Specular = 1.0;
            o.Gloss = _Shininess;

            half3 reflection = texCUBE(_Cubemap, reflect(worldView, worldNormal)).rgb * _CubemapInstensity;
            half3 refraction = col.rgb;

            o.Albedo = lerp(refraction, reflection, 0.5 );
        
		}
		ENDCG
	}

	SubShader 
	{

		Tags { "Queue"="Transparent-10" "IgnoreProjector"="True" "RenderType"="Transparent" }
		LOD 200
		Cull [_Cull]
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{

			CGPROGRAM

			#pragma target 2.0
			#include "UnityCG.cginc"
			#pragma multi_compile_fog
			
			#pragma vertex vert
			#pragma fragment frag
			
			half _WaveWind,_WaveHeight,_Frequency;

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
				float4 bumpUV		: TEXCOORD7;
				// 用于切线空间的计算
				float4 TtoW0 : TEXCOORD1;  
				float4 TtoW1 : TEXCOORD2;  
				float4 TtoW2 : TEXCOORD3; 
				UNITY_FOG_COORDS(4)
				
			};
			
			v2f vert(a2v v) 
			{
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				float4 pos =v.vertex;

				o.pos = UnityObjectToClipPos(pos);
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				// Normal的UV放在了zw里面，边缘泡沫的UV放在了xy里面
				float4 wpos = mul (unity_ObjectToWorld, v.vertex);
				o.uv.zw = wpos.xz / fixed2(_Tiling,_Tiling);
				//o.uv.xy = _FoamTiling * wpos.xz + 0.05 * float2(_SinTime.w, _SinTime.w);

				// Bump UV动画速度
				half speed	=frac( _Time.x* _WaveBumpSpeed);
				o.bumpUV.xy =o.uv.zw + half2(speed,speed);
				o.bumpUV.zw =o.uv.zw - half2(speed,speed);
				// 世界位置，法线，切线，副法线
				float3 worldPos 		= mul(unity_ObjectToWorld, v.vertex).xyz;  
				fixed3 worldNormal		= UnityObjectToWorldNormal(v.normal);  
				fixed3 worldTangent 	= UnityObjectToWorldDir(v.tangent.xyz);  
				fixed3 worldBinormal	= cross(worldNormal, worldTangent) * v.tangent.w; 
				
				// 转到切线空间
				o.TtoW0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);  
				o.TtoW1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);  
				o.TtoW2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);  

				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
				
			}
			
			fixed4 frag(v2f i) : SV_Target 
			{
				// 世界位置
				float3 worldPos = float3(i.TtoW0.w, i.TtoW1.w, i.TtoW2.w);

				// 视图向量
				half3 viewDir	= normalize(UnityWorldSpaceViewDir(worldPos));


				half4 bump1	= tex2D(_WaveMap,i.bumpUV.xy);
				half4 bump2	= tex2D(_WaveMap, i.bumpUV.zw);
				half3 bump 	= UnpackNormal((bump1 + bump2)*0.5).rgb * half3(_WaveZIntensity,_WaveZIntensity,1);
	

				// Normal转换到世界空间
				bump = normalize(half3(dot(i.TtoW0.xyz, bump), dot(i.TtoW1.xyz, bump), dot(i.TtoW2.xyz, bump)));

				// 最基本的颜色通过Fresnel来混合两个基本颜色
				fixed  fresnel		= pow(saturate(dot(viewDir, bump)), 0.3);
				fixed3 finalColor	= lerp(_Color0,_Color1,fresnel);
	
				// 边缘查找				

				fixed3 reflDir		= reflect(-viewDir, bump);
				fixed3 reflCol		= texCUBE(_Cubemap, reflDir).rgb;

				fixed3 cubeMapAvg   = lerp(_Color0,reflCol,_CubemapInstensity);
				finalColor			= lerp(cubeMapAvg,finalColor,0.5);//(reflCol * fresnelCube) + (finalColor * (1 - fresnelCube));
				_Color0.a *= _AlphaScaleLOD;
				// Fog
				UNITY_APPLY_FOG(i.fogCoord, finalColor);
				return fixed4(finalColor, _Color0.a);
				
			}
			
			ENDCG
		}
	}

	Fallback "Legacy Shaders/Transparent/VertexLit"
}
