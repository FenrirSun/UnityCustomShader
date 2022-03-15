Shader "Tomcat/Character/skin_sss_AO" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap("Normalmap", 2D) = "bump" {}
        _BumpFactor("Normal Factor", Range(-25,25)) = 1 
		_OcclusionTex("Occlusion Map", 2D) = "white" {}
        _OcclusionScale("Occlusion Scale", Range(0,1)) = 1
        _Glossiness ("Smoothness", Range(0,1)) = 0.36
		_Metallic ("Metallic", Range(0,1)) = 0.5
        fLTDistortion("Distortion", Range(0,2)) = 1.186
        iLTPower("Power", Range(0.5,5)) = 1
        fLTScale("Scale", Range(0,10)) = 0.3
        fLightAttentuation("Attentuation", Range(0,10)) = 1.0
        fLTAmbient("Ambient", Color) = (0.713,0.627,0.627,1)
    }
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _OcclusionTex;

        float fLTDistortion;
        float fLTScale;
        float iLTPower;
        fixed4 fLTAmbient;
        float fLightAttentuation;

        fixed _BumpFactor;
        sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
		    float3 viewDir;
            float3 worldPos;
        };

		half _Glossiness;
		half _Metallic;
        half _OcclusionScale;
		fixed4 _Color;

        void vert (inout appdata_full v, out Input o) 
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
        }

        void surf (Input IN, inout SurfaceOutputStandard o) {
            // Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            //// Metallic and smoothness come from slider variables
			o.Occlusion = tex2D(_OcclusionTex, IN.uv_MainTex);
            //remap occlusion
            half o_min = 1 - _OcclusionScale;
            //o.Occlusion =(o_min + ( (o.Occlusion - 0) * (1 - o_min) ) / (1 - 0));
            o.Occlusion = o_min + o.Occlusion * (1 - o_min);
            o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
   
            //法线
            fixed3 bump = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
            bump.xy *= _BumpFactor;
            bump.z = sqrt(1.0 - saturate(dot(bump.xy, bump.xy)));
            o.Normal = bump;

            //模拟SSS
            float3 lightDir = normalize(IN.worldPos - _WorldSpaceCameraPos);
            float3 vEye =  normalize(_WorldSpaceCameraPos - IN.worldPos);
            half3 vLTLight = lightDir + o.Normal.xyz * fLTDistortion;
            half fLTDot = pow(saturate(dot(vEye, -vLTLight)), iLTPower) * fLTScale;
            half3 fLT = fLightAttentuation * (fLTDot + fLTAmbient.rgb);
            
            o.Emission = o.Albedo * fLT;
        }

		ENDCG
	} 
	FallBack "Diffuse"
}
