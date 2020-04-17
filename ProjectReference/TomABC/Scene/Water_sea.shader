// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Tomcat/Scene/Water_ls"
{
	Properties
	{
		_WaterNormal01("Water Normal01", 2D) = "bump" {}
		_WaterNormal02("Water Normal02", 2D) = "bump" {}
		_DistortTexture("Distort Texture", 2D) = "bump" {}
		_NormalTex("NormalTex", Range( 10 , 50)) = 2
		_NormalScale("NormalScale", Range( 0 , 10)) = 0
		_UVDistortIntensity("UV Distort Intensity", Range( 0 , 1)) = 0
		_W_Start_F("W_Start_F", Range( -5 , 5)) = 0
		_W_Range_F("W_Range_F", Range( 0 , 0.5)) = 0
		_W_Color_F("W_Color_F", Color) = (0,0,0,0)
		_W_Color_N("W_Color_N", Color) = (0,0,0,0)
		_W_Emission("W_Emission", Float) = 0.4
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma exclude_renderers vulkan xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf StandardSpecular alpha:fade keepalpha exclude_path:deferred nolightmap  
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform float _NormalScale;
		uniform sampler2D _WaterNormal02;
		uniform half _NormalTex;
		uniform float _UVDistortIntensity;
		uniform sampler2D _DistortTexture;
		uniform half4 _DistortTexture_ST;
		uniform sampler2D _WaterNormal01;
		uniform half4 _W_Color_N;
		uniform half4 _W_Color_F;
		uniform half _W_Start_F;
		uniform half _W_Range_F;
		uniform half _W_Emission;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			half2 temp_cast_0 = (_NormalTex).xx;
			float2 uv_TexCoord40 = i.uv_texcoord * temp_cast_0;
			half2 panner42 = ( 1.0 * _Time.y * float2( -0.05,0 ) + uv_TexCoord40);
			float2 uv_DistortTexture = i.uv_texcoord * _DistortTexture_ST.xy + _DistortTexture_ST.zw;
			half3 tex2DNode139 = UnpackScaleNormal( tex2D( _DistortTexture, uv_DistortTexture ), _UVDistortIntensity );
			half2 panner43 = ( 1.0 * _Time.y * float2( 0.06,0.06 ) + uv_TexCoord40);
			half3 W_Normals96 = BlendNormals( UnpackScaleNormal( tex2D( _WaterNormal02, ( half3( panner42 ,  0.0 ) + tex2DNode139 ).xy ), _NormalScale ) , UnpackScaleNormal( tex2D( _WaterNormal01, ( half3( panner43 ,  0.0 ) + tex2DNode139 ).xy ), _NormalScale ) );
			o.Normal = W_Normals96;
			float3 ase_worldPos = i.worldPos;
			half3 temp_cast_5 = (_W_Start_F).xxx;
			half temp_output_8_0 = length( ( ( ase_worldPos - _WorldSpaceCameraPos ) - temp_cast_5 ) );
			half FakeDetph30 = ( ( saturate( ( temp_output_8_0 * _W_Range_F ) ) * 1.0 ) + saturate( ( ( 0.0 - (ase_worldPos).y ) * 1.0 ) ) );
			half4 lerpResult24 = lerp( _W_Color_N , _W_Color_F , FakeDetph30);
			half4 W_color92 = lerpResult24;
			o.Albedo = W_color92.rgb;
			half3 temp_cast_7 = (_W_Emission).xxx;
			o.Emission = temp_cast_7;
			o.Alpha = FakeDetph30;
		}

		ENDCG
	}
	Fallback "Mobile/Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
