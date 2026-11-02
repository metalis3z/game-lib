-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__1 = game.ReplicatedStorage:WaitForChild("Assets");
local l__UIEasingStyle__2 = u1.Settings.UIEasingStyle;
local l__PlayerGui__2 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
return function(p1, p2)
	if u1.Variables.Mobile == true then
		return false;
	end;
	local v3 = {};
	local v4 = l__PlayerGui__2:FindFirstChild("TooltipsFolder");
	if v4 == nil then
		v4 = Instance.new("ScreenGui");
		v4.Name = "TooltipsFolder";
		v4.DisplayOrder = 999;
		v4.Parent = l__PlayerGui__2;
	end;
	local u3 = nil;
	local u4 = nil;
	local function u5()
		v4:ClearAllChildren();
		u3 = Instance.new("TextLabel");
		u3.BorderSizePixel = 0;
		u3.BackgroundColor3 = Color3.new(0.35, 0.35, 0.35);
		u3.TextColor3 = Color3.new(1, 1, 1);
		u3.FontSize = Enum.FontSize.Size18;
		u3.Font = Enum.Font.Highway;
		u3.Text = p2;
		local v5 = u1.TextService:GetTextSize(u3.Text, u3.TextSize, u3.Font, Vector2.new(175, 1000));
		u3.Size = UDim2.new(0, v5.X + 4, 0, v5.Y + 2);
		u3.Parent = v4;
		while not u4 and u3 and u3.Parent do
			if not p1 then
				break;
			end;
			local l__X__6 = u1.Player.Get("Mouse").X;
			local l__Y__7 = u1.Player.Get("Mouse").Y;
			local l__X__8 = p1.AbsolutePosition.X;
			local l__Y__9 = p1.AbsolutePosition.Y;
			if l__X__8 - 10 < l__X__6 and l__X__6 < l__X__8 + p1.AbsoluteSize.X + 10 and l__Y__9 - 10 < l__Y__7 and l__Y__7 < l__Y__9 + p1.AbsoluteSize.Y + 10 then
				local v10 = u1.Player.Get("Mouse");
				u3.Position = UDim2.new(0, v10.X + 17, 0, v10.Y);
			else
				u4 = true;
			end;
			u1.RenderStepped();		
		end;
		if u3 then
			u3:Destroy();
			u3 = nil;
		end;
	end;
	v3[#v3 + 1] = p1.MouseEnter:Connect(function()
		if u3 then
			u3:Destroy();
			u3 = nil;
		end;
		u5();
	end);
	v3[#v3 + 1] = p1.MouseLeave:Connect(function()
		if u3 then
			u3:Destroy();
			u3 = nil;
		end;
	end);
	local u6 = v3;
	return function()
		for v11, v12 in ipairs(u6) do
			v12:disconnect();		
		end;
		u6 = nil;
		u4 = true;
	end;
end;
