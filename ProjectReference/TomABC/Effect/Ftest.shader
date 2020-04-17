// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5078765,fgcg:0.5644319,fgcb:0.9528302,fgca:1,fgde:0.04,fgrn:15,fgrf:200,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-8725-OUT,alpha-6528-OUT;n:type:ShaderForge.SFN_Fresnel,id:4758,x:32486,y:32915,varname:node_4758,prsc:2|NRM-4457-OUT,EXP-1748-OUT;n:type:ShaderForge.SFN_NormalVector,id:4457,x:32264,y:32598,prsc:2,pt:False;n:type:ShaderForge.SFN_Vector1,id:1748,x:32264,y:32789,varname:node_1748,prsc:2,v1:3;n:type:ShaderForge.SFN_Time,id:1452,x:32424,y:32478,varname:node_1452,prsc:2;n:type:ShaderForge.SFN_Sin,id:2397,x:32638,y:32777,varname:node_2397,prsc:2|IN-3405-OUT;n:type:ShaderForge.SFN_RemapRange,id:7239,x:32807,y:32897,varname:node_7239,prsc:2,frmn:-1,frmx:1,tomn:0.5,tomx:1|IN-2397-OUT;n:type:ShaderForge.SFN_Multiply,id:3405,x:32594,y:32604,varname:node_3405,prsc:2|A-1452-T,B-124-OUT;n:type:ShaderForge.SFN_Vector1,id:124,x:32456,y:32721,varname:node_124,prsc:2,v1:6;n:type:ShaderForge.SFN_Vector1,id:8725,x:33017,y:32638,varname:node_8725,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:6528,x:32945,y:32946,varname:node_6528,prsc:2|A-7239-OUT,B-4758-OUT;pass:END;sub:END;*/

Shader "Tomcat/Effect/Fresnel_thing" {
    Properties {
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float node_8725 = 1.0;
                float3 finalColor = float3(node_8725,node_8725,node_8725);
                float4 node_1452 = _Time;
                fixed4 finalRGBA = fixed4(finalColor,((sin((node_1452.g*6.0))*0.25+0.75)*pow(1.0-max(0,dot(i.normalDir, viewDirection)),3.0)));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
