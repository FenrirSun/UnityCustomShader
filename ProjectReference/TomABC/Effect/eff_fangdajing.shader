// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-1518-RGB,alpha-293-A;n:type:ShaderForge.SFN_Tex2d,id:293,x:32816,y:33103,ptovrint:False,ptlb:zhezhao,ptin:_zhezhao,varname:node_293,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ScreenPos,id:7016,x:31723,y:32107,varname:node_7016,prsc:2,sctp:2;n:type:ShaderForge.SFN_SceneColor,id:1518,x:32862,y:32433,varname:node_1518,prsc:2|UVIN-2436-OUT;n:type:ShaderForge.SFN_TexCoord,id:9998,x:30894,y:33255,varname:node_9998,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_RemapRange,id:471,x:31080,y:33255,varname:node_471,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-9998-UVOUT;n:type:ShaderForge.SFN_Distance,id:9297,x:31253,y:33255,varname:node_9297,prsc:2|A-471-OUT,B-1853-OUT;n:type:ShaderForge.SFN_Vector1,id:1853,x:31120,y:33463,varname:node_1853,prsc:2,v1:0;n:type:ShaderForge.SFN_OneMinus,id:7228,x:31412,y:33255,varname:node_7228,prsc:2|IN-9297-OUT;n:type:ShaderForge.SFN_Multiply,id:3845,x:31590,y:33255,varname:node_3845,prsc:2|A-7228-OUT,B-5092-OUT,C-2806-OUT;n:type:ShaderForge.SFN_Pi,id:5092,x:31348,y:33438,varname:node_5092,prsc:2;n:type:ShaderForge.SFN_Sin,id:9258,x:31765,y:33255,cmnt:半球面,varname:node_9258,prsc:2|IN-3845-OUT;n:type:ShaderForge.SFN_Vector1,id:2806,x:31408,y:33555,varname:node_2806,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:3857,x:31975,y:33285,cmnt:压扁,varname:node_3857,prsc:2|A-9258-OUT,B-3309-OUT;n:type:ShaderForge.SFN_Vector1,id:3309,x:31791,y:33424,varname:node_3309,prsc:2,v1:0.2;n:type:ShaderForge.SFN_TexCoord,id:597,x:30680,y:32311,varname:node_597,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_RemapRange,id:2856,x:30863,y:32231,varname:node_2856,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-597-UVOUT;n:type:ShaderForge.SFN_Add,id:8458,x:32599,y:32293,varname:node_8458,prsc:2|A-5229-OUT,B-2040-OUT;n:type:ShaderForge.SFN_Slider,id:1165,x:32111,y:32780,ptovrint:False,ptlb:node_1165,ptin:_node_1165,varname:node_1165,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:2040,x:32499,y:32572,varname:node_2040,prsc:2|A-1455-OUT,B-1335-OUT,C-1165-OUT;n:type:ShaderForge.SFN_Multiply,id:5382,x:31916,y:32397,varname:node_5382,prsc:2|A-8818-OUT,B-8489-OUT,C-4765-OUT;n:type:ShaderForge.SFN_Pi,id:8489,x:31655,y:32588,varname:node_8489,prsc:2;n:type:ShaderForge.SFN_Sin,id:1746,x:32129,y:32372,varname:node_1746,prsc:2|IN-5382-OUT;n:type:ShaderForge.SFN_Distance,id:4765,x:31431,y:32513,varname:node_4765,prsc:2|A-8818-OUT,B-6240-OUT;n:type:ShaderForge.SFN_Vector2,id:6240,x:31231,y:32558,varname:node_6240,prsc:2,v1:0,v2:0;n:type:ShaderForge.SFN_Vector1,id:1335,x:32241,y:32691,varname:node_1335,prsc:2,v1:-0.1;n:type:ShaderForge.SFN_Power,id:1455,x:32298,y:32476,varname:node_1455,prsc:2|VAL-1746-OUT,EXP-3992-OUT;n:type:ShaderForge.SFN_Vector1,id:3992,x:32084,y:32571,varname:node_3992,prsc:2,v1:1;n:type:ShaderForge.SFN_Set,id:1548,x:31029,y:32314,varname:new_00,prsc:2|IN-597-UVOUT;n:type:ShaderForge.SFN_Set,id:9497,x:31029,y:32231,varname:old_00,prsc:2|IN-2856-OUT;n:type:ShaderForge.SFN_Get,id:8818,x:31246,y:32401,cmnt:00,varname:node_8818,prsc:2|IN-1548-OUT;n:type:ShaderForge.SFN_Get,id:5229,x:32323,y:32333,cmnt:01,varname:node_5229,prsc:2|IN-963-OUT;n:type:ShaderForge.SFN_Set,id:3694,x:32077,y:32125,varname:old_01,prsc:2|IN-7016-UVOUT;n:type:ShaderForge.SFN_Set,id:963,x:32232,y:32243,varname:new_01,prsc:2|IN-2242-OUT;n:type:ShaderForge.SFN_Subtract,id:2242,x:32032,y:32222,varname:node_2242,prsc:2|A-7016-UVOUT,B-903-OUT;n:type:ShaderForge.SFN_Vector1,id:903,x:31532,y:32279,varname:node_903,prsc:2,v1:-0.03;n:type:ShaderForge.SFN_Get,id:7168,x:31009,y:32818,varname:node_7168,prsc:2|IN-9497-OUT;n:type:ShaderForge.SFN_Distance,id:1308,x:31122,y:32888,varname:node_1308,prsc:2|A-7168-OUT,B-6699-OUT;n:type:ShaderForge.SFN_Vector2,id:6699,x:30983,y:32954,varname:node_6699,prsc:2,v1:0,v2:0;n:type:ShaderForge.SFN_Multiply,id:587,x:32010,y:32895,varname:node_587,prsc:2|A-7168-OUT,B-3700-OUT,C-1502-OUT;n:type:ShaderForge.SFN_Add,id:2436,x:32563,y:32942,varname:node_2436,prsc:2|A-9602-OUT,B-587-OUT;n:type:ShaderForge.SFN_Get,id:9602,x:31601,y:32783,varname:node_9602,prsc:2|IN-3694-OUT;n:type:ShaderForge.SFN_Vector1,id:1502,x:31785,y:33145,varname:node_1502,prsc:2,v1:-0.1;n:type:ShaderForge.SFN_Power,id:605,x:31459,y:32888,varname:node_605,prsc:2|VAL-3814-OUT,EXP-1774-OUT;n:type:ShaderForge.SFN_OneMinus,id:3814,x:31297,y:32854,varname:node_3814,prsc:2|IN-1308-OUT;n:type:ShaderForge.SFN_Add,id:3700,x:31751,y:32949,varname:node_3700,prsc:2|A-605-OUT,B-2940-OUT;n:type:ShaderForge.SFN_Vector1,id:2651,x:31430,y:33068,cmnt:放大倍数,varname:node_2651,prsc:2,v1:0.1;n:type:ShaderForge.SFN_ValueProperty,id:8096,x:31430,y:33158,ptovrint:False,ptlb:Multiple,ptin:_Multiple,varname:node_8096,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:2940,x:31622,y:33051,varname:node_2940,prsc:2|A-2651-OUT,B-8096-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1774,x:31199,y:33133,ptovrint:False,ptlb:Size,ptin:_Size,varname:node_1774,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.5;proporder:293-1165-8096-1774;pass:END;sub:END;*/

Shader "Tomcat/Effect/eff_fangdajing" {
    Properties {
        _zhezhao ("zhezhao", 2D) = "white" {}
        _node_1165 ("node_1165", Range(0, 1)) = 0
        _Multiple ("Multiple", Float ) = 1
        _Size ("Size", Float ) = 0.5
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _zhezhao; uniform float4 _zhezhao_ST;
            uniform float _Multiple;
            uniform float _Size;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
                float2 old_01 = sceneUVs.rg;
                float2 old_00 = (i.uv0*2.0+-1.0);
                float2 node_7168 = old_00;
                float3 finalColor = tex2D( _GrabTexture, (old_01+(node_7168*(pow((1.0 - distance(node_7168,float2(0,0))),_Size)+(0.1*_Multiple))*(-0.1)))).rgb;
                float4 _zhezhao_var = tex2D(_zhezhao,TRANSFORM_TEX(i.uv0, _zhezhao));
                return fixed4(finalColor,_zhezhao_var.a);
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
            #pragma only_renderers d3d9 d3d11 glcore gles 
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
