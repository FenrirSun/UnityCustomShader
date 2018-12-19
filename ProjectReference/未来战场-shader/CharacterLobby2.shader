Shader "VX/Character/CharacterLobby2" {
	Properties {
	 _MainColor ("Main Color", Color) = (0.725,0.725,0.725,1)
	 _MainTex ("MainTex (RGB)", 2D) = "white" {}
	 _NormalTex ("Normal Map", 2D) = "bump" {}
	 _Cubemap ("Cube", CUBE) =  "_Skybox"  {}
	 _MaskMap ("R(Rim) G(Specular) B(CubeMap)", 2D) = "white" {}
	 _RimPower ("Rim Power", Range(0.1,8)) = 1
	 _RimColor ("Rim Color", Color) = (0,0,0,0)
	 _SpecShininess ("Specular Shininess", Range(0.1,64)) = 2
	 _SpecColor2 ("Specular Color", Color) = (1,1,1,1)
	 _SpecIntensity ("Specular Intensity", Range(0,8)) = 1
	 _SecondDiffLitDir ("Second Diffuse Light Direction", Vector) = (0,0,0,0)
	 _SecondDiffLitCol ("Second Diffuse Light Color", Color) = (0,0,0,0)
	}
SubShader { 
	 LOD 400

     Tags { "Queue" = "Geometry"  "RenderType"="Opaque"  "PerformanceChecks"="False" }
     CGPROGRAM 
	 #pragma surface surf TermBlinnPhong  noforwardadd   nolightmap exclude_path:prepass exclude_path:deferred
	 #pragma target 3.0
	 sampler2D   _MainTex;
	 sampler2D   _NormalTex;
	 samplerCUBE _Cubemap;
	 sampler2D   _MaskMap;
	 half   _RimPower;
	 fixed4 _RimColor;
	 half   _SpecShininess;
	 fixed4 _SpecColor2;
	 half   _SpecIntensity;
	 float4 _SecondDiffLitDir;
	 fixed4 _SecondDiffLitCol;
	 fixed4 _MainColor;
	 struct Input {
		half2 uv_MainTex;
		half2 uv_NormalTex;
		half2 uv_MaskMap;
		float3 viewDir;
		float3 worldRefl;
		INTERNAL_DATA
	 };
	 struct SurfOutput {
		fixed3 Albedo;
		fixed3 Normal;
		fixed3 Emission;
		fixed  Alpha;
		fixed  specMask;
	 };
	 inline fixed4 LightingTermBlinnPhong(SurfOutput s, fixed3 lightDir, fixed3 viewDir, fixed atten)
	 {
		fixed3 h    = normalize(lightDir + viewDir);
		fixed  diff = max (0, dot (s.Normal, lightDir));
		fixed  secondDiff = max(0,dot(s.Normal,normalize(_SecondDiffLitDir)));
		fixed  nh   = max (0, dot (s.Normal, h));
		fixed  sp   = pow (nh, _SpecShininess) * _SpecIntensity;
		fixed4 c;	
		c.rgb       = (s.Albedo * (_LightColor0.rgb * diff + secondDiff*_SecondDiffLitCol)+ _LightColor0.rgb * _SpecColor2.rgb * sp*s.specMask) * atten;
		c.a = s.Alpha;
		return c;
	 }
		
	 void surf (Input IN, inout SurfOutput o) {

		fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		fixed4 mask_rim_spc_cube =  tex2D(_MaskMap, IN.uv_MaskMap);
	
		o.Normal  = UnpackNormal (tex2D (_NormalTex, IN.uv_NormalTex));;
		half3 worldRefl = WorldReflectionVector (IN, o.Normal);
		fixed3 cube_reflect_color = texCUBE (_Cubemap, WorldReflectionVector (IN, o.Normal)).rgb * mask_rim_spc_cube.z;
		
		half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
		fixed3  rim_color = _RimColor.rgb * pow (rim, _RimPower) *mask_rim_spc_cube.x;
		o.Albedo = tex.rgb *_MainColor;
		o.specMask = mask_rim_spc_cube.y;
		o.Emission =rim_color + cube_reflect_color;

	}

	ENDCG	

}
    
}
