// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "(Discard)TS_QT/CastShadow" {
SubShader {
	Blend SrcAlpha OneMinusSrcAlpha
	//Blend One One
		ZTest On
		ZWrite Off
	 	Tags {"RenderType"="Opaque"}
	    Pass {
			Name "SHADOWPASS"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile QT_SHADOW_OFF QT_SHADOW_ON
			#include "UnityCG.cginc"
			
			float4x4 QTShadowCamera_VP;  //阴影相机的VP矩阵
			float4x4 QTShadowWorldToView;  //世界到shadow相机空间的变换矩阵
			sampler2D QTShadowMap;
			float4 ShadowLightDir;
			float QTShadowCameraFar;
			
			struct v2f {
			    float4  pos : SV_POSITION;
			    float4 texc: TEXCOORD0;
			    float2 nlAndDepth:TEXCOORD1;
			};
			
			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				float4x4 proj;
				proj = mul(QTShadowCamera_VP, unity_ObjectToWorld);
				float4x4 shadowMV = mul(QTShadowWorldToView, unity_ObjectToWorld);
			    o.texc = mul(proj, v.vertex);   //顶点到shadow相机的投影空间。为了将当前顶点，映射到shadowmap上的一点
			   	o.nlAndDepth.x = dot(ShadowLightDir,mul(unity_ObjectToWorld, half4(v.normal,0)));  //记录法线与光线的cos值，用于判定是否是照向背面
				o.nlAndDepth.y = -(mul( shadowMV, v.vertex ).z * (1/QTShadowCameraFar)); //计算顶点相对shadow相机的深度值（0~1）
			    return o;
			}
			
			half4 frag (v2f i) : COLOR
			{
				fixed4 c;
				#ifdef QT_SHADOW_ON
			    float2 shc = 0.5*i.texc.xy/i.texc.w+float2(0.5,0.5); //将-1~1空间的值，变换到0~1空间。作为shadowmap的uv
			    c=tex2D(QTShadowMap,shc); 
				clip(0.999 - c.r);

			   /* if(shc.x > 1 || shc.y > 1 || shc.x < 0 || shc.y < 0)
			    {
			    	c = float4(1,1,1,1);
			    }*/
				float rangeThre =  saturate(sign(1 - shc.x)) * saturate(sign(1 - shc.y)) * saturate(sign(shc.x)) * saturate(sign(shc.y)); //范围限制，当uv超界时则不进行渲染
			
			    float od = c.r; //取得光源视角记录的深度值，并对深度做微小偏移
			    float cd = i.nlAndDepth.y; //计算当前深度值

				half depthDiff = abs(od - cd); //深度差
				//两者深度差大于相机观看距离30%，则忽略阴影。   间隔距离0%~15%阴影强度为1，15%~30%递减消失
				half atten = saturate((1 - (depthDiff / 0.3))* 2);
				//atten = atten * atten * atten;
				rangeThre = rangeThre * pow(atten,2) ;//当两者深度差，大于整个相机观看距离的10%，则忽略阴影
				
			/*	if(cd > (od + 0.005))  //如果当前点距离比顶光视角中记录的值远，则被阴影遮挡。呈灰色.0.005为偏移值。
				{
					c.a = 0.3;
				}
				else  //当前点距离，比灯光视角中记录的值近，则显示白色（无阴影）
				{
					c.a = 0;
				}*/
				c.a = saturate(sign(cd - (od + 0.005))) * 0.3;//将以上if语句优化为sign


			/*	if(i.nl < 0)
				{
					c.a = 0;
				}*/
				c.a = c.a * saturate(sign(i.nlAndDepth.x)) * rangeThre;
				//c.a = pow(atten,1);
				c.rgb = 0;
				#endif
				
				#ifdef QT_SHADOW_OFF
				clip(-1);
				c = float4(0,0,0,0);
				#endif
				
				
			    return c;
			}
			ENDCG
	
	    }
	}
}
