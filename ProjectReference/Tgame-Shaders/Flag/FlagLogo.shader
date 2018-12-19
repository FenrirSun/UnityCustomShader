Shader "TSHD/VFX/FlagLogo" {
	Properties {
		_LogoColor ("Logo Color", Color) = (1,1,1,1)
		_LogoTex ("Logo Texture", 2D) = "white" {}
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
	}

	SubShader {
		Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
		Cull [_Cull]
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert  noforwardadd //alphatest:_Cutoff

		sampler2D _MainTex,_LogoTex;
		fixed4 _LogoColor;
		fixed _Cutoff;

		struct Input {
			float2 uv_MainTex;
			float2 uv_LogoTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) ;
			half4 logoCol =tex2D(_LogoTex, IN.uv_LogoTex) ;
			o.Albedo =lerp(c.rgb ,logoCol.r *_LogoColor.rgb,_LogoColor.a *logoCol.r);
			o.Alpha = c.a;
			clip(o.Alpha - _Cutoff);
		}
		ENDCG
		}

	Fallback "Legacy Shaders/Transparent/Cutout/VertexLit"
	}
