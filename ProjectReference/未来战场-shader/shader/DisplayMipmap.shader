Shader "VX/Debug/Display Mipmap" {
Properties {
 _MainTex ("Diffuse Texture", 2D) = "white" {}
 _ShowTexture ("Show Texture", Range(0,1)) = 0
 _MipMapLvl_00 ("MipMapLvl 00", Color) = (1,0,0,1)
 _MipMapLvl_01 ("MipMapLvl 01", Color) = (0,1,0,1)
 _MipMapLvl_02 ("MipMapLvl 02", Color) = (0,0,1,1)
 _MipMapLvl_03 ("MipMapLvl 03", Color) = (1,0,0.72,1)
 _MipMapLvl_04 ("MipMapLvl 04", Color) = (1,1,0,1)
 _MipMapLvl_05 ("MipMapLvl 05", Color) = (1,0.64,0,1)
 _MipMapLvl_06 ("MipMapLvl 06", Color) = (0,0.75,1,1)
 _MipMapLvl_07 ("MipMapLvl 07", Color) = (0.5,0.5,0.5,1)
 _MipMapLvl_08 ("MipMapLvl 08", Color) = (0.75,0,0.75,1)
 _MipMapLvl_09 ("MipMapLvl 09", Color) = (0.35,0.45,0.85,1)
 _MipMapLvl_10 ("MipMapLvl 10", Color) = (0.8,0.2,1,1)
 _MipMapLvl_11 ("MipMapLvl 11", Color) = (0,0,0,1)
}
SubShader { 
 LOD 200
 Tags { "LIGHTMODE"="ForwardBase" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" }
Program "vp" {
}
Program "fp" {
}
 }
}
Fallback Off
}