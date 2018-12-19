Shader "TS_QT/Shadow/ShadowMap" {
	Properties {
		//_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags {"RenderType"="Opaque" "Queue" = "Geometry"}
		Pass {
			Tags { "LightMode"="ForwardBase"}
			LOD 200
			//ZWrite Off
			//Blend One One
			ZTest On
		//	Blend SrcAlpha OneMinusSrcAlpha
	            
	        CGPROGRAM
	            // Apparently need to add this declaration 
	      //  #pragma multi_compile_fwdbase	
	            
	        #pragma vertex vert
	        #pragma fragment frag
	        
	        #include "UnityCG.cginc"

			struct v2f 
			{
				float4  pos : SV_POSITION;
				float2  depth: TEXCOORD0;
			};
				

			float4 QTDepthEncode(float depth)
			{
				//float temp = depth * 255;  
				//float temp2 = frac(temp);
				//temp = (temp - temp2);
				//float4 c;
				//c.r = temp /255;// 乘以1/255
				//c.g = temp2;// *255;
				//c.b = 0;
				//c.a = 1;

				//return c;

				return EncodeFloatRGBA(depth);
			}

				
			v2f vert (appdata_base v)
			{
				v2f o= (v2f)0;
				fixed offset = 0;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
				o.depth.x = COMPUTE_DEPTH_01; 

				return o;
			}
				
			half4 frag (v2f i) : COLOR
			{
				float4 c = QTDepthEncode(i.depth.x);  
				/*float temp = i.depth.x * 100;  
				temp = (temp - frac(temp)) * 0.01; 
				c.r = temp;
				c.g = (i.depth.x - temp)*100; 
				c.b = 0;
				
				c.a = 1;*/

				return c;
			}
			
			ENDCG
		}
	} 
	Fallback Off
}
