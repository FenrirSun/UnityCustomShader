Shader "VX/Character New/Fur Basic Shadow" {
Properties {
 _Color ("Ambient Color (RGB)", Color) = (0,0,0,0)
 _SpecColor ("Specular Color (RGB)", Color) = (1,1,1,1)
 _Shininess ("Shininess", Range(0.01,10)) = 8
 _FurLength ("Fur Length", Range(0.0002,0.5)) = 0.05
 _MainTex ("Base Color(RGB)", 2D) = "white" {}
 _MaskMap ("Mask R(Fur Length) G(Shadow Intensity) B(None)", 2D) = "white" {}
 _NoiseTex ("Noise (RGB)", 2D) = "white" {}
 _EdgeFade ("Edge Fade", Range(0,1)) = 0.15
 _HairThinness ("Fur Thinness", Range(0.01,10)) = 2
 _HairShading ("Fur Shading", Range(1,2.5)) = 2
 _SkinAlpha ("Mask Alpha Factor", Range(0,1)) = 0
 _ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
}
SubShader { 
 LOD 300
 Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
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
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
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
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MaskMap;
uniform lowp float _HairShading;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  texcol_2.w = 1.0;
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.01 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.1)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.01 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.1)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.01 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.1)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.04 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.2)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.04 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.2)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.04 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.2)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.09 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.3)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.09 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.3)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.09 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.3)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.16 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.4)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.16 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.4)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.16 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.4)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.25 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.5)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.25 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.5)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.25 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.5)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.36 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.6)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.36 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.6)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.36 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.6)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.49 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.7)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.49 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.7)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.49 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.7)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.64 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.8)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.64 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.8)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.64 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.8)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.81 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.9)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.81 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.9)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.81 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.9)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - _EdgeFade), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 1.0)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - _EdgeFade), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 1.0)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - _EdgeFade), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 1.0)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 UsePass "VertexLit/SHADOWCASTER"
 UsePass "VertexLit/SHADOWCOLLECTOR"
}
SubShader { 
 LOD 100
 Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
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
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
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
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _MaskMap;
uniform lowp float _HairShading;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  texcol_2.w = 1.0;
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.04 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.2)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.04 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.2)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.04 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.2)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.16 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.4)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.16 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.4)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.16 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.4)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.36 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.6)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.36 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.6)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.36 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.6)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - 
    (0.64 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.8)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - 
    (0.64 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 0.8)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - 
    (0.64 * _EdgeFade)
  ), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 0.8)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture2D (_NoiseTex, P_2).x - _EdgeFade), 0.0, 1.0) * ceil((
    max (texture2D (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 1.0)));
  gl_FragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 texcol_1;
  texcol_1.xyz = (texture (_MainTex, xlv_TEXCOORD0).xyz * (xlv_COLOR0.xyz * _HairShading));
  mediump vec2 P_2;
  P_2 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_1.w = (clamp ((texture (_NoiseTex, P_2).x - _EdgeFade), 0.0, 1.0) * ceil((
    max (texture (_MaskMap, xlv_TEXCOORD0).x, _SkinAlpha)
   - 1.0)));
  _glesFragData[0] = texcol_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
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
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform lowp vec4 _LightColor0;
uniform lowp float _FurLength;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  lowp float tmpvar_13;
  tmpvar_13 = dot (worldNormal_6, lightDir_5);
  highp vec4 cse_14;
  cse_14 = (_Object2World * _glesVertex);
  highp vec3 normal_15;
  normal_15 = worldNormal_6;
  highp vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - cse_14.x);
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - cse_14.y);
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - cse_14.z);
  highp vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  highp vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * normal_15.x) + (tmpvar_17 * normal_15.y)) + (tmpvar_18 * normal_15.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    (unity_LightColor[0].xyz * tmpvar_20.x)
   + 
    (unity_LightColor[1].xyz * tmpvar_20.y)
  ) + (unity_LightColor[2].xyz * tmpvar_20.z)) + (unity_LightColor[3].xyz * tmpvar_20.w));
  vertexLight_4 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceCameraPos - cse_14.xyz));
  worldView_3 = tmpvar_22;
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, dot (worldNormal_6, normalize(
    (lightDir_5 + worldView_3)
  )));
  mediump float tmpvar_24;
  tmpvar_24 = ((_LightColor0.xyz * _SpecColor.xyz) * pow (tmpvar_23, (_Shininess * 128.0))).x;
  spec_2 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = (((_Color.xyz + 
    (_LightColor0.xyz * max (0.0, tmpvar_13))
  ) + vertexLight_4) + spec_2);
  tmpvar_25.w = ((tmpvar_13 * 0.5) + 0.5);
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * cse_14);
  xlv_COLOR0 = tmpvar_25;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform sampler2D _MaskMap;
uniform lowp float _EdgeFade;
uniform mediump float _HairThinness;
uniform lowp float _HairShading;
uniform lowp float _SkinAlpha;
uniform lowp vec4 _ShadowColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp float atten_1;
  lowp vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskMap, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  atten_1 = tmpvar_5;
  if ((xlv_COLOR0.w > 0.6)) {
    lowp float tmpvar_6;
    mediump float lightShadowDataX_7;
    highp float dist_8;
    lowp float tmpvar_9;
    tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
    dist_8 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = _LightShadowData.x;
    lightShadowDataX_7 = tmpvar_10;
    highp float tmpvar_11;
    tmpvar_11 = max (float((dist_8 > 
      (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w)
    )), lightShadowDataX_7);
    tmpvar_6 = tmpvar_11;
    atten_1 = tmpvar_6;
  };
  texcol_2.xyz = (tmpvar_3.xyz * ((xlv_COLOR0.xyz * _HairShading) * (
    ((tmpvar_4.y * (1.0 - atten_1)) * (_ShadowColor.xyz - 1.0))
   + 1.0)));
  mediump vec2 P_12;
  P_12 = (xlv_TEXCOORD0 * _HairThinness);
  texcol_2.w = (clamp ((texture2D (_NoiseTex, P_12).x - _EdgeFade), 0.0, 1.0) * ceil((
    max (tmpvar_4.x, _SkinAlpha)
   - 1.0)));
  gl_FragData[0] = texcol_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SCREEN" }
"!!GLES"
}
}
 }
 UsePass "VertexLit/SHADOWCASTER"
 UsePass "VertexLit/SHADOWCOLLECTOR"
}
Fallback Off
}