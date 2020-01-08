using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using IGame3D;
public class Main : MonoBehaviour
{
    private LuaManager _luaManager;
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log("IGame3D Start");
        Debug.Log("Update Path = " + IGame3D.CommonUtils.GetUpdatePath());

        // 启动Lua 
        // LuaManager.Instance.Start();
        LuaManager luaManager = gameObject.AddComponent<LuaManager>();

    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
