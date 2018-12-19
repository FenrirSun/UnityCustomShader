// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:True,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33327,y:32709,varname:node_3138,prsc:2|emission-4933-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32416,y:32916,ptovrint:False,ptlb:Color,ptin:_Color,varname:_Color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.7843137,c2:0.07843139,c3:0.07843139,c4:1;n:type:ShaderForge.SFN_Fresnel,id:3756,x:32416,y:32761,varname:node_3756,prsc:2|EXP-1358-OUT;n:type:ShaderForge.SFN_Multiply,id:649,x:32835,y:32955,varname:node_649,prsc:2|A-3756-OUT,B-7241-RGB,C-3367-OUT,D-6456-RGB,E-6456-A;n:type:ShaderForge.SFN_ValueProperty,id:3367,x:32416,y:33088,ptovrint:False,ptlb:value,ptin:_value,varname:node_3367,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:1358,x:32229,y:32783,ptovrint:False,ptlb:node_1358,ptin:_node_1358,varname:node_1358,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:3;n:type:ShaderForge.SFN_Tex2d,id:5215,x:32564,y:32526,ptovrint:False,ptlb:node_5215,ptin:_node_5215,varname:node_5215,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:3247,x:32622,y:32743,ptovrint:False,ptlb:node_3247,ptin:_node_3247,varname:node_3247,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:9068,x:32821,y:32606,varname:node_9068,prsc:2|A-5215-RGB,B-3247-OUT;n:type:ShaderForge.SFN_Multiply,id:4933,x:33055,y:32743,varname:node_4933,prsc:2|A-9068-OUT,B-649-OUT;n:type:ShaderForge.SFN_VertexColor,id:6456,x:32402,y:33140,varname:node_6456,prsc:2;proporder:7241-3367-1358-5215-3247;pass:END;sub:END;*/

Shader "Shader Forge/fresnel" {
    Properties {
        _Color ("Color", Color) = (0.7843137,0.07843139,0.07843139,1)
        _value ("value", Float ) = 1
        _node_1358 ("node_1358", Float ) = 3
        _node_5215 ("node_5215", 2D) = "white" {}
        _node_3247 ("node_3247", Float ) = 0
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
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal n3ds wiiu 
            #pragma target 2.0
            uniform float4 _Color;
            uniform float _value;
            uniform float _node_1358;
            uniform sampler2D _node_5215; uniform float4 _node_5215_ST;
            uniform float _node_3247;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _node_5215_var = tex2D(_node_5215,TRANSFORM_TEX(i.uv0, _node_5215));
                float3 emissive = ((_node_5215_var.rgb*_node_3247)*(pow(1.0-max(0,dot(normalDirection, viewDirection)),_node_1358)*_Color.rgb*_value*i.vertexColor.rgb*i.vertexColor.a));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
