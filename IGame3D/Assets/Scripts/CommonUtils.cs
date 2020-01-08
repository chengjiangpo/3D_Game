#region "提供通用的接口"
#endregion

using System.Collections.Generic;
using System.ComponentModel;
using System;
using System.Net.Mime;
using UnityEngine;

namespace IGame3D
{
    public class CommonUtils 
    {
        static public string GetUpdatePath()
        {
            return Application.persistentDataPath + "/Update";
        }

        static public List<string> GetLuaPath()
        {
            List<string> list = new List<string>();
            list.Add(GetUpdatePath()+"/Lua");
            list.Add(Application.dataPath + "/Lua");
            return list;
        }
    };
};






















