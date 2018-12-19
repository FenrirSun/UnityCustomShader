// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TGame/Particle/Add_DisSoft" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture (RGBA) ", 2D) = "white" {}
	_SoftValue ("SoftValue", Range(1, 10)) = 4.180459
    _MulScale("Light Scale",float) =1.0
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha One

	Cull Off Lighting Off ZWrite Off

	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_particles
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed4 _TintColor;
            half  _SoftValue,_MulScale;
			
			struct appdata_t {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
			};

			struct v2f {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed2 texcoord : TEXCOORD0;
				#ifdef SOFTPARTICLES_ON
				fixed4 projPos : TEXCOORD1;
				#endif
			};
			
			float4 _MainTex_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				#ifdef SOFTPARTICLES_ON
				o.projPos = ComputeScreenPos (o.vertex);
				COMPUTE_EYEDEPTH(o.projPos.z);
				#endif
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			sampler2D _CameraDepthTexture;
			fixed _InvFade;
			
			fixed4 frag (v2f i) : COLOR
			{
				#ifdef SOFTPARTICLES_ON
				fixed sceneZ = LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos))));
				fixed partZ = i.projPos.z;
				fixed fade = saturate (_InvFade * (sceneZ-partZ));
				i.color.a *= fade;
				#endif
				
				half4 prev = tex2D(_MainTex, i.texcoord);
                prev.rgb = i.color.rgb*prev.rgb*_TintColor.rgb;

                fixed vertexAscale = 1.0 - ( i.color.a*0.95);
                fixed leA = step(prev.a,vertexAscale);
                fixed leB = step(vertexAscale,prev.a);
                prev.a =lerp((leB*saturate(((prev.a-vertexAscale)*_SoftValue))),0,leA*leB);
                prev.rgb *=prev.a*_MulScale;
				return  prev;
			}
			ENDCG 
		}
	}
    //FallBack "Transparent/Diffuse"		
}
}
