-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2, p3, p4)
	local v1 = {};
	if typeof(p1) == "Vector3" then
		p1 = CFrame.new(p1);
	end;
	p4 = p4 and 2;
	local v2 = Instance.new("Part");
	v2.Anchored = true;
	v2.CanCollide = false;
	v2.Size = Vector3.new(0.05, 0.05, 0.05);
	v2.Transparency = 1;
	v2.CFrame = p1;
	v2.Name = "RewardBillboard";
	v2.Parent = u1.Debris;
	local v3 = u1.Assets.Billboards:FindFirstChild(p3):Clone();
	local v4 = v3:GetDescendants();
	if p2 then
		for v5, v6 in ipairs(v4) do
			if v6.ClassName == "TextLabel" then
				v6.Text = p2;
			end;		
		end;
	end;
	v3.Size = UDim2.new(v3.Size.X.Scale * 0.5, v3.Size.X.Offset * 0.5, v3.Size.Y.Scale * 0.5, v3.Size.Y.Offset * 0.5);
	u1.Functions.FastTween(v3, {
		Size = v3.Size
	}, { 0.5, "Expo", "Out" });
	v3.Parent = v2;
	coroutine.wrap(function()
		local v8 = tick();
		local l__StudsOffsetWorldSpace__9 = v3.StudsOffsetWorldSpace;
		while tick() - v8 <= p4 do
			local v10 = u1.Functions.Easing((tick() - v8) / p4, "Linear", "InOut");
			v3.StudsOffsetWorldSpace = l__StudsOffsetWorldSpace__9 + Vector3.new(math.sin(v10 * 6) * 0.75, 4 * v10, -math.sin(v10 * 6) * 0.75);
			u1.RenderStepped();		
		end;
	end)();
	table.insert(v1, (u1.Functions.FastTween(v3, {
		Size = UDim2.new(0, 0, 0, 0)
	}, { 0.4, "Back", "Out" }, p4 - 0.4)));
	for v11, v12 in ipairs(v1) do
		v12.Completed:Connect(function()
			v2:Destroy();
		end);	
	end;
end;
