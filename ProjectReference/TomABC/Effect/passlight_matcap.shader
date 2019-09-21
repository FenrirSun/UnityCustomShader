// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.16,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33384,y:32150,varname:node_9361,prsc:2|custl-9434-OUT;n:type:ShaderForge.SFN_Tex2d,id:851,x:31675,y:32048,varname:node_851,prsc:2,ntxv:0,isnm:False|UVIN-1391-UVOUT,TEX-280-TEX;n:type:ShaderForge.SFN_Color,id:5927,x:32111,y:32467,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_5927,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.9813787,c3:0.8443396,c4:1;n:type:ShaderForge.SFN_Multiply,id:544,x:32452,y:32427,cmnt:Diffuse Color,varname:node_544,prsc:2|A-851-RGB,B-5927-RGB;n:type:ShaderForge.SFN_TexCoord,id:3775,x:30587,y:31536,varname:node_3775,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_ComponentMask,id:6223,x:31173,y:31698,varname:node_6223,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-352-UVOUT;n:type:ShaderForge.SFN_Rotator,id:352,x:30947,y:31661,varname:node_352,prsc:2|UVIN-3775-UVOUT,ANG-8062-OUT;n:type:ShaderForge.SFN_Multiply,id:8062,x:30702,y:31704,varname:node_8062,prsc:2|A-5157-OUT,B-9343-OUT;n:type:ShaderForge.SFN_Pi,id:9343,x:30521,y:31748,varname:node_9343,prsc:2;n:type:ShaderForge.SFN_Power,id:4593,x:32158,y:32145,varname:node_4593,prsc:2|VAL-851-A,EXP-8984-OUT;n:type:ShaderForge.SFN_Vector1,id:8984,x:31984,y:32246,varname:node_8984,prsc:2,v1:2;n:type:ShaderForge.SFN_Add,id:3107,x:32808,y:32367,varname:node_3107,prsc:2|A-4563-OUT,B-544-OUT;n:type:ShaderForge.SFN_Add,id:9155,x:31411,y:31727,varname:node_9155,prsc:2|A-6223-OUT,B-7442-OUT,C-3202-OUT;n:type:ShaderForge.SFN_Time,id:7249,x:30853,y:31900,varname:node_7249,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8079,x:32464,y:31973,varname:node_8079,prsc:2|A-3562-R,B-4593-OUT,C-143-OUT;n:type:ShaderForge.SFN_Multiply,id:7442,x:31065,y:31925,varname:node_7442,prsc:2|A-7249-T,B-3238-OUT;n:type:ShaderForge.SFN_Clamp01,id:4563,x:32470,y:32242,varname:node_4563,prsc:2|IN-8079-OUT;n:type:ShaderForge.SFN_Clamp01,id:3665,x:32975,y:32367,varname:node_3665,prsc:2|IN-3107-OUT;n:type:ShaderForge.SFN_Tex2d,id:3562,x:31933,y:31670,ptovrint:False,ptlb:node_3562,ptin:_node_3562,varname:node_3562,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3119d73826e38484585468af49c9fe50,ntxv:0,isnm:False|UVIN-6337-OUT;n:type:ShaderForge.SFN_Append,id:6337,x:31689,y:31630,varname:node_6337,prsc:2|A-9155-OUT,B-3775-V;n:type:ShaderForge.SFN_Vector1,id:3238,x:30853,y:32034,varname:node_3238,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:3202,x:31218,y:31975,varname:node_3202,prsc:2,v1:0.05;n:type:ShaderForge.SFN_Tex2d,id:9464,x:32702,y:32645,ptovrint:False,ptlb:MatCap,ptin:_MatCap,varname:node_9464,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8655-OUT;n:type:ShaderForge.SFN_NormalVector,id:7212,x:31925,y:32667,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:5994,x:32111,y:32667,varname:node_5994,prsc:2,tffrom:1,tfto:3|IN-7212-OUT;n:type:ShaderForge.SFN_RemapRange,id:3818,x:32298,y:32667,varname:node_3818,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-5994-XYZ;n:type:ShaderForge.SFN_ComponentMask,id:8655,x:32483,y:32667,varname:node_8655,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-3818-OUT;n:type:ShaderForge.SFN_Multiply,id:5892,x:32977,y:32643,varname:node_5892,prsc:2|A-9464-RGB,B-4788-G,C-9835-OUT;n:type:ShaderForge.SFN_Add,id:9434,x:33188,y:32509,varname:node_9434,prsc:2|A-3665-OUT,B-5892-OUT;n:type:ShaderForge.SFN_Set,id:3936,x:31767,y:32370,varname:MainAlpha,prsc:2|IN-851-A;n:type:ShaderForge.SFN_Slider,id:9835,x:32624,y:32903,ptovrint:False,ptlb:MatCapScale,ptin:_MatCapScale,varname:node_9835,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4444445,max:1;n:type:ShaderForge.SFN_Tex2dAsset,id:280,x:31231,y:32273,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_280,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:1391,x:31381,y:32094,varname:node_1391,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:5157,x:30395,y:31682,ptovrint:False,ptlb:jiaodu,ptin:_jiaodu,varname:node_5157,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:143,x:32120,y:31952,ptovrint:False,ptlb:liuguangqiangdu,ptin:_liuguangqiangdu,varname:node_143,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.6;n:type:ShaderForge.SFN_Tex2d,id:4788,x:32247,y:32889,ptovrint:False,ptlb:SAG,ptin:_SAG,varname:node_4788,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1391-UVOUT;proporder:280-5927-3562-5157-143-9464-9835-4788;pass:END;sub:END;*/

