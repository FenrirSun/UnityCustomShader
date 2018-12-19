//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Particles/Weather" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_Tex1 ("Texture 1", 2D) = "white" {}
	_Tex2 ("Texture 2", 2D) = "white" {}
	_Tex3 ("Texture 3", 2D) = "white" {}
	_Tex4 ("Texture 4", 2D) = "white" {}
	_Speed("Speed",float) = 0.2
	_SpeedScale("Speed Scale",Vector) = (8,4,2,1)
}

Category {
	Tags { "Queue"="Transparent+400" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	ColorMask RGB
	Cull Front
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

			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _Tex4;
			fixed4 _TintColor;
			fixed _Speed;

			fixed4 _SpeedScale;
			
			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f {
				fixed4 vertex : POSITION;
				fixed2 texcoord1 : TEXCOORD0;
				fixed2 texcoord2 : TEXCOORD1;
				fixed2 texcoord3 : TEXCOORD2;
				fixed2 texcoord4 : TEXCOORD3;
				fixed4 color : COLOR;
			};
			
			float4 _Tex1_ST;
			float4 _Tex2_ST;
			float4 _Tex3_ST;
			float4 _Tex4_ST;

			float4 WeatherTime;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.texcoord1 = TRANSFORM_TEX(v.texcoord * _Time.yy, _Tex1);
				//v.texcoord.y += _Time.y * _Speed;
				//o.texcoord1 = TRANSFORM_TEX((v.texcoord + fixed2(0,_Time.y * _Speed * _SpeedScale.x)),_Tex1);
				o.texcoord1 = TRANSFORM_TEX((v.texcoord + fixed2(0,WeatherTime.x * _Speed * _SpeedScale.x)),_Tex1);
				o.texcoord2 = TRANSFORM_TEX((v.texcoord + fixed2(0,WeatherTime.y * _Speed * _SpeedScale.y)),_Tex2);
				o.texcoord3 = TRANSFORM_TEX((v.texcoord + fixed2(0,WeatherTime.z * _Speed * _SpeedScale.z)),_Tex3);
				o.texcoord4 = TRANSFORM_TEX((v.texcoord + fixed2(0,WeatherTime.w * _Speed * _SpeedScale.w)),_Tex4);
				//o.texcoord1 = TRANSFORM_TEX((v.texcoord.xy + fixed2(0,0) ),_Tex1);
				//o.texcoord2 = TRANSFORM_TEX(v.texcoord,_Tex2);
				//o.texcoord3 = TRANSFORM_TEX(v.texcoord,_Tex3);
				//o.texcoord4 = TRANSFORM_TEX(v.texcoord,_Tex4);
				o.color = v.color;
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 c1 = tex2D(_Tex1, i.texcoord1);
				fixed4 c2 = tex2D(_Tex2, i.texcoord2);
				fixed4 c3 = tex2D(_Tex3, i.texcoord3);
				fixed4 c4 = tex2D(_Tex4, i.texcoord4);
				fixed4 c = 0;
				c.rgb = 1;
				c.rgb = c.a * c.rgb + c4.a * c4.rgb;
				c.a += c4.a;
				c.rgb = c.a * c.rgb + c3.a * c3.rgb;
				c.a += c3.a; 
				c.rgb = c.a * c.rgb + c2.a * c2.rgb;
				c.a += c2.a;
				c.rgb = c.a * c.rgb + c1.a * c1.rgb;
				c.a += c1.a;
				c.rgb = _TintColor;

				//c.rgb = c1.rgb;
				//c.a = c1.a;
				//c = 2.0f * _TintColor * i.color * c;
				FinalColor(c);
				//c = c3;
				return c;
			}
			ENDCG 
		}
	}	
}
}
