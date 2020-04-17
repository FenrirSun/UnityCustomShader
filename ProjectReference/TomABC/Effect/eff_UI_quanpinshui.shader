// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33394,y:32799,varname:node_9361,prsc:2|custl-6918-OUT,alpha-4133-OUT;n:type:ShaderForge.SFN_SceneColor,id:4368,x:32366,y:32371,varname:node_4368,prsc:2|UVIN-3530-UVOUT;n:type:ShaderForge.SFN_ScreenPos,id:2411,x:31677,y:32439,varname:node_2411,prsc:2,sctp:2;n:type:ShaderForge.SFN_Parallax,id:3530,x:32161,y:32454,varname:node_3530,prsc:2|UVIN-2411-UVOUT,HEI-8975-OUT;n:type:ShaderForge.SFN_TexCoord,id:1104,x:29855,y:32523,varname:node_1104,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:834,x:30352,y:32262,varname:node_834,prsc:2|A-1104-U,B-942-OUT,C-7760-OUT;n:type:ShaderForge.SFN_Vector1,id:942,x:30113,y:32629,varname:node_942,prsc:2,v1:3.5;n:type:ShaderForge.SFN_Pi,id:7760,x:30113,y:32697,varname:node_7760,prsc:2;n:type:ShaderForge.SFN_Sin,id:8543,x:30691,y:32245,varname:node_8543,prsc:2|IN-9441-OUT;n:type:ShaderForge.SFN_Step,id:5719,x:31040,y:32226,varname:node_5719,prsc:2|A-6626-OUT,B-3961-OUT;n:type:ShaderForge.SFN_RemapRange,id:3961,x:30851,y:32245,varname:node_3961,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-8543-OUT;n:type:ShaderForge.SFN_Multiply,id:5243,x:30667,y:32446,varname:node_5243,prsc:2|A-1104-V,B-1966-OUT;n:type:ShaderForge.SFN_Vector1,id:1966,x:30406,y:32498,varname:node_1966,prsc:2,v1:30;n:type:ShaderForge.SFN_RemapRange,id:5749,x:30575,y:32557,varname:node_5749,prsc:2,frmn:0,frmx:1,tomn:1,tomx:-30|IN-2836-OUT;n:type:ShaderForge.SFN_Add,id:6626,x:30851,y:32446,varname:node_6626,prsc:2|A-5243-OUT,B-5749-OUT;n:type:ShaderForge.SFN_Add,id:9441,x:30524,y:32245,varname:node_9441,prsc:2|A-7205-OUT,B-834-OUT;n:type:ShaderForge.SFN_Time,id:5392,x:30017,y:32316,varname:node_5392,prsc:2;n:type:ShaderForge.SFN_VertexColor,id:7201,x:31344,y:33828,varname:node_7201,prsc:2;n:type:ShaderForge.SFN_Multiply,id:412,x:32712,y:32456,varname:node_412,prsc:2|A-4368-RGB,B-4995-RGB,C-4995-A;n:type:ShaderForge.SFN_Color,id:4995,x:32366,y:32523,ptovrint:False,ptlb:color01,ptin:_color01,varname:node_4995,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:1133,x:32902,y:32665,varname:node_1133,prsc:2|A-412-OUT,B-5948-OUT;n:type:ShaderForge.SFN_Vector1,id:5009,x:31821,y:32564,varname:node_5009,prsc:2,v1:5;n:type:ShaderForge.SFN_Parallax,id:3287,x:31834,y:32768,varname:node_3287,prsc:2|UVIN-2411-UVOUT,HEI-9539-OUT;n:type:ShaderForge.SFN_Vector1,id:8408,x:31513,y:32802,varname:node_8408,prsc:2,v1:10;n:type:ShaderForge.SFN_SceneColor,id:4538,x:32067,y:32714,varname:node_4538,prsc:2|UVIN-3287-UVOUT;n:type:ShaderForge.SFN_Color,id:6672,x:32013,y:32897,ptovrint:False,ptlb:color02,ptin:_color02,varname:node_6672,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:904,x:32323,y:32816,varname:node_904,prsc:2|A-4538-RGB,B-6672-RGB,C-6672-A;n:type:ShaderForge.SFN_Set,id:4402,x:31575,y:33828,varname:kongzhi1,prsc:2|IN-7201-R;n:type:ShaderForge.SFN_Set,id:6667,x:31575,y:33895,varname:kongzhi2,prsc:2|IN-7201-G;n:type:ShaderForge.SFN_Set,id:9199,x:31575,y:33958,varname:kongzhi3,prsc:2|IN-7201-B;n:type:ShaderForge.SFN_Get,id:2836,x:30385,y:32557,varname:node_2836,prsc:2|IN-4402-OUT;n:type:ShaderForge.SFN_Set,id:9492,x:33097,y:32701,varname:layer1,prsc:2|IN-1133-OUT;n:type:ShaderForge.SFN_Multiply,id:6963,x:30219,y:33077,varname:node_6963,prsc:2|A-1104-U,B-6577-OUT,C-6211-OUT;n:type:ShaderForge.SFN_Vector1,id:6577,x:29957,y:33158,varname:node_6577,prsc:2,v1:4;n:type:ShaderForge.SFN_Pi,id:6211,x:29957,y:33227,varname:node_6211,prsc:2;n:type:ShaderForge.SFN_Sin,id:5158,x:30557,y:33059,varname:node_5158,prsc:2|IN-542-OUT;n:type:ShaderForge.SFN_Step,id:9228,x:30907,y:33041,varname:node_9228,prsc:2|A-4259-OUT,B-6744-OUT;n:type:ShaderForge.SFN_RemapRange,id:6744,x:30717,y:33059,varname:node_6744,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-5158-OUT;n:type:ShaderForge.SFN_Multiply,id:8216,x:30533,y:33261,varname:node_8216,prsc:2|A-1104-V,B-9303-OUT;n:type:ShaderForge.SFN_Vector1,id:9303,x:30272,y:33313,varname:node_9303,prsc:2,v1:25;n:type:ShaderForge.SFN_RemapRange,id:6237,x:30533,y:33384,varname:node_6237,prsc:2,frmn:0,frmx:1,tomn:1,tomx:-25|IN-1339-OUT;n:type:ShaderForge.SFN_Add,id:4259,x:30717,y:33261,varname:node_4259,prsc:2|A-8216-OUT,B-6237-OUT;n:type:ShaderForge.SFN_Add,id:542,x:30390,y:33059,varname:node_542,prsc:2|A-5229-OUT,B-6963-OUT;n:type:ShaderForge.SFN_Get,id:1339,x:30251,y:33372,varname:node_1339,prsc:2|IN-6667-OUT;n:type:ShaderForge.SFN_Set,id:608,x:31281,y:32303,varname:lang1,prsc:2|IN-6903-OUT;n:type:ShaderForge.SFN_Set,id:3877,x:31284,y:33091,varname:lang2,prsc:2|IN-1931-OUT;n:type:ShaderForge.SFN_Get,id:1752,x:32413,y:32702,varname:node_1752,prsc:2|IN-608-OUT;n:type:ShaderForge.SFN_Multiply,id:8682,x:32593,y:32888,varname:node_8682,prsc:2|A-904-OUT,B-1193-OUT;n:type:ShaderForge.SFN_Get,id:1193,x:32369,y:33021,varname:node_1193,prsc:2|IN-3877-OUT;n:type:ShaderForge.SFN_Subtract,id:883,x:32609,y:32702,varname:node_883,prsc:2|A-1752-OUT,B-1128-OUT;n:type:ShaderForge.SFN_Get,id:1128,x:32402,y:32749,varname:node_1128,prsc:2|IN-3877-OUT;n:type:ShaderForge.SFN_Set,id:8998,x:32767,y:32888,varname:layer2,prsc:2|IN-8682-OUT;n:type:ShaderForge.SFN_Add,id:6918,x:33085,y:32856,varname:node_6918,prsc:2|A-7546-OUT,B-9418-OUT,C-7151-OUT,D-1894-OUT;n:type:ShaderForge.SFN_Get,id:7546,x:32824,y:32830,varname:node_7546,prsc:2|IN-9492-OUT;n:type:ShaderForge.SFN_Get,id:9418,x:32826,y:32964,varname:node_9418,prsc:2|IN-8998-OUT;n:type:ShaderForge.SFN_Add,id:4791,x:32564,y:33181,varname:node_4791,prsc:2|A-9664-OUT,B-7525-OUT;n:type:ShaderForge.SFN_Get,id:9664,x:32328,y:33174,varname:node_9664,prsc:2|IN-608-OUT;n:type:ShaderForge.SFN_Get,id:7525,x:32310,y:33246,varname:node_7525,prsc:2|IN-3877-OUT;n:type:ShaderForge.SFN_Clamp01,id:4133,x:32747,y:33181,varname:node_4133,prsc:2|IN-4791-OUT;n:type:ShaderForge.SFN_Set,id:3617,x:31575,y:34020,varname:kongzhi4,prsc:2|IN-7201-A;n:type:ShaderForge.SFN_Get,id:9541,x:31513,y:32680,varname:node_9541,prsc:2|IN-3617-OUT;n:type:ShaderForge.SFN_Multiply,id:5229,x:30373,y:32928,varname:node_5229,prsc:2|A-5392-T,B-2311-OUT;n:type:ShaderForge.SFN_Vector1,id:2311,x:30134,y:32972,varname:node_2311,prsc:2,v1:10;n:type:ShaderForge.SFN_Multiply,id:7205,x:30409,y:32077,varname:node_7205,prsc:2|A-5392-T,B-2795-OUT;n:type:ShaderForge.SFN_Vector1,id:2795,x:30280,y:32184,varname:node_2795,prsc:2,v1:5;n:type:ShaderForge.SFN_Tex2d,id:6908,x:31973,y:33427,ptovrint:False,ptlb:rongjie,ptin:_rongjie,varname:node_6908,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b2f319da02d44e74e80e7c368a995ea1,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Step,id:6287,x:32452,y:33389,varname:node_6287,prsc:2|A-4273-OUT,B-3425-OUT;n:type:ShaderForge.SFN_Get,id:3425,x:32081,y:33664,varname:node_3425,prsc:2|IN-9199-OUT;n:type:ShaderForge.SFN_Get,id:1806,x:32163,y:33794,varname:node_1806,prsc:2|IN-9199-OUT;n:type:ShaderForge.SFN_Step,id:2277,x:32570,y:33696,varname:node_2277,prsc:2|A-4273-OUT,B-9524-OUT;n:type:ShaderForge.SFN_RemapRange,id:9524,x:32395,y:33724,varname:node_9524,prsc:2,frmn:0,frmx:1,tomn:0,tomx:1.05|IN-1806-OUT;n:type:ShaderForge.SFN_Set,id:3896,x:32738,y:33665,varname:rongjie1,prsc:2|IN-2277-OUT;n:type:ShaderForge.SFN_Set,id:288,x:32632,y:33425,varname:rongjie2,prsc:2|IN-6287-OUT;n:type:ShaderForge.SFN_Get,id:4174,x:31053,y:32482,varname:node_4174,prsc:2|IN-3896-OUT;n:type:ShaderForge.SFN_Multiply,id:6903,x:31254,y:32383,varname:node_6903,prsc:2|A-5719-OUT,B-4174-OUT;n:type:ShaderForge.SFN_Multiply,id:1931,x:31125,y:33201,varname:node_1931,prsc:2|A-9228-OUT,B-8032-OUT;n:type:ShaderForge.SFN_Get,id:8032,x:30934,y:33252,varname:node_8032,prsc:2|IN-288-OUT;n:type:ShaderForge.SFN_OneMinus,id:4273,x:32201,y:33389,varname:node_4273,prsc:2|IN-6908-R;n:type:ShaderForge.SFN_Multiply,id:8975,x:32002,y:32564,varname:node_8975,prsc:2|A-5009-OUT,B-9541-OUT;n:type:ShaderForge.SFN_Multiply,id:9539,x:31669,y:32768,varname:node_9539,prsc:2|A-9541-OUT,B-8408-OUT;n:type:ShaderForge.SFN_Add,id:7465,x:30804,y:33503,varname:node_7465,prsc:2|A-8216-OUT,B-7117-OUT;n:type:ShaderForge.SFN_Step,id:9324,x:30913,y:33385,varname:node_9324,prsc:2|A-7465-OUT,B-6744-OUT;n:type:ShaderForge.SFN_Subtract,id:4768,x:31217,y:33369,varname:node_4768,prsc:2|A-9324-OUT,B-9228-OUT;n:type:ShaderForge.SFN_Multiply,id:3422,x:31506,y:33512,varname:node_3422,prsc:2|A-1248-RGB,B-4768-OUT;n:type:ShaderForge.SFN_Color,id:1248,x:31152,y:33576,ptovrint:False,ptlb:miaobian,ptin:_miaobian,varname:node_1248,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Set,id:521,x:31628,y:33329,varname:langse2,prsc:2|IN-3422-OUT;n:type:ShaderForge.SFN_Get,id:7151,x:32897,y:33146,varname:node_7151,prsc:2|IN-521-OUT;n:type:ShaderForge.SFN_Subtract,id:7117,x:30620,y:33617,varname:node_7117,prsc:2|A-6237-OUT,B-1030-OUT;n:type:ShaderForge.SFN_Multiply,id:1030,x:30764,y:33775,varname:node_1030,prsc:2|A-1248-A,B-2960-OUT;n:type:ShaderForge.SFN_Vector1,id:2960,x:29813,y:33057,varname:node_2960,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Abs,id:5948,x:32767,y:32720,varname:node_5948,prsc:2|IN-883-OUT;n:type:ShaderForge.SFN_Color,id:658,x:30933,y:32607,ptovrint:False,ptlb:node_658,ptin:_node_658,varname:node_658,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:3068,x:30623,y:32811,varname:node_3068,prsc:2|A-658-A,B-2960-OUT;n:type:ShaderForge.SFN_Add,id:1680,x:31020,y:32876,varname:node_1680,prsc:2|A-5243-OUT,B-5879-OUT;n:type:ShaderForge.SFN_Step,id:440,x:31217,y:32906,varname:node_440,prsc:2|A-1680-OUT,B-3961-OUT;n:type:ShaderForge.SFN_Subtract,id:2361,x:31205,y:32687,varname:node_2361,prsc:2|A-5719-OUT,B-440-OUT;n:type:ShaderForge.SFN_Add,id:5879,x:30833,y:32796,varname:node_5879,prsc:2|A-5749-OUT,B-3068-OUT;n:type:ShaderForge.SFN_Multiply,id:3153,x:31361,y:32604,varname:node_3153,prsc:2|A-658-RGB,B-2361-OUT;n:type:ShaderForge.SFN_Set,id:6806,x:31532,y:32604,varname:langse1,prsc:2|IN-3153-OUT;n:type:ShaderForge.SFN_Get,id:1894,x:32827,y:33054,varname:node_1894,prsc:2|IN-6806-OUT;proporder:4995-6672-6908-1248-658;pass:END;sub:END;*/

