Shader "VX/Scene New/Transparent/AlphaMask Ground Detail" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _MaskTex ("AlphaMask (R)", 2D) = "white" {}
 _TintColor ("Tint Color", Color) = (1,1,1,1)
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent-50" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent-50" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9.x = sqrt(dot (tmpvar_7, tmpvar_7));
  tmpvar_9.y = cse_8.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_MainTex, xlv_TEXCOORD0).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz)) * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceCameraPos - cse_8.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9.x = sqrt(dot (tmpvar_7, tmpvar_7));
  tmpvar_9.y = cse_8.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture (_MainTex, xlv_TEXCOORD0).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz)) * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_7;
  tmpvar_3 = _FogColor;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3.w = (tmpvar_3.w * max (clamp (
    ((sqrt(dot (tmpvar_8, tmpvar_8)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_9.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_MainTex, xlv_TEXCOORD0).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz)) * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_7;
  tmpvar_3 = _FogColor;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3.w = (tmpvar_3.w * max (clamp (
    ((sqrt(dot (tmpvar_8, tmpvar_8)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_9.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture (_MainTex, xlv_TEXCOORD0).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz)) * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_7;
  tmpvar_3 = _FogColor;
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_MainTex, xlv_TEXCOORD0).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz)) * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_7;
  tmpvar_3 = _FogColor;
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture (_MainTex, xlv_TEXCOORD0).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz)) * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_7;
  tmpvar_7.x = sqrt(dot (tmpvar_5, tmpvar_5));
  tmpvar_7.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_7;
  tmpvar_7.x = sqrt(dot (tmpvar_5, tmpvar_5));
  tmpvar_7.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_3.w = (tmpvar_3.w * max (clamp (
    ((sqrt(dot (tmpvar_6, tmpvar_6)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_3.w = (tmpvar_3.w * max (clamp (
    ((sqrt(dot (tmpvar_6, tmpvar_6)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _MaskTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
uniform lowp vec3 _TintColor;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  lowp vec3 finalColor_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor);
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_3 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture (_MaskTex, xlv_TEXCOORD1).x;
  alpha_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = finalColor_3;
  tmpvar_7.w = alpha_2;
  tmpvar_1 = tmpvar_7;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
}
 }
}
Fallback Off
}