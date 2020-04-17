Shader "Tomcat/Scene/Grass"
{
    Properties{
        _Color ("Color Tint", Color) = (1, 1, 1, 1)
        _MainTex ("Front Tex", 2D) = "white" {}
        _SwingRange ("Swing Range", Range(0, 0.2)) = 0
        _SwingSpeed ("Swing Speed", Range(0, 20)) = 1
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
        _GradientColor("Gradient Color", Range(0, 100)) = 0
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
    }
    SubShader{
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
        LOD 200
        Cull [_Cull]
        ZWrite On
        
        CGPROGRAM
        #pragma surface surf Lambert vertex:grassVert addshadow fullforwardshadows exclude_path:deferred exclude_path:prepass
        #pragma target 3.0

        fixed4 _Color;
        sampler2D _MainTex;
        float _Cutoff;
        half _SwingRange;
        half _SwingSpeed;
        half _GradientColor;

        struct Input {
            float2 uv_MainTex;
            float distance;
        };

        void grassVert (inout appdata_full v, out Input o) {
            float4 offset = float4(0,0,0,0);
            offset.x = sin(_SwingSpeed * _Time.y * clamp(v.texcoord.y-0.5, 0, 1))  * _SwingRange;
            v.vertex.x = v.vertex.x + offset.x;

            UNITY_INITIALIZE_OUTPUT(Input, o);
            float3 viewPos = UnityObjectToViewPos(v.vertex);
            //这里用距离的平方代替距离
            o.distance = dot(viewPos,viewPos);
        }

        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            clip(tex.a - _Cutoff);

            //o.Albedo = tex.rgb;
            o.Alpha = tex.a;

            // Apply saturation
            //IN.distance = IN.distance / _GradientColor;
            IN.distance= (( (IN.distance - 0) * _GradientColor ) / (100 - 0));
            fixed luminance = 0.2125 * tex.r + 0.7154 * tex.g + 0.0721 *  tex.b;
            fixed3 luminanceColor = fixed3(luminance, luminance, luminance);
            fixed3 finalColor = lerp(luminanceColor, tex.rgb, max(0.5, saturate(IN.distance)));
            o.Albedo = float4(finalColor,1);
        }

        ENDCG
    }
    //FallBack "Legacy Shaders/Transparent/Cutout/Diffuse"
}
