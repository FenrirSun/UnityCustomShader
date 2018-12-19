Shader "Hidden/FastBloom" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Bloom ("Bloom (RGB)", 2D) = "black" {}
}
SubShader { 
 Pass {
  ZTest False
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Bloom;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_Bloom, xlv_TEXCOORD0));
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Bloom;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture (_MainTex, xlv_TEXCOORD0) + texture (_Bloom, xlv_TEXCOORD0));
  _glesFragData[0] = tmpvar_1;
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
  ZTest False
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
uniform mediump vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + _MainTex_TexelSize.xy);
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + (_MainTex_TexelSize.xy * vec2(-0.5, -0.5)));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + (_MainTex_TexelSize.xy * vec2(0.5, -0.5)));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + (_MainTex_TexelSize.xy * vec2(-0.5, 0.5)));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Parameter;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (((texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_MainTex, xlv_TEXCOORD1)) + texture2D (_MainTex, xlv_TEXCOORD2)) + texture2D (_MainTex, xlv_TEXCOORD3));
  mediump vec4 tmpvar_3;
  tmpvar_3 = max (((tmpvar_2 / 4.0) - _Parameter.z), vec4(0.0, 0.0, 0.0, 0.0));
  tmpvar_1 = (tmpvar_3 * _Parameter.w);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_TexelSize;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec2 xlv_TEXCOORD3;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + _MainTex_TexelSize.xy);
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + (_MainTex_TexelSize.xy * vec2(-0.5, -0.5)));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + (_MainTex_TexelSize.xy * vec2(0.5, -0.5)));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + (_MainTex_TexelSize.xy * vec2(-0.5, 0.5)));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Parameter;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (((texture (_MainTex, xlv_TEXCOORD0) + texture (_MainTex, xlv_TEXCOORD1)) + texture (_MainTex, xlv_TEXCOORD2)) + texture (_MainTex, xlv_TEXCOORD3));
  mediump vec4 tmpvar_3;
  tmpvar_3 = max (((tmpvar_2 / 4.0) - _Parameter.z), vec4(0.0, 0.0, 0.0, 0.0));
  tmpvar_1 = (tmpvar_3 * _Parameter.w);
  _glesFragData[0] = tmpvar_1;
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
  ZTest Always
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
uniform mediump vec4 _MainTex_TexelSize;
uniform mediump vec4 _Parameter;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = _glesMultiTexCoord0.xy;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_MainTex_TexelSize.xy * vec2(0.0, 1.0)) * _Parameter.x);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 coords_2;
  coords_2 = (xlv_TEXCOORD0.xy - (xlv_TEXCOORD1 * 3.0));
  mediump vec4 tap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, coords_2);
  tap_3 = tmpvar_4;
  color_1 = (tap_3 * vec4(0.0205, 0.0205, 0.0205, 0.0));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, coords_2);
  tap_5 = tmpvar_6;
  color_1 = (color_1 + (tap_5 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, coords_2);
  tap_7 = tmpvar_8;
  color_1 = (color_1 + (tap_7 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, coords_2);
  tap_9 = tmpvar_10;
  color_1 = (color_1 + (tap_9 * vec4(0.324, 0.324, 0.324, 1.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, coords_2);
  tap_11 = tmpvar_12;
  color_1 = (color_1 + (tap_11 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, coords_2);
  tap_13 = tmpvar_14;
  color_1 = (color_1 + (tap_13 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, coords_2);
  tap_15 = tmpvar_16;
  color_1 = (color_1 + (tap_15 * vec4(0.0205, 0.0205, 0.0205, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_TexelSize;
uniform mediump vec4 _Parameter;
out mediump vec4 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = _glesMultiTexCoord0.xy;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_MainTex_TexelSize.xy * vec2(0.0, 1.0)) * _Parameter.x);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in mediump vec4 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 coords_2;
  coords_2 = (xlv_TEXCOORD0.xy - (xlv_TEXCOORD1 * 3.0));
  mediump vec4 tap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, coords_2);
  tap_3 = tmpvar_4;
  color_1 = (tap_3 * vec4(0.0205, 0.0205, 0.0205, 0.0));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, coords_2);
  tap_5 = tmpvar_6;
  color_1 = (color_1 + (tap_5 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, coords_2);
  tap_7 = tmpvar_8;
  color_1 = (color_1 + (tap_7 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture (_MainTex, coords_2);
  tap_9 = tmpvar_10;
  color_1 = (color_1 + (tap_9 * vec4(0.324, 0.324, 0.324, 1.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_MainTex, coords_2);
  tap_11 = tmpvar_12;
  color_1 = (color_1 + (tap_11 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_MainTex, coords_2);
  tap_13 = tmpvar_14;
  color_1 = (color_1 + (tap_13 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, coords_2);
  tap_15 = tmpvar_16;
  color_1 = (color_1 + (tap_15 * vec4(0.0205, 0.0205, 0.0205, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  _glesFragData[0] = color_1;
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
  ZTest Always
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
uniform mediump vec4 _MainTex_TexelSize;
uniform mediump vec4 _Parameter;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = _glesMultiTexCoord0.xy;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_MainTex_TexelSize.xy * vec2(1.0, 0.0)) * _Parameter.x);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 coords_2;
  coords_2 = (xlv_TEXCOORD0.xy - (xlv_TEXCOORD1 * 3.0));
  mediump vec4 tap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, coords_2);
  tap_3 = tmpvar_4;
  color_1 = (tap_3 * vec4(0.0205, 0.0205, 0.0205, 0.0));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, coords_2);
  tap_5 = tmpvar_6;
  color_1 = (color_1 + (tap_5 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, coords_2);
  tap_7 = tmpvar_8;
  color_1 = (color_1 + (tap_7 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, coords_2);
  tap_9 = tmpvar_10;
  color_1 = (color_1 + (tap_9 * vec4(0.324, 0.324, 0.324, 1.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, coords_2);
  tap_11 = tmpvar_12;
  color_1 = (color_1 + (tap_11 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, coords_2);
  tap_13 = tmpvar_14;
  color_1 = (color_1 + (tap_13 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, coords_2);
  tap_15 = tmpvar_16;
  color_1 = (color_1 + (tap_15 * vec4(0.0205, 0.0205, 0.0205, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_TexelSize;
uniform mediump vec4 _Parameter;
out mediump vec4 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = _glesMultiTexCoord0.xy;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_MainTex_TexelSize.xy * vec2(1.0, 0.0)) * _Parameter.x);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in mediump vec4 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 coords_2;
  coords_2 = (xlv_TEXCOORD0.xy - (xlv_TEXCOORD1 * 3.0));
  mediump vec4 tap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, coords_2);
  tap_3 = tmpvar_4;
  color_1 = (tap_3 * vec4(0.0205, 0.0205, 0.0205, 0.0));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, coords_2);
  tap_5 = tmpvar_6;
  color_1 = (color_1 + (tap_5 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, coords_2);
  tap_7 = tmpvar_8;
  color_1 = (color_1 + (tap_7 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture (_MainTex, coords_2);
  tap_9 = tmpvar_10;
  color_1 = (color_1 + (tap_9 * vec4(0.324, 0.324, 0.324, 1.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_MainTex, coords_2);
  tap_11 = tmpvar_12;
  color_1 = (color_1 + (tap_11 * vec4(0.232, 0.232, 0.232, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_MainTex, coords_2);
  tap_13 = tmpvar_14;
  color_1 = (color_1 + (tap_13 * vec4(0.0855, 0.0855, 0.0855, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  mediump vec4 tap_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, coords_2);
  tap_15 = tmpvar_16;
  color_1 = (color_1 + (tap_15 * vec4(0.0205, 0.0205, 0.0205, 0.0)));
  coords_2 = (coords_2 + xlv_TEXCOORD1);
  _glesFragData[0] = color_1;
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
Fallback Off
}