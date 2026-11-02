--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1)
	local v1 = Instance.new("Part");
	v1.Anchored = true;
	v1.CanCollide = false;
	v1.Transparency = 1;
	v1.Material = Enum.Material.SmoothPlastic;
	v1.CastShadow = false;
	v1.Size = Vector3.new();
	v1.CFrame = typeof(p1) == "Vector3" and CFrame.new(p1) or p1;
	v1.Name = "host";
	local v2 = Instance.new("Attachment");
	v2.Parent = v1;
	v1.Parent = u1.Debris;
	return v1, v2;
end;
