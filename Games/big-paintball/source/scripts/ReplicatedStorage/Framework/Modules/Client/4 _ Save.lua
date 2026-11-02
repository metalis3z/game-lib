-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = {};
local u3 = nil;
local v3 = nil;
u3 = {
	Get = function(...)
		local v1, v2 = ...;
		if v1 ~= nil then
			v3 = type(v1) == "boolean" and u1.LocalPlayer or v1;
		else
			v3 = u1.LocalPlayer or v1;
		end;
		local v4 = u2[v3];
		if not v4 and v3 then
			u3.Update(v3);
			v4 = u2[v3];
		end;
		while (not v4 or not v4.loaded) and v3 == u1.LocalPlayer do
			u1.RenderStepped();		
		end;
		if not v3 or not u2[v3] then
			return;
		end;
		if v2 ~= nil and v2 or (type(v1) == "boolean" and v1 or true) then
			return v4.save;
		end;
		u3.Update(v3);
		return v4.save;
	end, 
	Update = function(p1)
		local v5 = u2[p1];
		if not v5 and p1 then
			u2[p1] = {
				save = nil, 
				loaded = false
			};
			v5 = u2[p1];
		end;
		local v6 = u1.Network.Invoke("Get Stats", p1, p1 == u1.LocalPlayer);
		if not v6 then
			u1.Print("Failed to update " .. p1.Name .. "'s Save", true);
			return false;
		end;
		v5.save = v6;
		local v7 = nil;
		if not v5.loaded then
			if p1 == u1.LocalPlayer then
				v7 = "Loaded Other Stats";
			else
				v7 = "Loaded Stats";
			end;
			u1.Signal.Fire(v7, p1);
		end;
		v5.loaded = true;
	end, 
	Error = function()
		u1.Print("STATS WERE RETURNED AS ERROR!", true);
		u1.LocalPlayer.Character = nil;
		u1.LocalPlayer:Kick("Something went wrong. Please rejoin!");
	end
};
function ProcessChanges(p2, p3)
	local v8 = u2[p3];
	if v8 then
		if not v8.loaded then
			return;
		end;
	else
		return;
	end;
	for v9, v10 in pairs(p2) do
		v8.save[v9] = v10;
		if p3 == u1.LocalPlayer then
			u1.Signal.Fire("Stat Changed", v9);
		else
			u1.Signal.Fire("Other Stat Changed", p3, v9);
		end;	
	end;
	if p3 == u1.LocalPlayer then
		u1.Signal.Fire("Stats Changed");
		return;
	end;
	u1.Signal.Fire("Other Stats Changed", p3);
end;
game.ReplicatedStorage["New Stats"].OnClientEvent:Connect(function(p4, p5)
	p5 = p5 or u1.LocalPlayer;
	ProcessChanges(p4, p5);
end);
game.Players.PlayerRemoving:Connect(function(p6)
	wait(3);
	u2[p6] = nil;
end);
coroutine.wrap(function()
	while true do
		for v14, v15 in ipairs(game.Players:GetPlayers()) do
			local v16 = u2[v15];
			if not v16 or not v16.save then
				u3.Update(v15);
			end;
		end;
		wait(2);	
	end;
end)();
u3.Get();
return u3;
