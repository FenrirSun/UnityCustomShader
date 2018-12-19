Shader "VX/SelfIllum/LerpFrom2Texture" {
Properties {
 _MainTex ("Color Map (RGB)", 2D) = "white" {}
 _FXTex ("Shining Mask(RGB)", 2D) = "black" {}
 _Speed ("Shining Speed", Float) = 1
}
SubShader { 
 Pass {
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform mediump float _Speed;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_FXTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, tmpvar_3, vec4((abs(
    sin(((3.1415 * _Time.y) * _Speed))
  ) * tmpvar_3.w)));
  ret_1 = tmpvar_4;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform mediump float _Speed;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_FXTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_2, tmpvar_3, vec4((abs(
    sin(((3.1415 * _Time.y) * _Speed))
  ) * tmpvar_3.w)));
  ret_1 = tmpvar_4;
  _glesFragData[0] = ret_1;
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