-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2, p3, p4)
	p3 = p3 and 1;
	p2 = p2 and "";
	p4 = p4 and 1;
	local v1 = Instance.new("TextLabel");
	v1.AnchorPoint = Vector2.new(0.5, 0.5);
	v1.Position = p1;
	v1.Size = UDim2.new(0, 250, 0, 250);
	v1.BackgroundTransparency = 1;
	v1.BorderSizePixel = 0;
	v1.TextColor3 = Color3.new(1, 1, 1);
	v1.TextStrokeTransparency = 0.5;
	v1.Text = p2;
	v1.Name = "Floating Text";
	v1.Font = Enum.Font.GothamBold;
	v1.TextSize = 20;
	v1.Parent = u1.GUIFX.GetHolder();
	local v2 = u1.Functions.FastTween(v1, {
		TextTransparency = 1, 
		TextStrokeTransparency = 1, 
		Position = p1 + UDim2.new(0, 0, 0, -(game.Workspace.CurrentCamera.ViewportSize.Y / 5) * p4)
	}, { p3 });
	u1.Functions.AddDebris(v1, 5);
	v2.Completed:Connect(function()
		v1:Destroy();
	end);
	return v1;
end;
