// [Space(10)]
// [Header(MatCap)]
// //Material Capture纹理
// [NoScaleOffset]_MatCap("MatCap", 2D) = "black" {}
// _MatCapIntencity("MatCap Intencity", Range(0, 1)) = 0.3
// _MatCapSpec("MatCap Spec", 2D) = "black" {}
// _MatCapSpecIntencity("MatCapSpec Intencity", Range(0, 1)) = 0.3
// _MatCapColor ("MatCap Color", Color) = (0.2, 0.2, 0.2, 1)

sampler2D _MatCap;
sampler2D _MatCapSpec;
float4 _MatCapSpec_ST;
float4 _MatCapColor;
float _MatCapIntencity;
float _MatCapSpecIntencity;

//计算材质捕获UV
half2 matcapSample(half3 worldUp, half3 viewDirection, half3 normalDirection)
{
    half3 worldViewUp = normalize(worldUp - viewDirection * dot(viewDirection, worldUp));
    half3 worldViewRight = normalize(cross(viewDirection, worldViewUp));
    half2 matcapUV = half2(dot(worldViewRight, normalDirection), dot(worldViewUp, normalDirection)) * 0.5 + 0.5;
    return matcapUV;
}

//计算材质捕获颜色
half3 calcMatCap(half3 normal, half3 indirectLight, half3 viewDir)
{
    half3 spec = half3(0,0,0);
    half3 upVector = half3(0,1,0);
    half2 remapUV = matcapSample(upVector, viewDir, normal);
    spec = tex2Dlod(_MatCap, half4(remapUV, 0, 0)) * _MatCapIntencity;
    spec += tex2D(_MatCapSpec, TRANSFORM_TEX(remapUV, _MatCapSpec)) * _MatCapSpecIntencity;
    spec *= _MatCapColor * indirectLight;

    return spec;
}
