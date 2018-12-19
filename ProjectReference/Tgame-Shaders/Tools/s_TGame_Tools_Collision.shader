

Shader "TGame/Tools/CollisionDisplay" 
{
	Properties 
	{
		_Color ("Color", Color) = (0,1.0,0,1.0)

	}

	SubShader 
	{
	    Tags { "RenderType" = "Opaque" }
	    //LOD 200

	    //Lighting Off
		CGPROGRAM

		// 使用 Unlit, 受到动态灯光的影响很糟糕
		//#pragma surface surf Unlit nolightmap 

		#pragma surface surf Unlit nolightmap 
		#pragma target 2.0
		#include "UnityCG.cginc"

		fixed4 _Color;
		//sampler2D _MainTex;

	 	//fixed _DiffMulti;
		//fixed _VertexColorMulti;

	 	
	    inline fixed4 LightingUnlit (SurfaceOutput s, fixed3 lightDir, fixed atten)  
        {  
            fixed4 c = fixed4(1,1,1,1);  
            c.rgb 	= s.Albedo;  
            c.a 	= s.Alpha;  
            return c;  
        }   
            

		struct Input 
		{
			//fixed2 uv_MainTex;
			fixed4 color : Color;

		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color;
			o.Alpha = 1.0;
		}

		ENDCG
	}
	Fallback "Diffuse"
}