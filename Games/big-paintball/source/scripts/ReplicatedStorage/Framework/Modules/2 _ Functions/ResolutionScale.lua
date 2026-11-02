--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__CurrentCamera__2 = game.Workspace.CurrentCamera;
local u3 = nil;
local u4 = nil;
return function()
	local l__ViewportSize__1 = l__CurrentCamera__2.ViewportSize;
	if l__ViewportSize__1 == u3 then
		return u4;
	end;
	local v2 = math.clamp(l__ViewportSize__1.Magnitude / 1800, 0.33, 2);
	u4 = v2;
	u3 = l__ViewportSize__1;
	return v2;
end;
