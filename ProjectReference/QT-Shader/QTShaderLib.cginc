// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "UnityShaderVariables.cginc"
#include "QTShaderInput.cginc"

//##################################  通用变量  ##################################
fixed4 _Color;
fixed _Cutoff;
sampler2D _MainTex;
sampler2D _AlphaTex;//单位贴图中： r:自发光/流光遮罩  g:?  b:高光贴图
sampler2D _QTBumpMap;
sampler2D _QTBumpMap2;
sampler2D _QTBumpMap3;
sampler2D _QTBumpMap4;
//sampler2D _MaskMap;
//sampler2D _CoatMap;

fixed2 tree_WindDir;
fixed tree_WindIntensity;
fixed tree_WindRate;
fixed tree_WindSwing;
fixed tree_WindScale;

float4x4 mirrorMatrix_VP;
sampler2D _ReflectTex;
fixed _PR_DiffWeight;
fixed _PR_ReflectWeight;


#ifdef QT_ROLE_SHADOW_ON
fixed shadowAlpha;
float bias;
#endif



//fixed _OceanRefractWeight;

//##################################  通用函数  ##################################
//深度压缩
float4 QTDepthEncode(float depth)
{
	//float temp = depth * 255;  
	//temp = (temp - frac(temp)); 
	//float4 c;
	//c.r = temp * 0.0039;// 乘以1/255
	//c.g = (depth - temp) * 255; 
	//c.b = 0;
	//c.a = 1;
	//return c;
	return EncodeFloatRGBA(depth);
}
//深度解压
float QTDepthDecode(float4 color)
{
	/*float t = color.r + color.g * 0.00392;

	return t;*/

	return DecodeFloatRGBA(color);
}

float SimpleShadowMap(sampler2D shadowMap, float2 uv)
{
	//float step = 1.0/2048;
	//float4 c1 = tex2D(shadowMap, uv + float2(step,step));
	//float d1 = QTDepthDecode(c1); 
	//float4 c2 = tex2D(shadowMap, uv + float2(step, -step));
	//float d2 = QTDepthDecode(c2);
	//float4 c3 = tex2D(shadowMap, uv + float2(-step, -step));
	//float d3 = QTDepthDecode(c3);
	//float4 c4 = tex2D(shadowMap, uv + float2(-step, step));
	//float d4 = QTDepthDecode(c4);
	//return (d1 + d2 + d3 + d4) * 0.25;


	float4 c = tex2D(shadowMap, uv);
	float d = QTDepthDecode(c);
	return d;
}

float3 QTUnpackNormal(fixed2 packednormal)
{
	return float3(packednormal.xy * 2 - 1, 1);
}

//##################################  通用宏定义  ##################################
//alpha 裁剪
#define ZEngine_Clip clip(alpha.a - _Cutoff - 0.001)
#define ZEngine_ClipBlue clip(alpha.b - _Cutoff - 0.001)
#define ZEngine_ClipRed clip(alpha.r - _Cutoff - 0.001)
//默认法线
#define ZEngine_Normale fixed4(0,0,1,0)



//------------------------------------------------------- 阴影 -------------------------------------------------------
float4x4 QTShadowCamera_VP;  //阴影相机的VP矩阵
float4x4 QTShadowWorldToView;  //世界到shadow相机空间的变换矩阵
sampler2D QTShadowMap; //shadow Map
fixed4 ShadowLightDir;  //阴影灯光方向
fixed QTShadowCameraFar;  //shadow camera的远裁剪面
fixed diffBias;

#ifdef QT_ROLE_SHADOW_ON
inline void Shadow_Vertex(inout appdata_full v, inout Input data)
{
	float4x4 proj;
	proj = mul(QTShadowCamera_VP, unity_ObjectToWorld);
	float4x4 shadowMV = mul(QTShadowWorldToView, unity_ObjectToWorld);
	fixed4 puv = mul(proj, v.vertex);   //顶点到shadow相机的投影空间。为了将当前顶点，映射到shadowmap上的一点
	data.QT_ShadowUV_NL_Depth.xy = 0.5* puv.xy / puv.w + fixed2(0.5, 0.5); //将投影空间点，化为uv
	data.QT_ShadowUV_NL_Depth.z = dot(ShadowLightDir, mul(unity_ObjectToWorld, fixed4(v.normal, 0)));  //记录法线与光线的cos值，用于判定是否是照向背面
	data.QT_ShadowUV_NL_Depth.w = -(mul(shadowMV, v.vertex).z * (1 / QTShadowCameraFar)); //计算顶点相对shadow相机的深度值（0~1）
																						  //data.QT_ShadowUV_NL_Depth.w = -(mul(UNITY_MATRIX_MV, v.vertex).z * (0.1));
																						  //-(mul(UNITY_MATRIX_MV, v.vertex).z * _ProjectionParams.w)
}

