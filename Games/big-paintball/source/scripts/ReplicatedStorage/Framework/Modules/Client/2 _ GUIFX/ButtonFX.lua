-- Onex Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	local v1 = p1:FindFirstChildOfClass("UIScale");
	if not v1 then
		v1 = Instance.new("UIScale");
		v1.Name = "ButtonUIScale";
		v1.Parent = p1;
	end;
	local v2 = {};
	for v3, v4 in ipairs(p1:GetChildren()) do
		if v4.ClassName == "TextLabel" and v4.Visible then
			v2[v4] = u1.GUIFX.CacheProperty(v4, "Position");
		end;	
	end;
	local u2 = false;
	local u3 = false;
	local u4 = {};
	local function u5()
		if not u2 then
			u2 = not u2;
			u1.Functions.Tween(v1, {
				Scale = 0.9
			}, { 0.065, Enum.EasingStyle.Exponential, "Out" });
		end;
	end;
	local function u6()
		if u2 then
			u2 = not u2;
			u1.Functions.Tween(v1, {
				Scale = 1
			}, { 0.25, Enum.EasingStyle.Circular, "Out" });
		end;
	end;
	local function u7()
		if not u3 then
			u3 = not u3;
			if not u2 then
				u1.Functions.Tween(v1, {
					Scale = 1.05
				}, { 0.05, Enum.EasingStyle.Circular, "Out" });
			end;
		end;
	end;
	local function u8()
		if u3 then
			u3 = not u3;
			if not u2 then
				u1.Functions.Tween(v1, {
					Scale = 1
				}, { 0.035, Enum.EasingStyle.Exponential, "Out" });
			end;
		end;
	end;
	(function()
		u4[#u4 + 1] = p1.InputBegan:Connect(function(p3)
			local l__UserInputType__6 = p3.UserInputType;
			if l__UserInputType__6 == Enum.UserInputType.MouseButton1 or (l__UserInputType__6 == Enum.UserInputType.Touch and p3.UserInputState == Enum.UserInputState.Begin or p3.KeyCode == Enum.KeyCode.ButtonA) then
				u5();
			end;
		end);
		u4[#u4 + 1] = p1.InputEnded:Connect(function(p4)
			local l__UserInputType__7 = p4.UserInputType;
			local l__UserInputState__8 = p4.UserInputState;
			if l__UserInputType__7 == Enum.UserInputType.MouseButton1 or l__UserInputType__7 == Enum.UserInputType.Touch or p4.KeyCode == Enum.KeyCode.ButtonA then
				u6();
			end;
		end);
		u4[#u4 + 1] = p1.MouseEnter:Connect(function()
			if u1.Variables.Desktop then
				u7();
			end;
		end);
		u4[#u4 + 1] = p1.MouseLeave:Connect(function()
			if u1.Variables.Desktop then
				u8();
			end;
		end);
	end)();
	local u9 = u1.GUIFX.InteractSound(p1, "mousedown", "rbxassetid://7000714975", 0.1, 1.75);
	local u10 = u1.GUIFX.InteractSound(p1, "mouseup", "rbxassetid://7000715003", 0.1, 2);
	return function()
	for v9, v10 in ipairs(u4) do
			v10:disconnect();		
		end;
		u9();
		u10();
	end;
end;
