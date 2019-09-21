Shader "Tomcat/Scene/BumpedDiffuse_Emission"
{
    Properties{
        _Color("Color Tint", Color) = (1,1,1,1)
        _MainTex("Base (RGB)", 2D) = "white" {}
        _BumpMap("Normalmap", 2D) = "bump" {}
        _BumpFactor("Normal Factor", Range(-25,25)) = 1 
        _EmissionMask("EmissionMask (R)", 2D) = "white" {}
        _EmissionColor("Emission Color", Color) = (1,1,1,1)
        _EmissionScale("Emission Scale", Range(0, 5)) = 1
        _EmissionCompensate("Emission Compensate", Range(0, 1)) = 1
    }
    SubShader{
        Tags { "RenderType" = "Opaque"}
        LOD 200

        CGPROGRAM
        #pragma surface surf HalfLambert addshadow exclude_path:deferred exclude_path:prepass
        #pragma target 3.0

        fixed4 _Color;
        fixed _BumpFactor;
        sampler2D _MainTex;
        sampler2D _BumpMap;
        fixed4 _EmissionColor;
        sampler2D _EmissionMask;
        fixed _EmissionScale;
        fixed _EmissionCompensate;

        struct Input {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            fixed4 emissionColor = tex2D(_EmissionMask, IN.uv_MainTex);
            //fixed emissionAlpha = all(emissionColor.rgb) * saturate(emissionColor.r + _EmissionCompensate);
            o.Albedo = tex.rgb;
            //用mask的R通道当作自发光比例
            o.Alpha = emissionColor.r;
            //o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex)) * _BumpFactor;

            fixed3 bump = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            bump.xy *= _BumpFactor;
            bump.z = sqrt(1.0 - saturate(dot(bump.xy, bump.xy)));
            o.Normal = bump;
            o.Emission = emissionColor.r * _EmissionColor * tex.rgb * _EmissionScale;
        }

        inline fixed4 LightingHalfLambert(SurfaceOutput s, UnityGI gi)
        {
            fixed diff = max(0, dot(s.Normal, gi.light.dir));
            diff = (diff + 0.5) * 0.5;

            fixed4 c;
            c.rgb = s.Albedo * gi.light.color * diff;
            #ifdef UNITY_LIGHT_FUNCTION_APPLY_INDIRECT
                c.rgb += s.Albedo * gi.indirect.diffuse;
            #endif
            //fixed hideAlbedo = s.Alpha < 0.1;
            //c.rgb *= hideAlbedo;
            c.rgb *= 1 - s.Alpha;
            c.a = s.Alpha;
            return c;
        }

        inline void LightingHalfLambert_GI (
            SurfaceOutput s,
            UnityGIInput data,
            inout UnityGI gi)
        {
            gi = UnityGlobalIllumination (data, 1.0, s.Normal);
        }

        ENDCG
    }
    FallBack "Legacy Shaders/Diffuse"
}
