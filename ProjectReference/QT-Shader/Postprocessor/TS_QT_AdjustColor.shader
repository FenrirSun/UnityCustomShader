Shader "TS_QT/postprocessor/AdjustColor" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_ColorParam("Adjust Param", Vector) = (1,1,1,1)
		_BaseBrightness("Base Brightness", Vector) = (0.5,0.5,0.5,1)
	}
	SubShader {
		ZTest Off
		ZWrite Off
		Tags { "RenderType"="Opaque" }
		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			#define Saturation (_ColorParam.x) //饱和度
			#define Brightness (_ColorParam.y)   //对比度
			#define Lightness (_ColorParam.z)  //亮度
			
			sampler2D _MainTex;
			sampler2D _AdjustR;
			sampler2D _AdjustG;
			sampler2D _AdjustB;

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			 
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.texcoord;
				return o;
			}
			
			half4 frag(v2f i) : COLOR
			{
				half4 c = tex2D(_MainTex, i.uv);
				//#ifdef ADJUST_COLOR_ON
				c.r = tex2D(_AdjustR, fixed2(c.r,0)).a;
				c.g = tex2D(_AdjustG, fixed2(c.g,0)).a;
				c.b = tex2D(_AdjustB, fixed2(c.b,0)).a;
			//	fixed luminance = Luminance(c.rgb);
			//	fixed4 gammaColor = tex2D(_GammaTex, fixed2(luminance,0));
			//	fixed adjustFactor = gammaColor.a / luminance;
			//	c = half4(lerp(fixed3(luminance,luminance,luminance), c.rgb, Saturation),1);
			//	c = half4(lerp(_BaseBrightness.rgb, c.rgb,Brightness), 1);
			//	c.rgb = c.rgb * adjustFactor;
			//	c.rgb = QT_tex3d(_GammaTex,c.rgb,16);
			//	c.rgb = QT_tex3d(_GammaTex,float3(0.5,0.5,0),16);
			//	c.rgb = tex3D(_LutTex, c.rgb * 0.333f).rgb * 3;
				//#endif
				c.a = 1;
				return c;
			}
			 
			ENDCG
		}
	} 
	FallBack Off
}
