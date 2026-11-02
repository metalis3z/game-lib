-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__1 = game.ReplicatedStorage:WaitForChild("Assets");
local v2 = Random.new();
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local v4 = u1.Player.Get("Camera");
local function u2(p1)
	for v5, v6 in pairs(game.Workspace.__THINGS.Drones:GetChildren()) do
		if v6.Name == p1.Name then
			return true;
		end;
	end;
	return false;
end;
return function()
	local v7 = Instance.new("BindableEvent");
	local v8 = {};
	u1.Network.Fire("Activate Drone");
	local u3 = {
		InUse = true, 
		Completed = v7.Event
	};
	coroutine.wrap(function()
		while true do
			wait();
			if not u2(game.Players.LocalPlayer) then
				break;
			end;		
		end;
		u3.InUse = false;
		v7:Fire();
	end)();
	return u3;
end;
