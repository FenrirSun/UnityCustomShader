
/*
	


*/
Shader "TGame/Post/ScreenWave"
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_WaveFactor ("WaveFactor", Vector) = (65, -5, 0.2, 1)
		_WaveExtendPos("WaveExtendPos", Float) = 0.1

		// 整体大小控制
		_Intensity ("Intensity",Range(0, 1)) = 1  

		//// 放一次 ，还是连续的播放
		//[MaterialToggle(_ONESHOT)] _OneShot("OneShot?", Float) = 1


	}

	SubShader 
	{
		Pass
		 {
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }
					
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest 
			#include "UnityCG.cginc"

			//#pragma multi_compile _ _ONESHOT


			sampler2D _MainTex;
			//uniform sampler2D _RampTex;
			float4 _WaveFactor;
			float _WaveExtendPos;

			float _Intensity;

			fixed4 frag (v2f_img i) : SV_Target
			{
				float2 center = float2(0.5, 0.5);
				float2 dv = i.uv - center;

				dv = dv * float2(_ScreenParams.x / _ScreenParams.y, 1 );
				float dis = sqrt(dv.x * dv.x + dv.y * dv.y);
				//WaveFactor include (scale speed attenaution swingStrength)
				float ind = sin( dis * _WaveFactor.x + _Time.y * _WaveFactor.y) * _WaveFactor.w * 0.01;

				//// 射一次 
				//#ifdef _ONESHOT

					ind = ind * clamp( _WaveFactor.z - abs( _WaveExtendPos - dis ), 0, 1 ) / _WaveFactor.z;
					//float ind = sin( dis * 65 + _Time.y * -5) * ( 0.8 - dis ) * 0.01;
					//ind = ind * clamp( _WaveFactor.z - abs( _Time - dis ), 0, 1 ) / _WaveFactor.z;

				//#endif


				float2 dv1 = normalize(dv);
				float2 offset = dv1 * ind;
				float2 dstuv = offset * _Intensity + i.uv;
				float4 output = tex2D( _MainTex, dstuv );
				return output;

			}
			ENDCG

		}
	}
	Fallback off

}