Shader "YS/Hero/Ghost"
{
	Properties
	{
		_RimRate("RimRate", Range(0, 10)) = 1.5
		_RimColor("RimColor", Color) = (0,0,0,1)
	}
	SubShader
	{
		Tags
		{
			"IgnoreProjector" = "True"
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
		}
		Pass
		{
			Name "ForwardBase"

			Blend SrcAlpha One
			BindChannels
			{
				Bind "Color", color
				Bind "Vertex", vertex
				Bind "TexCoord", texcoord
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			uniform float _RimRate;
			uniform float4 _RimColor;

			uniform float _Alpha;
			
			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord0 : TEXCOORD0;
				float4 vertexColor : COLOR;
			};

			struct VertexOutput
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 posWorld : TEXCOORD1;
				float3 normalDir : TEXCOORD2;
				float4 vertexColor : COLOR;
			};

			float CalcRimLight(fixed3 posWorld, fixed3 normalDir)
			{
				float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - posWorld.xyz);
				float3 normalDirection = normalDir * sign(dot(viewDirection, normalDir));
				float3 rim = max(0,dot(normalDirection, viewDirection));
				rim = pow(1.0 - rim, _RimRate);

				return rim;
			}

			VertexOutput vert(VertexInput v)
			{
				VertexOutput o;
				o.uv = v.texcoord0;
				o.vertexColor = v.vertexColor;
				o.normalDir = normalize(mul(unity_ObjectToWorld, v.normal));
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag(VertexOutput i) : SV_Target
			{
				float rim = CalcRimLight(i.posWorld, i.normalDir);
				return fixed4(_RimColor.rgb*rim, _RimColor.a);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
