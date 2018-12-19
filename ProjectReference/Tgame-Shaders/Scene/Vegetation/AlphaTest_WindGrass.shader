// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// Upgrade NOTE: replaced 'UNITY_INSTANCE_ID' with 'UNITY_VERTEX_INPUT_INSTANCE_ID'
// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
///Update 17.9 :new Collider Mode
Shader "TSHD/Vegetation/AlphaTest_WindGrass" {
    Properties {
         _EmissionColor ("Emission Color", Color) = (0.0,0.0,0.0,1.0) 
        _MainTex ("Diffuse(RGB)", 2D) = "white" {}

        _Wind("Wind params（XZ for Direction,W for Weight Scale)",Vector) = (1,0.2,1,0.1)
        _WindEdgeFlutterFreqScale("Wind Freq Scale",float) = 0.1

		_ColliderRadius("Collider Radius",Range(0,4)) =1.0
		_PlayerForce("Player Force",float) =1.0
		_ForceY("Collider Force Y ",Range(-1,1)) =-1.0

         _Cutoff("Alpha cutoff", Range(0,1)) = 0.5
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2

         [HideInInspector]_DirForce("XYZ for Wind Direction,W for PlayerForce Weight",Vector) =(0,0,0,0)
         [HideInInspector]_ForceWeight("Force Weight",float)=0.0 //All force weight
    }
    SubShader {
        	Tags {"Queue"="Geometry+50"  "RenderType"="TransparentCutout"}
            Cull [_Cull]
			LOD 250
        CGPROGRAM

        #pragma surface surf LambertRe alphatest:_Cutoff vertex:vert  exclude_path:prepass exclude_path:deferred noforwardadd  nolppv addshadow  //nometa
		//#pragma multi_compile __ _PLANTCOLLIDER
		#pragma multi_compile _ LOD_FADE_CROSSFADE
		#pragma target 3.0

		inline fixed4 UnityLambertReLight (SurfaceOutput s, UnityLight light)
		{

             // Figure out if we should use the inverse normal or the regular normal based on light direction.
			//half NdotL = dot (s.Normal, light.dir);
   //          half diff = (NdotL > 0) ? NdotL : dot (-s.Normal, light.dir);

			//fixed diff = max (0, dot (s.Normal, light.dir));
			fixed4 c;
			//c.rgb = s.Albedo * light.color * diff;
			c.rgb = s.Albedo * light.color *s.Gloss;
			c.a = s.Alpha;
			return c;
		}

		inline fixed4 LightingLambertRe (SurfaceOutput s, UnityGI gi)
		{
			fixed4 c;
			c = UnityLambertReLight (s, gi.light);

			#ifdef UNITY_LIGHT_FUNCTION_APPLY_INDIRECT
				c.rgb += s.Albedo * gi.indirect.diffuse;
			#endif

			return c;
		}

		inline void LightingLambertRe_GI (
		SurfaceOutput s,
		UnityGIInput data,
		inout UnityGI gi)
	{
		gi = UnityGlobalIllumination (data, 1.0, s.Normal);
	}


            sampler2D _MainTex; 
			float4 _MainTex_ST;
            float4 _Wind,_PlayerPos;
            float _WindEdgeFlutterFreqScale,_ColliderRadius,_PlayerForce,_AmbScale,_ForceY;

			float _ColliderForce;
			//float4 _PlayerPos;

            float4 _EmissionColor;


			float SmoothCurve( float x ) {   
				return x * x *( 3.0 - 2.0 * x );   
			}
			float TriangleWave( float x ) {   
				return abs( frac( x + 0.5 ) * 2.0 - 1.0 );   
			}
			float SmoothTriangleWave( float x ) {   
				return SmoothCurve( TriangleWave( x ) );   
			}
      
	  		struct InterpolatorsVertex {
				float2 uv_MainTex;
				#if defined(LOD_FADE_CROSSFADE)
					UNITY_VPOS_TYPE vpos : VPOS;
				#else
					float4 pos : SV_POSITION;
				#endif
			};

            struct Input {
	            //float2 uv_MainTex;
				float3 UVdiff; //Z:diff
				float4 screenPos;
            };

            
            void vert (inout appdata_full v, out Input o) {
                UNITY_INITIALIZE_OUTPUT(Input,o);
				float4 posWorld= mul(unity_ObjectToWorld, v.vertex);
               float windTime 	= _Time.y *_WindEdgeFlutterFreqScale;

				// Wave 1 :XZ wave
				// Wave 2 detail:add X wave!
				half windPara =v.color.a* _Wind.w;

				half colliderForce =v.color.a* SmoothTriangleWave( 3*windTime)*_ColliderForce;

				half oriX =SmoothTriangleWave( windTime+posWorld.x)*windPara;
				half oriZ =SmoothTriangleWave( windTime+posWorld.z)*windPara;

				posWorld.x += oriX;
				posWorld.z += oriZ;

				//#ifdef _PLANTCOLLIDER
					half3 posP =_PlayerPos.xyz;
					half moveThread =_ColliderRadius -distance(posWorld.xyz,posP) ;
					moveThread =clamp(moveThread,0,1);

					half2 forceDir =normalize(posWorld.xz - posP);

					posWorld.xz +=forceDir*windPara*moveThread*_PlayerForce;
					posWorld.y +=lerp(0,_ForceY,moveThread);
				//#endif
				v.vertex = mul(unity_WorldToObject, posWorld);

				half NdotL = dot (v.normal, _WorldSpaceLightPos0.xyz);
				 // Figure out if we should use the inverse normal or the regular normal based on light direction.
				 o.UVdiff.z = (NdotL > 0) ? NdotL : dot (-v.normal, _WorldSpaceLightPos0.xyz);
				 o.UVdiff.xy =TRANSFORM_TEX(v.texcoord, _MainTex);
            }

            //void surf (Input IN, inout SurfaceOutput o) {
			void surf (Input IN, inout SurfaceOutput o) {
				#ifdef LOD_FADE_CROSSFADE
					float2 vpos = IN.screenPos.xy / IN.screenPos.w * _ScreenParams.xy;
					UnityApplyDitherCrossFade(vpos);
				#endif

	            half4  tex = tex2D(_MainTex, IN.UVdiff.xy);
	            half4  c = tex ;
	           	o.Albedo = c.rgb;
				o.Emission = c.rgb*_EmissionColor.rgb;

                o.Alpha = tex.a;
				o.Albedo = lerp(o.Albedo,o.Albedo *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
				o.Gloss =IN.UVdiff.z; // Double side NdotL factor
            }
            ENDCG
            }

		SubShader {
        	Tags {"Queue"="Geometry+50"  "RenderType"="TransparentCutout"}
            Cull [_Cull]
			LOD 150
        CGPROGRAM

        #pragma surface surf Lambert alphatest:_Cutoff exclude_path:prepass  exclude_path:deferred  novertexlights noforwardadd 
		#pragma target 2.0

			 sampler2D _MainTex; 
            fixed _AmbScale;
            fixed3 _EmissionColor;


            struct Input {
	            float2 uv_MainTex;
            };


            void surf (Input IN, inout SurfaceOutput o) {

                float4 tex = tex2D(_MainTex, IN.uv_MainTex);
                half4  c = tex ;
	            o.Albedo = c.rgb;
				o.Emission = c.rgb*_EmissionColor;
				o.Alpha = tex.a;
                o.Albedo = lerp(o.Albedo,o.Albedo *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
            }
            ENDCG
        }

   Fallback "Legacy Shaders/Transparent/Cutout/VertexLit"
}
