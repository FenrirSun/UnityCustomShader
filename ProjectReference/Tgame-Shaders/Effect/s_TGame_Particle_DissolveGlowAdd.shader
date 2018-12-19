// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


/*
	TGame - Particles - DissolveGlowAdd



*/
Shader "TGame/Particles/DissolveGlowAdd" 
{
	Properties 
	{
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,1)
		_ColorStrength ("Color strength", Float) = 1.0
		_MainTex ("Particle Texture", 2D) = "grey" {}


		[Space(5)]
		[Header(Dissolve)]
		_DissolveMap ("Dissolve Map (R)",2D) = "white"{}
 		_DissolveFactor ("Dissolve Factor",Range(0,1.05)) = 0


 		// Edge 
		[Space(5)]
		[Header(Edge)]
 		_FresnelPower ("Edge-Rim-Power ",Range(0.05,10)) = 1
		_EdgeWidth("Edge-Width",Range(0.5,2.5)) = 1
		_EdgeColor("Edge-Color",Color) =  (1,1,1,1)	
		_EdgeMultiplier("Edge-Multiplier",Range(0,30)) = 1


		// Culling
		[Space(5)]
		[Header(Culling)]
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2


	}

	SubShader
	{	
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }

		//Blend SrcAlpha OneMinusSrcAlpha
		Blend One One
		AlphaTest Greater .01
		ColorMask RGB
		Cull [_Cull]
		Lighting Off 
		ZWrite Off

		Pass 
		{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_particles
			#include "UnityCG.cginc"

			// Dissolve
	      	sampler2D	_DissolveMap;
			fixed		_DissolveFactor;
			fixed		_EdgeWidth;
			fixed4		_EdgeColor;

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			fixed4 _TintColor;
			fixed _ColorStrength;

			fixed _EdgeMultiplier;
			fixed _FresnelPower;
			//sampler2D _CameraDepthTexture;
			//float _InvFade;
				
	
			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal   : NORMAL;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				
			};
			

			struct v2f 
			{
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float4 texcoord : TEXCOORD0;

				//fixed4 rimColor : TEXCOORD1;
				/*
				#ifdef SOFTPARTICLES_ON
				float4 projPos : TEXCOORD1;
				#endif
				*/
			};
			
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				/*
				#ifdef SOFTPARTICLES_ON
				o.projPos = ComputeScreenPos (o.vertex);
				COMPUTE_EYEDEPTH(o.projPos.z);
				#endif
				*/
				
				// 
				float3 viewDir = normalize(ObjSpaceViewDir(v.vertex));     
            	float fresnel = pow((1 - dot(v.normal, viewDir)),_FresnelPower);
      

				o.color = v.color;
				o.texcoord.xy = TRANSFORM_TEX(v.texcoord,_MainTex);
				//o.texcoord.xy = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;

				// 将Fresnel信息记录在 z 里面
				o.texcoord.z = fresnel; //smoothstep(0.3, 1.0, fresnel);  
				o.texcoord.w = 0;
				
				return o;
			}

			
			fixed4 frag (v2f i) : COLOR
			{
				/*
				#ifdef SOFTPARTICLES_ON
				float sceneZ = LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos))));
				float partZ = i.projPos.z;
				float fade = saturate (_InvFade * (sceneZ-partZ));
				i.color.a *= fade;
				#endif
				*/

				// 
				fixed4 tex = tex2D(_MainTex, i.texcoord);
				fixed4 res = 2 * i.color * tex * _TintColor * _ColorStrength;

				// 可以通过粒子系统中的 ColorOverLifetime 进行溶解
				_DissolveFactor = 1- ((1- _DissolveFactor) *  i.color.a);

				// 
				// TODO : 想办法改掉 if 语句，变成Lerp?
				if(_DissolveFactor > 0.01)
				{
					// Dissolve溶解
					fixed dissolve = tex2D(_DissolveMap,i.texcoord).r;
					fixed edgeFactor = saturate((dissolve - _DissolveFactor)/(_EdgeWidth*_DissolveFactor));
				
					// Rim叠加，色相上做一个偏色
					fixed4 rimColor = fixed4(_EdgeColor.r + 0.05,_EdgeColor.g + 0.05,_EdgeColor.b + 0.05,1.0 ) * i.texcoord.z;


					// 原有颜色与 边缘颜色混合， 使用_EdgeMultiplier来单独控制边缘颜色的强度
					//fixed3 mixColor = lerp(res.rgb , res.rgb * _EdgeColor.rgb * _EdgeMultiplier , 1- edgeFactor);
					fixed3 mixColor = lerp(res.rgb , res.rgb * rimColor.rgb * _EdgeMultiplier , 1- edgeFactor);
	
					res.rgb = lerp(mixColor ,fixed3(0,0,0) ,1 - edgeFactor); 

				}
	
				return res;
			}
			ENDCG 
		}
	}	
}

