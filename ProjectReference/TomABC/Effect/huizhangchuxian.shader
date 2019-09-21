// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.9882353,fgcg:0.6257871,fgcb:0.454902,fgca:1,fgde:0.01,fgrn:-45.9,fgrf:296.5,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-8800-OUT,clip-2268-OUT;n:type:ShaderForge.SFN_Tex2d,id:851,x:31565,y:32207,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_851,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a2cdda053949c7b428312e61a92c6d3b,ntxv:0,isnm:False|UVIN-5924-UVOUT;n:type:ShaderForge.SFN_Color,id:5927,x:31860,y:32664,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_5927,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.9813787,c3:0.8443396,c4:1;n:type:ShaderForge.SFN_Multiply,id:544,x:32072,y:32619,cmnt:Diffuse Color,varname:node_544,prsc:2|A-851-RGB,B-5927-RGB;n:type:ShaderForge.SFN_TexCoord,id:3775,x:30094,y:31391,varname:node_3775,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_ComponentMask,id:6223,x:30613,y:31528,varname:node_6223,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-352-UVOUT;n:type:ShaderForge.SFN_Rotator,id:352,x:30387,y:31491,varname:node_352,prsc:2|UVIN-3775-UVOUT,ANG-8062-OUT;n:type:ShaderForge.SFN_Vector1,id:7513,x:29666,y:31569,varname:node_7513,prsc:2,v1:0.72;n:type:ShaderForge.SFN_Multiply,id:8062,x:30062,y:31680,varname:node_8062,prsc:2|A-7513-OUT,B-9343-OUT;n:type:ShaderForge.SFN_Pi,id:9343,x:29690,y:31818,varname:node_9343,prsc:2;n:type:ShaderForge.SFN_Power,id:4593,x:32197,y:32068,varname:node_4593,prsc:2|VAL-851-A,EXP-8984-OUT;n:type:ShaderForge.SFN_Vector1,id:8984,x:32040,y:32292,varname:node_8984,prsc:2,v1:2;n:type:ShaderForge.SFN_Add,id:3107,x:32403,y:32637,varname:node_3107,prsc:2|A-4563-OUT,B-544-OUT;n:type:ShaderForge.SFN_Add,id:9155,x:30851,y:31557,varname:node_9155,prsc:2|A-6223-OUT,B-7442-OUT,C-3202-OUT;n:type:ShaderForge.SFN_Time,id:7249,x:30159,y:31843,varname:node_7249,prsc:2;n:type:ShaderForge.SFN_Multiply,id:8079,x:32455,y:31832,varname:node_8079,prsc:2|A-3562-R,B-4593-OUT,C-1871-OUT;n:type:ShaderForge.SFN_Multiply,id:7442,x:30438,y:31950,varname:node_7442,prsc:2|A-7249-T,B-3238-OUT;n:type:ShaderForge.SFN_Clamp01,id:4563,x:32662,y:32075,varname:node_4563,prsc:2|IN-8079-OUT;n:type:ShaderForge.SFN_Clamp01,id:3665,x:32665,y:32717,varname:node_3665,prsc:2|IN-3107-OUT;n:type:ShaderForge.SFN_Tex2d,id:3562,x:31361,y:31482,ptovrint:False,ptlb:node_3562,ptin:_node_3562,varname:node_3562,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:3119d73826e38484585468af49c9fe50,ntxv:0,isnm:False|UVIN-6337-OUT;n:type:ShaderForge.SFN_Append,id:6337,x:31062,y:31444,varname:node_6337,prsc:2|A-9155-OUT,B-3775-V;n:type:ShaderForge.SFN_Vector1,id:3238,x:30203,y:32111,varname:node_3238,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:3202,x:30683,y:31876,varname:node_3202,prsc:2,v1:0.05;n:type:ShaderForge.SFN_Vector1,id:1871,x:32061,y:31917,varname:node_1871,prsc:2,v1:0.6;n:type:ShaderForge.SFN_TexCoord,id:19,x:31774,y:33287,varname:node_19,prsc:2,uv:2,uaff:False;n:type:ShaderForge.SFN_Slider,id:1431,x:31938,y:33462,ptovrint:False,ptlb:node_1431,ptin:_node_1431,varname:node_1431,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_If,id:2268,x:32820,y:33425,varname:node_2268,prsc:2|A-19-V,B-1431-OUT,GT-619-OUT,EQ-619-OUT,LT-5410-OUT;n:type:ShaderForge.SFN_Vector1,id:619,x:32095,y:33564,varname:node_619,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:5410,x:32147,y:33644,varname:node_5410,prsc:2,v1:1;n:type:ShaderForge.SFN_FaceSign,id:125,x:32600,y:32467,varname:node_125,prsc:2,fstp:0;n:type:ShaderForge.SFN_ConstantClamp,id:6186,x:32780,y:32525,varname:node_6186,prsc:2,min:0.8,max:1|IN-125-VFACE;n:type:ShaderForge.SFN_Multiply,id:8800,x:32954,y:32765,varname:node_8800,prsc:2|A-6186-OUT,B-3689-OUT;n:type:ShaderForge.SFN_TexCoord,id:5924,x:31067,y:32085,varname:node_5924,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:7737,x:31432,y:33100,ptovrint:False,ptlb:SAG,ptin:_SAG,varname:node_7737,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-5924-UVOUT;n:type:ShaderForge.SFN_NormalVector,id:9796,x:31475,y:32888,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:5023,x:31796,y:32924,varname:node_5023,prsc:2,tffrom:1,tfto:3|IN-9796-OUT;n:type:ShaderForge.SFN_RemapRange,id:7798,x:32013,y:32924,varname:node_7798,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-5023-XYZ;n:type:ShaderForge.SFN_ComponentMask,id:8468,x:32199,y:32924,varname:node_8468,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-7798-OUT;n:type:ShaderForge.SFN_Tex2d,id:8092,x:32398,y:32924,ptovrint:False,ptlb:MatCap,ptin:_MatCap,varname:node_8092,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8468-OUT;n:type:ShaderForge.SFN_Multiply,id:3399,x:32635,y:33037,varname:node_3399,prsc:2|A-8092-RGB,B-7737-G,C-8194-OUT;n:type:ShaderForge.SFN_Slider,id:8194,x:32309,y:33203,ptovrint:False,ptlb:MatCapScale,ptin:_MatCapScale,varname:node_8194,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Add,id:3689,x:32801,y:32886,varname:node_3689,prsc:2|A-3665-OUT,B-3399-OUT;proporder:851-5927-3562-1431-7737-8092-8194;pass:END;sub:END;*/