Shader "Tomcat/Effect/UI_quanpinshui" {
    Properties {
        _color01 ("color01", Color) = (0.5,0.5,0.5,1)
        _color02 ("color02", Color) = (0.5,0.5,0.5,1)
        _rongjie ("rongjie", 2D) = "white" {}
        _miaobian ("miaobian", Color) = (1,1,1,1)
        _node_658 ("node_658", Color) = (0.5,0.5,0.5,1)
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
            uniform sampler2D _GrabTexture;
            uniform float4 _color01;
            uniform float4 _color02;
            uniform sampler2D _rongjie; uniform float4 _rongjie_ST;
            uniform float4 _miaobian;
            uniform float4 _node_658;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                float4 vertexColor : COLOR;
                float4 projPos : TEXCOORD5;
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
                float kongzhi4 = i.vertexColor.a;
                float node_9541 = kongzhi4;
                float kongzhi1 = i.vertexColor.r;
                float node_5749 = (kongzhi1*-31.0+1.0);
                float4 node_5392 = _Time;
                float node_3961 = (sin(((node_5392.g*5.0)+(i.uv0.r*3.5*3.141592654)))*0.5+0.5);
                float node_5719 = step(((i.uv0.g*30.0)+node_5749),node_3961);
                float4 _rongjie_var = tex2D(_rongjie,TRANSFORM_TEX(i.uv0, _rongjie));
                float node_4273 = (1.0 - _rongjie_var.r);
                float kongzhi3 = i.vertexColor.b;
                float rongjie1 = step(node_4273,(kongzhi3*1.05+0.0));
                float lang1 = (node_5719*rongjie1);
                float node_8216 = (i.uv0.g*25.0);
                float kongzhi2 = i.vertexColor.g;
                float node_6237 = (kongzhi2*-26.0+1.0);
                float node_6744 = (sin(((node_5392.g*10.0)+(i.uv0.r*4.0*3.141592654)))*0.5+0.5);
                float node_9228 = step((node_8216+node_6237),node_6744);
                float rongjie2 = step(node_4273,kongzhi3);
                float lang2 = (node_9228*rongjie2);

                float2 uv2 = (0.05*((5.0*node_9541) - 0.5)*mul(tangentTransform, viewDirection).xy + sceneUVs.rg).rg;
                float2 uv3 = (0.05*((node_9541*10.0) - 0.5)*mul(tangentTransform, viewDirection).xy + sceneUVs.rg).rg;
                if (_ProjectionParams.x > 0)
                {
                   uv2.y = 1 - uv2.y;
                   uv3.y = 1 - uv3.y;
                }

                float3 layer1 = ((tex2D( _GrabTexture, uv2).rgb*_color01.rgb*_color01.a)*abs((lang1-lang2)));
                float3 layer2 = ((tex2D( _GrabTexture, uv3).rgb*_color02.rgb*_color02.a)*lang2);
                float node_2960 = 0.1;
                float3 langse2 = (_miaobian.rgb*(step((node_8216+(node_6237-(_miaobian.a*node_2960))),node_6744)-node_9228));
                float node_3068 = (_node_658.a*node_2960);
                float3 langse1 = (_node_658.rgb*(node_5719-step(((i.uv0.g*30.0)+(node_5749+node_3068)),node_3961)));
                float3 finalColor = (layer1+layer2+langse2+langse1);
                fixed4 finalRGBA = fixed4(finalColor,saturate((lang1+lang2)));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
