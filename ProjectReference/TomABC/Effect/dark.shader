// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33396,y:32694,varname:node_9361,prsc:2|alpha-9082-OUT;n:type:ShaderForge.SFN_Slider,id:3752,x:32513,y:32761,ptovrint:False,ptlb:dark,ptin:_dark,varname:node_3752,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Time,id:9755,x:32161,y:32897,varname:node_9755,prsc:2;n:type:ShaderForge.SFN_Sin,id:9304,x:32481,y:32927,varname:node_9304,prsc:2|IN-9064-OUT;n:type:ShaderForge.SFN_Multiply,id:9064,x:32328,y:33036,varname:node_9064,prsc:2|A-9755-T,B-6505-OUT;n:type:ShaderForge.SFN_ValueProperty,id:6505,x:32142,y:33141,ptovrint:False,ptlb:shanshuosudu,ptin:_shanshuosudu,varname:node_6505,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:6302,x:32917,y:32939,varname:node_6302,prsc:2|IN-9304-OUT,IMIN-4059-OUT,IMAX-123-OUT,OMIN-9190-OUT,OMAX-3752-OUT;n:type:ShaderForge.SFN_Vector1,id:4059,x:32646,y:32866,varname:node_4059,prsc:2,v1:-1;n:type:ShaderForge.SFN_Vector1,id:123,x:32656,y:32950,varname:node_123,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:9523,x:32544,y:33150,varname:node_9523,prsc:2,v1:0.5;n:type:ShaderForge.SFN_SwitchProperty,id:9082,x:33079,y:32939,ptovrint:False,ptlb:shanshuo,ptin:_shanshuo,varname:node_9082,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-3752-OUT,B-6302-OUT;n:type:ShaderForge.SFN_Multiply,id:9190,x:32715,y:33040,varname:node_9190,prsc:2|A-3752-OUT,B-9523-OUT;proporder:3752-9082-6505;pass:END;sub:END;*/

Shader "Tomcat/Effect/dark" {
    Properties {
        _dark ("dark", Range(0, 1)) = 0.5
        [MaterialToggle] _shanshuo ("shanshuo", Float ) = 0.375
        _shanshuosudu ("shanshuosudu", Float ) = 1
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
            uniform float _dark;
            uniform float _shanshuosudu;
            uniform fixed _shanshuo;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_FOG_COORDS(0)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
                float3 finalColor = 0;
                float4 node_9755 = _Time;
                float node_4059 = (-1.0);
                float node_9190 = (_dark*0.5);
                fixed4 finalRGBA = fixed4(finalColor,lerp( _dark, (node_9190 + ( (sin((node_9755.g*_shanshuosudu)) - node_4059) * (_dark - node_9190) ) / (1.0 - node_4059)), _shanshuo ));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
