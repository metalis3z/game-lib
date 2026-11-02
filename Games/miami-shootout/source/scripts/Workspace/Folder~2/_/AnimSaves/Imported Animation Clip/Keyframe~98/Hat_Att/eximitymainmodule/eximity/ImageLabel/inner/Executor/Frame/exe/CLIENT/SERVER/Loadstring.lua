-- Decompiled with the Synapse X Luau decompiler.

for v1, v2 in pairs({ "LBI", "LuaK", "LuaP", "LuaU", "LuaX", "LuaY", "LuaZ" }) do
	script:WaitForChild(v2);
end;
local v3 = require(script.LuaY);
local v4 = require(script.LuaZ);
local v5 = require(script.LuaU);
local v6 = require(script.LBI);
require(script.LuaX):init();
local u1 = {};
return function(p1, p2)
	local u2 = nil;
	local u3 = nil;
	local u4 = nil;
	local v7, v8 = pcall(function()
		local v9 = v4:init(v4:make_getS(p1), nil);
		if not v9 then
			return error();
		end;
		local v10 = v3:parser(u1, v9, nil, "@input");
		local v11, v12 = v5:make_setS();
		u2 = v11;
		u3 = v12;
		v5:dump(u1, v10, u2, u3);
		u4 = v6.load_bytecode(u3.data);
		if p2 then
			setfenv(u4, p2);
			return;
		end;
		local v13 = getfenv();
		v13.script = nil;
		setfenv(u4, v13);
	end);
	if not v7 then
		return nil, v8;
	end;
	return u4, u3.data;
end;
