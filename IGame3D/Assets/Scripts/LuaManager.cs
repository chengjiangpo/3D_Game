using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using LuaInterface;
namespace IGame3D
{
    public class LuaManager : MonoBehaviour
    {
        private LuaState lua;
        private LuaLooper loop = null;
        public string luaContextJson;

        static private LuaManager instance;
        static public LuaManager Instance
        {
            set
            {
                instance = value;
            }
            get 
            {
                return instance;
            }
        }

        LuaManager()
        {
            Instance = this;
        }

        void Awake() {
            new LuaResLoader(); //真机上使用
            lua = new LuaState();
            lua.LuaSetTop(0);
            this.OpenLibs();
            LuaBinder.Bind(lua);
            DelegateFactory.Init();
            LuaCoroutine.Register(lua, this);

        }
        // Start is called before the first frame update
        void Start()
        {
            InitStart();
        }

        public void InitStart()
        {
            InitLuaPath();
        
            lua.Start();    //启动LUAVM
            this.StartMain();
            this.StartLooper();
        }

        void StartLooper()
        {
            loop = gameObject.AddComponent<LuaLooper>();
            loop.luaState = lua;
        }

        void OpenLibs()
        {
            lua.OpenLibs(LuaDLL.luaopen_pb);
        // lua.OpenLibs(LuaDLL.luaopen_sproto_core);
            // lua.OpenLibs(LuaDLL.luaopen_protobuf_c);
            lua.OpenLibs(LuaDLL.luaopen_lpeg);
            lua.OpenLibs(LuaDLL.luaopen_bit);
            lua.OpenLibs(LuaDLL.luaopen_socket_core);

            this.OpenCJson();

            if (LuaConst.openLuaSocket)
            {
                OpenLuaSocket();
            }
        }

        protected void OpenCJson()
        {
            lua.LuaGetField(LuaIndexes.LUA_REGISTRYINDEX, "_LOADED");
            lua.OpenLibs(LuaDLL.luaopen_cjson);
            lua.LuaSetField(-2, "cjson");

            lua.OpenLibs(LuaDLL.luaopen_cjson_safe);
            lua.LuaSetField(-2, "cjson.safe");
        }


        protected void OpenLuaSocket()
        {
            lua.LuaGetField(LuaIndexes.LUA_REGISTRYINDEX, "_LOADED");
            lua.OpenLibs(LuaDLL.luaopen_socket_core);
            lua.LuaSetField(-2, "socket.core");

            lua.OpenLibs(LuaDLL.luaopen_mime_core);
            lua.LuaSetField(-2, "mime.core");
        }




        void InitLuaPath()
        {
            List<string> pathList = CommonUtils.GetLuaPath();
            for(int i = 0; i < 1; i++)
            {
                if(i == 0)
                {
                    lua.AddSearchPath(pathList[i],true);
                }else 
                {
                    lua.AddSearchPath(pathList[i]);
                }
            }
            
        }


        void StartMain()
        {
            lua.DoFile("Main.lua");
        }

        public void LuaGC()
        {
            lua.LuaGC(LuaGCOptions.LUA_GCCOLLECT);
        }

        public void Close()
        {
        
            if (loop != null)
                loop.Destroy();
            loop = null;

            lua.Dispose();
            lua = null;
        }

    }

}