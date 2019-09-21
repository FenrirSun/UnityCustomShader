// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

// Unlit shader. Simplest possible textured shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Tomcat/Scene/Texture" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
		_Brightness ("Brightness", Range(0,2)) = 1
		[Toggle(_Fog)] _Fog ("Fog", Int) = 1
	}

	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma multi_compile_fog
			#pragma shader_feature _Fog

			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Brightness;

			v2f vert(appdata_t v)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				#ifdef _Fog
				UNITY_TRANSFER_FOG(o,o.vertex);
				#endif
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.texcoord);
				col.rgb = col.rgb * _Brightness;
				#ifdef _Fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				#endif
				UNITY_OPAQUE_ALPHA(col.a);
				return col;
			}
		ENDCG
		}
	}
	FallBack "Unlit/Texture"
}
