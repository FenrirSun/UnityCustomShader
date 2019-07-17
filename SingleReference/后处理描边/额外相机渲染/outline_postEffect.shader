Shader "Custom/outline_postShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BlurSize("Blur Size",float) = 1
        _BlurTex("Blur Tex",2D) = ""{}
        _SrcTex("SrcTex", 2D) = "white"{}
        _OutlineColor("OutLine Color",Color) = (1,1,1,1)
    }
    CGINCLUDE
    #include "UnityCG.cginc"
    uniform half4 _MainTex_TexelSize;
    // 边缘分成了硬边和软边两种
    #pragma shader_feature _Hard_Side 
    float _BlurSize;    
    sampler2D _MainTex;
    sampler2D _BlurTex;
    sampler2D _SrcTex;
    float4 _OutlineColor;

    //高斯模糊权重
    static const half4 GaussWeight[7] =
    {
        half4(0.0205,0.0205,0.0205,0),
        half4(0.0855,0.0855,0.0855,0),
        half4(0.232,0.232,0.232,0),
        half4(0.324,0.324,0.324,1),
        half4(0.232,0.232,0.232,0),
        half4(0.0855,0.0855,0.0855,0),
        half4(0.0205,0.0205,0.0205,0)
    };

    struct v2f_Blur
    {
        float4 pos:SV_POSITION;
        half2 uv:TEXCOORD0;
        half2 offset:TEXCOORD1;
    };

    // 水平方向的高斯模糊
    v2f_Blur vert_blur_Horizonal(appdata_img v)
    {
        v2f_Blur o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv = v.texcoord;
        o.offset = _MainTex_TexelSize.xy * half2(1,0)*_BlurSize;
        return o;
    }

    // 垂直方向的高斯模糊
    v2f_Blur vert_blur_Vertical(appdata_img v)
    {
        v2f_Blur o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv = v.texcoord;

        o.offset = _MainTex_TexelSize.xy * half2(0,1)*_BlurSize;
        return o;
    }

    //全方向片段着色器
    half4 frag_blur(v2f_Blur i):COLOR
    {
        half2 uv_withOffset = i.uv - i.offset * 3;
        half4 color = 0;
        for (int j = 0; j < 7; ++j)
        {
            half4 texcol = tex2D(_MainTex,uv_withOffset);
            color += texcol * GaussWeight[j];
            uv_withOffset += i.offset;
        }
        return color;
    }

    //修正的垂直方向片段着色器，只取样下方
    half4 frag_blur_Vertical(v2f_Blur i):COLOR
    {
        half2 uv_withOffset = i.uv;// - i.offset * 3;
        half4 color = 0;
        for (int j = 0; j < 4; ++j)
        {
            half4 texcol = tex2D(_MainTex,uv_withOffset);
            float shouldDouble = j > 0;
            color += texcol * GaussWeight[j + 3] * (1 + shouldDouble);
            uv_withOffset += i.offset;
        }
        return color;
    }

    //add
    struct v2f_add
    {
        float4 pos : SV_POSITION;
        float2 uv  : TEXCOORD0;
        float2 uv1 : TEXCOORD1;
    };

    v2f_add vert_add(appdata_img v)
    {
        v2f_add o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv = v.texcoord;
        o.uv1 = o.uv;
#if UNITY_UV_STARTS_AT_TOP
        o.uv.y = 1- o.uv.y;
#endif  
        return o;
    }

    half4 frag_add(v2f_add i):COLOR
    {
        //获取屏幕
        fixed4 scene = tex2D(_MainTex, i.uv1);
        fixed4 blurCol = tex2D(_BlurTex,i.uv1);
        fixed4 srcCol = tex2D(_SrcTex,i.uv1);
        //return blurCol;
        #if _Hard_Side 
            // 如果是硬边描边，就用模糊纹理-原来的纹理得到边缘
            fixed4 outlineColor = saturate(blurCol - srcCol);
            // all(outlineColor.rgb) 三个分量都不等于0，返回1，否则返回0.类似&&运算
            // any(outlineColor.rgb);rgb 任意不为 0，则返回 true。类似||运算
            // 如果rgb都不为0(硬边部分）就显示硬边，否则都显示scene部分。
            return scene * (1 - all(outlineColor.rgb))  +  _OutlineColor * any(outlineColor.rgb);
        #else
            //测试，不带场景渲染图
            //return saturate(blurCol - srcCol) * _OutlineColor;

            //软描边，直接将模糊图像剪掉原图向，加上场景图
            //return saturate(blurCol - srcCol) * _OutlineColor + scene;

            //白色阴影描边
            // float blurAlpha = blurCol.r - srcCol.a;
            // if(blurAlpha < 0)
            // {
            //     //这里内部描是为了抗锯齿
            //     //这个-0.5是用来控制脸部的反向描边程度的，-1为完全描边，0为完全不描
            //     blurAlpha = blurAlpha * 0.3;
            // }
            // blurAlpha = blurAlpha * _OutlineColor.a;
            // return saturate(blurCol - srcCol) * _OutlineColor + scene * (1 - blurAlpha);

            //黑色阴影描边
            //这里让内部描是为了抗锯齿
            //float blurAlpha = abs(blurCol.r - srcCol.a);
            float blurAlpha = saturate(blurCol.r - srcCol.a);
            blurAlpha = blurAlpha * _OutlineColor.a;
            return saturate(blurCol - srcCol) * _OutlineColor * blurAlpha + scene * (1 - blurAlpha);
        #endif
    }

    ENDCG

    SubShader
    {
        ZTest Always
        ZWrite Off
        Fog{ Mode Off }

        //0
        Pass 
        {
            ZTest Always
            Cull Off
            CGPROGRAM
            #pragma vertex vert_blur_Horizonal
            #pragma fragment frag_blur
            ENDCG
        }
        //1
        Pass
        {
            ZTest Always
            Cull Off
            CGPROGRAM
            #pragma vertex vert_blur_Vertical
            #pragma fragment frag_blur_Vertical
            ENDCG
        }
        //2
        Pass
        {
            ZTest Off
            Cull Off

            CGPROGRAM
            #pragma vertex vert_add
            #pragma fragment frag_add
            ENDCG
        }
    }
}

