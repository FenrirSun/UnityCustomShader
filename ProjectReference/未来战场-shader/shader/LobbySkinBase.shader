Shader "VX/Character New/LobbySkinBase" {
Properties {
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _SpecLevel ("Specular Level", Range(0,1)) = 1
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _BumpMap ("Normal Map", 2D) = "bump" {}
 _MaskMap ("Mask R(Specular) G(Shadow)", 2D) = "white" {}
 _RampTex ("Diffuse Ramp", 2D) = "white" {}
 _DiffLevel ("Diffuse Level", Range(0,1)) = 1
 _ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  gl_FragData[0] = tmpvar_14;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  _glesFragData[0] = tmpvar_14;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  gl_FragData[0] = tmpvar_14;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  _glesFragData[0] = tmpvar_14;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  gl_FragData[0] = tmpvar_14;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  _glesFragData[0] = tmpvar_14;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float tmpvar_17;
  mediump float lightShadowDataX_18;
  highp float dist_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((dist_19 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_18);
  tmpvar_17 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((float(
    (NdotL_4 >= 0.1)
  ) * (tmpvar_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float tmpvar_17;
  mediump float lightShadowDataX_18;
  highp float dist_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((dist_19 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_18);
  tmpvar_17 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((float(
    (NdotL_4 >= 0.1)
  ) * (tmpvar_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float tmpvar_17;
  mediump float lightShadowDataX_18;
  highp float dist_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((dist_19 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_18);
  tmpvar_17 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((float(
    (NdotL_4 >= 0.1)
  ) * (tmpvar_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  gl_FragData[0] = tmpvar_14;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  mediump float NdotL_2;
  lowp vec3 lightDir_3;
  lowp vec3 finalColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_3 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, lightDir_3);
  NdotL_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_3 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ceil(NdotL_2);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = 0.5;
  tmpvar_11.y = ((0.45 * NdotL_2) + 0.45);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_RampTex, tmpvar_11);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_5.xyz * ((_DiffLevel * (tmpvar_12.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_7.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_4 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_4;
  _glesFragData[0] = tmpvar_14;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float tmpvar_17;
  mediump float lightShadowDataX_18;
  highp float dist_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((dist_19 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_18);
  tmpvar_17 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((float(
    (NdotL_4 >= 0.1)
  ) * (tmpvar_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_LightShadowData.x + (tmpvar_18 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_21;
  gl_FragData[0] = tmpvar_22;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  mediump float tmpvar_18;
  tmpvar_18 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_19;
  tmpvar_19 = tmpvar_18;
  highp float tmpvar_20;
  tmpvar_20 = (_LightShadowData.x + (tmpvar_19 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_22;
  _glesFragData[0] = tmpvar_23;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_LightShadowData.x + (tmpvar_18 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_21;
  gl_FragData[0] = tmpvar_22;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  mediump float tmpvar_18;
  tmpvar_18 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_19;
  tmpvar_19 = tmpvar_18;
  highp float tmpvar_20;
  tmpvar_20 = (_LightShadowData.x + (tmpvar_19 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_22;
  _glesFragData[0] = tmpvar_23;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_LightShadowData.x + (tmpvar_18 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_21;
  gl_FragData[0] = tmpvar_22;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  mediump float tmpvar_18;
  tmpvar_18 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_19;
  tmpvar_19 = tmpvar_18;
  highp float tmpvar_20;
  tmpvar_20 = (_LightShadowData.x + (tmpvar_19 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_22;
  _glesFragData[0] = tmpvar_23;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_LightShadowData.x + (tmpvar_18 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_21;
  gl_FragData[0] = tmpvar_22;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
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
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform sampler2D _RampTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp float _SpecLevel;
uniform highp float _Shininess;
uniform lowp float _DiffLevel;
uniform lowp vec4 _ShadowColor;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp float atten_1;
  lowp float intensity_2;
  highp float nh_3;
  mediump float NdotL_4;
  lowp vec3 lightDir_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_5 = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, lightDir_5);
  NdotL_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_8, normalize(
    (lightDir_5 + normalize(xlv_TEXCOORD2))
  )));
  nh_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = ceil(NdotL_4);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = 0.5;
  tmpvar_13.y = ((0.45 * NdotL_4) + 0.45);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_RampTex, tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_7.xyz * ((_DiffLevel * (tmpvar_14.xyz - 1.0)) + 1.0))
   + 
    (_SpecColor.xyz * (((tmpvar_12 * 
      pow (nh_3, (_Shininess * 128.0))
    ) * _SpecLevel) * tmpvar_9.x))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  intensity_2 = tmpvar_16;
  lowp float shadow_17;
  mediump float tmpvar_18;
  tmpvar_18 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_19;
  tmpvar_19 = tmpvar_18;
  highp float tmpvar_20;
  tmpvar_20 = (_LightShadowData.x + (tmpvar_19 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((float(
    (NdotL_4 >= 0.1)
  ) * (shadow_17 - intensity_2)) + intensity_2);
  atten_1 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_6 * ((
    (tmpvar_9.y * (1.0 - atten_1))
   * 
    (_ShadowColor.xyz - 1.0)
  ) + 1.0));
  finalColor_6 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_22;
  _glesFragData[0] = tmpvar_23;
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
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog { Mode Off }
  Blend One One
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_LightTexture0, vec2(tmpvar_7)).w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = ceil(tmpvar_10);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, tmpvar_10);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_4.xyz * tmpvar_13) + ((_SpecColor.xyz * (tmpvar_12 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_6.x))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_3;
  gl_FragData[0] = tmpvar_15;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_8;
  tmpvar_8 = texture (_LightTexture0, vec2(tmpvar_7)).w;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = ceil(tmpvar_10);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, tmpvar_10);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_4.xyz * tmpvar_13) + ((_SpecColor.xyz * (tmpvar_12 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_6.x))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_3;
  _glesFragData[0] = tmpvar_15;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_2 = xlv_TEXCOORD1;
  lowp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = ceil(tmpvar_7);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, tmpvar_7);
  highp vec3 tmpvar_11;
  tmpvar_11 = (((
    (tmpvar_4.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * (tmpvar_9 * pow (nh_1, 
      (_Shininess * 128.0)
    ))) * tmpvar_6.x)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = finalColor_3;
  gl_FragData[0] = tmpvar_12;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_2 = xlv_TEXCOORD1;
  lowp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = ceil(tmpvar_7);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, tmpvar_7);
  highp vec3 tmpvar_11;
  tmpvar_11 = (((
    (tmpvar_4.xyz * tmpvar_10)
   + 
    ((_SpecColor.xyz * (tmpvar_9 * pow (nh_1, 
      (_Shininess * 128.0)
    ))) * tmpvar_6.x)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_3 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = finalColor_3;
  _glesFragData[0] = tmpvar_12;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp float attenuation_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_8 = texture2D (_LightTexture0, P_9);
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_LightTextureB0, vec2(tmpvar_10));
  highp float tmpvar_12;
  tmpvar_12 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * tmpvar_8.w) * tmpvar_11.w);
  attenuation_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_6, lightDir_2);
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = ceil(tmpvar_14);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, tmpvar_14);
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_5.xyz * tmpvar_17) + ((_SpecColor.xyz * (tmpvar_16 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_7.x))
   * _LightColor0.xyz) * attenuation_4) * 2.0);
  finalColor_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_3;
  gl_FragData[0] = tmpvar_19;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp float attenuation_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_8 = texture (_LightTexture0, P_9);
  highp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_LightTextureB0, vec2(tmpvar_10));
  highp float tmpvar_12;
  tmpvar_12 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * tmpvar_8.w) * tmpvar_11.w);
  attenuation_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_6, lightDir_2);
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = ceil(tmpvar_14);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, tmpvar_14);
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_5.xyz * tmpvar_17) + ((_SpecColor.xyz * (tmpvar_16 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_7.x))
   * _LightColor0.xyz) * attenuation_4) * 2.0);
  finalColor_3 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_3;
  _glesFragData[0] = tmpvar_19;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_8;
  tmpvar_8 = (texture2D (_LightTextureB0, vec2(tmpvar_7)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = ceil(tmpvar_10);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, tmpvar_10);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_4.xyz * tmpvar_13) + ((_SpecColor.xyz * (tmpvar_12 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_6.x))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_3;
  gl_FragData[0] = tmpvar_15;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_8;
  tmpvar_8 = (texture (_LightTextureB0, vec2(tmpvar_7)).w * texture (_LightTexture0, xlv_TEXCOORD3).w);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = ceil(tmpvar_10);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, tmpvar_10);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    ((tmpvar_4.xyz * tmpvar_13) + ((_SpecColor.xyz * (tmpvar_12 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_6.x))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_3;
  _glesFragData[0] = tmpvar_15;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = ceil(tmpvar_8);
  lowp float tmpvar_11;
  tmpvar_11 = max (0.0, tmpvar_8);
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_4.xyz * tmpvar_11) + ((_SpecColor.xyz * (tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_6.x))
   * _LightColor0.xyz) * tmpvar_7) * 2.0);
  finalColor_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = finalColor_3;
  gl_FragData[0] = tmpvar_13;
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
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp float nh_1;
  lowp vec3 lightDir_2;
  lowp vec3 finalColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture (_LightTexture0, xlv_TEXCOORD3).w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_5, lightDir_2);
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = ceil(tmpvar_8);
  lowp float tmpvar_11;
  tmpvar_11 = max (0.0, tmpvar_8);
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_4.xyz * tmpvar_11) + ((_SpecColor.xyz * (tmpvar_10 * 
      pow (nh_1, (_Shininess * 128.0))
    )) * tmpvar_6.x))
   * _LightColor0.xyz) * tmpvar_7) * 2.0);
  finalColor_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = finalColor_3;
  _glesFragData[0] = tmpvar_13;
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