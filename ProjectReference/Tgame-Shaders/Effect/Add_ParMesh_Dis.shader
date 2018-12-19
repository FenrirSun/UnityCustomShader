// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TGame/Particle/Add_ParMesh_Dis" {
    Properties {
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _DisTex ("DisMap(R)", 2D) = "white" {}
        _DisVal("Dissolve Factor",range(0,1)) =1.0

    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
    
            uniform fixed4 _Color;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _DisTex; uniform float4 _DisTex_ST;
            uniform fixed _DisVal;

            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                half disVal :TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.uv0 = TRANSFORM_TEX(v.texcoord0,_MainTex);
                o.vertexColor = v.vertexColor * _Color;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.disVal =1.0 - v.vertexColor.a*0.95*_DisVal;
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {

                float4 diff = tex2D(_MainTex,i.uv0);
                half4 DisCol = tex2D(_DisTex,i.uv0);

                float3 finalColor = i.vertexColor.rgb*step(i.disVal,DisCol.r);  
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"

}

