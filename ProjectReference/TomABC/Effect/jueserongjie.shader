// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33497,y:32741,varname:node_9361,prsc:2|custl-1453-OUT,alpha-128-OUT;n:type:ShaderForge.SFN_Posterize,id:3130,x:31665,y:32431,varname:node_3130,prsc:2|IN-1577-UVOUT,STPS-6270-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6270,x:31455,y:32622,ptovrint:False,ptlb:fenkuai,ptin:_fenkuai,varname:node_6270,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:10;n:type:ShaderForge.SFN_Tex2d,id:9947,x:31889,y:32447,varname:node_9947,prsc:2,tex:2d0e4a67a85b80843ba911c4ff68c7cc,ntxv:0,isnm:False|UVIN-3130-OUT,TEX-4431-TEX;n:type:ShaderForge.SFN_Slider,id:8670,x:31470,y:32982,ptovrint:False,ptlb:chuxian,ptin:_chuxian,varname:node_8670,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-0.01,cur:1.2,max:1.2;n:type:ShaderForge.SFN_Multiply,id:4055,x:32810,y:32830,varname:node_4055,prsc:2|A-8587-RGB,B-3713-OUT;n:type:ShaderForge.SFN_Color,id:8587,x:32540,y:32727,ptovrint:False,ptlb:color,ptin:_color,varname:node_8587,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:0.6367924,c2:0.9931678,c3:1,c4:1;n:type:ShaderForge.SFN_If,id:9421,x:32520,y:33133,varname:node_9421,prsc:2|A-5929-OUT,B-8670-OUT,GT-6585-OUT,EQ-3722-OUT,LT-3722-OUT;n:type:ShaderForge.SFN_Vector1,id:6585,x:32101,y:33339,varname:node_6585,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:3722,x:32046,y:33437,varname:node_3722,prsc:2,v1:1;n:type:ShaderForge.SFN_FragmentPosition,id:6110,x:31838,y:32827,varname:node_6110,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9609,x:32654,y:32464,varname:node_9609,prsc:2|A-1076-OUT,B-5929-OUT,C-8587-RGB;n:type:ShaderForge.SFN_Divide,id:1476,x:32112,y:32930,varname:node_1476,prsc:2|A-6110-Y,B-9502-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9502,x:31869,y:33165,ptovrint:False,ptlb:shengao,ptin:_shengao,varname:node_9502,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Power,id:5929,x:32340,y:32952,varname:node_5929,prsc:2|VAL-1476-OUT,EXP-7573-OUT;n:type:ShaderForge.SFN_Vector1,id:7573,x:32112,y:33165,varname:node_7573,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:4318,x:31734,y:33256,varname:node_4318,prsc:2|A-8670-OUT,B-4565-OUT;n:type:ShaderForge.SFN_Vector1,id:4565,x:31478,y:33352,varname:node_4565,prsc:2,v1:0.01;n:type:ShaderForge.SFN_If,id:7306,x:32508,y:33367,varname:node_7306,prsc:2|A-5929-OUT,B-4318-OUT,GT-6585-OUT,EQ-3722-OUT,LT-3722-OUT;n:type:ShaderForge.SFN_Multiply,id:5844,x:32892,y:32558,varname:node_5844,prsc:2|A-9609-OUT,B-7306-OUT;n:type:ShaderForge.SFN_Subtract,id:3713,x:32820,y:33288,varname:node_3713,prsc:2|A-9421-OUT,B-7306-OUT;n:type:ShaderForge.SFN_Add,id:1453,x:33007,y:32844,varname:node_1453,prsc:2|A-5844-OUT,B-4055-OUT,C-3709-OUT;n:type:ShaderForge.SFN_ScreenPos,id:1577,x:31418,y:32431,varname:node_1577,prsc:2,sctp:1;n:type:ShaderForge.SFN_Tex2dAsset,id:4431,x:31665,y:32598,ptovrint:False,ptlb:node_4431,ptin:_node_4431,varname:node_4431,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:2d0e4a67a85b80843ba911c4ff68c7cc,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7303,x:32291,y:32464,varname:node_7303,prsc:2|A-9209-OUT,B-4741-TTR;n:type:ShaderForge.SFN_Time,id:4741,x:31950,y:32629,varname:node_4741,prsc:2;n:type:ShaderForge.SFN_Frac,id:1076,x:32455,y:32464,varname:node_1076,prsc:2|IN-7303-OUT;n:type:ShaderForge.SFN_ConstantClamp,id:9209,x:32094,y:32464,varname:node_9209,prsc:2,min:0.2,max:0.8|IN-9947-R;n:type:ShaderForge.SFN_Multiply,id:4303,x:32862,y:33135,varname:node_4303,prsc:2|A-1076-OUT,B-7306-OUT;n:type:ShaderForge.SFN_Add,id:4407,x:33185,y:33136,varname:node_4407,prsc:2|A-4303-OUT,B-3713-OUT,C-7226-OUT;n:type:ShaderForge.SFN_Fresnel,id:3085,x:33244,y:32618,varname:node_3085,prsc:2|EXP-9362-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9362,x:33081,y:32618,ptovrint:False,ptlb:fresnel,ptin:_fresnel,varname:node_9362,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:7226,x:32974,y:32984,varname:node_7226,prsc:2|A-3085-OUT,B-7306-OUT;n:type:ShaderForge.SFN_Multiply,id:3709,x:33196,y:32730,varname:node_3709,prsc:2|A-3085-OUT,B-8587-RGB;n:type:ShaderForge.SFN_Add,id:9991,x:33134,y:33724,varname:node_9991,prsc:2|A-7487-OUT,B-8400-OUT;n:type:ShaderForge.SFN_Slider,id:2065,x:32211,y:33824,ptovrint:False,ptlb:xiaoshi,ptin:_xiaoshi,varname:node_2065,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:4;n:type:ShaderForge.SFN_Multiply,id:8400,x:32796,y:33807,varname:node_8400,prsc:2|A-2065-OUT,B-9502-OUT;n:type:ShaderForge.SFN_Subtract,id:3046,x:33318,y:33280,varname:node_3046,prsc:2|A-4407-OUT,B-8266-OUT;n:type:ShaderForge.SFN_Clamp01,id:128,x:33382,y:33456,varname:node_128,prsc:2|IN-3046-OUT;n:type:ShaderForge.SFN_Subtract,id:4957,x:32972,y:33414,varname:node_4957,prsc:2|A-8400-OUT,B-6110-Y;n:type:ShaderForge.SFN_Power,id:3067,x:32759,y:33653,varname:node_3067,prsc:2|VAL-6110-Y,EXP-5912-OUT;n:type:ShaderForge.SFN_Vector1,id:5912,x:32485,y:33680,varname:node_5912,prsc:2,v1:3;n:type:ShaderForge.SFN_Multiply,id:7487,x:32972,y:33596,varname:node_7487,prsc:2|A-3586-OUT,B-3067-OUT;n:type:ShaderForge.SFN_Vector1,id:3586,x:32710,y:33532,varname:node_3586,prsc:2,v1:-1;n:type:ShaderForge.SFN_Clamp01,id:9196,x:33318,y:33724,varname:node_9196,prsc:2|IN-9991-OUT;n:type:ShaderForge.SFN_ConstantClamp,id:8266,x:33318,y:33826,varname:node_8266,prsc:2,min:0,max:2|IN-9991-OUT;proporder:4431-6270-8670-8587-9502-9362-2065;pass:END;sub:END;*/

