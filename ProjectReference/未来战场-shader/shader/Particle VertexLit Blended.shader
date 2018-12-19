Shader "VX/Particles/VertexLit Blended" {
Properties {
 _EmisColor ("Emissive Color", Color) = (0.2,0.2,0.2,0)
 _MainTex ("Particle Texture", 2D) = "white" {}
}
SubShader { 
 Tags { "LIGHTMODE"="Vertex" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "LIGHTMODE"="Vertex" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Lighting On
  Material {
   Emission [_EmisColor]
  }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMaterial AmbientAndDiffuse
  SetTexture [_MainTex] { combine primary * texture }
 }
}
}