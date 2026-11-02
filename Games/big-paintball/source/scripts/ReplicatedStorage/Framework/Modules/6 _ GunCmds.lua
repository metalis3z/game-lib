-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
function v1.GetEquipped(p1)
	if not p1 or p1.Parent ~= game.Players then
		u1.Print("Invalid parameters", true);
		return;
	end;
	local v2 = u1.Entity.Get(p1);
	if not v2 or not v2.EquippedGun then
		return nil;
	end;
	local l__EquippedGun__3 = v2.EquippedGun;
	if not u1.Directory.Guns[l__EquippedGun__3] then
		u1.Print(string.format("Failed to find gun '%s'", l__EquippedGun__3), true);
		return;
	end;
	return l__EquippedGun__3, u1.Directory.Guns[l__EquippedGun__3];
end;
local u2 = game:GetService("RunService"):IsServer();
local v4
function v1.DoesOwnGun(p2, p3)
	if not u2 then
		v4 = u1.Save.Get();
	else
		v4 = u1.Saving.Get(p2, false);
	end;
	if not p2 or p2.Parent ~= game.Players then
		u1.Print("Invalid parameters", true);
		return;
	end;
	if not v4 or not v4.Guns then
		return;
	end;
	for v4, v5 in pairs(v4.Guns) do
		if v5.n == p3 then
			return true;
		end;
	end;
	return false;
end;
function v1.Get(p4)
	if not p4 then
		u1.Print("Invalid parameters", true);
		return;
	end;
	return u1.Directory.Guns[p4];
end;
return v1;
