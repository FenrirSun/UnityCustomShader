Shader "VX/Postprocess/BlurGrab" {
Properties {
 _MainTex ("-", 2D) = "black" {}
 _BlurredTex ("-", 2D) = "black" {}
 _MaskTex ("-", 2D) = "black" {}
}
SubShader { 
 GrabPass {
  "_MainTex"
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Offsets;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_3;
  cse_3 = (1.0/(_ScreenParams.xyxy));
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0)) * cse_3));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0)) * cse_3));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0)) * cse_3));
  xlv_TEXCOORD4 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(4.0, 4.0, -4.0, -4.0)) * cse_3));
  xlv_TEXCOORD5 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(5.0, 5.0, -5.0, -5.0)) * cse_3));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 sampleK_1;
  highp vec4 sampleJ_2;
  highp vec4 sampleI_3;
  highp vec4 sampleH_4;
  highp vec4 sampleG_5;
  highp vec4 sampleF_6;
  highp vec4 sampleE_7;
  highp vec4 sampleD_8;
  highp vec4 sampleC_9;
  highp vec4 sampleB_10;
  highp vec4 sampleA_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  sampleA_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  sampleB_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD1.zw);
  sampleC_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  sampleD_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD2.zw);
  sampleE_7 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  sampleF_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD3.zw);
  sampleG_5 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  sampleH_4 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD4.zw);
  sampleI_3 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD5.xy);
  sampleJ_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, xlv_TEXCOORD5.zw);
  sampleK_1 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (((
    ((((
      ((((sampleA_11 + 
        (sampleB_10 * 0.8)
      ) + (sampleC_9 * 0.8)) + (sampleD_8 * 0.65)) + (sampleE_7 * 0.65))
     + 
      (sampleF_6 * 0.5)
    ) + (sampleG_5 * 0.5)) + (sampleH_4 * 0.4)) + (sampleI_3 * 0.4))
   + 
    (sampleJ_2 * 0.2)
  ) + (sampleK_1 * 0.2)) / 6.1001);
  gl_FragData[0] = tmpvar_23;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Offsets;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  highp vec4 cse_3;
  cse_3 = (1.0/(_ScreenParams.xyxy));
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(1.0, 1.0, -1.0, -1.0)) * cse_3));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(2.0, 2.0, -2.0, -2.0)) * cse_3));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(3.0, 3.0, -3.0, -3.0)) * cse_3));
  xlv_TEXCOORD4 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(4.0, 4.0, -4.0, -4.0)) * cse_3));
  xlv_TEXCOORD5 = (_glesMultiTexCoord0.xyxy + ((_Offsets.xyxy * vec4(5.0, 5.0, -5.0, -5.0)) * cse_3));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 sampleK_1;
  highp vec4 sampleJ_2;
  highp vec4 sampleI_3;
  highp vec4 sampleH_4;
  highp vec4 sampleG_5;
  highp vec4 sampleF_6;
  highp vec4 sampleE_7;
  highp vec4 sampleD_8;
  highp vec4 sampleC_9;
  highp vec4 sampleB_10;
  highp vec4 sampleA_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_MainTex, xlv_TEXCOORD0);
  sampleA_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_MainTex, xlv_TEXCOORD1.xy);
  sampleB_10 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_MainTex, xlv_TEXCOORD1.zw);
  sampleC_9 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture (_MainTex, xlv_TEXCOORD2.xy);
  sampleD_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_MainTex, xlv_TEXCOORD2.zw);
  sampleE_7 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture (_MainTex, xlv_TEXCOORD3.xy);
  sampleF_6 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture (_MainTex, xlv_TEXCOORD3.zw);
  sampleG_5 = tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture (_MainTex, xlv_TEXCOORD4.xy);
  sampleH_4 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture (_MainTex, xlv_TEXCOORD4.zw);
  sampleI_3 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture (_MainTex, xlv_TEXCOORD5.xy);
  sampleJ_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture (_MainTex, xlv_TEXCOORD5.zw);
  sampleK_1 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (((
    ((((
      ((((sampleA_11 + 
        (sampleB_10 * 0.8)
      ) + (sampleC_9 * 0.8)) + (sampleD_8 * 0.65)) + (sampleE_7 * 0.65))
     + 
      (sampleF_6 * 0.5)
    ) + (sampleG_5 * 0.5)) + (sampleH_4 * 0.4)) + (sampleI_3 * 0.4))
   + 
    (sampleJ_2 * 0.2)
  ) + (sampleK_1 * 0.2)) / 6.1001);
  _glesFragData[0] = tmpvar_23;
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
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BlurredTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 blur_1;
  highp vec4 orig_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  orig_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_BlurredTex, xlv_TEXCOORD0);
  blur_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (orig_2, blur_1, blur_1.wwww);
  gl_FragData[0] = tmpvar_5;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BlurredTex;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 blur_1;
  highp vec4 orig_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  orig_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_BlurredTex, xlv_TEXCOORD0);
  blur_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (orig_2, blur_1, blur_1.wwww);
  _glesFragData[0] = tmpvar_5;
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
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _BlurredTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _DofStart;
uniform highp float _DofEnd;
uniform highp float _DofLerpIntensity;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 blur_1;
  highp vec4 orig_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  orig_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_BlurredTex, xlv_TEXCOORD0);
  blur_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (orig_2, blur_1, vec4((clamp (
    (((1.0/((
      (_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x)
     + _ZBufferParams.y))) - _DofStart) / (_DofEnd - _DofStart))
  , 0.0, 1.0) * _DofLerpIntensity)));
  gl_FragData[0] = tmpvar_5;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _BlurredTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _DofStart;
uniform highp float _DofEnd;
uniform highp float _DofLerpIntensity;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 blur_1;
  highp vec4 orig_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  orig_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_BlurredTex, xlv_TEXCOORD0);
  blur_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (orig_2, blur_1, vec4((clamp (
    (((1.0/((
      (_ZBufferParams.x * texture (_CameraDepthTexture, xlv_TEXCOORD0).x)
     + _ZBufferParams.y))) - _DofStart) / (_DofEnd - _DofStart))
  , 0.0, 1.0) * _DofLerpIntensity)));
  _glesFragData[0] = tmpvar_5;
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
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  mediump float tmpvar_4;
  tmpvar_4 = tmpvar_1.x;
  tmpvar_3.x = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = tmpvar_1.y;
  tmpvar_3.y = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BlurredTex;
uniform sampler2D _MaskTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 mask_1;
  highp vec4 blur_2;
  highp vec4 orig_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  orig_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_BlurredTex, xlv_TEXCOORD1);
  blur_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (orig_3, blur_2, vec4((1.0 - mask_1.x)));
  gl_FragData[0] = tmpvar_7;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  mediump float tmpvar_4;
  tmpvar_4 = tmpvar_1.x;
  tmpvar_3.x = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = tmpvar_1.y;
  tmpvar_3.y = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BlurredTex;
uniform sampler2D _MaskTex;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 mask_1;
  highp vec4 blur_2;
  highp vec4 orig_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  orig_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_BlurredTex, xlv_TEXCOORD1);
  blur_2 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (orig_3, blur_2, vec4((1.0 - mask_1.x)));
  _glesFragData[0] = tmpvar_7;
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