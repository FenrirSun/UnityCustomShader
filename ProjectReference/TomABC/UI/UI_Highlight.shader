Shader "Tomcat/UI/UI_Highlight"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
        //是否隐藏原图
        [Toggle(_ShowRawImage)] _ShowRawImage ("是否显示原图", Int) = 1  
        //描边
        [Toggle(_ShowOutline)] _ShowOutline ("是否显示描边", Int) = 1       
        _EdgeColor("描边颜色", Color) = (0,0,0,1)
        _EdgeRange("描边宽度", Range(0, 5)) = 3
        [PowerSlider(2.0)]_EdgeDampRate("描边强度(动态调节)", range(0, 2)) = 0
        _OriginAlphaThreshold("描边覆盖率", range(0.1, 0.99)) = 0.5

        //内发光
        // [Toggle(_ShowInnerGlow)] _ShowInnerGlow ("是否开启内发光", Int) = 1
        // _InnerGlowColor("内发光颜色", Color) = (0,0,0,1)
        // _InnerGlowLerpRate("内发光亮度(动态调节)", range(0, 0.1)) = 0

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask [_ColorMask]

        Pass
        {
            Name "Default"
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP

            #pragma multi_compile __ _ShowRawImage
            #pragma multi_compile __ _ShowOutline
            //#pragma multi_compile __ _ShowInnerGlow
            #define _EdgeAlphaThreshold 0.0

            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                float2 uv[9] : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;
            float4 _MainTex_ST;

            fixed _EdgeRange;
            half4 _MainTex_TexelSize;
            fixed4 _EdgeColor;
            float _EdgeDampRate;
            float _OriginAlphaThreshold;
            // fixed4 _InnerGlowColor;
            // float _InnerGlowLerpRate;

            half CalculateAlphaSumAround(v2f i)
            {
                half texAlpha;
                half alphaSum = 0;
                for(int it = 0; it < 9; it ++)
                {
                    texAlpha = tex2D(_MainTex, i.uv[it]).w;
                    alphaSum += texAlpha;
                }
 
                return alphaSum;
            }

            v2f vert(appdata_t v)
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
                OUT.worldPosition = v.vertex;
                OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);
                OUT.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                OUT.color = v.color * _Color;

                //用周围像素是否有颜色来判断边缘
                half2 uv = v.texcoord;
                OUT.uv[0] = uv + _MainTex_TexelSize.xy * half2(-1, -1) * _EdgeRange;
                OUT.uv[1] = uv + _MainTex_TexelSize.xy * half2(0, -1) * _EdgeRange;
                OUT.uv[2] = uv + _MainTex_TexelSize.xy * half2(1, -1) * _EdgeRange;
                OUT.uv[3] = uv + _MainTex_TexelSize.xy * half2(-1, 0) * _EdgeRange;
                OUT.uv[4] = uv + _MainTex_TexelSize.xy * half2(0, 0) * _EdgeRange;
                OUT.uv[5] = uv + _MainTex_TexelSize.xy * half2(1, 0) * _EdgeRange;
                OUT.uv[6] = uv + _MainTex_TexelSize.xy * half2(-1, 1) * _EdgeRange;
                OUT.uv[7] = uv + _MainTex_TexelSize.xy * half2(0, 1) * _EdgeRange;
                OUT.uv[8] = uv + _MainTex_TexelSize.xy * half2(1, 1) * _EdgeRange;

                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                half4 orignColor = (tex2D(_MainTex, IN.texcoord) + _TextureSampleAdd) * IN.color;

                //clip(IN.texcoord.x - 0.1);
                // clip(IN.texcoord.y - 0.01);
                //clip(0.5 - IN.texcoord.x);
                //clip(0.9 - IN.texcoord.y);

                #ifdef UNITY_UI_CLIP_RECT
                orignColor.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (orignColor.a - 0.001);
                #endif

                //如果不显示原图，那么直接丢弃原像素
                #if !defined(_ShowRawImage) 
                    clip (0.9-orignColor.a);
                #endif

                fixed4 innerGlow = fixed4(0,0,0,0);
                fixed4 outline = fixed4(0,0,0,0);

                //2D图片外轮廓
                #if defined(_ShowOutline)
                    half alphaSum = CalculateAlphaSumAround(IN);
                    float isNeedShow = alphaSum > _EdgeAlphaThreshold;
                    float damp = saturate((alphaSum - _EdgeAlphaThreshold) * _EdgeDampRate);
                    float isOrigon = orignColor.a > _OriginAlphaThreshold;
                    fixed3 finalColor = lerp(_EdgeColor.rgb, fixed3(0,0,0), isOrigon);

                    float finalAlpha = isNeedShow * damp * (1 - isOrigon);
                    outline = fixed4(finalColor.rgb, finalAlpha);
                #endif

                //2D图片的内发光
                // #if defined(_ShowInnerGlow) && defined(_ShowRawImage) 
                //     //计算透明度
                //     float innerColorAlpha = saturate(tex2D(_MainTex, IN.uv[4]).a);
                //     fixed3 innerColor = _InnerGlowColor.rgb * innerColorAlpha;
                //     innerGlow = fixed4(innerColor.rgb, innerColorAlpha);
                // #endif
 
                //将外轮廓和内发光元颜色叠加输出。
                #if defined(_ShowOutline)
                    float outlineAlphaDiscard = orignColor.a > _OriginAlphaThreshold;
                    orignColor = outlineAlphaDiscard * orignColor;
                    return orignColor + outline;
                #endif
 
                return orignColor;
            }
        ENDCG
        }
    }
}
