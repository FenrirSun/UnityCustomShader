Shader "VX/Particles/DistortionCutout" {
Properties {
 _TintColor ("Tint Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "black" {}
 _CutOut ("CutOut (A)", 2D) = "black" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _ColorStrength ("Color Strength", Float) = 1
 _BumpAmt ("Distortion", Float) = 10
 _InvFade ("Soft Particles Factor", Range(0,10)) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }
 GrabPass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" }
 }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CutOut_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((tmpvar_2.xy + tmpvar_2.w) * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _CutOut;
uniform sampler2D _BumpMap;
uniform highp float _BumpAmt;
uniform highp float _ColorStrength;
uniform sampler2D _GrabTexture;
uniform highp vec4 _GrabTexture_TexelSize;
uniform lowp vec4 _TintColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = xlv_TEXCOORD0.zw;
  lowp vec4 emission_3;
  mediump vec4 col_4;
  mediump vec2 bump_5;
  lowp vec2 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
  bump_5 = tmpvar_6;
  tmpvar_2.xy = (((
    (bump_5 * _BumpAmt)
   * _GrabTexture_TexelSize.xy) * xlv_TEXCOORD0.z) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_GrabTexture, tmpvar_2);
  col_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD2) * xlv_COLOR);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((col_4 * xlv_COLOR) + ((tmpvar_8 * _ColorStrength) * _TintColor));
  emission_3.xyz = tmpvar_9.xyz;
  emission_3.w = ((_TintColor.w * xlv_COLOR.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * xlv_COLOR).w);
  tmpvar_1 = emission_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CutOut_ST;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xy = ((tmpvar_2.xy + tmpvar_2.w) * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _CutOut;
uniform sampler2D _BumpMap;
uniform highp float _BumpAmt;
uniform highp float _ColorStrength;
uniform sampler2D _GrabTexture;
uniform highp vec4 _GrabTexture_TexelSize;
uniform lowp vec4 _TintColor;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = xlv_TEXCOORD0.zw;
  lowp vec4 emission_3;
  mediump vec4 col_4;
  mediump vec2 bump_5;
  lowp vec2 tmpvar_6;
  tmpvar_6 = ((texture (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
  bump_5 = tmpvar_6;
  tmpvar_2.xy = (((
    (bump_5 * _BumpAmt)
   * _GrabTexture_TexelSize.xy) * xlv_TEXCOORD0.z) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = textureProj (_GrabTexture, tmpvar_2);
  col_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture (_MainTex, xlv_TEXCOORD2) * xlv_COLOR);
  highp vec4 tmpvar_9;
  tmpvar_9 = ((col_4 * xlv_COLOR) + ((tmpvar_8 * _ColorStrength) * _TintColor));
  emission_3.xyz = tmpvar_9.xyz;
  emission_3.w = ((_TintColor.w * xlv_COLOR.w) * (texture (_CutOut, xlv_TEXCOORD3) * xlv_COLOR).w);
  tmpvar_1 = emission_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CutOut_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  tmpvar_1.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  tmpvar_1.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CutOut;
uniform sampler2D _BumpMap;
uniform highp float _BumpAmt;
uniform highp float _ColorStrength;
uniform sampler2D _GrabTexture;
uniform highp vec4 _GrabTexture_TexelSize;
uniform lowp vec4 _TintColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_2 = xlv_TEXCOORD0;
  tmpvar_3 = xlv_COLOR;
  lowp vec4 emission_4;
  mediump vec4 col_5;
  mediump vec2 bump_6;
  if ((_InvFade > 0.0001)) {
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
    highp float z_8;
    z_8 = tmpvar_7.x;
    highp float tmpvar_9;
    tmpvar_9 = (xlv_COLOR.w * clamp ((_InvFade * 
      ((1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)
    ), 0.0, 1.0));
    tmpvar_3.w = tmpvar_9;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
  bump_6 = tmpvar_10;
  tmpvar_2.xy = (((
    (bump_6 * _BumpAmt)
   * _GrabTexture_TexelSize.xy) * xlv_TEXCOORD0.z) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_GrabTexture, tmpvar_2);
  col_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD2) * tmpvar_3);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((col_5 * tmpvar_3) + ((tmpvar_12 * _ColorStrength) * _TintColor));
  emission_4.xyz = tmpvar_13.xyz;
  emission_4.w = ((_TintColor.w * tmpvar_3.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * tmpvar_3).w);
  tmpvar_1 = emission_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CutOut_ST;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out lowp vec4 xlv_COLOR;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  tmpvar_1.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  tmpvar_1.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CutOut;
uniform sampler2D _BumpMap;
uniform highp float _BumpAmt;
uniform highp float _ColorStrength;
uniform sampler2D _GrabTexture;
uniform highp vec4 _GrabTexture_TexelSize;
uniform lowp vec4 _TintColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in lowp vec4 xlv_COLOR;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_2 = xlv_TEXCOORD0;
  tmpvar_3 = xlv_COLOR;
  lowp vec4 emission_4;
  mediump vec4 col_5;
  mediump vec2 bump_6;
  if ((_InvFade > 0.0001)) {
    lowp vec4 tmpvar_7;
    tmpvar_7 = textureProj (_CameraDepthTexture, xlv_TEXCOORD4);
    highp float z_8;
    z_8 = tmpvar_7.x;
    highp float tmpvar_9;
    tmpvar_9 = (xlv_COLOR.w * clamp ((_InvFade * 
      ((1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w))) - xlv_TEXCOORD4.z)
    ), 0.0, 1.0));
    tmpvar_3.w = tmpvar_9;
  };
  lowp vec2 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
  bump_6 = tmpvar_10;
  tmpvar_2.xy = (((
    (bump_6 * _BumpAmt)
   * _GrabTexture_TexelSize.xy) * xlv_TEXCOORD0.z) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_11;
  tmpvar_11 = textureProj (_GrabTexture, tmpvar_2);
  col_5 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture (_MainTex, xlv_TEXCOORD2) * tmpvar_3);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((col_5 * tmpvar_3) + ((tmpvar_12 * _ColorStrength) * _TintColor));
  emission_4.xyz = tmpvar_13.xyz;
  emission_4.w = ((_TintColor.w * tmpvar_3.w) * (texture (_CutOut, xlv_TEXCOORD3) * tmpvar_3).w);
  tmpvar_1 = emission_4;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend DstColor Zero
  SetTexture [_MainTex] { combine texture }
 }
}
}