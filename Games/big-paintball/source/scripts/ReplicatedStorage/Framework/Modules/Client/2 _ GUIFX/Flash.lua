-- OneX Was here 

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__UIEasingStyle__3 = u1.Settings.UIEasingStyle;
return function(p1, p2, p3, p4)
	p1 = p1 and 1;
	p2 = p2 and 1;
	p3 = p3 or Color3.new(1, 1, 1);
	p4 = p4 and 0;
	local v4 = tick();
	coroutine.wrap(function()
		local v5 = Instance.new("Frame");
		v5.BackgroundTransparency = 1;
		v5.BackgroundColor3 = p3;
		v5.Size = UDim2.new(2, 0, 2, 0);
		v5.AnchorPoint = Vector2.new(0.5, 0.5);
		v5.Position = UDim2.new(0.5, 0, 0.5, 0);
		v5.BorderSizePixel = 0;
		v5.Parent = u1.GUIFX.GetHolder();
		if p1 > 0 then
			u1.Functions.FastTween(v5, {
				BackgroundTransparency = p4
			}, { p1, "Linear", "Out" });
			wait(p1);
		else
			v5.BackgroundTransparency = p4;
		end;
		if p2 > 0 then
			u1.Functions.FastTween(v5, {
				BackgroundTransparency = 1
			}, { p2, "Sine", "Out" });
			wait(p2);
		else
			v5.BackgroundTransparency = 1;
		end;
		v5:Destroy();
	end)();
end;