//这个是实时光单位接收阴影
inline fixed Shadow_Light(fixed4 uv_nl_d, fixed diffCos, inout SurfaceOutput o)
{

	float4 c;
	float2 shc = uv_nl_d.xy;//0.5*i.texc.xy/i.texc.w+float2(0.5,0.5); //将-1~1空间的值，变换到0~1空间。作为shadowmap的uv
							//c = tex2D(QTShadowMap, shc);
							//float od = QTDepthDecode(c);//取得光源视角记录的深度值
	float od = SimpleShadowMap(QTShadowMap, shc);
	float depthClip = sign(saturate(0.999 - od)); //如果深度图数值为1，则返回0
	float4 tempRangeThre4 = saturate(sign(fixed4(1 - shc.xy, shc.xy))); //范围限制，当uv超界时则不进行渲染
	float rangeThre = tempRangeThre4.x * tempRangeThre4.y * tempRangeThre4.z * tempRangeThre4.w;

	//float od = c.r; //取得光源视角记录的深度值，并对深度做微小偏移
	float cd = uv_nl_d.w; //计算当前深度值
						  //fixed depthDiff = abs(od - cd); //深度差

						  //两者深度差大于相机观看距离30%，则忽略阴影。(*0.33代替除以0.3)
						  //卡牌游戏场景比较简单，不做此计算
						  //fixed atten = max(0, sign(0.15 - depthDiff));// saturate((1 - (depthDiff * 3.33)));
						  //rangeThre = rangeThre * atten;

	float shadow = depthClip * rangeThre * max(0, sign(cd - (od + bias)));//将if语句优化为sign，如果当前深度值，比shadowmap记录的深度值大，则表示该点有阴影。

																		  //saturate(sign(IN.QT_ShadowUV_NL_Depth.z))用于判定是否是背对光源, 这部分因为卡牌游戏场景比较简单，所以忽略
																		  //rangeThre判定阴影是否超范围
																		  //depthClip判定该位置在shadowmap上是否没有物体
																		  //shadow = shadow * saturate(sign(IN.QT_ShadowUV_NL_Depth.z)) * rangeThre * depthClip;
																		  //shadow = shadow * saturate(sign(IN.QT_ShadowUV_NL_Depth.z)) * rangeThre * depthClip;
																		  //if (IN.QT_ShadowUV_NL_Depth.z <= 0)
																		  //{
																		  //	shadow = 0;
																		  //}
	shadow = shadow * saturate(sign(diffCos - diffBias));
	/*if (diff < diffBias)
	{
		shadow = 0;
	}*/
	return  shadow;//(cd - od) * 3;
				   //return rangeThre;
}
#endif

//静态物体接收实时阴影
#ifdef QT_SHADOW_ON
inline void Shadow_Vertex(inout appdata_full v, inout Input data)
{
	float4x4 proj;
	proj = mul(QTShadowCamera_VP, unity_ObjectToWorld);
	float4x4 shadowMV = mul(QTShadowWorldToView, unity_ObjectToWorld);
	fixed4 puv = mul(proj, v.vertex);   //顶点到shadow相机的投影空间。为了将当前顶点，映射到shadowmap上的一点
	data.QT_ShadowUV_NL_Depth.xy = 0.5* puv.xy / puv.w + fixed2(0.5, 0.5); //将投影空间点，化为uv
	data.QT_ShadowUV_NL_Depth.z = dot(ShadowLightDir, mul(unity_ObjectToWorld, fixed4(v.normal, 0)));  //记录法线与光线的cos值，用于判定是否是照向背面
	data.QT_ShadowUV_NL_Depth.w = -(mul(shadowMV, v.vertex).z * (1 / QTShadowCameraFar)); //计算顶点相对shadow相机的深度值（0~1）
																						  //data.QT_ShadowUV_NL_Depth.w = -(mul(UNITY_MATRIX_MV, v.vertex).z * (0.1));
																						  //-(mul(UNITY_MATRIX_MV, v.vertex).z * _ProjectionParams.w)
}

