// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-673-OUT,alpha-1635-OUT;n:type:ShaderForge.SFN_Tex2d,id:2450,x:32592,y:32689,varname:node_2450,prsc:2,tex:1b1c165da146e95499d3c1fa3adb0031,ntxv:0,isnm:False|UVIN-8684-UVOUT,TEX-3953-TEX;n:type:ShaderForge.SFN_UVTile,id:8684,x:32433,y:32705,varname:node_8684,prsc:2|UVIN-7742-OUT,WDT-6499-OUT,HGT-3002-OUT,TILE-959-OUT;n:type:ShaderForge.SFN_Vector1,id:6499,x:31919,y:32780,varname:node_6499,prsc:2,v1:5;n:type:ShaderForge.SFN_Vector1,id:3002,x:31919,y:32830,varname:node_3002,prsc:2,v1:2;n:type:ShaderForge.SFN_Tex2dAsset,id:3953,x:31433,y:32777,ptovrint:False,ptlb:tex,ptin:_tex,varname:node_3953,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:1b1c165da146e95499d3c1fa3adb0031,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:8337,x:31045,y:32480,varname:node_8337,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:3983,x:31546,y:32277,varname:node_3983,prsc:2|A-4865-OUT,B-8337-U;n:type:ShaderForge.SFN_Vector1,id:4865,x:31316,y:32311,varname:node_4865,prsc:2,v1:2;n:type:ShaderForge.SFN_Clamp01,id:5493,x:31876,y:32319,varname:node_5493,prsc:2|IN-3206-OUT;n:type:ShaderForge.SFN_Subtract,id:4263,x:31608,y:32598,varname:node_4263,prsc:2|A-3983-OUT,B-9229-OUT;n:type:ShaderForge.SFN_Vector1,id:9229,x:31333,y:32602,varname:node_9229,prsc:2,v1:1;n:type:ShaderForge.SFN_Clamp01,id:3195,x:31971,y:32564,varname:node_3195,prsc:2|IN-274-OUT;n:type:ShaderForge.SFN_Append,id:7742,x:32073,y:32346,varname:node_7742,prsc:2|A-5493-OUT,B-8337-V;n:type:ShaderForge.SFN_Append,id:5554,x:32153,y:32603,varname:node_5554,prsc:2|A-3195-OUT,B-8337-V;n:type:ShaderForge.SFN_ValueProperty,id:4275,x:31667,y:32976,ptovrint:False,ptlb:No,ptin:_No,varname:node_4275,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Divide,id:5520,x:31991,y:32932,varname:node_5520,prsc:2|A-4275-OUT,B-2125-OUT;n:type:ShaderForge.SFN_Vector1,id:2125,x:31755,y:33110,varname:node_2125,prsc:2,v1:10;n:type:ShaderForge.SFN_Floor,id:959,x:32202,y:32932,varname:node_959,prsc:2|IN-5520-OUT;n:type:ShaderForge.SFN_Fmod,id:3777,x:32048,y:33091,varname:node_3777,prsc:2|A-4275-OUT,B-2125-OUT;n:type:ShaderForge.SFN_UVTile,id:5572,x:32433,y:32831,varname:node_5572,prsc:2|UVIN-5554-OUT,WDT-6499-OUT,HGT-3002-OUT,TILE-3777-OUT;n:type:ShaderForge.SFN_Add,id:2860,x:32791,y:32794,varname:node_2860,prsc:2|A-2450-RGB,B-3347-RGB;n:type:ShaderForge.SFN_Add,id:1635,x:32791,y:33018,varname:node_1635,prsc:2|A-2450-A,B-3347-A;n:type:ShaderForge.SFN_Tex2d,id:3347,x:32551,y:33018,varname:node_3347,prsc:2,tex:1b1c165da146e95499d3c1fa3adb0031,ntxv:0,isnm:False|UVIN-5572-UVOUT,TEX-3953-TEX;n:type:ShaderForge.SFN_Multiply,id:673,x:32994,y:32737,varname:node_673,prsc:2|A-2860-OUT,B-8152-OUT;n:type:ShaderForge.SFN_Vector1,id:8152,x:32854,y:32933,varname:node_8152,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Subtract,id:3206,x:31782,y:32169,varname:node_3206,prsc:2|A-3983-OUT,B-5768-OUT;n:type:ShaderForge.SFN_Vector1,id:5768,x:31520,y:32453,varname:node_5768,prsc:2,v1:0.16;n:type:ShaderForge.SFN_Add,id:274,x:31825,y:32522,varname:node_274,prsc:2|A-5768-OUT,B-4263-OUT;proporder:3953-4275;pass:END;sub:END;*/

Shader "Tomcat/Effect/Number" {
    Properties {
        _tex ("tex", 2D) = "white" {}
        _No ("No", Float ) = 0
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
            uniform sampler2D _tex; uniform float4 _tex_ST;
            uniform float _No;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
                float node_6499 = 5.0;
                float node_3002 = 2.0;
                float node_2125 = 10.0;
                float node_959 = floor((_No/node_2125));
                float2 node_8684_tc_rcp = float2(1.0,1.0)/float2( node_6499, node_3002 );
                float node_8684_ty = floor(node_959 * node_8684_tc_rcp.x);
                float node_8684_tx = node_959 - node_6499 * node_8684_ty;
                float node_3983 = (2.0*i.uv0.r);
                float node_5768 = 0.16;
                float2 node_8684 = (float2(saturate((node_3983-node_5768)),i.uv0.g) + float2(node_8684_tx, node_8684_ty)) * node_8684_tc_rcp;
                float4 node_2450 = tex2D(_tex,TRANSFORM_TEX(node_8684, _tex));
                float node_3777 = fmod(_No,node_2125);
                float2 node_5572_tc_rcp = float2(1.0,1.0)/float2( node_6499, node_3002 );
                float node_5572_ty = floor(node_3777 * node_5572_tc_rcp.x);
                float node_5572_tx = node_3777 - node_6499 * node_5572_ty;
                float2 node_5572 = (float2(saturate((node_5768+(node_3983-1.0))),i.uv0.g) + float2(node_5572_tx, node_5572_ty)) * node_5572_tc_rcp;
                float4 node_3347 = tex2D(_tex,TRANSFORM_TEX(node_5572, _tex));
                float node_8152 = 0.5;
                float3 finalColor = ((node_2450.rgb+node_3347.rgb)*node_8152);
                float node_1635 = (node_2450.a+node_3347.a);
                fixed4 finalRGBA = fixed4(finalColor,node_1635);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
