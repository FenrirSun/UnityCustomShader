Shader "TS_QT/WarFog/QTWarFog"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent+399" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		//Blend Zero SrcColor
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off 
		Lighting Off 
		ZWrite Off
		ZTest Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			#define r0 0.2
			#define r1 0.176
			#define r2 0.121
			#define r3 0.065
			#define r4 0.027

			//#define r0 0.266
			//#define r1 0.213
			//#define r2 0.109
			//#define r3 0.036

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			///战争迷雾贴图 r 正在开启区域 g 已经开启的区域
			sampler2D _MainTex;
			fixed4 _TintColor;
			fixed warFogIntensity;
			fixed openProgress;
			//采样间隔（模糊混合使用）
			float simpleStep;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				half4 c1 = 0;
				half4 c2 = 0;


				half4 tempC = tex2D(_MainTex, i.uv) * r0;
				c1 += tempC;
				c2 += tempC;
				//X方向模糊
				tempC = tex2D(_MainTex, i.uv + float2(-simpleStep, 0)) * r1;
				c1 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-2 * simpleStep, 0)) * r2;
				c1 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-3 * simpleStep, 0)) * r3;
				c1 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(-4 * simpleStep, 0)) * r4;
				c1 += tempC;

				tempC = tex2D(_MainTex, i.uv + float2(simpleStep, 0)) * r1;
				c1 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(2 * simpleStep, 0)) * r2;
				c1 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(3 * simpleStep, 0)) * r3;
				c1 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(4 * simpleStep, 0)) * r4;
				c1 += tempC;
				//Y方向模糊
				tempC = tex2D(_MainTex, i.uv + float2(0, -simpleStep)) * r1;
				c2 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(0, -2 * simpleStep)) * r2;
				c2 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(0, -3 * simpleStep)) * r3;
				c2 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(0, -4 * simpleStep)) * r4;
				c2 += tempC;

				tempC = tex2D(_MainTex, i.uv + float2(0, simpleStep)) * r1;
				c2 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(0, 2 * simpleStep)) * r2;
				c2 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(0, 3 * simpleStep)) * r3;
				c2 += tempC;
				tempC = tex2D(_MainTex, i.uv + float2(0, 4 * simpleStep)) * r4;
				c2 += tempC;


				fixed4 col = (c1 + c2) * 0.5;
				//col.a = 1;
				//half4 col = tex2D(_MainTex, i.uv);// *r0;

				col.a = (1 - (col.g + col.r * openProgress)) * warFogIntensity;
				col.rgb = _TintColor.rgb;

				return col;
			}
			ENDCG
		}
	}
}
