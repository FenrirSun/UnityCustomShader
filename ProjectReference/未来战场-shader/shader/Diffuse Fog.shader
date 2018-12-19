Shader "VX/Scene New/Diffuse Fog" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 LOD 400
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardAdd" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
  Blend One One
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "ALTITUDEFOG"
  Tags { "LIGHTMODE"="Always" "RenderType"="Opaque" }
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "SHADOWCOLLECTOR"
  Tags { "LIGHTMODE"="SHADOWCOLLECTOR" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
}
Program "fp" {
}
 }
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_5;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_5;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_4;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_4;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_4;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_4;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float tmpvar_3;
  mediump float lightShadowDataX_4;
  highp float dist_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((dist_5 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_4);
  tmpvar_3 = tmpvar_8;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * tmpvar_3) * 2.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_9, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_11;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float tmpvar_2;
  mediump float lightShadowDataX_3;
  highp float dist_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((dist_4 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_3);
  tmpvar_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_9, 
    ((tmpvar_8.xyz * tmpvar_2) * 2.0)
  ), (tmpvar_9 * tmpvar_2)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_10, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_12;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float tmpvar_2;
  mediump float lightShadowDataX_3;
  highp float dist_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((dist_4 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_3);
  tmpvar_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_9, 
    ((tmpvar_8.xyz * tmpvar_2) * 2.0)
  ), (tmpvar_9 * tmpvar_2)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_10, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_12;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_5;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_5;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float tmpvar_3;
  mediump float lightShadowDataX_4;
  highp float dist_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((dist_5 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_4);
  tmpvar_3 = tmpvar_8;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * tmpvar_3) * 2.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_9, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_11;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  lowp float tmpvar_4;
  tmpvar_4 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_5;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  ret_1.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  mediump float tmpvar_4;
  tmpvar_4 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_6;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((
    ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_9;
  _glesFragData[0] = ret_1;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  lowp float tmpvar_3;
  tmpvar_3 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_4;
  tmpvar_4 = (_LightShadowData.x + (tmpvar_3 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (2.0 * tmpvar_5.xyz);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_6, 
    ((tmpvar_5.xyz * shadow_2) * 2.0)
  ), (tmpvar_6 * shadow_2)));
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_9;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  mediump float tmpvar_3;
  tmpvar_3 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_7, 
    ((tmpvar_6.xyz * shadow_2) * 2.0)
  ), (tmpvar_7 * shadow_2)));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  ret_1.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_10;
  _glesFragData[0] = ret_1;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  lowp float tmpvar_3;
  tmpvar_3 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_4;
  tmpvar_4 = (_LightShadowData.x + (tmpvar_3 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (2.0 * tmpvar_5.xyz);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_6, 
    ((tmpvar_5.xyz * shadow_2) * 2.0)
  ), (tmpvar_6 * shadow_2)));
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_9;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  mediump float tmpvar_3;
  tmpvar_3 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_7, 
    ((tmpvar_6.xyz * shadow_2) * 2.0)
  ), (tmpvar_7 * shadow_2)));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  ret_1.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_10;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  lowp float tmpvar_4;
  tmpvar_4 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_5;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  ret_1.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_4 = (_WorldSpaceCameraPos - cse_5.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6.x = sqrt(dot (tmpvar_4, tmpvar_4));
  tmpvar_6.y = cse_5.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  mediump float tmpvar_4;
  tmpvar_4 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_6;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((
    ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD2.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD2.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_9;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float tmpvar_3;
  mediump float lightShadowDataX_4;
  highp float dist_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((dist_5 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_4);
  tmpvar_3 = tmpvar_8;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * tmpvar_3) * 2.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_9, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_11;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float tmpvar_2;
  mediump float lightShadowDataX_3;
  highp float dist_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((dist_4 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_3);
  tmpvar_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_9, 
    ((tmpvar_8.xyz * tmpvar_2) * 2.0)
  ), (tmpvar_9 * tmpvar_2)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_10, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_12;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float tmpvar_2;
  mediump float lightShadowDataX_3;
  highp float dist_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((dist_4 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_3);
  tmpvar_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_9, 
    ((tmpvar_8.xyz * tmpvar_2) * 2.0)
  ), (tmpvar_9 * tmpvar_2)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_10, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_12;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float tmpvar_3;
  mediump float lightShadowDataX_4;
  highp float dist_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((dist_5 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_4);
  tmpvar_3 = tmpvar_8;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * tmpvar_3) * 2.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_9, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_11;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  lowp float tmpvar_4;
  tmpvar_4 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_5;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  ret_1.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  mediump float tmpvar_4;
  tmpvar_4 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_6;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((
    ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
  _glesFragData[0] = ret_1;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  lowp float tmpvar_3;
  tmpvar_3 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_4;
  tmpvar_4 = (_LightShadowData.x + (tmpvar_3 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (2.0 * tmpvar_5.xyz);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_6, 
    ((tmpvar_5.xyz * shadow_2) * 2.0)
  ), (tmpvar_6 * shadow_2)));
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  mediump float tmpvar_3;
  tmpvar_3 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_7, 
    ((tmpvar_6.xyz * shadow_2) * 2.0)
  ), (tmpvar_7 * shadow_2)));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  ret_1.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_10;
  _glesFragData[0] = ret_1;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  lowp float tmpvar_3;
  tmpvar_3 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_4;
  tmpvar_4 = (_LightShadowData.x + (tmpvar_3 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (2.0 * tmpvar_5.xyz);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_6, 
    ((tmpvar_5.xyz * shadow_2) * 2.0)
  ), (tmpvar_6 * shadow_2)));
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  mediump float tmpvar_3;
  tmpvar_3 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_7, 
    ((tmpvar_6.xyz * shadow_2) * 2.0)
  ), (tmpvar_7 * shadow_2)));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  ret_1.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_10;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  lowp float tmpvar_4;
  tmpvar_4 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_5;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  ret_1.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2.w = (tmpvar_2.w * max (clamp (
    ((sqrt(dot (tmpvar_5, tmpvar_5)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_6.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  mediump float tmpvar_4;
  tmpvar_4 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_6;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((
    ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
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
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2;
  ret_1.w = tmpvar_3.w;
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_4;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_5.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float tmpvar_3;
  mediump float lightShadowDataX_4;
  highp float dist_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((dist_5 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_4);
  tmpvar_3 = tmpvar_8;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * tmpvar_3) * 2.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_9, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_11;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    (cse_6.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float tmpvar_2;
  mediump float lightShadowDataX_3;
  highp float dist_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((dist_4 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_3);
  tmpvar_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_9, 
    ((tmpvar_8.xyz * tmpvar_2) * 2.0)
  ), (tmpvar_9 * tmpvar_2)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_10, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_12;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    (cse_6.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float tmpvar_2;
  mediump float lightShadowDataX_3;
  highp float dist_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((dist_4 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_3);
  tmpvar_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_9, 
    ((tmpvar_8.xyz * tmpvar_2) * 2.0)
  ), (tmpvar_9 * tmpvar_2)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_10, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_12;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
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
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (((
    (texture (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (N_2, _WorldSpaceLightPos0.xyz)
  )) * 2.0);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_3;
  ret_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (tmpvar_3, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_5;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_5.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float tmpvar_3;
  mediump float lightShadowDataX_4;
  highp float dist_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = max (float((dist_5 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_4);
  tmpvar_3 = tmpvar_8;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  tmpvar_9 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * tmpvar_3) * 2.0);
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_9, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_11;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_5.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  lowp float tmpvar_4;
  tmpvar_4 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_5;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  ret_1.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_5.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  mediump float tmpvar_4;
  tmpvar_4 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_6;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((
    ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
  _glesFragData[0] = ret_1;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    (cse_6.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  lowp float tmpvar_3;
  tmpvar_3 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_4;
  tmpvar_4 = (_LightShadowData.x + (tmpvar_3 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (2.0 * tmpvar_5.xyz);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_6, 
    ((tmpvar_5.xyz * shadow_2) * 2.0)
  ), (tmpvar_6 * shadow_2)));
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    (cse_6.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  mediump float tmpvar_3;
  tmpvar_3 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_7, 
    ((tmpvar_6.xyz * shadow_2) * 2.0)
  ), (tmpvar_7 * shadow_2)));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  ret_1.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_10;
  _glesFragData[0] = ret_1;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    (cse_6.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  lowp float tmpvar_3;
  tmpvar_3 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_4;
  tmpvar_4 = (_LightShadowData.x + (tmpvar_3 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_6;
  tmpvar_6 = (2.0 * tmpvar_5.xyz);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_6, 
    ((tmpvar_5.xyz * shadow_2) * 2.0)
  ), (tmpvar_6 * shadow_2)));
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = _FogColor;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_3.w = (tmpvar_3.w * clamp ((
    (cse_6.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp float shadow_2;
  mediump float tmpvar_3;
  tmpvar_3 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * tmpvar_6.xyz);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * max (min (tmpvar_7, 
    ((tmpvar_6.xyz * shadow_2) * 2.0)
  ), (tmpvar_7 * shadow_2)));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
  ret_1.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_8, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_10;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_5.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  lowp float tmpvar_4;
  tmpvar_4 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = (_LightShadowData.x + (tmpvar_4 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_5;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_6;
  tmpvar_6 = (((
    ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  ret_1.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  tmpvar_2 = _FogColor;
  highp vec4 cse_5;
  cse_5 = (_Object2World * _glesVertex);
  tmpvar_2.w = (tmpvar_2.w * clamp ((
    (cse_5.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_5);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
in mediump vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec3 N_2;
  lowp float shadow_3;
  mediump float tmpvar_4;
  tmpvar_4 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_6;
  N_2 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((
    ((texture (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz)
   * 
    max (0.0, dot (N_2, _WorldSpaceLightPos0.xyz))
  ) * shadow_3) * 2.0);
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  ret_1.w = tmpvar_8.w;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_7, xlv_COLOR.xyz, xlv_COLOR.www);
  ret_1.xyz = tmpvar_9;
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
 UsePass "VertexLit/SHADOWCASTER"
 UsePass "VertexLit/SHADOWCOLLECTOR"
}
Fallback Off
}