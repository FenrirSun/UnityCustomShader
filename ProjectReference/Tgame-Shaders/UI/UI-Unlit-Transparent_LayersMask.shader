Shader "UI/Unlit/Transparent_LayersMask"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)

		_LayerMask1 ("Layer Mask1(RGBA)", 2D) = "black" {}
		_LayerMask2 ("Layer Mask2(RGBA)", 2D) = "black" {}
		_LayerMask3 ("Layer Mask3(RGBA)", 2D) = "black" {}

		_Layer1con("Layer1 Controller",vector) =(0,0,0,0)
		_Layer2con("Layer2 Controller",vector) =(0,0,0,0)
		_Layer3con("Layer3 Controller",vector) =(0,0,0,0)

		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15
		
		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
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
				};

				struct v2f
				{
					float4 vertex   : SV_POSITION;
					fixed4 color    : COLOR;
					half2 texcoord  : TEXCOORD0;
					float4 worldPosition : TEXCOORD1;
				};
			
				fixed4 _Color;
				fixed4 _TextureSampleAdd;
				float4 _ClipRect;
				float4 _Layer1con,_Layer2con,_Layer3con;

				v2f vert(appdata_t IN)
				{
					v2f OUT;
					OUT.worldPosition = IN.vertex;
					OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

					OUT.texcoord = IN.texcoord;
				
					#ifdef UNITY_HALF_TEXEL_OFFSET
					OUT.vertex.xy += (_ScreenParams.zw-1.0) * float2(-1,1) * OUT.vertex.w;
					#endif
				
					OUT.color = IN.color * _Color;
					return OUT;
				}

				sampler2D _MainTex;
				sampler2D _LayerMask1,_LayerMask2,_LayerMask3;

				fixed4 frag(v2f IN) : SV_Target
				{
					half4 color = (tex2D(_MainTex, IN.texcoord) + _TextureSampleAdd) * IN.color;

					half4 layer1 =tex2D(_LayerMask1, IN.texcoord);
					half4 layer2 =tex2D(_LayerMask2, IN.texcoord);
					half4 layer3 =tex2D(_LayerMask3, IN.texcoord);

					//color.a =0;
					//color.a += layer1.r *_Layer1con.r+layer1.g *_Layer1con.g +layer1.b *_Layer1con.b +layer1.a *_Layer1con.a;
					//color.a += layer2.r *_Layer2con.r+layer2.g *_Layer2con.g +layer2.b *_Layer2con.b +layer2.a *_Layer2con.a;
					//color.a += layer3.r *_Layer3con.r+layer3.g *_Layer3con.g +layer3.b *_Layer3con.b +layer3.a *_Layer3con.a;

					color.a =1;
					color.a -= saturate(layer1.r *_Layer1con.r + layer1.g *_Layer1con.g + layer1.b *_Layer1con.b + layer1.a *_Layer1con.a);
					color.a -= saturate(layer2.r *_Layer2con.r + layer2.g *_Layer2con.g + layer2.b *_Layer2con.b + layer2.a *_Layer2con.a);
					color.a -= saturate(layer3.r *_Layer3con.r + layer3.g *_Layer3con.g + layer3.b *_Layer3con.b + layer3.a *_Layer3con.a);

					color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
				
					#ifdef UNITY_UI_ALPHACLIP
					clip (color.a - 0.001);
					#endif

					return color;
				}
			ENDCG
			}
		}
	}
