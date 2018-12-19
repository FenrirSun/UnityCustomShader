// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Projector' with 'unity_Projector'
// Upgrade NOTE: replaced '_ProjectorClip' with 'unity_ProjectorClip'

Shader "TGame/Projector/AlphaBlended" 
{
	Properties 
	{
		_BurnAmount ("Burn Amount", Range(0.0, 1.0)) = 0.0
		_LineWidth("Burn Line Width", Range(0.0, 0.7)) = 0.1
		_TransparentWidth("Transparent Width", Range(0.0, 1.0)) = 0.1

		_Color ("Main Color", Color) = (1,1,1,1)
		_ShadowTex ("Cookie", 2D) = "" {}
		_FalloffTex ("FallOff", 2D) = "" {}
		_BurnTex ("Burn Noise, the r value which is smaller is first disappeared, the a value decides where disappeared", 2D) = "" {}

		_BurnFirstColor("Burn First Color", Color) = (1, 0, 0, 1)
		_BurnSecondColor("Burn Second Color", Color) = (1, 0, 0, 1)
		_Multipiler ("Multipiler",Range(0, 10)) = 1

		_XOffset("Horizontal Offset", float) = 0.01
		_YOffset("Vertical Offset", float) = 0.01
	}
	
	Subshader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
		Pass {
			Cull Off Lighting Off ZWrite Off
			ColorMask RGB
			
			Offset -1, -1
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			#include "UnityCG.cginc"
			
			struct a2v {
				float4 vertex : POSITION;
				float4 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};

			struct v2f {
				float4 uvShadow : TEXCOORD0;
				float4 uvFalloff : TEXCOORD1;
				float4 uvBurn : TEXCOORD2;
				fixed4 color : COLOR;
				UNITY_FOG_COORDS(3)
				float4 pos : SV_POSITION;
			};
			
			float4x4 unity_Projector;
			float4x4 unity_ProjectorClip;

			fixed _BurnAmount;
			fixed _LineWidth;
			fixed _TransparentWidth;

			fixed _XOffset;
			fixed _YOffset;

			fixed4 _BurnFirstColor;
			fixed4 _BurnSecondColor;
			fixed _Multipiler;
			
			fixed4 _Color;
			sampler2D _ShadowTex;
			sampler2D _FalloffTex;
			sampler2D _BurnTex;
			float4 _BurnTex_ST;
			
			v2f vert (a2v v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos (v.vertex);
				o.uvShadow = mul (unity_Projector, v.vertex);
				o.uvFalloff = mul (unity_ProjectorClip, v.vertex);
				o.uvBurn = mul (unity_Projector, v.vertex);
				o.color = v.color;
				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed2 offset = fixed2(_XOffset, _YOffset);
				fixed4 burnColor = tex2Dproj (_BurnTex, UNITY_PROJ_COORD(i.uvBurn));
				
				clip(burnColor.r - _BurnAmount);
				fixed4 uvShadow = UNITY_PROJ_COORD(i.uvShadow);
				fixed2 uv = uvShadow.xy / uvShadow.w;
				uv += offset;
				
				fixed4 texS = tex2D(_ShadowTex, uv);
				texS.rgb *= _Color.rgb;
				
				fixed t = 1 - smoothstep(0.0, _LineWidth, burnColor.r - _BurnAmount);
				fixed3 color = lerp(_BurnFirstColor, _BurnSecondColor, t);
				color = pow(color, 5);
				color *= burnColor.a * texS.a;

				fixed4 texF = tex2Dproj (_FalloffTex, UNITY_PROJ_COORD(i.uvFalloff));
				fixed4 res = 2.0 * i.color * texS  * texF.a * _Multipiler;

				UNITY_APPLY_FOG_COLOR(i.fogCoord, res, fixed4(0,0,0,0));
				fixed3 finalColor = lerp(res.rgb, color, t * step(0.0001, _BurnAmount));
				fixed t1 = smoothstep(0.0, _TransparentWidth, burnColor.r - _BurnAmount);
				fixed t2 = lerp(0, 1, t1);
				fixed finalAlpha = lerp(1, t2, t2 * step(0.0001, _BurnAmount));
				return fixed4(finalColor.rgb, burnColor.a * texS.a * finalAlpha);
			}
			ENDCG
		}
	}
}
