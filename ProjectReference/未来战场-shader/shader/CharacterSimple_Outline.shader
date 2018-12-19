Shader "VX/Character/CharacterSimple_Outline" {
Properties {
 _TintColor ("Tint Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "grey" {}
 _MatCap ("MatCap (RGB)", 2D) = "grey" {}
 _CombinedMap ("G(Gloss)", 2D) = "grey" {}
 _FlashColor ("Flash", Color) = (1,1,1,1)
 _Flash ("Flash", Range(0,1)) = 0
 _OutLineColor ("OutLine Color", Color) = (1,1,1,1)
 _Outline ("Outline width", Range(0.002,0.03)) = 0.005
}
SubShader { 
 UsePass "VX/FX/Outline/BASE"
 UsePass "VX/Character/CharacterSimple/BASE"
}
Fallback "VertexLit"
}