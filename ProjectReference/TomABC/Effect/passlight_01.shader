// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-3665-OUT;n:type:ShaderForge.SFN_Tex2d,id:851,x:31565,y:32207,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_851,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:10a6d6c3a8fdbf5418a641881986c72b,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:5927,x:31860,y:32664,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_5927,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.9813787,c3:0.8443396,c4:1;n:type:ShaderForge.SFN_Multiply,id:544,x:32072,y:32619,cmnt:Diffuse Color,varname:node_544,prsc:2|A-851-RGB,B-5927-RGB;n:type:ShaderForge.SFN_TexCoord,id:3775,x:30094,y:31391,varname:node_3775,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ComponentMask,id:6223,x:30613,y:31528,varname:node_6223,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-352-UVOUT;n:type:ShaderForge.SFN_Rotator,id:352,x:30387,y:31491,varname:node_352,prsc:2|UVIN-3775-UVOUT,ANG-8062-OUT;n:type:ShaderForge.SFN_Vector1,id:7513,x:29666,y:31569,varname:node_7513,prsc:2,v1:-0.15;n:type:ShaderForge.SFN_Multiply,id:8062,x:30062,y:31680,varname:node_8062,prsc:2|A-7513-OUT,B-9343-OUT;n:type:ShaderForge.SFN_Pi,id:9343,x:29690,y:31818,varname:node_9343,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3924,x:31910,y:32028,varname:node_3924,prsc:2|A-851-R,B-851-G;n:type:ShaderForge.SFN_Power,id:4593,x:32197,y:32068,varname:node_4593,prsc:2|VAL-3924-OUT,EXP-8984-OUT;n:type:ShaderForge.SFN_Vector1,id:8984,x:32040,y:32292,varname:node_8984,prsc:2,v1:20;n:type:ShaderForge.SFN_Add,id:3107,x:32752,y:32669,varname:node_3107,prsc:2|A-4563-OUT,B-544-OUT;n:type:ShaderForge.SFN_Add,id:9155,x:30851,y:31557,varname:node_9155,prsc:2|A-6223-OUT,B-7442-OUT,C-3202-OUT;n:type:ShaderForge.SFN_Time,id:7249,x:30159,y:31843,varname:node_7249,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8079,x:32455,y:31832,varname:node_8079,prsc:2|A-3562-R,B-4593-OUT,C-1871-OUT;n:type:ShaderForge.SFN_Multiply,id:7442,x:30438,y:31950,varname:node_7442,prsc:2|A-7249-T,B-3238-OUT;n:type:ShaderForge.SFN_Clamp01,id:4563,x:32662,y:32075,varname:node_4563,prsc:2|IN-8079-OUT;n:type:ShaderForge.SFN_Clamp01,id:3665,x:32966,y:32851,varname:node_3665,prsc:2|IN-3107-OUT;n:type:ShaderForge.SFN_Tex2d,id:3562,x:31361,y:31482,ptovrint:False,ptlb:node_3562,ptin:_node_3562,varname:node_3562,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3119d73826e38484585468af49c9fe50,ntxv:0,isnm:False|UVIN-6337-OUT;n:type:ShaderForge.SFN_Append,id:6337,x:31062,y:31444,varname:node_6337,prsc:2|A-9155-OUT,B-3775-V;n:type:ShaderForge.SFN_Vector1,id:3238,x:30203,y:32111,varname:node_3238,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:3202,x:30683,y:31876,varname:node_3202,prsc:2,v1:0.05;n:type:ShaderForge.SFN_Vector1,id:1871,x:32061,y:31917,varname:node_1871,prsc:2,v1:0.6;proporder:851-5927-3562;pass:END;sub:END;*/

Shader "Tomcat/Effect/passlight_01" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _Color ("Color", Color) = (1,0.9813787,0.8443396,1)
        _node_3562 ("node_3562", 2D) = "white" {}
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
            //#define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _Color;
            uniform sampler2D _node_3562; uniform float4 _node_3562_ST;
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
                float node_352_ang = ((-0.15)*3.141592654);
                float node_352_spd = 1.0;
                float node_352_cos = cos(node_352_spd*node_352_ang);
                float node_352_sin = sin(node_352_spd*node_352_ang);
                float2 node_352_piv = float2(0.5,0.5);
                float2 node_352 = (mul(i.uv0-node_352_piv,float2x2( node_352_cos, -node_352_sin, node_352_sin, node_352_cos))+node_352_piv);
                float4 node_7249 = _Time + _TimeEditor;
                float2 node_6337 = float2((node_352.r+(node_7249.g*0.5)+0.05),i.uv0.g);
                float4 _node_3562_var = tex2D(_node_3562,TRANSFORM_TEX(node_6337, _node_3562));
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float3 finalColor = saturate((saturate((_node_3562_var.r*pow((_Diffuse_var.r*_Diffuse_var.g),20.0)*0.6))+(_Diffuse_var.rgb*_Color.rgb)));
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
