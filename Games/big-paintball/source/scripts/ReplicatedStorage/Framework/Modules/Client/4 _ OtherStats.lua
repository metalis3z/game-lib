-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = nil;
u2 = {
	Get = function(p1)
		if p1 ~= true then
			local v1 = u1.Network.Invoke("Get Other Stats");
			if v1 then
				u2.Cache = v1;
			end;
			return v1;
		end;
		if u2.Cache == nil then
			while u2.Cache == nil do
				u1.Services.RunService.RenderStepped:wait();			
			end;
		end;
		return u2.Cache;
	end
};
u1.Network.Fired("New Other Stats"):Connect(function(...)
	local v2 = ({ ... })[1];
	if v2 == "Error" then
		error("Failed to retrieve other player(s)' stats from server");
		return;
	end;
	u2.Cache = v2;
	u1.Signal.Fire("Other Stats Changed", v2);
end);
return u2;
