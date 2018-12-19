Shader "VX/Character/CharacterSimple_Reflective_Outline" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "grey" {}
 _MatCap ("MatCap (RGB)", 2D) = "grey" {}
 _CombinedMap ("R(Alpha),G(Gloss),B(Reflection)", 2D) = "grey" {}
 _Cube ("Cube", CUBE) = "black" {}
 _ReflectionThreshold ("ReflectionThreshold", Range(0,1)) = 1
 _FlashColor ("Flash", Color) = (0.5,0.5,0.5,1)
 _Flash ("Flash", Range(0,1)) = 0
 _OutLineColor ("OutLine Color", Color) = (1,1,1,1)
 _Outline ("Outline width", Range(0.002,0.03)) = 0.005
}
SubShader { 
 Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "RenderType"="Opaque" "Reflection"="RenderReflectionOpaque" }
 UsePass "VX/FX/Outline/BASE"
 UsePass "VX/Character/CharacterSimple_Reflective/BASE"
}
Fallback "VertexLit"
}