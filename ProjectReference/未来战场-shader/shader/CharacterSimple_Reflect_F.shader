Shader "VX/Character/CharacterSimple_Reflective_F" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "grey" {}
 _MatCap ("MatCap (RGB)", 2D) = "grey" {}
 _CombinedMap ("R(Alpha),G(Gloss),B(Reflection)", 2D) = "grey" {}
 _Cube ("Cube", CUBE) = "black" {}
 _ReflectionThreshold ("ReflectionThreshold", Range(0,1)) = 1
 _FlashColor ("Flash", Color) = (0.5,0.5,0.5,1)
 _Flash ("Flash", Range(0,1)) = 0
 _FresnelColor ("FColor", Color) = (0,0,0,1)
 _FresnelMin ("FMin", Range(0,1)) = 0
 _FresnelMax ("FMax", Range(0,1)) = 1
 _FresnelScale ("FScale", Range(0,2)) = 1
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  gl_FragData[0] = final_3;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  _glesFragData[0] = final_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  gl_FragData[0] = final_3;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  _glesFragData[0] = final_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  gl_FragData[0] = final_3;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  _glesFragData[0] = final_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = (final_3 * tmpvar_12);
  final_3 = tmpvar_18;
  gl_FragData[0] = tmpvar_18;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = (final_3 * tmpvar_12);
  final_3 = tmpvar_18;
  gl_FragData[0] = tmpvar_18;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = (final_3 * tmpvar_12);
  final_3 = tmpvar_18;
  gl_FragData[0] = tmpvar_18;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  gl_FragData[0] = final_3;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  _glesFragData[0] = final_3;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform sampler2D _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD5.z / xlv_TEXCOORD5.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = (final_3 * tmpvar_12);
  final_3 = tmpvar_18;
  gl_FragData[0] = tmpvar_18;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = (final_3 * shadow_12);
  final_3 = tmpvar_15;
  gl_FragData[0] = tmpvar_15;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_3 * shadow_12);
  final_3 = tmpvar_16;
  _glesFragData[0] = tmpvar_16;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = (final_3 * shadow_12);
  final_3 = tmpvar_15;
  gl_FragData[0] = tmpvar_15;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_3 * shadow_12);
  final_3 = tmpvar_16;
  _glesFragData[0] = tmpvar_16;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = (final_3 * shadow_12);
  final_3 = tmpvar_15;
  gl_FragData[0] = tmpvar_15;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_3 * shadow_12);
  final_3 = tmpvar_16;
  _glesFragData[0] = tmpvar_16;
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
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (textureCube (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = (final_3 * shadow_12);
  final_3 = tmpvar_15;
  gl_FragData[0] = tmpvar_15;
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
out mediump vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
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
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (tmpvar_6 - (2.0 * (
    dot (worldNormal_3, tmpvar_6)
   * worldNormal_3)));
  xlv_TEXCOORD3 = worldNormal_3;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (unity_World2Shadow[0] * cse_8);
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
uniform lowp vec4 _FresnelColor;
uniform lowp float _FresnelMin;
uniform lowp float _FresnelMax;
uniform lowp float _FresnelScale;
uniform lowp sampler2DShadow _ShadowMapTexture;
in mediump vec3 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 f_color_1;
  highp vec4 mc_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 + (_Flash * _FlashColor));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_CombinedMap, xlv_TEXCOORD1.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MatCap, xlv_TEXCOORD1.zw);
  mc_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 + ((
    (mc_2 * 2.0)
   - 1.0) * tmpvar_6.y));
  final_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (final_3 + (texture (_Cube, xlv_TEXCOORD2) * clamp (
    (((tmpvar_6.z * 2.0) - 1.0) - _ReflectionThreshold)
  , 0.0, 1.0)));
  final_3.w = tmpvar_9.w;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + (tmpvar_4.xyz * xlv_TEXCOORD0));
  final_3.xyz = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = (((
    (clamp ((1.0 - dot (
      normalize(xlv_TEXCOORD3)
    , 
      normalize(xlv_TEXCOORD4)
    )), _FresnelMin, _FresnelMax) - _FresnelMin)
   * 
    (_FresnelMax - _FresnelMin)
  ) * _FresnelScale) * _FresnelColor);
  f_color_1 = tmpvar_11;
  final_3.xyz = (final_3.xyz + f_color_1.xyz);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD5.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = (final_3 * shadow_12);
  final_3 = tmpvar_16;
  _glesFragData[0] = tmpvar_16;
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