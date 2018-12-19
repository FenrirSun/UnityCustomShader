//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Particles/SectorWarn" {
	Properties {
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_MaskTex ("Mask Texture",2D) = "black" {}
		_FlowTex ("Flow Texture", 2D) = "white" {}
		_Angle ("Sector Angle", float) = 90
		_LightRate("Light Rate", float) = 4
	}

	Category {
		Tags { "Queue"="Transparent+50" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask RGB
		Cull Off Lighting Off ZWrite Off

		SubShader {
			Pass {
		
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
			//	#pragma multi_compile_particles
			
				#include "Assets/Resources/QTShader/QTCGShader.cginc"

				sampler2D _MainTex;
				sampler2D _MaskTex;
				sampler2D _FlowTex;
				fixed4 _TintColor;
				float _Angle;
			
				struct appdata_t {
					fixed4 vertex : POSITION;
					fixed2 texcoord : TEXCOORD0;
					fixed4 color : COLOR;
				};

				struct v2f {
					fixed4 vertex : POSITION;
					fixed2 texcoord : TEXCOORD0;
					fixed4 verColor : TEXCOORD1;
				};
			
				float4 _MainTex_ST;
				fixed _LightRate;
				const float4 sectorDir = float4(0,0,1,0);

				v2f vert (appdata_t v)
				{
					v2f o;
					half ra =  radians(_Angle * 0.5) - 0.785 ;

					half cosA = cos(sign(v.vertex.x) * ra * v.color.r);
					half sinA = sin(sign(v.vertex.x) * ra * v.color.r);
					
					half tx = v.vertex.z * sinA + v.vertex.x * cosA;
					half tz = v.vertex.z * cosA - v.vertex.x * sinA; 

					v.vertex.x = tx;
					v.vertex.z = tz;
					v.vertex.y = 0;
					
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
					o.verColor = v.color;
					return o;
				}
				
				
				
				fixed4 frag (v2f i) : COLOR
				{
					fixed flowLength = 0.2;
					fixed flowSpeed = 0.5;
					fixed4 c = tex2D(_MainTex, i.texcoord);
				/*	fixed4 maskC = tex2D(_MaskTex, i.texcoord);

					fixed progress = fmod(flowSpeed * _Time.y,1);
					fixed oldProgress = progress;
					fixed progressEnd = progress - flowLength;
					fixed currP = maskC.x;
					if(progressEnd < 0)
					{
						//if(currP < progress)
						//{
							currP = 1 + currP;
						//}
						progress = progress + 1;
						progressEnd = progress - flowLength;
					}
					
					fixed fv = (currP - progressEnd) / flowLength;
					if(fv > 0.99)
					{
					fv = 0;
					}
					fixed fu = maskC.y;


					if(fu > 0.01 && fu < 0.99 && fv > 0.01 && fv < 0.99)
					{
						fixed4 flowC = tex2D(_FlowTex, fixed2(fu,fv));
						c.rgb = c.rgb + flowC.rgb;
					}*/
					clip(c.a - 0.001);
					fixed currTime = fmod(_Time.y, 6.28);
					c.a *= (sin(_LightRate * currTime) + 1) / 4 + 0.5;
					c = 2.0f * _TintColor * c;
					FinalColor(c);
					return c;
				}
				ENDCG 
			}
		}	
	}
}
