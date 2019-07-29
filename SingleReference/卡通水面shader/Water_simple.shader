Shader "Tomcat/Scene/Water_simple"
{
    Properties
    {
        _MainTex("Base(RGB)", 2D) = "white" {}
        _NoiseTex ("Wave Noise", 2D) = "white" {}//噪波贴图
        _EdgeTex("Edge Texture(RGB)", 2D) = "white" {}
        _Edge_Range ("Edge Range", Range(0, 1)) = 1

        _Color ("Tint", Color) = (1,1,1,1)
        _Indentity ("Indentity", float) = 0.1//表示水波的扭曲强度

        _SpeedX ("WaveSpeedX", float) = 0.08//噪波贴图延X方向的移动速度
        _SpeedY ("WaveSpeedY", float) = 0.04//噪波贴图延Y方向的移动速度

        _AlphaFadeIn ("AlphaFadeIn", float) = 0.0//水波的淡入位置
        _AlphaFadeOut ("AlphaFadeOut", float) = 1.0//水波的淡出位置
        _TwistFadeIn ("TwistFadeIn", float) = 1.0//扭曲的淡入位置
        _TwistFadeOut ("TwistFadeOut", float) = 1.01//扭曲的淡出位置
        _TwistFadeInIndentity ("TwistFadeInIndentity", float) = 1.0//扭曲的淡入强度
        _TwistFadeOutIndentity ("TwistFadeOutIndentity", float) = 1.0//扭曲的淡出强度
    }

    SubShader
    {
        tags{"Queue" = "Transparent" "RenderType" = "Transparent" "IgnoreProjector" = "True"}
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fog

            sampler2D _MainTex;
            sampler2D _NoiseTex;
            float4 _NoiseTex_ST;
            sampler2D _EdgeTex;
            float4 _EdgeTex_ST;

            uniform sampler2D _CameraDepthTexture;
            float _Edge_Range;
            fixed4 _Color;
            half _Indentity;
            half _SpeedX;
            half _SpeedY;

            float _AlphaFadeIn;
            float _AlphaFadeOut;
            half _TwistFadeIn;
            half _TwistFadeOut;
            fixed _TwistFadeInIndentity;
            fixed _TwistFadeOutIndentity;

            struct appdata{
                float4 vertex : POSITION;
                float4 texcoord : TEXCOORD;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 pos:POSITION;
                float2 uv:TEXCOORD0;
                float4 projPos : TEXCOORD1;
                UNITY_FOG_COORDS(2)
                float4 color:COLOR;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                //o.uv = v.texcoord;
                o.uv = v.texcoord.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
                o.color = v.color;
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }

            half4 frag(v2f i):COLOR
            {
                //对淡入强度和淡出强度的插值  
                fixed fadeT = saturate((_TwistFadeOut - i.uv.y) / (_TwistFadeOut - _TwistFadeIn));
                float2 tuv = (i.uv - float2(0.5, 0)) * fixed2(lerp(_TwistFadeOutIndentity, _TwistFadeInIndentity, fadeT), 1) + float2(0.5, 0);

                //计算噪波贴图的RG值，得到扭曲UV，
                float2 waveOffset = (tex2D(_NoiseTex, i.uv.xy + float2(0, _Time.y * _SpeedY)).rg + tex2D(_NoiseTex, i.uv.xy + float2(_Time.y * _SpeedX, 0)).rg) - 1;
                float2 ruv = float2(i.uv.x, 1 - i.uv.y) + waveOffset * _Indentity;

                //使用扭曲UV对纹理采样
                float4 c = tex2D (_MainTex, ruv);

                //边缘检测，混合波浪和水面
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float EdgeAlpha = saturate((sceneZ-partZ)/_Edge_Range);

                //对淡入Alpha和淡出Alpha的插值
                fixed fadeA = saturate((_AlphaFadeOut - ruv.y) / (_AlphaFadeOut - _AlphaFadeIn));
                c = c * _Color * i.color * fadeA;
                clip (c.a - 0.01);
                UNITY_APPLY_FOG(i.fogCoord, c);

                //边缘渐透
                //c.a = c.a * EdgeAlpha;

                //边缘贴图混合
                ruv.y = EdgeAlpha;
                float4 EdgeColor = tex2D(_EdgeTex, ruv);
                c = EdgeColor * (1 - EdgeAlpha) + c * EdgeAlpha;

                return c;
            }

            ENDCG
        }
    }
}