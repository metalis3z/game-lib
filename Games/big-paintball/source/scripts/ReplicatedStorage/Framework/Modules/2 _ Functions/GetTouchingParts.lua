--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	local v1 = p1:GetTouchingParts();
	p1.Touched:Connect(function()

	end):Disconnect();
	return v1;
end;
