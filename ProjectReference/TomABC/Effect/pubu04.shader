// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.3635636,fgcg:0.8113208,fgcb:0.7934223,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33481,y:32709,varname:node_9361,prsc:2|custl-885-OUT,voffset-4817-OUT;n:type:ShaderForge.SFN_Tex2d,id:8020,x:30153,y:32878,varname:node_8020,prsc:2,tex:23c6b6c2ac6483342bdb31b4b73e9d5d,ntxv:3,isnm:True|UVIN-7360-UVOUT,TEX-1309-TEX;n:type:ShaderForge.SFN_Transform,id:3345,x:31430,y:32202,varname:node_3345,prsc:2,tffrom:0,tfto:3|IN-255-OUT;n:type:ShaderForge.SFN_NormalBlend,id:5551,x:31249,y:32960,varname:node_5551,prsc:2|BSE-5919-OUT,DTL-3157-OUT;n:type:ShaderForge.SFN_NormalVector,id:5919,x:30944,y:32907,prsc:2,pt:False;n:type:ShaderForge.SFN_RemapRange,id:2433,x:31615,y:32202,varname:node_2433,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-3345-XYZ;n:type:ShaderForge.SFN_ComponentMask,id:4638,x:31803,y:32202,varname:node_4638,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2433-OUT;n:type:ShaderForge.SFN_Tex2d,id:6987,x:32299,y:32316,ptovrint:False,ptlb:MatCap,ptin:_MatCap,varname:node_6987,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-4638-OUT;n:type:ShaderForge.SFN_TexCoord,id:9159,x:29518,y:32672,varname:node_9159,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:7360,x:29830,y:32690,varname:node_7360,prsc:2,spu:0,spv:0.3|UVIN-9159-UVOUT;n:type:ShaderForge.SFN_Code,id:3157,x:30348,y:33083,varname:node_3157,prsc:2,code:YgB1AG0AcAAuAHgAeQAgACoAPQAgAC0AMQA7AA0ACgAKAHIAZQB0AHUAcgBuACAAYgB1AG0AcAAgADsA,output:2,fname:Function_node_3157,width:572,height:193,input:2,input_1_label:bump|A-8020-RGB;n:type:ShaderForge.SFN_Tex2dAsset,id:1309,x:29647,y:32937,ptovrint:False,ptlb:Normalmap,ptin:_Normalmap,varname:node_1309,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:23c6b6c2ac6483342bdb31b4b73e9d5d,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Color,id:794,x:31992,y:32435,ptovrint:False,ptlb:color01,ptin:_color01,varname:node_794,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:3324,x:31992,y:32625,ptovrint:False,ptlb:color02,ptin:_color02,varname:node_3324,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Lerp,id:2816,x:32225,y:32540,varname:node_2816,prsc:2|A-794-RGB,B-3324-RGB,T-2538-OUT;n:type:ShaderForge.SFN_TexCoord,id:1917,x:31763,y:32765,varname:node_1917,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_OneMinus,id:2538,x:31992,y:32810,varname:node_2538,prsc:2|IN-1917-V;n:type:ShaderForge.SFN_Set,id:622,x:31468,y:32996,varname:NormalBlend,prsc:2|IN-5551-OUT;n:type:ShaderForge.SFN_Get,id:255,x:31201,y:32202,varname:node_255,prsc:2|IN-622-OUT;n:type:ShaderForge.SFN_Lerp,id:9993,x:32948,y:32388,varname:node_9993,prsc:2|A-6987-RGB,B-2816-OUT,T-5501-OUT;n:type:ShaderForge.SFN_Slider,id:5501,x:32514,y:32570,ptovrint:False,ptlb:node_5501,ptin:_node_5501,varname:node_5501,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Fresnel,id:1428,x:32439,y:32898,varname:node_1428,prsc:2|NRM-5919-OUT,EXP-5477-OUT;n:type:ShaderForge.SFN_Color,id:6079,x:32649,y:32757,ptovrint:False,ptlb:gaoguang,ptin:_gaoguang,varname:node_6079,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.759434,c2:0.9953364,c3:1,c4:1;n:type:ShaderForge.SFN_Lerp,id:2858,x:32968,y:32837,varname:node_2858,prsc:2|A-9993-OUT,B-6079-RGB,T-1428-OUT;n:type:ShaderForge.SFN_Slider,id:5477,x:32077,y:33024,ptovrint:False,ptlb:node_5477,ptin:_node_5477,varname:node_5477,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:5;n:type:ShaderForge.SFN_Tex2d,id:2174,x:32252,y:31762,ptovrint:False,ptlb:lang,ptin:_lang,varname:node_2174,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bf91df5529134d34f9632153bf1e2a5f,ntxv:0,isnm:False|UVIN-2053-OUT;n:type:ShaderForge.SFN_Tex2d,id:9054,x:31788,y:31932,ptovrint:False,ptlb:wenli,ptin:_wenli,varname:node_9054,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b004e0a52eadafa46ab7b41501ec6aa7,ntxv:0,isnm:False|UVIN-8323-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:6025,x:31335,y:31838,varname:node_6025,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:7153,x:31774,y:31719,varname:node_7153,prsc:2,spu:0,spv:0.6|UVIN-6025-UVOUT;n:type:ShaderForge.SFN_Multiply,id:2458,x:32824,y:32083,varname:node_2458,prsc:2|A-8749-OUT,B-1478-RGB,C-2174-A;n:type:ShaderForge.SFN_Add,id:885,x:33261,y:32677,varname:node_885,prsc:2|A-7171-OUT,B-2858-OUT;n:type:ShaderForge.SFN_Color,id:1478,x:32366,y:32096,ptovrint:False,ptlb:node_1478,ptin:_node_1478,varname:node_1478,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Fresnel,id:1283,x:31633,y:32456,varname:node_1283,prsc:2|NRM-5919-OUT,EXP-2060-OUT;n:type:ShaderForge.SFN_Vector1,id:2060,x:31427,y:32578,varname:node_2060,prsc:2,v1:0.5;n:type:ShaderForge.SFN_OneMinus,id:9303,x:31840,y:32357,varname:node_9303,prsc:2|IN-1283-OUT;n:type:ShaderForge.SFN_Power,id:8749,x:32585,y:32187,varname:node_8749,prsc:2|VAL-9303-OUT,EXP-7941-OUT;n:type:ShaderForge.SFN_Vector1,id:7941,x:32402,y:32269,varname:node_7941,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:7171,x:33072,y:32171,varname:node_7171,prsc:2|A-2458-OUT,B-218-OUT;n:type:ShaderForge.SFN_Vector1,id:218,x:32812,y:32270,varname:node_218,prsc:2,v1:2;n:type:ShaderForge.SFN_Panner,id:8323,x:31607,y:31932,varname:node_8323,prsc:2,spu:0.1,spv:0.1|UVIN-6025-UVOUT;n:type:ShaderForge.SFN_Add,id:2053,x:32058,y:31826,varname:node_2053,prsc:2|A-7153-UVOUT,B-6995-OUT;n:type:ShaderForge.SFN_Multiply,id:6995,x:32018,y:31966,varname:node_6995,prsc:2|A-9054-R,B-3114-OUT;n:type:ShaderForge.SFN_Vector1,id:3114,x:31857,y:32096,varname:node_3114,prsc:2,v1:0.05;n:type:ShaderForge.SFN_Get,id:8328,x:31713,y:33323,varname:node_8328,prsc:2|IN-622-OUT;n:type:ShaderForge.SFN_Multiply,id:4817,x:32610,y:33275,varname:node_4817,prsc:2|A-8328-OUT,B-574-OUT;n:type:ShaderForge.SFN_Vector1,id:574,x:32361,y:33399,varname:node_574,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Distance,id:1579,x:32368,y:31538,varname:node_1579,prsc:2|A-6025-U,B-9781-OUT;n:type:ShaderForge.SFN_Vector1,id:9781,x:32163,y:31635,varname:node_9781,prsc:2,v1:0.5;n:type:ShaderForge.SFN_OneMinus,id:2677,x:32557,y:31619,varname:node_2677,prsc:2|IN-1579-OUT;n:type:ShaderForge.SFN_Multiply,id:7951,x:32939,y:31764,varname:node_7951,prsc:2|A-9345-OUT,B-2174-A;n:type:ShaderForge.SFN_Multiply,id:2253,x:33112,y:31927,varname:node_2253,prsc:2|A-7951-OUT,B-1478-RGB,C-218-OUT;n:type:ShaderForge.SFN_Lerp,id:866,x:33350,y:32060,varname:node_866,prsc:2|A-2253-OUT,B-7171-OUT,T-883-OUT;n:type:ShaderForge.SFN_Vector1,id:883,x:33221,y:32228,varname:node_883,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Power,id:9345,x:32766,y:31643,varname:node_9345,prsc:2|VAL-2677-OUT,EXP-6943-OUT;n:type:ShaderForge.SFN_Vector1,id:6943,x:32569,y:31906,varname:node_6943,prsc:2,v1:3;proporder:6987-1309-794-3324-5501-6079-5477-2174-9054-1478;pass:END;sub:END;*/

