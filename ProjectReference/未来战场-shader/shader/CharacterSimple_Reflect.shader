Shader "VX/Character/CharacterSimple_Reflective" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "grey" {}
 _MatCap ("MatCap (RGB)", 2D) = "grey" {}
 _CombinedMap ("R(Alpha),G(Gloss),B(Reflection)", 2D) = "grey" {}
 _Cube ("Cube", CUBE) = "black" {}
 _ReflectionThreshold ("ReflectionThreshold", Range(0,1)) = 1
 _FlashColor ("Flash", Color) = (0.5,0.5,0.5,1)
 _Flash ("Flash", Range(0,1)) = 0
}
SubShader { 
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "RenderType"="Opaque" "Reflection"="RenderReflectionOpaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Geometry" "RenderType"="Opaque" "Reflection"="RenderReflectionOpaque" }
  Lighting On
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  gl_FragData[0] = final_2;
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
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  _glesFragData[0] = final_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  gl_FragData[0] = final_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  _glesFragData[0] = final_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  gl_FragData[0] = final_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  _glesFragData[0] = final_2;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_2 * tmpvar_10);
  final_2 = tmpvar_16;
  gl_FragData[0] = tmpvar_16;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_2 * tmpvar_10);
  final_2 = tmpvar_16;
  gl_FragData[0] = tmpvar_16;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_2 * tmpvar_10);
  final_2 = tmpvar_16;
  gl_FragData[0] = tmpvar_16;
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
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  gl_FragData[0] = final_2;
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
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_7;
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
  highp vec3 tmpvar_24;
  tmpvar_24 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_25;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  _glesFragData[0] = final_2;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_2 * tmpvar_10);
  final_2 = tmpvar_16;
  gl_FragData[0] = tmpvar_16;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (final_2 * shadow_10);
  final_2 = tmpvar_13;
  gl_FragData[0] = tmpvar_13;
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
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (final_2 * shadow_10);
  final_2 = tmpvar_14;
  _glesFragData[0] = tmpvar_14;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (final_2 * shadow_10);
  final_2 = tmpvar_13;
  gl_FragData[0] = tmpvar_13;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (final_2 * shadow_10);
  final_2 = tmpvar_14;
  _glesFragData[0] = tmpvar_14;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (final_2 * shadow_10);
  final_2 = tmpvar_13;
  gl_FragData[0] = tmpvar_13;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (final_2 * shadow_10);
  final_2 = tmpvar_14;
  _glesFragData[0] = tmpvar_14;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (final_2 * shadow_10);
  final_2 = tmpvar_13;
  gl_FragData[0] = tmpvar_13;
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
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 capCoord_2;
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = cse_8.xyz;
  worldPos_4 = tmpvar_7;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_1);
  worldNormal_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  highp vec3 pos_12;
  pos_12 = worldPos_4;
  highp vec3 normal_13;
  normal_13 = worldNormal_3;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_4LightPosX0 - pos_12.x);
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosY0 - pos_12.y);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosZ0 - pos_12.z);
  highp vec4 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * tmpvar_14) + (tmpvar_15 * tmpvar_15)) + (tmpvar_16 * tmpvar_16));
  highp vec4 tmpvar_18;
  tmpvar_18 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_14 * normal_13.x) + (tmpvar_15 * normal_13.y)) + (tmpvar_16 * normal_13.z))
   * 
    inversesqrt(tmpvar_17)
  )) * (1.0/((1.0 + 
    (tmpvar_17 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (unity_LightColor[0].xyz * tmpvar_18.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_18.y)
  ) + (unity_LightColor[2].xyz * tmpvar_18.z)) + (unity_LightColor[3].xyz * tmpvar_18.w));
  tmpvar_11 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5.xy = tmpvar_20;
  highp vec4 v_21;
  v_21.x = glstate_matrix_invtrans_modelview0[0].x;
  v_21.y = glstate_matrix_invtrans_modelview0[1].x;
  v_21.z = glstate_matrix_invtrans_modelview0[2].x;
  v_21.w = glstate_matrix_invtrans_modelview0[3].x;
  highp float tmpvar_22;
  tmpvar_22 = dot (v_21.xyz, tmpvar_1);
  capCoord_2.x = tmpvar_22;
  highp vec4 v_23;
  v_23.x = glstate_matrix_invtrans_modelview0[0].y;
  v_23.y = glstate_matrix_invtrans_modelview0[1].y;
  v_23.z = glstate_matrix_invtrans_modelview0[2].y;
  v_23.w = glstate_matrix_invtrans_modelview0[3].y;
  highp float tmpvar_24;
  tmpvar_24 = dot (v_23.xyz, tmpvar_1);
  capCoord_2.y = tmpvar_24;
  tmpvar_5.zw = ((capCoord_2 * 0.5) + 0.5);
  highp vec3 tmpvar_25;
  tmpvar_25 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_6 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  tmpvar_6 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_26;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_8);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform sampler2D _MainTex;
uniform sampler2D _CombinedMap;
uniform sampler2D _MatCap;
uniform lowp samplerCube _Cube;
uniform lowp float _Flash;
uniform lowp vec4 _FlashColor;
uniform lowp float _ReflectionThreshold;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  lowp vec4 final_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_2 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (final_2 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_5.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_2.w = tmpvar_8.w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xyz + (tmpvar_3.xyz * xlv_TEXCOORD0));
  final_2.xyz = tmpvar_9;
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = (final_2 * shadow_10);
  final_2 = tmpvar_14;
  _glesFragData[0] = tmpvar_14;
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
Fallback "Mobile/Diffuse"
}