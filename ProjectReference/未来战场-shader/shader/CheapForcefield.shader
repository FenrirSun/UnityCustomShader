Shader "VX/FX/CheapForcefield" {
Properties {
 _Color ("_Color", Color) = (0,1,0,1)
 _Inside ("_Inside", Range(0,0.2)) = 0
 _Rim ("_Rim", Range(1,2)) = 1.2
 _Texture ("_Texture", 2D) = "white" {}
 _Speed ("_Speed", Range(0.5,5)) = 0.5
 _Tile ("_Tile", Range(1,10)) = 5
 _Strength ("_Strength", Range(0,5)) = 1.5
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
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
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_6 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_13;
  mediump vec4 normal_14;
  normal_14 = tmpvar_12;
  highp float vC_15;
  mediump vec3 x3_16;
  mediump vec3 x2_17;
  mediump vec3 x1_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAr, normal_14);
  x1_18.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAg, normal_14);
  x1_18.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAb, normal_14);
  x1_18.z = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normal_14.xyzz * normal_14.yzzx);
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBr, tmpvar_22);
  x2_17.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBg, tmpvar_22);
  x2_17.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBb, tmpvar_22);
  x2_17.z = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y));
  vC_15 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = (unity_SHC.xyz * vC_15);
  x3_16 = tmpvar_27;
  tmpvar_13 = ((x1_18 + x2_17) + x3_16);
  shlight_3 = tmpvar_13;
  tmpvar_5 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
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
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_6 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_13;
  mediump vec4 normal_14;
  normal_14 = tmpvar_12;
  highp float vC_15;
  mediump vec3 x3_16;
  mediump vec3 x2_17;
  mediump vec3 x1_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAr, normal_14);
  x1_18.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAg, normal_14);
  x1_18.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAb, normal_14);
  x1_18.z = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normal_14.xyzz * normal_14.yzzx);
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBr, tmpvar_22);
  x2_17.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBg, tmpvar_22);
  x2_17.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBb, tmpvar_22);
  x2_17.z = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = ((normal_14.x * normal_14.x) - (normal_14.y * normal_14.y));
  vC_15 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = (unity_SHC.xyz * vC_15);
  x3_16 = tmpvar_27;
  tmpvar_13 = ((x1_18 + x2_17) + x3_16);
  shlight_3 = tmpvar_13;
  tmpvar_5 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 * ((
    (_World2Object * tmpvar_11)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_5 * ((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1).z;
  tmpvar_4 = (1.0 - tmpvar_5);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_5 * ((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1).z;
  tmpvar_4 = (1.0 - tmpvar_5);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_5 * ((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_5 * ((
    (_World2Object * tmpvar_6)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
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
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_7;
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_5 = shlight_3;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_29.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_29.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_29.z);
  highp vec4 tmpvar_33;
  tmpvar_33 = (((tmpvar_30 * tmpvar_30) + (tmpvar_31 * tmpvar_31)) + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_34;
  tmpvar_34 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_30 * tmpvar_7.x) + (tmpvar_31 * tmpvar_7.y)) + (tmpvar_32 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_33)
  )) * (1.0/((1.0 + 
    (tmpvar_33 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_5 + ((
    ((unity_LightColor[0].xyz * tmpvar_34.x) + (unity_LightColor[1].xyz * tmpvar_34.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_34.z)
  ) + (unity_LightColor[3].xyz * tmpvar_34.w)));
  tmpvar_5 = tmpvar_35;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesTANGENT;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
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
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_7;
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_5 = shlight_3;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_29.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_29.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_29.z);
  highp vec4 tmpvar_33;
  tmpvar_33 = (((tmpvar_30 * tmpvar_30) + (tmpvar_31 * tmpvar_31)) + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_34;
  tmpvar_34 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_30 * tmpvar_7.x) + (tmpvar_31 * tmpvar_7.y)) + (tmpvar_32 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_33)
  )) * (1.0/((1.0 + 
    (tmpvar_33 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_5 + ((
    ((unity_LightColor[0].xyz * tmpvar_34.x) + (unity_LightColor[1].xyz * tmpvar_34.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_34.z)
  ) + (unity_LightColor[3].xyz * tmpvar_34.w)));
  tmpvar_5 = tmpvar_35;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  c_1.xyz = _Color.xyz;
  c_1.w = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0
  ColorMask RGB
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
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  gl_FragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  _glesFragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  gl_FragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  _glesFragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  gl_FragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  _glesFragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  gl_FragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * ((
    (_World2Object * _WorldSpaceLightPos0)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  _glesFragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture2D (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  gl_FragData[0] = c_1;
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
uniform highp vec4 _Texture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_6 * ((
    (_World2Object * tmpvar_8)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform lowp vec4 _Color;
uniform lowp float _Inside;
uniform lowp float _Rim;
uniform sampler2D _Texture;
uniform lowp float _Speed;
uniform lowp float _Tile;
uniform lowp float _Strength;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec2 texCoords_2;
  mediump float timeOffset_3;
  lowp float tmpvar_4;
  highp vec3 cse_5;
  cse_5 = normalize(xlv_TEXCOORD1);
  tmpvar_4 = (1.0 - cse_5.z);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.x * _Speed);
  timeOffset_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = (xlv_TEXCOORD0.y + timeOffset_3);
  texCoords_2 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (texCoords_2 * vec2(_Tile));
  texCoords_2 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = (((
    (texture (_Texture, tmpvar_8).x * _Strength)
   * 
    pow (tmpvar_4, _Rim)
  ) * clamp (
    float((1.0 >= tmpvar_4))
  , _Inside, 1.0)) * _Color.w);
  lowp vec4 c_10;
  c_10.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_11;
  tmpvar_11 = tmpvar_9;
  c_10.w = tmpvar_11;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_9;
  _glesFragData[0] = c_1;
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
}
Fallback "Diffuse"
}