Shader "VX/FX/Specular Lerp Alpha" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _FXTex ("FX Map", 2D) = "white" {}
 _AlphaTex ("Alpha (R)", 2D) = "white" {}
 _Weight ("Blend Weight", Range(0,1)) = 0
}
SubShader { 
 LOD 300
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_6;
  viewDir_6 = tmpvar_5;
  lowp vec4 c_7;
  highp float nh_8;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_6)
  )));
  nh_8 = tmpvar_10;
  mediump float y_11;
  y_11 = (_Shininess * 128.0);
  highp float tmpvar_12;
  tmpvar_12 = (pow (nh_8, y_11) * tmpvar_2.x);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_9) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_12)) * 2.0);
  c_7.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (tmpvar_4 + ((_LightColor0.w * _SpecColor.w) * tmpvar_12));
  c_7.w = tmpvar_14;
  c_1.w = c_7.w;
  c_1.xyz = (c_7.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_6;
  viewDir_6 = tmpvar_5;
  lowp vec4 c_7;
  highp float nh_8;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_6)
  )));
  nh_8 = tmpvar_10;
  mediump float y_11;
  y_11 = (_Shininess * 128.0);
  highp float tmpvar_12;
  tmpvar_12 = (pow (nh_8, y_11) * tmpvar_2.x);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_9) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_12)) * 2.0);
  c_7.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (tmpvar_4 + ((_LightColor0.w * _SpecColor.w) * tmpvar_12));
  c_7.w = tmpvar_14;
  c_1.w = c_7.w;
  c_1.xyz = (c_7.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
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
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) + 
    (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)
  ).xyz * _Color.xyz) * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.w = (texture2D (_AlphaTex, xlv_TEXCOORD0).x * _Color.w);
  gl_FragData[0] = c_1;
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
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = (((texture (_MainTex, xlv_TEXCOORD0) + 
    (texture (_FXTex, xlv_TEXCOORD0) * _Weight)
  ).xyz * _Color.xyz) * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.w = (texture (_AlphaTex, xlv_TEXCOORD0).x * _Color.w);
  _glesFragData[0] = c_1;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (tmpvar_2 * unity_Scale.w));
  tmpvar_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_8 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  c_1.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_5;
  mediump vec3 viewDir_6;
  viewDir_6 = tmpvar_4;
  mediump vec3 specColor_7;
  highp float nh_8;
  mediump vec3 scalePerBasisVector_9;
  mediump vec3 lm_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, normalize((
    normalize((((scalePerBasisVector_9.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_9.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_9.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_6)).z);
  nh_8 = tmpvar_13;
  highp float tmpvar_14;
  mediump float y_15;
  y_15 = (_Shininess * 128.0);
  tmpvar_14 = pow (nh_8, y_15);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((lm_10 * _SpecColor.xyz) * tmpvar_2.x) * tmpvar_14);
  specColor_7 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = lm_10;
  tmpvar_17.w = tmpvar_14;
  tmpvar_5 = tmpvar_17;
  c_1.xyz = specColor_7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (c_1.xyz + (tmpvar_3 * tmpvar_5.xyz));
  c_1.xyz = tmpvar_18;
  c_1.w = (tmpvar_2.x * _Color.w);
  gl_FragData[0] = c_1;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (tmpvar_2 * unity_Scale.w));
  tmpvar_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_8 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  c_1.w = 0.0;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_5;
  mediump vec3 viewDir_6;
  viewDir_6 = tmpvar_4;
  mediump vec3 specColor_7;
  highp float nh_8;
  mediump vec3 scalePerBasisVector_9;
  mediump vec3 lm_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_9 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, normalize((
    normalize((((scalePerBasisVector_9.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_9.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_9.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_6)).z);
  nh_8 = tmpvar_13;
  highp float tmpvar_14;
  mediump float y_15;
  y_15 = (_Shininess * 128.0);
  tmpvar_14 = pow (nh_8, y_15);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((lm_10 * _SpecColor.xyz) * tmpvar_2.x) * tmpvar_14);
  specColor_7 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = lm_10;
  tmpvar_17.w = tmpvar_14;
  tmpvar_5 = tmpvar_17;
  c_1.xyz = specColor_7;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (c_1.xyz + (tmpvar_3 * tmpvar_5.xyz));
  c_1.xyz = tmpvar_18;
  c_1.w = (tmpvar_2.x * _Color.w);
  _glesFragData[0] = c_1;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_22);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  lowp float tmpvar_5;
  mediump float lightShadowDataX_6;
  highp float dist_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = max (float((dist_7 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_6);
  tmpvar_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_12;
  viewDir_12 = tmpvar_11;
  lowp vec4 c_13;
  highp float nh_14;
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_12)
  )));
  nh_14 = tmpvar_16;
  mediump float y_17;
  y_17 = (_Shininess * 128.0);
  highp float tmpvar_18;
  tmpvar_18 = (pow (nh_14, y_17) * tmpvar_2.x);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_15) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_18)) * (tmpvar_5 * 2.0));
  c_13.xyz = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (tmpvar_4 + ((
    (_LightColor0.w * _SpecColor.w)
   * tmpvar_18) * tmpvar_5));
  c_13.w = tmpvar_20;
  c_1.w = c_13.w;
  c_1.xyz = (c_13.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp float cosAngle_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_AlphaTex, xlv_TEXCOORD0).x * _Color.w);
  lowp float tmpvar_5;
  mediump float lightShadowDataX_6;
  highp float dist_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = max (float((dist_7 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_6);
  tmpvar_5 = tmpvar_10;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz);
  cosAngle_1 = tmpvar_12;
  if ((cosAngle_1 > 0.0)) {
    c_2.xyz = (tmpvar_3 * min (tmpvar_11, vec3((tmpvar_5 * 2.0))));
  } else {
    c_2.xyz = (c_2.xyz + (tmpvar_3 * min (tmpvar_11, vec3(
      (tmpvar_5 * 3.0)
    ))));
  };
  c_2.w = tmpvar_4;
  gl_FragData[0] = c_2;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (tmpvar_2 * unity_Scale.w));
  tmpvar_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_8 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp float cosAngle_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = (tmpvar_3.x * _Color.w);
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  c_2.w = 0.0;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_13;
  mediump vec3 viewDir_14;
  viewDir_14 = tmpvar_12;
  mediump vec3 specColor_15;
  highp float nh_16;
  mediump vec3 scalePerBasisVector_17;
  mediump vec3 lm_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_18 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_17 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, normalize((
    normalize((((scalePerBasisVector_17.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_17.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_17.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_14)).z);
  nh_16 = tmpvar_21;
  highp float tmpvar_22;
  mediump float y_23;
  y_23 = (_Shininess * 128.0);
  tmpvar_22 = pow (nh_16, y_23);
  highp vec3 tmpvar_24;
  tmpvar_24 = (((lm_18 * _SpecColor.xyz) * tmpvar_3.x) * tmpvar_22);
  specColor_15 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = lm_18;
  tmpvar_25.w = tmpvar_22;
  tmpvar_13 = tmpvar_25;
  c_2.xyz = specColor_15;
  lowp float tmpvar_26;
  tmpvar_26 = dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz);
  cosAngle_1 = tmpvar_26;
  if ((cosAngle_1 > 0.0)) {
    lowp vec3 tmpvar_27;
    tmpvar_27 = vec3((tmpvar_6 * 2.0));
    mediump vec3 tmpvar_28;
    tmpvar_28 = (c_2.xyz + (tmpvar_4 * min (tmpvar_13.xyz, tmpvar_27)));
    c_2.xyz = tmpvar_28;
  } else {
    lowp vec3 tmpvar_29;
    tmpvar_29 = vec3((tmpvar_6 * 3.0));
    mediump vec3 tmpvar_30;
    tmpvar_30 = (c_2.xyz + (tmpvar_4 * min (tmpvar_13.xyz, tmpvar_29)));
    c_2.xyz = tmpvar_30;
  };
  c_2.w = tmpvar_5;
  gl_FragData[0] = c_2;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - cse_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - cse_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - cse_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_26)
  )) * (1.0/((1.0 + 
    (tmpvar_26 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_27.z)
  ) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_6;
  viewDir_6 = tmpvar_5;
  lowp vec4 c_7;
  highp float nh_8;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_6)
  )));
  nh_8 = tmpvar_10;
  mediump float y_11;
  y_11 = (_Shininess * 128.0);
  highp float tmpvar_12;
  tmpvar_12 = (pow (nh_8, y_11) * tmpvar_2.x);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_9) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_12)) * 2.0);
  c_7.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (tmpvar_4 + ((_LightColor0.w * _SpecColor.w) * tmpvar_12));
  c_7.w = tmpvar_14;
  c_1.w = c_7.w;
  c_1.xyz = (c_7.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - cse_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - cse_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - cse_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_26)
  )) * (1.0/((1.0 + 
    (tmpvar_26 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_27.z)
  ) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_6;
  viewDir_6 = tmpvar_5;
  lowp vec4 c_7;
  highp float nh_8;
  lowp float tmpvar_9;
  tmpvar_9 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_6)
  )));
  nh_8 = tmpvar_10;
  mediump float y_11;
  y_11 = (_Shininess * 128.0);
  highp float tmpvar_12;
  tmpvar_12 = (pow (nh_8, y_11) * tmpvar_2.x);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_9) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_12)) * 2.0);
  c_7.xyz = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (tmpvar_4 + ((_LightColor0.w * _SpecColor.w) * tmpvar_12));
  c_7.w = tmpvar_14;
  c_1.w = c_7.w;
  c_1.xyz = (c_7.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - cse_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - cse_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - cse_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_26)
  )) * (1.0/((1.0 + 
    (tmpvar_26 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_27.z)
  ) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_22);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  lowp float tmpvar_5;
  mediump float lightShadowDataX_6;
  highp float dist_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_7 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = _LightShadowData.x;
  lightShadowDataX_6 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = max (float((dist_7 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_6);
  tmpvar_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_12;
  viewDir_12 = tmpvar_11;
  lowp vec4 c_13;
  highp float nh_14;
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_12)
  )));
  nh_14 = tmpvar_16;
  mediump float y_17;
  y_17 = (_Shininess * 128.0);
  highp float tmpvar_18;
  tmpvar_18 = (pow (nh_14, y_17) * tmpvar_2.x);
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_15) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_18)) * (tmpvar_5 * 2.0));
  c_13.xyz = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (tmpvar_4 + ((
    (_LightColor0.w * _SpecColor.w)
   * tmpvar_18) * tmpvar_5));
  c_13.w = tmpvar_20;
  c_1.w = c_13.w;
  c_1.xyz = (c_13.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_22);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  lowp float shadow_5;
  lowp float tmpvar_6;
  tmpvar_6 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_9;
  viewDir_9 = tmpvar_8;
  lowp vec4 c_10;
  highp float nh_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_9)
  )));
  nh_11 = tmpvar_13;
  mediump float y_14;
  y_14 = (_Shininess * 128.0);
  highp float tmpvar_15;
  tmpvar_15 = (pow (nh_11, y_14) * tmpvar_2.x);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_12) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_15)) * (shadow_5 * 2.0));
  c_10.xyz = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_4 + ((
    (_LightColor0.w * _SpecColor.w)
   * tmpvar_15) * shadow_5));
  c_10.w = tmpvar_17;
  c_1.w = c_10.w;
  c_1.xyz = (c_10.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_22);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  lowp float shadow_5;
  mediump float tmpvar_6;
  tmpvar_6 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_10;
  viewDir_10 = tmpvar_9;
  lowp vec4 c_11;
  highp float nh_12;
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_10)
  )));
  nh_12 = tmpvar_14;
  mediump float y_15;
  y_15 = (_Shininess * 128.0);
  highp float tmpvar_16;
  tmpvar_16 = (pow (nh_12, y_15) * tmpvar_2.x);
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_13) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_16)) * (shadow_5 * 2.0));
  c_11.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_4 + ((
    (_LightColor0.w * _SpecColor.w)
   * tmpvar_16) * shadow_5));
  c_11.w = tmpvar_18;
  c_1.w = c_11.w;
  c_1.xyz = (c_11.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
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
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp float cosAngle_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_AlphaTex, xlv_TEXCOORD0).x * _Color.w);
  lowp float shadow_5;
  lowp float tmpvar_6;
  tmpvar_6 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_7;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz);
  cosAngle_1 = tmpvar_9;
  if ((cosAngle_1 > 0.0)) {
    c_2.xyz = (tmpvar_3 * min (tmpvar_8, vec3((shadow_5 * 2.0))));
  } else {
    c_2.xyz = (c_2.xyz + (tmpvar_3 * min (tmpvar_8, vec3(
      (shadow_5 * 3.0)
    ))));
  };
  c_2.w = tmpvar_4;
  gl_FragData[0] = c_2;
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
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp float cosAngle_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (texture (_AlphaTex, xlv_TEXCOORD0).x * _Color.w);
  lowp float shadow_5;
  mediump float tmpvar_6;
  tmpvar_6 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_8;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lowp float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz);
  cosAngle_1 = tmpvar_10;
  if ((cosAngle_1 > 0.0)) {
    c_2.xyz = (tmpvar_3 * min (tmpvar_9, vec3((shadow_5 * 2.0))));
  } else {
    c_2.xyz = (c_2.xyz + (tmpvar_3 * min (tmpvar_9, vec3(
      (shadow_5 * 3.0)
    ))));
  };
  c_2.w = tmpvar_4;
  _glesFragData[0] = c_2;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (tmpvar_2 * unity_Scale.w));
  tmpvar_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_8 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp float cosAngle_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = (tmpvar_3.x * _Color.w);
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  c_2.w = 0.0;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_10;
  mediump vec3 viewDir_11;
  viewDir_11 = tmpvar_9;
  mediump vec3 specColor_12;
  highp float nh_13;
  mediump vec3 scalePerBasisVector_14;
  mediump vec3 lm_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_15 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_14 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, normalize((
    normalize((((scalePerBasisVector_14.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_14.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_14.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_11)).z);
  nh_13 = tmpvar_18;
  highp float tmpvar_19;
  mediump float y_20;
  y_20 = (_Shininess * 128.0);
  tmpvar_19 = pow (nh_13, y_20);
  highp vec3 tmpvar_21;
  tmpvar_21 = (((lm_15 * _SpecColor.xyz) * tmpvar_3.x) * tmpvar_19);
  specColor_12 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = lm_15;
  tmpvar_22.w = tmpvar_19;
  tmpvar_10 = tmpvar_22;
  c_2.xyz = specColor_12;
  lowp float tmpvar_23;
  tmpvar_23 = dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz);
  cosAngle_1 = tmpvar_23;
  if ((cosAngle_1 > 0.0)) {
    lowp vec3 tmpvar_24;
    tmpvar_24 = vec3((shadow_6 * 2.0));
    mediump vec3 tmpvar_25;
    tmpvar_25 = (c_2.xyz + (tmpvar_4 * min (tmpvar_10.xyz, tmpvar_24)));
    c_2.xyz = tmpvar_25;
  } else {
    lowp vec3 tmpvar_26;
    tmpvar_26 = vec3((shadow_6 * 3.0));
    mediump vec3 tmpvar_27;
    tmpvar_27 = (c_2.xyz + (tmpvar_4 * min (tmpvar_10.xyz, tmpvar_26)));
    c_2.xyz = tmpvar_27;
  };
  c_2.w = tmpvar_5;
  gl_FragData[0] = c_2;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (tmpvar_2 * unity_Scale.w));
  tmpvar_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_1.xyz;
  tmpvar_7 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0].x = tmpvar_6.x;
  tmpvar_8[0].y = tmpvar_7.x;
  tmpvar_8[0].z = tmpvar_2.x;
  tmpvar_8[1].x = tmpvar_6.y;
  tmpvar_8[1].y = tmpvar_7.y;
  tmpvar_8[1].z = tmpvar_2.y;
  tmpvar_8[2].x = tmpvar_6.z;
  tmpvar_8[2].y = tmpvar_7.z;
  tmpvar_8[2].z = tmpvar_2.z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_8 * ((
    (_World2Object * tmpvar_9)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp float cosAngle_1;
  lowp vec4 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_5;
  tmpvar_5 = (tmpvar_3.x * _Color.w);
  lowp float shadow_6;
  mediump float tmpvar_7;
  tmpvar_7 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_8;
  tmpvar_8 = tmpvar_7;
  highp float tmpvar_9;
  tmpvar_9 = (_LightShadowData.x + (tmpvar_8 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_9;
  c_2.w = 0.0;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_11;
  mediump vec3 viewDir_12;
  viewDir_12 = tmpvar_10;
  mediump vec3 specColor_13;
  highp float nh_14;
  mediump vec3 scalePerBasisVector_15;
  mediump vec3 lm_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_16 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_15 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, normalize((
    normalize((((scalePerBasisVector_15.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_15.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_15.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_12)).z);
  nh_14 = tmpvar_19;
  highp float tmpvar_20;
  mediump float y_21;
  y_21 = (_Shininess * 128.0);
  tmpvar_20 = pow (nh_14, y_21);
  highp vec3 tmpvar_22;
  tmpvar_22 = (((lm_16 * _SpecColor.xyz) * tmpvar_3.x) * tmpvar_20);
  specColor_13 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = lm_16;
  tmpvar_23.w = tmpvar_20;
  tmpvar_11 = tmpvar_23;
  c_2.xyz = specColor_13;
  lowp float tmpvar_24;
  tmpvar_24 = dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz);
  cosAngle_1 = tmpvar_24;
  if ((cosAngle_1 > 0.0)) {
    lowp vec3 tmpvar_25;
    tmpvar_25 = vec3((shadow_6 * 2.0));
    mediump vec3 tmpvar_26;
    tmpvar_26 = (c_2.xyz + (tmpvar_4 * min (tmpvar_11.xyz, tmpvar_25)));
    c_2.xyz = tmpvar_26;
  } else {
    lowp vec3 tmpvar_27;
    tmpvar_27 = vec3((shadow_6 * 3.0));
    mediump vec3 tmpvar_28;
    tmpvar_28 = (c_2.xyz + (tmpvar_4 * min (tmpvar_11.xyz, tmpvar_27)));
    c_2.xyz = tmpvar_28;
  };
  c_2.w = tmpvar_5;
  _glesFragData[0] = c_2;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - cse_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - cse_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - cse_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_26)
  )) * (1.0/((1.0 + 
    (tmpvar_26 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_27.z)
  ) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_22);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  lowp float shadow_5;
  lowp float tmpvar_6;
  tmpvar_6 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_7;
  tmpvar_7 = (_LightShadowData.x + (tmpvar_6 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_9;
  viewDir_9 = tmpvar_8;
  lowp vec4 c_10;
  highp float nh_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_9)
  )));
  nh_11 = tmpvar_13;
  mediump float y_14;
  y_14 = (_Shininess * 128.0);
  highp float tmpvar_15;
  tmpvar_15 = (pow (nh_11, y_14) * tmpvar_2.x);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_12) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_15)) * (shadow_5 * 2.0));
  c_10.xyz = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (tmpvar_4 + ((
    (_LightColor0.w * _SpecColor.w)
   * tmpvar_15) * shadow_5));
  c_10.w = tmpvar_17;
  c_1.w = c_10.w;
  c_1.xyz = (c_10.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
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
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec4 cse_22;
  cse_22 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - cse_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - cse_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - cse_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_26)
  )) * (1.0/((1.0 + 
    (tmpvar_26 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_27.z)
  ) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_WorldSpaceCameraPos - cse_22.xyz);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_22);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
