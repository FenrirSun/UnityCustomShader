Shader "Unlit/ExpandUVShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "grey" {}
		//进度，第一笔是0-1，第二笔1-2，第三笔2-3
		_TotalProgress ("Total Progress", Range (0, 4)) = 0
		_alpha ("alpha", Range (0, 1)) = 1
    }
    SubShader
    {
        //Tags { "RenderType"="Opaque" }
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Back
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
				float strokeNum : TEXCOORD1;
				float progress : TEXCOORD2;
				float2 uv1 : TEXCOORD4;
                UNITY_FOG_COORDS(3)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			half _TotalProgress;
			fixed _alpha;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv1 = v.uv1;
				o.progress = modf(_TotalProgress, o.strokeNum);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
				if(i.strokeNum < 0.5)
				{
					//第一笔
					//后面的几笔全都裁剪掉
					clip(0.25 - i.uv1.y);
					clip(i.progress - i.uv1.x);
				}
				else if(i.strokeNum < 1.5)
				{
					//第二笔
					//将第三笔裁剪掉
					clip(0.5 - i.uv1.y);
					if(i.uv1.y > 0.25)
						clip(i.progress - i.uv1.x);
				}
				else if(i.strokeNum < 2.5)
				{
					//第三笔
					clip(0.75 - i.uv1.y);
					if(i.uv1.y > 0.50)
						clip(i.progress - i.uv1.x);
				}
				else
				{
					//第四笔
					if(i.uv1.y > 0.75)
						clip(i.progress - i.uv1.x);
				}
				
                UNITY_APPLY_FOG(i.fogCoord, col);
				col.a = _alpha;
                return col;
            }
            ENDCG
        }
    }
	FallBack "Legacy Shaders/Transparent/Diffuse"
}
