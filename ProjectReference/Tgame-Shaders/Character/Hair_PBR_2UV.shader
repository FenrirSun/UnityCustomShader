//Update 18.3.13 PBR model

Shader "TSHD/Hair_PBR_2UV" 
{
	Properties 
	{
        _Color1 ("Main Color", Color) = (1,1,1,1)
		_Color2 ("Main Color2", Color) = (1,1,1,1)
		_MainTex ("Diffuse (R),ColorMask(G),SpeMask(B)", 2D) = "grew" {}

        _NormalTex ("Normal Map", 2D) = "Black" {}
		//_Specular ("Specular Amount", Range(0, 5)) = 1.0 
		_Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)
        _ExtraSpeColor ("Extra Specular Color", Color) = (0.5,0.5,0.5,1)
		_SpecularMultiplier ("Specular Power", float) = 100.0
		_PrimaryShift ( "Specular Primary Shift", float) = 0.0
		_AnisoDir ("SpecShift(G)", 2D) = "white" {}

        //RIM LIGHT
		_RimColor ("Rim Color", Color) = (0.8,0.8,0.8,0.6)
		_RimPower ("Rim Power", Range(0,20)) = 5.0
		_RimLevel ("Rim Level",Range(0,3)) = 0.5
        _RimDir("Rim Direction(W>0 Direction Rim,or esle Full Rim)",Vector) =(1,1,0,1)

        //_Cutoff ("Alpha Cut-Off Threshold", Range(0,0.9)) = 0.8
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
	}
	
CGINCLUDE
		sampler2D _MainTex, _AnisoDir,_NormalTex;
		half _SpecularMultiplier, _PrimaryShift,_Specular;
		half4 _SpecularColor, _Color1,_Color2,_ExtraSpeColor;
        half _RimPower;
		half4 _RimColor;
		half _RimLevel;
		//half _Cutoff;
        half4  _RimDir,_LightDir;
		half _Glossiness;

		struct Input
			{
				fixed2 uv2_MainTex;
				fixed2 uv_AnisoDir;
				fixed3 tangent_input;
                float3 	viewDirWorld;
                half3 worldNor;
				float3 	viewDir;
				INTERNAL_DATA
			};
		
		struct SurfaceOutputAniso 
		{
			fixed3 Albedo;
			fixed3 Normal;
			fixed3 Emission;
			fixed Specular;
			fixed Gloss;
			fixed Alpha;
				
            fixed SpecShift;
			fixed SpecMask;
			fixed3 tangent_input; 

			half3 worldNor;
		};
					
		fixed StrandSpecular ( fixed3 T, fixed3 V, fixed3 L, fixed exponent)
		{
			fixed3 H = normalize ( L + V );
			fixed dotTH = dot ( T, H );
			fixed sinTH = sqrt ( 1 - dotTH * dotTH);
			fixed dirAtten = smoothstep(-1, 0, dotTH );
			return dirAtten * pow(sinTH, exponent);
				//dotTH =max(0,dotTH);
				//float spec =pow(dotTH,exponent);
				//return spec;
		}
			
		fixed3 ShiftTangent ( fixed3 T, fixed3 N, fixed shift)
		{
			return normalize( T + shift * N );
		}

ENDCG


	SubShader
	{
		Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}

		Cull [_Cull]
		
		CGPROGRAM
		//#pragma surface surf Aniso vertex:vert   exclude_path:prepass  noforwardadd  exclude_path:deferred nolightmap 
		#pragma surface surf StandardSpecular vertex:vert   exclude_path:prepass  noforwardadd  exclude_path:deferred nolightmap finalcolor:addSpe
		#pragma target 3.0  

		void vert(inout appdata_full i, out Input o)
		{	
			UNITY_INITIALIZE_OUTPUT(Input, o);	
			o.tangent_input =normalize(UnityObjectToWorldDir(i.tangent.xyz));
			float3 worldPos = mul(unity_ObjectToWorld, i.vertex).xyz;    
			o.worldNor = normalize(UnityObjectToWorldNormal(i.normal));
			o.viewDirWorld =normalize(UnityWorldSpaceViewDir(worldPos));
		}

		void addSpe(Input IN, SurfaceOutputStandardSpecular o, inout fixed4 color)
        {
			half3 LightDir=_WorldSpaceLightPos0.xyz;

			half NdotL = saturate(dot(o.Normal, LightDir));
			half3 T = -normalize(cross( o.Normal, IN.tangent_input));

			fixed3 anisoTex = tex2D(_AnisoDir, IN.uv_AnisoDir).rgb;
            half shiftTex = anisoTex.g;
            half3 t1 = ShiftTangent ( T, o.Normal, _PrimaryShift + shiftTex);
			half3 spe= StrandSpecular(t1, IN.viewDirWorld, LightDir, _SpecularMultiplier)* _ExtraSpeColor;

			half3 extraSpe=  spe  *o.Alpha*_LightColor0.rgb * NdotL;
			color.rgb +=extraSpe.rgb;
        }
			
		void surf (Input IN, inout SurfaceOutputStandardSpecular o)
		{
			fixed4 albedo = tex2D(_MainTex, IN.uv2_MainTex);
            o.Albedo =albedo.r*lerp(_Color1.rgb,_Color2.rgb,albedo.g);

            o.Alpha = albedo.b;// mask of extra spe
			//clip(albedo.a -_Cutoff);

			o.Specular = _SpecularColor;  
			o.Smoothness =_Glossiness;

            o.Normal = UnpackNormal( tex2D(_NormalTex, IN.uv2_MainTex));

            half rim = 1.0 - saturate(dot (IN.viewDir, o.Normal));
			half rimMask =_RimDir.w>0 ? saturate(dot(IN.worldNor, _RimDir.xyz)) : 1;    
            o.Emission += _RimColor.rgb *pow(rim,_RimPower)*_RimLevel*rimMask;
		}

		ENDCG

	}
	FallBack "Mobile/VertexLit"
	//FallBack "Legacy Shaders/Transparent/Cutout/Diffuse"
}