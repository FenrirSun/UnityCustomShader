Shader "Tomcat/Scene/Texture_UDIM"
{
    Properties
    {
		_MainTex("Albedo1 (U0-1)", 2D) = "white" {}
		_MainTex2 ("Albedo2 (U1-2)", 2D) = "white" {}
		_MainTex3 ("Albedo3 (U2-3)", 2D) = "white" {}
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
				//这里存uv的整数部分
				float2 texcoord_int : TEXCOORD0;
				//这里存uv的小数部分
				float2 texcoord_frac : TEXCOORD1;
				UNITY_FOG_COORDS(2)
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
            sampler2D _MainTex2;
			float4 _MainTex2_ST;
            sampler2D _MainTex3;
			float4 _MainTex3_ST;
			float _Brightness;

			v2f vert(appdata_t v)
			{
				v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                v.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.texcoord_frac = modf(v.texcoord, o.texcoord_int);
				#ifdef _Fog
				UNITY_TRANSFER_FOG(o,o.vertex);
				#endif
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col;
				//这里用if应该比用step的性能高
				if(i.texcoord_int.x == 1)
				{
					col = tex2D(_MainTex2, i.texcoord_frac);
				}
				else if(i.texcoord_int.x == 2)
				{
					col = tex2D(_MainTex3, i.texcoord_frac);
				}
				else
				{
					col = tex2D(_MainTex, i.texcoord_frac);
				}
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
