Shader "VX/Character New/LobbyCubeMapAlphaTest_Hair" {
	Properties {
	 _Color("main color ",Color) = (0.8,0.8,0.8,1)
	 _Cutoff ("AlphaTest Cutoff", Range(0.01,1)) = 0.5
	 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
	 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
	 _MainTex ("Color Map (RGB)", 2D) = "white" {}
	 _Alpha ("Alpha Mask", 2D) = "white" {}
	 _BumpMap ("Normal Map", 2D) = "bump" {}
	 _Cubemap ("Cubemap", CUBE) = "" 
	 _MaskMap ("R(Rim) G(Specular) B(CubeMap)", 2D) = "white" {}
	 _RimColor ("Rim Color", Color) = (1,1,1,1)
	 _EdgeIn ("Edge In Range", Range(0,1)) = 0.5
	 _EdgeOut ("Edge Out Range", Range(1,2)) = 1.5
	}
	Category{
	    Tags { "Queue" = "Geometry" "IgnoreProjector" = "True"  }
		SubShader {
			LOD 400
			CGPROGRAM
			#pragma surface surf BlinnPhong  addshadow noforwardadd  nolightmap exclude_path:prepass exclude_path:deferred alphatest:_Cutoff
			#pragma target 3.0
			sampler2D   _MainTex;
			sampler2D   _Alpha;
			sampler2D   _BumpMap;
			sampler2D   _MaskMap;
			samplerCUBE _Cubemap;
		
			fixed       _Shininess;
			fixed4      _RimColor;
			half        _CubeExp;
			half        _EdgeIn;
			half        _EdgeOut;
			fixed4      _Color;
		
			struct Input {
				half2  uv_MainTex;
				half2  uv_Alpha;
				half2  uv_BumpMap;
				half2  uv_MaskMap; 
				float3 viewDir;     
      			float3 worldRefl;
      			INTERNAL_DATA
			};
			void surf (Input IN, inout SurfaceOutput o) {
				fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
				fixed4 alpha_mask = tex2D( _Alpha, IN.uv_Alpha);
				fixed4 rim_spec_cube = tex2D(_MaskMap, IN.uv_MaskMap);
				o.Albedo = tex.rgb* _Color;
				o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
				fixed3 cube_reflect_color = texCUBE (_Cubemap, WorldReflectionVector (IN, o.Normal)).rgb * rim_spec_cube.z;
				half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
				fixed p =clamp((rim-_EdgeIn)/(_EdgeOut-_EdgeIn),0,1);
				fixed3  rim_color = _RimColor.rgb *(p*(p*(3-(2*p))));
				o.Emission   = cube_reflect_color + rim_color*rim_spec_cube.x;
			   	o.Gloss = rim_spec_cube.y;
				o.Specular =  _Shininess;
				o.Alpha = alpha_mask.x;
			}
			ENDCG
		}
	}
}