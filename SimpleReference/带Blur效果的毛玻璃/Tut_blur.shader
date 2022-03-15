// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33631,y:32810,varname:node_9361,prsc:2|custl-6307-OUT;n:type:ShaderForge.SFN_Slider,id:2883,x:31640,y:32451,ptovrint:False,ptlb:offset,ptin:_offset,varname:node_2883,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:0.05;n:type:ShaderForge.SFN_Set,id:184,x:32169,y:32454,varname:__offset,prsc:2|IN-8518-OUT;n:type:ShaderForge.SFN_ScreenPos,id:1662,x:32338,y:32435,varname:node_1662,prsc:2,sctp:2;n:type:ShaderForge.SFN_Set,id:1860,x:32563,y:32435,varname:__ScreenPos,prsc:2|IN-1662-UVOUT;n:type:ShaderForge.SFN_Set,id:4344,x:32563,y:32500,varname:__ScreenPosU,prsc:2|IN-1662-U;n:type:ShaderForge.SFN_Set,id:8066,x:32563,y:32572,varname:__ScreenPosV,prsc:2|IN-1662-V;n:type:ShaderForge.SFN_Add,id:4348,x:32232,y:33820,varname:node_4348,prsc:2|A-5383-OUT,B-2537-OUT;n:type:ShaderForge.SFN_Get,id:5383,x:31974,y:33866,varname:node_5383,prsc:2|IN-1860-OUT;n:type:ShaderForge.SFN_Get,id:2537,x:31974,y:33943,varname:node_2537,prsc:2|IN-184-OUT;n:type:ShaderForge.SFN_SceneColor,id:5786,x:32624,y:32921,varname:node_5786,prsc:2|UVIN-5080-OUT;n:type:ShaderForge.SFN_Get,id:3436,x:31965,y:32908,varname:node_3436,prsc:2|IN-4344-OUT;n:type:ShaderForge.SFN_Get,id:2834,x:31965,y:32986,varname:node_2834,prsc:2|IN-184-OUT;n:type:ShaderForge.SFN_Add,id:3737,x:32202,y:32921,varname:node_3737,prsc:2|A-3436-OUT,B-2834-OUT;n:type:ShaderForge.SFN_Get,id:3985,x:32181,y:32839,varname:node_3985,prsc:2|IN-8066-OUT;n:type:ShaderForge.SFN_Append,id:5080,x:32433,y:32921,varname:node_5080,prsc:2|A-3737-OUT,B-3985-OUT;n:type:ShaderForge.SFN_Get,id:1797,x:31965,y:33144,varname:node_1797,prsc:2|IN-8066-OUT;n:type:ShaderForge.SFN_Get,id:6589,x:31965,y:33222,varname:node_6589,prsc:2|IN-184-OUT;n:type:ShaderForge.SFN_Add,id:9670,x:32202,y:33157,varname:node_9670,prsc:2|A-1797-OUT,B-6589-OUT;n:type:ShaderForge.SFN_Get,id:2393,x:32202,y:33081,varname:node_2393,prsc:2|IN-4344-OUT;n:type:ShaderForge.SFN_Append,id:5300,x:32433,y:33157,varname:node_5300,prsc:2|A-2393-OUT,B-9670-OUT;n:type:ShaderForge.SFN_SceneColor,id:336,x:32624,y:33157,varname:node_336,prsc:2|UVIN-5300-OUT;n:type:ShaderForge.SFN_Add,id:2776,x:33184,y:33050,varname:node_2776,prsc:2|A-8872-RGB,B-2423-OUT,C-1903-OUT;n:type:ShaderForge.SFN_Divide,id:6307,x:33410,y:33050,varname:node_6307,prsc:2|A-2776-OUT,B-7643-OUT;n:type:ShaderForge.SFN_Vector1,id:7643,x:33184,y:33194,varname:node_7643,prsc:2,v1:9;n:type:ShaderForge.SFN_SceneColor,id:8872,x:32624,y:32736,varname:node_8872,prsc:2|UVIN-3771-OUT;n:type:ShaderForge.SFN_Get,id:3771,x:32395,y:32736,varname:node_3771,prsc:2|IN-1860-OUT;n:type:ShaderForge.SFN_SceneColor,id:6266,x:32633,y:33370,varname:node_6266,prsc:2|UVIN-2615-OUT;n:type:ShaderForge.SFN_Get,id:4458,x:31974,y:33357,varname:node_4458,prsc:2|IN-4344-OUT;n:type:ShaderForge.SFN_Get,id:522,x:31974,y:33435,varname:node_522,prsc:2|IN-184-OUT;n:type:ShaderForge.SFN_Get,id:4446,x:32190,y:33288,varname:node_4446,prsc:2|IN-8066-OUT;n:type:ShaderForge.SFN_Append,id:2615,x:32442,y:33370,varname:node_2615,prsc:2|A-6482-OUT,B-4446-OUT;n:type:ShaderForge.SFN_Get,id:1216,x:31974,y:33593,varname:node_1216,prsc:2|IN-8066-OUT;n:type:ShaderForge.SFN_Get,id:3767,x:31974,y:33671,varname:node_3767,prsc:2|IN-184-OUT;n:type:ShaderForge.SFN_Get,id:6011,x:32211,y:33530,varname:node_6011,prsc:2|IN-4344-OUT;n:type:ShaderForge.SFN_Append,id:7740,x:32442,y:33574,varname:node_7740,prsc:2|A-6011-OUT,B-6016-OUT;n:type:ShaderForge.SFN_SceneColor,id:8077,x:32633,y:33574,varname:node_8077,prsc:2|UVIN-7740-OUT;n:type:ShaderForge.SFN_Subtract,id:6482,x:32211,y:33370,varname:node_6482,prsc:2|A-4458-OUT,B-522-OUT;n:type:ShaderForge.SFN_Subtract,id:6016,x:32232,y:33635,varname:node_6016,prsc:2|A-1216-OUT,B-3767-OUT;n:type:ShaderForge.SFN_SceneColor,id:5088,x:32633,y:33826,varname:node_5088,prsc:2|UVIN-4348-OUT;n:type:ShaderForge.SFN_Add,id:2423,x:32853,y:33370,varname:node_2423,prsc:2|A-5786-RGB,B-336-RGB,C-6266-RGB,D-8077-RGB;n:type:ShaderForge.SFN_Add,id:1903,x:32888,y:34054,varname:node_1903,prsc:2|A-5088-RGB,B-8346-RGB,C-6437-RGB,D-8015-RGB;n:type:ShaderForge.SFN_SceneColor,id:8346,x:32633,y:33976,varname:node_8346,prsc:2|UVIN-1644-OUT;n:type:ShaderForge.SFN_Subtract,id:1644,x:32232,y:33966,varname:node_1644,prsc:2|A-5383-OUT,B-2537-OUT;n:type:ShaderForge.SFN_Get,id:3410,x:31950,y:34303,varname:node_3410,prsc:2|IN-8066-OUT;n:type:ShaderForge.SFN_Get,id:5523,x:31950,y:34381,varname:node_5523,prsc:2|IN-184-OUT;n:type:ShaderForge.SFN_Get,id:5051,x:31950,y:34221,varname:node_5051,prsc:2|IN-4344-OUT;n:type:ShaderForge.SFN_Subtract,id:6604,x:32232,y:34116,varname:node_6604,prsc:2|A-5051-OUT,B-5523-OUT;n:type:ShaderForge.SFN_Add,id:6646,x:32232,y:34246,varname:node_6646,prsc:2|A-3410-OUT,B-5523-OUT;n:type:ShaderForge.SFN_SceneColor,id:6437,x:32633,y:34132,varname:node_6437,prsc:2|UVIN-8235-OUT;n:type:ShaderForge.SFN_Append,id:8235,x:32436,y:34132,varname:node_8235,prsc:2|A-6604-OUT,B-6646-OUT;n:type:ShaderForge.SFN_Subtract,id:9560,x:32231,y:34374,varname:node_9560,prsc:2|A-3410-OUT,B-5523-OUT;n:type:ShaderForge.SFN_Add,id:3702,x:32231,y:34502,varname:node_3702,prsc:2|A-5051-OUT,B-5523-OUT;n:type:ShaderForge.SFN_SceneColor,id:8015,x:32633,y:34374,varname:node_8015,prsc:2|UVIN-1292-OUT;n:type:ShaderForge.SFN_Append,id:1292,x:32436,y:34374,varname:node_1292,prsc:2|A-3702-OUT,B-9560-OUT;n:type:ShaderForge.SFN_Distance,id:3271,x:31616,y:32568,varname:node_3271,prsc:2|A-2709-XYZ,B-131-XYZ;n:type:ShaderForge.SFN_ObjectPosition,id:2709,x:31423,y:32551,varname:node_2709,prsc:2;n:type:ShaderForge.SFN_ViewPosition,id:131,x:31433,y:32692,varname:node_131,prsc:2;n:type:ShaderForge.SFN_Divide,id:8518,x:31999,y:32454,varname:node_8518,prsc:2|A-2883-OUT,B-5050-OUT;n:type:ShaderForge.SFN_Divide,id:5050,x:31843,y:32568,varname:node_5050,prsc:2|A-3271-OUT,B-7571-OUT;n:type:ShaderForge.SFN_Log,id:7571,x:31723,y:32790,varname:node_7571,prsc:2,lt:0|IN-3271-OUT;proporder:2883;pass:END;sub:END;*/

