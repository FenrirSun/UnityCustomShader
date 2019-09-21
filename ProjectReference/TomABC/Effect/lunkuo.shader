// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33587,y:32714,varname:node_9361,prsc:2|emission-936-OUT,alpha-9985-OUT;n:type:ShaderForge.SFN_Color,id:5927,x:32473,y:32541,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_5927,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:2460,x:32927,y:32598,cmnt:Ambient Light,varname:node_2460,prsc:2|A-5927-RGB,B-5446-OUT;n:type:ShaderForge.SFN_Fresnel,id:9985,x:32350,y:32854,varname:node_9985,prsc:2|NRM-6970-OUT,EXP-6163-OUT;n:type:ShaderForge.SFN_Slider,id:6163,x:31758,y:32936,ptovrint:False,ptlb:inside,ptin:_inside,varname:node_6163,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.3134484,max:1;n:type:ShaderForge.SFN_Power,id:5446,x:32772,y:32789,varname:node_5446,prsc:2|VAL-9985-OUT,EXP-9671-OUT;n:type:ShaderForge.SFN_Vector1,id:9671,x:32523,y:32942,varname:node_9671,prsc:2,v1:5;n:type:ShaderForge.SFN_NormalVector,id:6970,x:32046,y:32733,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:6197,x:33111,y:32779,varname:node_6197,prsc:2|A-2460-OUT,B-6728-OUT;n:type:ShaderForge.SFN_Slider,id:6728,x:32271,y:33076,ptovrint:False,ptlb:huxi,ptin:_huxi,varname:node_6728,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Time,id:222,x:32389,y:33262,varname:node_222,prsc:2;n:type:ShaderForge.SFN_Sin,id:4701,x:32758,y:33250,varname:node_4701,prsc:2|IN-4369-OUT;n:type:ShaderForge.SFN_RemapRange,id:9802,x:32937,y:33227,varname:node_9802,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-4701-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:2603,x:33185,y:33128,ptovrint:False,ptlb:shanshuo,ptin:_shanshuo,varname:node_2603,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-2987-OUT,B-9802-OUT;n:type:ShaderForge.SFN_Vector1,id:2987,x:32969,y:33104,varname:node_2987,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:4369,x:32584,y:33250,varname:node_4369,prsc:2|A-222-T,B-2800-OUT;n:type:ShaderForge.SFN_Multiply,id:936,x:33343,y:32839,varname:node_936,prsc:2|A-6197-OUT,B-2603-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2800,x:32409,y:33468,ptovrint:False,ptlb:sudu,ptin:_sudu,varname:node_2800,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;proporder:5927-6163-6728-2603-2800;pass:END;sub:END;*/

Shader "Tomcat/Effect/lunkuo" {
    Properties {
        [HDR]_Color ("Color", Color) = (1,1,1,1)
        _inside ("inside", Range(0, 1)) = 0.3134484
        _huxi ("huxi", Range(0, 1)) = 0
        [MaterialToggle] _shanshuo ("shanshuo", Float ) = 1
        _sudu ("sudu", Float ) = 1
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
            Blend SrcAlpha One
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
            uniform float4 _Color;
            uniform float _inside;
            uniform float _huxi;
            uniform fixed _shanshuo;
            uniform float _sudu;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float node_9985 = pow(1.0-max(0,dot(i.normalDir, viewDirection)),_inside);
                float4 node_222 = _Time;
                float3 emissive = (((_Color.rgb*pow(node_9985,5.0))*_huxi)*lerp( 1.0, (sin((node_222.g*_sudu))*0.5+0.5), _shanshuo ));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,node_9985);
				//finalRGBA.a = max(max(finalColor.r, finalColor.g), finalColor.b);
				//finalRGBA.a /= 2;
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
