Shader "VX/Character/CharacterSimple_Transparent_OutlineInGrass" {
Properties {
 _TintColor ("Tint Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "gray" {}
 _Transparent ("Transparent", Range(0,1)) = 0.5
 _OutLineColor ("OutLine Color", Color) = (0,1,0,1)
 _Outline ("Outline Width", Range(0.001,0.03)) = 0.001
}
SubShader { 
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent+1" "RenderType"="Transparent" }
 Pass {
  Name "BASETRANSPARENT"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent+1" "RenderType"="Transparent" }
  Lighting On
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask 0
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
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
 Pass {
  Name "BASETRANSPARENT2"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent+1" "RenderType"="Transparent" }
  Lighting On
  ZTest Equal
  ZWrite Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  gl_FragData[0] = clr_1;
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
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
uniform lowp float _Transparent;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 clr_1;
  clr_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * _TintColor.xyz);
  clr_1.w = _Transparent;
  _glesFragData[0] = clr_1;
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
 Pass {
  Name "OUTLINE"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent+1" "RenderType"="Transparent" }
  Lighting On
  ZTest Less
  Cull Front
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _OutLineColor;
void main ()
{
  gl_FragData[0] = _OutLineColor;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp float _Outline;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.zw = tmpvar_3.zw;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp mat2 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_projection[0].xy;
  tmpvar_5[1] = glstate_matrix_projection[1].xy;
  tmpvar_1.xy = (tmpvar_3.xy + ((
    (tmpvar_5 * (tmpvar_4 * normalize(_glesNormal)).xy)
   * tmpvar_3.z) * _Outline));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _OutLineColor;
void main ()
{
  _glesFragData[0] = _OutLineColor;
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
Fallback "Diffuse"
}