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
public class OutLineCameraCommand : MonoBehaviour
{
    public GameObject ShadowTarget;
    public Material outlinePreMaterial;
    public Material outlineMaterial;
    [Range(0, 5)]
    public int m_downSampler = 2;
    [Range(0, 3)]
    public int blurIterator = 2;
    [Range(0, 8)]
    public float blurSize = 1.5f;
    public Color outlineColor;
    public bool hardSide;

    public RenderTexture m_renderTexture;
    private CommandBuffer m_commandBuffer;

    void ShowShadow(Renderer[] Renderers, Camera _renderCam)
    {
        m_commandBuffer = new CommandBuffer();
        if (m_renderTexture == null)
        {
            int width = _renderCam.pixelWidth;
            int height = _renderCam.pixelHeight;
            m_renderTexture = RenderTexture.GetTemporary(width, height, 0);
            //
            //m_renderTexture = RenderTexture.GetTemporary(Screen.width >> m_downSampler, Screen.height >> m_downSampler, 0);
        }
        m_commandBuffer.SetRenderTarget(m_renderTexture);
        m_commandBuffer.ClearRenderTarget(true, true, Color.black);
        foreach (var renderer in Renderers)
        {
            m_commandBuffer.DrawRenderer(renderer, outlinePreMaterial);
        }
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (m_commandBuffer == null)
        {
            Graphics.Blit(source, destination);
            return;
        }

        int rtW = source.width >> m_downSampler;
        int rtH = source.height >> m_downSampler;

        // 插入commandbuffer，绘制出纯色的图片
        outlinePreMaterial.SetColor("_OutlineColor", outlineColor);
        Graphics.ExecuteCommandBuffer(m_commandBuffer);
        var temp1 = RenderTexture.GetTemporary(rtW, rtH, 16);
        var temp2 = RenderTexture.GetTemporary(rtW, rtH, 16);
        Graphics.Blit(m_renderTexture, temp1, outlineMaterial, 0);
        //Graphics.Blit(temp1, temp2, outlineMaterial, 1);
        for (int i = 0; i < blurIterator; ++i)
        {
            //水平方向高斯模糊
            Graphics.Blit(temp1, temp2, outlineMaterial, 0);
            //竖直方向高斯模糊
            Graphics.Blit(temp2, temp1, outlineMaterial, 1);
        }

        //add
        //把模糊的边框加到原来的照片中
        if (hardSide)
        {
            outlineMaterial.EnableKeyword("_Hard_Side");
            outlineMaterial.SetColor("_OutlineColor", outlineColor);
        }
        else
        {
            outlineMaterial.DisableKeyword("_Hard_Side");
        }
        outlineMaterial.SetTexture("_BlurTex", temp2);
        outlineMaterial.SetTexture("_SrcTex", m_renderTexture);
        outlineMaterial.SetFloat("_BlurSize", blurSize);
        Graphics.Blit(source, destination, outlineMaterial, 2);
        RenderTexture.ReleaseTemporary(temp1);
        RenderTexture.ReleaseTemporary(temp2);
    }

    private void OnGUI()
    {
        GUILayout.BeginArea(new Rect(Screen.width - 100, 0, 200, 360));

        if (GUI.Button(new Rect(0, 0, 100, 30), "描边阴影"))
        {
            if (ShadowTarget)
            {
                Renderer[] renders = ShadowTarget.GetComponentsInChildren<Renderer>();
                if (renders != null && renders.Length > 0)
                {
                    ShowShadow(renders, Camera.main);
                }
            }
        }

        GUILayout.EndArea();
    }
}
