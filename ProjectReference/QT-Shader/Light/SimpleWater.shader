//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_OFF</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_OFF;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_SHADOW_ON;QT_SCENE_POINT_LIGHT_G0_ON</Exclude Keyword>
Shader "TS_QT/Light/SimpleWater" {
		Properties{
			_Color("Main Color", Color) = (1,1,1,1)
			_MainTex("Base (RGB)", 2D) = "white" {}
		_QTBumpMap("Normalmap 1", 2D) = "bump" {}
		_QTBumpMap2("Normalmap 2", 2D) = "bump" {}
		_QTBumpMap3("Normalmap 3", 2D) = "bump" {}
		_QTBumpMap4("Normalmap 4", 2D) = "bump" {}
		_AlphaTex("Alpha Texture", 2D) = "white"{}
		//_Fresnel("Frensel", Range(0,10)) = 0
		_normalFactor("Normal Factor", Vector) = (0,0,0,0)
		//WaveSpeed1("Wave 1", Vector) = (0,0,0,0)
		//	WaveSpeed2("Wave 2", Vector) = (0,0,0,0)
		//	WaveSpeed3("Wave 3", Vector) = (0,0,0,0)
		//	WaveSpeed4("Wave 4", Vector) = (0,0,0,0)

		//	WaveSpeedScale("Wave Speed Scale", float) = 0.01 

		LightMap_RealHighLightScale("Real Light Scale", float) = 0
			//BlinnPhong_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 0)
			Lightmap_finalShininess("Shininess", Range(0.001, 5)) = 0

			LightMap_AdjustDiff("LightMap_AdjustDiff", Range(0,5)) = 0

			_StrengthX("Offset Strength X", Float) = 0.05     //偏移强度
			_StrengthY("Offset Strength Y", Float) = 0.05
		}
			SubShader{
			Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha

			LOD 1000

			CGPROGRAM

#define QT_FOG_ON
#define QT_SIMPLE_WATER
#define QT_WARP_ON
#define QT_STATIC_REALTIME_LIGHT_ON
#define QT_STATIC_REALTIME_HIGHLIGHT_ON
#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_Lambert noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
#pragma target 3.0

			fixed4 _normalFactor;

		//fixed2 WaveSpeed1;
		//fixed2 WaveSpeed2;
		//fixed2 WaveSpeed3;
		//fixed2 WaveSpeed4;

		//float WaveSpeedScale;

		half _StrengthX;
		half _StrengthY;

		sampler2D _QT_GrabTex;

		//surface
		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			//fixed refl = 
			//fixed refr = 

			o.Albedo = c.rgb;
			o.Alpha = _Color.a * alpha.r;
			o.Specular = alpha.b ;
			
			//fixed3 n1 = UnpackNormal(tex2D(_QTBumpMap, IN.uv_QTBumpMap + WaveSpeed1 * _Time.y * WaveSpeedScale));
			//fixed3 n2 = UnpackNormal(tex2D(_QTBumpMap2, IN.uv_QTBumpMap2 + WaveSpeed2 * _Time.y * WaveSpeedScale));
			//fixed3 n3 = UnpackNormal(tex2D(_QTBumpMap3, IN.uv_QTBumpMap3 + WaveSpeed3 * _Time.y * WaveSpeedScale));
			//fixed3 n4 = UnpackNormal(tex2D(_QTBumpMap4, IN.uv_QTBumpMap4 + WaveSpeed4 * _Time.y * WaveSpeedScale));

			fixed3 n1 = UnpackNormal(tex2D(_QTBumpMap, IN.uv_QTBumpMap));
			fixed3 n2 = UnpackNormal(tex2D(_QTBumpMap2, IN.uv_QTBumpMap2));
			fixed3 n3 = UnpackNormal(tex2D(_QTBumpMap3, IN.uv_QTBumpMap3));
			fixed3 n4 = UnpackNormal(tex2D(_QTBumpMap4, IN.uv_QTBumpMap4));

			o.Normal = normalize(n1 * _normalFactor.x + n2 * _normalFactor.y + n3 * _normalFactor.z+n4 * _normalFactor.w);

			TanSpaceNormal = o.Normal;

		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0;

			//data.vertexColor = v.color;

#ifdef QT_WARP_ON
			//o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
			data.grabUV = ComputeScreenPos(mul(UNITY_MATRIX_MVP, v.vertex));
#endif

#ifdef QT_STATIC_REALTIME_LIGHT_ON
			StaticRealtimeLight_Vertex(v, data);
#endif

#ifdef QT_SCENE_POINT_LIGHT_G0_ON
			PointLight_Vertex(v,data);
#endif


#ifdef QT_FOG_ON
			Fog_Vertex(v,data);
#endif


		}

		//像素处理
		void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
#ifdef QT_WARP_ON
			//fixed4 maskTexColor = tex2D(_MaskTex, i.texcoord);
			//clip(maskTexColor.a - _Cutoff);
			//fixed2 nosieUV = i.texcoord.xy + (_Time.y * _NoiseSpeed.xy);    //计算当前时间的噪声扰动纹理UV坐标
			//fixed2 offsetColor = tex2D(_NoiseTex, nosieUV).rg - 0.5;        //纹理偏移颜色，将0~1区间变换到-0.5~0.5
			//fixed2 offsetUV = offsetColor.rg * half2(_StrengthX * maskTexColor.a * maskTexColor.a, _StrengthY * maskTexColor.a* maskTexColor.a); //计算最终的UV偏移向量
			fixed2 offsetUV = o.Normal.xz * fixed2(_StrengthX, _StrengthY);

			fixed2 uv = (IN.grabUV.xy / IN.grabUV.w) + offsetUV;        //最终UV
			fixed4 c = tex2D(_QT_GrabTex, uv);//fixed4(0, 0, 0, 0);//
			//fixed4 tc = tex2D(_MainTex, i.texcoord);
			//c.rgb = lerp(c.rgb, tc.rgb * 2.0f * _TintColor.rgb, tc.a * _TintColor.a);
			//c.a = _Alpha * tc.a;

			color.a = 1;
			color.rgb = lerp(c.rgb, color.rgb, min(1, o.Alpha * 2));


			//color.rgb = min(1, o.Alpha * 2);
			//color.rgb = 0;
			//color.rg = uv;
			//c *= i.color;
#endif

#ifdef QT_WARP_OFF
			fixed4 c = fixed4(0, 0, 0, 0);
#endif
			
#ifdef QT_STATIC_REALTIME_LIGHT_ON
			StaticRealtimeLight_Pixel(IN, o, color);
#endif

#ifdef QT_SCENE_POINT_LIGHT_G0_ON
			PointLight_Pixel(IN,o,color);
#endif

#ifdef QT_FOG_ON
			Fog_Pixel(IN,o,color);
#endif
			
			//最终颜色处理
			color = FinalColor(color);
		}

		ENDCG
		}


		SubShader{
			Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha
			LOD 300

			CGPROGRAM

#include "Assets/Resources/QTShader/QTShaderLib.cginc"
#pragma surface surf QT_Lambert alpha noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass

#pragma target 3.0

			void surf(Input IN, inout SurfaceOutput o) {
			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = 1;//c.a;
			o.Gloss = saturate((alpha.b - 0.5) * 2);
		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0;
		}

		//像素处理
		void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			//最终颜色处理
			color = FinalColor(color);
		}

		ENDCG
		}

			Fallback Off
	}
