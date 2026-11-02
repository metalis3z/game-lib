-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = game:GetService("RunService"):IsServer();
local u3 = false;
local u4 = {};
function v1.GivePack(p1, p2)
	local v2 = nil;
	if not u2 then
		return;
	end;
	v2 = u1.Packs.Get(p2);
	local v3 = u1.Saving.Get(p1);
	if not v3 or not v2 then
		return false;
	end;
	if not u1.Packs.IsAvailable(p2) then
		return false;
	end;
	local v4 = true;
	for v5, v6 in pairs(v2.items) do
		if not u1.GunCmds.DoesOwnGun(p1, v6) and not u1.Shared.giveGun(p1, v6) then
			v4 = false;
		end;
	end;
	if v4 then
		return true;
	end;
	v3.Guns = v3.Guns;
	return false;
end;
function v1.Get(p3)
	return u1.Directory.Packs[p3];
end;
function v1.GetAll()
	return u1.Directory.Packs;
end;
function v1.GetAvailableGuns(p4)
	local v7 = v1.Get(p4);
	if not v7 then
		u1.Print("Invalid pack", true);
		return;
	end;
	return v7.items;
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
function v1.IsAvailable(p5)
	local v8 = u5();
	local v9 = v1.Get(p5);
	if not v9 then
		return false;
	end;
	if v9.disabled then
		return false;
	end;
	if v9.starts < v8 and v8 < v9.ends then
		return true;
	end;
	return false;
end;
function v1.IsDisabled(p6)
	local v10 = u5();
	local v11 = v1.Get(p6);
	if v11.disabled then
		return true;
	end;
	if v11.isDisabledAt and v11.isDisabledAt < v10 then
		return true;
	end;
	if v11.ends + 604800 < v10 then
		return true;
	end;
	return false;
end;
function v1.IsOld(p7)
	local v12 = v1.Get(p7);
	if v12.disabled then
		return true;
	end;
	if v12.ends and v12.ends + 3600 < u5() then
		return true;
	end;
	return false;
end;
function v1.IsInPacks(p8)
	if not u1.GunCmds.Get(p8) then
		--u1.Print("Invalid gunId", true);
		return
	end;
	for v13, v14 in pairs(v1.GetAll()) do
		for v15, v16 in pairs(v14.items) do
			if v16 == p8 then
				return true, v13;
			end;
		end;
	end;
	return false;
end;
function v1.IsGunAvailable(p9)
	local v17 = nil;
	if not u1.GunCmds.Get(p9) then
		--u1.Print("Invalid gunId", true);
		return;
	end;
	local v18 = nil;
	v18, v17 = v1.IsInPacks(p9);
	if not v18 or not v17 then
		return false;
	end;
	local v19 = v1.Get(v17);
	if not v1.IsAvailable(v17) then
		return false;
	end;
	return false;
end;
function v1.Value(p10)
	local v20 = v1.Get(p10);
	if not v20 then
		u1.Print("Invalid pack", true);
		return;
	end;
	local v21 = 0;
	for v22, v23 in pairs(v20.items) do
		local v24 = u1.GunCmds.Get(v23);
		if v24 and not v24.disabled then
			v21 = v21 + v24.price;
		end;
	end;
	return v21;
end;
function v1.BuyAllPrice(p11, p12)
	local v25 = v1.Get(p12);
	local v26 = 0;
	local v27
	if not u2 then
		v27 = u1.Save.Get();
	else
		v27 = u1.Saving.Get(p11);
	end;
	if not p11 or p11.Parent ~= game.Players then
		u1.Print("Invalid parameters", true);
		return;
	end;
	if not v27 or not v27.Guns then
		u1.Print("Failed to get stats", true);
		return;
	end;
	if not v25 then
		u1.Print("Invalid pack", true);
		return;
	end;
	for v28, v29 in pairs(v25.items) do
		local v30 = u1.GunCmds.Get(v29);
		if v30 and not v30.disabled and not u1.GunCmds.DoesOwnGun(p11, v29) then
			v26 = v26 + v30.price;
		end;
	end;
	if v26 == 0 then
		return 99999999;
	end;
	return v26;
end;
function v1.IsInRobux(p13)
	local v31 = v1.Get(p13);
	if not (not v31.productId) and v31.productId ~= 0 or v31.gamepassId and v31.gamepassId ~= 0 then
		return true;
	end;
	return false;
end;
function v1.HasItemFrom(p14, p15)
	local v32 = v1.Get(p15);
	local v33
	if not u2 then
		v33 = u1.Save.Get();
	else
		v33 = u1.Saving.Get(p14);
	end;
	if not p14 or p14.Parent ~= game.Players then
		u1.Print("Invalid parameters", true);
		return;
	end;
	if not v33 or not v33.Guns then
		u1.Print("Failed to get stats", true);
		return;
	end;
	if not v32 then
		u1.Print("Invalid pack", true);
		return;
	end;
	for v34, v35 in pairs(v32.items) do
		local v36 = u1.GunCmds.Get(v35);
		if v36 and not v36.disabled and u1.GunCmds.DoesOwnGun(p14, v35) then
			return true;
		end;
	end;
	return false;
end;
function v1.Owns(p16, p17)
	local v37 = v1.Get(p17);
	local v38
	if not u2 then
		v38 = u1.Save.Get();
	else
		v38 = u1.Saving.Get(p16);
	end;
	if not p16 or p16.Parent ~= game.Players then
		u1.Print("Invalid parameters", true);
		return;
	end;
	if not v38 or not v38.Guns then
		u1.Print("Failed to get stats", true);
		return;
	end;
	if not v37 then
		u1.Print("Invalid pack", true);
		return;
	end;
	local v39 = 0;
	local v40 = 0;
	for v41, v42 in pairs(v37.items) do
		local v43 = u1.GunCmds.Get(v42);
		v39 = v39 + 1;
		if v43 and u1.GunCmds.DoesOwnGun(p16, v42) then
			v40 = v40 + 1;
		end;
	end;
	if v39 <= v40 then
		return true;
	end;
	return false;
end;
if u2 then

end;
return v1;
