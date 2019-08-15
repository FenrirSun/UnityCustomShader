using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

///<summary>
///描述：缺少描述
///@作者 请填写作者
///@创建日期 2019-07-15 21-33-03
///@版本号 1.0
///</summary>
public class OutLineCameraScript : MonoBehaviour
{
    public Camera m_outlineCamera;
    public Shader m_outlinePreShader;
    public Material outlineMaterial;
    [Range(0,5)]
    public int m_downSampler;
    [Range(0, 5)]
    public int blurIterator = 2;
    [Range(0, 8)]
    public float blurSize = 1.5f;
    public Color outlineColor;
    public bool hardSide;

    private RenderTexture m_renderTexture;

    // Start is called before the first frame update
    void Start()
    {
        m_outlineCamera.cullingMask = 1 << LayerMask.NameToLayer("Tom");
        int width = m_outlineCamera.pixelWidth >> m_downSampler;
        int height = m_outlineCamera.pixelHeight >> m_downSampler;
        m_renderTexture = RenderTexture.GetTemporary(width, height, 0);
    }

    private void OnPreRender()
    {
        //先渲染到RT
        if (m_outlineCamera.enabled)
        {
            m_outlineCamera.targetTexture = m_renderTexture;
            //OutlineCamera摄像机下的所有物体都用outlineShader渲染
            m_outlineCamera.RenderWithShader(m_outlinePreShader, "");
        }
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        int rtW = source.width >> m_downSampler;
        int rtH = source.height >> m_downSampler;
        var temp1 = RenderTexture.GetTemporary(rtW, rtH, 0);
        var temp2 = RenderTexture.GetTemporary(rtW, rtH, 0);
        // 先模糊纯色的图片
        Graphics.Blit(m_renderTexture, temp1);
        // 模糊迭代
        for (int i = 0; i < blurIterator; ++i)
        {
            //水平方向高斯模糊
            Graphics.Blit(temp1, temp2, outlineMaterial, 0);
            //竖直方向高斯模糊
            Graphics.Blit(temp2, temp1, outlineMaterial, 1);
        }
        if (hardSide)
        {
            outlineMaterial.EnableKeyword("_Hard_Side");
        }
        else
        {
            outlineMaterial.DisableKeyword("_Hard_Side");
        }

        outlineMaterial.SetTexture("_BlurTex", temp2);
        outlineMaterial.SetTexture("_SrcTex", m_renderTexture);
        outlineMaterial.SetColor("_OutlineColor", outlineColor);
        outlineMaterial.SetFloat("_BlurSize", blurSize);
        Graphics.Blit(source, destination, outlineMaterial, 2);
        RenderTexture.ReleaseTemporary(temp1);
        RenderTexture.ReleaseTemporary(temp2);
    }
}
