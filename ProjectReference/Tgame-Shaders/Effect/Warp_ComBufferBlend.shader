// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//Background:1000
//Geometry:2000
//AlphaTest:2450
//Transparent:3000
//Overlay:4000
//Update 17.1.12
Shader "TSHD/VFX/Warp_CommandBufferBlend" {
	Properties {
        [HideInInspector]_MainTex ("Main Texture ", 2D) = "black" {}
		_NoiseTex ("Noise Texture ", 2D) = "white" {}
        //_AlphaTex ("Alpha Texture (R)",2D) = "white" {}
		_DisStrength("Normal strength", Range(0.01, 10.0)) = 1.0
		_AlphaVal("Alpha Value",Range(0,10)) =1
		_FlowVal ("Flow Speed",float) = 0.2
	}

Category {

       Tags {"Queue"="Transparent-20" "RenderType"="Transparent"}
		SubShader {
		LOD 250
		Pass {
			Name "BASE"
            //Tags { "LightMode" = "Always" }
            //Cull Off
            //Important to make refraction obj render before transparent!
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

            //sampler2D _MainTex;
            //float4 _MainTex_ST;
			float4 _NoiseTex_ST;
			sampler2D _NoiseTex;
			sampler2D _AlphaTex;
			float4 _AlphaTex_ST;

            sampler2D _GrabTexture;
            float4 _GrabTexture_TexelSize;

			fixed _DisStrength;
			fixed _FlowVal;
			fixed _AlphaVal;

			struct data {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 vertexColor : COLOR;
			};

			struct v2f {
				float4 position : POSITION;
				float4 screenPos : TEXCOORD0;
				float2 uvmain : TEXCOORD2;
                //float2 uvAlpha : TEXCOORD3;
				float distortion :TEXCOORD1;
				float4 vertexColor : COLOR;
			};

			v2f vert(data v){
				v2f o;
				o.position = UnityObjectToClipPos(v.vertex); 
				o.uvmain = TRANSFORM_TEX(v.texcoord, _NoiseTex); 
                //o.uvAlpha = TRANSFORM_TEX(v.texcoord, _AlphaTex);
				o.vertexColor =v.vertexColor;
				float viewAngle = dot(normalize(ObjSpaceViewDir(v.vertex)),	v.normal);
				o.distortion = viewAngle * viewAngle;	

				//float depth = -mul( UNITY_MATRIX_MV, v.vertex ).z;	// 顶点深度，取负
				float depth = -UnityObjectToViewPos(v.vertex).z;
				o.distortion /= 1+depth;	// scale effect with vertex depth,就是模拟离得远(Zbuffer大)distortion越大,越近则越小
				o.distortion *= _DisStrength;	
                
                #if UNITY_UV_STARTS_AT_TOP
	            float scale = -1.0;
	            #else
	            float scale = 1.0;
	            #endif
	            o.screenPos.xy = (float2(o.position.x, o.position.y*scale) + o.position.w) * 0.5;
	            o.screenPos.zw = o.position.zw;

                //o.screenPos = o.position; // pass the position to the pixel shader直接把顶点位置当做屏幕位置
                //// compute the texture coordinates
                //o.screenPos.xy = o.screenPos.xy / o.screenPos.w; // screenpos ranges from -1 to 1
                //o.screenPos.x = (o.screenPos.x + 1) * 0.5; 
                //o.screenPos.y = (o.screenPos.y + 1) * 0.5; 
                //if (_ProjectionParams.x < 0)
                //o.screenPos.y = 1 - o.screenPos.y;

				return o;
			}

			half4 frag( v2f i ) : COLOR
			{ 

				fixed4 offsetColor1 = tex2D(_NoiseTex, i.uvmain + _Time.xz * _FlowVal);
				fixed4 offsetColor2 = tex2D(_NoiseTex, i.uvmain - _Time.yx * _FlowVal);

                fixed4 orAlpha =tex2D(_NoiseTex, i.uvmain);

				fixed4 screenPos = i.screenPos;
                //screenPos.x += ((offsetColor1.r + offsetColor2.r) - 1) * i.distortion *orAlpha.r* _AlphaVal;
                //screenPos.y += ((offsetColor1.g + offsetColor2.g) - 1) * i.distortion*orAlpha.r* _AlphaVal;		
                
                screenPos.x += ((offsetColor1.r + offsetColor2.r) - 1) * i.distortion ;
				screenPos.y += ((offsetColor1.g + offsetColor2.g) - 1) * i.distortion;		


				fixed4 col=tex2Dproj (_GrabTexture, UNITY_PROJ_COORD(screenPos));
                //col.a = tex2D(_AlphaTex,i.uvAlpha).r *saturate(i.distortion * _AlphaVal*100) *i.vertexColor.a;
                col.a = orAlpha.r * _AlphaVal *i.vertexColor.a;

				return col;
			}
			ENDCG
		}
	}
	FallBack "Mobile/Particles/Alpha Blended"
}
}