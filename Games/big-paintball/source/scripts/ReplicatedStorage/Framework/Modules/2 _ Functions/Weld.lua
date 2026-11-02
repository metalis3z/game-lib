--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2, p3)
	local v1
	if p3 then
		v1 = "ManualWeld";
	else
		v1 = "WeldConstraint";
	end;
	if p1.Anchored or p2.Anchored then
		v1 = "Motor6D";
	end;
	local v2 = Instance.new(v1);
	v2.Part0 = p1;
	v2.Part1 = p2;
	if v1 ~= "WeldConstraint" then
		v2.C0 = p1.CFrame:inverse() * p2.CFrame;
	end;
	v2.Parent = p1;
	return v2;
end;