1927;146;1906;853;1417.717;332.9601;2.882773;True;True
Node;AmplifyShaderEditor.CommentaryNode;32;-1063.495,-1214.635;Inherit;False;1828.086;739.7286;Comment;20;23;15;20;21;22;14;16;18;17;11;13;8;9;10;7;5;6;30;38;109;FakeDepth;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;6;-757.496,-1004.634;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;5;-1013.493,-1164.634;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;10;-360.4954,-929.6343;Inherit;False;Property;_W_Start_F;W_Start_F;7;0;Create;True;0;0;False;0;0;-0.25;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-357.4954,-1164.634;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-132.4951,-1163.634;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;17;-741.4962,-716.6343;Inherit;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;8;154.5049,-1164.634;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-339.2922,-644.0034;Inherit;False;Constant;_W_Start_H;W_Start_H;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;41.505,-940.6343;Inherit;False;Property;_W_Range_F;W_Range_F;8;0;Create;True;0;0;False;0;0;0.04;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;39;-631.2039,414.2282;Inherit;False;1420.803;735.5994;Blend panning normals to fake noving ripples;13;139;96;46;45;44;140;141;41;42;43;40;60;138;WaterWave;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;314.5048,-1164.634;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1.037919,-660.7634;Inherit;False;Constant;_W_Range_H;W_Range_H;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-351.5494,-788.7084;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-620.0082,543.5958;Inherit;False;Property;_NormalTex;NormalTex;4;0;Create;True;0;0;False;0;2;40;10;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;26.50502,-780.6343;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;14;505.1348,-1148.634;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;410.5047,-940.6343;Inherit;False;Constant;_W_Density;W_Density;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-599.0136,923.4915;Float;False;Property;_UVDistortIntensity;UV Distort Intensity;6;0;Create;True;0;0;False;0;0;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;40;-627.5452,700.1198;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;38;233.77,-777.0153;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;607.0184,-1022.494;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;43;-266.2044,915.7274;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.06,0.06;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;479.0718,-764.8334;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;42;-308.5044,464.2283;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.05,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;139;-365.7013,670.9893;Inherit;True;Property;_DistortTexture;Distort Texture;3;0;Create;True;0;0;False;0;-1;None;70685453a9e94d0459ae35896af520df;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;535.8747,-648.4883;Inherit;False;FakeDetph;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;141;-7.937134,780.0928;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-79.30444,669.9263;Float;False;Property;_NormalScale;NormalScale;5;0;Create;True;0;0;False;0;0;3;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;37;234.0475,-235.5801;Inherit;False;527.7568;537.5446;Comment;5;29;27;26;24;92;WaterColor;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-4.937073,511.1127;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;27;292.9999,-11.25439;Inherit;False;Property;_W_Color_F;W_Color_F;9;0;Create;True;0;0;False;0;0,0,0,0;0.1367925,0.5904782,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;26;283.0477,-185.58;Inherit;False;Property;_W_Color_N;W_Color_N;10;0;Create;True;0;0;False;0;0,0,0,0;0,0.6609422,0.9433962,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;44;138.3963,774.4276;Inherit;True;Property;_WaterNormal01;Water Normal01;0;0;Create;True;0;0;False;0;-1;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;45;128.4956,476.5273;Inherit;True;Property;_WaterNormal02;Water Normal02;1;0;Create;True;0;0;False;0;-1;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;29;302.028,186.9649;Inherit;False;30;FakeDetph;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;46;422.7987,638.0274;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;24;570.8046,-53.78607;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;82;-488.9697,1360.877;Inherit;False;1256.19;390.5999;Comment;6;78;75;77;73;76;79;WaterReflect;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;96;556.7373,524.8174;Inherit;False;W_Normals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;92;561.3785,78.44475;Inherit;False;W_color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;349.78,-1045.501;Inherit;False;FakeDetph01;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;977.7495,192.4549;Inherit;False;Property;_W_Emission;W_Emission;11;0;Create;True;0;0;False;0;0.4;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;95;1137.923,27.42952;Inherit;False;92;W_color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;1144.972,148.7918;Inherit;False;96;W_Normals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;1150.63,267.0196;Inherit;False;30;FakeDetph;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;78;-355.9695,1573.477;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;76;182.3806,1446.177;Inherit;True;Property;_Cubemap;Cubemap;2;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ReflectOpNode;73;-21.61956,1474.177;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;77;-353.2696,1410.877;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;75;-176.6197,1551.177;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;1161.018,384.494;Inherit;False;79;W_Reflect;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;571.2204,1423.761;Inherit;False;W_Reflect;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;1516.339,40.28849;Half;False;True;-1;2;ASEMaterialInspector;0;0;StandardSpecular;Tomcat/Scene/Water_ls;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;7;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;1;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Mobile/Diffuse;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.264;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;17;0;5;0
WireConnection;8;0;9;0
WireConnection;11;0;8;0
WireConnection;11;1;13;0
WireConnection;18;0;20;0
WireConnection;18;1;17;0
WireConnection;22;0;18;0
WireConnection;22;1;21;0
WireConnection;14;0;11;0
WireConnection;40;0;60;0
WireConnection;38;0;22;0
WireConnection;15;0;14;0
WireConnection;15;1;16;0
WireConnection;43;0;40;0
WireConnection;23;0;15;0
WireConnection;23;1;38;0
WireConnection;42;0;40;0
WireConnection;139;5;138;0
WireConnection;30;0;23;0
WireConnection;141;0;43;0
WireConnection;141;1;139;0
WireConnection;140;0;42;0
WireConnection;140;1;139;0
WireConnection;44;1;141;0
WireConnection;44;5;41;0
WireConnection;45;1;140;0
WireConnection;45;5;41;0
WireConnection;46;0;45;0
WireConnection;46;1;44;0
WireConnection;24;0;26;0
WireConnection;24;1;27;0
WireConnection;24;2;29;0
WireConnection;96;0;46;0
WireConnection;92;0;24;0
WireConnection;109;0;8;0
WireConnection;76;1;73;0
WireConnection;73;0;75;0
WireConnection;73;1;77;0
WireConnection;75;0;78;0
WireConnection;79;0;76;0
WireConnection;2;0;95;0
WireConnection;2;1;97;0
WireConnection;2;2;114;0
WireConnection;2;9;31;0
ASEEND*/
//CHKSM=D1BE3FF454081740960A73EBE9C21B6D52FE2043