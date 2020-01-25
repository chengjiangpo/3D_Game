using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using LuaInterface;

namespace IGame3D
{
    public class ABLoader : MonoBehaviour 
    {
        static private ABLoader instance;
        static public ABLoader Instance
        {
            get
            {
                return instance;
            }
        }

        ABLoader()
        {
            instance = this;
        }

        private string fullPath(string abPath)
        {
            return Application.streamingAssetsPath + "/" + abPath;
        }

        public Object load(string abPath)
        {
            return AssetBundle.LoadFromFile(fullPath(abPath)) as Object;
        }

        public void loadAsync(string abPath,LuaFunction callback)
        {
            StartCoroutine(loadAsyncCoroutine(fullPath(abPath),callback));
        }

        IEnumerator loadAsyncCoroutine(string abPath,LuaFunction callback)
        {
            AssetBundleCreateRequest request =  AssetBundle.LoadFromFileAsync(abPath);
            yield return request;

            if (callback != null)
            {
                callback.Call(request.assetBundle);
            }
        }

        /*
         *      @unloadAllLoadedAsset:是否清理所有已经加载过的资源
         */
        public void unLoad(AssetBundle ab,bool unloadAllLoadedAsset)
        {
            if (ab != null)
            {
                ab.Unload(unloadAllLoadedAsset);
            }
        }

        /*
         *      清空所有未使用的资源
         */
        public void unLoadUnUsedAsset()
        {
            Resources.UnloadUnusedAssets();
        }


        static public Object loadAsset(AssetBundle ab,string name)
        {
            Object asset = ab.LoadAsset(name) as Object;
            return asset;
        }
    }
}