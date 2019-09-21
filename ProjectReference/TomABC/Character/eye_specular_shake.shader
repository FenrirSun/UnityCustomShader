// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:Legacy Shaders/Bumped Diffuse,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:31595,y:32259,varname:node_4013,prsc:2|diff-7854-RGB,spec-4388-RGB,gloss-9427-OUT,normal-2117-RGB;n:type:ShaderForge.SFN_Color,id:4388,x:31210,y:32413,ptovrint:False,ptlb:Specular Color,ptin:_SpecularColor,varname:node_4388,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Tex2dAsset,id:2751,x:30963,y:32437,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_2751,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b27be6d62b9969141ac4744c00afae25,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:7854,x:31210,y:32267,varname:node_7854,prsc:2,tex:b27be6d62b9969141ac4744c00afae25,ntxv:0,isnm:False|UVIN-3466-OUT,TEX-2751-TEX;n:type:ShaderForge.SFN_TexCoord,id:2312,x:30785,y:31983,varname:node_2312,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Set,id:1677,x:31029,y:31964,varname:__UV,prsc:2|IN-2312-UVOUT;n:type:ShaderForge.SFN_Set,id:2972,x:31029,y:32029,varname:__U,prsc:2|IN-2312-U;n:type:ShaderForge.SFN_Set,id:7481,x:31029,y:32101,varname:__V,prsc:2|IN-2312-V;n:type:ShaderForge.SFN_Time,id:2050,x:30229,y:31959,varname:node_2050,prsc:2;n:type:ShaderForge.SFN_Get,id:6284,x:30551,y:32215,varname:node_6284,prsc:2|IN-2972-OUT;n:type:ShaderForge.SFN_Sin,id:8731,x:30025,y:32457,varname:node_8731,prsc:2|IN-9929-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9137,x:30229,y:32116,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_9137,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:732,x:30404,y:31959,varname:node_732,prsc:2|A-2050-T,B-9137-OUT;n:type:ShaderForge.SFN_Add,id:1047,x:30788,y:32215,varname:node_1047,prsc:2|A-6284-OUT,B-5090-OUT;n:type:ShaderForge.SFN_Get,id:2827,x:30767,y:32352,varname:node_2827,prsc:2|IN-7481-OUT;n:type:ShaderForge.SFN_Append,id:3466,x:30963,y:32267,varname:node_3466,prsc:2|A-1047-OUT,B-2827-OUT;n:type:ShaderForge.SFN_Tex2d,id:2117,x:31210,y:32579,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:node_2117,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Slider,id:9427,x:31131,y:32774,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_9427,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Tex2d,id:1250,x:30407,y:32672,ptovrint:False,ptlb:Shake_Mask,ptin:_Shake_Mask,varname:node_1250,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d8062c130a5e32f478cb7c2c65e91c0b,ntxv:0,isnm:False|UVIN-1560-OUT;n:type:ShaderForge.SFN_Get,id:1560,x:30217,y:32672,varname:node_1560,prsc:2|IN-1677-OUT;n:type:ShaderForge.SFN_Lerp,id:5090,x:30584,y:32388,varname:node_5090,prsc:2|A-6226-OUT,B-4068-OUT,T-1250-R;n:type:ShaderForge.SFN_Vector1,id:6226,x:30365,y:32318,varname:node_6226,prsc:2,v1:0;n:type:ShaderForge.SFN_Set,id:8082,x:30566,y:31959,varname:__timeFlow,prsc:2|IN-732-OUT;n:type:ShaderForge.SFN_Get,id:9929,x:29760,y:32391,varname:node_9929,prsc:2|IN-8082-OUT;n:type:ShaderForge.SFN_Slider,id:1498,x:29893,y:32668,ptovrint:False,ptlb:MoveDis,ptin:_MoveDis,varname:node_1498,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.01;n:type:ShaderForge.SFN_Multiply,id:4068,x:30253,y:32397,varname:node_4068,prsc:2|A-8731-OUT,B-1498-OUT;proporder:2751-2117-1250-9137-1498-4388-9427;pass:END;sub:END;*/

Shader "Tomcat/Character/eye_specular_shake" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Normal ("Normal", 2D) = "bump" {}
        _Shake_Mask ("Shake_Mask", 2D) = "white" {}
        _Speed ("Speed", Float ) = 1
        _MoveDis ("MoveDis", Range(0, 0.01)) = 0
        _SpecularColor ("Specular Color", Color) = (0,0,0,1)
        _Gloss ("Gloss", Range(0, 1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _SpecularColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Speed;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _Gloss;
            uniform sampler2D _Shake_Mask; uniform float4 _Shake_Mask_ST;
            uniform float _MoveDis;
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
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float3 normalLocal = _Normal_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularColor = _SpecularColor.rgb;
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float __U = i.uv0.r;
                float4 node_2050 = _Time;
                float __timeFlow = (node_2050.g*_Speed);
                float node_8731 = sin(__timeFlow);
                float2 __UV = i.uv0;
                float2 node_1560 = __UV;
                float4 _Shake_Mask_var = tex2D(_Shake_Mask,TRANSFORM_TEX(node_1560, _Shake_Mask));
                float __V = i.uv0.g;
                float2 node_3466 = float2((__U+lerp(0.0,(node_8731*_MoveDis),_Shake_Mask_var.r)),__V);
                float4 node_7854 = tex2D(_MainTex,TRANSFORM_TEX(node_3466, _MainTex));
                float3 diffuseColor = node_7854.rgb;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _SpecularColor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Speed;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _Gloss;
            uniform sampler2D _Shake_Mask; uniform float4 _Shake_Mask_ST;
            uniform float _MoveDis;
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
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float3 normalLocal = _Normal_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularColor = _SpecularColor.rgb;
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularColor;
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float __U = i.uv0.r;
                float4 node_2050 = _Time;
                float __timeFlow = (node_2050.g*_Speed);
                float node_8731 = sin(__timeFlow);
                float2 __UV = i.uv0;
                float2 node_1560 = __UV;
                float4 _Shake_Mask_var = tex2D(_Shake_Mask,TRANSFORM_TEX(node_1560, _Shake_Mask));
                float __V = i.uv0.g;
                float2 node_3466 = float2((__U+lerp(0.0,(node_8731*_MoveDis),_Shake_Mask_var.r)),__V);
                float4 node_7854 = tex2D(_MainTex,TRANSFORM_TEX(node_3466, _MainTex));
                float3 diffuseColor = node_7854.rgb;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Legacy Shaders/Bumped Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
