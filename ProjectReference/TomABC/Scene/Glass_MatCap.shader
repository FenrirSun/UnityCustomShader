// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

Shader "Tomcat/Scene/Glass_MatCap" {
	Properties{
		_ColorMult("Luminocity", Range(-1,2)) = 1
		_Color("Color", Color) = (1,1,1,0.37)
		_Glossiness("Smoothness", Range(0,1)) = 0.973
		_Metallic("Metallic", Range(0,1)) = 0.916
		_Reflection("Reflection Intencity", Range(0.1,10)) = 5.2
		_Saturation("Reflection Saturation", Range(0.6,2.2)) = 1.2
		_DotProduct("Rim effect", Range(-1,1)) = 0.044
		_Emission("Emission", Range(-1,1)) = 1
		_EmissionColor("Emission Color", Color) = (1,1,1,0.37)
		_Occlusion("Occlusion", Range(-2,5)) = 1

        [Space(10)]
        [Header(MatCap)]
        //Material Capture纹理
        [NoScaleOffset]_MatCap("MatCap", 2D) = "black" {}
        _MatCapIntencity("MatCap Intencity", Range(0, 1)) = 0.3
        _MatCapSpec("MatCap Spec", 2D) = "black" {}
        _MatCapSpecIntencity("MatCapSpec Intencity", Range(0, 1)) = 0.3
        _MatCapColor ("MatCap Color", Color) = (0.2, 0.2, 0.2, 1)

		//_Fresnel("Fresnel Coefficient", Range(-1,10)) = 5.0
		//_Refraction("Refration Index", float) = 0.9
		//_Reflectance("Reflectance", Range(-1,1)) = 1.0
			
		//_Cube("Cube",CUBE) = ""{}
	}
		SubShader{
			Tags {
				"Queue" = "Transparent"
				"IgnoreProjector" = "True"
				"RenderType" = "Transparent"
			}
			LOD 200
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGBA

			CGPROGRAM
			#pragma surface surf Standard exclude_path:deferred exclude_path:prepass nofog keepalpha // alpha:fade
			#pragma target 3.0

			float _ColorMult;
			float _Reflection;
			float _DotProduct;
			float _Saturation;
			float _Occlusion;
			float _Emission;
			//float _Fresnel;
			//float _Refraction;
			//float _Reflectance;

			struct Input {
				float2 uv_MainTex;
				float3 worldNormal;
				float3 viewDir;
				float3 worldRefl;
			};

			half _Glossiness;
			half _Metallic;
			fixed4 _Color;
			fixed4 _EmissionColor;
			//samplerCUBE _Cube;
			#include "../CGIncludes/MatCap.cginc"

			void surf(Input IN, inout SurfaceOutputStandard o) {
				// Albedo comes from a texture tinted by color
				fixed4 c = _Color;
				c.rgb += calcMatCap(IN.worldNormal, 1, IN.viewDir);
				o.Albedo = c.rgb * _ColorMult;

				// Metallic and smoothness come from slider variables
				o.Metallic = _Metallic * _Saturation;
				o.Smoothness = _Glossiness;

				// Add transparency in the center (if more perpendicular)
				// And more reflections in the side (if more angle).
				float border = 1 - (abs(dot(IN.viewDir,IN.worldNormal)));
				float alpha = (border * (1 - _DotProduct) + _DotProduct);
				o.Alpha = ((c.a * _Reflection)  * alpha);

				//o.Emission = c.a;
				//o.Emission = texCUBE(_Cube, IN.worldRefl).rgb * c.a* _Emission;
				o.Emission = _EmissionColor.rgb * c.a* _Emission;
				o.Occlusion = _Occlusion;
			}

			ENDCG
		}

		//Fallback "Unlit/Transparent"
		Fallback "VertexLit" 
}