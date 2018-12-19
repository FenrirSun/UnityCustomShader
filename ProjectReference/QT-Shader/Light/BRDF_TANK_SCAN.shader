//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword:High>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Middle>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON</Exclude Keyword>
//<Exclude Keyword:Low>SHADOWS_ON;DIRLIGHTMAP_ON;LIGHTMAP_ON;SHADOWS_SCREEN;SHADOWS_NATIVE;HDR_LIGHT_PREPASS_ON;QT_TEXILLUMIN_ON;QT_FLUX_ON</Exclude Keyword>

Shader "(Discard)TS_QT/Light/BRDF_TANK_SCAN" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_AlphaTex ("Alpha Texture", 2D) = "white"{}     //r表示流光遮罩 g:? b: 0.5~1 高光贴图（低于0.2表示cutoff）
		_BRDFMap ("BRDF",2D) = "white"{}
		BRDF_k1 ("diff k", float) = 0.3          //漫射光权重
		BRDF_k2 ("spec k", float) = 1                   //镜面光权重
		//TankWheelSpeed("wheel speed",float) = 0   //履带速度

		TankScanValue("Scan Line",float) = 1
		TankScanMaxHigh("Max high",float) = 1

		_RoleReflectDiffWeight("reflect diff w", Range(0,3)) = 1
		_RoleReflectEnvWeight("reflect env w",Range(0,5)) = 0

		//_Scan("Scan Line",float) = 1
		//_MaxHigh("Max high",float) = 1
		//_ReflectCubeTex("Reflect Tex",Cube) = "_Skybox" { }
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue" = "Geometry+400"}
		LOD 800
		
		CGPROGRAM

//*#ifqtdef editor
	#define QT_FOG_ON
	#define QT_TANK_SCAN
	#define QT_ROLE_REFLECT_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
//endqtdef*/

/*#ifqtdef high
	#define QT_FOG_ON
	#define QT_TANK_SCAN
	#define QT_ROLE_REFLECT_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
//endqtdef*/

/*#ifqtdef middle
	#define QT_FOG_ON
	#define QT_TANK_SCAN
	#define QT_ROLE_REFLECT_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
//endqtdef*/

/*#ifqtdef low
	#define QT_FOG_ON
	#define QT_TANK_SCAN
	#define QT_ROLE_REFLECT_ON
	#include "Assets/Resources/QTShader/QTShaderLib.cginc"
	#pragma surface surf QT_BRDF noforwardadd nometa noshadow nofog nodirlightmap nodynlightmap finalcolor:YHFinalColor vertex:YHVertex exclude_path:prepass
//endqtdef*/

		#pragma target 3.0

		void surf (Input IN, inout SurfaceOutput o) {
			
			//#ifdef QT_TANK_WHEEL
			//fixed wheelCoe = saturate(-(IN.vertexColor.r - 0.99));
			//fixed wheelV = (IN.uv_MainTex.y + TankWheelSpeed * _Time.y * 0.1);
			////fixed signCoe = sign(wheelV);
			//wheelV = sign(wheelV) * fmod(wheelV, 0.125);
			//wheelV = wheelV - IN.uv_MainTex.y;
			//IN.uv_MainTex.y += wheelV * wheelCoe;
			//#endif

			fixed4 alpha = tex2D(_AlphaTex, IN.uv_MainTex);
			//ZEngine_ClipBlue;
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color * alpha.g;;
			o.Alpha = 1;
			o.Specular = alpha.b;
			o.Gloss = alpha.r;
			//o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			o.Normal = ZEngine_Normale;

			//o.Alpha = IN.uv_MainTex.y;
		}

		//顶点处理
		void YHVertex(inout appdata_full v, out Input data)
		{
			data = (Input)0; 
		#ifdef QT_TANK_SCAN
			TankScan_Vertex(v,data);
		#endif
		//#ifdef QT_TANK_WHEEL
		//	data.vertexColor = v.color;
		//	//TankWheel_Vertex(v,data);
		//#endif

		#ifdef QT_ROLE_REFLECT_ON
		ReloReflectEnv_Vertex(v,data);
		#endif

		#ifdef QT_SHADOW_ON
			Shadow_Vertex(v,data);
		#endif

		#ifdef QT_FOG_ON
			Fog_Vertex(v,data);
		#endif

		}

		//像素处理
		void YHFinalColor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
		#ifdef QT_TANK_SCAN
			TankScan_Pixel(IN,o,color);
		#endif
		#ifdef QT_ROLE_REFLECT_ON
			ReloReflectEnv_Pixel(IN,o,color);
		#endif

		#ifdef QT_TEXILLUMIN_ON
			TexIllumin_Pixel(IN,o,color);
		#endif

		#ifdef QT_SHADOW_ON
			Shadow_Pixel(IN,o,color);
		#endif

		#ifdef QT_FOG_ON
			Fog_Pixel(IN,o,color);
		#endif
		
			//最终颜色处理
			color = FinalColor(color);
			//color.r = o.Alpha * 8;
			//color.gb = 0;
			//color.a = 1;
		}

		ENDCG
		
		//Tags { "Queue"="Transparent+50" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Tags { "RenderType"="Opaque" "Queue" = "Geometry+401"}
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask RGB
		Lighting Off
		ZTest On
		ZWrite Off

		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		//	#pragma multi_compile_particles
			
			#include "Assets/Resources/QTShader/QTCGShader.cginc"

		//	sampler2D _MainTex;
		//	fixed4 _TintColor;

			fixed TankScanValue;
			fixed TankScanMaxHigh;
			fixed4 _TintColor;
			
			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
				fixed high : TEXCOORD1;
			};
			
			float4 _MainTex_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = fixed4(1,1,1,1);// v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				o.high = v.vertex.z;
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 c = 1;// tex2D(_MainTex, i.texcoord);
				clip(i.high / TankScanMaxHigh - TankScanValue);
				clip(c.a - 0.001);
				c = 2.0f * i.color * _TintColor * c;
				FinalColor(c);
				return c;
			}
			ENDCG 
		}
	} 




Fallback Off
}
