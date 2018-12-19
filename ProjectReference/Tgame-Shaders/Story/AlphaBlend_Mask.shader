// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// 剧情对话条幅
Shader "TSHD/AlphaBlend_Mask" 
{
    Properties 
    {
         [PerRendererData]_MainTex ("Base (RGBA)", 2D) = "white" {}
        _MaskTex ("Mask Tex (R)",2D) = "white"{}
        _DissolveFactor("Dissolve Factor",Range(0,1.5)) = 0.0
        _TinyColor("Main Color",Color) =  (1,1,1,1)

    }
    SubShader 
    {
        Tags { 
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			 }

		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha  //透不透明就看这一句
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
             
            uniform sampler2D _MainTex;
            uniform sampler2D _MaskTex;
            uniform fixed4 _MainTex_ST,_MaskTex_ST;
            uniform float _DissolveFactor;
            uniform float4 _TinyColor;
            
            struct v2f {
				fixed4 vertex : POSITION;
				fixed4 color : COLOR;
				fixed4 texcoord : TEXCOORD0;

			};


            v2f vert (appdata_base v)
			{
				v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f ,o);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord.xy = TRANSFORM_TEX(v.texcoord,_MainTex);
                fixed2 panUV = v.texcoord.xy +fixed2(_DissolveFactor-1,0);
                o.texcoord.zw = TRANSFORM_TEX(panUV,_MaskTex);
				return o;
			}            


            float4 frag(v2f i):COLOR
            {
                float noiseValue = tex2D(_MaskTex,i.texcoord.zw).r;            

                float4 texColor = tex2D(_MainTex,i.texcoord.xy) *_TinyColor;
                fixed tempA =noiseValue * texColor.a;

                return fixed4(texColor.rgb,tempA);
            }
            
            ENDCG
        }
    } 
    
    FallBack Off
}