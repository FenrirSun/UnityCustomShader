Shader "TS_QT/Particles/GroundEffect_Additive" {
		Properties{
			_TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
			_MainTex("Particle Texture", 2D) = "white" {}
		}

			Category{
			Tags{ "RenderType" = "Opaque"
			"Queue" = "Geometry+301"
			"IgnoreProjector" = "True"}
			//Tags{ "RenderType" = "Opaque" }
			Blend SrcAlpha One
			ColorMask RGB
			Cull Off Lighting Off ZWrite Off Fog{ Color(0,0,0,0) }
			ZWrite Off
			ZTest Off

			SubShader{
			Pass{

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

		v2f vert(appdata_t v)
		{
			v2f o;
			o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
			o.color = v.color;
			o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
			return o;
		}

		sampler2D _CameraDepthTexture;
		fixed _InvFade;

		fixed4 frag(v2f i) : COLOR
		{
			fixed4 color = 2.0f * _TintColor * i.color * tex2D(_MainTex, i.texcoord);
		FinalColor(color);
		return color;
		}
			ENDCG
		}
		}
		}
	}
