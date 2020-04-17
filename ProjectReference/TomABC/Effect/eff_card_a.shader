// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-5357-OUT,alpha-5277-OUT;n:type:ShaderForge.SFN_Tex2d,id:9236,x:32425,y:32683,ptovrint:False,ptlb:Tex01,ptin:_Tex01,varname:node_9236,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:53565e414fad4144ab61972d9c76997d,ntxv:0,isnm:False|UVIN-3972-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:7770,x:32003,y:32664,varname:node_7770,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:3972,x:32214,y:32664,varname:node_3972,prsc:2,spu:0.05,spv:-0.5|UVIN-7770-UVOUT;n:type:ShaderForge.SFN_Color,id:5124,x:32425,y:32506,ptovrint:False,ptlb:color01,ptin:_color01,varname:node_5124,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:8820,x:32815,y:32779,varname:node_8820,prsc:2|A-5124-RGB,B-9236-RGB;n:type:ShaderForge.SFN_Tex2d,id:2984,x:32425,y:33278,ptovrint:False,ptlb:zhezhao,ptin:_zhezhao,varname:node_2984,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:e169c6041f056fa44ac91399539af768,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5277,x:32854,y:33274,varname:node_5277,prsc:2|A-2984-A,B-2984-A;n:type:ShaderForge.SFN_Panner,id:6729,x:32235,y:33031,varname:node_6729,prsc:2,spu:-0.05,spv:0|UVIN-7770-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:7066,x:32425,y:33078,ptovrint:False,ptlb:tex02,ptin:_tex02,varname:node_7066,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6729-UVOUT;n:type:ShaderForge.SFN_Multiply,id:5492,x:32726,y:33004,varname:node_5492,prsc:2|A-4261-RGB,B-7066-RGB;n:type:ShaderForge.SFN_Color,id:4261,x:32425,y:32904,ptovrint:False,ptlb:color02,ptin:_color02,varname:_node_5124_copy,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Add,id:5357,x:33005,y:32896,varname:node_5357,prsc:2|A-8820-OUT,B-1126-OUT,C-382-OUT;n:type:ShaderForge.SFN_Multiply,id:1126,x:32872,y:33081,varname:node_1126,prsc:2|A-5492-OUT,B-2984-A;n:type:ShaderForge.SFN_Panner,id:3541,x:32130,y:33373,varname:node_3541,prsc:2,spu:-0.5,spv:0|UVIN-7770-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:1619,x:32401,y:33638,ptovrint:False,ptlb:pass,ptin:_pass,varname:node_1619,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3541-UVOUT;n:type:ShaderForge.SFN_Color,id:482,x:32401,y:33477,ptovrint:False,ptlb:color03,ptin:_color03,varname:node_482,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:382,x:32686,y:33563,varname:node_382,prsc:2|A-482-RGB,B-1619-RGB;proporder:2984-9236-5124-7066-4261-1619-482;pass:END;sub:END;*/

Shader "Tomcat/Effect/eff_card_a" {
    Properties {
        _zhezhao ("zhezhao", 2D) = "white" {}
        _Tex01 ("Tex01", 2D) = "white" {}
        [HDR]_color01 ("color01", Color) = (0.5,0.5,0.5,1)
        _tex02 ("tex02", 2D) = "white" {}
        [HDR]_color02 ("color02", Color) = (0.5,0.5,0.5,1)
        _pass ("pass", 2D) = "white" {}
        [HDR]_color03 ("color03", Color) = (0.5,0.5,0.5,1)
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
            Blend SrcAlpha One
            Cull Off
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
            uniform sampler2D _Tex01; uniform float4 _Tex01_ST;
            uniform float4 _color01;
            uniform sampler2D _zhezhao; uniform float4 _zhezhao_ST;
            uniform sampler2D _tex02; uniform float4 _tex02_ST;
            uniform float4 _color02;
            uniform sampler2D _pass; uniform float4 _pass_ST;
            uniform float4 _color03;
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
                float4 node_620 = _Time;
                float2 node_3972 = (i.uv0+node_620.g*float2(0.05,-0.5));
                float4 _Tex01_var = tex2D(_Tex01,TRANSFORM_TEX(node_3972, _Tex01));
                float2 node_6729 = (i.uv0+node_620.g*float2(-0.05,0));
                float4 _tex02_var = tex2D(_tex02,TRANSFORM_TEX(node_6729, _tex02));
                float4 _zhezhao_var = tex2D(_zhezhao,TRANSFORM_TEX(i.uv0, _zhezhao));
                float2 node_3541 = (i.uv0+node_620.g*float2(-0.5,0));
                float4 _pass_var = tex2D(_pass,TRANSFORM_TEX(node_3541, _pass));
                float3 finalColor = ((_color01.rgb*_Tex01_var.rgb)+((_color02.rgb*_tex02_var.rgb)*_zhezhao_var.a)+(_color03.rgb*_pass_var.rgb));
                fixed4 finalRGBA = fixed4(finalColor,(_zhezhao_var.a*_zhezhao_var.a));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
