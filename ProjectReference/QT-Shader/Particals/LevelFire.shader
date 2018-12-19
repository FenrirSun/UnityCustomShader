Shader "TS_QT/Particles/LevelFire"
{
	Properties
	{
		_EdgeColor_1 ("Edge Color 1", Color) = (1,1,1,1)
		_EdgeColor_2 ("Edge Color 2", Color) = (1,1,1,1)
		_areaMap("Area Map", 2D) = "white"{}
		_MainTex ("Mask", 2D) = "white" {}
	//	_DissMask("_DissMask", 2D) = "white" {}
		_DissEdge("_DissEdge", 2D) = "white" {}
		_DissEdge2("_DissEdge2", 2D) = "black" {}
		DissEdgeWidth("Edge Width",float) = 0.02   //第一段边缘宽
		DissSecondStep("Edge Width 2",float) = 0.02  //第二段边缘宽
		_progress("_progress",Range(0,2)) = 0
		levelCount("level Count",float) = 4
		currLevel("curr Level",float) = 1
	}
	SubShader
	{
		Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite off
		

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			#pragma target 3.0
			#include "UnityCG.cginc"

			//fixed _DissStartTime; //开始溶解时间
			//fixed _DissSpeed;  //溶解速度（0~1）

			fixed _progress;
			sampler2D _areaMap;     //区域图
		//	sampler2D _DissMask;    //溶解噪声图
			sampler2D _DissEdge;    //溶解边缘图
			sampler2D _DissEdge2;    //溶解边缘图
			fixed DissEdgeWidth;  //边缘宽度
			fixed DissSecondStep; //第二阶段间隔（0~1）
			fixed levelCount;
			fixed currLevel;
			fixed4 _EdgeColor_1;
			fixed4 _EdgeColor_2;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			fixed myStep(fixed a, fixed x)
			{
				return  x >= a ? 1.0 : 0.0;
			}

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//fixed ct = _Time.y - _DissStartTime;  //当前已经溶解的时间
				//fixed progress = ct * _DissSpeed;    //溶解进度
				fixed4 area = tex2D(_areaMap, i.uv);
				fixed singleStep = 1 / levelCount;

				clip(area.r - singleStep * (currLevel - 0.5));

				fixed4 maskColor = tex2D(_MainTex, i.uv);
				fixed a = saturate(1000 * maskColor.a);
			//	fixed4 dissMaskColor = tex2D(_DissMask, i.uv);   //mask颜色
				fixed4 dissEdgeColor = tex2D(_DissEdge, i.uv);   //溶解边缘颜色
				fixed4 dissEdgeColor2 = tex2D(_DissEdge2, i.uv); //
				fixed currValue = area.g;// dissMaskColor.r;
			//	fixed dissValue = currValue + DissEdgeWidth + DissSecondStep - _progress;
				fixed dissValue = currValue + DissEdgeWidth + DissSecondStep - _progress;

				fixed areaCoe = step(0, area.r - singleStep * (currLevel + 0.5));

				clip(dissValue + areaCoe * 1000);

				fixed op = saturate(sign(currValue - _progress));//原色参数 0.1~1区间
				fixed ep = float(step(0, _progress - currValue)) *float( step(_progress - currValue, DissEdgeWidth));//边缘色参数 0~0.1, 因为step会返回int值，怀疑unity编译器没有定义int*int返回fixed的操作。所以需要强转float骗一下编译器
				fixed cp = step(DissEdgeWidth, _progress - currValue);//溶解底色参数 0~负无穷

				

				fixed4 color = areaCoe * maskColor + (1 - areaCoe) * (maskColor * op + dissEdgeColor * ep * _EdgeColor_1 +dissEdgeColor2 * cp * _EdgeColor_2);// +Luminance(color) * 2 * dissMaskColor.rgb * cp;
				//color.a *= a;

				//color.a = 1;
				//color.rgb = singleStep;// *(currLevel + 0.5);//area.r;

				//// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);
				//// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);
				return color;
			}
			ENDCG
		}
	}
}
