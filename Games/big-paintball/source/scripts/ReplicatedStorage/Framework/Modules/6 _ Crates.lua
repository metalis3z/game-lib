-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = game:GetService("RunService"):IsServer();
local u3 = false;
local u4 = {};
function v1.Get(p1)
	return u1.Directory.Crates[p1];
end;
function v1.GetAll()
	return u1.Directory.Crates;
end;
function v1.GetAvailableGuns(p2)
	local v2 = v1.Get(p2);
	if not v2 then
		u1.Print("Invalid crate", true);
		return;
	end;
	return v2.items;
end;
local function u5()
	if u2 then
		return os.time();
	end;
	if not u2 and not u3 then
		u4 = {
			client = os.time(), 
			server = u1.Network.Invoke("Get Tick")
		};
		u3 = true;
	end;
	return u4.server + (os.time() - u4.client);
end;
function v1.IsAvailable(p3)
	local v3 = u5();
	local v4 = v1.Get(p3);
	if not v4 then
		return false;
	end;
	if v4.disabled then
		return false;
	end;
	if v4.starts < v3 and v3 < v4.ends then
		return true;
	end;
	return false;
end;
function v1.Open(p4)
	if not u2 then
		return;
	end;
	local v5 = v1.Get(p4);
	if not v5 or not v5.items then
		return;
	end;
	if not v1.IsAvailable(p4) then
		return;
	end;
	local v6 = {};
	for v7, v8 in pairs(v5.items) do
		table.insert(v6, { v7, v8 });
	end;
	return u1.Functions.Lottery(v6);
end;
function v1.GetRarity(p5, p6)
	local v9 = v1.GetAvailableGuns(p5);
	if not v9 then
		return;
	end;
	for v10, v11 in pairs(v9) do
		if v10 == p6 then
			return v11;
		end;
	end;
	return 0;
end;
function v1.GetRarityColor(p7)
	if not p7 or p7 == 0 then
		return Color3.new(1, 1, 1);
	end;
	for v12, v13 in pairs(u1.Shared.crateRarity) do
		if p7 <= v13.rarity then
			return v13.color;
		end;
	end;
	return Color3.new(0.85, 1, 0.85);
end;
function v1.IsInCrates(p8)
	if not u1.GunCmds.Get(p8) then
		--u1.Print("Invalid gunId", true);
		return;
	end;
	for v14, v15 in pairs(v1.GetAll()) do
		for v16, v17 in pairs(v15.items) do
			if v16 == p8 then
				return true, v14;
			end;
		end;
	end;
	return false;
end;
return v1;
