// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
//Update:11.10: Height Fog pramer including
Shader "TSHD/Scene/Skybox_Scroll2_FogHeight" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,0.5)
	_MainTex ("Base layer (RGB)", 2D) = "white" {}
	_DetailTex ("2nd layer (RGBA)", 2D) = "black" {}
	_ScrollX ("Base layer Scroll speed X", Float) = 1.0
	_ScrollY ("Base layer Scroll speed Y", Float) = 0.0
	_Scroll2X ("2nd layer Scroll speed X", Float) = 1.0
	_Scroll2Y ("2nd layer Scroll speed Y", Float) = 0.0
	_FogVal ("Fog Distance Density",Range(0,1)) =1.0
    _FogVal2 ("Fog Height Density",Range(0,1)) =1.0
	_FogHeightStart("Fog Height Start",Float) =0.0
	_FogHeightEnd("Fog Height End",Float) =40.0
}

SubShader {
	Tags { "Queue"="Geometry+150" "RenderType"="Opaque" }
	
	Lighting Off 
	ZWrite Off
	
	LOD 100
	
	Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest	
		#pragma multi_compile_fog
		#include "UnityCG.cginc"
		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _DetailTex;

		float4 _MainTex_ST;
		float4 _DetailTex_ST;
	    half _AmbScale;
		float _ScrollX;
		float _ScrollY;
		float _Scroll2X;
		float _Scroll2Y;

		uniform half _FogVal,_FogVal2;
        uniform sampler2D _FogTex;uniform float4 _FogTex_ST;
        uniform half _FogHeightStart,_FogHeightEnd;
	    uniform half4 _GradientFogColor;

		struct v2f {
			float4 pos : SV_POSITION;
			float2 uv : TEXCOORD0;
			float2 uv2 : TEXCOORD1;
			fixed4 color : TEXCOORD2;		
			float2 fogCoord : TEXCOORD3;
		};

	
		v2f vert (appdata_base v)
		{
			v2f o;
			o.pos = UnityObjectToClipPos(v.vertex);
            //o.pos.z =0;
            float4 worldPos =mul(unity_ObjectToWorld,v.vertex);
			o.uv = TRANSFORM_TEX(v.texcoord.xy,_MainTex) + frac(float2(_ScrollX, _ScrollY) * _Time);
			o.uv2 = TRANSFORM_TEX(v.texcoord.xy,_DetailTex) + frac(float2(_Scroll2X, _Scroll2Y) * _Time);
			o.color = _Color;

				//UNITY_TRANSFER_FOG(o, pos);
			half _FogHeiParaZ = saturate(1 / (_FogHeightEnd - _FogHeightStart));
			half _FogHeiParaW = -_FogHeightStart *_FogHeiParaZ;

			#if defined(FOG_LINEAR)
	            // factor = (end-z)/(end-start) = z * (-1/(end-start)) + (end/(end-start))

	            o.fogCoord.x = UNITY_Z_0_FAR_FROM_CLIPSPACE(o.pos.z) * unity_FogParams.z + unity_FogParams.w;
                //o.fogCoord.y =((worldPos.y -_FogHeiStart)/(_FogHeiEnd-_FogHeiStart)); //linear
                o.fogCoord.y =worldPos.y*_FogHeiParaZ +_FogHeiParaW;
            #elif defined(FOG_EXP)
	            // factor = exp(-density*z)
	            o.fogCoord.x = unity_FogParams.y * UNITY_Z_0_FAR_FROM_CLIPSPACE(o.pos.z);
                o.fogCoord.x  = exp2(-o.fogCoord.x );
                o.fogCoord.y =worldPos.y *_FogHeiParaZ +_FogHeiParaW;
            #elif defined(FOG_EXP2)
	            // factor = exp(-(density*z)^2)
	           o.fogCoord.x = unity_FogParams.x * UNITY_Z_0_FAR_FROM_CLIPSPACE(o.pos.z); 
               o.fogCoord.x= exp2(-o.fogCoord.x *o.fogCoord.x );
                o.fogCoord.y =worldPos.y  *_FogHeiParaZ +_FogHeiParaW;
            #else
	        o.fogCoord= 1.0;
            #endif

			return o;
		}

	
		fixed4 frag (v2f i) : COLOR
		{
			fixed4 c;
			fixed4 tex = tex2D (_MainTex, i.uv);
			fixed4 tex2 = tex2D (_DetailTex, i.uv2);
			c.rgb =tex.rgb*(1-tex2.a)+tex2.rgb*tex2.a;
            c.rgb *=i.color;
            c.rgb  = lerp(c.rgb ,c.rgb  *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
            //o = (tex * tex2) * i.color;
			
			#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
                 half4 fogTex = tex2D(_FogTex,float2(1-i.fogCoord.x ,1-i.fogCoord.x)) ;
                fogTex.rgb *= _GradientFogColor.rgb;
                half4 fogCol = _GradientFogColor >0.01f ? fogTex : unity_FogColor  ;

			    fixed3 tempC = lerp(fogCol.rgb, c.rgb, saturate(i.fogCoord.x));
                c.rgb = lerp(c.rgb,tempC,_FogVal);
                tempC =lerp(fogCol.rgb,c.rgb,saturate(i.fogCoord.y));
			    c.rgb = lerp(c.rgb,tempC,_FogVal2);
            #endif
			//UNITY_OPAQUE_ALPHA(c.a);
			c.a =_Color.a*tex2.a;
			return c;
		}
		ENDCG 
	}	
}
    FallBack "Unlit/Color"
}
