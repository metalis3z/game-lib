-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__1 = game.ReplicatedStorage:WaitForChild("Assets");
local v2 = Random.new();
local l__LocalPlayer__3 = game.Players.LocalPlayer;
return function()
	local v4 = Instance.new("BindableEvent");
	local v5 = {};
	u1.Network.Fire("Drop Care Package");
	local u2 = {
		InUse = true, 
		Completed = v4.Event
	};
	coroutine.wrap(function()
		wait(0.5);
		u2.InUse = false;
		v4:Fire();
	end)();
	return u2;
end;
