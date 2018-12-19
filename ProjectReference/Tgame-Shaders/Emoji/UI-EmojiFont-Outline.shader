
//	Author:zouchunyi
//	E-mail:zouchunyi@kingsoft.com

Shader "UI/EmojiFont_OutLine" {
	Properties {
		[PerRendererData] _MainTex ("Font Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		
		_ColorMask ("Color Mask", Float) = 15
		
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0

		_EmojiTex ("Emoji Texture", 2D) = "white" {}
		_EmojiDataTex ("Emoji Data", 2D) = "white" {}
		_EmojiSize ("Emoji count of every line",float) = 200
		_FrameSpeed ("FrameSpeed",Range(0,10)) = 3

        _BorderWidth ("Border Width", Float) = 1
        _BorderColor ("Border Color", Color) = (0,0,0,1)
	}
	
	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
		}
		
		Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp] 
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
		}

		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		Pass
		{
			Name "Default"
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
				float2 texcoord2 : TEXCOORD2;
				float2 texcoord3 : TEXCOORD3;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				half2 texcoord1 : TEXCOORD1;

				float4 worldPosition : TEXCOORD5;
                half4 clipRect : TEXCOORD2;
				half2 borderWidth : TEXCOORD3;
				half4 oriArea : TEXCOORD6;
				half4 borderColor : TEXCOORD4;
			};
			
			fixed4 _Color;
			fixed4 _TextureSampleAdd;
			float4 _ClipRect;
			half _BorderWidth;
			fixed4 _BorderColor;
			sampler2D _MainTex;
			half4 _MainTex_TexelSize;

			v2f vert(appdata_t v)
			{
				v2f OUT;
				OUT.worldPosition = v.vertex;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);
				//OUT.vertex = UnityObjectToClipPos(float4(IN.vertex.x, IN.vertex.y, IN.vertex.z, 1.0));

				OUT.texcoord = v.texcoord;
				OUT.texcoord1 = v.texcoord1;

				OUT.oriArea =half4(v.texcoord2.x,v.texcoord2.y,v.texcoord3.x,v.texcoord3.y);
				half2 borderWidth = _BorderWidth / _MainTex_TexelSize.zw;

				OUT.clipRect = half4(OUT.oriArea.xy + borderWidth,OUT.oriArea.zw - borderWidth);
				OUT.oriArea = half4(OUT.oriArea.xy - borderWidth,OUT.oriArea.zw + borderWidth);

                OUT.borderWidth = borderWidth;

				OUT.borderColor.rgb =_BorderColor.rgb;
				OUT.borderColor.a = OUT.color.a;

				#ifdef UNITY_HALF_TEXEL_OFFSET
				OUT.vertex.xy += (_ScreenParams.zw-1.0) * float2(-1,1) * OUT.vertex.w;
				#endif
				
				OUT.color = v.color * _Color;
				return OUT;
			}

			//sampler2D _MainTex;
			sampler2D _EmojiTex;
			sampler2D _EmojiDataTex;
		    float _EmojiSize;
			float _FrameSpeed;

			fixed4 frag(v2f IN) : SV_Target
			{
				fixed4 color;
				if (IN.texcoord1.x >0 && IN.texcoord1.y > 0)
				{
					// it's an emoji

					// compute the size of emoji
					half size = (1 / _EmojiSize);
					// compute the center uv of per pixel in the emoji
					half2 uv = half2(floor(IN.texcoord1.x * _EmojiSize) * size + 0.5 * size,floor(IN.texcoord1.y * _EmojiSize) * size + 0.5 * size);
					// read data
					fixed4 data = tex2D(_EmojiDataTex, uv);
					// compute the frame count of emoji
					half frameCount = 1 + sign(data.r) + sign(data.g) * 2 + sign(data.b) * 4;
					// compute current frame index of emoji
					half index = abs(fmod(floor(_Time.x * _FrameSpeed * 50), frameCount));
					// judge current frame is in the next line or not.
					half flag = (1 + sign(IN.texcoord1.x + index * size - 1)) * 0.5;
					// compute the final uv
					IN.texcoord1.x += index * size - flag;
					IN.texcoord1.y += size * flag;

					color = tex2D(_EmojiTex, IN.texcoord1);
				}else
				{
					// it's a text, and render it as normal ugui text
					color = (tex2D(_MainTex, IN.texcoord) + _TextureSampleAdd) * IN.color;

					half4 border1 = tex2D(_MainTex, IN.texcoord + IN.borderWidth);
					half4 border2 = tex2D(_MainTex, IN.texcoord - IN.borderWidth) ;

					half2 borderA =half2(IN.borderWidth.x,0);
					half4 border1a = tex2D(_MainTex, IN.texcoord +borderA);
					half4 border2a = tex2D(_MainTex, IN.texcoord -borderA);

					IN.borderWidth.x = -IN.borderWidth.x;
					half4 border3 = tex2D(_MainTex, IN.texcoord + IN.borderWidth);
					half4 border4 = tex2D(_MainTex, IN.texcoord - IN.borderWidth);

					half2 borderB =half2(0,IN.borderWidth.y);
					half4 border3a = tex2D(_MainTex, IN.texcoord +borderB);
					half4 border4a = tex2D(_MainTex, IN.texcoord -borderB);

					half2 maxXYMuBorder = step(IN.texcoord.xy,IN.clipRect.zw); //XY <maxXY -borderWidth?
					half2 minXYAddBorder = step(IN.clipRect.xy,IN.texcoord.xy);//XY >= minXY +borderWidth?

					half2 minXYMuEdge = step(IN.oriArea.xy,IN.texcoord.xy);//XY >= minXY -edgeWidth?
					half2 maxXYAddEdge = step(IN.texcoord.xy,IN.oriArea.zw); //XY <maxXY +edgeWidth?

					//Need to dectect 4 edges 
					border1 *=minXYMuEdge.x *maxXYMuBorder.x *maxXYMuBorder.y *minXYMuEdge.y;
					border2 *= minXYAddBorder.x *maxXYAddEdge.x *maxXYAddEdge.y *minXYAddBorder.y;
					border3 *= minXYAddBorder.x  *maxXYAddEdge.x *maxXYMuBorder.y *minXYMuEdge.y;
					border4 *= minXYMuEdge.x  *maxXYMuBorder.x *minXYAddBorder.y *maxXYAddEdge.y;

					border1a *=minXYMuEdge.y*maxXYMuBorder.x *maxXYMuBorder.y *minXYMuEdge.x;
					border2a *= minXYAddBorder.x *minXYAddBorder.y*maxXYAddEdge.y *maxXYAddEdge.x;
					border3a *=minXYMuEdge.y *minXYMuEdge.x *maxXYMuBorder.y *maxXYMuBorder.x;
					border4a *=minXYAddBorder.y *minXYAddBorder.x *maxXYAddEdge.x *maxXYAddEdge.y;

					half4 border = (saturate(border1 + border2 + border3 + border4 +border1a+border2a+border3a+border4a) 
					+ _TextureSampleAdd) 	*IN.borderColor;

					half inside =minXYMuEdge.x*minXYMuEdge.y*maxXYAddEdge.x*maxXYAddEdge.y;

					color = color * color.a* inside + border * (1 - color.a);

					//color = color * color.a + border * (1 - color.a);
					color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);


				}

				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
}
