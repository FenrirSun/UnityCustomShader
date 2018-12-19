Shader "RenderFX/Skybox" {
Properties {
 _Tint ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _FrontTex ("Front (+Z)", 2D) = "white" {}
 _BackTex ("Back (-Z)", 2D) = "white" {}
 _LeftTex ("Left (+X)", 2D) = "white" {}
 _RightTex ("Right (-X)", 2D) = "white" {}
 _UpTex ("Up (+Y)", 2D) = "white" {}
 _DownTex ("Down (-Y)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Background" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _FrontTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_FrontTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _FrontTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_FrontTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  _glesFragData[0] = col_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _BackTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_BackTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _BackTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_BackTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  _glesFragData[0] = col_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _LeftTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_LeftTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _LeftTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_LeftTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  _glesFragData[0] = col_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _RightTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_RightTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _RightTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_RightTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  _glesFragData[0] = col_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _UpTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_UpTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _UpTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_UpTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  _glesFragData[0] = col_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _DownTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_DownTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 _Tint;
uniform sampler2D _DownTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_DownTex, xlv_TEXCOORD0);
  col_1.xyz = ((tmpvar_2.xyz + _Tint.xyz) - unity_ColorSpaceGrey.xyz);
  col_1.w = (tmpvar_2.w * _Tint.w);
  _glesFragData[0] = col_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
}