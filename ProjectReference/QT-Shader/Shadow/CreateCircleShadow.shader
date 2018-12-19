Shader "TS_QT/Shadow/CreateCircleShadow"
{
	Properties
	{
		//_CircleShadowColor("Color", Color) = (0,0,0,1)
		//_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		Blend SrcAlpha One
		ColorMask RGB
		LOD 100
		ZWrite Off
		ZTest Off

		Pass
	{
		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
		// make fog work
#pragma multi_compile_fog

#include "UnityCG.cginc"

		struct appdata
	{
		float4 vertex : POSITION;
		//float2 uv : TEXCOORD0;
	};

	struct v2f
	{
		float4 vertex : SV_POSITION;
	};

	float4 _CircleShadowColor;

	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
		return o;
	}

	fixed4 frag(v2f i) : SV_Target
	{
		return _CircleShadowColor;
	}
		ENDCG
	}
	}
}
