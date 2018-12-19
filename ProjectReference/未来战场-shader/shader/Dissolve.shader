Shader "VX/FX/Dissolve" {
Properties {
 _TintValue ("Tint Value", Range(0,1)) = 1
 _MainTex ("Color (RGB)", 2D) = "white" {}
 _DissolveTex ("Dissolve (RGB)", 2D) = "white" {}
 _DissolveValue ("DissolveValue", Range(0,1)) = 1
 _Tile ("Tile", Float) = 1
 _DissColor ("DissColor", Color) = (1,1,1,1)
 _DissStartValue ("DissolveStartValue", Range(0,1)) = 1
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 pos_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  pos_1 = tmpvar_5;
  tmpvar_2 = pos_1;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform mediump float _DissolveValue;
uniform mediump float _TintValue;
uniform mediump float _Tile;
uniform lowp vec4 _DissColor;
uniform mediump float _DissStartValue;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  lowp float alpha_2;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD1.xy / _Tile);
  mediump vec2 P_4;
  P_4 = (xlv_TEXCOORD1.yz / _Tile);
  lowp float tmpvar_5;
  tmpvar_5 = (texture2D (_DissolveTex, P_3).x * texture2D (_DissolveTex, P_4).y);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5 - _DissolveValue);
  alpha_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  final_1 = tmpvar_7;
  if ((alpha_2 < 0.0)) {
    discard;
  } else {
    lowp float tmpvar_8;
    tmpvar_8 = clamp ((alpha_2 * 20.0), 0.0, 1.0);
    alpha_2 = tmpvar_8;
    if ((tmpvar_8 > _DissStartValue)) {
      mediump vec4 tmpvar_9;
      tmpvar_9.xyz = (tmpvar_7.xyz * _TintValue);
      tmpvar_9.w = (tmpvar_8 * tmpvar_7.w);
      final_1 = tmpvar_9;
    } else {
      lowp vec4 tmpvar_10;
      tmpvar_10.xyz = _DissColor.xyz;
      tmpvar_10.w = tmpvar_8;
      final_1 = tmpvar_10;
    };
  };
  gl_FragData[0] = final_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform lowp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 pos_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  pos_1 = tmpvar_5;
  tmpvar_2 = pos_1;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  tmpvar_4 = tmpvar_7;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _DissolveTex;
uniform mediump float _DissolveValue;
uniform mediump float _TintValue;
uniform mediump float _Tile;
uniform lowp vec4 _DissColor;
uniform mediump float _DissStartValue;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  lowp float alpha_2;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD1.xy / _Tile);
  mediump vec2 P_4;
  P_4 = (xlv_TEXCOORD1.yz / _Tile);
  lowp float tmpvar_5;
  tmpvar_5 = (texture (_DissolveTex, P_3).x * texture (_DissolveTex, P_4).y);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5 - _DissolveValue);
  alpha_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  final_1 = tmpvar_7;
  if ((alpha_2 < 0.0)) {
    discard;
  } else {
    lowp float tmpvar_8;
    tmpvar_8 = clamp ((alpha_2 * 20.0), 0.0, 1.0);
    alpha_2 = tmpvar_8;
    if ((tmpvar_8 > _DissStartValue)) {
      mediump vec4 tmpvar_9;
      tmpvar_9.xyz = (tmpvar_7.xyz * _TintValue);
      tmpvar_9.w = (tmpvar_8 * tmpvar_7.w);
      final_1 = tmpvar_9;
    } else {
      lowp vec4 tmpvar_10;
      tmpvar_10.xyz = _DissColor.xyz;
      tmpvar_10.w = tmpvar_8;
      final_1 = tmpvar_10;
    };
  };
  _glesFragData[0] = final_1;
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