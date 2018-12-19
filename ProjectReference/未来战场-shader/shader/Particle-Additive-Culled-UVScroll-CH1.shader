Shader "VX/Particles/Additive Culled_UVScroll_CH1" {
Properties {
 _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _MainTex ("Particle Texture", 2D) = "white" {}
 _FXTex ("FX Map", 2D) = "black" {}
 _SpeedX ("Speed X", Float) = 10
 _SpeedY ("Speed Y", Float) = 10
}
SubShader { 
 Tags { "QUEUE"="Transparent+101" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent+101" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha One
  ColorMask RGB
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
uniform lowp vec4 _TintColor;
uniform int _SpeedX;
uniform int _SpeedY;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float Time_1;
  highp float tmpvar_2;
  tmpvar_2 = _Time.x;
  Time_1 = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = (xlv_TEXCOORD0.x + (Time_1 * float(_SpeedX)));
  tmpvar_3.y = (xlv_TEXCOORD0.y + (Time_1 * float(_SpeedY)));
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((texture2D (_MainTex, xlv_TEXCOORD0) * texture2D (_FXTex, tmpvar_3)) * _TintColor);
  gl_FragData[0] = tmpvar_4;
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
uniform lowp vec4 _TintColor;
uniform int _SpeedX;
uniform int _SpeedY;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float Time_1;
  highp float tmpvar_2;
  tmpvar_2 = _Time.x;
  Time_1 = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = (xlv_TEXCOORD0.x + (Time_1 * float(_SpeedX)));
  tmpvar_3.y = (xlv_TEXCOORD0.y + (Time_1 * float(_SpeedY)));
  lowp vec4 tmpvar_4;
  tmpvar_4 = ((texture (_MainTex, xlv_TEXCOORD0) * texture (_FXTex, tmpvar_3)) * _TintColor);
  _glesFragData[0] = tmpvar_4;
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
Fallback "VertexLit"
}