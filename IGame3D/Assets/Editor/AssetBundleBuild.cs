using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class AssetBundleBuild
{
  // 在Unity的ToolsBar中添加按钮和按钮的回调函数
  [MenuItem("AssetBundle/Build")]

  public static void Builde()
  {
#if (UNITY_5 || UNITY_5_3_OR_NEWER)
      // 开始打包
      BuildPipeline.BuildAssetBundles(Application.streamingAssetsPath, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows);
#endif
  }
}