//这个是光照贴图单位，接受实时阴影
inline void Shadow_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
{
	float4 c;
	float2 shc = IN.QT_ShadowUV_NL_Depth.xy;//0.5*i.texc.xy/i.texc.w+float2(0.5,0.5); //将-1~1空间的值，变换到0~1空间。作为shadowmap的uv
											//c=tex2D(QTShadowMap,shc);
											//fixed od = QTDepthDecode(c);//取得光源视角记录的深度值
	float od = SimpleShadowMap(QTShadowMap, shc);
	float depthClip = sign(saturate(0.999 - od)); //如果深度图数值为1，则返回0
	float4 tempRangeThre4 = saturate(sign(fixed4(1 - shc.xy, shc.xy))); //范围限制，当uv超界时则不进行渲染
	float rangeThre = tempRangeThre4.x * tempRangeThre4.y * tempRangeThre4.z * tempRangeThre4.w;

	//float od = c.r; //取得光源视角记录的深度值，并对深度做微小偏移
	float cd = IN.QT_ShadowUV_NL_Depth.w; //计算当前深度值
	float depthDiff = abs(od - cd); //深度差

									//两者深度差大于相机观看距离30%，则忽略阴影。(*0.33代替除以0.3)
									//卡牌游戏场景比较简单，不做此计算
									//fixed atten = max(0, sign(0.15 - depthDiff));// saturate((1 - (depthDiff * 3.33)));
									//rangeThre = rangeThre * atten;

	c.a = max(0, sign(cd - (od + 0.01)));//将if语句优化为sign，如果当前深度值，比shadowmap记录的深度值大，则表示该点有阴影。

										 //saturate(sign(IN.QT_ShadowUV_NL_Depth.z))用于判定是否是背对光源, 这部分因为卡牌游戏场景比较简单，所以忽略
										 //rangeThre判定阴影是否超范围
										 //depthClip判定该位置在shadowmap上是否没有物体
	c.a = c.a * saturate(sign(IN.QT_ShadowUV_NL_Depth.z)) * rangeThre * depthClip * 0.6;// *color.a;
																						//c.a = c.a * rangeThre * depthClip * 0.6 * color.a;
	color.rgb = color.rgb * (1 - c.a);

}
#endif

//##################################  光照模型  ##################################
//******************************************* Lambert光照模型 *******************************************
inline fixed4 LightingQT_Lambert (SurfaceOutput s, fixed3 lightDir, fixed atten)
{
	fixed diff = max (0, dot (s.Normal, lightDir));
	
	fixed4 c;
	c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 2);
	c.a = s.Alpha;
	return c;
}


//******************************************* BRDF光照模型 *******************************************
fixed BRDF_k1;
fixed BRDF_k2;
sampler2D _BRDFMap;
fixed specEnhanceOqapue;  //高光增强不透明度
#ifdef QT_ROLE_SHADOW_ON
fixed4 QT_ShadowUV_NL_Depth;
#endif

