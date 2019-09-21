Shader "Tomcat/Scene/Mirror1" {
    Properties{
        _Color("Color", Color) = (1,1,1,0.37)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Cube("Cube",CUBE) = ""{}
        _Emission("Emission", Range(0,2)) = 1
    }
        SubShader{
            Tags {
                "RenderType" = "Opaque"
            }
            LOD 200

            CGPROGRAM
            #pragma surface surf Lambert fullforwardshadows exclude_path:deferred exclude_path:prepass
            #pragma target 3.0

            sampler2D _MainTex;
            float _ColorMult;
            float _Emission;

            struct Input {
                float2 uv_MainTex;
                float3 worldNormal;
                float3 viewDir;
                float3 worldRefl;
            };

            half _Glossiness;
            half _Metallic;
            fixed4 _Color;
            samplerCUBE _Cube;

            void surf(Input IN, inout SurfaceOutput o) {
                fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
                o.Albedo = c.rgb + texCUBE(_Cube, IN.worldRefl).rgb * _Emission;
            }

            ENDCG
        }

        Fallback "Legacy Shaders/Diffuse"
}