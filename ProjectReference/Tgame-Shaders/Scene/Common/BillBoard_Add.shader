//add offset 
Shader "TSHD/Billboard/BillBoard_Add" {
   Properties {
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,1)
      _MainTex ("Texture Image", 2D) = "white" {}
      _ScaleX ("Scale X", Float) = 1.0
      _ScaleY ("Scale Y", Float) = 1.0
	  	_ViewerOffset("Viewer offset", Range(-0.1,0.1)) = 0
   }
   SubShader {
   	          Tags {
			  "Queue"="Transparent"
			  "RenderType"="Transparent"
			"DisableBatching" = "True"
        }
		Blend SrcAlpha One
		//Offset -10000, 0
      Pass {   

         CGPROGRAM
		#include "UnityCG.cginc" 
         #pragma vertex vert  
         #pragma fragment frag

         // User-specified uniforms            
         uniform sampler2D _MainTex;  
		  fixed4 _TintColor;
         uniform float _ScaleX;
         uniform float _ScaleY;
		 float _ViewerOffset;

         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 uv : TEXCOORD0;
         };
 
         vertexOutput vert(appdata_base v) 
         {
            vertexOutput o;
			//float4(0,0,0,1): obj original poin --->view space
			//+ vertex.xy
            o.pos = mul(UNITY_MATRIX_P, mul(UNITY_MATRIX_MV, float4(0.0, 0.0, 0.0, 1.0))
			    //o.pos = mul(UNITY_MATRIX_P, UnityObjectToViewPos(float4(0.0, 0.0, 0.0, 1.0))
             + float4(v.vertex.x, v.vertex.y, 0.0, 0.0)
              * float4(_ScaleX, _ScaleY, 1.0, 1.0));

			#if defined(UNITY_REVERSED_Z)
				o.pos +=float4(0,0,_ViewerOffset,0);
			#elif defined(SHADER_API_D3D9) || defined(SHADER_API_D3D11_9X)|| defined(SHADER_API_D3D11)
				o.pos +=float4(0,0,_ViewerOffset,0);
 			#else
				o.pos -=float4(0,0,_ViewerOffset*2,0);
			#endif
 
            o.uv = v.texcoord;

            return o;
         }
 
         float4 frag(vertexOutput input) : COLOR
         {
            return tex2D(_MainTex, float2(input.uv.xy))*_TintColor;   
         }
 
         ENDCG
      }
   }
}