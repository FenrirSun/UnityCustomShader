
Shader "TSHD/Character/Character_Dissove"
{
	Properties
	{
		_Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		_DissolveMap("DissolveMap", 2D) = "white" {}
		_EmissionColor("EmissionColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Lambert keepalpha addshadow nolightmap  nodynlightmap nodirlightmap nometa noforwardadd 
		struct Input
		{
			float2 uv_MainTex;
		};

		uniform sampler2D _MainTex;
		uniform float4 _EmissionColor;
		uniform sampler2D _DissolveMap;

		float _Cutoff;

		void surf( Input i , inout SurfaceOutput  o )
		{
			o.Albedo = tex2D( _MainTex, i.uv_MainTex ).rgb;
			o.Emission = ( o.Albedo  * _EmissionColor ).rgb;
			o.Alpha = 1;
			clip( tex2D( _DissolveMap, i.uv_MainTex ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Mobile/VertexLit"

}
