Shader "TSHD/Scene/ShadowTransparent_ForwardAdd" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,0.5)
    _Cutoff ("Alpha cutoff", Range(0,1)) = 0.99
	//_PointPos("Point Light Postion",vector) =(0,0,0,0)
	_FadeFactor("Fade out ",float) =10
}


SubShader {
    Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
    LOD 100

	ZWrite Off 
	Blend SrcAlpha OneMinusSrcAlpha 

	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }

		CGPROGRAM
		// compile directives
		#pragma vertex vert_surf
		#pragma fragment frag_surf
		#pragma multi_compile_fwdadd_fullshadows novertexlight noshadowmask nodynlightmap nodirlightmap nolightmap exclude_path:prepass exclude_path:deferred

		#define UNITY_PASS_FORWARDADD
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#include "AutoLight.cginc"

		fixed4 _Color;
		//half4 _PointPos;
		half _FadeFactor;
		//struct Input {
		//	float2 uv_MainTex;
		//};

		// vertex-to-fragment interpolation data
		struct v2f_surf {
			float4 pos		: SV_POSITION;
			half3 worldNormal : TEXCOORD1;
			float3 worldPos : TEXCOORD2;
			UNITY_SHADOW_COORDS(3)
			half shadowDis : TEXCOORD4;
		};

		// vertex shader
		v2f_surf vert_surf (appdata_full v) {
			//UNITY_SETUP_INSTANCE_ID(v);
			v2f_surf o;
			UNITY_INITIALIZE_OUTPUT(v2f_surf,o);

			o.pos = UnityObjectToClipPos(v.vertex);

			float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
			fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
			o.worldPos = worldPos;
			o.worldNormal = worldNormal;

			UNITY_TRANSFER_SHADOW(o,v.texcoord1.xy); // pass shadow coordinates to pixel shader
			half dis =distance(worldPos,_WorldSpaceLightPos0.xyz);
			o.shadowDis =dis>_FadeFactor?0:1;

			return o;
		}
		fixed _Cutoff;

		// fragment shader
		half4 frag_surf (v2f_surf IN) : SV_Target {
				
			// prepare and unpack data
			//Input surfIN;
			//UNITY_INITIALIZE_OUTPUT(Input,surfIN);
			float3 worldPos = IN.worldPos;

			SurfaceOutput o;
			fixed3 normalWorldVertex = fixed3(0,0,1);
			o.Normal = IN.worldNormal;
			normalWorldVertex = IN.worldNormal;

			UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
			half4 c = 0;
			//c.rgb =IN.shadowDis;
		//Transparent Shadow
			c.a =1-atten;
			c.a =c.a -_Cutoff>0? c.a :0;
			c.a *=_Color.a*IN.shadowDis;

			return c;
		}



		ENDCG

		}


		}


}
