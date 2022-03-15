Shader "Kirk/Droplet"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_Opacity("Opacity",Range(0 ,1)) = 1
		_MoreRainAmount("Droplet Amount",Range(0, 1)) = 1
		_FixedDroplet("Fixed Droplet",Range(0 ,1)) = 0.7
		_DropletSize("Droplet Size",Range(0 ,1)) = 0.4
		_Speed("Droplet Speed",Range(0 ,1)) = 1
		
		_StaticSize("Static Size",Range(0 ,1)) = 0.3
		
		_DropletDensityOne("Droplet Density One",Range(0 ,10)) = 1.85
		_DropletDensityTwo("Droplet Density Two",Range(0 ,10)) = 1.85
		_DropletSizeOne("Droplet Size One",Range(0 ,3)) = 0.75
		_DropletSizeTwo("Droplet Size Two",Range(0 ,3)) = 0.5
	}

		SubShader
		{
			Tags { "Queue" = "Transparent" "RenderType" = "Opaque" }

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 3.0
				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float2 uv : TEXCOORD0;
					// float4 scrPos : TEXCOORD1;
					// float3 worldNormal : TEXCOORD2;
					// float3 normal : TEXCOORD3;
					// float3 worldPos : TEXCOORD4;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;
				float _Opacity;
				float _FixedDroplet;
				float _MoreRainAmount;
				float _StaticSize;
				float _DropletSize;
				float _DropletSizeOne;
				float _DropletSizeTwo;
				float _DropletDensityOne;
				float _DropletDensityTwo;
				float _Speed;

				float3 N13(float p) {
					float3 p3 = frac(float3(p,p,p) * float3(.1031,.11369,.13787));
					p3 += dot(p3, p3.yzx + 19.19);
					return frac(float3((p3.x + p3.y) * p3.z, (p3.x + p3.z) * p3.y, (p3.y + p3.z) * p3.x));
				}
				float4 N14(float t) {
					return frac(sin(t * float4(123., 1024., 1456., 264.)) * float4(6547., 345., 8799., 1564.));
				}
				float N(float t) {
					return frac(sin(t * 12345.564) * 7658.76);
				}
				float Saw(float b, float t) {
					return smoothstep(0., b, t) * smoothstep(1., b, t);
				}

				float2 DropLayer2(float2 uv, float t) {
					float2 UV = uv;

					uv.y += t * 0.75;
					float2 a = float2(6, 1);
					float2 grid = a * 3.;
					float2 id = floor(uv * grid);

					float colShift = N(id.x);
					uv.y += colShift;

					id = floor(uv * grid);
					float3 n = N13(id.x * 35.2 + id.y * 2376.1);
					float2 st = frac(uv * grid) - float2(0.5, 0);

					float x = n.x - 0.5;

					float y = UV.y * 20;
					float wiggle = sin(y + sin(y));
					x += wiggle * (0.5 - abs(x)) * (n.z - 0.5);
					x *= _FixedDroplet;
					float ti = frac(t + n.z);
					y = (Saw(0.85, ti) - 0.5) * 0.9 + 0.5;
					float2 p = float2(x, y);

					float d = length((st - p) * a.yx);

					float mainDrop = smoothstep(_DropletSize, 0, d);

					float r = sqrt(smoothstep(1, y, st.y));
					float cd = abs(st.x - x);
					float trail = smoothstep(0.23 * r, 0.15 * r * r, cd);
					float trailFront = smoothstep(-0.02, 0.02, st.y - y);
					trail *= trailFront * r * r;

					y = UV.y;
					// float trail2 = smoothstep(0.2 * r, 0.0, cd);
					// float droplets = max(0, (sin(y * (1 - y) * 120) - st.y)) * trail2 * trailFront * n.z;
					y = frac(y * 10.) + (st.y - .5);
					float dd = length(st - float2(x, y));
					float droplets = smoothstep(.1, 0., dd);
					float m = mainDrop + droplets * r * trailFront;

					return float2(m, trail);
				}

				float StaticDrops(float2 uv, float t) {
					uv *= 100.;

					float2 id = floor(uv);
					uv = frac(uv) - .5;
					float3 n = N13(id.x * 107.45 + id.y * 3543.654);
					float2 p = (n.xy - .5) * .7;
					float d = length(uv - p);

					float fade = Saw(.025, frac(t + n.z));
					float c = smoothstep(_StaticSize, 0., d) * frac(n.z * 10.) * fade;
					return c;
				}

				float Drops(float2 uv, float t, float l0, float l1, float l2) {
					float s = StaticDrops(uv, t) * l0;
					float2 m1 = DropLayer2(uv * _DropletDensityOne, t) * l1;
					float2 m2 = DropLayer2(uv * _DropletDensityTwo, t) * l2;

					float c = s + m1.x + m2.x;
					c = smoothstep(0.3, 1, c);

					return c;
				}

				// float2 DropsDynamic(float2 uv, float t, float l1, float l2)
				// {
				// 	float2 m1 = DropLayer2(uv, t) * l1;
				// 	float2 m2 = DropLayer2(uv * 1.75, t) * l2;
				//
				// 	float c = m1.x + m2.x;
				// 	c = smoothstep(.4, 1., c);
				//
				// 	return float2(c, max(0, m2.y * l1));
				// }

				v2f vert(appdata v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					// o.scrPos = ComputeScreenPos(o.pos);
					// o.normal = v.normal;
					// o.worldNormal = UnityObjectToWorldNormal(v.normal);
					// o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
					return o;
				}

				fixed4 frag(v2f _iParam) : SV_Target
				{
					float2 uv = _iParam.uv;
					float2 UV = _iParam.uv;
					const float rainAmount = 2;
					
					float T = (_Time.y + rainAmount * 2) * _Speed;
					float t = T * (.2 + 0.1 * _MoreRainAmount);

					uv *= 0.5;

					float staticDrops = 1. * 2.;
					// float layer1 = .75;
					// float layer2 = .5;

					float2 n = float2(0, 0);
					float c = Drops(uv, t, staticDrops, _DropletSizeOne, _DropletSizeTwo).x;
					float2 e = float2(0.001, 0.);
					float cx = Drops(uv + e, t, staticDrops, _DropletSizeOne, _DropletSizeTwo).x;
					float cy = Drops(uv + e.yx, t, staticDrops, _DropletSizeOne, _DropletSizeTwo).x;
					n += float2(cx - c, cy - c);
					
					// float moreRainAmount = 1.25 + 1.25 * _MoreRainAmount;
					// for (float i = 1.25; i < moreRainAmount; i += 0.25)
					// {
					// 	// float i = 1.25;
					// 	float2 _c = DropsDynamic(uv, t * i, layer1, layer2);
					// 	float _cx = DropsDynamic(uv + e, t * i, layer1, layer2).x;
					// 	float _cy = DropsDynamic(uv + e.yx, t * i, layer1, layer2).x;
					// 	n += float2(_cx - _c.x, _cy - _c.x);
					// }

					float blend = (n.x + n.y) * (1.75 + _MoreRainAmount);
					float3 col = tex2D(_MainTex, UV + n * _Opacity).rgb;
					float4 fragColor = float4(col, blend);
					return fragColor;
				}
				ENDCG
			}
		}
}