// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'


/*
	TGameShader - Character - PlayCharacter


*/
Shader "TGame/Character/JellyfishAlphaBlendZWriteEmission" 
{  
    Properties {
		_TintColor ("Tint Color", Color) = (1,1,1,1)

        _ParticleTexture ("Particle Texture", 2D) = "white" {}
        _DistortTexture ("Distort Texture", 2D) = "white" {}

        _DistortMultiplier ("Distort Multiplier", Float ) = 0.2
        _Glow ("Glow", Float ) = 1

        _VSpeed ("VSpeed", Float ) = 0.2
        _USpeed ("USpeed", Float ) = 0

        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
	}
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		
		// Extra pass that renders to depth buffer only
		LOD 100
		Pass {
			ZWrite On
			ColorMask 0
		}
		
		Pass 
        {
            Name "FORWARD"
            Tags { "LightMode"="ForwardBase" }

            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #pragma multi_compile_fwdbase
            #pragma target 2.0

            sampler2D _ParticleTexture; 
            float4 _ParticleTexture_ST;
            float4 _TintColor;

            sampler2D _DistortTexture; 
            float4 _DistortTexture_ST;

            float _DistortMultiplier;
            float _Glow;
            float _VSpeed;
            float _USpeed;

            struct appdata 
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                float4 vertexColor : COLOR;

            };

            struct v2f 
            {
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD0;
                float4 vertexColor : COLOR;

            };

            v2f vert (appdata v) 
            {
                v2f o = (v2f)0;
                o.uv.xy = v.texcoord;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;

            }

            float4 frag(v2f i) : COLOR 
            {

                float4 time = _Time;

                // 
                float2 uvAnim = (float2((_USpeed*time.g),(_VSpeed*time.g))+i.uv.xy);
                float2 distortUV = uvAnim * _DistortTexture_ST.xy + _DistortTexture_ST.zw;
                float4 distort = tex2D(_DistortTexture,distortUV);

                // 
                float2 uvAnimParticle = ((distort.r*_DistortMultiplier)+i.uv);     
                float2 partUV = uvAnimParticle * _ParticleTexture_ST.xy + _ParticleTexture_ST.zw;
                float4 particle = tex2D(_ParticleTexture,partUV);

                // 
                float3 emissive = (((2.0*distort.rgb)*particle.rgb)*(particle.rgb*i.vertexColor.rgb*(_TintColor.rgb*_Glow)));
                float3 finalColor = emissive;
                
                // Alpha
                //float alpha = particle.a*i.vertexColor.a*_TintColor.a;

                return fixed4(finalColor*i.vertexColor.a,1.0);
            }
            ENDCG
        }    
	} 
FallBack "Particles/Additive"  
}  