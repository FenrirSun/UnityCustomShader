// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "DGame/Npc_MatCap_OutLine" {
    Properties {
        _Hit ("Hit", Float ) = 1
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
       // _FallOffstep ("FallOffstep", Float ) = 2
        _FallOffColor ("FallOffColor", Color) = (1,1,1,1)
        _FallOffColorMap ("FallOffColorMap", 2D) = "white" {}
        _FallOffPower ("FallOffPower", Range(0, 1)) = 0
        //_RimLightSampler ("RimLightSampler", 2D) = "black" {}
        _SAGMap ("SAGMap", 2D) = "white" {}
        _OutLineColor ("OutLineColor", Color) = (0.3529412,0.3529412,0.3529412,1)
        _OutLinePow ("OutLinePow", Float ) = 1
        _OutWidth ("OutWidth", Float ) = 1
        _FresnelPower ("FresnelPower", Range(0, 5)) = 2
        _FresnelColor ("FresnelColor", Color) = (0,0,0,1)
		_MatCap1 ("MatCap1 (RGB)", 2D) = "Black" {}
        _MatCap ("MatCap (RGB)", 2D) = "white" {}
        _LerpS ("LerpS", Range(0, 1)) = 1
        _ReflectPower ("ReflectPower", Float ) = 1
        _Alphabias ("Alphabias", Range(0, 1)) = 0
		_RimColor ("RimColor", Color) = (1,1,1,1)
		_RimPower ("RimPower", Range(0.5, 1)) = 0.5
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Geometry"
        }
		Blend SrcAlpha OneMinusSrcAlpha
        Cull Off
		Lighting Off
	    ZTest LEqual
		//Fog {Mode Off}
        Pass {
           
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile_fog
            #include "UnityCG.cginc"
			#pragma multi_compile Role_High Role_Middle Role_Low
            uniform fixed4 _MainColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform fixed _Hit;
            //uniform sampler2D _RimLightSampler; uniform float4 _RimLightSampler_ST;
            uniform fixed _FallOffPower;
            uniform fixed4 _FallOffColor;
            uniform sampler2D _SAGMap; uniform float4 _SAGMap_ST;
            uniform sampler2D _FallOffColorMap; uniform float4 _FallOffColorMap_ST;
            uniform fixed _FresnelPower;
            uniform fixed4 _FresnelColor;
            uniform float _LerpS;
            uniform sampler2D _MatCap;
			uniform sampler2D _MatCap1;
            uniform fixed _ReflectPower;
            uniform fixed _Alphabias;
			uniform fixed _RimPower;
			uniform fixed4 _RimColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
               // LIGHTING_COORDS(5,6)
                float2 cap	: TEXCOORD7;
				UNITY_FOG_COORDS(8)

                //float3 shLight : TEXCOORD7;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                //o.shLight = ShadeSH9(float4(mul(_Object2World, float4(v.normal,0)).xyz * unity_Scale.w,1)) * 0.5;
                o.normalDir = mul(float4(v.normal,0), unity_WorldToObject).xyz;
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 worldNorm = normalize(unity_WorldToObject[0].xyz * v.normal.x + unity_WorldToObject[1].xyz * v.normal.y + unity_WorldToObject[2].xyz * v.normal.z);
				worldNorm = mul((float3x3)UNITY_MATRIX_V, worldNorm);
				o.cap.xy = worldNorm.xy * 0.5 + 0.5;
                o.pos = UnityObjectToClipPos(v.vertex); 
				 UNITY_TRANSFER_FOG(o,o.pos);
                //TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                half3x3 tangentTransform = half3x3( i.tangentDir, i.binormalDir, i.normalDir);
                half3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float nSign = sign( dot( viewDirection, i.normalDir ) );              
                i.normalDir *= nSign;  
/////// Normals:
                half3 normalDirection = i.normalDir; // Perturbed normals
////// Lighting:
                half4 Diff = tex2D(_MainTex,TRANSFORM_TEX(i.uv0.rg, _MainTex));
                half4 SAG = tex2D(_SAGMap,TRANSFORM_TEX(i.uv0.rg, _SAGMap));
                clip(saturate(SAG.g) - 0.5);
				fixed4 amc = tex2D(_MatCap1, i.cap);
				fixed4 mc = tex2D(_MatCap, i.cap)*_ReflectPower;
                //half LightFallOff = (SAG.r*2*max(0,amc));
				half LightFallOff = (SAG.r*amc.r);
                //half StepFallOff = floor(LightFallOff * 2);
                //half If_LeA = step(StepFallOff,0.5);
                //half If_LeB = step(0.5,StepFallOff);
				half3 If_Output = saturate((_FallOffColor.rgb*tex2D(_FallOffColorMap,TRANSFORM_TEX(i.uv0.rg, _FallOffColorMap)).rgb));
                //half3 If_Output = saturate((saturate((StepFallOff+0.5))*_FallOffPower*_FallOffColor.rgb*tex2D(_FallOffColorMap,TRANSFORM_TEX(i.uv0.rg, _FallOffColorMap)).rgb));
				#ifdef Role_Low
				half3 finalColor = Diff.rgb*_MainColor.rgb*_Hit;
				#endif

				#ifdef Role_Middle
				half3 finalColor = _Hit*lerp(Diff.rgb*_MainColor.rgb*If_Output,Diff.rgb*_MainColor.rgb,saturate(LightFallOff*2+_FallOffPower))+saturate(amc-_RimPower)*_RimColor;
				//half3 finalColor = Diff.rgb*_MainColor.rgb*saturate(lerp((If_LeA*If_Output)+(If_LeB*1.0),If_Output,If_LeA*If_LeB))*_Hit+saturate(amc-_RimPower)*_RimColor;
				#endif

				#ifdef Role_High
				half3 CombinC = _Hit*lerp(Diff.rgb*_MainColor.rgb*If_Output,Diff.rgb*_MainColor.rgb,saturate(LightFallOff*2+_FallOffPower));
                //half3 CombinC = Diff.rgb*_MainColor.rgb*saturate(lerp((If_LeA*If_Output)+(If_LeB*1.0),If_Output,If_LeA*If_LeB))*_Hit;
                half3 CombinColor = lerp(CombinC,CombinC+(mc*2.0)-1.0,saturate(SAG.b - _LerpS)) ;
                half3 Fresnel = pow((1.0-max(0,dot(i.normalDir, viewDirection))),_FresnelPower)*_FresnelColor.rgb*2.0;
				half3 finalColor = Fresnel  + CombinColor+saturate(amc-_RimPower)*_RimColor ;
				UNITY_APPLY_FOG(i.fogCoord,finalColor);
				#endif

/// Final Color:
                return fixed4(finalColor,saturate(SAG.g-_Alphabias));
            }
            ENDCG
        }
               Pass {
            Name "Outline"
            Tags {
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Front
            ZTest Less
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            //#pragma target 3.0
            #pragma glsl
            
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _OutWidth;
           // uniform fixed4 _LightColor0;
            uniform sampler2D _SAGMap; uniform float4 _SAGMap_ST;
            uniform fixed4 _OutLineColor;
            uniform fixed _OutLinePow;
            uniform fixed _Alphabias;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                 o.uv0 = v.texcoord0;
                //float4 SAG = tex2Dlod(_SAGMap,float4(TRANSFORM_TEX(o.uv0 .rg, _SAGMap),0.0,0));
                //o.pos = mul(UNITY_MATRIX_MVP, float4(v.vertex.xyz + v.normal*(_OutWidth*0.00285*SAG.g),1));
                o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + v.normal*(_OutWidth*0.00285),1));
                o.pos.z += 0.00001;
                return o;                
            }
            fixed4 frag(VertexOutput i) : COLOR {
               // float2 i.uv0 = i.uv0;
                float4 col = tex2D(_MainTex,TRANSFORM_TEX(i.uv0.rg, _MainTex));
                half4 SAG = tex2D(_SAGMap,TRANSFORM_TEX(i.uv0.rg, _SAGMap));
                clip(saturate(SAG.g) - 0.5);
               // return fixed4((_OutLineColor.rgb*pow(col.rgb,_OutLinePow)),0);
               // float4 col = tex2D( _MainTex, i.uv );

	            float maxChan = max( max( col.r, col.g ), col.b );
	           //float4 col = col;
                maxChan -= ( 1.0 / 255.0 );
	            float3 lerpVals = saturate( ( col.rgb - float3( maxChan, maxChan, maxChan ) ) * 255.0 );
	            col.rgb = lerp( 0.6 * col.rgb, col.rgb, lerpVals );
	
	return float4( 0.8 * col.rgb * col.rgb* _OutLineColor  * _OutLinePow, saturate(SAG.g-_Alphabias) )  ; 
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