Shader "Tomcat/Effect/pubu04" {
    Properties {
        _MatCap ("MatCap", 2D) = "white" {}
        _Normalmap ("Normalmap", 2D) = "bump" {}
        _color01 ("color01", Color) = (0.5,0.5,0.5,1)
        _color02 ("color02", Color) = (0.5,0.5,0.5,1)
        _node_5501 ("node_5501", Range(0, 1)) = 0
        _gaoguang ("gaoguang", Color) = (0.759434,0.9953364,1,1)
        _node_5477 ("node_5477", Range(0, 5)) = 0
        _lang ("lang", 2D) = "white" {}
        _wenli ("wenli", 2D) = "white" {}
        _node_1478 ("node_1478", Color) = (0.5,0.5,0.5,1)
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
            uniform sampler2D _MatCap; uniform float4 _MatCap_ST;
            float3 Function_node_3157( float3 bump ){
            bump.xy *= -1;
            
            return bump ;
            }
            
            uniform sampler2D _Normalmap; uniform float4 _Normalmap_ST;
            uniform float4 _color01;
            uniform float4 _color02;
            uniform float _node_5501;
            uniform float4 _gaoguang;
            uniform float _node_5477;
            uniform sampler2D _lang; uniform float4 _lang_ST;
            uniform sampler2D _wenli; uniform float4 _wenli_ST;
            uniform float4 _node_1478;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_571 = _Time;
                float2 node_7360 = (o.uv0+node_571.g*float2(0,0.3));
                float3 node_8020 = UnpackNormal(tex2Dlod(_Normalmap,float4(TRANSFORM_TEX(node_7360, _Normalmap),0.0,0)));
                float3 node_5551_nrm_base = v.normal + float3(0,0,1);
                float3 node_5551_nrm_detail = Function_node_3157( node_8020.rgb ) * float3(-1,-1,1);
                float3 node_5551_nrm_combined = node_5551_nrm_base*dot(node_5551_nrm_base, node_5551_nrm_detail)/node_5551_nrm_base.z - node_5551_nrm_detail;
                float3 node_5551 = node_5551_nrm_combined;
                float3 NormalBlend = node_5551;
                v.vertex.xyz += (NormalBlend*0.2);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float4 node_571 = _Time;
                float2 node_8323 = (i.uv0+node_571.g*float2(0.1,0.1));
                float4 _wenli_var = tex2D(_wenli,TRANSFORM_TEX(node_8323, _wenli));
                float2 node_2053 = ((i.uv0+node_571.g*float2(0,0.6))+(_wenli_var.r*0.05));
                float4 _lang_var = tex2D(_lang,TRANSFORM_TEX(node_2053, _lang));
                float node_218 = 2.0;
                float3 node_7171 = ((pow((1.0 - pow(1.0-max(0,dot(i.normalDir, viewDirection)),0.5)),2.0)*_node_1478.rgb*_lang_var.a)*node_218);
                float2 node_7360 = (i.uv0+node_571.g*float2(0,0.3));
                float3 node_8020 = UnpackNormal(tex2D(_Normalmap,TRANSFORM_TEX(node_7360, _Normalmap)));
                float3 node_5551_nrm_base = i.normalDir + float3(0,0,1);
                float3 node_5551_nrm_detail = Function_node_3157( node_8020.rgb ) * float3(-1,-1,1);
                float3 node_5551_nrm_combined = node_5551_nrm_base*dot(node_5551_nrm_base, node_5551_nrm_detail)/node_5551_nrm_base.z - node_5551_nrm_detail;
                float3 node_5551 = node_5551_nrm_combined;
                float3 NormalBlend = node_5551;
                float2 node_4638 = (mul( UNITY_MATRIX_V, float4(NormalBlend,0) ).xyz.rgb*0.5+0.5).rg;
                float4 _MatCap_var = tex2D(_MatCap,TRANSFORM_TEX(node_4638, _MatCap));
                float3 finalColor = (node_7171+lerp(lerp(_MatCap_var.rgb,lerp(_color01.rgb,_color02.rgb,(1.0 - i.uv0.g)),_node_5501),_gaoguang.rgb,pow(1.0-max(0,dot(i.normalDir, viewDirection)),_node_5477)));
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
            Cull Back
            
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
            float3 Function_node_3157( float3 bump ){
            bump.xy *= -1;
            
            return bump ;
            }
            
            uniform sampler2D _Normalmap; uniform float4 _Normalmap_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_1053 = _Time;
                float2 node_7360 = (o.uv0+node_1053.g*float2(0,0.3));
                float3 node_8020 = UnpackNormal(tex2Dlod(_Normalmap,float4(TRANSFORM_TEX(node_7360, _Normalmap),0.0,0)));
                float3 node_5551_nrm_base = v.normal + float3(0,0,1);
                float3 node_5551_nrm_detail = Function_node_3157( node_8020.rgb ) * float3(-1,-1,1);
                float3 node_5551_nrm_combined = node_5551_nrm_base*dot(node_5551_nrm_base, node_5551_nrm_detail)/node_5551_nrm_base.z - node_5551_nrm_detail;
                float3 node_5551 = node_5551_nrm_combined;
                float3 NormalBlend = node_5551;
                v.vertex.xyz += (NormalBlend*0.2);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
