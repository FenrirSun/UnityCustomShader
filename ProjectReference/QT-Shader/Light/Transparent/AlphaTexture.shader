//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Light/Alpha Texture" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
	_Cutoff("Alpha cutoff", Range(0,1)) = 0.1
}

Category {
	Tags { "RenderType"="Opaque" "Queue" = "Geometry" }
	//Tags { "RenderType"="Transparent"}
		LOD 200

	Lighting Off
	ZTest On
	ZWrite On

	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed4 _TintColor;
			fixed _Cutoff;
			
			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f {
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
			};
			
			float4 _MainTex_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 c = tex2D(_MainTex, i.texcoord);
				clip(c.a - _Cutoff - 0.001);
				return 2.0f * _TintColor * c;
				//c.rgb = (c.b - 0.5) * 2;
				//c.a = 1;
				//return c;
			}
			ENDCG 
		}
	}	
}
}
