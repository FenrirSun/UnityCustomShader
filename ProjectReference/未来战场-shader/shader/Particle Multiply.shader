Shader "VX/Particles/Multiply" {
Properties {
 _MainTex ("Particle Texture", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog {
   Color (1,1,1,1)
  }
  Blend Zero SrcColor
Program "vp" {
SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
  prev_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * texture (_MainTex, xlv_TEXCOORD0));
  prev_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
  prev_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 prev_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * texture (_MainTex, xlv_TEXCOORD0));
  prev_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3"
}
}
 }
}
}