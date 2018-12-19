Shader "VX/Debug/DisplayDepth" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _DepthPower ("Depth Power", Range(1,5)) = 1
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_texture0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 inUV_4;
  inUV_4 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = inUV_4;
  tmpvar_3 = (glstate_matrix_texture0 * tmpvar_5).xy;
  tmpvar_2 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ZBufferParams;
uniform lowp float _DepthPower;
uniform sampler2D _CameraDepthTexture;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float d_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x;
  d_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = pow ((1.0/((
    (_ZBufferParams.x * d_2)
   + _ZBufferParams.y))), _DepthPower);
  d_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(tmpvar_4);
  tmpvar_1 = tmpvar_5;
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
uniform highp mat4 glstate_matrix_texture0;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 inUV_4;
  inUV_4 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = inUV_4;
  tmpvar_3 = (glstate_matrix_texture0 * tmpvar_5).xy;
  tmpvar_2 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform lowp float _DepthPower;
uniform sampler2D _CameraDepthTexture;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float d_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_CameraDepthTexture, xlv_TEXCOORD0).x;
  d_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = pow ((1.0/((
    (_ZBufferParams.x * d_2)
   + _ZBufferParams.y))), _DepthPower);
  d_2 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(tmpvar_4);
  tmpvar_1 = tmpvar_5;
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
}
Fallback "Diffuse"
}