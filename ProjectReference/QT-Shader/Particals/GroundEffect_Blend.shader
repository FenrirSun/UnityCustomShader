Shader "TS_QT/Particles/GroundEffect_Blend"
{
		Properties{
			_TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
			_MainTex("Particle Texture", 2D) = "white" {}
		}

			Category{
			Tags{ "RenderType" = "Opaque"
			"Queue" = "Geometry+301"
			"IgnoreProjector" = "True" }
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
			Cull Off
			Lighting Off
			ZWrite Off
			ZTest Off

			SubShader{
			Pass{

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
			//	#pragma multi_compile_particles

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

		float4 _MainTex_ST;

		v2f vert(appdata_t v)
		{
			v2f o;
			o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
			o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
			o.color = v.color;// fixed4(1,1,1,1);// v.color;
			return o;
		}

		fixed4 frag(v2f i) : COLOR
		{
			fixed4 c = tex2D(_MainTex, i.texcoord);
		//clip(c.a - 0.001);
		c = 2.0f * _TintColor * i.color * c;
		//c.a *= _TintColor.a;
		FinalColor(c);
		return c;
		}
			ENDCG
		}
		}
		}
	}
