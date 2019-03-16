Shader "Custom/GrassShader"
{
    Properties{
        _ColorTint("Color Tint", Color) = (1,1,1,1)
        _MainTex("Base (RGB)", 2D) = "white" {}
        _CullOff("Cull Off", float) = 0.5
    }
    SubShader{
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
        LOD 300
        //ZWrite On
        //Cull Off
        
        CGPROGRAM
        #pragma surface surf Lambert exclude_path:deferred exclude_path:prepass
        #pragma target 3.0

        fixed4 _ColorTint;
        sampler2D _MainTex;
        float _CullOff;

        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _ColorTint;
            o.Albedo = tex.rgb;
            o.Alpha = tex.a;

            clip(tex.a - _CullOff);
        }

        ENDCG
    }
    FallBack "Legacy Shaders/Transparent/Diffuse"
}
