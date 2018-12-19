///Update 18.5:Unlit mode
Shader "TGame/Character/PC" 
{  
    Properties 
    {  
        _MainTex  ("Diff(RGB)", 2D) = "white" {}  
        //_EmissionColor("EmissionColor", Color) = (0.7,0.7,0.7)
		// 雾效的影响
		_FogScale   ("FogScale", Range(0,1)) = 1

        // 光照的影响
        //_DiffuseMultiply ("Diffuse Multiply",Range(0,2)) = 1

        // 边缘光强度
		_RimColor ("Rim Color", Color) = (1,0.85,0.67,1)
		_RimPower ("Rim Power", Range(0,10)) = 6.0
		_RimLevel ("Rim Level",Range(0,5)) = 0.2
        _RimDir("Rim Direction(W>0 Direction Rim,or esle Full Rim)",Vector) =(-1,1,0,1)

        
    }  

	SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 100

    Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

			sampler2D _MainTex;
            float4 _MainTex_ST;
			fixed _Illum,_FogScale,_DiffuseMultiply;
			fixed _AmbientImpact;
	
			//fixed _MatCapMulti;
			fixed _RimPower,_RimLevel;
			fixed4 _RimColor,_EmissionColor,_RimDir;


            struct v2f {
                float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
                UNITY_FOG_COORDS(1)
				//half3 normal :TEXCOORD3;
				half3 viewDir:TEXCOORD2;
				half3 norDotRim :TEXCOORD4;
				//half3 worldPos:TEXCOORD5;
				half3 worldNor:TEXCOORD5;
            };

            fixed4 _Color;

            v2f vert (appdata_full v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				//o.normal =v.normal;
				o.worldNor = UnityObjectToWorldNormal(v.normal);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.viewDir =normalize(UnityWorldSpaceViewDir(worldPos));
				//half rimMask =_RimDir.w>0 ? saturate(dot(worldNor, _RimDir.xyz)) : 1;  
				//o.norDotRim =rimMask *_RimLevel *_RimColor.rgb;
				o.norDotRim =_RimLevel *_RimColor.rgb;
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                fixed4 col = tex2D(_MainTex, i.texcoord);
				fixed rim = 1.0 - saturate(dot (i.viewDir, i.worldNor));
				//col.rgb +=  pow(rim,_RimPower) *i.norDotRim;
				half rimMask =_RimDir.w>0 ? saturate(dot(i.worldNor, _RimDir.xyz)) : 1;  
				col.rgb +=  pow(rim,_RimPower) *i.norDotRim*rimMask;
				half3 tempCol =col.rgb;
                UNITY_APPLY_FOG(i.fogCoord, col);
				col.rgb =lerp(tempCol,col,_FogScale);
                UNITY_OPAQUE_ALPHA(col.a);
                return col;
            }
        ENDCG
    }
}

	//SubShader 
	//{
	//	Tags { "Queue" = "Geometry" }
		
 //       //Cull Off
 //       CGPROGRAM  
 //     	#pragma surface surf Lambert noforwardadd nolightmap vertex:vert finalcolor:fogColor nofog
 //       #pragma target 2.0

	//	#pragma multi_compile_fog

 //       sampler2D _MainTex;
 //       fixed _Illum,_FogScale,_DiffuseMultiply;
	//	fixed _AmbientImpact;
	
 //       //fixed _MatCapMulti;
 //       fixed _RimPower,_RimLevel;
 //       fixed4 _RimColor,_EmissionColor,_RimDir;


	//	struct Input 
	//	{
	//		fixed2 uv_MainTex : TEXCOORD0;
 //           fixed3 viewDir;
	//		//half3 rimCol:TEXCOORD4;
	//		half3 norDotRim :TEXCOORD4;
	//		float2 fogCoord : TEXCOORD5;
	//	};

	//	void vert(inout appdata_full v, out Input data)
	//	{
	//		UNITY_INITIALIZE_OUTPUT(Input, data);
	//		float4 pos = UnityObjectToClipPos (v.vertex);
	//		//float4 worldPos =mul(unity_ObjectToWorld,v.vertex);
	//		 //fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
	//		 half3 worldNor = UnityObjectToWorldNormal(v.normal);

	//		 //部分运算放顶点
	//		//fixed rim = 1.0 - saturate(dot (worldViewDir, v.normal));
	//		half rimMask =_RimDir.w>0 ? saturate(dot(worldNor, _RimDir.xyz)) : 1;  
	//		data.norDotRim =rimMask *_RimLevel *_RimColor.rgb;
	//		//data.norDotRim.y =rim;
	//		//data.rimCol =(_RimColor.rgb *pow(rim,_RimPower)) *_RimLevel*rimMask;

	//		UNITY_TRANSFER_FOG(data, pos);
	//	}

	//	void fogColor(Input IN, SurfaceOutput  o, inout fixed4 color)
	//	{
	//	#if defined(FOG_LINEAR) ||defined(FOG_EXP)|| defined(FOG_EXP2)
 //           #ifdef UNITY_PASS_FORWARDADD
 //               color.rgb = lerp(fixed3(0,0,0), (color).rgb, saturate(IN.fogCoord.x));
 //           #else
	//			fixed3 orCol =color.rgb;
	//			UNITY_APPLY_FOG(IN.fogCoord, color);
	//	        color.rgb = lerp(orCol,color.rgb,_FogScale);
 //           #endif
	//	#endif
	//	}

 //       void surf (Input IN, inout SurfaceOutput o)   
 //       {  
 //           fixed4 c  		= tex2D (_MainTex, IN.uv_MainTex);  
	//		// 颜色计算
 //           fixed3 final = c.rgb;
 //           final = c.rgb * _DiffuseMultiply;
	//		o.Emission = final *_EmissionColor.rgb;
	//		// Rim
 //       	fixed rim = 1.0 - saturate(dot (IN.viewDir, o.Normal));
	//	 //final +=IN.rimCol;
	//		final +=  pow(rim,_RimPower) *IN.norDotRim;
 //           o.Albedo = final ;
 //       }  
 //       ENDCG  
 //   }   
    FallBack "Mobile/VertexLit"
}  