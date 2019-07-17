Shader "Tomcat/Effect/OutlineShadow" {
  Properties {
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest", Float) = 0

    _OutlineColor("Outline Color", Color) = (1, 1, 1, 0)
    _OutlineWidth("Outline Width", Range(0, 10)) = 2
    _OutLightPow("Falloff",Float) = 5 //光晕平方参数
    _OutLightStrength("Transparency", Float) = 15 //光晕强度
  }

  SubShader {
    Tags {
      "Queue" = "Transparent+110"
      "RenderType" = "Transparent"
      "DisableBatching" = "True"
    }

    Pass {
      Name "Fill"
      Cull Back
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
        //UNITY_VERTEX_INPUT_INSTANCE_ID
      };

      struct v2f {
        float4 position : SV_POSITION;
        fixed4 color : COLOR;
        float3 normal:TEXCOORD0;
        float3 worldvertpos:TEXCOORD1;
        UNITY_VERTEX_OUTPUT_STEREO
      };

      uniform fixed4 _OutlineColor;
      uniform float _OutlineWidth;
      uniform float _OutLightPow;
      uniform float _OutLightStrength;

      v2f vert(appdata input) {
        v2f output;

        //UNITY_SETUP_INSTANCE_ID(input);
        //UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

        float3 normal = any(input.smoothNormal) ? input.smoothNormal : input.normal;
        //float3 viewPosition = UnityObjectToViewPos(input.vertex);
        float3 viewNormal = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, normal));

        //output.position = UnityViewToClipPos(viewPosition + viewNormal * -viewPosition.z * _OutlineWidth / 1000.0);
        //output.position = UnityViewToClipPos(viewPosition - viewNormal * viewPosition.y * _OutlineWidth / 1000.0);
        //output.position = UnityViewToClipPos(viewPosition + viewNormal * _OutlineWidth / 1000.0);

         float4 offset = (0, 0, 0, 1);

        //input.vertex += offset * _OutlineWidth / 1000.0;
        float4 worldPosition = mul(unity_ObjectToWorld,  input.vertex);
        worldPosition += offset * _OutlineWidth / 1000.0;
        float3 viewPosition = UnityWorldToViewPos(worldPosition);
        output.position = UnityViewToClipPos(viewPosition); //+ viewNormal * _OutlineWidth / 1000.0);

        output.color = _OutlineColor;
        output.normal = viewNormal;
        output.worldvertpos = mul(unity_ObjectToWorld, input.vertex);

        return output;
      }

      fixed4 frag(v2f input) : SV_Target {
        float3 viewdir = normalize(input.worldvertpos-_WorldSpaceCameraPos); 
        float4 output = input.color;
        output.a = pow(saturate(dot(viewdir, input.normal)), _OutLightPow);
        output.a *= _OutLightStrength*dot(viewdir, input.normal);
        return output;
      }
      ENDCG
    }
  }
}