Shader "Tomcat/Effect/passlight_matcap" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _Color ("Color", Color) = (1,0.9813787,0.8443396,1)
        _node_3562 ("node_3562", 2D) = "white" {}
        _jiaodu ("jiaodu", Float ) = 0
        _liuguangqiangdu ("liuguangqiangdu", Float ) = 0.6
        _MatCap ("MatCap", 2D) = "white" {}
        _MatCapScale ("MatCapScale", Range(0, 1)) = 0.4444445
        _SAG ("SAG", 2D) = "white" {}
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _node_3562; uniform float4 _node_3562_ST;
            uniform sampler2D _MatCap; uniform float4 _MatCap_ST;
            uniform float _MatCapScale;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float _jiaodu;
            uniform float _liuguangqiangdu;
            uniform sampler2D _SAG; uniform float4 _SAG_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float node_352_ang = (_jiaodu*3.141592654);
                float node_352_spd = 1.0;
                float node_352_cos = cos(node_352_spd*node_352_ang);
                float node_352_sin = sin(node_352_spd*node_352_ang);
                float2 node_352_piv = float2(0.5,0.5);
                float2 node_352 = (mul(i.uv2-node_352_piv,float2x2( node_352_cos, -node_352_sin, node_352_sin, node_352_cos))+node_352_piv);
                float4 node_7249 = _Time;
                float2 node_6337 = float2((node_352.r+(node_7249.g*0.5)+0.05),i.uv2.g);
                float4 _node_3562_var = tex2D(_node_3562,TRANSFORM_TEX(node_6337, _node_3562));
                float4 node_851 = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float2 node_8655 = (UnityObjectToViewPos( float4(i.normalDir,0) ).xyz.rgb*0.5+0.5).rg;
                float4 _MatCap_var = tex2D(_MatCap,TRANSFORM_TEX(node_8655, _MatCap));
                float4 _SAG_var = tex2D(_SAG,TRANSFORM_TEX(i.uv0, _SAG));
                float3 finalColor = (saturate((saturate((_node_3562_var.r*pow(node_851.a,2.0)*_liuguangqiangdu))+(node_851.rgb*_Color.rgb)))+(_MatCap_var.rgb*_SAG_var.g*_MatCapScale));
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
