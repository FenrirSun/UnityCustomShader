Shader "TS_QT/postprocessor/BloomMixAndAdjustColor" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_FuzzyTex ("Fuzzy Map", 2D) = "black" {}
		_FuzzyForce("Fuzzy Force", Range(0,2)) = 0.8
		_SourceForce("Source Force", Range(0,1)) = 1
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
			#pragma multi_compile ADJUST_COLOR_OFF ADJUST_COLOR_ON 
			#pragma target 3.0

			#include "UnityCG.cginc"
			
			#define Saturation (_ColorParam.x) //饱和度
			#define Brightness (_ColorParam.y)   //对比度
			#define Lightness (_ColorParam.z)  //亮度

			sampler2D _MainTex;
			sampler2D _FuzzyTex;
			sampler2D _AdjustR;
			sampler2D _AdjustG;
			sampler2D _AdjustB;
			//sampler2D _GammaTex;
			//sampler3D _LutTex;
			float4 _MainTex_ST;
			half _FuzzyForce;
			half _SourceForce;

			float4 _ColorParam; //x:饱和度 y:对比度 z:亮度
			fixed4 _BaseBrightness; //对比度变换基础
			
			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			//模拟3D纹理采样，_recParCount为分段数的倒数
			float4 QT_tex3d(sampler2D _tex, half3 _uvw, half _parCount)
			{
			if(_uvw.x >= 0.99)
			{
				_uvw.x = 0.99;
			}
			if(_uvw.y >= 0.99)
			{
				_uvw.y = 0.99;
			}
			if(_uvw.z >= 0.99)
			{
				_uvw.z = 0.99;
			}
				fixed layer = _uvw.y * _parCount;
				fixed big = ceil(layer);
				fixed small = floor(layer);
				fixed4 bigColor = tex2D(_tex, fixed2(_uvw.x/_parCount + big / _parCount, _uvw.z));
				fixed4 smallColor = tex2D(_tex, fixed2(_uvw.x/_parCount + small / _parCount, _uvw.z));
				//return float4(big/16, small/16, layer,1);
				//return float4(_uvw.x/_parCount + big / _parCount, _uvw.y, big/16,1);
				//return tex2D(_tex, float2(_uvw.x/_parCount + big * _parCount, _uvw.y));
				//return bigColor;
				return lerp(smallColor, bigColor,layer-small);
			}

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			
			half4 frag(v2f i) : COLOR
			{
				half4 c = tex2D(_MainTex, i.uv);
				
				c = c * _SourceForce;
				
			/*	#if SHADER_API_D3D9
				i.uv.y = 1-i.uv.y;
				#endif
				#if SHADER_API_D3D11
				i.uv.y = 1-i.uv.y;
				#endif*/
				half4 f = tex2D(_FuzzyTex, i.uv) * _FuzzyForce;
				
				c = c + f;
				//return c;
				#ifdef ADJUST_COLOR_ON
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
				#endif
				c.a = 1;
				return c;
			}
			
			ENDCG
		}
	} 
	FallBack Off
}
