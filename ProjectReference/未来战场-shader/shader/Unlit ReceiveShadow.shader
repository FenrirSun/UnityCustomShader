Shader "VX/Scene New/Unlit ReceiveShadow" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD1.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD1.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
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
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  texcol_2.xyz = (tmpvar_3.xyz * tmpvar_4);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = finalColor_1;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  tmpvar_2 = _FogColor;
  highp vec4 cse_4;
  cse_4 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_4.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * cse_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
in mediump vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 finalColor_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  texcol_2.w = tmpvar_3.w;
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  texcol_2.xyz = (tmpvar_3.xyz * shadow_4);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (texcol_2.xyz, xlv_COLOR.xyz, xlv_COLOR.www);
  finalColor_1 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = finalColor_1;
  _glesFragData[0] = tmpvar_9;
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
 Pass {
  Name "SHADOWCOLLECTOR"
  Tags { "LIGHTMODE"="SHADOWCOLLECTOR" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ProjectionParams;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 zFar_3;
  highp vec4 zNear_4;
  bvec4 tmpvar_5;
  tmpvar_5 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_6;
  tmpvar_6 = vec4(tmpvar_5);
  zNear_4 = tmpvar_6;
  bvec4 tmpvar_7;
  tmpvar_7 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(tmpvar_7);
  zFar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (zNear_4 * zFar_3);
  highp float tmpvar_10;
  tmpvar_10 = clamp (((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (((
    (xlv_TEXCOORD0 * tmpvar_9.x)
   + 
    (xlv_TEXCOORD1 * tmpvar_9.y)
  ) + (xlv_TEXCOORD2 * tmpvar_9.z)) + (xlv_TEXCOORD3 * tmpvar_9.w));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, tmpvar_11.xy);
  highp float tmpvar_13;
  if ((tmpvar_12.x < tmpvar_11.z)) {
    tmpvar_13 = _LightShadowData.x;
  } else {
    tmpvar_13 = 1.0;
  };
  res_2.x = clamp ((tmpvar_13 + tmpvar_10), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_14.y = tmpvar_15.y;
  enc_14.x = (tmpvar_15.x - (tmpvar_15.y * 0.00392157));
  res_2.zw = enc_14;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 zFar_4;
  highp vec4 zNear_5;
  bvec4 tmpvar_6;
  tmpvar_6 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(tmpvar_6);
  zNear_5 = tmpvar_7;
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = vec4(tmpvar_8);
  zFar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (zNear_5 * zFar_4);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (((
    (xlv_TEXCOORD0 * tmpvar_10.x)
   + 
    (xlv_TEXCOORD1 * tmpvar_10.y)
  ) + (xlv_TEXCOORD2 * tmpvar_10.z)) + (xlv_TEXCOORD3 * tmpvar_10.w));
  lowp float tmpvar_12;
  tmpvar_12 = shadow2DEXT (_ShadowMapTexture, tmpvar_11.xyz);
  mediump float tmpvar_13;
  tmpvar_13 = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_14;
  res_2.x = clamp ((shadow_3 + clamp (
    ((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_15.y = tmpvar_16.y;
  enc_15.x = (tmpvar_16.x - (tmpvar_16.y * 0.00392157));
  res_2.zw = enc_15;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 zFar_4;
  highp vec4 zNear_5;
  bvec4 tmpvar_6;
  tmpvar_6 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(tmpvar_6);
  zNear_5 = tmpvar_7;
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = vec4(tmpvar_8);
  zFar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (zNear_5 * zFar_4);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = (((
    (xlv_TEXCOORD0 * tmpvar_10.x)
   + 
    (xlv_TEXCOORD1 * tmpvar_10.y)
  ) + (xlv_TEXCOORD2 * tmpvar_10.z)) + (xlv_TEXCOORD3 * tmpvar_10.w));
  mediump float tmpvar_12;
  tmpvar_12 = texture (_ShadowMapTexture, tmpvar_11.xyz);
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_13;
  res_2.x = clamp ((shadow_3 + clamp (
    ((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_14.y = tmpvar_15.y;
  enc_14.x = (tmpvar_15.x - (tmpvar_15.y * 0.00392157));
  res_2.zw = enc_14;
  tmpvar_1 = res_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform sampler2D _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 cascadeWeights_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.x = dot (tmpvar_4, tmpvar_4);
  tmpvar_8.y = dot (tmpvar_5, tmpvar_5);
  tmpvar_8.z = dot (tmpvar_6, tmpvar_6);
  tmpvar_8.w = dot (tmpvar_7, tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (tmpvar_8, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_10;
  tmpvar_10 = vec4(tmpvar_9);
  cascadeWeights_3 = tmpvar_10;
  cascadeWeights_3.yzw = clamp ((cascadeWeights_3.yzw - cascadeWeights_3.xyz), 0.0, 1.0);
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    sqrt(dot (tmpvar_11, tmpvar_11))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (((
    (xlv_TEXCOORD0 * cascadeWeights_3.x)
   + 
    (xlv_TEXCOORD1 * cascadeWeights_3.y)
  ) + (xlv_TEXCOORD2 * cascadeWeights_3.z)) + (xlv_TEXCOORD3 * cascadeWeights_3.w));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_13.z)) {
    tmpvar_15 = _LightShadowData.x;
  } else {
    tmpvar_15 = 1.0;
  };
  res_2.x = clamp ((tmpvar_15 + tmpvar_12), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_16.y = tmpvar_17.y;
  enc_16.x = (tmpvar_17.x - (tmpvar_17.y * 0.00392157));
  res_2.zw = enc_16;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 cascadeWeights_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_5, tmpvar_5);
  tmpvar_9.y = dot (tmpvar_6, tmpvar_6);
  tmpvar_9.z = dot (tmpvar_7, tmpvar_7);
  tmpvar_9.w = dot (tmpvar_8, tmpvar_8);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (tmpvar_9, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_11;
  tmpvar_11 = vec4(tmpvar_10);
  cascadeWeights_4 = tmpvar_11;
  cascadeWeights_4.yzw = clamp ((cascadeWeights_4.yzw - cascadeWeights_4.xyz), 0.0, 1.0);
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (((
    (xlv_TEXCOORD0 * cascadeWeights_4.x)
   + 
    (xlv_TEXCOORD1 * cascadeWeights_4.y)
  ) + (xlv_TEXCOORD2 * cascadeWeights_4.z)) + (xlv_TEXCOORD3 * cascadeWeights_4.w));
  lowp float tmpvar_14;
  tmpvar_14 = shadow2DEXT (_ShadowMapTexture, tmpvar_13.xyz);
  mediump float tmpvar_15;
  tmpvar_15 = tmpvar_14;
  highp float tmpvar_16;
  tmpvar_16 = (_LightShadowData.x + (tmpvar_15 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_16;
  res_2.x = clamp ((shadow_3 + clamp (
    ((sqrt(dot (tmpvar_12, tmpvar_12)) * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_17.y = tmpvar_18.y;
  enc_17.x = (tmpvar_18.x - (tmpvar_18.y * 0.00392157));
  res_2.zw = enc_17;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform lowp sampler2DShadow _ShadowMapTexture;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 cascadeWeights_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_5, tmpvar_5);
  tmpvar_9.y = dot (tmpvar_6, tmpvar_6);
  tmpvar_9.z = dot (tmpvar_7, tmpvar_7);
  tmpvar_9.w = dot (tmpvar_8, tmpvar_8);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (tmpvar_9, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_11;
  tmpvar_11 = vec4(tmpvar_10);
  cascadeWeights_4 = tmpvar_11;
  cascadeWeights_4.yzw = clamp ((cascadeWeights_4.yzw - cascadeWeights_4.xyz), 0.0, 1.0);
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (((
    (xlv_TEXCOORD0 * cascadeWeights_4.x)
   + 
    (xlv_TEXCOORD1 * cascadeWeights_4.y)
  ) + (xlv_TEXCOORD2 * cascadeWeights_4.z)) + (xlv_TEXCOORD3 * cascadeWeights_4.w));
  mediump float tmpvar_14;
  tmpvar_14 = texture (_ShadowMapTexture, tmpvar_13.xyz);
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_15;
  res_2.x = clamp ((shadow_3 + clamp (
    ((sqrt(dot (tmpvar_12, tmpvar_12)) * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_16.y = tmpvar_17.y;
  enc_16.x = (tmpvar_17.x - (tmpvar_17.y * 0.00392157));
  res_2.zw = enc_16;
  tmpvar_1 = res_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES3"
}
}
 }
}
Fallback Off
}