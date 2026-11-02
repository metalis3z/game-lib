--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2, p3)
	if not p3 then
		p3 = 0.1;
	end;
	if typeof(p1) == "Vector3" then
		p1 = CFrame.new(p1);
	end;
	local function v1()
		local v2 = Instance.new("Part");
		v2.Anchored = true;
		v2.CanCollide = false;
		v2.Transparency = 0.65;
		v2.Color = Color3.fromRGB(255, 255, 255);
		v2.Material = Enum.Material.SmoothPlastic;
		return v2;
	end;
	local v3 = p1 + p2;
	local v4 = v1();
	local l__Magnitude__5 = (p1.p - v3.p).Magnitude;
	v4.Size = Vector3.new(0.075, 0.075, l__Magnitude__5);
	v4.CFrame = CFrame.new(p1.p, v3.p) * CFrame.new(0, 0, -l__Magnitude__5 / 2);
	v4.Parent = game.Workspace.CurrentCamera;
	local v6 = v1();
	v6.Color = Color3.fromRGB(46, 255, 10);
	v6.Transparency = 0;
	v6.Size = Vector3.new(0.2, 0.2, 0.2);
	v6.CFrame = p1;
	v6.Parent = game.Workspace.CurrentCamera;
	local v7 = v1();
	v7.Color = Color3.fromRGB(255, 16, 16);
	v7.Transparency = 0;
	v7.Size = Vector3.new(0.2, 0.2, 0.2);
	v7.CFrame = CFrame.new(v3.p);
	v7.Parent = game.Workspace.CurrentCamera;
	u1.Functions.FastTween({ v4, v6, v7 }, {
		Transparency = 1
	}, { p3 }).Completed:Connect(function()
		v4:Destroy();
	end);
end;