inline fixed4 LightingQT_BRDF (SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
{
	fixed cos = dot(s.Normal, lightDir);
	fixed diff = (cos + 1) / 2;
	fixed3 rv = -lightDir - 2 * dot(-lightDir, s.Normal) * s.Normal;//normalize (lightDir + viewDir); //半向量，近似反射方向
	fixed vh = (dot(rv, viewDir) + 1) / 2;//反射方向与相机
	fixed3 brdfColor = tex2D(_BRDFMap, fixed2(diff,vh));
	fixed spec = brdfColor.b * brdfColor.g * s.Specular;// s.Gloss;
	fixed brdfdiff = brdfColor.r;

#ifdef QT_ROLE_SHADOW_ON
	//计算阴影系数，Specular在无阴影时，将会传入镜面高光强度，有阴影时将会传入一个负数（负数的值没有意义，重要的是一个负数）
	//inline fixed Shadow_Light(fixed4 uv_nl_d, inout SurfaceOutput o)
	fixed shadowFactor = Shadow_Light(QT_ShadowUV_NL_Depth, cos, s);
	//if (shadowFactor > 0)
	//{
	//	shadowFactor = 0;
	//}
	//else
	//{
	//	shadowFactor = 1;
	//}
	//fixed shadowFactor = max(0, sign(s.Specular));
#endif

	fixed4 c;
#ifdef QT_ROLE_SHADOW_ON
	c.rgb = (BRDF_k1 * s.Albedo * _LightColor0.rgb * ((brdfdiff *( 1-shadowFactor)) + (shadowFactor)*shadowAlpha) + BRDF_k2 * _LightColor0.rgb * spec * (1 - shadowFactor)) * (atten * 2);
	//c.rgb = (BRDF_k1 * s.Albedo * _LightColor0.rgb * ((brdfdiff * shadowFactor) + (1-shadowFactor)*shadowAlpha) + BRDF_k2 * _LightColor0.rgb * spec * shadowFactor) * (atten * 2);
#else
	c.rgb = (BRDF_k1 * s.Albedo * _LightColor0.rgb * brdfdiff + BRDF_k2 * _LightColor0.rgb * spec) * (atten * 2);
#endif
	c.a = s.Alpha +spec * specEnhanceOqapue;

	//c.a = 1;
	//c.rgb = shadowFactor;
	//c.rgb = s.Specular;
	//c.rgb = shadowFactor;
	return c;
}


//##################################  各种效果  ##################################

//------------------------------------------------------- 雾效 -------------------------------------------------------
fixed4 _FogColor;
fixed _FogPower;
fixed2 Fog_StartPro;   //Fog_StartPro.x : fog的开始比例，数值代表物体与相机的距离，除以远平面. Fog_StartPro.y : 1/(1 - Fog_StartPro)

#ifdef QT_FOG_ON
inline void Fog_Vertex(inout appdata_full v, inout Input data)
{
	data.depthValue = COMPUTE_DEPTH_01;
}

inline void Fog_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
{
	fixed depth = saturate((IN.depthValue - Fog_StartPro.x) * Fog_StartPro.y);/// (1 - Fog_StartPro));
	fixed fogP = _FogPower * depth;
	fixed f = exp(-fogP*fogP);// pow(2.7, -pow(_FogPower * depth, 2));
	f = saturate(f);
	color.rgb = color.rgb * f + _FogColor.rgb * (1-f);
}
#endif



//------------------------------------------------------- 实时点光源 -------------------------------------------------------
fixed4 QT_4LightPosX0;
fixed4 QT_4LightPosY0;
fixed4 QT_4LightPosZ0;
fixed4 QT_4LightAtten0;
float4x4 QT_LightColor;

#ifdef QT_SCENE_POINT_LIGHT_G0_ON
inline void PointLight_Vertex(inout appdata_full v, inout Input data)
{
	fixed4 worldPos = mul(unity_ObjectToWorld,v.vertex);
	fixed3 worldSpaceN = mul((float3x3)unity_ObjectToWorld, v.normal.xyz);
	data.vlight = Shade4PointLights (
		QT_4LightPosX0, QT_4LightPosY0, QT_4LightPosZ0,
		QT_LightColor[0].rgb, QT_LightColor[1].rgb, QT_LightColor[2].rgb, QT_LightColor[3].rgb,
		QT_4LightAtten0, worldPos, worldSpaceN );
}

inline void PointLight_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
{
	color.rgb += o.Albedo.rgb * IN.vlight;
}
#endif


//------------------------------------------------------- 自发光特效 -------------------------------------------------------
sampler2D _SSSTex;
fixed _SSSWeight;

#ifdef QT_TEXILLUMIN_ON
inline void TexIllumin_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
{
	fixed4 sssColor = tex2D(_SSSTex,IN.uv_MainTex);
	color.rgb += sssColor.rgb * _SSSWeight;
}
#endif

//------------------------------------------------------- 坦克履带 -------------------------------------------------------
#ifdef QT_TANK_WHEEL
//fixed TankWheelSpeed;

//inline void TankWheel_Vertex(inout appdata_full v, inout Input data)
//{
//	fixed wheelCoe = saturate(-(v.color.r - 0.99));
//	v.texcoord.y += fmod(TankWheelSpeed * _Time.y * 0.1, 0.05) * wheelCoe;
//}

#endif

//------------------------------------------------------- 坦克履带 -------------------------------------------------------
#ifdef QT_TANK_SCAN
fixed TankScanMaxHigh;
fixed TankScanValue;
inline void TankScan_Vertex(inout appdata_full v, inout Input data)
{
	data.unitScanValue = v.vertex.z;
}

inline void TankScan_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
{
	clip(TankScanValue - IN.unitScanValue / TankScanMaxHigh);
	//color.rgb += o.Albedo.rgb * IN.vlight;
}
#endif


//------------------------------------------------------- 静态物体实时光 -------------------------------------------------------
fixed3 LightMap_DirLight;  //lightmap下，主光源位置
fixed LightMap_RealHighLightScale;  //lightmap下，高光强度缩放
fixed LightMap_AdjustDiff; //lightmap下，调整漫反射颜色
fixed4 BlinnPhong_Shininess;
half4 LightMap_LightColor;   //高光颜色

#ifdef QT_STATIC_REALTIME_LIGHT_ON

fixed Lightmap_finalShininess;
fixed4 DetailNormalScale; //细节法线缩放系数

inline fixed4 LightingQT_LMBlinnPhong(SurfaceOutput s, fixed3 normal, half3 viewDir, fixed3 lightDir)
{
	fixed3 h = normalize(lightDir + viewDir);

	fixed nh = max(0, dot(normal, h));

	fixed simpleFresnel = pow(nh, Lightmap_finalShininess*128.0);

	fixed spec = simpleFresnel * s.Specular;

	fixed4 c;
	c.rgb = LightMap_LightColor.rgb * spec;
	c.a = 1;//(0.8 + max(0, pow(simpleFresnel, 2))); //(pow(simpleFresnel, 0.5) + 0.05) * 10;
	//c.a = simpleFresnel;
	//c.rgb = simpleFresnel;
	return c;
}


inline void StaticRealtimeLight_Vertex(inout appdata_full v, inout Input data)
{
	//data.LightMap_LightDir = LightMap_DirLight;// mul ((float3x3)lRotation, mul((float3x3)_World2Object, LightMap_DirLight));

	//计算顶点在世界空间中到相机的方向向量
	data.LightMap_ViewDir = normalize(WorldSpaceViewDir(v.vertex));
	//计算模型法线
	data.MeshNormal = normalize(mul((float3x3)(unity_ObjectToWorld), v.normal));
}

inline void StaticRealtimeLight_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
{
//#ifdef LIGHTMAP_ON
	fixed4 dirColor = fixed4(0,0,0,1);
	//模型法线与光线cos
	fixed cosMeshN = dot(IN.MeshNormal, LightMap_DirLight.xyz);
	//贴图法线与光线cos
	fixed cosN = dot(o.Normal, LightMap_DirLight.xyz);

	//漫反射法线补差
	fixed sub = cosN - cosMeshN;
#ifdef QT_STATIC_REALTIME_HIGHLIGHT_ON
	//计算高光
	dirColor = LightingQT_LMBlinnPhong(o, o.Normal, IN.LightMap_ViewDir, LightMap_DirLight.xyz);

	//计算调整后颜色
	color.rgb = color.rgb
		+ color.rgb * sub * LightMap_AdjustDiff   //光照贴图漫反射调整
		+ dirColor.rgb * LightMap_RealHighLightScale;  //实时光高光叠加
	color.a = dirColor.a;
#else
	//计算调整后颜色
	color.rgb = color.rgb
		+ color.rgb * sub * LightMap_AdjustDiff;   //光照贴图漫反射调整
#endif

	//color.rgb = o.Normal;

	//color = float4(1, 0, 0, 1);
//#endif
//
//#ifdef LIGHTMAP_OFF
//	fixed4 dirColor = fixed4(0, 0, 0, 1);
//	dirColor = LightingQT_LMBlinnPhong(o, o.Normal, IN.LightMap_ViewDir, _WorldSpaceLightPos0.xyz);
//	color.rgb = color.rgb
//		+ dirColor * LightMap_RealHighLightScale; 
//	color.a = dirColor.a;
//
//	color = float4(0, 1, 0, 1);
//#endif

	//color = dirColor;//fixed4(1, 1, 1, 1);
}

#endif

//------------------------------------------------------- 角色环境反射 -------------------------------------------------------
samplerCUBE _ReflectCubeTex;
fixed _RoleReflectDiffWeight;
fixed _RoleReflectEnvWeight;
fixed _GlobalReflectIntensity;

#ifdef QT_ROLE_REFLECT_ON

inline void ReloReflectEnv_Vertex(inout appdata_full v, inout Input data)
{
	fixed3 cryViewDir = -ObjSpaceViewDir(v.vertex);
	fixed3 cryViewRefl = reflect (cryViewDir, v.normal);
	data.reflectCoord = mul ((float3x3)unity_ObjectToWorld, cryViewRefl);
}

inline void ReloReflectEnv_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
{
	//fixed4 refMask = tex2D(_AlphaTex,IN.uv_MainTex);
	fixed4 reflcol = 0;
	fixed4 refracol = 0;
	
	fixed lod = UNITY_SPECCUBE_LOD_STEPS*(1-o.Gloss);
	
	//fixed4 c1 = texCUBElod(_ReflectCubeTex, fixed4(IN.reflectCoord, ceil(lod)));
	//fixed4 c2 = texCUBElod(_ReflectCubeTex, fixed4(IN.reflectCoord, floor(lod)));
	//fixed tempLod = frac(lod);
	//reflcol = c1 *tempLod + c2 * (1 - tempLod);

	reflcol = texCUBE(_ReflectCubeTex, IN.reflectCoord);

	//fixed roleRefDiffW = _RoleReflectDiffWeight / (_RoleReflectDiffWeight + saturate(refMask.a - 0.51));
	//color.rgb = color.xyz * roleRefDiffW + Luminance(reflcol.xyz) * color.rgb * (1-roleRefDiffW) * _RoleReflectEnvWeight;
	color.rgb = color.xyz * _RoleReflectDiffWeight + reflcol.xyz * color.rgb * _GlobalReflectIntensity * _RoleReflectEnvWeight *o.Gloss;

	//color.rgb = reflcol;
	//color.rgb = reflcol.xyz * color.rgb * _GlobalReflectIntensity * _RoleReflectEnvWeight *o.Gloss;
}
#else
inline void ReloReflectEnv_Pixel(inout fixed4 color)
{

	color.rgb = color.xyz * _RoleReflectDiffWeight;

}
#endif


//------------------------------------------------------- 棕榈树摇摆 -------------------------------------------------------

#ifdef QT_PLAM_TREE_WIND_ON
float PlamWindWave(float _A, float _w, float _phase)
{
	return _A * sin(_phase + _w * _Time.y)*cos(_phase + 0.5*_w*_Time.y);
	//return _A * sin(_phase + _w*_Time.y);
}

float3 PlamTreeMainBend(float3 _worldPos, float2 _windDir, float _tenacity, float _intensity, float _A, float _w, float _phase)
{
	//_worldPos.xz += _windDir.xy * _tenacity * _intensity;
	//return _worldPos;
	_phase = _phase * (6.28 / _w);
	float offset = PlamWindWave(_A,_w, _phase);
	_worldPos.xz += _windDir.xy * _tenacity * (_intensity + offset * _intensity);
	return _worldPos;
}

float3 PlamTreeBoughBend(float3 _worldPos, float _tenacity, float _intensity, float _A, float _w, float _phase)
{
	_phase = _phase * (6.28 / _w);
	float offset =  PlamWindWave(_A,_w, _phase);
	//_objPos.xyz += _objNormal * _tenacity * _intensity * offset;
	_worldPos.y +=  _tenacity * _intensity * offset;
	return _worldPos;
}

float3 PlamTreeLeafBend(float3 _worldPos, float3 _worldNormal, float _tenacity, float _intensity, float _A, float _w, float _phase)
{
	_phase = _phase * (6.28 / _w);
	float offset =  PlamWindWave(_A,_w, _phase);
	_worldPos.xz += _worldNormal.xz * _tenacity * _intensity * offset;
	return _worldPos;
}

inline void PlamTree_Vertex(inout appdata_full v, inout Input data)
{
	float3 treePos = float3(unity_ObjectToWorld[0].w, unity_ObjectToWorld[1].w, unity_ObjectToWorld[2].w); 
	fixed4 worldPos = mul(unity_ObjectToWorld,v.vertex);
	fixed3 worldNormal = mul(unity_ObjectToWorld, v.vertex);
	fixed pasheOffset = 0;//fmod((treePos.x + treePos.z),6.28);
	tree_WindRate = clamp(tree_WindRate, 0.01, 1000);
	tree_WindIntensity *= tree_WindScale;
	worldPos.xyz = PlamTreeLeafBend(worldPos, worldNormal,v.color.r, tree_WindIntensity/300, tree_WindSwing, tree_WindRate, v.color.g + pasheOffset);
	worldPos.xyz = PlamTreeBoughBend(worldPos, v.color.b, tree_WindIntensity * 1.5, tree_WindSwing,tree_WindRate, v.color.g + pasheOffset);
	worldPos.xyz = PlamTreeMainBend(worldPos, tree_WindDir.xy, v.color.a, tree_WindIntensity, tree_WindSwing, tree_WindRate, pasheOffset);

	v.vertex = mul(unity_WorldToObject, worldPos);
}

#endif

#ifdef QT_BILLBOARD_TREE_WIND_ON
//fixed tree_WindScale;
float BTreeWindWave(float _A, float _w, float _phase)
{
	return _A * sin(_phase + _w * _Time.y)*cos(_phase + 0.5*_w*_Time.y);
	//return _A * sin(_phase + _w*_Time.y);
}

inline void BillboardTreeWind_Vertex(inout appdata_full v, inout Input data)
{
	fixed4 worldPos = mul(unity_ObjectToWorld, v.vertex);
	float wave = BTreeWindWave(tree_WindSwing, tree_WindRate, 0);
	worldPos.xyz = worldPos + v.color.a * fixed3(tree_WindDir.x, 0, tree_WindDir.y) * wave * tree_WindScale;
	v.vertex = mul(unity_WorldToObject, worldPos);
	//v.vertex = 0;
}
#endif

//------------------------------------------------------- 海洋波浪 -------------------------------------------------------

float OW_A1;
float4 OW_D1;
float OW_w1;
float OW_phi1;
float OW_k1;
float OW_A2;
float4 OW_D2;
float OW_w2;
float OW_phi2;
float OW_k2;
float OW_A3;
float4 OW_D3;
float OW_w3;
float OW_phi3;
float OW_k3; 

#ifdef QT_OCEAN_WAVE_ON
	float WaveH2(float x,float y,float t,float A, float4 D, float w, float phi, float k)
	{
		return 2 * A * pow(((sin(dot(normalize(D).xy, float2(x,y))* w + t * phi) + 1) / 2), k);
	}

	float3 WaveN2(float x,float y,float t,float A, float4 D, float w, float phi, float k)
	{
		float3 nd = normalize(D.xyz);
		float tempSinMid = (sin(dot(nd, float2(x,y)) * w + t * phi) + 1) / 2;
		tempSinMid = pow(tempSinMid,k-1);
		float tempCosMid = cos(dot(nd,float2(x,y)) * w + t * phi);
		float Q = k * w * A;
		//float dx = k * nd.x * w * A * pow(tempSinMid,k-1) * tempCosMid;
		//float dy = k * nd.y * w * A * pow(tempSinMid,k-1) * tempCosMid;
		float dx = Q * nd.x * tempSinMid * tempCosMid;
		float dy = Q * nd.y * tempSinMid * tempCosMid;
		float3 n = normalize((float3(-dx,-dy,1)));
		return n;
	}

	inline void OceanWave_Vertex(inout appdata_full v, inout Input data)
	{
	//求顶点位置
		v.vertex.z = WaveH2(v.vertex.x,v.vertex.y,_Time.y, OW_A1,OW_D1,OW_w1,OW_phi1,OW_k1);
		v.vertex.z += WaveH2(v.vertex.x,v.vertex.y,_Time.y, OW_A2,OW_D2,OW_w2,OW_phi2,OW_k2);
		v.vertex.z += WaveH2(v.vertex.x,v.vertex.y,_Time.y, OW_A3,OW_D3,OW_w3,OW_phi3,OW_k3);

		//求法线
		v.normal = WaveN2(v.vertex.x,v.vertex.y,_Time.y, OW_A1,OW_D1,OW_w1,OW_phi1,OW_k1);
		v.normal += WaveN2(v.vertex.x,v.vertex.y,_Time.y, OW_A2,OW_D2,OW_w2,OW_phi2,OW_k2);
		v.normal += WaveN2(v.vertex.x,v.vertex.y,_Time.y, OW_A3,OW_D3,OW_w3,OW_phi3,OW_k3);
		//求切线
		v.tangent = float4(normalize(float3(0,1,-v.normal.y)),1);
	}

#ifdef QT_SIMPLE_OCEAN_WAVE_ON
	//pos 坐标位置
	//t 时间
	//A 振幅
	//D 方向
	//w 周期
	//k 幂数，波形控制参数
	float SimpleWaveH2(float2 pos, float t, float A, float4 D, float w, float phi, float k)
	{
		//float toP = normlized(pos);
		//float dis = dot(normlized(D), pos);
		//float result = pow(A * (sin(w * t) + 1), k);
		//float result = A * (sin(w * t) + 1);

		D = normalize(D);
		float dis = dot(D, pos);
		//float result = pow(A * (sin(w * t) + 1), k);
		//float high = A * (sin(w * (dis + t * phi)) + 1);
		float high = A * (sin(w * (dis)) + 1);
		return high;
	}

	float3 SimpleWaveN2(float2 pos, float t, float A, float4 D, float w, float phi, float k)
	{
		float dis = dot(D, pos);
		float s = dis + phi * t;
		//float diff = A * (cos(w * t) + 1);
		//float diff = A * cos(w * dis) * w;// //A * (cos(w * s) + 1) + w;
		float diff = sin(w * dis) * cos(w * dis) * w;
		//diff = cos(pos.x * 360);

		float3 n = float3(0, 1, 0);
		float3 bn = cross(D, n);

		float3 D2 = sign(diff) * D;

		D2.y = diff;

		float3 n2 = cross(D2, bn);

		//return float3(abs(diff / 20), 0, 0);
		//return normalize(n2);

		//n2 = normalize(n2);
		//n2.z = 0;
		//n2.x = 0;//abs(n2.x);
		//n2.y = 0;//abs(n2.y);
		return abs(normalize(n2));
	}

	inline void SimpleOceanWave_Vertex(inout appdata_full v, inout Input data)
	{
		//求顶点位置
		v.vertex.z = WaveH2(v.texcoord.x, v.texcoord.y, _Time.y, OW_A1, OW_D1, OW_w1, OW_phi1, OW_k1);
		/*v.vertex.z += WaveH2(v.vertex.x, v.vertex.y, _Time.y, OW_A2, OW_D2, OW_w2, OW_phi2, OW_k2);
		v.vertex.z += WaveH2(v.vertex.x, v.vertex.y, _Time.y, OW_A3, OW_D3, OW_w3, OW_phi3, OW_k3);*/

		//求法线
		v.normal = WaveN2(v.vertex.x, v.vertex.y, _Time.y, OW_A1, OW_D1, OW_w1, OW_phi1, OW_k1);
		/*v.normal += WaveN2(v.vertex.x, v.vertex.y, _Time.y, OW_A2, OW_D2, OW_w2, OW_phi2, OW_k2);
		v.normal += WaveN2(v.vertex.x, v.vertex.y, _Time.y, OW_A3, OW_D3, OW_w3, OW_phi3, OW_k3);*/
		//求切线
		v.tangent = float4(normalize(float3(0, 1, -v.normal.y)), 1);
	}
#endif
#endif

//------------------------------------------------------- 海洋反射 -------------------------------------------------------

	fixed3 TanSpaceNormal;
	fixed ReflectUVOffsetForNormal;

#ifdef QT_PLANE_REFLECT_ON
	inline void PlaneReflect_Vertex(inout appdata_full v, inout Input data)
	{
	/*	float4x4 oceanRefProj;
		oceanRefProj = mul(mirrorMatrix_VP, unity_ObjectToWorld);
		half4 oceanRefUV = mul(oceanRefProj, v.vertex);
		data.mirrorUV = 0.5* oceanRefUV.xy / oceanRefUV.w + half2(0.5,0.5);*/

		data.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
		//half4 oceanRefractUV = mul (UNITY_MATRIX_MVP, v.vertex);
		//data.refractUV = 0.5* oceanRefractUV.xy / oceanRefractUV.w + half2(0.5,0.5);
	}

	//inline void PlaneReflect_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
	//{
	//	fixed4 mirrorMask = tex2D(_AlphaTex,IN.uv_MainTex);
	//	//IN.mirrorUV += o.Normal.xz * 0.03;
	//	half4 oceanRefUV = mul(mirrorMatrix_VP, IN.worldPos);
	//	fixed2 mirrorUV = 0.5* oceanRefUV.xy / oceanRefUV.w + half2(0.5, 0.5);

	//	fixed4 mirrorCol = tex2D(_ReflectTex, mirrorUV);
	//	//IN.refractUV += o.Normal.xz * 0.05;
	//	//fixed4 refractCol = tex2D(_RefractTex, IN.refractUV);
	//	fixed oceanMask = saturate(mirrorMask.b - 0.51);

	//	//fixed3 ocean_lightdir = _WorldSpaceLightPos0;
	//	fixed ocean_diff = (dot (o.Normal, _WorldSpaceLightPos0) + 1) / 2;
	//	fixed3 ocean_brdfColor = tex2D(_BRDFMap, fixed2(ocean_diff,0));
	//	fixed reflectRate = ocean_brdfColor.g;
	//	//fixed refractRate = 1- ocean_brdfColor.g;

	//	color.rgb = color.xyz * _PR_DiffWeight 
	//		+ mirrorCol.xyz * color.rgb * _PR_ReflectWeight * oceanMask * reflectRate;
	//	color.a = o.Alpha;
	//	//color.rgb = mirrorCol.rgb;
	//		//+ refractCol.xyz * color.rgb * _OceanRefractWeight * oceanMask * refractRate;
	//}

	inline void PlaneGroundReflect_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
	{
		//镜面遮罩
		fixed4 mirrorMask = tex2D(_AlphaTex, IN.uv_MainTex);
		//反射UV
		half4 oceanRefUV = mul(mirrorMatrix_VP, float4(IN.worldPos + fixed3(TanSpaceNormal.x,0,TanSpaceNormal.y) * ReflectUVOffsetForNormal,1));
		fixed2 mirrorUV = 0.5* oceanRefUV.xy / oceanRefUV.w + half2(0.5, 0.5);

		fixed4 mirrorCol = tex2D(_ReflectTex, mirrorUV);

		color = _PR_DiffWeight * color + _PR_ReflectWeight * mirrorCol * mirrorMask.r;
	}
#endif


//------------------------------------------------------- 广告版树 -------------------------------------------------------
	//相机到世界的旋转矩阵，用于使叶片拥有与相机相同的旋转
	float4x4 _BillLeafCameraToWorld;
	float4x4 _BillBoleCameraToWorld;

#ifdef QT_BILLBOARD_TREE_ON

	inline void BillboardTree_Vertex(inout appdata_full v, inout Input data)
	{
	/*	fixed3 cryViewDir = -ObjSpaceViewDir(v.vertex);
		fixed3 cryViewRefl = reflect(cryViewDir, v.normal);
		data.reflectCoord = mul((float3x3)unity_ObjectToWorld, cryViewRefl);*/

		///当前位置的世界坐标
		fixed3 worldPos = mul(unity_ObjectToWorld, v.vertex);
		//局部坐标到世界坐标的位移
		fixed3 old2newPos = worldPos - v.tangent.xyz;

		float4x4 myObj2World = float4x4
			(1, 0, 0, old2newPos.x,
				0, 1, 0, old2newPos.y,
				0, 0, 1, old2newPos.z,
				0, 0, 0, 1);

		float4x4 billM44_1 = mul(myObj2World, _BillLeafCameraToWorld);
		float4x4 billM44_2 = mul(myObj2World, _BillBoleCameraToWorld);

		/*billM44_1 = mul(UNITY_MATRIX_VP, billM44_1);
		billM44_2 = mul(UNITY_MATRIX_VP, billM44_2);*/

		v.vertex = mul(billM44_1, fixed4(v.tangent.xyz, 1)) * v.tangent.w + mul(billM44_2, fixed4(v.tangent.xyz, 1)) * (1 - v.tangent.w);

		v.vertex = mul(unity_WorldToObject, v.vertex);

		//v.normal = mul(billM44_1, v.normal) * v.tangent.w + mul(billM44_2, v.normal) * (1 - v.tangent.w);
		//v.normal = mul(unity_WorldToObject, v.normal);

		//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
	}

#endif

////
//#ifdef QT_EDGE_LIGHT_ON
//	inline void PlaneReflect_Vertex(inout appdata_full v, inout Input data)
//	{
//		float3 viewDir = normalize(WorldSpaceViewDir(vertex));
//		float3 lightDir = normalize(WorldSpaceLightDir(vertex));
//	}

//	inline void PlaneReflect_Pixel(inout Input IN, inout SurfaceOutput o, inout fixed4 color)
//	{
//	}

//#endif











///////////////////////////////////////////////////////////////////////////////////////////////////////
inline fixed4 FinalColor(fixed4 _color)
{
	return _color;
}