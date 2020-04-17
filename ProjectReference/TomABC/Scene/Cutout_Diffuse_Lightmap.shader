Shader "Tomcat/Scene/Cutout_Diffuse_Lightmap"
{
    Properties{
        _Color ("Color Tint", Color) = (1, 1, 1, 1)
        _MainTex ("Main Tex", 2D) = "white" {}
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5

        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
    }
    SubShader{
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
        LOD 200
        Cull [_Cull]
        //ZWrite On
        
        CGPROGRAM
        #pragma surface surf Lambert fullforwardshadows exclude_path:deferred exclude_path:prepass
        #pragma target 3.0

        fixed4 _Color;
        sampler2D _MainTex;
        float _Cutoff;

        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = tex.rgb;
            o.Alpha = tex.a;

            clip(tex.a - _Cutoff);
        }

        ENDCG
    }
    FallBack "Transparent/Cutout/VertexLit"
}
