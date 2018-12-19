Shader "VX/Character/CharacterSimpleWithAlpha" {
Properties {
 _TintColor ("Tint Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "grey" {}
 _MatCap ("MatCap (RGB)", 2D) = "grey" {}
 _CombinedMap ("G(Gloss)", 2D) = "grey" {}
 _FlashColor ("Flash", Color) = (1,1,1,1)
 _Flash ("Flash", Range(0,1)) = 0
}
SubShader { 
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent" "RenderType"="Transparent" }
  Lighting On
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float tmpvar_9;
  mediump float lightShadowDataX_10;
  highp float dist_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = max (float((dist_11 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_10);
  tmpvar_9 = tmpvar_14;
  final_1.xyz = (((final_1 * tmpvar_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float tmpvar_9;
  mediump float lightShadowDataX_10;
  highp float dist_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = max (float((dist_11 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_10);
  tmpvar_9 = tmpvar_14;
  final_1.xyz = (((final_1 * tmpvar_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float tmpvar_9;
  mediump float lightShadowDataX_10;
  highp float dist_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = max (float((dist_11 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_10);
  tmpvar_9 = tmpvar_14;
  final_1.xyz = (((final_1 * tmpvar_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_1);
  worldNormal_3 = tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec3 pos_10;
  pos_10 = worldPos_4;
  highp vec3 normal_11;
  normal_11 = worldNormal_3;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosX0 - pos_10.x);
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosY0 - pos_10.y);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosZ0 - pos_10.z);
  highp vec4 tmpvar_15;
  tmpvar_15 = (((tmpvar_12 * tmpvar_12) + (tmpvar_13 * tmpvar_13)) + (tmpvar_14 * tmpvar_14));
  highp vec4 tmpvar_16;
  tmpvar_16 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_12 * normal_11.x) + (tmpvar_13 * normal_11.y)) + (tmpvar_14 * normal_11.z))
   * 
    inversesqrt(tmpvar_15)
  )) * (1.0/((1.0 + 
    (tmpvar_15 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (unity_LightColor[0].xyz * tmpvar_16.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_16.y)
  ) + (unity_LightColor[2].xyz * tmpvar_16.z)) + (unity_LightColor[3].xyz * tmpvar_16.w));
  tmpvar_9 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_18;
  highp vec4 v_19;
  v_19.x = glstate_matrix_invtrans_modelview0[0].x;
  v_19.y = glstate_matrix_invtrans_modelview0[1].x;
  v_19.z = glstate_matrix_invtrans_modelview0[2].x;
  v_19.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_20;
  tmpvar_20 = dot (v_19.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].y;
  v_21.y = glstate_matrix_invtrans_modelview0[1].y;
  v_21.z = glstate_matrix_invtrans_modelview0[2].y;
  v_21.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_22;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  final_1.xyz = ((final_1 / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp vec4 _TintColor;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float tmpvar_9;
  mediump float lightShadowDataX_10;
  highp float dist_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_11 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = max (float((dist_11 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_10);
  tmpvar_9 = tmpvar_14;
  final_1.xyz = (((final_1 * tmpvar_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  gl_FragData[0] = final_1;
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
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
out mediump vec3 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = cse_7.xyz;
  worldPos_4 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * tmpvar_1);
  worldNormal_3 = tmpvar_9;
  mediump vec3 tmpvar_10;
  highp vec3 pos_11;
  pos_11 = worldPos_4;
  highp vec3 normal_12;
  normal_12 = worldNormal_3;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosX0 - pos_11.x);
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosY0 - pos_11.y);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosZ0 - pos_11.z);
  highp vec4 tmpvar_16;
  tmpvar_16 = (((tmpvar_13 * tmpvar_13) + (tmpvar_14 * tmpvar_14)) + (tmpvar_15 * tmpvar_15));
  highp vec4 tmpvar_17;
  tmpvar_17 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_13 * normal_12.x) + (tmpvar_14 * normal_12.y)) + (tmpvar_15 * normal_12.z))
   * 
    inversesqrt(tmpvar_16)
  )) * (1.0/((1.0 + 
    (tmpvar_16 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    (unity_LightColor[0].xyz * tmpvar_17.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_17.y)
  ) + (unity_LightColor[2].xyz * tmpvar_17.z)) + (unity_LightColor[3].xyz * tmpvar_17.w));
  tmpvar_10 = tmpvar_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_19;
  highp vec4 v_20;
  v_20.x = glstate_matrix_invtrans_modelview0[0].x;
  v_20.y = glstate_matrix_invtrans_modelview0[1].x;
  v_20.z = glstate_matrix_invtrans_modelview0[2].x;
  v_20.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_21;
  tmpvar_21 = dot (v_20.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_21;
  highp vec4 v_22;
  v_22.x = glstate_matrix_invtrans_modelview0[0].y;
  v_22.y = glstate_matrix_invtrans_modelview0[1].y;
  v_22.z = glstate_matrix_invtrans_modelview0[2].y;
  v_22.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_23;
  tmpvar_23 = dot (v_22.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_23;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
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
uniform lowp vec4 _TintColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 final_1;
  highp vec4 mc_2;
  lowp vec4 Albedo_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  Albedo_3.w = tmpvar_4.w;
  Albedo_3.xyz = (tmpvar_4.xyz * _TintColor.xyz);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (Albedo_3 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_1 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (final_1.xyz + (Albedo_3.xyz * xlv_TEXCOORD0));
  final_1.xyz = tmpvar_8;
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  final_1.xyz = (((final_1 * shadow_9) / (1.0 + _Flash)) + (_Flash * _FlashColor)).xyz;
  final_1.w = _TintColor.w;
  _glesFragData[0] = final_1;
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