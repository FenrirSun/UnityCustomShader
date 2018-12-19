Shader "TGame/Character/MobEffect"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_MainColor ("Main color", Color) = (0.7568628,1,0.9215687,1)
		_XSpeed("Horizontal Speed", float) = 0.01
		_YSpeed("Vertical Speed", float) = 0.01
		_Intensity("Intensity", float) = 1.0
		_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
	}
	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent+1"
		 	"IgnoreProjector"="True"
			"RenderType"="Transparent"
		}
		Pass
		{
			
			Blend SrcAlpha One
			ColorMask RGB
        	ZWrite Off Cull Off Lighting Off
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma multi_compile_particles
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
				#ifdef SOFTPARTICLES_ON
				float4 projPos : TEXCOORD2;
				#endif
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _MainColor;
			float _XSpeed;
			float _YSpeed;
			fixed _Intensity;
			
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				#ifdef SOFTPARTICLES_ON
				o.projPos = ComputeScreenPos (o.vertex);
				COMPUTE_EYEDEPTH(o.projPos.z);
				#endif
				o.color = v.color;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex) + _Time.g * float2(_XSpeed, _YSpeed);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			sampler2D_float _CameraDepthTexture;
			float _InvFade;

			fixed4 frag (v2f i) : SV_Target
			{
				#ifdef SOFTPARTICLES_ON
				float sceneZ = LinearEyeDepth (SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
				float partZ = i.projPos.z;
				float fade = saturate (_InvFade * (sceneZ-partZ));
				i.color.a *= fade;
				#endif

				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv) ;
				col = col * _MainColor * 2.0f * i.color * _Intensity;
				// apply fog
				UNITY_APPLY_FOG_COLOR(i.fogCoord, col, fixed4(0,0,0,0)); // fog towards black due to our blend mode
				return col;
			}
			ENDCG
		}
	}
}
