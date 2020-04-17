Shader "Tomcat/Scene/Cutout_Diffuse_Lightmap_Control"
{
    Properties{
        _Color ("Color Tint", Color) = (1, 1, 1, 1)
        _MainTex ("Main Tex", 2D) = "white" {}
        _MinAtten("Shadow Scale", Range(0, 1)) = 0
        _MinDiff("Diff Scale", Range(0, 1)) = 0
        _MinColor("Color Scale", Color) = (0, 0, 0, 0)
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5

        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
    }
    SubShader{
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
        LOD 200
        Cull [_Cull]
        //ZWrite On
        
        CGPROGRAM
        #pragma surface surf CustomLambert fullforwardshadows exclude_path:deferred exclude_path:prepass
        #pragma target 3.0

        fixed4 _Color;
        sampler2D _MainTex;
        float _Cutoff;
        half _MinAtten;
        half _MinDiff;
        float4 _MinColor;
        struct Input {
            float2 uv_MainTex;
        };

        struct SurfaceOutputCustom
        {
            half3 Albedo;
            half3 Normal;
            half3 Emission;
            half Metallic;
            half Smoothness;
            half Occlusion;
            half Alpha;
            Input SurfInput;
            UnityGIInput GIData;
        };

        void surf(Input IN, inout SurfaceOutputCustom o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = tex.rgb;
            o.Alpha = tex.a;

            clip(tex.a - _Cutoff);
        }

        // half4 LightingCustomLambertOri (SurfaceOutputCustom s, half3 lightDir, fixed3 halfDir, half atten) {
        //      half NdotL = dot(s.Normal, lightDir);
        //      half4 c;
        //      c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
        //      c.a = s.Alpha;
        //      return c;
        // }

        half4 LightingCustomLambert (inout SurfaceOutputCustom s, half3 viewDir, UnityGI gi) {
            fixed diff = max (0, dot (s.Normal, gi.light.dir));
            half4 c;

            UnityGIInput data = s.GIData;
            Input i = s.SurfInput;
            #ifdef UNITY_PASS_FORWARDBASE
                float ase_lightAtten = data.atten;
                if( _LightColor0.a == 0)
                ase_lightAtten = 0;
            #else
                float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
                float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
            #endif


            float remapAtten = (_MinAtten + (ase_lightAtten * (1 - _MinAtten)));
            float remapdiff = (_MinDiff + (diff * (1 - _MinDiff)));
            float3 newLight = (_MinColor.rgb + ( gi.light.color * (_LightColor0.rgb - _MinColor.rgb) ));
            c.rgb = s.Albedo * remapAtten * newLight * remapdiff;
            #ifdef UNITY_LIGHT_FUNCTION_APPLY_INDIRECT
            c.rgb += s.Albedo * gi.indirect.diffuse;
            #endif
            c.a = s.Alpha;
            return c;
        }

        void LightingCustomLambert_GI (
            SurfaceOutputCustom s,
            UnityGIInput data,
            inout UnityGI gi)
        {
            gi = UnityGlobalIllumination (data, 1.0, s.Normal);
            s.GIData = data;
        }

        ENDCG
    }
    FallBack "Transparent/Cutout/VertexLit"
}
