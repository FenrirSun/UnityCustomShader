// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "UI/UnlitStencil_Add" {
	Properties {
	    _MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
		//_InvFade("Soft Particles Factor", Range(0.01,3.0)) = 1.0
		_MulScale("Grow Scale",float) = 2.0
        //_StencilOp ("Stencil Operation", Float) = 0
        //_StencilWriteMask ("Stencil Write Mask", Float) = 255
        //_StencilReadMask ("Stencil Read Mask", Float) = 255

  //      _ColorMask ("Color Mask", Float) = 15
		//[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}

SubShader {
	Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

		Stencil {
                Ref [_Stencil]
      			//Comp Equal
				Comp [_StencilComp]
                } 

		Cull Off
        Lighting Off
        ZWrite Off
        //ZTest [unity_GUIZTestMode]
        Blend SrcAlpha One

	Pass { 
	

		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;

			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _Color;
			half _MulScale;
			//float _InvFade;
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.color = v.color *_MulScale;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.texcoord)*i.color * _Color;
			
				return col;
			}
		ENDCG
	}
}

}