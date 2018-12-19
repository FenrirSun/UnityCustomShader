Shader "VX/Scene New/Unlit Reflect Mask RGB" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _MainAlpha ("Base Alpha (RGB)", 2D) = "white" {}
 _SpecTex ("Specular Map (RGB)", 2D) = "black" {}
 _SpecLevel ("Specular Level", Range(0,1)) = 0.5
 _ReflectLevel ("Reflect Level", Float) = 1
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_5[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_5[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((
    (tmpvar_3.xy / tmpvar_3.w)
   + 
    (normalize((tmpvar_5 * normalize(_glesNormal))).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_2 = tmpvar_6;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 texspec_1;
  mediump float texAlpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecTex, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * texAlpha_2) * _SpecLevel);
  texspec_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = ((texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR) + texspec_1);
  gl_FragData[0] = tmpvar_6;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_5[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_5[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_6;
  tmpvar_6 = (((
    (tmpvar_3.xy / tmpvar_3.w)
   + 
    (normalize((tmpvar_5 * normalize(_glesNormal))).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_2 = tmpvar_6;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 texspec_1;
  mediump float texAlpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_SpecTex, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * texAlpha_2) * _SpecLevel);
  texspec_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = ((texture (_MainTex, xlv_TEXCOORD0) * xlv_COLOR) + texspec_1);
  _glesFragData[0] = tmpvar_6;
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