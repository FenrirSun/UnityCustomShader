Shader "TSHD/Scene/AlphaTest_Diffuse_Amb" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
	[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}

SubShader {
	Tags {"Queue"="AlphaTest" "RenderType"="TransparentCutout"}
	Cull [_Cull]
	LOD 200
	
CGPROGRAM
#pragma surface surf Lambert alphatest:_Cutoff noforwardadd 

sampler2D _MainTex;
fixed4 _Color;
half _AmbScale;

struct Input {
	float2 uv_MainTex;
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
	o.Albedo = lerp(c.rgb,c.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	o.Alpha = c.a;
}
ENDCG
}

Fallback "Legacy Shaders/Transparent/Cutout/VertexLit"
}
