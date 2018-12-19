// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TSHD/Scene/UnlitLM_Shadow_Reflect" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_ReflectVal("Reflect Value",Range(0,1)) = 0.2
	[HideInInspector]
	_ReflectionTex ("Reflection", 2D) = "black" { }

}

SubShader {
	Tags { "RenderType"="Opaque" }
	LOD 100
	
	// Non-lightmapped
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }

		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
        #pragma multi_compile_fwdbase //novertexlight nodynlightmap nodirlightmap 
		#pragma multi_compile_fog
         //#pragma multi_compile LIGHTMAP_ON LIGHTMAP_OFF

		#include "UnityCG.cginc"
		#include "Lighting.cginc"
        #include "AutoLight.cginc"

		sampler2D _ReflectionTex;  
		float4	  _ReflectionTex_TexelSize;

		half _ReflectVal;

		uniform fixed4 _Color;
		uniform sampler2D _MainTex;uniform float4 _MainTex_ST;
        
        struct appdata_t{
			float4 vertex : POSITION;
			float2 texcoord : TEXCOORD0;
			float2 texcoord1 : TEXCOORD1;

		};
		struct v2f { 
			float4 pos :SV_POSITION;
			half2  uv : TEXCOORD0;
			UNITY_FOG_COORDS(1)
       //      #ifndef LIGHTMAP_OFF  
			    //half2  lmuv : TEXCOORD2;
       //     #endif
			float4 scrPos : TEXCOORD5;
            //SHADOW_COORDS(3)
			LIGHTING_COORDS(3,4)
		};

		v2f vert(appdata_t v)
		{
			v2f o;
			o.pos =UnityObjectToClipPos(v.vertex);
			o.uv =TRANSFORM_TEX(v.texcoord,_MainTex);
            //#ifndef LIGHTMAP_OFF  
            //    o.lmuv = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
            //#endif
			
			o.scrPos = ComputeScreenPos(o.pos);
             //TRANSFER_SHADOW(o);
			TRANSFER_VERTEX_TO_FRAGMENT(o);
			UNITY_TRANSFER_FOG(o,o.pos);
			return o;
		}

		fixed4 frag(v2f i) :COLOR
		{
			fixed4 c =_Color* tex2D(_MainTex,i.uv);
            //fixed atten = SHADOW_ATTENUATION(i);
			fixed atten = LIGHT_ATTENUATION(i);

            //#ifndef LIGHTMAP_OFF  
            //    fixed4 lm = UNITY_SAMPLE_TEX2D(unity_Lightmap,i.lmuv);
            //    c.rgb *=DecodeLightmap(lm);
                
            //#endif
            c.rgb *= atten; 

			half4 projTC = UNITY_PROJ_COORD(i.scrPos); 
			fixed4 reflection = tex2Dproj(_ReflectionTex, projTC);
			c.rgb +=reflection*_ReflectVal*reflection.a;
              //c.rgb =fixed3(atten,atten,atten);
			UNITY_APPLY_FOG(i.fogCoord, c);
			return c;
		}
		ENDCG
	}
	
	
}

FallBack "Mobile/VertexLit"
}