//
//  OutlineFill.shader
//  QuickOutline
//
//  Created by Chris Nolet on 2/21/18.
//  Copyright © 2018 Chris Nolet. All rights reserved.
//

Shader "Tomcat/Effect/OutlineFill" {
  Properties {
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", Float) = 0

    _OutlineColor("Outline Color", Color) = (1, 1, 1, 0)
    _OutlineWidth("Outline Width", Range(0, 10)) = 2

    _useSmoothNormal("UseSmoothNormal", Float) = 0
  }

  SubShader {
    Tags {
      "Queue" = "Transparent+110"
      "RenderType" = "Transparent"
      "DisableBatching" = "True"
    }

    Pass {
      Name "Fill"
      Cull Off
      ZTest [_ZTest]
      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask RGBA

      Stencil {
        Ref 1
        Comp NotEqual
      }

      CGPROGRAM
      #include "UnityCG.cginc"

      #pragma vertex vert
      #pragma fragment frag

      struct appdata {
        float4 vertex : POSITION;
        float3 normal : NORMAL;
        float3 smoothNormal : TEXCOORD3;
        UNITY_VERTEX_INPUT_INSTANCE_ID
      };

      struct v2f {
        float4 position : SV_POSITION;
        fixed4 color : COLOR;
        UNITY_VERTEX_OUTPUT_STEREO
      };

      uniform fixed4 _OutlineColor;
      uniform float _OutlineWidth;
      fixed _useSmoothNormal;

      v2f vert(appdata input) {
        v2f output;

        UNITY_SETUP_INSTANCE_ID(input);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

        //float3 normal = any(input.smoothNormal) ? input.smoothNormal : input.normal;
        float3 normal = _useSmoothNormal ? input.smoothNormal : input.normal;
        float3 viewPosition = UnityObjectToViewPos(input.vertex);
        float3 viewNormal = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, normal));

        //计算fov
        float t = unity_CameraProjection._m11;
        const float Rad2Deg = 180 / UNITY_PI;
        float fov = atan(1.0f / t ) * 2.0 * Rad2Deg;
        //以23的fov为基准
        float fovParam = fov / 23;

        output.position = UnityViewToClipPos(viewPosition + viewNormal * fovParam * -viewPosition.z * _OutlineWidth / 1000.0);
		    //output.position = UnityViewToClipPos(viewPosition - viewNormal * viewPosition.y * _OutlineWidth / 1000.0);
        //output.position = UnityViewToClipPos(viewPosition + viewNormal * _OutlineWidth / 1000.0);
        output.color = _OutlineColor;
        //output.color.a = clamp(1 - viewNormal * viewPosition.y, 0, 1);

        // if(_useSmoothNormal)
        // {
        //   output.color = float4(1,0,0,1);
        // }
        // else
        // {
        //   output.color = float4(0,1,0,1);
        // }
        return output;
      }

      fixed4 frag(v2f input) : SV_Target {
        return input.color;
      }
      ENDCG
    }
  }
}
