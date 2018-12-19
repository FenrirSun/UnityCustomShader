Shader "VX/Scene New/Unlit CastShadow" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_3 = (_WorldSpaceCameraPos - cse_4.xyz);
  highp vec2 tmpvar_5;
  tmpvar_5.x = sqrt(dot (tmpvar_3, tmpvar_3));
  tmpvar_5.y = cse_4.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (tmpvar_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_3 = (_WorldSpaceCameraPos - cse_4.xyz);
  highp vec2 tmpvar_5;
  tmpvar_5.x = sqrt(dot (tmpvar_3, tmpvar_3));
  tmpvar_5.y = cse_4.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (tmpvar_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_4, tmpvar_4)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (tmpvar_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_4, tmpvar_4)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (tmpvar_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (tmpvar_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (tmpvar_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "FOG_LOW" }
"!!GLES3"
}
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Cull Off
  Fog { Mode Off }
  Offset 1, 1
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xyw = tmpvar_2.xyw;
  tmpvar_1.z = (tmpvar_2.z + unity_LightShadowBias.x);
  tmpvar_1.z = mix (tmpvar_1.z, max (tmpvar_1.z, -(tmpvar_2.w)), unity_LightShadowBias.y);
  gl_Position = tmpvar_1;
}



#endif
#ifdef FRAGMENT

void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xyw = tmpvar_2.xyw;
  tmpvar_1.z = (tmpvar_2.z + unity_LightShadowBias.x);
  tmpvar_1.z = mix (tmpvar_1.z, max (tmpvar_1.z, -(tmpvar_2.w)), unity_LightShadowBias.y);
  gl_Position = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
void main ()
{
  _glesFragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightPositionRange;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.65814e+07) * min (
    (sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) * _LightPositionRange.w)
  , 0.999)));
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.00392157));
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightPositionRange;
in highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.65814e+07) * min (
    (sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) * _LightPositionRange.w)
  , 0.999)));
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.00392157));
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
"!!GLES3"
}
}
 }
}
Fallback Off
}