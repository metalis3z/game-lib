-- Decompiled with the Synapse X Luau decompiler.

local function u1(p1, p2, p3)
	local v1, v2, v3 = ipairs(p1:GetDescendants());
	while true do
		v1(v2, v3);
		if not v1 then
			break;
		end;
		v3 = v1;
		if v2:IsA(p3) and v2.Name == p2 then
			return v2;
		end;	
	end;
	return nil;
end;
local u2 = { script.Parent.Parent, game:GetService("ReplicatedFirst"), game:GetService("ReplicatedStorage"), game:GetService("ServerScriptService"), (game:GetService("ServerStorage")) };
return function()
	local v4 = script:FindFirstAncestorOfClass("Plugin");
	if v4 then
		local v5 = u1(v4, "Promise", "ModuleScript");
		if v5 then
			return true, require(v5);
		else
			return false;
		end;
	end;
	local v6 = nil;
	local v7, v8, v9 = ipairs(u2);
	while true do
		v7(v8, v9);
		if not v7 then
			break;
		end;
		v9 = v7;
		v6 = u1(v8, "Promise", "ModuleScript");
		if v6 then
			break;
		end;	
	end;
	if not v6 then
		return false;
	end;
	return true, require(v6);
end;
