Shader "VX/Scene New/Specular Reflect Mask RGB" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _MainAlpha ("Base Alpha (RGB)", 2D) = "white" {}
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _SpecTex ("Specular Map (RGB)", 2D) = "black" {}
 _SpecLevel ("Specular Level", Range(0,1)) = 0.5
 _ReflectLevel ("Reflect Level", Float) = 1
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
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
uniform highp float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_11 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_12;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_10;
  lowp float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    (tmpvar_11 * texcol_4.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_1, (_Shininess * 128.0)) * texAlpha_3))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_5;
  gl_FragData[0] = tmpvar_15;
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
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_11 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_12;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_10;
  lowp float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    (tmpvar_11 * texcol_4.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_1, (_Shininess * 128.0)) * texAlpha_3))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_5;
  _glesFragData[0] = tmpvar_15;
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
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_7[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_7[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((
    (tmpvar_4.xy / tmpvar_4.w)
   + 
    (normalize((tmpvar_7 * normalize(_glesNormal))).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_3 = tmpvar_8;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float texAlpha_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 + (tmpvar_5 * texAlpha_1));
  texcol_2 = tmpvar_6;
  texcol_2.xyz = (texcol_2.xyz * _Color.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (texcol_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  gl_FragData[0] = tmpvar_7;
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
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_7[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_7[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((
    (tmpvar_4.xy / tmpvar_4.w)
   + 
    (normalize((tmpvar_7 * normalize(_glesNormal))).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_3 = tmpvar_8;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float texAlpha_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 + (tmpvar_5 * texAlpha_1));
  texcol_2 = tmpvar_6;
  texcol_2.xyz = (texcol_2.xyz * _Color.xyz);
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (texcol_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  _glesFragData[0] = tmpvar_7;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD5;
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
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_2.xyz;
  tmpvar_10 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_1.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_1.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_1.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_11 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_15[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_15[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_7.xy / tmpvar_7.w)
   + 
    (normalize((tmpvar_15 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_6 = tmpvar_16;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 + (tmpvar_9 * texAlpha_4));
  texcol_5 = tmpvar_10;
  texcol_5.xyz = (texcol_5.xyz * _Color.xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_2 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_1 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * _SpecColor.xyz) * texAlpha_4) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_14;
  finalColor_6 = specColor_3;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_6 + (texcol_5.xyz * tmpvar_11));
  finalColor_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_15;
  gl_FragData[0] = tmpvar_16;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec2 xlv_TEXCOORD5;
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
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_2.xyz;
  tmpvar_10 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_1.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_1.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_1.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_11 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_15[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_15[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_7.xy / tmpvar_7.w)
   + 
    (normalize((tmpvar_15 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_6 = tmpvar_16;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 + (tmpvar_9 * texAlpha_4));
  texcol_5 = tmpvar_10;
  texcol_5.xyz = (texcol_5.xyz * _Color.xyz);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_2 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_1 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * _SpecColor.xyz) * texAlpha_4) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_14;
  finalColor_6 = specColor_3;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (finalColor_6 + (texcol_5.xyz * tmpvar_11));
  finalColor_6 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_15;
  _glesFragData[0] = tmpvar_16;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_12 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_16;
  lowp float tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    ((tmpvar_17 * texcol_4.xyz) + (_SpecColor.xyz * (pow (nh_1, 
      (_Shininess * 128.0)
    ) * texAlpha_3)))
   * _LightColor0.xyz) * tmpvar_10) * 2.0);
  finalColor_5 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = finalColor_5;
  gl_FragData[0] = tmpvar_21;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_7[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_7[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((
    (tmpvar_4.xy / tmpvar_4.w)
   + 
    (normalize((tmpvar_7 * normalize(_glesNormal))).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_3 = tmpvar_8;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float texAlpha_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 + (tmpvar_5 * texAlpha_1));
  texcol_2 = tmpvar_6;
  texcol_2.xyz = (texcol_2.xyz * _Color.xyz);
  lowp float tmpvar_7;
  mediump float lightShadowDataX_8;
  highp float dist_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_8 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((dist_9 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_8);
  tmpvar_7 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * tmpvar_13.xyz);
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = (texcol_2.xyz * max (min (tmpvar_14, 
    ((tmpvar_7 * 2.0) * tmpvar_13.xyz)
  ), (tmpvar_14 * tmpvar_7)));
  gl_FragData[0] = tmpvar_15;
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
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
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
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_2.xyz;
  tmpvar_10 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_1.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_1.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_1.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_11 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_15[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_15[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_7.xy / tmpvar_7.w)
   + 
    (normalize((tmpvar_15 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_6 = tmpvar_16;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_6;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 + (tmpvar_9 * texAlpha_4));
  texcol_5 = tmpvar_10;
  texcol_5.xyz = (texcol_5.xyz * _Color.xyz);
  lowp float tmpvar_11;
  mediump float lightShadowDataX_12;
  highp float dist_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = _LightShadowData.x;
  lightShadowDataX_12 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = max (float((dist_13 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_12);
  tmpvar_11 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * tmpvar_17.xyz);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_2 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_1 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((tmpvar_18 * _SpecColor.xyz) * texAlpha_4) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_21;
  finalColor_6 = specColor_3;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (finalColor_6 + (texcol_5.xyz * max (
    min (tmpvar_18, ((tmpvar_11 * 2.0) * tmpvar_17.xyz))
  , 
    (tmpvar_18 * tmpvar_11)
  )));
  finalColor_6 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_22;
  gl_FragData[0] = tmpvar_23;
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
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_11 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_12;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_10;
  lowp float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    (tmpvar_11 * texcol_4.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_1, (_Shininess * 128.0)) * texAlpha_3))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_5;
  gl_FragData[0] = tmpvar_15;
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
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_11[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_11[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_11 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_12;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_10;
  lowp float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (((
    (tmpvar_11 * texcol_4.xyz)
   + 
    (_SpecColor.xyz * (pow (nh_1, (_Shininess * 128.0)) * texAlpha_3))
  ) * _LightColor0.xyz) * 2.0);
  finalColor_5 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = finalColor_5;
  _glesFragData[0] = tmpvar_15;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_12 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
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
  lowp vec3 tmpvar_16;
  tmpvar_16 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_16;
  lowp float tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_17 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    ((tmpvar_17 * texcol_4.xyz) + (_SpecColor.xyz * (pow (nh_1, 
      (_Shininess * 128.0)
    ) * texAlpha_3)))
   * _LightColor0.xyz) * tmpvar_10) * 2.0);
  finalColor_5 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = finalColor_5;
  gl_FragData[0] = tmpvar_21;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_12 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_4.xyz) + (_SpecColor.xyz * (pow (nh_1, 
      (_Shininess * 128.0)
    ) * texAlpha_3)))
   * _LightColor0.xyz) * shadow_10) * 2.0);
  finalColor_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_5;
  gl_FragData[0] = tmpvar_18;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_12 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_14;
  lowp float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_15 * texcol_4.xyz) + (_SpecColor.xyz * (pow (nh_1, 
      (_Shininess * 128.0)
    ) * texAlpha_3)))
   * _LightColor0.xyz) * shadow_10) * 2.0);
  finalColor_5 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_5;
  _glesFragData[0] = tmpvar_19;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_7[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_7[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((
    (tmpvar_4.xy / tmpvar_4.w)
   + 
    (normalize((tmpvar_7 * normalize(_glesNormal))).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_3 = tmpvar_8;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float texAlpha_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 + (tmpvar_5 * texAlpha_1));
  texcol_2 = tmpvar_6;
  texcol_2.xyz = (texcol_2.xyz * _Color.xyz);
  lowp float shadow_7;
  lowp float tmpvar_8;
  tmpvar_8 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_9;
  tmpvar_9 = (_LightShadowData.x + (tmpvar_8 * (1.0 - _LightShadowData.x)));
  shadow_7 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * tmpvar_10.xyz);
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (texcol_2.xyz * max (min (tmpvar_11, 
    ((shadow_7 * 2.0) * tmpvar_10.xyz)
  ), (tmpvar_11 * shadow_7)));
  gl_FragData[0] = tmpvar_12;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD3;
out mediump vec2 xlv_TEXCOORD5;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_7[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_7[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_8;
  tmpvar_8 = (((
    (tmpvar_4.xy / tmpvar_4.w)
   + 
    (normalize((tmpvar_7 * normalize(_glesNormal))).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_3 = tmpvar_8;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MainAlpha;
uniform lowp vec4 _Color;
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD3;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float texAlpha_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 + (tmpvar_5 * texAlpha_1));
  texcol_2 = tmpvar_6;
  texcol_2.xyz = (texcol_2.xyz * _Color.xyz);
  lowp float shadow_7;
  mediump float tmpvar_8;
  tmpvar_8 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_9;
  tmpvar_9 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = (_LightShadowData.x + (tmpvar_9 * (1.0 - _LightShadowData.x)));
  shadow_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * tmpvar_11.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (texcol_2.xyz * max (min (tmpvar_12, 
    ((shadow_7 * 2.0) * tmpvar_11.xyz)
  ), (tmpvar_12 * shadow_7)));
  _glesFragData[0] = tmpvar_13;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
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
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_2.xyz;
  tmpvar_10 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_1.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_1.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_1.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_11 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_15[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_15[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_7.xy / tmpvar_7.w)
   + 
    (normalize((tmpvar_15 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_6 = tmpvar_16;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_6;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 + (tmpvar_9 * texAlpha_4));
  texcol_5 = tmpvar_10;
  texcol_5.xyz = (texcol_5.xyz * _Color.xyz);
  lowp float shadow_11;
  lowp float tmpvar_12;
  tmpvar_12 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_11 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * tmpvar_14.xyz);
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_2 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_1 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * _SpecColor.xyz) * texAlpha_4) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_18;
  finalColor_6 = specColor_3;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (finalColor_6 + (texcol_5.xyz * max (
    min (tmpvar_15, ((shadow_11 * 2.0) * tmpvar_14.xyz))
  , 
    (tmpvar_15 * shadow_11)
  )));
  finalColor_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_19;
  gl_FragData[0] = tmpvar_20;
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
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
uniform mediump vec4 unity_LightmapST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out mediump vec2 xlv_TEXCOORD5;
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
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_8;
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_2.xyz;
  tmpvar_10 = (((tmpvar_1.yzx * tmpvar_2.zxy) - (tmpvar_1.zxy * tmpvar_2.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_1.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_1.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_1.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_11 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_5 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  tmpvar_4 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_15[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_15[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_7.xy / tmpvar_7.w)
   + 
    (normalize((tmpvar_15 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_6 = tmpvar_16;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = tmpvar_6;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 scalePerBasisVector_2;
  mediump vec3 specColor_3;
  highp float texAlpha_4;
  lowp vec4 texcol_5;
  lowp vec3 finalColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_8;
  tmpvar_8 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_4 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 + (tmpvar_9 * texAlpha_4));
  texcol_5 = tmpvar_10;
  texcol_5.xyz = (texcol_5.xyz * _Color.xyz);
  lowp float shadow_11;
  mediump float tmpvar_12;
  tmpvar_12 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_13;
  tmpvar_13 = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_11 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * tmpvar_15.xyz);
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  scalePerBasisVector_2 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, normalize((
    normalize((((scalePerBasisVector_2.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_2.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_2.z * vec3(-0.408248, -0.707107, 0.57735))))
   + 
    normalize(xlv_TEXCOORD2)
  )).z);
  nh_1 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * _SpecColor.xyz) * texAlpha_4) * pow (nh_1, (_Shininess * 128.0)));
  specColor_3 = tmpvar_19;
  finalColor_6 = specColor_3;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (finalColor_6 + (texcol_5.xyz * max (
    min (tmpvar_16, ((shadow_11 * 2.0) * tmpvar_15.xyz))
  , 
    (tmpvar_16 * shadow_11)
  )));
  finalColor_6 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_20;
  _glesFragData[0] = tmpvar_21;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_12 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_13;
  lowp float tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    ((tmpvar_14 * texcol_4.xyz) + (_SpecColor.xyz * (pow (nh_1, 
      (_Shininess * 128.0)
    ) * texAlpha_3)))
   * _LightColor0.xyz) * shadow_10) * 2.0);
  finalColor_5 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = finalColor_5;
  gl_FragData[0] = tmpvar_18;
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _ReflectLevel;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceCameraPos - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  tmpvar_4 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_mvp[0].xyz;
  tmpvar_12[1] = glstate_matrix_mvp[1].xyz;
  tmpvar_12[2] = glstate_matrix_mvp[2].xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_6.xy / tmpvar_6.w)
   + 
    (normalize((tmpvar_12 * tmpvar_1)).xz * _ReflectLevel)
  ) * vec2(0.5, 0.5)) + vec2(0.5, 0.5));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_9);
  xlv_TEXCOORD5 = tmpvar_5;
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
uniform sampler2D _SpecTex;
uniform lowp float _SpecLevel;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in mediump vec2 xlv_TEXCOORD5;
void main ()
{
  highp float nh_1;
  mediump vec3 L_2;
  highp float texAlpha_3;
  lowp vec4 texcol_4;
  lowp vec3 finalColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_7;
  tmpvar_7 = texture (_MainAlpha, xlv_TEXCOORD0).y;
  texAlpha_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_SpecTex, xlv_TEXCOORD5) * _SpecLevel);
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + (tmpvar_8 * texAlpha_3));
  texcol_4 = tmpvar_9;
  texcol_4.xyz = (texcol_4.xyz * _Color.xyz);
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = _WorldSpaceLightPos0.xyz;
  L_2 = tmpvar_14;
  lowp float tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (xlv_TEXCOORD2, L_2), 0.0, 1.0);
  tmpvar_15 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (xlv_TEXCOORD2, normalize(
    (L_2 + normalize(xlv_TEXCOORD1))
  )));
  nh_1 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_15 * texcol_4.xyz) + (_SpecColor.xyz * (pow (nh_1, 
      (_Shininess * 128.0)
    ) * texAlpha_3)))
   * _LightColor0.xyz) * shadow_10) * 2.0);
  finalColor_5 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = finalColor_5;
  _glesFragData[0] = tmpvar_19;
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
Fallback "VX/Scene New/Diffuse Fog"
}