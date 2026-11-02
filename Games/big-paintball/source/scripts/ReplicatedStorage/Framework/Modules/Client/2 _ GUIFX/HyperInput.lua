-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2, p3, p4)
	if p1.AnchorPoint ~= Vector2.new(0.5, 0.5) then
		u1.Print("Button needs to be centered to use button fx (" .. p1.Parent.Parent.Name .. "." .. p1.Parent.Name .. "." .. p1.Name .. ")", true);
		return;
	end;
	if p2 == nil then
		p2 = false;
	end;
	if p4 == nil then
		p4 = false;
	end;
	p1.AutoButtonColor = false;
	local v1 = Instance.new("UIScale");
	v1.Parent = p1;
	local u2 = false;
	local u3 = false;
	local l__ImageColor3__4 = p1.ImageColor3;
	local u5 = false;
	local u6 = false;
	local function u7()
		if not u2 and not u3 then
			u2 = true;
			u3 = true;
			u1.Functions.FastTween(v1, {
				Scale = 0.933
			}, { 0.08, "Linear" });
			if not p4 then
				local v2, v3, v4 = l__ImageColor3__4:ToHSV();
				u1.Functions.FastTween(p1, {
					ImageColor3 = Color3.fromHSV(v2, v3, v4 - 0.2)
				}, { 0.075, "Quad", "Out" });
			end;
			u2 = false;
		end;
	end;
	p1.InputBegan:Connect(function(p5)
		local l__UserInputType__5 = p5.UserInputType;
		local v6
		if l__UserInputType__5 == Enum.UserInputType.MouseButton1 or l__UserInputType__5 == Enum.UserInputType.Touch or l__UserInputType__5 == Enum.UserInputType.Gamepad1 then
			v6 = true;
		else
			v6 = nil;
		end;
		if not v6 then
			return;
		end;
		u7();
	end);
	local function u8()
		if not u5 and u3 then
			u5 = true;
			u3 = false;
			p1.ImageColor3 = Color3.new(1, 1, 1);
			u1.Functions.FastTween(v1, {
				Scale = 1
			}, { 0.065, "Back", "Out" });
			if not p4 then
				u1.Functions.FastTween(p1, {
					ImageColor3 = l__ImageColor3__4
				}, { 0.12, "Sine", "Out" });
			end;
			if not p2 then
				u1.Audio.Play(5745909596, script, 1, 0.5);
			end;
			u5 = false;
		end;
	end;
	p1.InputEnded:Connect(function(p6)
		local l__UserInputType__7 = p6.UserInputType;
		local v8
		if l__UserInputType__7 == Enum.UserInputType.MouseButton1 or l__UserInputType__7 == Enum.UserInputType.Touch or l__UserInputType__7 == Enum.UserInputType.Gamepad1 then
			v8 = true;
		else
			v8 = nil;
		end;
		if not v8 then
			return;
		end;
		u8();
	end);
	if not p4 then
		local function u9()
			if not u6 and u1.Variables.Desktop then
				u6 = true;
				if not u3 then
					local v9, v10, v11 = l__ImageColor3__4:ToHSV();
					u1.Functions.FastTween(p1, {
						ImageColor3 = Color3.fromHSV(v9, v10, v11 + 0.2)
					}, { 0.05, "Expo", "Out" });
				end;
			end;
		end;
		p1.MouseEnter:Connect(function()
			u9();
		end);
		local function u10()
			if u6 and u1.Variables.Desktop then
				u6 = false;
				if not u3 then
					u1.Functions.FastTween(p1, {
						ImageColor3 = l__ImageColor3__4
					}, { 0.05, "Linear" });
				end;
			end;
		end;
		p1.MouseLeave:Connect(function()
			u10();
		end);
	end;
	if p3 then
		game:GetService("UserInputService").InputBegan:Connect(function(p7)
			if p3.Enabled and not u1.Variables.Typing and (p7.KeyCode == Enum.KeyCode.Space or p7.KeyCode == Enum.KeyCode.ButtonY) then
				u7();
			end;
		end);
		game:GetService("UserInputService").InputEnded:Connect(function(p8)
			if p3.Enabled and not u1.Variables.Typing and (p8.KeyCode == Enum.KeyCode.Space or p8.KeyCode == Enum.KeyCode.ButtonY) then
				u8();
			end;
		end);
	end;
end;
