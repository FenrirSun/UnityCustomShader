using UnityEngine;

public class DrawOutlineWithTarget : PostEffectsBase
{
    // 选择的物体列表
    public GameObject[] targets;

    [Range(0, 1)]
    public float width = 0.05f;
    public Color color = Color.green;

    // 所有选择物体的网格
    private MeshFilter[] meshFilters;

    // 也可以在OnPostRender()中更新
    private void Update()
    {
        if (TargetMaterial != null && targets != null) {
            TargetMaterial.SetFloat("_Width", width);
            TargetMaterial.SetColor("_Color", color);

            for (int i = 0; i < targets.Length; i++) {
                if (targets[i] == null)
                    continue;
                meshFilters = targets[i].GetComponentsInChildren<MeshFilter>();
                for (int j = 0; j < meshFilters.Length; j++)
                    Graphics.DrawMesh(meshFilters[j].sharedMesh, meshFilters[j].transform.localToWorldMatrix, TargetMaterial, 0);   // 对选中物体再次渲染。
            }
        }
    }
}