Shader "Tomcat/Effect/jueserongjie" {
    Properties {
        _node_4431 ("node_4431", 2D) = "white" {}
        _fenkuai ("fenkuai", Float ) = 10
        _chuxian ("chuxian", Range(-0.01, 1.2)) = 1.2
        [HDR]_color ("color", Color) = (0.6367924,0.9931678,1,1)
        _shengao ("shengao", Float ) = 2
        _fresnel ("fresnel", Float ) = 1
        _xiaoshi ("xiaoshi", Range(-1, 4)) = 0
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
            uniform float _fenkuai;
            uniform float _chuxian;
            uniform float4 _color;
            uniform float _shengao;
            uniform sampler2D _node_4431; uniform float4 _node_4431_ST;
            uniform float _fresnel;
            uniform float _xiaoshi;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 projPos : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
////// Lighting:
                float2 node_3130 = floor(float2((sceneUVs.x * 2 - 1)*(_ScreenParams.r/_ScreenParams.g), sceneUVs.y * 2 - 1).rg * _fenkuai) / (_fenkuai - 1);
                float4 node_9947 = tex2D(_node_4431,TRANSFORM_TEX(node_3130, _node_4431));
                float4 node_4741 = _Time;
                float node_1076 = frac((clamp(node_9947.r,0.2,0.8)*node_4741.a));
                float node_5929 = pow((i.posWorld.g/_shengao),1.0);
                float node_7306_if_leA = step(node_5929,(_chuxian-0.01));
                float node_7306_if_leB = step((_chuxian-0.01),node_5929);
                float node_3722 = 1.0;
                float node_6585 = 0.0;
                float node_7306 = lerp((node_7306_if_leA*node_3722)+(node_7306_if_leB*node_6585),node_3722,node_7306_if_leA*node_7306_if_leB);
                float node_9421_if_leA = step(node_5929,_chuxian);
                float node_9421_if_leB = step(_chuxian,node_5929);
                float node_3713 = (lerp((node_9421_if_leA*node_3722)+(node_9421_if_leB*node_6585),node_3722,node_9421_if_leA*node_9421_if_leB)-node_7306);
                float node_3085 = pow(1.0-max(0,dot(normalDirection, viewDirection)),_fresnel);
                float3 finalColor = (((node_1076*node_5929*_color.rgb)*node_7306)+(_color.rgb*node_3713)+(node_3085*_color.rgb));
                float node_8400 = (_xiaoshi*_shengao);
                float node_9991 = (((-1.0)*pow(i.posWorld.g,3.0))+node_8400);
                fixed4 finalRGBA = fixed4(finalColor,saturate((((node_1076*node_7306)+node_3713+(node_3085*node_7306))-clamp(node_9991,0,2))));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
