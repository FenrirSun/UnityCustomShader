// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "TAShaders/UI/OverlayNoZTest_UVAnim"
 {
     Properties
     {
         [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        // _MainColor ("Tint", Color) = (1,1,1,1)
         
         
         /*
         // UI Mask
         _StencilComp ("Stencil Comparison", Float) = 8
         _Stencil ("Stencil ID", Float) = 0
         _StencilOp ("Stencil Operation", Float) = 0
         _StencilWriteMask ("Stencil Write Mask", Float) = 255
         _StencilReadMask ("Stencil Read Mask", Float) = 255
  
         _ColorMask ("Color Mask", Float) = 15
         */
         

         //_NoiseTex ("NoiseTex (R)",2D) = "white"{}
         //_DissolveFactor ("DissolveFactor",Range(0,1)) = 0.001
         
         _FlowTex("_FlowTexMultipiler",2D) = "white"{}
         _UVAnimXSpeed("_UVAnimXSpeed",float) = 1
		 _UVAnimYSpeed("_UVAnimYSpeed",float) = 1
         _FlowTexMultipiler ("_FlowTexMultipiler",Range(0,1)) = 1

     }
  
     SubShader
     {
         Tags
         { 
             "Queue"="Overlay" 
             "IgnoreProjector"="True" 
             "RenderType"="Transparent" 
             "PreviewType"="Plane"
             "CanUseSpriteAtlas"="True"
         }
         
         Cull Off
         Lighting Off
         ZWrite Off
         ZTest Off
         Blend SrcAlpha OneMinusSrcAlpha
 
         Pass
         {
        	CGPROGRAM
             #pragma vertex vert
             #pragma fragment frag
             #include "UnityCG.cginc"

			 float _UVAnimXSpeed;
		 float _UVAnimYSpeed;
		 float4 _MainColor;
			 sampler2D _MainTex;
			 sampler2D _FlowTex;
			
             fixed4 _TextureSampleAdd; 
             fixed _FlowTexMultipiler;
             

             struct appdata_t
             {
                 float4 vertex   : POSITION;
                 float2 texcoord : TEXCOORD0;
             };
  
             struct v2f
             {
                 float4 vertex   : SV_POSITION;
                 half2 texcoord  : TEXCOORD0;
             };
              

  
             v2f vert(appdata_t IN)
             {
                 v2f OUT;
                 OUT.vertex = UnityObjectToClipPos(IN.vertex);
                 OUT.texcoord = IN.texcoord;
                 return OUT;
             }
  
   
  
             fixed4 frag(v2f IN) : SV_Target
             {
                half4 color = tex2D(_MainTex, IN.texcoord);  
                 
				// UV动画 以及 流光贴图采样
				float2 uv = IN.texcoord;
				uv.x *= 0.5f;
				uv.x += _Time.y * _UVAnimXSpeed;
				////////
				uv.y *= 0.5f;
				uv.y += _Time.y * _UVAnimYSpeed;

				float4 flow = tex2D(_FlowTex, uv);
				
				// 最终颜色
				fixed4 final = fixed4(color.rgb + flow.rgb * flow.a * _FlowTexMultipiler, color.a);

                return final;
             }
         ENDCG
         }
     }
 }