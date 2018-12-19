//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Particles/CheckColor" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	
}

Category {
	Tags { "RenderType"="Opaque" "Queue" = "Geometry+500"  "IgnoreProjector"="True"}

	Blend SrcAlpha OneMinusSrcAlpha
		ZTest On
		ZWrite On
		LOD 200
	
	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma multi_compile_particles

			#include "Assets/Resources/QTShader/QTCGShader.cginc"

			sampler2D _MainTex;
			fixed4 _TintColor;
			
			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f {
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};
			
			fixed4 _MainTex_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color;
				o.texcoord = v.texcoord;
				return o;
			}

			sampler2D _CameraDepthTexture;
			fixed _InvFade;
			
			fixed4 frag (v2f i) : COLOR
			{
				fixed4 color = _TintColor * i.color;
				//color.rgb = color.a;
				color.a = 1;
				return color;
			}
			ENDCG 
		}
	}	
}
}
