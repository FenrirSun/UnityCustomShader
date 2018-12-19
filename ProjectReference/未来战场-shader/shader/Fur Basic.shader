Shader "VX/Character New/Fur Basic" {
Properties {
 _Color ("Ambient Color (RGB)", Color) = (0,0,0,0)
 _SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
 _Shininess ("Shininess", Range(0.01,10)) = 8
 _FurLength ("Fur Length", Range(0.0002,0.5)) = 0.05
 _MainTex ("Base Color(RGB)", 2D) = "white" {}
 _MaskMap ("Mask", 2D) = "white" {}
 _NoiseTex ("Noise (RGB)", 2D) = "white" {}
 _EdgeFade ("Edge Fade", Range(0,1)) = 0.15
 _HairThinness ("Fur Thinness", Range(0.01,10)) = 2
 _HairShading ("Fur Shading", Range(1,2.5)) = 2
 _SkinAlpha ("Mask Alpha Factor", Range(0,1)) = 0
}
SubShader { 
 LOD 300
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _glesVertex.xyz;
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _HairShading;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  texcol_1.w = 1.0;
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _glesVertex.xyz;
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _HairShading;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  texcol_1.w = 1.0;
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.1)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.1 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.01 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.1)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.1 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.01 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.2)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.2 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.04 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.2)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.2 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.04 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.3)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.3 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.09 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.3)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.3 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.09 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.4)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.4 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.16 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.4)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.4 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.16 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.5)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.5 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.25 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.5)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.5 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.25 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.6)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.6 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.36 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.6)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.6 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.36 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.7)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.7 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.49 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.7)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.7 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.49 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.8)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.8 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.64 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.8)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.8 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.64 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.9)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.9 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.81 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.9)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.9 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.81 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * _FurLength));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((1.0 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - _EdgeFade), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * _FurLength));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((1.0 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - _EdgeFade), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
SubShader { 
 LOD 100
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _glesVertex.xyz;
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _HairShading;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  texcol_1.w = 1.0;
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _glesVertex.xyz;
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _HairShading;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  texcol_1.w = 1.0;
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.2)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.2 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.04 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.2)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.2 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.04 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.4)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.4 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.16 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.4)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.4 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.16 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.6)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.6 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.36 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.6)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.6 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.36 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.8)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.8 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - (0.64 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * (_FurLength * 0.8)));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((0.8 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - (0.64 * _EdgeFade)), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * _FurLength));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((1.0 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture2D (_NoiseTex, P_6).x - _EdgeFade), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  lowp float spec_2;
  lowp vec3 worldView_3;
  lowp vec3 vertexLight_4;
  lowp vec3 lightDir_5;
  lowp vec3 worldNormal_6;
  lowp vec3 P_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesVertex.xyz + (tmpvar_1 * _FurLength));
  P_7 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = P_7;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = _Object2World[0].xyz;
  tmpvar_10[1] = _Object2World[1].xyz;
  tmpvar_10[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (tmpvar_1 * unity_Scale.w));
  worldNormal_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_12;
  highp vec4 cse_13;
  cse_13 = (_Object2World * _glesVertex);
  highp vec3 normal_14;
  normal_14 = worldNormal_6;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - cse_13.x);
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - cse_13.y);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - cse_13.z);
  highp vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  highp vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * normal_14.x) + (tmpvar_16 * normal_14.y)) + (tmpvar_17 * normal_14.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_20;
  tmpvar_20 = (((
    (unity_LightColor[0].xyz * tmpvar_19.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_19.y)
  ) + (unity_LightColor[2].xyz * tmpvar_19.z)) + (unity_LightColor[3].xyz * tmpvar_19.w));
  vertexLight_4 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceCameraPos - cse_13.xyz));
  worldView_3 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_22, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, dot (worldNormal_6, lightDir_5)))
  ) + vertexLight_4) + spec_2);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_24;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform lowp float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  texcol_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha);
  int tmpvar_4;
  if ((1.0 > tmpvar_3)) {
    tmpvar_4 = -1;
  } else {
    tmpvar_4 = 1;
  };
  highp float x_5;
  x_5 = float(tmpvar_4);
  if ((x_5 < 0.0)) {
    discard;
  };
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = clamp ((texture (_NoiseTex, P_6).x - _EdgeFade), 0.0, 1.0);
  texcol_1.xyz = (tmpvar_2.xyz * (xlv_COLOR0.xyz * _HairShading));
  _glesFragData[0] = texcol_1;
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
Fallback Off
}