in highp vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.x * _Color.w);
  lowp float shadow_5;
  mediump float tmpvar_6;
  tmpvar_6 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD3);
  mediump vec3 viewDir_10;
  viewDir_10 = tmpvar_9;
  lowp vec4 c_11;
  highp float nh_12;
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (xlv_TEXCOORD1, normalize(
    (_WorldSpaceLightPos0.xyz + viewDir_10)
  )));
  nh_12 = tmpvar_14;
  mediump float y_15;
  y_15 = (_Shininess * 128.0);
  highp float tmpvar_16;
  tmpvar_16 = (pow (nh_12, y_15) * tmpvar_2.x);
  highp vec3 tmpvar_17;
  tmpvar_17 = (((
    (tmpvar_3 * _LightColor0.xyz)
   * tmpvar_13) + (
    (_LightColor0.xyz * _SpecColor.xyz)
   * tmpvar_16)) * (shadow_5 * 2.0));
  c_11.xyz = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (tmpvar_4 + ((
    (_LightColor0.w * _SpecColor.w)
   * tmpvar_16) * shadow_5));
  c_11.w = tmpvar_18;
  c_1.w = c_11.w;
  c_1.xyz = (c_11.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
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
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform mediump float _Shininess;
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = _Shininess;
  gl_FragData[0] = res_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform mediump float _Shininess;
in lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = _Shininess;
  _glesFragData[0] = res_1;
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
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_8;
  lowp vec4 c_9;
  lowp float spec_10;
  mediump float tmpvar_11;
  tmpvar_11 = (tmpvar_7.w * tmpvar_4.x);
  spec_10 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tmpvar_5 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_10));
  c_9.xyz = tmpvar_12;
  c_9.w = ((tmpvar_4.x * _Color.w) + (spec_10 * _SpecColor.w));
  c_2 = c_9;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_8;
  lowp vec4 c_9;
  lowp float spec_10;
  mediump float tmpvar_11;
  tmpvar_11 = (tmpvar_7.w * tmpvar_4.x);
  spec_10 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tmpvar_5 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_10));
  c_9.xyz = tmpvar_12;
  c_9.w = ((tmpvar_4.x * _Color.w) + (spec_10 * _SpecColor.w));
  c_2 = c_9;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_10.w;
  highp float tmpvar_11;
  tmpvar_11 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_13;
  light_6.xyz = (tmpvar_10.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_14;
  lowp float spec_15;
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_10.w * tmpvar_7.x);
  spec_15 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_8 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_15));
  c_14.xyz = tmpvar_17;
  c_14.w = ((tmpvar_7.x * _Color.w) + (spec_15 * _SpecColor.w));
  c_2 = c_14;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_10.w;
  highp float tmpvar_11;
  tmpvar_11 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_13;
  light_6.xyz = (tmpvar_10.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_14;
  lowp float spec_15;
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_10.w * tmpvar_7.x);
  spec_15 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_8 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_15));
  c_14.xyz = tmpvar_17;
  c_14.w = ((tmpvar_7.x * _Color.w) + (spec_15 * _SpecColor.w));
  c_2 = c_14;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_8;
  mediump vec3 viewDir_9;
  viewDir_9 = tmpvar_7;
  highp float nh_10;
  mediump vec3 scalePerBasisVector_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_12 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_11 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, normalize((
    normalize((((scalePerBasisVector_11.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_11.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_11.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_9)).z);
  nh_10 = tmpvar_15;
  mediump float y_16;
  y_16 = (_Shininess * 128.0);
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = lm_12;
  tmpvar_17.w = pow (nh_10, y_16);
  tmpvar_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_8);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  lowp float spec_20;
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_18.w * tmpvar_4.x);
  spec_20 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tmpvar_5 * tmpvar_18.xyz) + ((tmpvar_18.xyz * _SpecColor.xyz) * spec_20));
  c_19.xyz = tmpvar_22;
  c_19.w = ((tmpvar_4.x * _Color.w) + (spec_20 * _SpecColor.w));
  c_2 = c_19;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_8;
  mediump vec3 viewDir_9;
  viewDir_9 = tmpvar_7;
  highp float nh_10;
  mediump vec3 scalePerBasisVector_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_12 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_11 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, normalize((
    normalize((((scalePerBasisVector_11.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_11.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_11.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_9)).z);
  nh_10 = tmpvar_15;
  mediump float y_16;
  y_16 = (_Shininess * 128.0);
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = lm_12;
  tmpvar_17.w = pow (nh_10, y_16);
  tmpvar_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_8);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  lowp float spec_20;
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_18.w * tmpvar_4.x);
  spec_20 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tmpvar_5 * tmpvar_18.xyz) + ((tmpvar_18.xyz * _SpecColor.xyz) * spec_20));
  c_19.xyz = tmpvar_22;
  c_19.w = ((tmpvar_4.x * _Color.w) + (spec_20 * _SpecColor.w));
  c_2 = c_19;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_8;
  lowp vec4 c_9;
  lowp float spec_10;
  mediump float tmpvar_11;
  tmpvar_11 = (tmpvar_7.w * tmpvar_4.x);
  spec_10 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tmpvar_5 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_10));
  c_9.xyz = tmpvar_12;
  c_9.w = ((tmpvar_4.x * _Color.w) + (spec_10 * _SpecColor.w));
  c_2 = c_9;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_7.w;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_8;
  lowp vec4 c_9;
  lowp float spec_10;
  mediump float tmpvar_11;
  tmpvar_11 = (tmpvar_7.w * tmpvar_4.x);
  spec_10 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = ((tmpvar_5 * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_10));
  c_9.xyz = tmpvar_12;
  c_9.w = ((tmpvar_4.x * _Color.w) + (spec_10 * _SpecColor.w));
  c_2 = c_9;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_10.w;
  highp float tmpvar_11;
  tmpvar_11 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_13;
  light_6.xyz = (tmpvar_10.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_14;
  lowp float spec_15;
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_10.w * tmpvar_7.x);
  spec_15 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_8 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_15));
  c_14.xyz = tmpvar_17;
  c_14.w = ((tmpvar_7.x * _Color.w) + (spec_15 * _SpecColor.w));
  c_2 = c_14;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_10.w;
  highp float tmpvar_11;
  tmpvar_11 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_13;
  light_6.xyz = (tmpvar_10.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_14;
  lowp float spec_15;
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_10.w * tmpvar_7.x);
  spec_15 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_8 * light_6.xyz) + ((light_6.xyz * _SpecColor.xyz) * spec_15));
  c_14.xyz = tmpvar_17;
  c_14.w = ((tmpvar_7.x * _Color.w) + (spec_15 * _SpecColor.w));
  c_2 = c_14;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MainTex, xlv_TEXCOORD0) + (texture2D (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_8;
  mediump vec3 viewDir_9;
  viewDir_9 = tmpvar_7;
  highp float nh_10;
  mediump vec3 scalePerBasisVector_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_12 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_11 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, normalize((
    normalize((((scalePerBasisVector_11.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_11.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_11.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_9)).z);
  nh_10 = tmpvar_15;
  mediump float y_16;
  y_16 = (_Shininess * 128.0);
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = lm_12;
  tmpvar_17.w = pow (nh_10, y_16);
  tmpvar_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_8);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  lowp float spec_20;
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_18.w * tmpvar_4.x);
  spec_20 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tmpvar_5 * tmpvar_18.xyz) + ((tmpvar_18.xyz * _SpecColor.xyz) * spec_20));
  c_19.xyz = tmpvar_22;
  c_19.w = ((tmpvar_4.x * _Color.w) + (spec_20 * _SpecColor.w));
  c_2 = c_19;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_7 = tmpvar_1.xyz;
  tmpvar_8 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_9;
  tmpvar_9[0].x = tmpvar_7.x;
  tmpvar_9[0].y = tmpvar_8.x;
  tmpvar_9[0].z = tmpvar_2.x;
  tmpvar_9[1].x = tmpvar_7.y;
  tmpvar_9[1].y = tmpvar_8.y;
  tmpvar_9[1].z = tmpvar_2.y;
  tmpvar_9[2].x = tmpvar_7.z;
  tmpvar_9[2].y = tmpvar_8.z;
  tmpvar_9[2].z = tmpvar_2.z;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (tmpvar_9 * ((
    (_World2Object * tmpvar_10)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform sampler2D _FXTex;
uniform lowp vec4 _Color;
uniform lowp float _Weight;
uniform mediump float _Shininess;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_AlphaTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_MainTex, xlv_TEXCOORD0) + (texture (_FXTex, xlv_TEXCOORD0) * _Weight)).xyz * _Color.xyz);
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  mediump vec4 tmpvar_8;
  mediump vec3 viewDir_9;
  viewDir_9 = tmpvar_7;
  highp float nh_10;
  mediump vec3 scalePerBasisVector_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_12 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_11 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, normalize((
    normalize((((scalePerBasisVector_11.x * vec3(0.816497, 0.0, 0.57735)) + (scalePerBasisVector_11.y * vec3(-0.408248, 0.707107, 0.57735))) + (scalePerBasisVector_11.z * vec3(-0.408248, -0.707107, 0.57735))))
   + viewDir_9)).z);
  nh_10 = tmpvar_15;
  mediump float y_16;
  y_16 = (_Shininess * 128.0);
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = lm_12;
  tmpvar_17.w = pow (nh_10, y_16);
  tmpvar_8 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_8);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  lowp float spec_20;
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_18.w * tmpvar_4.x);
  spec_20 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tmpvar_5 * tmpvar_18.xyz) + ((tmpvar_18.xyz * _SpecColor.xyz) * spec_20));
  c_19.xyz = tmpvar_22;
  c_19.w = ((tmpvar_4.x * _Color.w) + (spec_20 * _SpecColor.w));
  c_2 = c_19;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
}
 }
}
Fallback "VertexLit"
}