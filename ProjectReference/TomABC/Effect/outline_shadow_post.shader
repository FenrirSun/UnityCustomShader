Shader "Tomcat/Effect/outline_shadow_post"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BlurSize("Blur Size",float) = 1
        _BlurTex("Blur Tex",2D) = ""{}
        _SrcTex("SrcTex", 2D) = "white"{}
        _OutlineColor("OutLine Color",Color) = (0,0,0,1)
    }
    CGINCLUDE
    #include "UnityCG.cginc"
    uniform half4 _MainTex_TexelSize;
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

    //修正的垂直方向片段着色器，只取样上方
    half4 frag_blur_Vertical(v2f_Blur i):COLOR
    {
        half2 uv_withOffset = i.uv;
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

    /////////////////////////////////////////////////////////
    ///为了减少DC调用，这里做了一次优化，一次调用计算两个方向的模糊

    struct v2f_Blur_2
    {
        float4 pos:SV_POSITION;
        half2 uv:TEXCOORD0;
        // 优化带宽占用，将两个偏移放在一起
        // xy 为竖直方向偏移，zw为水平方向偏移
        half4 offset:TEXCOORD1;
        // half2 offset_vert:TEXCOORD1;
        // half2 offset_hori:TEXCOORD2;
    };

    v2f_Blur_2 vert_blur_2(appdata_img v)
    {
        v2f_Blur_2 o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv = v.texcoord;
        o.offset.xy = _MainTex_TexelSize.xy * half2(0,1)*_BlurSize;
        o.offset.zw = _MainTex_TexelSize.xy * half2(1,0)*_BlurSize;
        return o;
    }

    fixed4 frag_blur_2(v2f_Blur_2 i):COLOR
    {
        //垂直方向上的模糊
        half2 uv_withOffset = i.uv;
        fixed4 color_vert = 0;
        for (int j = 0; j < 4; ++j)
        {
            half4 texcol = tex2D(_MainTex,uv_withOffset);
            float shouldDouble = j > 0;
            color_vert += texcol * GaussWeight[j + 3] * (1 + shouldDouble);
            uv_withOffset += i.offset.xy;
        }

        //水平方向上的模糊
        uv_withOffset = i.uv - i.offset.zw * 3;
        fixed4 color_hori = 0;
        for (int k = 0; k < 7; ++k)
        {
            half4 texcol = tex2D(_MainTex,uv_withOffset);
            color_hori += texcol * GaussWeight[k];
            uv_withOffset += i.offset.zw;
        }
        fixed4 result = (color_vert + color_hori) / 2;
        result.a = result.r;
        return result;
    }

    /////////////////////////////////////////////////////////

    //add
    struct v2f_add
    {
        float4 pos : SV_POSITION;
        half2 uv  : TEXCOORD0;
        half2 uv1 : TEXCOORD1;
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

    fixed4 frag_add(v2f_add i):COLOR
    {
        //获取屏幕
        fixed4 scene = tex2D(_MainTex, i.uv1);
        fixed4 blurCol = tex2D(_BlurTex,i.uv1);
        fixed4 srcCol = tex2D(_SrcTex,i.uv1);
       
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
        fixed blurAlpha = saturate(blurCol.r - srcCol.b);
        blurAlpha = blurAlpha * _OutlineColor.a;
        fixed4 result = saturate(blurCol - srcCol) * _OutlineColor * blurAlpha + scene * (1 - blurAlpha);
        //这里是为了模型避免边缘的透光点
        if(srcCol.r && result.a < 0.5)
        {
            return blurCol * _OutlineColor;
        }
        //这是设置a是为了让渲染到RT之后可以看到
        result.a = saturate(blurAlpha + result.a);
        return result;
    }

    ENDCG

    SubShader
    {
        ZTest Always
        ZWrite Off
        Fog{ Mode Off }

        //0
        //水平方向模糊
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
        //竖直方向模糊，但是忽略上方
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
        //3
        //水平竖直一次模糊
        Pass
        {
            ZTest Always
            Cull Off
            CGPROGRAM
            #pragma vertex vert_blur_2
            #pragma fragment frag_blur_2
            ENDCG
        }
    }
}

