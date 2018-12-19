//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Particles/NoiseWarpBlend" {
	Properties {
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_NoiseTex ("Noise", 2D) = "black" {}
		_MaskTex ("Mask", 2D) = "white" {}
		_StrengthX  ("Offset Strength X", Float) = 0.05     //偏移强度
		_StrengthY  ("Offset Strength Y", Float) = 0.05
		_NoiseSpeed("Noise Speed", Vector) = (0.2,0.2,0,0)
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.1
		_Alpha("Alpha Blend", Range(0,1)) = 1
	}
	Category 
	{
		
		Tags { "Queue"="Transparent+50" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha

		ColorMask RGB
		Cull Off Lighting Off ZWrite Off

		SubShader {
		/*	GrabPass {		
				"_ZGrabTex"					
				//Name "BASE"
				//Tags { "LightMode" = "Always" }
 			}
			*/
			Pass {
		
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
			//	#pragma multi_compile_particles
				#pragma multi_compile QT_WARP_ON QT_WARP_OFF
				//#pragma target 3.0
			
				#include "Assets/Resources/QTShader/QTCGShader.cginc"

				sampler2D _NoiseTex;
				sampler2D _MaskTex;
				//sampler2D _GrabTexture;
				sampler2D _QT_GrabTex;
				sampler2D _MainTex;
				fixed4 _TintColor;
				fixed _Alpha;

				uniform half _StrengthX;
				uniform half _StrengthY;
				uniform half4 _NoiseSpeed;
			
				struct appdata_t {
					fixed4 vertex : POSITION;
					fixed4 color : COLOR;
					fixed2 texcoord : TEXCOORD0;
				};

				struct v2f {
					fixed4 vertex : POSITION;
					fixed2 texcoord : TEXCOORD0;
					fixed4 grabUV : TEXCOORD1;
					fixed4 color : COLOR;
				};
			
				float4 _MaskTex_ST;
				float4 _NoiseTex_ST;
				half _Cutoff;

				v2f vert (appdata_t v)
				{
					v2f o;
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.texcoord = TRANSFORM_TEX(v.texcoord,_NoiseTex);
					o.color = v.color;
					o.grabUV =  ComputeScreenPos(o.vertex); // ComputeGrabScreenPos(o.vertex);   //计算当前顶点，映射的屏幕纹理的UV坐标
					//o.grabUV.xy = o.grabUV.xy/o.grabUV.w;         //除以缩放
					return o;
				}
			
				fixed4 frag (v2f i) : COLOR
				{
				#ifdef QT_WARP_ON
					fixed4 maskTexColor = tex2D(_MaskTex, i.texcoord);
					clip(maskTexColor.a - _Cutoff);
					fixed2 nosieUV = i.texcoord.xy + (_Time.y * _NoiseSpeed.xy);    //计算当前时间的噪声扰动纹理UV坐标
					fixed2 offsetColor =tex2D(_NoiseTex, nosieUV).rg - 0.5;        //纹理偏移颜色，将0~1区间变换到-0.5~0.5
					fixed2 offsetUV = offsetColor.rg * half2(_StrengthX * maskTexColor.a * maskTexColor.a,_StrengthY * maskTexColor.a* maskTexColor.a); //计算最终的UV偏移向量
					fixed2 uv = (i.grabUV.xy / i.grabUV.w) + offsetUV;        //最终UV
					fixed4 c = tex2D(_QT_GrabTex, uv);  
					fixed4 tc = tex2D(_MainTex, i.texcoord);
					c.rgb = lerp(c.rgb, tc.rgb * 2.0f * _TintColor.rgb,  tc.a * _TintColor.a);
					c.a = _Alpha * tc.a;
					c *= i.color;
				#endif

				#ifdef QT_WARP_OFF
					fixed4 c = fixed4(0,0,0,0);
				#endif

					FinalColor(c);
					return c;
				}
				ENDCG 
			}
		}	
	}
}
