// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// The motion of vertex is base on CryEngine theory.It makes much more dynamic motions for  verts.
Shader "TSHD/Vegetation/AlphaTest_WindGrass_CE" {
    Properties {
         _EmissionColor ("Emission Color", Color) = (0.0,0.0,0.0,1.0) 

        _MainTex ("Diffuse(RGBA)", 2D) = "white" {}
        //_DiffScale("Diffuse Scale",float) = 1.0
        _Wind("Wind params（XZ for Direction,W for Weight Scale)",Vector) = (1,1,1,0.1)

        _WindEdgeFlutterFreqScale("Wind Freq Scale",float) = 0.1

		_ColliderRadius("Collider Radius",Range(0,4)) =0.5
		_PlayerForce("Player Force",float) =1
		_ForceY("Collider Force Y ",Range(-1,1)) =-1.0

        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2

        [HideInInspector]_DirForce("XYZ for Wind Direction,W for PlayerForce Weight",Vector) =(0,0,0,0)
        [HideInInspector]_ForceWeight("Force Weight",float)=0.0 //All force weight
    }

    SubShader {
        	Tags {"Queue"="AlphaTest"  "RenderType"="TransparentCutout"}
            Cull [_Cull]
			LOD 250
        CGPROGRAM

        #pragma surface surf LambertRe  vertex:vert  exclude_path:prepass  exclude_path:deferred  alphatest:_Cutoff  noforwardadd  //nometa nolppv addshadow 
		#pragma multi_compile _ LOD_FADE_CROSSFADE
		//#pragma multi_compile __ _PLANTCOLLIDER
		#pragma target 3.0

		inline fixed4 UnityLambertReLight (SurfaceOutput s, UnityLight light)
		{
		    // Figure out if we should use the inverse normal or the regular normal based on light direction.
			//half NdotL = dot (s.Normal, light.dir);
   //         half diff = (NdotL > 0) ? NdotL : dot (-s.Normal, light.dir);
			//half diff = (NdotL > 0) ? NdotL : -NdotL;
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
				c.rgb += s.Albedo * gi.indirect.diffuse ;
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
            //float4 _PlayerForce,_DirForce;
            fixed _AmbScale;
            float _WindEdgeFlutterFreqScale,_ForceWeight,_ColliderRadius,_PlayerForce,_ForceY;
			float4 _Wind,_PlayerPos;
            half4 _EmissionColor;
            float _ColliderForce;

			float SmoothCurve( float x ) {   
				return x * x *( 3.0 - 2.0 * x );   
			}
			float TriangleWave( float x ) {   
				return abs( frac( x + 0.5 ) * 2.0 - 1.0 );   
			}
			float SmoothTriangleWave( float x ) {   
				return SmoothCurve( TriangleWave( x ) );   
			}
            void MyFastSin (half2 val, out half2 s)
            {
	            val = val * 6.408849 - 3.1415927;
	            // powers for taylor series
	            half2 r5 = val * val;		// wavevec ^ 2
	            half2 r6 = r5 * r5;		// wavevec ^ 4;
	            half2 r7 = r6 * r5;		// wavevec ^ 6;
	            half2 r8 = r6 * r5;		// wavevec ^ 8;

	            half2 r1 = r5 * val;		// wavevec ^ 3
	            half2 r2 = r1 * r5;		// wavevec ^ 5;
	            half2 r3 = r2 * r5;		// wavevec ^ 7;

	            //Vectors for taylor's series expansion of sin
	            half4 sin7 = {1, -0.16161616, 0.0083333, -0.00019841};
	            // sin
	            s =  val + r1 * sin7.y + r2 * sin7.z + r3 * sin7.w;
            }

            struct Input {
	            float3 UVdiff; //Z:diff
				float4 screenPos;
            };

            void vert (inout appdata_full v, out Input o) {
                UNITY_INITIALIZE_OUTPUT(Input,o);

                float4 posWorld= mul(unity_ObjectToWorld, v.vertex);
                float windTime 	= _Time.y *_WindEdgeFlutterFreqScale;

                float4	wind =_Wind;

	            // Phases (object, vertex, branch)	
	            half2 fObjPhase;
                half2 _sin = float2 ( frac( posWorld.x + posWorld.z)  , frac(posWorld.x + posWorld.z + windTime));
	            MyFastSin ( _sin, fObjPhase);
	            
	            half fVtxPhase = dot(posWorld.xyz, fObjPhase.x); // controled by vertex color green
	            half2 vWavesIn = windTime + float2(fVtxPhase, fObjPhase.x);

				//force after interacive
	            half4 vWaves = frac( vWavesIn.xxyy * float4(1.975, 0.793, 0.375, 0.285) ) * 2.0 - 1.0;
				//half4 vWavesCollider =4*vWaves;
	            vWaves = SmoothTriangleWave( vWaves );
				//vWavesCollider =SmoothTriangleWave(vWavesCollider);
	            half2 vWavesSum = vWaves.xz + vWaves.yw;
				//half2 vWavesSumCollider = vWavesCollider.xz +vWavesCollider.yw;

				half2 windPara =wind.xz *v.color.a* wind.w;
				half2 oriForce = windPara *vWavesSum.y;

				half2 finalForce = oriForce;

				//#ifdef _PLANTCOLLIDER
					half3 posP =_PlayerPos.xyz;
					half moveThread =_ColliderRadius -distance(posWorld.xyz,posP) ;
					moveThread =clamp(moveThread,0,1);

					half2 forceDir =normalize(posWorld.xz - posP);
					finalForce +=forceDir*windPara*moveThread*_PlayerForce;
					posWorld.y +=lerp(0,_ForceY,moveThread);
				//#endif

				posWorld.xz += finalForce;

				v.vertex = mul(unity_WorldToObject, posWorld);

				half NdotL = dot (v.normal, _WorldSpaceLightPos0.xyz);
				 // Figure out if we should use the inverse normal or the regular normal based on light direction.
				 o.UVdiff.z = (NdotL >= 0) ? NdotL : dot (-v.normal, _WorldSpaceLightPos0.xyz);
				 o.UVdiff.xy =TRANSFORM_TEX(v.texcoord, _MainTex);
            }


            void surf (Input IN, inout SurfaceOutput o) {
				#ifdef LOD_FADE_CROSSFADE
					float2 vpos = IN.screenPos.xy / IN.screenPos.w * _ScreenParams.xy;
					UnityApplyDitherCrossFade(vpos);
					//o.Alpha *=unity_LODFade.x;
				#endif
                float4 tex = tex2D(_MainTex, IN.UVdiff.xy);

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
        	Tags {"Queue"="AlphaTest"  "RenderType"="TransparentCutout"}
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