Shader "Tomcat/Effect/huizhangchuxian" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _Color ("Color", Color) = (1,0.9813787,0.8443396,1)
        _node_3562 ("node_3562", 2D) = "white" {}
        _node_1431 ("node_1431", Range(0, 1)) = 0
        _SAG ("SAG", 2D) = "white" {}
        _MatCap ("MatCap", 2D) = "white" {}
        _MatCapScale ("MatCapScale", Range(0, 1)) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float4 _Color;
            uniform sampler2D _node_3562; uniform float4 _node_3562_ST;
            uniform float _node_1431;
            uniform sampler2D _SAG; uniform float4 _SAG_ST;
            uniform sampler2D _MatCap; uniform float4 _MatCap_ST;
            uniform float _MatCapScale;
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
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float node_2268_if_leA = step(i.uv2.g,_node_1431);
                float node_2268_if_leB = step(_node_1431,i.uv2.g);
                float node_619 = 0.0;
                clip(lerp((node_2268_if_leA*1.0)+(node_2268_if_leB*node_619),node_619,node_2268_if_leA*node_2268_if_leB) - 0.5);
////// Lighting:
                float node_352_ang = (0.72*3.141592654);
                float node_352_spd = 1.0;
                float node_352_cos = cos(node_352_spd*node_352_ang);
                float node_352_sin = sin(node_352_spd*node_352_ang);
                float2 node_352_piv = float2(0.5,0.5);
                float2 node_352 = (mul(i.uv2-node_352_piv,float2x2( node_352_cos, -node_352_sin, node_352_sin, node_352_cos))+node_352_piv);
                float4 node_7249 = _Time;
                float2 node_6337 = float2((node_352.r+(node_7249.g*0.5)+0.05),i.uv2.g);
                float4 _node_3562_var = tex2D(_node_3562,TRANSFORM_TEX(node_6337, _node_3562));
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                float2 node_8468 = (UnityObjectToViewPos( float4(i.normalDir,0) ).xyz.rgb*0.5+0.5).rg;
                float4 _MatCap_var = tex2D(_MatCap,TRANSFORM_TEX(node_8468, _MatCap));
                float4 _SAG_var = tex2D(_SAG,TRANSFORM_TEX(i.uv0, _SAG));
                float3 finalColor = (clamp(isFrontFace,0.8,1)*(saturate((saturate((_node_3562_var.r*pow(_Diffuse_var.a,2.0)*0.6))+(_Diffuse_var.rgb*_Color.rgb)))+(_MatCap_var.rgb*_SAG_var.g*_MatCapScale)));
                return fixed4(finalColor,1);
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
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float _node_1431;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv2 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv2 = v.texcoord2;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float node_2268_if_leA = step(i.uv2.g,_node_1431);
                float node_2268_if_leB = step(_node_1431,i.uv2.g);
                float node_619 = 0.0;
                clip(lerp((node_2268_if_leA*1.0)+(node_2268_if_leB*node_619),node_619,node_2268_if_leA*node_2268_if_leB) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
