// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/CustomDepth"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag

            struct v2f 
            {
                float4 pos : SV_POSITION;
                float4 hpos : TEXCOORD0;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
		        o.hpos = o.pos;

                return o;
            }

            float4 frag(v2f input) : SV_Target
            {
                return input.hpos.z/input.hpos.w;
            }
			ENDCG
		}
	}
}
