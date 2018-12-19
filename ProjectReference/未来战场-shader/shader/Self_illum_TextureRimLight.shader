Shader "VX/SelfIllum/TextureRimLight" {
Properties {
 _Color ("Edge Color", Color) = (1,1,1,1)
 _EdgeIn ("Edge In Range", Range(0,1)) = 0.5
 _EdgeOut ("Edge Out Range", Range(1,2)) = 1.5
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TintColor ("Main Color", Color) = (1,1,1,1)
}
SubShader { 
 Pass {
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Color;
uniform highp float _EdgeIn;
uniform highp float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_2;
  tmpvar_2 = clamp (((
    (1.0 - dot (normalize(_glesNormal), normalize((
      ((_World2Object * tmpvar_1).xyz * unity_Scale.w)
     - _glesVertex.xyz))))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = (_Color * (tmpvar_2 * (tmpvar_2 * 
    (3.0 - (2.0 * tmpvar_2))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((c_1 * _TintColor) + xlv_COLOR);
  c_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Color;
uniform highp float _EdgeIn;
uniform highp float _EdgeOut;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_2;
  tmpvar_2 = clamp (((
    (1.0 - dot (normalize(_glesNormal), normalize((
      ((_World2Object * tmpvar_1).xyz * unity_Scale.w)
     - _glesVertex.xyz))))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = (_Color * (tmpvar_2 * (tmpvar_2 * 
    (3.0 - (2.0 * tmpvar_2))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((c_1 * _TintColor) + xlv_COLOR);
  c_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
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