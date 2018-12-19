Shader "VX/Scene New/Specular Fog RGB" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _MainAlpha ("Base Alpha (RGB)", 2D) = "white" {}
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
}
SubShader { 
 LOD 400
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardAdd" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
  Blend One One
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "ALTITUDEFOG"
  Tags { "LIGHTMODE"="Always" "RenderType"="Opaque" }
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "SHADOWCOLLECTOR"
  Tags { "LIGHTMODE"="SHADOWCOLLECTOR" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
}
Program "fp" {
}
 }
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_15;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_15;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_7;
  tmpvar_7.x = sqrt(dot (tmpvar_5, tmpvar_5));
  tmpvar_7.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texcol_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  ret_1.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_6;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_7;
  tmpvar_7.x = sqrt(dot (tmpvar_5, tmpvar_5));
  tmpvar_7.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texcol_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  ret_1.w = tmpvar_5.w;
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_4, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_6;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_6;
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
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  tmpvar_13 = (_WorldSpaceCameraPos - cse_14.xyz);
  highp vec2 tmpvar_15;
  tmpvar_15.x = sqrt(dot (tmpvar_13, tmpvar_13));
  tmpvar_15.y = cse_14.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_15;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_13;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (finalColor_7 + (texcol_6.xyz * tmpvar_10));
  finalColor_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  ret_1.w = tmpvar_15.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (tmpvar_14, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_16;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_6;
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
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  tmpvar_13 = (_WorldSpaceCameraPos - cse_14.xyz);
  highp vec2 tmpvar_15;
  tmpvar_15.x = sqrt(dot (tmpvar_13, tmpvar_13));
  tmpvar_15.y = cse_14.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_15;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_13;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (finalColor_7 + (texcol_6.xyz * tmpvar_10));
  finalColor_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  ret_1.w = tmpvar_15.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (tmpvar_14, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_16;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_15;
  lowp float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_16 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_6;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_21;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_7;
  tmpvar_7.x = sqrt(dot (tmpvar_5, tmpvar_5));
  tmpvar_7.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD3 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * tmpvar_10.xyz);
  lowp vec3 tmpvar_12;
  tmpvar_12 = (texcol_2.xyz * max (min (tmpvar_11, 
    ((tmpvar_4 * 2.0) * tmpvar_10.xyz)
  ), (tmpvar_11 * tmpvar_4)));
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_12;
  ret_1.w = tmpvar_13.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (tmpvar_12, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_14;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_6;
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
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  tmpvar_13 = (_WorldSpaceCameraPos - cse_14.xyz);
  highp vec2 tmpvar_15;
  tmpvar_15.x = sqrt(dot (tmpvar_13, tmpvar_13));
  tmpvar_15.y = cse_14.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_14);
  xlv_TEXCOORD3 = tmpvar_15;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_20;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_17, ((tmpvar_10 * 2.0) * tmpvar_16.xyz))
  , 
    (tmpvar_17 * tmpvar_10)
  )));
  finalColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_21;
  ret_1.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_23;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_15;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_15;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_15;
  lowp float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_16 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_6;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_21;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_12;
  lowp float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_13 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_6;
  ret_1.w = tmpvar_17.w;
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_18;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_6;
  ret_1.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_19;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_7;
  tmpvar_7.x = sqrt(dot (tmpvar_5, tmpvar_5));
  tmpvar_7.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD3 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_8;
  tmpvar_8 = (2.0 * tmpvar_7.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (texcol_2.xyz * max (min (tmpvar_8, 
    ((shadow_4 * 2.0) * tmpvar_7.xyz)
  ), (tmpvar_8 * shadow_4)));
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_9, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_11;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_7;
  tmpvar_7.x = sqrt(dot (tmpvar_5, tmpvar_5));
  tmpvar_7.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD3 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (texcol_2.xyz * max (min (tmpvar_9, 
    ((shadow_4 * 2.0) * tmpvar_8.xyz)
  ), (tmpvar_9 * shadow_4)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_10, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_12;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_6;
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
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  tmpvar_13 = (_WorldSpaceCameraPos - cse_14.xyz);
  highp vec2 tmpvar_15;
  tmpvar_15.x = sqrt(dot (tmpvar_13, tmpvar_13));
  tmpvar_15.y = cse_14.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_14);
  xlv_TEXCOORD3 = tmpvar_15;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * tmpvar_13.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_17;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_14, ((shadow_10 * 2.0) * tmpvar_13.xyz))
  , 
    (tmpvar_14 * shadow_10)
  )));
  finalColor_7 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  ret_1.w = tmpvar_19.w;
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (tmpvar_18, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_20;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_6;
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
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_12;
  highp vec3 tmpvar_13;
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  tmpvar_13 = (_WorldSpaceCameraPos - cse_14.xyz);
  highp vec2 tmpvar_15;
  tmpvar_15.x = sqrt(dot (tmpvar_13, tmpvar_13));
  tmpvar_15.y = cse_14.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_14);
  xlv_TEXCOORD3 = tmpvar_15;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * tmpvar_14.xyz);
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_18;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_15, ((shadow_10 * 2.0) * tmpvar_14.xyz))
  , 
    (tmpvar_15 * shadow_10)
  )));
  finalColor_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  ret_1.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD3.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD3.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_21;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_12;
  lowp float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_13 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_6;
  ret_1.w = tmpvar_17.w;
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_18;
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_HIGH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 cse_6;
  cse_6 = (_Object2World * _glesVertex);
  tmpvar_5 = (_WorldSpaceCameraPos - cse_6.xyz);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - cse_6.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_10.y = cse_6.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_6);
  xlv_TEXCOORD5 = tmpvar_10;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_6;
  ret_1.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (finalColor_6, _FogColor.xyz, vec3((max (
    clamp (((xlv_TEXCOORD5.x - _FogStart) / (_FogEnd - _FogStart)), 0.0, 1.0)
  , 
    clamp (((xlv_TEXCOORD5.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight)), 0.0, 1.0)
  ) * _FogColor.w)));
  ret_1.xyz = tmpvar_19;
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_6, tmpvar_6)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_3.w = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texcol_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  ret_1.w = tmpvar_5.w;
  ret_1.xyz = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_6, tmpvar_6)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_3.w = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texcol_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  ret_1.w = tmpvar_5.w;
  ret_1.xyz = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp vec3 tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_WorldSpaceCameraPos - cse_15.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_14, tmpvar_14)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_15.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_6.w = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_13;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (finalColor_7 + (texcol_6.xyz * tmpvar_10));
  finalColor_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  ret_1.w = tmpvar_15.w;
  ret_1.xyz = mix (tmpvar_14, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp vec3 tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_WorldSpaceCameraPos - cse_15.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_14, tmpvar_14)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_15.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_6.w = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_13;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (finalColor_7 + (texcol_6.xyz * tmpvar_10));
  finalColor_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  ret_1.w = tmpvar_15.w;
  ret_1.xyz = mix (tmpvar_14, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_15;
  lowp float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_16 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_6;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_6, tmpvar_6)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_3.w = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * tmpvar_10.xyz);
  lowp vec3 tmpvar_12;
  tmpvar_12 = (texcol_2.xyz * max (min (tmpvar_11, 
    ((tmpvar_4 * 2.0) * tmpvar_10.xyz)
  ), (tmpvar_11 * tmpvar_4)));
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_12;
  ret_1.w = tmpvar_13.w;
  ret_1.xyz = mix (tmpvar_12, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp vec3 tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_WorldSpaceCameraPos - cse_15.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_14, tmpvar_14)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_15.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_6.w = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_15);
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_20;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_17, ((tmpvar_10 * 2.0) * tmpvar_16.xyz))
  , 
    (tmpvar_17 * tmpvar_10)
  )));
  finalColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_21;
  ret_1.w = tmpvar_22.w;
  ret_1.xyz = mix (tmpvar_21, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_15;
  lowp float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_16 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_6;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_12;
  lowp float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_13 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_6;
  ret_1.w = tmpvar_17.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_6;
  ret_1.w = tmpvar_18.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_6, tmpvar_6)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_3.w = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_8;
  tmpvar_8 = (2.0 * tmpvar_7.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (texcol_2.xyz * max (min (tmpvar_8, 
    ((shadow_4 * 2.0) * tmpvar_7.xyz)
  ), (tmpvar_8 * shadow_4)));
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  ret_1.xyz = mix (tmpvar_9, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_6, tmpvar_6)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_3.w = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD4;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (texcol_2.xyz * max (min (tmpvar_9, 
    ((shadow_4 * 2.0) * tmpvar_8.xyz)
  ), (tmpvar_9 * shadow_4)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  ret_1.xyz = mix (tmpvar_10, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp vec3 tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_WorldSpaceCameraPos - cse_15.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_14, tmpvar_14)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_15.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_6.w = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_15);
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * tmpvar_13.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_17;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_14, ((shadow_10 * 2.0) * tmpvar_13.xyz))
  , 
    (tmpvar_14 * shadow_10)
  )));
  finalColor_7 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (tmpvar_18, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp vec3 tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_WorldSpaceCameraPos - cse_15.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_14, tmpvar_14)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_15.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_6.w = tmpvar_16;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_15);
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD4;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * tmpvar_14.xyz);
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_18;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_15, ((shadow_10 * 2.0) * tmpvar_14.xyz))
  , 
    (tmpvar_15 * shadow_10)
  )));
  finalColor_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (tmpvar_19, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_12;
  lowp float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_13 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_6;
  ret_1.w = tmpvar_17.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_MIDDLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogStart;
uniform highp float _FogEnd;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos - cse_7.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_FogColor.w * max (clamp (
    ((sqrt(dot (tmpvar_10, tmpvar_10)) - _FogStart) / (_FogEnd - _FogStart))
  , 0.0, 1.0), clamp (
    ((cse_7.y - _FogMinHeight) / (_FogMaxHeight - _FogMinHeight))
  , 0.0, 1.0)));
  tmpvar_4.w = tmpvar_11;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_6;
  ret_1.w = tmpvar_18.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_6;
  tmpvar_6 = (_FogColor.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_3.w = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texcol_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  ret_1.w = tmpvar_5.w;
  ret_1.xyz = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_6;
  tmpvar_6 = (_FogColor.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_3.w = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp vec3 tmpvar_4;
  tmpvar_4 = (texcol_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  ret_1.w = tmpvar_5.w;
  ret_1.xyz = mix (tmpvar_4, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp float tmpvar_14;
  tmpvar_14 = (_FogColor.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_6.w = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_13;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (finalColor_7 + (texcol_6.xyz * tmpvar_10));
  finalColor_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  ret_1.w = tmpvar_15.w;
  ret_1.xyz = mix (tmpvar_14, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp float tmpvar_14;
  tmpvar_14 = (_FogColor.w * clamp ((
    ((_Object2World * _glesVertex).y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_6.w = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_13;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (finalColor_7 + (texcol_6.xyz * tmpvar_10));
  finalColor_7 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_14;
  ret_1.w = tmpvar_15.w;
  ret_1.xyz = mix (tmpvar_14, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_15;
  lowp float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_16 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_6;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_3.w = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float tmpvar_4;
  mediump float lightShadowDataX_5;
  highp float dist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = max (float((dist_6 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_5);
  tmpvar_4 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * tmpvar_10.xyz);
  lowp vec3 tmpvar_12;
  tmpvar_12 = (texcol_2.xyz * max (min (tmpvar_11, 
    ((tmpvar_4 * 2.0) * tmpvar_10.xyz)
  ), (tmpvar_11 * tmpvar_4)));
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_12;
  ret_1.w = tmpvar_13.w;
  ret_1.xyz = mix (tmpvar_12, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp float tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_FogColor.w * clamp ((
    (cse_15.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_6.w = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_15);
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * tmpvar_16.xyz);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_17 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_20;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_17, ((tmpvar_10 * 2.0) * tmpvar_16.xyz))
  , 
    (tmpvar_17 * tmpvar_10)
  )));
  finalColor_7 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_21;
  ret_1.w = tmpvar_22.w;
  ret_1.xyz = mix (tmpvar_21, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_9;
  lowp float tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_10 * texcol_5.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_2, (_Shininess * 128.0)) * texAlpha_4))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_6 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = finalColor_6;
  ret_1.w = tmpvar_14.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_15;
  lowp float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_16 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_16 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * tmpvar_9) * 2.0);
  finalColor_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = finalColor_6;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_12;
  lowp float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_13 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_6;
  ret_1.w = tmpvar_17.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_6;
  ret_1.w = tmpvar_18.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_3.w = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float shadow_4;
  lowp float tmpvar_5;
  tmpvar_5 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_6;
  tmpvar_6 = (_LightShadowData.x + (tmpvar_5 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_8;
  tmpvar_8 = (2.0 * tmpvar_7.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (texcol_2.xyz * max (min (tmpvar_8, 
    ((shadow_4 * 2.0) * tmpvar_7.xyz)
  ), (tmpvar_8 * shadow_4)));
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  ret_1.w = tmpvar_10.w;
  ret_1.xyz = mix (tmpvar_9, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_5;
  tmpvar_3.xyz = _FogColor.xyz;
  highp float tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_3.w = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD4;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_2.w = tmpvar_3.w;
  texcol_2.xyz = (tmpvar_3.xyz * _Color.xyz);
  lowp float shadow_4;
  mediump float tmpvar_5;
  tmpvar_5 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_6;
  tmpvar_6 = tmpvar_5;
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * tmpvar_8.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = (texcol_2.xyz * max (min (tmpvar_9, 
    ((shadow_4 * 2.0) * tmpvar_8.xyz)
  ), (tmpvar_9 * shadow_4)));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  ret_1.w = tmpvar_11.w;
  ret_1.xyz = mix (tmpvar_10, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp float tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_FogColor.w * clamp ((
    (cse_15.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_6.w = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_15);
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * tmpvar_13.xyz);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_14 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_17;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_14, ((shadow_10 * 2.0) * tmpvar_13.xyz))
  , 
    (tmpvar_14 * shadow_10)
  )));
  finalColor_7 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18;
  ret_1.w = tmpvar_19.w;
  ret_1.xyz = mix (tmpvar_18, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD4;
out lowp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_2.xyz;
  tmpvar_9 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_1.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_1.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_1.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_13;
  tmpvar_6.xyz = _FogColor.xyz;
  highp float tmpvar_14;
  highp vec4 cse_15;
  cse_15 = (_Object2World * _glesVertex);
  tmpvar_14 = (_FogColor.w * clamp ((
    (cse_15.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_6.w = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_15);
  xlv_COLOR = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD4;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 scalePerBasisVector_3;
  mediump vec3 specColor_4;
  highp float texAlpha_5;
  lowp vec4 texcol_6;
  lowp vec3 finalColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_6.w = tmpvar_8.w;
  lowp float tmpvar_9;
  tmpvar_9 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_5 = tmpvar_9;
  texcol_6.xyz = (tmpvar_8.xyz * _Color.xyz);
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * tmpvar_14.xyz);
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_3 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, normalize((
    normalize((((scalePerBasisVector_3.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_3.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_3.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * _SpecColor.xyz) * texAlpha_5) * pow (nh_2, (_Shininess * 128.0)));
  specColor_4 = tmpvar_18;
  finalColor_7 = specColor_4;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_7 + (texcol_6.xyz * max (
    min (tmpvar_15, ((shadow_10 * 2.0) * tmpvar_14.xyz))
  , 
    (tmpvar_15 * shadow_10)
  )));
  finalColor_7 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  ret_1.w = tmpvar_20.w;
  ret_1.xyz = mix (tmpvar_19, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  lowp float tmpvar_10;
  tmpvar_10 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_11;
  tmpvar_11 = (_LightShadowData.x + (tmpvar_10 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_12;
  lowp float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_13 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_13 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_6;
  ret_1.w = tmpvar_17.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  gl_FragData[0] = ret_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" "FOG_LOW" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform lowp vec4 _FogColor;
uniform highp float _FogMaxHeight;
uniform highp float _FogMinHeight;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceCameraPos - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_9;
  tmpvar_4.xyz = _FogColor.xyz;
  highp float tmpvar_10;
  tmpvar_10 = (_FogColor.w * clamp ((
    (cse_7.y - _FogMinHeight)
   / 
    (_FogMaxHeight - _FogMinHeight)
  ), 0.0, 1.0));
  tmpvar_4.w = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_7);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 ret_1;
  highp float nh_2;
  mediump vec3 L_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_5.w = tmpvar_7.w;
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  texcol_5.xyz = (tmpvar_7.xyz * _Color.xyz);
  lowp float shadow_9;
  mediump float tmpvar_10;
  tmpvar_10 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_11;
  tmpvar_11 = tmpvar_10;
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_9 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_3 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_3), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_3 + normalize(xlv_TEXCOORD1))
  )));
  nh_2 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_5.xyz) + (_SpecColor.xyz * (pow (nh_2, 
      (_Shininess * 128.0)
    ) * texAlpha_4)))
   * _LightColor0.xyz) * shadow_9) * 2.0);
  finalColor_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_6;
  ret_1.w = tmpvar_18.w;
  ret_1.xyz = mix (finalColor_6, xlv_COLOR.xyz, xlv_COLOR.www);
  _glesFragData[0] = ret_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_HIGH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_MIDDLE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "FOG_LOW" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "FOG_LOW" }
"!!GLES3"
}
}
 }
 UsePass "VertexLit/SHADOWCASTER"
 UsePass "VertexLit/SHADOWCOLLECTOR"
}
Fallback "VX/Scene New/Diffuse Fog"
}