Shader "Shader Forge/Tut_blur" {
    Properties {
        _offset ("offset", Range(0, 0.05)) = 0
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
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform float _offset;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 projPos : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
                float2 __ScreenPos = sceneUVs.rg;
                float __ScreenPosU = sceneUVs.r;
                float node_3271 = distance(objPos.rgb,_WorldSpaceCameraPos);
                float __offset = (_offset/(node_3271/log(node_3271)));
                float __ScreenPosV = sceneUVs.g;
                float node_4458 = __ScreenPosU;
                float node_522 = __offset;
                float node_1216 = __ScreenPosV;
                float node_3767 = __offset;
                float2 node_5383 = __ScreenPos;
                float node_2537 = __offset;
                float node_5051 = __ScreenPosU;
                float node_5523 = __offset;
                float node_3410 = __ScreenPosV;
                float3 finalColor = ((tex2D( _GrabTexture, __ScreenPos).rgb+(tex2D( _GrabTexture, float2((__ScreenPosU+__offset),__ScreenPosV)).rgb+tex2D( _GrabTexture, float2(__ScreenPosU,(__ScreenPosV+__offset))).rgb+tex2D( _GrabTexture, float2((node_4458-node_522),__ScreenPosV)).rgb+tex2D( _GrabTexture, float2(__ScreenPosU,(node_1216-node_3767))).rgb)+(tex2D( _GrabTexture, (node_5383+node_2537)).rgb+tex2D( _GrabTexture, (node_5383-node_2537)).rgb+tex2D( _GrabTexture, float2((node_5051-node_5523),(node_3410+node_5523))).rgb+tex2D( _GrabTexture, float2((node_5051+node_5523),(node_3410-node_5523))).rgb))/9.0);
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
