Shader "VX/Character New/LobbyMatCapAlphaBlend" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Color Map (RGB)", 2D) = "white" {}
 _Alpha ("Alpha Mask", 2D) = "white" {}
 _BumpMap ("Normal Map", 2D) = "bump" {}
 _MatCap ("MatCap (RGB)", 2D) = "black" {}
 _MaskMap ("R(Rim) G(Specular) B(MatCap)", 2D) = "white" {}
 _RimColor ("Rim Color", Color) = (1,1,1,1)
 _EdgeIn ("Edge In Range", Range(0,1)) = 0.5
 _EdgeOut ("Edge Out Range", Range(1,2)) = 1.5
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transaprent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transaprent" }
  Cull Off
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture2D (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  _glesFragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture2D (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  _glesFragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture2D (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  _glesFragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
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
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_15)
  )));
  nh_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_6.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_5 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_19.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_5 + (texture2D (_MatCap, tmpvar_20).xyz * tmpvar_8.z));
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_21 + ((_RimColor.xyz * 
    (tmpvar_22 * (tmpvar_22 * (3.0 - (2.0 * tmpvar_22))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = finalColor_5;
  tmpvar_25.w = alpha_2;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
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
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_15)
  )));
  nh_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_6.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_5 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_19.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_5 + (texture2D (_MatCap, tmpvar_20).xyz * tmpvar_8.z));
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_21 + ((_RimColor.xyz * 
    (tmpvar_22 * (tmpvar_22 * (3.0 - (2.0 * tmpvar_22))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = finalColor_5;
  tmpvar_25.w = alpha_2;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
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
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_15)
  )));
  nh_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_6.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_5 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_19.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_5 + (texture2D (_MatCap, tmpvar_20).xyz * tmpvar_8.z));
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_21 + ((_RimColor.xyz * 
    (tmpvar_22 * (tmpvar_22 * (3.0 - (2.0 * tmpvar_22))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = finalColor_5;
  tmpvar_25.w = alpha_2;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture2D (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_9)
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_12;
  mediump vec2 tmpvar_13;
  tmpvar_13.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_13.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * 0.5) + 0.5);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_5 + (texture (_MatCap, tmpvar_14).xyz * tmpvar_8.z));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((
    (1.0 - dot (tmpvar_9, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 + ((_RimColor.xyz * 
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = finalColor_5;
  tmpvar_19.w = alpha_2;
  tmpvar_1 = tmpvar_19;
  _glesFragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
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
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_15)
  )));
  nh_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_6.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_5 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_19.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_5 + (texture2D (_MatCap, tmpvar_20).xyz * tmpvar_8.z));
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_21 + ((_RimColor.xyz * 
    (tmpvar_22 * (tmpvar_22 * (3.0 - (2.0 * tmpvar_22))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = finalColor_5;
  tmpvar_25.w = alpha_2;
  tmpvar_1 = tmpvar_25;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_12)
  )));
  nh_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    ((tmpvar_6.xyz * tmpvar_13) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_16.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * 0.5) + 0.5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_5 + (texture2D (_MatCap, tmpvar_17).xyz * tmpvar_8.z));
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_18 + ((_RimColor.xyz * 
    (tmpvar_19 * (tmpvar_19 * (3.0 - (2.0 * tmpvar_19))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = finalColor_5;
  tmpvar_22.w = alpha_2;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_13)
  )));
  nh_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_6.xyz * tmpvar_14) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_17.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_18;
  tmpvar_18 = ((tmpvar_17 * 0.5) + 0.5);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_5 + (texture (_MatCap, tmpvar_18).xyz * tmpvar_8.z));
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - dot (tmpvar_13, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_19 + ((_RimColor.xyz * 
    (tmpvar_20 * (tmpvar_20 * (3.0 - (2.0 * tmpvar_20))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = finalColor_5;
  tmpvar_23.w = alpha_2;
  tmpvar_1 = tmpvar_23;
  _glesFragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_12)
  )));
  nh_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    ((tmpvar_6.xyz * tmpvar_13) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_16.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * 0.5) + 0.5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_5 + (texture2D (_MatCap, tmpvar_17).xyz * tmpvar_8.z));
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_18 + ((_RimColor.xyz * 
    (tmpvar_19 * (tmpvar_19 * (3.0 - (2.0 * tmpvar_19))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = finalColor_5;
  tmpvar_22.w = alpha_2;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_13)
  )));
  nh_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_6.xyz * tmpvar_14) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_17.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_18;
  tmpvar_18 = ((tmpvar_17 * 0.5) + 0.5);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_5 + (texture (_MatCap, tmpvar_18).xyz * tmpvar_8.z));
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - dot (tmpvar_13, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_19 + ((_RimColor.xyz * 
    (tmpvar_20 * (tmpvar_20 * (3.0 - (2.0 * tmpvar_20))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = finalColor_5;
  tmpvar_23.w = alpha_2;
  tmpvar_1 = tmpvar_23;
  _glesFragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_12)
  )));
  nh_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    ((tmpvar_6.xyz * tmpvar_13) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_16.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * 0.5) + 0.5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_5 + (texture2D (_MatCap, tmpvar_17).xyz * tmpvar_8.z));
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_18 + ((_RimColor.xyz * 
    (tmpvar_19 * (tmpvar_19 * (3.0 - (2.0 * tmpvar_19))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = finalColor_5;
  tmpvar_22.w = alpha_2;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_13)
  )));
  nh_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_6.xyz * tmpvar_14) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_17.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_18;
  tmpvar_18 = ((tmpvar_17 * 0.5) + 0.5);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_5 + (texture (_MatCap, tmpvar_18).xyz * tmpvar_8.z));
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - dot (tmpvar_13, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_19 + ((_RimColor.xyz * 
    (tmpvar_20 * (tmpvar_20 * (3.0 - (2.0 * tmpvar_20))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = finalColor_5;
  tmpvar_23.w = alpha_2;
  tmpvar_1 = tmpvar_23;
  _glesFragData[0] = tmpvar_1;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_12)
  )));
  nh_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    ((tmpvar_6.xyz * tmpvar_13) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_16.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * 0.5) + 0.5);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_5 + (texture2D (_MatCap, tmpvar_17).xyz * tmpvar_8.z));
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_18 + ((_RimColor.xyz * 
    (tmpvar_19 * (tmpvar_19 * (3.0 - (2.0 * tmpvar_19))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = finalColor_5;
  tmpvar_22.w = alpha_2;
  tmpvar_1 = tmpvar_22;
  gl_FragData[0] = tmpvar_1;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out mediump vec3 xlv_TEXCOORD5;
out mediump vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_2.xyz;
  tmpvar_8 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_1.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_1.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_1.z;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_12;
  highp vec4 v_13;
  v_13.x = glstate_matrix_invtrans_modelview0[0].x;
  v_13.y = glstate_matrix_invtrans_modelview0[1].x;
  v_13.z = glstate_matrix_invtrans_modelview0[2].x;
  v_13.w = glstate_matrix_invtrans_modelview0[3].x;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_9 * v_13.xyz);
  tmpvar_5 = tmpvar_14;
  highp vec4 v_15;
  v_15.x = glstate_matrix_invtrans_modelview0[0].y;
  v_15.y = glstate_matrix_invtrans_modelview0[1].y;
  v_15.z = glstate_matrix_invtrans_modelview0[2].y;
  v_15.w = glstate_matrix_invtrans_modelview0[3].y;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_9 * v_15.xyz);
  tmpvar_6 = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _MatCap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in mediump vec3 xlv_TEXCOORD5;
in mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lightDir_4 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + tmpvar_13)
  )));
  nh_3 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_6.xyz * tmpvar_14) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = dot (xlv_TEXCOORD5, tmpvar_7);
  tmpvar_17.y = dot (xlv_TEXCOORD6, tmpvar_7);
  mediump vec2 tmpvar_18;
  tmpvar_18 = ((tmpvar_17 * 0.5) + 0.5);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_5 + (texture (_MatCap, tmpvar_18).xyz * tmpvar_8.z));
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((
    (1.0 - dot (tmpvar_13, tmpvar_7))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_19 + ((_RimColor.xyz * 
    (tmpvar_20 * (tmpvar_20 * (3.0 - (2.0 * tmpvar_20))))
  ) * tmpvar_8.x));
  finalColor_5 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = finalColor_5;
  tmpvar_23.w = alpha_2;
  tmpvar_1 = tmpvar_23;
  _glesFragData[0] = tmpvar_1;
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
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transaprent" }
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha One
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(tmpvar_9)).w;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD1);
  lightDir_4 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_6.xyz * tmpvar_12) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_10) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = finalColor_5;
  tmpvar_16.w = alpha_2;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_10;
  tmpvar_10 = texture (_LightTexture0, vec2(tmpvar_9)).w;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD1);
  lightDir_4 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_6.xyz * tmpvar_12) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_10) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = finalColor_5;
  tmpvar_16.w = alpha_2;
  tmpvar_1 = tmpvar_16;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((
    (tmpvar_6.xyz * tmpvar_9)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = finalColor_5;
  tmpvar_13.w = alpha_2;
  tmpvar_1 = tmpvar_13;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_4 = xlv_TEXCOORD1;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((
    (tmpvar_6.xyz * tmpvar_9)
   + 
    ((_SpecColor.xyz * pow (nh_3, (_Shininess * 128.0))) * tmpvar_8.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = finalColor_5;
  tmpvar_13.w = alpha_2;
  tmpvar_1 = tmpvar_13;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp float attenuation_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_10 = texture2D (_LightTexture0, P_11);
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(tmpvar_12));
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * tmpvar_10.w) * tmpvar_13.w);
  attenuation_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD1);
  lightDir_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_8, lightDir_4));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_7.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_9.y))
   * _LightColor0.xyz) * attenuation_6) * 2.0);
  finalColor_5 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_5;
  tmpvar_20.w = alpha_2;
  tmpvar_1 = tmpvar_20;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp float attenuation_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_10 = texture (_LightTexture0, P_11);
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_LightTextureB0, vec2(tmpvar_12));
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * tmpvar_10.w) * tmpvar_13.w);
  attenuation_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD1);
  lightDir_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_8, lightDir_4));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_7.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_9.y))
   * _LightColor0.xyz) * attenuation_6) * 2.0);
  finalColor_5 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = finalColor_5;
  tmpvar_20.w = alpha_2;
  tmpvar_1 = tmpvar_20;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(tmpvar_9)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD1);
  lightDir_4 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_6.xyz * tmpvar_12) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_10) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = finalColor_5;
  tmpvar_16.w = alpha_2;
  tmpvar_1 = tmpvar_16;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_10;
  tmpvar_10 = (texture (_LightTextureB0, vec2(tmpvar_9)).w * texture (_LightTexture0, xlv_TEXCOORD3).w);
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD1);
  lightDir_4 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_6.xyz * tmpvar_12) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_10) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = finalColor_5;
  tmpvar_16.w = alpha_2;
  tmpvar_1 = tmpvar_16;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  lightDir_4 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_6.xyz * tmpvar_10) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_5 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2D (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = finalColor_5;
  tmpvar_14.w = alpha_2;
  tmpvar_1 = tmpvar_14;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2.xyz;
  tmpvar_6 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_1.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_1.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_1.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float alpha_2;
  highp float nh_3;
  lowp vec3 lightDir_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = (texture (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_9;
  tmpvar_9 = texture (_LightTexture0, xlv_TEXCOORD3).w;
  lightDir_4 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_7, lightDir_4));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_7, normalize(
    (lightDir_4 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_6.xyz * tmpvar_10) + ((_SpecColor.xyz * pow (nh_3, 
      (_Shininess * 128.0)
    )) * tmpvar_8.y))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_5 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture (_Alpha, xlv_TEXCOORD0).x;
  alpha_2 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = finalColor_5;
  tmpvar_14.w = alpha_2;
  tmpvar_1 = tmpvar_14;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}
}
 }
 UsePass "VertexLit/SHADOWCASTER"
 UsePass "VertexLit/SHADOWCOLLECTOR"
}
Fallback Off
}