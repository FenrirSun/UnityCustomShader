// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TSHD/Vegetation/PlantEmissionBreathe_AlphaTest" 
{
	Properties
	{
		_AmbScale ("Ambient Color", Range (0.0, 1)) = 0.3
		_MainTex ("Main Texture", 2D) = "white" {}
		_EmissionMaskTex ("Emission Mask Texture", 2D) = "white" {}
		_EmissionScale ("Emission Scale", Range (0.0, 10)) = 0
		[KeywordEnum(Enable, Disable)] _Breathe ("Enable Breathe", Float) = 1
		_EmissionBreTimeFrequency("Breathe Frequency",Float) = 0.1
        _EmissionBreAreaScale ("Breathe Strength",Range(0, 2)) = 1.3
		_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
	}
	SubShader
    {
		Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
		Cull [_Cull]
		CGPROGRAM
        #pragma surface surf Lambert alphatest:_Cutoff vertex:vert exclude_path:deferred  exclude_path:prepass nometa  noforwardadd//nofogæÕ√ªŒÌ¡À finalcolor:fogColor
        #pragma target 3.0
		#pragma multi_compile _BREATHE_ENABLE _BREATHE_DISABLE

        sampler2D _MainTex;
		sampler2D _EmissionMaskTex;


        fixed _AmbScale;


		fixed _EmissionScale;
		
		float _EmissionBreTimeFrequency;
		float _EmissionBreAreaScale;

        struct Input {
			float2 uv_MainTex;
			#if _BREATHE_ENABLE
				float scale;
			#endif
        };
        
        void vert (inout appdata_full v,out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            float4 pos = UnityObjectToClipPos (v.vertex);
			#if _BREATHE_ENABLE
				float ss = sin(_Time.w * _EmissionBreTimeFrequency);
				o.scale = (ss + 2.5)*_EmissionBreAreaScale*0.5;
			#endif
        }

        void surf (Input IN, inout SurfaceOutput o) {
	        half4 c  = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = lerp(c.rgb,c.rgb *UNITY_LIGHTMODEL_AMBIENT,_AmbScale); //mul Amb
	        fixed3 emissionMaskColor = tex2D(_EmissionMaskTex, IN.uv_MainTex).rgb;
            
			#if _BREATHE_ENABLE
				o.Emission = emissionMaskColor * _EmissionScale * IN.scale;
			#else
				o.Emission = emissionMaskColor * _EmissionScale;
			#endif
			o.Alpha = c.a;
        }
        ENDCG
   }
	FallBack "Legacy Shaders/Transparent/Cutout/VertexLit"
}
	