﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class IGame3D_ABLoaderWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(IGame3D.ABLoader), typeof(UnityEngine.MonoBehaviour));
		L.RegFunction("load", load);
		L.RegFunction("loadAsync", loadAsync);
		L.RegFunction("unLoad", unLoad);
		L.RegFunction("unLoadUnUsedAsset", unLoadUnUsedAsset);
		L.RegFunction("loadAsset", loadAsset);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int load(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IGame3D.ABLoader obj = (IGame3D.ABLoader)ToLua.CheckObject<IGame3D.ABLoader>(L, 1);
			string arg0 = ToLua.CheckString(L, 2);
			UnityEngine.Object o = obj.load(arg0);
			ToLua.Push(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int loadAsync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			IGame3D.ABLoader obj = (IGame3D.ABLoader)ToLua.CheckObject<IGame3D.ABLoader>(L, 1);
			string arg0 = ToLua.CheckString(L, 2);
			LuaFunction arg1 = ToLua.CheckLuaFunction(L, 3);
			obj.loadAsync(arg0, arg1);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int unLoad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			IGame3D.ABLoader obj = (IGame3D.ABLoader)ToLua.CheckObject<IGame3D.ABLoader>(L, 1);
			UnityEngine.AssetBundle arg0 = (UnityEngine.AssetBundle)ToLua.CheckObject<UnityEngine.AssetBundle>(L, 2);
			bool arg1 = LuaDLL.luaL_checkboolean(L, 3);
			obj.unLoad(arg0, arg1);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int unLoadUnUsedAsset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IGame3D.ABLoader obj = (IGame3D.ABLoader)ToLua.CheckObject<IGame3D.ABLoader>(L, 1);
			obj.unLoadUnUsedAsset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int loadAsset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.AssetBundle arg0 = (UnityEngine.AssetBundle)ToLua.CheckObject<UnityEngine.AssetBundle>(L, 1);
			string arg1 = ToLua.CheckString(L, 2);
			UnityEngine.Object o = IGame3D.ABLoader.loadAsset(arg0, arg1);
			ToLua.Push(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, IGame3D.ABLoader.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

