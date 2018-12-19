// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


/*
	TGame - Particles - DissolveGlowBlend


*/
Shader "TGame/Particles/DissolveGlowBlend" 
{
	Properties 
	{
		//_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,1)
		_Color ("Main Color", Color) = (1,1,1,1)


		_ColorStrength ("Color strength", Float) = 1.0
		_MainTex ("Particle Texture", 2D) = "grey" {}


		[Space(5)]
		[Header(Dissolve)]
		_DissolveMap ("DissolveMap (R)",2D) = "white"{}
 		_DissolveFactor ("DissolveFactor",Range(0,1.05)) = 0.5


 		// Edge
		[Space(5)]
		[Header(Edge)]
		_EdgeWidth("EdgeWidth",Range(0,2)) = 0.3
		_EdgeColor("EdgeColor",Color) =  (1,1,1,1)	
		_EdgeMultiplier("Edge-Multiplier",Range(0,30)) = 1

		// CullMode
		[Space(5)]
		[Header(Culling)]
    	[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
    	

	}

	SubShader
	{	
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }

		Blend SrcAlpha OneMinusSrcAlpha
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
			
			//fixed4 _TintColor;
			fixed4 _Color;

			fixed _ColorStrength;
			fixed _EdgeMultiplier;
			
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
            	float dotProduct = 1 - dot(v.normal, viewDir);
                //float rimWidth = 0.7;
                //o.rimColor = smoothstep(0.3, 1.0, dotProduct);      
            	//o.rimColor *= _RimColor;
      

				o.color = v.color;
				o.texcoord.xy = TRANSFORM_TEX(v.texcoord,_MainTex);
				
				// z 存储Fresnel 信息
				o.texcoord.z = smoothstep(0.3, 1.0, dotProduct);  
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
				//fixed4 res = 2 * i.color * tex * _TintColor * _ColorStrength;
				fixed4 res = 2 * i.color * tex * _Color * _ColorStrength;

				res.a = saturate(res.a);

				// Dissolve溶解
				fixed noiseValue = tex2D(_DissolveMap,i.texcoord).r;

				// 可以通过粒子系统中的 ColorOverLifetime 进行溶解
				_DissolveFactor = 1- ((1- _DissolveFactor) *  i.color.a);

				// 
				fixed edgeFactor = saturate((noiseValue - _DissolveFactor)/(_EdgeWidth*_DissolveFactor));
				
				// 色相上做一个偏色
				fixed4 rimColor = fixed4(_EdgeColor.r + 0.05,_EdgeColor.g + 0.05,_EdgeColor.b + 0.05,1.0 ) * i.texcoord.z * 4;
				fixed4 blendColor = _EdgeColor  + rimColor;// _EdgeColor * i.texcoord.z * 4;
		
				blendColor *= _EdgeMultiplier;


				// Final
				res.rgb = lerp(res.rgb ,blendColor,1 - edgeFactor); 
				res.a = saturate((noiseValue * res.a - _DissolveFactor) + (edgeFactor));
	


				return res;
			}
			ENDCG 
		}
	}	
}

