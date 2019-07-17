
Shader "Tomcat/Effect/outline_preEffect"
{
    Properties
    {
        _OutlineColor("_OutlineColor", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Pass
        {
            Tags{ "LightMode" = "ForwardBase" }
            Cull Back

            //CG程序开始
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            float4 _OutlineColor;
            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //相机设置成黑色，这里为外描边
                _OutlineColor = float4 (1,1,1,1);
                //相机底色设置为白色，这里为内描边
                //_OutlineColor = float4 (0,0,0,1);
                return _OutlineColor;
            }
            ENDCG
        }
    }
}