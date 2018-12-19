Shader "VX/FX/CharacterSkillA" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _FXTex ("FX Map (RGB)", 2D) = "white" {}
 _FXColor ("FX Color", Color) = (1,1,1,1)
 _EdgeIn ("Edge In Range", Range(0,1)) = 0.5
 _EdgeOut ("Edge Out Range", Range(1,2)) = 1.5
 _FlameWidth ("Flame Width", Range(1,30)) = 20
 _Shining ("Shining", Range(0,1)) = 1
 _Opacity ("Opacity", Range(0,1)) = 1
 _Transparent ("Transparent", Range(0,1)) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Name "BASE"
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
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
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
uniform lowp vec4 _FXColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 viewDir_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (_World2Object * tmpvar_3)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = clamp (((
    (1.0 - dot (normalize(_glesNormal), viewDir_1))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((_FXColor * (tmpvar_5 * 
    (tmpvar_5 * (3.0 - (2.0 * tmpvar_5)))
  )) * 2.0);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw);
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform mediump float _FlameWidth;
uniform mediump float _Shining;
uniform mediump float _Opacity;
uniform mediump float _Transparent;
uniform lowp vec4 _FXColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp float alpha_2;
  lowp vec3 finalcol_3;
  mediump float Math_If_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FXTex, xlv_TEXCOORD1);
  if ((tmpvar_6.x <= _Shining)) {
    Math_If_4 = 1.0;
  } else {
    Math_If_4 = 0.0;
  };
  mediump float tmpvar_7;
  tmpvar_7 = (((1.0 - 
    clamp (((_Shining - tmpvar_6.x) * _FlameWidth), 0.0, 1.0)
  ) * Math_If_4) * 2.0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = (((_FXColor.xyz * tmpvar_7) + tmpvar_5.xyz) + xlv_COLOR.xyz);
  finalcol_3 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (max (tmpvar_7, xlv_COLOR.w) + _Opacity);
  alpha_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = finalcol_3;
  tmpvar_10.w = (alpha_2 * _Transparent);
  ret_1 = tmpvar_10;
  gl_FragData[0] = ret_1;
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
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
uniform lowp vec4 _FXColor;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec3 viewDir_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (_World2Object * tmpvar_3)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_1 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = clamp (((
    (1.0 - dot (normalize(_glesNormal), viewDir_1))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((_FXColor * (tmpvar_5 * 
    (tmpvar_5 * (3.0 - (2.0 * tmpvar_5)))
  )) * 2.0);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw);
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform mediump float _FlameWidth;
uniform mediump float _Shining;
uniform mediump float _Opacity;
uniform mediump float _Transparent;
uniform lowp vec4 _FXColor;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp float alpha_2;
  lowp vec3 finalcol_3;
  mediump float Math_If_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_FXTex, xlv_TEXCOORD1);
  if ((tmpvar_6.x <= _Shining)) {
    Math_If_4 = 1.0;
  } else {
    Math_If_4 = 0.0;
  };
  mediump float tmpvar_7;
  tmpvar_7 = (((1.0 - 
    clamp (((_Shining - tmpvar_6.x) * _FlameWidth), 0.0, 1.0)
  ) * Math_If_4) * 2.0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = (((_FXColor.xyz * tmpvar_7) + tmpvar_5.xyz) + xlv_COLOR.xyz);
  finalcol_3 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (max (tmpvar_7, xlv_COLOR.w) + _Opacity);
  alpha_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = finalcol_3;
  tmpvar_10.w = (alpha_2 * _Transparent);
  ret_1 = tmpvar_10;
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