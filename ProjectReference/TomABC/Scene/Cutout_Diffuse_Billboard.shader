Shader "Tomcat/Scene/Cutout_Diffuse_Billboard"
{
    Properties{
        _Color ("Color Tint", Color) = (1, 1, 1, 1)
        _MainTex ("Main Tex", 2D) = "white" {}
        _MinAtten("Shadow Scale", Range(0, 1)) = 0
        _MinDiff("Diff Scale", Range(0, 1)) = 0
        _MinColor("Color Scale", Color) = (0, 0, 0, 0)
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
        _VerticalBillboarding ("Vertical Restraints", Range(0, 1)) = 1 

        //[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
    }
    SubShader{
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" "DisableBatching" = "True" }
        LOD 200
        Cull Back
        //ZWrite On
        
        CGPROGRAM
        #pragma surface surf CustomLambert vertex:billboardVert fullforwardshadows exclude_path:deferred exclude_path:prepass //nolightmap
        #pragma target 3.0

        fixed4 _Color;
        sampler2D _MainTex;
        float _Cutoff;
        half _MinAtten;
        half _MinDiff;
        float4 _MinColor;
        fixed _VerticalBillboarding;

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

        void billboardVert (inout appdata_full v)
        {
            float3 center = float3(0, 0, 0);
            float3 viewer = mul(unity_WorldToObject,float4(_WorldSpaceCameraPos, 1));
            float3 normalDir = viewer - center;

            normalDir.y =normalDir.y * _VerticalBillboarding;
            normalDir = normalize(normalDir);
            float3 upDir = abs(normalDir.y) > 0.999 ? float3(0, 0, 1) : float3(0, 1, 0);
            float3 rightDir = normalize(cross(upDir, normalDir));
            upDir = normalize(cross(normalDir, rightDir));
            
            float3 centerOffs = v.vertex.xyz - center;
            float3 localPos = center + rightDir * centerOffs.x + upDir * centerOffs.y + normalDir * centerOffs.z;
          
            v.vertex.xyz = float4(localPos, 1);
        }

        void surf(Input IN, inout SurfaceOutputCustom o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = tex.rgb;
            o.Alpha = tex.a;

            clip(tex.a - _Cutoff);
        }

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
