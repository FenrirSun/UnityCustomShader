Shader "VX/Character New/LobbyCubeMapAlphaTest" {
Properties {
 _Cutoff ("AlphaTest Cutoff", Range(0.01,1)) = 0.5
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Color Map (RGB)", 2D) = "white" {}
 _Alpha ("Alpha Mask", 2D) = "white" {}
 _BumpMap ("Normal Map", 2D) = "bump" {}
 _Cube ("Cubemap", CUBE) = "" { TexGen CubeReflect }
 _MaskMap ("R(Rim) G(Specular) B(CubeMap)", 2D) = "white" {}
 _RimColor ("Rim Color", Color) = (1,1,1,1)
 _EdgeIn ("Edge In Range", Range(0,1)) = 0.5
 _EdgeOut ("Edge Out Range", Range(1,2)) = 1.5
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater [_Cutoff]
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (textureCube (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (texture (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (textureCube (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (texture (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (textureCube (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (texture (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_25;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_18)
  )));
  nh_6 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    ((tmpvar_9.xyz * tmpvar_19) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * tmpvar_12) * 2.0);
  finalColor_8 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD5.w;
  tmpvar_22.y = xlv_TEXCOORD5_1.w;
  tmpvar_22.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_26.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_26.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_27;
  tmpvar_27 = (worldView_5 - (2.0 * (
    dot (tmpvar_26, worldView_5)
   * tmpvar_26)));
  worldView_5 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((
    (1.0 - dot (tmpvar_18, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = (_RimColor.xyz * (tmpvar_28 * (tmpvar_28 * 
    (3.0 - (2.0 * tmpvar_28))
  )));
  rim_1 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((finalColor_8 + (textureCube (_Cube, tmpvar_27).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = tmpvar_30;
  tmpvar_31.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_31;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_18)
  )));
  nh_6 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    ((tmpvar_9.xyz * tmpvar_19) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * tmpvar_12) * 2.0);
  finalColor_8 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD5.w;
  tmpvar_22.y = xlv_TEXCOORD5_1.w;
  tmpvar_22.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_26.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_26.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_27;
  tmpvar_27 = (worldView_5 - (2.0 * (
    dot (tmpvar_26, worldView_5)
   * tmpvar_26)));
  worldView_5 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((
    (1.0 - dot (tmpvar_18, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = (_RimColor.xyz * (tmpvar_28 * (tmpvar_28 * 
    (3.0 - (2.0 * tmpvar_28))
  )));
  rim_1 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((finalColor_8 + (textureCube (_Cube, tmpvar_27).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = tmpvar_30;
  tmpvar_31.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_31;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_18)
  )));
  nh_6 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    ((tmpvar_9.xyz * tmpvar_19) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * tmpvar_12) * 2.0);
  finalColor_8 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD5.w;
  tmpvar_22.y = xlv_TEXCOORD5_1.w;
  tmpvar_22.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_26.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_26.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_27;
  tmpvar_27 = (worldView_5 - (2.0 * (
    dot (tmpvar_26, worldView_5)
   * tmpvar_26)));
  worldView_5 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((
    (1.0 - dot (tmpvar_18, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = (_RimColor.xyz * (tmpvar_28 * (tmpvar_28 * 
    (3.0 - (2.0 * tmpvar_28))
  )));
  rim_1 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((finalColor_8 + (textureCube (_Cube, tmpvar_27).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = tmpvar_30;
  tmpvar_31.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_31;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (textureCube (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_25;
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
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
out highp vec2 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec3 v_18;
  v_18.x = tmpvar_14.x;
  v_18.y = tmpvar_15.x;
  v_18.z = tmpvar_16.x;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = (tmpvar_10 * v_18);
  tmpvar_19.w = tmpvar_17.x;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_19 * unity_Scale.w);
  tmpvar_5 = tmpvar_20;
  highp vec3 v_21;
  v_21.x = tmpvar_14.y;
  v_21.y = tmpvar_15.y;
  v_21.z = tmpvar_16.y;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = (tmpvar_10 * v_21);
  tmpvar_22.w = tmpvar_17.y;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * unity_Scale.w);
  tmpvar_6 = tmpvar_23;
  highp vec3 v_24;
  v_24.x = tmpvar_14.z;
  v_24.y = tmpvar_15.z;
  v_24.z = tmpvar_16.z;
  highp vec4 tmpvar_25;
  tmpvar_25.xyz = (tmpvar_10 * v_24);
  tmpvar_25.w = tmpvar_17.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * unity_Scale.w);
  tmpvar_7 = tmpvar_26;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_12)
  )));
  nh_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (((
    (tmpvar_9.xyz * tmpvar_13)
   + 
    ((_SpecColor.xyz * pow (nh_6, (_Shininess * 128.0))) * tmpvar_11.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_8 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD5.w;
  tmpvar_16.y = xlv_TEXCOORD5_1.w;
  tmpvar_16.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_19;
  mediump vec3 tmpvar_20;
  tmpvar_20.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_20.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_20.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_21;
  tmpvar_21 = (worldView_5 - (2.0 * (
    dot (tmpvar_20, worldView_5)
   * tmpvar_20)));
  worldView_5 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - dot (tmpvar_12, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (_RimColor.xyz * (tmpvar_22 * (tmpvar_22 * 
    (3.0 - (2.0 * tmpvar_22))
  )));
  rim_1 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((finalColor_8 + (texture (_Cube, tmpvar_21).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_25;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_18)
  )));
  nh_6 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (((
    ((tmpvar_9.xyz * tmpvar_19) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * tmpvar_12) * 2.0);
  finalColor_8 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD5.w;
  tmpvar_22.y = xlv_TEXCOORD5_1.w;
  tmpvar_22.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_25;
  mediump vec3 tmpvar_26;
  tmpvar_26.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_26.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_26.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_27;
  tmpvar_27 = (worldView_5 - (2.0 * (
    dot (tmpvar_26, worldView_5)
   * tmpvar_26)));
  worldView_5 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((
    (1.0 - dot (tmpvar_18, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_29;
  tmpvar_29 = (_RimColor.xyz * (tmpvar_28 * (tmpvar_28 * 
    (3.0 - (2.0 * tmpvar_28))
  )));
  rim_1 = tmpvar_29;
  lowp vec3 tmpvar_30;
  tmpvar_30 = ((finalColor_8 + (textureCube (_Cube, tmpvar_27).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = tmpvar_30;
  tmpvar_31.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_31;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_15)
  )));
  nh_6 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_9.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD5.w;
  tmpvar_19.y = xlv_TEXCOORD5_1.w;
  tmpvar_19.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_23.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_23.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_24;
  tmpvar_24 = (worldView_5 - (2.0 * (
    dot (tmpvar_23, worldView_5)
   * tmpvar_23)));
  worldView_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (_RimColor.xyz * (tmpvar_25 * (tmpvar_25 * 
    (3.0 - (2.0 * tmpvar_25))
  )));
  rim_1 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((finalColor_8 + (textureCube (_Cube, tmpvar_24).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = tmpvar_27;
  tmpvar_28.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_28;
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
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_16)
  )));
  nh_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_9.xyz * tmpvar_17) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD5.w;
  tmpvar_20.y = xlv_TEXCOORD5_1.w;
  tmpvar_20.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_24.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_24.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_25;
  tmpvar_25 = (worldView_5 - (2.0 * (
    dot (tmpvar_24, worldView_5)
   * tmpvar_24)));
  worldView_5 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((
    (1.0 - dot (tmpvar_16, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = (_RimColor.xyz * (tmpvar_26 * (tmpvar_26 * 
    (3.0 - (2.0 * tmpvar_26))
  )));
  rim_1 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((finalColor_8 + (texture (_Cube, tmpvar_25).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_29;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_15)
  )));
  nh_6 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_9.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD5.w;
  tmpvar_19.y = xlv_TEXCOORD5_1.w;
  tmpvar_19.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_23.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_23.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_24;
  tmpvar_24 = (worldView_5 - (2.0 * (
    dot (tmpvar_23, worldView_5)
   * tmpvar_23)));
  worldView_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (_RimColor.xyz * (tmpvar_25 * (tmpvar_25 * 
    (3.0 - (2.0 * tmpvar_25))
  )));
  rim_1 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((finalColor_8 + (textureCube (_Cube, tmpvar_24).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = tmpvar_27;
  tmpvar_28.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_28;
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
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_16)
  )));
  nh_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_9.xyz * tmpvar_17) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD5.w;
  tmpvar_20.y = xlv_TEXCOORD5_1.w;
  tmpvar_20.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_24.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_24.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_25;
  tmpvar_25 = (worldView_5 - (2.0 * (
    dot (tmpvar_24, worldView_5)
   * tmpvar_24)));
  worldView_5 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((
    (1.0 - dot (tmpvar_16, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = (_RimColor.xyz * (tmpvar_26 * (tmpvar_26 * 
    (3.0 - (2.0 * tmpvar_26))
  )));
  rim_1 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((finalColor_8 + (texture (_Cube, tmpvar_25).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_29;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_15)
  )));
  nh_6 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_9.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD5.w;
  tmpvar_19.y = xlv_TEXCOORD5_1.w;
  tmpvar_19.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_23.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_23.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_24;
  tmpvar_24 = (worldView_5 - (2.0 * (
    dot (tmpvar_23, worldView_5)
   * tmpvar_23)));
  worldView_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (_RimColor.xyz * (tmpvar_25 * (tmpvar_25 * 
    (3.0 - (2.0 * tmpvar_25))
  )));
  rim_1 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((finalColor_8 + (textureCube (_Cube, tmpvar_24).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = tmpvar_27;
  tmpvar_28.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_28;
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
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_16)
  )));
  nh_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_9.xyz * tmpvar_17) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD5.w;
  tmpvar_20.y = xlv_TEXCOORD5_1.w;
  tmpvar_20.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_24.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_24.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_25;
  tmpvar_25 = (worldView_5 - (2.0 * (
    dot (tmpvar_24, worldView_5)
   * tmpvar_24)));
  worldView_5 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((
    (1.0 - dot (tmpvar_16, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = (_RimColor.xyz * (tmpvar_26 * (tmpvar_26 * 
    (3.0 - (2.0 * tmpvar_26))
  )));
  rim_1 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((finalColor_8 + (texture (_Cube, tmpvar_25).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_29;
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
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_TEXCOORD5;
varying lowp vec4 xlv_TEXCOORD5_1;
varying lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_15)
  )));
  nh_6 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (((
    ((tmpvar_9.xyz * tmpvar_16) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD5.w;
  tmpvar_19.y = xlv_TEXCOORD5_1.w;
  tmpvar_19.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_23.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_23.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_24;
  tmpvar_24 = (worldView_5 - (2.0 * (
    dot (tmpvar_23, worldView_5)
   * tmpvar_23)));
  worldView_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((
    (1.0 - dot (tmpvar_15, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (_RimColor.xyz * (tmpvar_25 * (tmpvar_25 * 
    (3.0 - (2.0 * tmpvar_25))
  )));
  rim_1 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((finalColor_8 + (textureCube (_Cube, tmpvar_24).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = tmpvar_27;
  tmpvar_28.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_28;
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
out lowp vec4 xlv_TEXCOORD5;
out lowp vec4 xlv_TEXCOORD5_1;
out lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_2.w = _glesTANGENT.w;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_3 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_10 * ((
    (_World2Object * tmpvar_12)
  .xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_13;
  highp vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_14 = _Object2World[0].xyz;
  tmpvar_15 = _Object2World[1].xyz;
  tmpvar_16 = _Object2World[2].xyz;
  highp vec3 tmpvar_17;
  highp vec4 cse_18;
  cse_18 = (_Object2World * _glesVertex);
  tmpvar_17 = (cse_18.xyz - _WorldSpaceCameraPos);
  highp vec3 v_19;
  v_19.x = tmpvar_14.x;
  v_19.y = tmpvar_15.x;
  v_19.z = tmpvar_16.x;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = (tmpvar_10 * v_19);
  tmpvar_20.w = tmpvar_17.x;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_20 * unity_Scale.w);
  tmpvar_5 = tmpvar_21;
  highp vec3 v_22;
  v_22.x = tmpvar_14.y;
  v_22.y = tmpvar_15.y;
  v_22.z = tmpvar_16.y;
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = (tmpvar_10 * v_22);
  tmpvar_23.w = tmpvar_17.y;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * unity_Scale.w);
  tmpvar_6 = tmpvar_24;
  highp vec3 v_25;
  v_25.x = tmpvar_14.z;
  v_25.y = tmpvar_15.z;
  v_25.z = tmpvar_16.z;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = (tmpvar_10 * v_25);
  tmpvar_26.w = tmpvar_17.z;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * unity_Scale.w);
  tmpvar_7 = tmpvar_27;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_18);
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD5_1 = tmpvar_6;
  xlv_TEXCOORD5_2 = tmpvar_7;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Alpha;
uniform sampler2D _BumpMap;
uniform sampler2D _MaskMap;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
uniform highp float _Shininess;
uniform lowp vec4 _RimColor;
uniform mediump float _EdgeIn;
uniform mediump float _EdgeOut;
in highp vec2 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in lowp vec4 xlv_TEXCOORD5;
in lowp vec4 xlv_TEXCOORD5_1;
in lowp vec4 xlv_TEXCOORD5_2;
void main ()
{
  lowp vec3 rim_1;
  mediump vec3 Tangent2World2_2;
  mediump vec3 Tangent2World1_3;
  mediump vec3 Tangent2World0_4;
  highp vec3 worldView_5;
  highp float nh_6;
  lowp vec3 lightDir_7;
  lowp vec3 finalColor_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MaskMap, xlv_TEXCOORD0);
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lightDir_7 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD2);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_10, lightDir_7));
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_10, normalize(
    (lightDir_7 + tmpvar_16)
  )));
  nh_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((
    ((tmpvar_9.xyz * tmpvar_17) + ((_SpecColor.xyz * pow (nh_6, 
      (_Shininess * 128.0)
    )) * tmpvar_11.y))
   * _LightColor0.xyz) * shadow_12) * 2.0);
  finalColor_8 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD5.w;
  tmpvar_20.y = xlv_TEXCOORD5_1.w;
  tmpvar_20.z = xlv_TEXCOORD5_2.w;
  worldView_5 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD5.xyz;
  Tangent2World0_4 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = xlv_TEXCOORD5_1.xyz;
  Tangent2World1_3 = tmpvar_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = xlv_TEXCOORD5_2.xyz;
  Tangent2World2_2 = tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24.x = dot (Tangent2World0_4, tmpvar_10);
  tmpvar_24.y = dot (Tangent2World1_3, tmpvar_10);
  tmpvar_24.z = dot (Tangent2World2_2, tmpvar_10);
  highp vec3 tmpvar_25;
  tmpvar_25 = (worldView_5 - (2.0 * (
    dot (tmpvar_24, worldView_5)
   * tmpvar_24)));
  worldView_5 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((
    (1.0 - dot (tmpvar_16, tmpvar_10))
   - _EdgeIn) / (_EdgeOut - _EdgeIn)), 0.0, 1.0);
  mediump vec3 tmpvar_27;
  tmpvar_27 = (_RimColor.xyz * (tmpvar_26 * (tmpvar_26 * 
    (3.0 - (2.0 * tmpvar_26))
  )));
  rim_1 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((finalColor_8 + (texture (_Cube, tmpvar_25).xyz * tmpvar_11.z)) + (rim_1 * tmpvar_11.x));
  finalColor_8 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_29;
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
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Cull Off
  Fog { Mode Off }
  Blend One One
  AlphaTest Greater [_Cutoff]
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
uniform sampler2D _Alpha;
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
  tmpvar_10 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_4.xyz * tmpvar_10) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_6.y))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = finalColor_3;
  tmpvar_13.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_13;
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
uniform sampler2D _Alpha;
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
  tmpvar_10 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_4.xyz * tmpvar_10) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_6.y))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = finalColor_3;
  tmpvar_13.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_13;
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
uniform sampler2D _Alpha;
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
  tmpvar_7 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (((
    (tmpvar_4.xyz * tmpvar_7)
   + 
    ((_SpecColor.xyz * pow (nh_1, (_Shininess * 128.0))) * tmpvar_6.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = finalColor_3;
  tmpvar_10.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_10;
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
uniform sampler2D _Alpha;
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
  tmpvar_7 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_8;
  tmpvar_8 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (((
    (tmpvar_4.xyz * tmpvar_7)
   + 
    ((_SpecColor.xyz * pow (nh_1, (_Shininess * 128.0))) * tmpvar_6.y)
  ) * _LightColor0.xyz) * 2.0);
  finalColor_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = finalColor_3;
  tmpvar_10.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_10;
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
uniform sampler2D _Alpha;
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
  tmpvar_14 = max (0.0, dot (tmpvar_6, lightDir_2));
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_5.xyz * tmpvar_14) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_7.y))
   * _LightColor0.xyz) * attenuation_4) * 2.0);
  finalColor_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_3;
  tmpvar_17.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_17;
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
uniform sampler2D _Alpha;
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
  tmpvar_14 = max (0.0, dot (tmpvar_6, lightDir_2));
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_6, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    ((tmpvar_5.xyz * tmpvar_14) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_7.y))
   * _LightColor0.xyz) * attenuation_4) * 2.0);
  finalColor_3 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = finalColor_3;
  tmpvar_17.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_17;
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
uniform sampler2D _Alpha;
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
  tmpvar_10 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_4.xyz * tmpvar_10) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_6.y))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = finalColor_3;
  tmpvar_13.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_13;
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
uniform sampler2D _Alpha;
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
  tmpvar_10 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((
    ((tmpvar_4.xyz * tmpvar_10) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_6.y))
   * _LightColor0.xyz) * tmpvar_8) * 2.0);
  finalColor_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = finalColor_3;
  tmpvar_13.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_13;
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
uniform sampler2D _Alpha;
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
  tmpvar_8 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (((
    ((tmpvar_4.xyz * tmpvar_8) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_6.y))
   * _LightColor0.xyz) * tmpvar_7) * 2.0);
  finalColor_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = finalColor_3;
  tmpvar_11.w = texture2D (_Alpha, xlv_TEXCOORD0).x;
  gl_FragData[0] = tmpvar_11;
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
uniform sampler2D _Alpha;
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
  tmpvar_8 = max (0.0, dot (tmpvar_5, lightDir_2));
  mediump float tmpvar_9;
  tmpvar_9 = max (0.0, dot (tmpvar_5, normalize(
    (lightDir_2 + normalize(xlv_TEXCOORD2))
  )));
  nh_1 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (((
    ((tmpvar_4.xyz * tmpvar_8) + ((_SpecColor.xyz * pow (nh_1, 
      (_Shininess * 128.0)
    )) * tmpvar_6.y))
   * _LightColor0.xyz) * tmpvar_7) * 2.0);
  finalColor_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = finalColor_3;
  tmpvar_11.w = texture (_Alpha, xlv_TEXCOORD0).x;
  _glesFragData[0] = tmpvar_11;
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
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Cull Off
  Fog { Mode Off }
  Offset 1, 1
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xyw = tmpvar_2.xyw;
  tmpvar_1.z = (tmpvar_2.z + unity_LightShadowBias.x);
  tmpvar_1.z = mix (tmpvar_1.z, max (tmpvar_1.z, -(tmpvar_2.w)), unity_LightShadowBias.y);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD1 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp float x_1;
  x_1 = (texture2D (_Alpha, xlv_TEXCOORD1).x - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_1.xyw = tmpvar_2.xyw;
  tmpvar_1.z = (tmpvar_2.z + unity_LightShadowBias.x);
  tmpvar_1.z = mix (tmpvar_1.z, max (tmpvar_1.z, -(tmpvar_2.w)), unity_LightShadowBias.y);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD1 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp float x_1;
  x_1 = (texture (_Alpha, xlv_TEXCOORD1).x - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  _glesFragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD1 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightPositionRange;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp float x_1;
  x_1 = (texture2D (_Alpha, xlv_TEXCOORD1).x - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_2;
  tmpvar_2 = fract((vec4(1.0, 255.0, 65025.0, 1.65814e+07) * min (
    (sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) * _LightPositionRange.w)
  , 0.999)));
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - (tmpvar_2.yzww * 0.00392157));
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD1 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightPositionRange;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp float x_1;
  x_1 = (texture (_Alpha, xlv_TEXCOORD1).x - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_2;
  tmpvar_2 = fract((vec4(1.0, 255.0, 65025.0, 1.65814e+07) * min (
    (sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) * _LightPositionRange.w)
  , 0.999)));
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_2 - (tmpvar_2.yzww * 0.00392157));
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
"!!GLES3"
}
}
 }
 Pass {
  Name "SHADOWCOLLECTOR"
  Tags { "LIGHTMODE"="SHADOWCOLLECTOR" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ProjectionParams;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 zFar_3;
  highp vec4 zNear_4;
  lowp float x_5;
  x_5 = (texture2D (_Alpha, xlv_TEXCOORD5).x - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  bvec4 tmpvar_6;
  tmpvar_6 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(tmpvar_6);
  zNear_4 = tmpvar_7;
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = vec4(tmpvar_8);
  zFar_3 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (zNear_4 * zFar_3);
  highp float tmpvar_11;
  tmpvar_11 = clamp (((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    (xlv_TEXCOORD0 * tmpvar_10.x)
   + 
    (xlv_TEXCOORD1 * tmpvar_10.y)
  ) + (xlv_TEXCOORD2 * tmpvar_10.z)) + (xlv_TEXCOORD3 * tmpvar_10.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  highp float tmpvar_14;
  if ((tmpvar_13.x < tmpvar_12.z)) {
    tmpvar_14 = _LightShadowData.x;
  } else {
    tmpvar_14 = 1.0;
  };
  res_2.x = clamp ((tmpvar_14 + tmpvar_11), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_15.y = tmpvar_16.y;
  enc_15.x = (tmpvar_16.x - (tmpvar_16.y * 0.00392157));
  res_2.zw = enc_15;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 zFar_4;
  highp vec4 zNear_5;
  lowp float x_6;
  x_6 = (texture2D (_Alpha, xlv_TEXCOORD5).x - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(tmpvar_7);
  zNear_5 = tmpvar_8;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_10;
  tmpvar_10 = vec4(tmpvar_9);
  zFar_4 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (zNear_5 * zFar_4);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    (xlv_TEXCOORD0 * tmpvar_11.x)
   + 
    (xlv_TEXCOORD1 * tmpvar_11.y)
  ) + (xlv_TEXCOORD2 * tmpvar_11.z)) + (xlv_TEXCOORD3 * tmpvar_11.w));
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, tmpvar_12.xyz);
  mediump float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_15;
  res_2.x = clamp ((shadow_3 + clamp (
    ((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_16.y = tmpvar_17.y;
  enc_16.x = (tmpvar_17.x - (tmpvar_17.y * 0.00392157));
  res_2.zw = enc_16;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 zFar_4;
  highp vec4 zNear_5;
  lowp float x_6;
  x_6 = (texture (_Alpha, xlv_TEXCOORD5).x - _Cutoff);
  if ((x_6 < 0.0)) {
    discard;
  };
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(tmpvar_7);
  zNear_5 = tmpvar_8;
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_10;
  tmpvar_10 = vec4(tmpvar_9);
  zFar_4 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (zNear_5 * zFar_4);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    (xlv_TEXCOORD0 * tmpvar_11.x)
   + 
    (xlv_TEXCOORD1 * tmpvar_11.y)
  ) + (xlv_TEXCOORD2 * tmpvar_11.z)) + (xlv_TEXCOORD3 * tmpvar_11.w));
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, tmpvar_12.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_14;
  res_2.x = clamp ((shadow_3 + clamp (
    ((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_15;
  highp vec2 tmpvar_16;
  tmpvar_16 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_15.y = tmpvar_16.y;
  enc_15.x = (tmpvar_16.x - (tmpvar_16.y * 0.00392157));
  res_2.zw = enc_15;
  tmpvar_1 = res_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 cascadeWeights_3;
  lowp float x_4;
  x_4 = (texture2D (_Alpha, xlv_TEXCOORD5).x - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_5, tmpvar_5);
  tmpvar_9.y = dot (tmpvar_6, tmpvar_6);
  tmpvar_9.z = dot (tmpvar_7, tmpvar_7);
  tmpvar_9.w = dot (tmpvar_8, tmpvar_8);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (tmpvar_9, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_11;
  tmpvar_11 = vec4(tmpvar_10);
  cascadeWeights_3 = tmpvar_11;
  cascadeWeights_3.yzw = clamp ((cascadeWeights_3.yzw - cascadeWeights_3.xyz), 0.0, 1.0);
  highp vec3 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    sqrt(dot (tmpvar_12, tmpvar_12))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    (xlv_TEXCOORD0 * cascadeWeights_3.x)
   + 
    (xlv_TEXCOORD1 * cascadeWeights_3.y)
  ) + (xlv_TEXCOORD2 * cascadeWeights_3.z)) + (xlv_TEXCOORD3 * cascadeWeights_3.w));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
  highp float tmpvar_16;
  if ((tmpvar_15.x < tmpvar_14.z)) {
    tmpvar_16 = _LightShadowData.x;
  } else {
    tmpvar_16 = 1.0;
  };
  res_2.x = clamp ((tmpvar_16 + tmpvar_13), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_17.y = tmpvar_18.y;
  enc_17.x = (tmpvar_18.x - (tmpvar_18.y * 0.00392157));
  res_2.zw = enc_17;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 cascadeWeights_4;
  lowp float x_5;
  x_5 = (texture2D (_Alpha, xlv_TEXCOORD5).x - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_6, tmpvar_6);
  tmpvar_10.y = dot (tmpvar_7, tmpvar_7);
  tmpvar_10.z = dot (tmpvar_8, tmpvar_8);
  tmpvar_10.w = dot (tmpvar_9, tmpvar_9);
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (tmpvar_10, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(tmpvar_11);
  cascadeWeights_4 = tmpvar_12;
  cascadeWeights_4.yzw = clamp ((cascadeWeights_4.yzw - cascadeWeights_4.xyz), 0.0, 1.0);
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    (xlv_TEXCOORD0 * cascadeWeights_4.x)
   + 
    (xlv_TEXCOORD1 * cascadeWeights_4.y)
  ) + (xlv_TEXCOORD2 * cascadeWeights_4.z)) + (xlv_TEXCOORD3 * cascadeWeights_4.w));
  lowp float tmpvar_15;
  tmpvar_15 = shadow2DEXT (_ShadowMapTexture, tmpvar_14.xyz);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15;
  highp float tmpvar_17;
  tmpvar_17 = (_LightShadowData.x + (tmpvar_16 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_17;
  res_2.x = clamp ((shadow_3 + clamp (
    ((sqrt(dot (tmpvar_13, tmpvar_13)) * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_18;
  highp vec2 tmpvar_19;
  tmpvar_19 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_18.y = tmpvar_19.y;
  enc_18.x = (tmpvar_19.x - (tmpvar_19.y * 0.00392157));
  res_2.zw = enc_18;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec2 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _Alpha;
uniform lowp float _Cutoff;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec2 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 cascadeWeights_4;
  lowp float x_5;
  x_5 = (texture (_Alpha, xlv_TEXCOORD5).x - _Cutoff);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_6, tmpvar_6);
  tmpvar_10.y = dot (tmpvar_7, tmpvar_7);
  tmpvar_10.z = dot (tmpvar_8, tmpvar_8);
  tmpvar_10.w = dot (tmpvar_9, tmpvar_9);
  bvec4 tmpvar_11;
  tmpvar_11 = lessThan (tmpvar_10, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(tmpvar_11);
  cascadeWeights_4 = tmpvar_12;
  cascadeWeights_4.yzw = clamp ((cascadeWeights_4.yzw - cascadeWeights_4.xyz), 0.0, 1.0);
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    (xlv_TEXCOORD0 * cascadeWeights_4.x)
   + 
    (xlv_TEXCOORD1 * cascadeWeights_4.y)
  ) + (xlv_TEXCOORD2 * cascadeWeights_4.z)) + (xlv_TEXCOORD3 * cascadeWeights_4.w));
  mediump float tmpvar_15;
  tmpvar_15 = texture (_ShadowMapTexture, tmpvar_14.xyz);
  highp float tmpvar_16;
  tmpvar_16 = (_LightShadowData.x + (tmpvar_15 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_16;
  res_2.x = clamp ((shadow_3 + clamp (
    ((sqrt(dot (tmpvar_13, tmpvar_13)) * _LightShadowData.z) + _LightShadowData.w)
  , 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = fract((vec2(1.0, 255.0) * (1.0 - 
    (xlv_TEXCOORD4.w * _ProjectionParams.w)
  )));
  enc_17.y = tmpvar_18.y;
  enc_17.x = (tmpvar_18.x - (tmpvar_18.y * 0.00392157));
  res_2.zw = enc_17;
  tmpvar_1 = res_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES3"
}
}
 }
}
Fallback Off
}