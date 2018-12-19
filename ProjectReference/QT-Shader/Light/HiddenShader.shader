//标注打包简化版本时，包含关键字与排除关键字
//<Contain Keyword></Contain Keyword>
//<Exclude Keyword>SOFTPARTICLES_ON</Exclude Keyword>
Shader "TS_QT/Light/HideenShader" {
	Properties{
	}

		Category{
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry" }
		//Tags { "RenderType"="Transparent"}
		LOD 300

		Lighting Off
		ZTest Off
		ZWrite Off

		SubShader{
		Pass{

		CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"


	struct appdata_t {
		fixed4 vertex : POSITION;
	};

	struct v2f {
		fixed4 vertex : POSITION;
	};

	float4 _MainTex_ST;

	v2f vert(appdata_t v)
	{
		v2f o;
		o.vertex = fixed4(0, -1000000, 0,0);
		return o;
	}

	fixed4 frag(v2f i) : COLOR
	{
		return 1;
	}
		ENDCG
	}
	}
	}
}
