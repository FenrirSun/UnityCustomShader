//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Other/RoadShader" {
	Properties{
		_TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex("OpenTexture", 2D) = "white" {}
		_MainTex2("CloseTexture", 2D) = "white" {}
		_Progress("Progress", Range(0,1)) = 1 
		//secLen("secLen", float) = 1
	}

		Category{
		Tags{ "Queue" = "Transparent+10" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		LOD 200
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask RGB
		Cull Off
		Lighting Off
		ZWrite Off

		SubShader{
		Pass{

		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
		//	#pragma multi_compile_particles

#include "Assets/Resources/QTShader/QTCGShader.cginc"
		sampler2D _MainTex;
		sampler2D _MainTex2;
	fixed4 _TintColor;
	fixed _Progress;
	//fixed secLen;

	struct appdata_t {
		fixed4 vertex : POSITION;
		fixed4 color : COLOR;
		fixed2 texcoord : TEXCOORD0;
		fixed2 texcoord2 : TEXCOORD1;
	};

	struct v2f {
		fixed4 vertex : POSITION;
		fixed2 texcoord : TEXCOORD0;
		fixed2 texcoord2 : TEXCOORD1;
		fixed4 color : COLOR;
	};

	float4 _MainTex_ST;

		v2f vert(appdata_t v)
		{
			v2f o;
			o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
			o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
			o.texcoord2 = v.texcoord2;
			o.color = v.color;// fixed4(1,1,1,1);// v.color;
			return o;
		}

		fixed4 frag(v2f i) : COLOR
		{
			fixed4 c1 = tex2D(_MainTex, i.texcoord);
			fixed4 c2 = tex2D(_MainTex2, i.texcoord);
			//secLen = min(secLen, 100);
			//fixed sign = sign(_Progress - 1) + 1;
			_Progress = ceil(_Progress / i.texcoord2.x) * i.texcoord2.x;
			fixed p2 = saturate(sign(i.color.a - _Progress));
			fixed p1 = 1 - p2;
			//clip(c.a - 0.001);
			fixed4 c = 2.0f * _TintColor * ((p1 * c1) + (p2 * c2));
			//c.a *= _TintColor.a;
			FinalColor(c);
			//c.rgb = i.texcoord2.x;
			//c.a = 1;
			//c.rgb = i.color.a;
			//c.a = 1;
			return c;
		}
		ENDCG
	}
	}
	}
}
