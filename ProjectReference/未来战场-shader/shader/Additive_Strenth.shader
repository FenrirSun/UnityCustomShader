Shader "VX/FX/Additive_Strenth" {
Properties {
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
 _AlphaColor ("Main Color", Color) = (1,1,1,1)
}
SubShader { 
 LOD 30
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha One
  SetTexture [_MainTex] { ConstantColor [_AlphaColor] combine texture, texture alpha * constant alpha }
 }
}
}