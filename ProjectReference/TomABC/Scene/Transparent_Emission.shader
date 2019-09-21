Shader "Tomcat/Scene/Transparent_Emission" {
	Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    //_BumpMap ("Normalmap", 2D) = "bump" {}
    //_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    //_EmissionColor ("Emission Color", Color) = (1,1,1,1)
    _EmissionScale("Emission Scale", Range(0, 3)) = 1
}

SubShader {
    Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
    LOD 300
	//ZWrite On
	//Cull Off

	CGPROGRAM
	#pragma surface surf Lambert exclude_path:deferred exclude_path:prepass alpha:fade

	sampler2D _MainTex;
	//sampler2D _BumpMap;
	fixed4 _Color;
	//fixed4 _EmissionColor;
	fixed _EmissionScale;

	struct Input {
	    float2 uv_MainTex;
	};

	void surf (Input IN, inout SurfaceOutput o) {
	    fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	    o.Albedo = c.rgb * _Color.rgb;
	    o.Alpha = c.a;
	    //o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	    o.Emission = c.rgb * _EmissionScale;
	    //o.Emission = _EmissionColor * _EmissionScale;
	}
	ENDCG
	}

	FallBack "Legacy Shaders/Transparent/Bumped Diffuse"
}