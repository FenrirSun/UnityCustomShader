Shader "VX/Scene New/Ice Effect" {
Properties {
 _Color ("Edge Color", Color) = (1,1,1,1)
 _EdgeIn ("Edge In Range", Range(0,1)) = 0.5
 _EdgeOut ("Edge Out Range", Range(1,2)) = 1.5
 _Tint ("Tint Color", Color) = (1,1,1,1)
 _MainTex ("Color Map (RGB)", 2D) = "white" {}
 _SpecTex ("Specular Map (RGB)", 2D) = "black" {}
 _SpecLevel ("Specular Level", Range(0,1)) = 0.5
}
SubShader { 
 LOD 100
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Cull Off
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  _glesFragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  _glesFragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  _glesFragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  _glesFragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  _glesFragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  _glesFragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump vec4 unity_LightmapST;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 lm_1;
  mediump vec4 texcol_2;
  mediump vec4 spec_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Tint);
  texcol_2.w = tmpvar_6.w;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_1 = tmpvar_7;
  texcol_2.xyz = ((tmpvar_6.xyz * lm_1) + tmpvar_6.xyz);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((texcol_2 + (spec_3 * _SpecLevel)) + xlv_COLOR);
  texcol_2 = tmpvar_8;
  _glesFragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_3[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_3[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (_World2Object * tmpvar_4)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = (((tmpvar_3 * tmpvar_1).xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_6 * (tmpvar_6 * 
    (3.0 - (2.0 * tmpvar_6))
  )));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Color;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec3 viewDir_2;
  mediump vec3 norm_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * tmpvar_1);
  norm_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  viewDir_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (((
    (1.0 - dot (tmpvar_1, viewDir_2))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((norm_3.xy * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  xlv_COLOR = (_Color * (tmpvar_8 * (tmpvar_8 * 
    (3.0 - (2.0 * tmpvar_8))
  )));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _SpecTex;
uniform mediump float _SpecLevel;
uniform mediump vec4 _Tint;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 spec_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_SpecTex, xlv_TEXCOORD2);
  spec_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  _glesFragData[0] = (((tmpvar_3 * _Tint) + (spec_1 * _SpecLevel)) + xlv_COLOR);
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }
 UsePass "VertexLit/SHADOWCASTER"
 UsePass "VertexLit/SHADOWCOLLECTOR"
}
Fallback Off
}