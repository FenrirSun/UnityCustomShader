// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TSHD/Scene/Opaque_Unlit_FogCon" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_FogVal ("Fog Density",Range(0,1)) =1.0
}

SubShader {
	Tags { "RenderType"="Opaque" }
	LOD 100
	
	// Non-lightmapped
	Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile_fog
		#include "UnityCG.cginc"

		uniform fixed4 _Color;
		uniform sampler2D _MainTex;uniform float4 _MainTex_ST;
		uniform fixed _FogVal;

		struct v2f { 
			float4 pos :SV_POSITION;
			half2  uv : TEXCOORD0;
			//UNITY_FOG_COORDS(1)
			float fogCoord : TEXCOORD1;
		};

		v2f vert(appdata_base v)
		{
			v2f o;
			o.pos =UnityObjectToClipPos(v.vertex);
			o.uv =TRANSFORM_TEX(v.texcoord,_MainTex);
			#if defined(FOG_LINEAR)
	        // factor = (end-z)/(end-start) = z * (-1/(end-start)) + (end/(end-start))
	        o.fogCoord = UNITY_Z_0_FAR_FROM_CLIPSPACE(o.pos.z) * unity_FogParams.z + unity_FogParams.w;
            #elif defined(FOG_EXP)
	            // factor = exp(-density*z)
	            o.fogCoord = unity_FogParams.y * UNITY_Z_0_FAR_FROM_CLIPSPACE(o.pos.z);
                o.fogCoord  = exp2(-o.fogCoord );
            #elif defined(FOG_EXP2)
	            // factor = exp(-(density*z)^2)
	           o.fogCoord = unity_FogParams.x * UNITY_Z_0_FAR_FROM_CLIPSPACE(o.pos.z); 
               unityFogFactor = exp2(-o.fogCoord *o.fogCoord );
            #else
	        o.fogCoord= 1.0;
            #endif
            //UNITY_CALC_FOG_FACTOR(o.pos.z);
            //o.fogCoord = unityFogFactor;
			return o;
		}

		fixed4 frag(v2f i) :COLOR
		{
			fixed4 c =_Color* tex2D(_MainTex,i.uv);

			fixed3 tempC = lerp(unity_FogColor.rgb, c.rgb, saturate(i.fogCoord));
			c.rgb = lerp(c.rgb,tempC,_FogVal);

			UNITY_OPAQUE_ALPHA(c.a);
			return c;
		}
		ENDCG
	}


	}
	
}
