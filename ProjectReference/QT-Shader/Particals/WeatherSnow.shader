Shader "TS_QT/Particles/WeatherSnow" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
	MaxLifeTime ("MaxLifeTime", float) = 1
	MaxHigh("Max High", float) = 1
	colorParamScale("color param Scale", float) = 1
	fun1_w("fun1 w", float) = 1
	fun2_w("fun2 w", float) = 4
	baseColorParam("base color param",Vector) = (0,0,0,0)
}

	Category 
	{
		Tags { "Queue"="Transparent+400" "IgnoreProjector"="True" "RenderType"="Transparent" }
		//Blend SrcAlpha OneMinusSrcAlpha
		//ColorMask RGB
		//Cull Front
		//Lighting Off 
		//ZWrite Off
		//ZTest Off
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask RGB
	//	Cull Off 
		Lighting Off 
		ZWrite Off
		ZTest Off

		SubShader {
			Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		//	#pragma multi_compile_particles
			
			#include "Assets/Resources/QTShader/QTCGShader.cginc"
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"
			#include "UnityShaderVariables.cginc"

			#pragma target 3.0

			#define PI 3.1416

				sampler2D _MainTex;
				fixed4 _TintColor;

				float4 _MainTex_ST;

				half MaxLifeTime;
				half MaxHigh;
				half WeatherTime;

				half colorParamScale;
				half fun1_w;
				half fun2_w;
				half4 baseColorParam;
			
				struct appdata_t {
					fixed4 vertex : POSITION;
					fixed2 texcoord : TEXCOORD0;
					fixed2 texcoord2 : TEXCOORD1;
					fixed4 color : COLOR0;
					fixed4 tangent: TANGENT;
				};

				struct v2f {
					fixed4 vertex : POSITION;
					fixed2 texcoord : TEXCOORD0;
					fixed4 color : COLOR0;
				};

				// max absolute error 9.0x10^-3
				// Eberly's polynomial degree 1 - respect bounds
				// 4 VGPR, 12 FR (8 FR, 1 QR), 1 scalar
				// input [-1, 1] and output [0, PI]
				float acosFast(float inX) 
				{
					float x = abs(inX);
					float res = -0.156583f * x + (0.5 * PI);
					res *= sqrt(1.0f - x);
					return (inX >= 0) ? res : PI - res;
				}

				// Same cost as acosFast + 1 FR
				// Same error
				// input [-1, 1] and output [-PI/2, PI/2]
				float asinFast( float x )
				{
					return (0.5 * PI) - acosFast(x);
				}
			
				half myMod(half x, half y)
				{
					return x - y*floor(x / y);
				}

				v2f vert (appdata_t v)
				{
					v2f o;

					half dis = v.texcoord2.x + v.texcoord2.y * WeatherTime;// _Time.y;
					dis = MaxHigh - dis;
					dis = myMod(dis,MaxHigh);
					dis = MaxHigh - dis;
					dis = dis - v.texcoord2.x;
					//dis = v.texcoord2.x + dis;
					half4 pos = v.vertex;
					pos.y += dis;
					
					//pos.xyz += v.tangent.xyz * sin(_Time.y)*cos(0.3+0.5*(_Time.y));
					half paramX = WeatherTime / MaxLifeTime;
					half f1_p = baseColorParam.r + v.color.r * colorParamScale;
					half f1_a = baseColorParam.g + v.color.g * colorParamScale;
					half f2_p = baseColorParam.b + v.color.b * colorParamScale;
					half f2_a = baseColorParam.a + v.color.a * colorParamScale;
					
					pos.xyz += v.tangent.xyz * (f1_a * sin(fun1_w*(paramX + f1_p))+f2_a*cos(fun2_w*(paramX + f2_p)));
					//pos.xyz += v.tangent.xyz * (f1_a * sin(6.283 * fun1_w * paramX) + f2_a * cos(6.283 * fun2_w * paramX));
					
					//pos.x += sin(6.283 * WeatherTime / MaxLifeTime);

					o.vertex = mul(UNITY_MATRIX_MVP, pos);
					o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
					o.color = v.color;

					//o.color.rgb = v.texcoord2.x / 15;

					//o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					//o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
					//o.color = v.color;

					//o.color.rgb = WeatherTime / 14;

					return o;
				}
			
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 c = tex2D(_MainTex, i.texcoord);
					c = 2.0f * _TintColor * c;
					//c.a *= _TintColor.a;
					FinalColor(c);
					//c.rgb = i.color.rgb;
					//c.a = 1;
					return c;
				}
				ENDCG 
			}
		}	
	}
}
