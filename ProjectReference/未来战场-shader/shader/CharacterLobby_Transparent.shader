Shader "VX/Character/CharacterLobby_Transparent" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "grey" {}
 _NormalMap ("NormalMap", 2D) = "black" {}
 _MatCap ("MatCap (RGB)", 2D) = "grey" {}
 _LightMap ("R(Rim Coef) G(Matcap),B(Alpha)", 2D) = "grey" {}
 _RimPower ("Rim Power", Range(0.5,8)) = 1.5
 _RimColor ("Rim Color", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transaprent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transaprent" }
  ZWrite Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 * v_13.xyz);
  tmpvar_6 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_12 * v_15.xyz);
  tmpvar_7 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _Object2World[0].xyz;
  tmpvar_19[1] = _Object2World[1].xyz;
  tmpvar_19[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * tmpvar_2);
  worldNormal_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_8 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_8 - (2.0 * (
    dot (worldNormal_3, tmpvar_8)
   * worldNormal_3)));
  tmpvar_8 = tmpvar_22;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = (tmpvar_12 * ((
    (_World2Object * tmpvar_17)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_22;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform sampler2D _LightMap;
uniform sampler2D _MatCap;
uniform lowp vec3 _RimColor;
uniform highp float _RimPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  highp vec2 mcuv_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_LightMap, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1, tmpvar_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2, tmpvar_6);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * 0.5) + 0.5);
  mcuv_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MatCap, mcuv_2);
  mc_1 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (final_3.xyz + ((
    pow ((1.0 - clamp (dot (tmpvar_6, 
      normalize(xlv_TEXCOORD3)
    ), 0.0, 1.0)), _RimPower)
   * _RimColor) * tmpvar_5.x));
  final_3.xyz = tmpvar_11;
  final_3.w = tmpvar_5.z;
  gl_FragData[0] = final_3;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 worldNormal_3;
  mediump vec3 worldPos_4;
  mediump vec2 tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 * v_13.xyz);
  tmpvar_6 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_12 * v_15.xyz);
  tmpvar_7 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * _glesVertex).xyz;
  worldPos_4 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _Object2World[0].xyz;
  tmpvar_19[1] = _Object2World[1].xyz;
  tmpvar_19[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * tmpvar_2);
  worldNormal_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_WorldSpaceCameraPos - worldPos_4);
  tmpvar_8 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_8 - (2.0 * (
    dot (worldNormal_3, tmpvar_8)
   * worldNormal_3)));
  tmpvar_8 = tmpvar_22;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = (tmpvar_12 * ((
    (_World2Object * tmpvar_17)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = tmpvar_22;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap;
uniform sampler2D _LightMap;
uniform sampler2D _MatCap;
uniform lowp vec3 _RimColor;
uniform highp float _RimPower;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 mc_1;
  highp vec2 mcuv_2;
  lowp vec4 final_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_LightMap, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1, tmpvar_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2, tmpvar_6);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * 0.5) + 0.5);
  mcuv_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MatCap, mcuv_2);
  mc_1 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_4 + ((
    (mc_1 * 2.0)
   - 1.0) * tmpvar_5.y));
  final_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (final_3.xyz + ((
    pow ((1.0 - clamp (dot (tmpvar_6, 
      normalize(xlv_TEXCOORD3)
    ), 0.0, 1.0)), _RimPower)
   * _RimColor) * tmpvar_5.x));
  final_3.xyz = tmpvar_11;
  final_3.w = tmpvar_5.z;
  _glesFragData[0] = final_3;
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