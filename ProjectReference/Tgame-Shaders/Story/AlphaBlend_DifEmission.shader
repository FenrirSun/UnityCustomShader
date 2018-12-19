//用于剧情动画3d对话的模型渐变效果
Shader "Tgame/AlphaBlend_DifEmission" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_EmissionColor ("Emission Color", Color) = (0,0,0,0)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}

SubShader {

	Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}

	//Pass{
	//	ZWrite On
    //    ColorMask 0 
	//} 


	//ZTest On
	LOD 200

	CGPROGRAM
	#pragma surface surf Lambert alpha:blend
	
		sampler2D _MainTex;
		fixed4 _Color;
		fixed4 _EmissionColor;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _Color.rgb;
			o.Alpha = _Color.a;
			o.Emission = c.rgb * _EmissionColor.rgb;
	
		}
	
	ENDCG
	
}

Fallback "Legacy Shaders/Transparent/VertexLit"
}
