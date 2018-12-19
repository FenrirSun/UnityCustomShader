Shader "VX/Scene New/Water Effect RGB" {
Properties {
 _FogAlpha ("Fog Alpha", Range(0,1)) = 1
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Color Map(RGB)", 2D) = "white" {}
 _MainAlpha ("Main Alpha(G)", 2D) = "black" {}
 _FXTex ("Distortion Map(Normal)", 2D) = "black" {}
 _DScale ("Distortion Scale", Float) = 0.3
 _DPower ("Distortion Power", Float) = 0.02
 _ReflectTex ("Reflection Map", 2D) = "black" {}
 _ReflectLevel ("Reflection Level", Range(0,1)) = 0.5
 _ReflectDist ("Reflection Distortion", Float) = 1
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_8, tmpvar_8));
  tmpvar_10.y = cse_9.y;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_11 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_21;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_8, tmpvar_8));
  tmpvar_10.y = cse_9.y;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_11 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_21;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_2.xyz;
  tmpvar_12 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_1.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_1.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_1.z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * ((
    (_World2Object * tmpvar_14)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec4 cse_17;
  cse_17 = (_Object2World * _glesVertex);
  tmpvar_16 = (_WorldSpaceCameraPos - cse_17.xyz);
  highp vec2 tmpvar_18;
  tmpvar_18.x = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_18.y = cse_17.y;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_19[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_19[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = (((
    (((tmpvar_7.xy / tmpvar_7.w) + (normalize(
      (tmpvar_19 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (finalColor_11, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_28;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_2.xyz;
  tmpvar_12 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_1.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_1.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_1.z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * ((
    (_World2Object * tmpvar_14)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec4 cse_17;
  cse_17 = (_Object2World * _glesVertex);
  tmpvar_16 = (_WorldSpaceCameraPos - cse_17.xyz);
  highp vec2 tmpvar_18;
  tmpvar_18.x = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_18.y = cse_17.y;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_19[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_19[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = (((
    (((tmpvar_7.xy / tmpvar_7.w) + (normalize(
      (tmpvar_19 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (finalColor_11, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_28;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_8, tmpvar_8));
  tmpvar_10.y = cse_9.y;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_11 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_21;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_2.xyz;
  tmpvar_12 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_1.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_1.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_1.z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * ((
    (_World2Object * tmpvar_14)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec4 cse_17;
  cse_17 = (_Object2World * _glesVertex);
  tmpvar_16 = (_WorldSpaceCameraPos - cse_17.xyz);
  highp vec2 tmpvar_18;
  tmpvar_18.x = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_18.y = cse_17.y;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_19[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_19[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = (((
    (((tmpvar_7.xy / tmpvar_7.w) + (normalize(
      (tmpvar_19 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (finalColor_11, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_28;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_8, tmpvar_8));
  tmpvar_10.y = cse_9.y;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_11 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_21;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_8, tmpvar_8));
  tmpvar_10.y = cse_9.y;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_10;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_11 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_21;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_2.xyz;
  tmpvar_12 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_1.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_1.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_1.z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * ((
    (_World2Object * tmpvar_14)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec4 cse_17;
  cse_17 = (_Object2World * _glesVertex);
  tmpvar_16 = (_WorldSpaceCameraPos - cse_17.xyz);
  highp vec2 tmpvar_18;
  tmpvar_18.x = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_18.y = cse_17.y;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_19[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_19[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = (((
    (((tmpvar_7.xy / tmpvar_7.w) + (normalize(
      (tmpvar_19 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (finalColor_11, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_28;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_11 = tmpvar_2.xyz;
  tmpvar_12 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11.x;
  tmpvar_13[0].y = tmpvar_12.x;
  tmpvar_13[0].z = tmpvar_1.x;
  tmpvar_13[1].x = tmpvar_11.y;
  tmpvar_13[1].y = tmpvar_12.y;
  tmpvar_13[1].z = tmpvar_1.y;
  tmpvar_13[2].x = tmpvar_11.z;
  tmpvar_13[2].y = tmpvar_12.z;
  tmpvar_13[2].z = tmpvar_1.z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * ((
    (_World2Object * tmpvar_14)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_15;
  highp vec3 tmpvar_16;
  highp vec4 cse_17;
  cse_17 = (_Object2World * _glesVertex);
  tmpvar_16 = (_WorldSpaceCameraPos - cse_17.xyz);
  highp vec2 tmpvar_18;
  tmpvar_18.x = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_18.y = cse_17.y;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_19[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_19[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_18;
  xlv_TEXCOORD5 = (((
    (((tmpvar_7.xy / tmpvar_7.w) + (normalize(
      (tmpvar_19 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (finalColor_11, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_28;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp vec2 tmpvar_8;
  tmpvar_8.x = sqrt(dot (tmpvar_6, tmpvar_6));
  tmpvar_8.y = cse_7.y;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_9[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_9[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (((
    (((tmpvar_3.xy / tmpvar_3.w) + (normalize(
      (tmpvar_9 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform highp float _FogAlpha;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (finalColor_8, _FogColor.xyz, vec3(((
    max (clamp (((xlv_TEXCOORD4.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0), clamp (((xlv_TEXCOORD4.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0))
   * _FogColor.w) * _FogAlpha)));
  ret_1.xyz = tmpvar_20;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_9;
  highp vec4 cse_10;
  cse_10 = (_Object2World * _glesVertex);
  tmpvar_9 = (_WorldSpaceCameraPos - cse_10.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_10.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_4.w = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_12 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_9;
  highp vec4 cse_10;
  cse_10 = (_Object2World * _glesVertex);
  tmpvar_9 = (_WorldSpaceCameraPos - cse_10.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_10.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_4.w = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_12 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (_WorldSpaceCameraPos - cse_18.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_18.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_7.w = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_20[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_20[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_20 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (_WorldSpaceCameraPos - cse_18.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_18.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_7.w = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_20[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_20[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_20 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_9;
  highp vec4 cse_10;
  cse_10 = (_Object2World * _glesVertex);
  tmpvar_9 = (_WorldSpaceCameraPos - cse_10.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_10.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_4.w = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_12 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (_WorldSpaceCameraPos - cse_18.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_18.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_7.w = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_20[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_20[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_20 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_9;
  highp vec4 cse_10;
  cse_10 = (_Object2World * _glesVertex);
  tmpvar_9 = (_WorldSpaceCameraPos - cse_10.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_10.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_4.w = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_12 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_9;
  highp vec4 cse_10;
  cse_10 = (_Object2World * _glesVertex);
  tmpvar_9 = (_WorldSpaceCameraPos - cse_10.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_10.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_4.w = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_12 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (_WorldSpaceCameraPos - cse_18.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_18.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_7.w = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_20[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_20[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_20 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (_WorldSpaceCameraPos - cse_18.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_18.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_7.w = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_20[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_20[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_20 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (max (
    clamp (((sqrt(
      dot (tmpvar_7, tmpvar_7)
    ) - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((cse_8.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogAlpha));
  tmpvar_3.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_4.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_4.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_7.w = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_18[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_18[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_18 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_7.w = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_18[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_18[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_18 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_4.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_7.w = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_18[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_18[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_18 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_4.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture2D (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_8;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_4.w = tmpvar_9;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_10[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_10[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD5 = (((
    (((tmpvar_5.xy / tmpvar_5.w) + (normalize(
      (tmpvar_10 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texcol_4.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_16 = texture (_ReflectTex, P_17);
  mediump vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_16 * _ReflectLevel);
  texreflect_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_15 + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_8;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_7.w = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_18[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_18[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_18 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture2D (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
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
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_4 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_5 = tmpvar_11;
  highp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_12 = tmpvar_2.xyz;
  tmpvar_13 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12.x;
  tmpvar_14[0].y = tmpvar_13.x;
  tmpvar_14[0].z = tmpvar_1.x;
  tmpvar_14[1].x = tmpvar_12.y;
  tmpvar_14[1].y = tmpvar_13.y;
  tmpvar_14[1].z = tmpvar_1.y;
  tmpvar_14[2].x = tmpvar_12.z;
  tmpvar_14[2].y = tmpvar_13.z;
  tmpvar_14[2].z = tmpvar_1.z;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_14 * ((
    (_World2Object * tmpvar_15)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_6 = tmpvar_16;
  tmpvar_7.xyz = _FogColor.xyz;
  highp float tmpvar_17;
  tmpvar_17 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_7.w = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_18[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_18[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_COLOR = tmpvar_7;
  xlv_TEXCOORD5 = (((
    (((tmpvar_8.xy / tmpvar_8.w) + (normalize(
      (tmpvar_18 * tmpvar_1)
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float nh_3;
  mediump vec3 scalePerBasisVector_4;
  mediump vec3 specColor_5;
  highp float tex_alpha_6;
  lowp vec4 texcol_7;
  mediump float Pow_8;
  mediump vec2 ColMapUV_9;
  lowp vec4 DScaleMap_10;
  lowp vec3 finalColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_10.w = tmpvar_12.w;
  DScaleMap_10.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  DScaleMap_10.xyz = normalize(DScaleMap_10.xyz);
  lowp vec2 tmpvar_13;
  tmpvar_13 = DScaleMap_10.xy;
  ColMapUV_9 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_8 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, tmpvar_15);
  texcol_7.w = tmpvar_16.w;
  lowp float tmpvar_17;
  tmpvar_17 = texture (_MainAlpha, tmpvar_15).y;
  tex_alpha_6 = tmpvar_17;
  texcol_7.xyz = (tmpvar_16.xyz * _Color.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_4.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_4.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_4.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD3)
  )).z);
  nh_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * tex_alpha_6) * pow (nh_3, (_Shininess * 128.0)));
  specColor_5 = tmpvar_21;
  finalColor_11 = specColor_5;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_11 + (texcol_7.xyz * tmpvar_18));
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = ((ColMapUV_9 * Pow_8) + xlv_TEXCOORD5);
  tmpvar_23 = texture (_ReflectTex, P_24);
  mediump vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_23 * _ReflectLevel);
  texreflect_2 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_22 + (texreflect_2.xyz * tex_alpha_6));
  finalColor_11 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = finalColor_11;
  ret_1.w = tmpvar_27.w;
  ret_1.xyz = mix (finalColor_11, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture2D (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp float _FogAlpha;
uniform lowp float _DScale;
uniform highp vec4 _ReflectTex_ST;
uniform highp float _ReflectDist;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform lowp vec4 _MainTex_ST;
uniform lowp vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
  tmpvar_2 = tmpvar_6;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_7;
  tmpvar_7 = (_FogColor.w * (clamp (
    (((_Object2World * _glesVertex).y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0) * _FogAlpha));
  tmpvar_3.w = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_8[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_8[2] = glstate_matrix_mvp[2].xyz;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD5 = (((
    (((tmpvar_4.xy / tmpvar_4.w) + (normalize(
      (tmpvar_8 * normalize(_glesNormal))
    ).xz * _ReflectDist)) * vec2(0.5, 0.5))
   + vec2(0.5, 0.5)) * _ReflectTex_ST.xy) + _ReflectTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _DPower;
uniform sampler2D _ReflectTex;
uniform mediump float _ReflectLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texreflect_2;
  highp float tex_alpha_3;
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
  mediump vec2 tmpvar_12;
  tmpvar_12 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, tmpvar_12);
  texcol_4.w = tmpvar_13.w;
  lowp float tmpvar_14;
  tmpvar_14 = texture (_MainAlpha, tmpvar_12).y;
  tex_alpha_3 = tmpvar_14;
  texcol_4.xyz = (tmpvar_13.xyz * _Color.xyz);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = ((ColMapUV_6 * Pow_5) + xlv_TEXCOORD5);
  tmpvar_15 = texture (_ReflectTex, P_16);
  mediump vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_15 * _ReflectLevel);
  texreflect_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (texcol_4.xyz + (texreflect_2.xyz * tex_alpha_3));
  finalColor_8 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_8;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (finalColor_8, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3"
}
}
 }
}
Fallback Off
}