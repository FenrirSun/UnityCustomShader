//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Particles/Lightning" {
	Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
}

Category {
	Tags { "Queue"="Transparent+50" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha One
	//Blend SrcAlpha OneMinusSrcAlpha
	ColorMask RGB
	Cull Off Lighting Off ZWrite Off
	//Blend SrcAlpha One
	SubShader {
		Pass {
		
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "Assets/Resources/QTShader/QTCGShader.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _TintColor;
			fixed _OffsetGlobalWeight;
			fixed4 _PartOffsetWeight;
			fixed _width;
			fixed _OffsetMap_V;
			fixed _LightningLength;
			

			struct v2f {
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			//	float4 color : COLOR0;
			};
			
			half3 OneToHalfHundred(half3 value)
			{
				return ((value - 0.5) * 100);
			}


			v2f vert (appdata_full v)
			{
				v2f o;
				v.vertex.z *= _LightningLength * 0.01;
				half3 offset_0 = OneToHalfHundred(v.color.rgb);//((v.color.rgb - 0.5) * 100);
				half3 offset_1 = v.tangent.xyz * 10;
				half3 offset_2 = half3(v.texcoord1.xy, v.tangent.w) * 10;
				half3 offset_3 = v.normal.xyz * 10;
				
				//v.vertex.xyz += offset_1;
				//fixed offsetScale = 1 * (5 - abs(v.vertex.z - 5));
				
				//fixed3 offsetFinal = ((offset_1 * _PartOffsetWeight.x + offset_2 * _PartOffsetWeight.y + offset_3 * _PartOffsetWeight.z /*+ offset_4 * _PartOffsetWeight.w*/) * _OffsetGlobalWeight);
				//offsetFinal.xyz = offset_1.xyz * _OffsetGlobalWeight.xyz;
				//v.vertex.x *= _width;
				//v.vertex.xyz += offsetFinal.xyz;
				//_PartOffsetWeight = 0;
				//_PartOffsetWeight.y = 1;
				fixed3 offsetFinal = offset_0 * _PartOffsetWeight.x + offset_1 * _PartOffsetWeight.y + offset_2 * _PartOffsetWeight.z + offset_3 * _PartOffsetWeight.w;
				v.vertex.x *= _width;
				v.vertex.xyz += (offsetFinal * _OffsetGlobalWeight);
				
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				//o.color = v.color.rgb;

				//o.color = v.tangent * 10;
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				half4 c = tex2D(_MainTex, i.texcoord + float2(0,_OffsetMap_V));
				c = 2 * c * _TintColor;
				FinalColor(c);
				return c;
				//half4 c = ;
				//i.color.a = 1;
				//return i.color;
			}
			ENDCG 
		}
	}	
}
}
