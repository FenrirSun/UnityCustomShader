Shader "VX/Scene New/Water Effect" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Color Map(RGB)", 2D) = "white" {}
 _FXTex ("Distortion Map(Normal)", 2D) = "black" {}
 _DScale ("Distortion Scale", Float) = 0.3
 _DPower ("Distortion Power", Float) = 0.02
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  _glesFragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (texcol_1.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (texcol_1.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  _glesFragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_2.xyz;
  tmpvar_11 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_1.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_1.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_1.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 * ((
    (_World2Object * tmpvar_13)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  lowp vec4 texcol_4;
  mediump float Pow_5;
  mediump vec2 ColMapUV_6;
  lowp vec4 DScaleMap_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_7.w = tmpvar_9.w;
  DScaleMap_7.xyz = ((tmpvar_9.xyz * 2.0) - 1.0);
  DScaleMap_7.xyz = normalize(DScaleMap_7.xyz);
  lowp vec2 tmpvar_10;
  tmpvar_10 = DScaleMap_7.xy;
  ColMapUV_6 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump vec2 P_13;
  P_13 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  tmpvar_12 = texture2D (_MainTex, P_13);
  texcol_4.w = tmpvar_12.w;
  texcol_4.xyz = (tmpvar_12.xyz * _Color.xyz);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_1 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * tmpvar_12.w) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_17;
  finalColor_8 = specColor_3;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_8 + (texcol_4.xyz * tmpvar_14));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  gl_FragData[0] = tmpvar_19;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_2.xyz;
  tmpvar_11 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_1.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_1.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_1.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 * ((
    (_World2Object * tmpvar_13)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  lowp vec4 texcol_4;
  mediump float Pow_5;
  mediump vec2 ColMapUV_6;
  lowp vec4 DScaleMap_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_7.w = tmpvar_9.w;
  DScaleMap_7.xyz = ((tmpvar_9.xyz * 2.0) - 1.0);
  DScaleMap_7.xyz = normalize(DScaleMap_7.xyz);
  lowp vec2 tmpvar_10;
  tmpvar_10 = DScaleMap_7.xy;
  ColMapUV_6 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump vec2 P_13;
  P_13 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  tmpvar_12 = texture (_MainTex, P_13);
  texcol_4.w = tmpvar_12.w;
  texcol_4.xyz = (tmpvar_12.xyz * _Color.xyz);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_1 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * tmpvar_12.w) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_17;
  finalColor_8 = specColor_3;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_8 + (texcol_4.xyz * tmpvar_14));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  _glesFragData[0] = tmpvar_19;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (texcol_1.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_2.xyz;
  tmpvar_11 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_1.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_1.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_1.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 * ((
    (_World2Object * tmpvar_13)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  lowp vec4 texcol_4;
  mediump float Pow_5;
  mediump vec2 ColMapUV_6;
  lowp vec4 DScaleMap_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_7.w = tmpvar_9.w;
  DScaleMap_7.xyz = ((tmpvar_9.xyz * 2.0) - 1.0);
  DScaleMap_7.xyz = normalize(DScaleMap_7.xyz);
  lowp vec2 tmpvar_10;
  tmpvar_10 = DScaleMap_7.xy;
  ColMapUV_6 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump vec2 P_13;
  P_13 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  tmpvar_12 = texture2D (_MainTex, P_13);
  texcol_4.w = tmpvar_12.w;
  texcol_4.xyz = (tmpvar_12.xyz * _Color.xyz);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_1 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * tmpvar_12.w) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_17;
  finalColor_8 = specColor_3;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_8 + (texcol_4.xyz * tmpvar_14));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  gl_FragData[0] = tmpvar_19;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  _glesFragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  _glesFragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (texcol_1.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (texcol_1.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  _glesFragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_2.xyz;
  tmpvar_11 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_1.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_1.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_1.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 * ((
    (_World2Object * tmpvar_13)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  lowp vec4 texcol_4;
  mediump float Pow_5;
  mediump vec2 ColMapUV_6;
  lowp vec4 DScaleMap_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_7.w = tmpvar_9.w;
  DScaleMap_7.xyz = ((tmpvar_9.xyz * 2.0) - 1.0);
  DScaleMap_7.xyz = normalize(DScaleMap_7.xyz);
  lowp vec2 tmpvar_10;
  tmpvar_10 = DScaleMap_7.xy;
  ColMapUV_6 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump vec2 P_13;
  P_13 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  tmpvar_12 = texture2D (_MainTex, P_13);
  texcol_4.w = tmpvar_12.w;
  texcol_4.xyz = (tmpvar_12.xyz * _Color.xyz);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_1 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * tmpvar_12.w) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_17;
  finalColor_8 = specColor_3;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_8 + (texcol_4.xyz * tmpvar_14));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  gl_FragData[0] = tmpvar_19;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_2.xyz;
  tmpvar_11 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_1.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_1.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_1.z;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 * ((
    (_World2Object * tmpvar_13)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  lowp vec4 texcol_4;
  mediump float Pow_5;
  mediump vec2 ColMapUV_6;
  lowp vec4 DScaleMap_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_7.w = tmpvar_9.w;
  DScaleMap_7.xyz = ((tmpvar_9.xyz * 2.0) - 1.0);
  DScaleMap_7.xyz = normalize(DScaleMap_7.xyz);
  lowp vec2 tmpvar_10;
  tmpvar_10 = DScaleMap_7.xy;
  ColMapUV_6 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump vec2 P_13;
  P_13 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  tmpvar_12 = texture (_MainTex, P_13);
  texcol_4.w = tmpvar_12.w;
  texcol_4.xyz = (tmpvar_12.xyz * _Color.xyz);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_2 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_1 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * tmpvar_12.w) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_17;
  finalColor_8 = specColor_3;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_8 + (texcol_4.xyz * tmpvar_14));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  _glesFragData[0] = tmpvar_19;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture2D (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  gl_FragData[0] = tmpvar_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 texcol_1;
  mediump float Pow_2;
  mediump vec2 ColMapUV_3;
  lowp vec4 DScaleMap_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_4.w = tmpvar_5.w;
  DScaleMap_4.xyz = ((tmpvar_5.xyz * 2.0) - 1.0);
  DScaleMap_4.xyz = normalize(DScaleMap_4.xyz);
  lowp vec2 tmpvar_6;
  tmpvar_6 = DScaleMap_4.xy;
  ColMapUV_3 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  mediump vec2 P_9;
  P_9 = ((ColMapUV_3 * Pow_2) + xlv_TEXCOORD0);
  tmpvar_8 = texture (_MainTex, P_9);
  texcol_1.w = tmpvar_8.w;
  texcol_1.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = texcol_1.xyz;
  _glesFragData[0] = tmpvar_10;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }
}
Fallback Off
}