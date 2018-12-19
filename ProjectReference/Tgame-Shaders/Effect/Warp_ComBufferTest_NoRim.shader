// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//Background:1000
//Geometry:2000
//AlphaTest:2450
//Transparent:3000
//Overlay:4000
//Update 17.1.12
Shader "TSHD/VFX/Warp_CommandBufferTest_NoRim" {
	Properties {
         [HideInInspector]_MainTex ("Main Texture ", 2D) = "black" {}
		_NoiseTex ("Noise Texture ", 2D) = "white" {}
        //_AlphaTex ("Alpha Texture (R)",2D) = "white" {}
		_DisStrength("Normal strength", Range(0.01, 5.0)) = 1.0
        //_AlphaVal("Alpha Scale",Range(0,10)) =1
		_FlowVal ("Flow Speed",float) = 0.2
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
	}

Category {
    Tags {"Queue"="Transparent-20" }
    //Tags {"Queue"="AlphaTest-20" "RenderType"="TransparentCutout"}
	SubShader {
        LOD 250
		Pass {
			Name "BASE"
            //Tags { "LightMode" = "Always" }
            //Cull Off
            //Important to make refraction obj render before transparent!
           ZWrite Off

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			float4 _NoiseTex_ST;
			sampler2D _NoiseTex;

            sampler2D _GrabTexture;
            float4 _GrabTexture_TexelSize;

			fixed _DisStrength;
			fixed _FlowVal,_Cutoff;
            //fixed _AlphaVal;

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
                UNITY_INITIALIZE_OUTPUT(v2f ,o);
				o.position = UnityObjectToClipPos(v.vertex); 
				o.uvmain = TRANSFORM_TEX(v.texcoord, _NoiseTex); 
				o.vertexColor =v.vertexColor;
                //float viewAngle = dot(normalize(ObjSpaceViewDir(v.vertex)),	v.normal);
                //o.distortion = viewAngle * viewAngle;	
                o.distortion =1;
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

				return o;
			}

			half4 frag( v2f i ) : COLOR
			{ 
				fixed4 offsetColor1 = tex2D(_NoiseTex, i.uvmain + _Time.xz * _FlowVal);
				fixed4 offsetColor2 = tex2D(_NoiseTex, i.uvmain - _Time.yx * _FlowVal);

                fixed4 orAlpha =tex2D(_NoiseTex, i.uvmain);
                clip(i.vertexColor.a*orAlpha.r -_Cutoff);

				fixed4 screenPos = i.screenPos;
                screenPos.x += ((offsetColor1.r + offsetColor2.r) - 1) * i.distortion ;
				screenPos.y += ((offsetColor1.g + offsetColor2.g) - 1) * i.distortion;		
				fixed4 col=tex2Dproj (_GrabTexture, UNITY_PROJ_COORD(screenPos));
				return col;
			}
			ENDCG
		}
	}
		FallBack "Mobile/Particles/Alpha Blended"
}
}