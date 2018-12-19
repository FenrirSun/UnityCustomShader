Shader "VX/Character/CharacterSimple" {
Properties {
 _TintColor ("Tint Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "grey" {}
 _MatCap ("MatCap (RGB)", 2D) = "grey" {}
 _CombinedMap ("G(Gloss)", 2D) = "grey" {}
 _FlashColor ("Flash", Color) = (1,1,1,1)
 _Flash ("Flash", Range(0,1)) = 0
 _GlobalTiniColor ("Global Tint Color", Color) = (1,1,1,1)
}
SubShader { 
 LOD 200
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Geometry" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
  _glesFragData[0] = tmpvar_8;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float tmpvar_8;
  mediump float lightShadowDataX_9;
  highp float dist_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
  dist_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (float((dist_10 > 
    (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
  )), lightShadowDataX_9);
  tmpvar_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (((final_1 * tmpvar_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_14;
  gl_FragData[0] = tmpvar_14;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float tmpvar_8;
  mediump float lightShadowDataX_9;
  highp float dist_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
  dist_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (float((dist_10 > 
    (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
  )), lightShadowDataX_9);
  tmpvar_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (((final_1 * tmpvar_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_14;
  gl_FragData[0] = tmpvar_14;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float tmpvar_8;
  mediump float lightShadowDataX_9;
  highp float dist_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
  dist_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (float((dist_10 > 
    (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
  )), lightShadowDataX_9);
  tmpvar_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (((final_1 * tmpvar_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_14;
  gl_FragData[0] = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_8;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_8;
  _glesFragData[0] = tmpvar_8;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float tmpvar_8;
  mediump float lightShadowDataX_9;
  highp float dist_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
  dist_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = max (float((dist_10 > 
    (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
  )), lightShadowDataX_9);
  tmpvar_8 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (((final_1 * tmpvar_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_14;
  gl_FragData[0] = tmpvar_14;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  lowp float tmpvar_9;
  tmpvar_9 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  highp float tmpvar_10;
  tmpvar_10 = (_LightShadowData.x + (tmpvar_9 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_11;
  gl_FragData[0] = tmpvar_11;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  mediump float tmpvar_9;
  tmpvar_9 = texture (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  lowp float tmpvar_10;
  tmpvar_10 = tmpvar_9;
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_12;
  _glesFragData[0] = tmpvar_12;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  lowp float tmpvar_9;
  tmpvar_9 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  highp float tmpvar_10;
  tmpvar_10 = (_LightShadowData.x + (tmpvar_9 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_11;
  gl_FragData[0] = tmpvar_11;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  mediump float tmpvar_9;
  tmpvar_9 = texture (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  lowp float tmpvar_10;
  tmpvar_10 = tmpvar_9;
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_12;
  _glesFragData[0] = tmpvar_12;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  lowp float tmpvar_9;
  tmpvar_9 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  highp float tmpvar_10;
  tmpvar_10 = (_LightShadowData.x + (tmpvar_9 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_11;
  gl_FragData[0] = tmpvar_11;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  mediump float tmpvar_9;
  tmpvar_9 = texture (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  lowp float tmpvar_10;
  tmpvar_10 = tmpvar_9;
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_12;
  _glesFragData[0] = tmpvar_12;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  lowp float tmpvar_9;
  tmpvar_9 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  highp float tmpvar_10;
  tmpvar_10 = (_LightShadowData.x + (tmpvar_9 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_11;
  gl_FragData[0] = tmpvar_11;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.xy = tmpvar_4;
  highp vec4 v_5;
  v_5.x = glstate_matrix_invtrans_modelview0[0].x;
  v_5.y = glstate_matrix_invtrans_modelview0[1].x;
  v_5.z = glstate_matrix_invtrans_modelview0[2].x;
  v_5.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_6;
  tmpvar_6 = dot (v_5.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_6;
  highp vec4 v_7;
  v_7.x = glstate_matrix_invtrans_modelview0[0].y;
  v_7.y = glstate_matrix_invtrans_modelview0[1].y;
  v_7.z = glstate_matrix_invtrans_modelview0[2].y;
  v_7.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_8;
  tmpvar_8 = dot (v_7.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_8;
  tmpvar_3.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor);
  Albedo_3.xyz = (Albedo_3.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD0.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  lowp float shadow_8;
  mediump float tmpvar_9;
  tmpvar_9 = texture (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  lowp float tmpvar_10;
  tmpvar_10 = tmpvar_9;
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (((final_1 * shadow_8) / (1.0 + _Flash)) + (_Flash * _FlashColor));
  final_1 = tmpvar_12;
  _glesFragData[0] = tmpvar_12;
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
}
SubShader { 
 LOD 100
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Geometry" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec3 _TintColor;
uniform lowp vec4 _GlobalTiniColor;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 Albedo_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0.xy);
  Albedo_1.w = tmpvar_2.w;
  Albedo_1.xyz = (tmpvar_2.xyz * _TintColor);
  Albedo_1.xyz = (Albedo_1.xyz * _GlobalTiniColor.xyz);
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((Albedo_1 / (1.0 + _Flash)) + (_Flash * _FlashColor));
  _glesFragData[0] = tmpvar_3;
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
}
Fallback "VertexLit"
}