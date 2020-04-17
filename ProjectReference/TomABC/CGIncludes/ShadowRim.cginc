// 边缘阴影
half4 calcShadowRim(half svdn, half ndl)
{
    half rimIntensity = saturate((1-svdn)) * pow(1-ndl, _ShadowRimThreshold * 2);
    rimIntensity = smoothstep(_ShadowRimRange - _ShadowRimSharpness, _ShadowRimRange + _ShadowRimSharpness, rimIntensity);
    half4 shadowRim = lerp(1, _ShadowRim, rimIntensity);

    return shadowRim;
}

half3 calcStereoViewDir(half3 worldPos)
{
    #if UNITY_SINGLE_PASS_STEREO
        half3 cameraPos = half3((unity_StereoWorldSpaceCameraPos[0]+ unity_StereoWorldSpaceCameraPos[1])*.5); 
    #else
        half3 cameraPos = _WorldSpaceCameraPos;
    #endif
        half3 viewDir = cameraPos - worldPos;
    return normalize(viewDir);
}