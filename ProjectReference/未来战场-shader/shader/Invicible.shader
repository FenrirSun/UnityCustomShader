Shader "VX/FX/Invisible" {
Properties {
 _TexMain ("TexMain", 2D) = "white" {}
 _TexMain2 ("TexMain2", 2D) = "white" {}
 _Tex_ScrollX ("Tex_ScrollX", 2D) = "white" {}
 _Tex_ScrollY ("Tex_ScrollY", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Name "FORWARDBASE"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesTANGENT;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture2D (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture2D (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture2D (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture2D (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * _World2Object).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Object2World * tmpvar_4).xyz);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_Object2World * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = normalize(((
    (tmpvar_3.yzx * tmpvar_5.zxy)
   - 
    (tmpvar_3.zxy * tmpvar_5.yzx)
  ) * _glesTANGENT.w));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _TimeEditor;
uniform sampler2D _Tex_ScrollX;
uniform highp vec4 _Tex_ScrollX_ST;
uniform sampler2D _Tex_ScrollY;
uniform highp vec4 _Tex_ScrollY_ST;
uniform sampler2D _TexMain;
uniform highp vec4 _TexMain_ST;
uniform sampler2D _TexMain2;
uniform highp vec4 _TexMain2_ST;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0].x = xlv_TEXCOORD3.x;
  tmpvar_2[0].y = xlv_TEXCOORD4.x;
  tmpvar_2[0].z = xlv_TEXCOORD2.x;
  tmpvar_2[1].x = xlv_TEXCOORD3.y;
  tmpvar_2[1].y = xlv_TEXCOORD4.y;
  tmpvar_2[1].z = xlv_TEXCOORD2.y;
  tmpvar_2[2].x = xlv_TEXCOORD3.z;
  tmpvar_2[2].y = xlv_TEXCOORD4.z;
  tmpvar_2[2].z = xlv_TEXCOORD2.z;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz));
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Time + _TimeEditor);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 0.0))
  ) * _Tex_ScrollX_ST.xy) + _Tex_ScrollX_ST.zw);
  tmpvar_5 = texture (_Tex_ScrollX, P_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (((xlv_TEXCOORD0 + 
    (tmpvar_4.y * vec2(0.1, 1.0))
  ) * _Tex_ScrollY_ST.xy) + _Tex_ScrollY_ST.zw);
  tmpvar_7 = texture (_Tex_ScrollY, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (((tmpvar_5.x * 0.6) + (tmpvar_7.x * 0.6)) * 3.0);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.0)))
  ) * _TexMain_ST.xy) + _TexMain_ST.zw);
  tmpvar_10 = texture (_TexMain, P_11);
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (((
    ((0.05 * (tmpvar_9 - 0.5)) * (tmpvar_2 * tmpvar_3).xy)
   + 
    (xlv_TEXCOORD0 + (tmpvar_4.y * vec2(0.1, 0.2)))
  ) * _TexMain2_ST.xy) + _TexMain2_ST.zw);
  tmpvar_12 = texture (_TexMain2, P_13);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((1.0 - max (0.0, 
    dot (xlv_TEXCOORD2, tmpvar_3)
  )) * (vec3(0.8, 0.6, 0.4) + (
    (tmpvar_10.xyz + tmpvar_12.xyz)
   * 2.0)));
  tmpvar_1 = tmpvar_14;
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
}
Fallback "Diffuse"
}