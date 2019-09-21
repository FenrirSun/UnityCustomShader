// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3503916,fgcg:0.5849056,fgcb:0.5362868,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-7544-OUT,alpha-5185-B;n:type:ShaderForge.SFN_Tex2d,id:2200,x:32408,y:32854,ptovrint:False,ptlb:node_2200,ptin:_node_2200,varname:node_2200,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b2f319da02d44e74e80e7c368a995ea1,ntxv:0,isnm:False|UVIN-9944-UVOUT;n:type:ShaderForge.SFN_Color,id:6128,x:32368,y:32679,ptovrint:False,ptlb:node_6128,ptin:_node_6128,varname:node_6128,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5707547,c2:0.9762645,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:780,x:32283,y:33058,ptovrint:False,ptlb:node_780,ptin:_node_780,varname:node_780,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:53565e414fad4144ab61972d9c76997d,ntxv:0,isnm:False|UVIN-7243-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:5666,x:31870,y:32869,varname:node_5666,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:7243,x:32046,y:32935,varname:node_7243,prsc:2,spu:0,spv:1|UVIN-5666-UVOUT;n:type:ShaderForge.SFN_Multiply,id:7933,x:32661,y:32816,varname:node_7933,prsc:2|A-6128-RGB,B-780-RGB;n:type:ShaderForge.SFN_Add,id:7544,x:32899,y:32859,varname:node_7544,prsc:2|A-7933-OUT,B-9940-OUT;n:type:ShaderForge.SFN_Multiply,id:9940,x:32661,y:32625,varname:node_9940,prsc:2|A-6128-RGB,B-2200-RGB;n:type:ShaderForge.SFN_ComponentMask,id:5185,x:32889,y:33066,varname:node_5185,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-7544-OUT;n:type:ShaderForge.SFN_Panner,id:9944,x:32078,y:32637,varname:node_9944,prsc:2,spu:0,spv:0.5|UVIN-5666-UVOUT;proporder:2200-6128-780;pass:END;sub:END;*/

Shader "Tomcat/Effect/pubu" {
    Properties {
        _node_2200 ("node_2200", 2D) = "white" {}
        _node_6128 ("node_6128", Color) = (0.5707547,0.9762645,1,1)
        _node_780 ("node_780", 2D) = "white" {}
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
            uniform sampler2D _node_2200; uniform float4 _node_2200_ST;
            uniform float4 _node_6128;
            uniform sampler2D _node_780; uniform float4 _node_780_ST;
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
                float4 node_1453 = _Time;
                float2 node_7243 = (i.uv0+node_1453.g*float2(0,1));
                float4 _node_780_var = tex2D(_node_780,TRANSFORM_TEX(node_7243, _node_780));
                float2 node_9944 = (i.uv0+node_1453.g*float2(0,0.5));
                float4 _node_2200_var = tex2D(_node_2200,TRANSFORM_TEX(node_9944, _node_2200));
                float3 node_7544 = ((_node_6128.rgb*_node_780_var.rgb)+(_node_6128.rgb*_node_2200_var.rgb));
                float3 finalColor = node_7544;
                fixed4 finalRGBA = fixed4(finalColor,node_7544.rgb.b);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
