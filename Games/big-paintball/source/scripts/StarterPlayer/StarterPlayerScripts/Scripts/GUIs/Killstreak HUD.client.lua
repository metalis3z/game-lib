-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = Random.new();
local v4 = v1.Player.Get();
local v5 = v1.Player.Get("Camera");
local v6 = v1.Entity.Get(v4);
local l__Killstreaks__1 = v1.GUI.Killstreaks;
v1.Signal.Fired("Show Killstreak In Use"):Connect(function(p1, p2)
	local v7 = v1.Killstreaks.GetSlotByKillstreak(p1);
	if not v7 then
		print("failed to find slot");
		return;
	end;
	local v8 = l__Killstreaks__1.Main:FindFirstChild(v7);
	if v8 then
		if not p2 then
			v1.Functions.FastTween(v8.Used.UIScale, {
				Scale = 0
			}, { 0.125, "Sine", "InOut" }).Completed:Connect(function()
				v8.Used.Visible = false;
			end);
			return;
		end;
	else
		return;
	end;
	v8.Used.UIScale.Scale = 1.25;
	v8.Used.Visible = true;
	v1.Functions.FastTween(v8.Used.UIScale, {
		Scale = 1
	}, { 0.235, "Sine", "InOut" });
end);
v1.UserInputService.InputBegan:Connect(function(p3, p4)
	if p4 and p3.UserInputType ~= Enum.UserInputType.Gamepad1 and p3.UserInputType ~= Enum.UserInputType.Gamepad2 and p3.UserInputType ~= Enum.UserInputType.Gamepad3 then
		return;
	end;
	if p3.UserInputType ~= Enum.UserInputType.Keyboard and p3.UserInputType ~= Enum.UserInputType.Gamepad1 and p3.UserInputType ~= Enum.UserInputType.Gamepad2 and p3.UserInputType ~= Enum.UserInputType.Gamepad3 then
		return;
	end;
	for v9, v10 in pairs(v1.Killstreaks.KeyBinds) do
		if p3.KeyCode == v9 then
			local v11 = v1.Killstreaks.GetKillstreakBySlot(v10);
			if v11 and v4:FindFirstChild("__SPAWNED") then
				local v12 = l__Killstreaks__1.Main:FindFirstChild(v10);
				if v12 then
					coroutine.wrap(function()
						local v13 = script:WaitForChild("UIGradient"):Clone();
						v13.Offset = Vector2.new(0, -0.75);
						v13.Parent = v12;
						v1.Functions.FastTween(v13, {
							Offset = Vector2.new(0, 1.5)
						}, { 0.35, "Quad", "Out" });
						wait(0.5);
						v13:Destroy();
					end)();
				end;
				v1.Killstreaks.Use(v11);
			end;
		end;
	end;
end);
local function u2()
	local v14 = v1.Killstreaks.GetEquipped();
	if not v14 then -- me
		return nil; -- me
	end -- me
	for v15, v16 in pairs(v14) do
		if not l__Killstreaks__1.Main:FindFirstChild(v15) then
			local v17 = script:WaitForChild("Item"):Clone();
			v17.LayoutOrder = tonumber(v15);
			v17.Name = v15;
			v17.Parent = l__Killstreaks__1.Main;
			v17.Activated:Connect(function()
				local v18 = v1.Killstreaks.GetKillstreakBySlot(v15);
				if v18 and v18 ~= "" and v4:FindFirstChild("__SPAWNED") then
					local v19 = l__Killstreaks__1.Main:FindFirstChild(v15);
					if v19 then
						coroutine.wrap(function()
							local v20 = script:WaitForChild("UIGradient"):Clone();
							v20.Offset = Vector2.new(0, -0.75);
							v20.Parent = v19;
							v1.Functions.FastTween(v20, {
								Offset = Vector2.new(0, 1.5)
							}, { 0.35, "Quad", "Out" });
							wait(0.5);
							v20:Destroy();
						end)();
					end;
					v1.Killstreaks.Use(v18);
				end;
			end);
		end;
	end;
	for v21, v22 in pairs(v14) do
		local v23 = l__Killstreaks__1.Main:FindFirstChild(v21);
		local v24 = v1.Killstreaks.IsSlotInUse(v21);
		if not v24 then
			v23.Visible = false;
		else
			v23.Visible = true;
			local v25 = v1.Directory.Killstreaks[v22];
			local v26 = v1.Killstreaks.GetCountForStreak(v22);
			if v25 and v26 and (v23) then
				v23:WaitForChild("CountFrame"):WaitForChild("Count").Text = v26;
				v23:WaitForChild("Thumbnail").Image = v25.thumbnail;
				v23:WaitForChild("Title").Text = v25.displayName;
				v23.LayoutOrder = tonumber(v21);
				v23.Visible = v24;
				if v26 > 0 then
					v23.CountFrame.Visible = true;
					v23.Kills.Visible = false;
					if v1.Variables.Mobile or v1.Variables.Console then
						v23.KeyBind.Visible = false;
						v23.ShortcutIcon.Visible = false;
					else
						v23.KeyBind.Visible = true;
						v23.ShortcutIcon.Visible = true;
					end;
					if v1.Variables.Console then
						v23.DPad.Visible = true;
						if v1.Killstreaks.KeyBindDisplay.Xbox[v21] then
							v23.DPad.Image = v1.Killstreaks.KeyBindDisplay.Xbox[v21];
						else
							print("failed to find controller image for slot", v21);
						end;
					else
						v23.DPad.Visible = false;
						if v1.Killstreaks.KeyBindDisplay.PC[v21] then
							v23:WaitForChild("KeyBind").Text = v1.Killstreaks.KeyBindDisplay.PC[v21];
						else
							print("failed to find keybind for slot", v21);
						end;
					end;
					v23.ImageColor3 = Color3.fromRGB(255, 255, 255);
					v23.Thumbnail.ImageColor3 = Color3.new(1, 1, 1);
					v23.KeyBind.TextColor3 = Color3.new(1, 1, 1);
					v23.Title.TextColor3 = Color3.new(0, 0, 0);
				else
					v23.CountFrame.Visible = false;
					v23.Kills.Visible = true;
					v23.KeyBind.Visible = false;
					v23.DPad.Visible = false;
					v23.ShortcutIcon.Visible = false;
					v23.Kills.Text = v25.interval - v1.Killstreaks.GetKillsOnStreak(v22) % v25.interval;
					v23.ImageColor3 = Color3.fromRGB(75, 75, 75);
					v23.Thumbnail.ImageColor3 = Color3.fromRGB(63, 63, 63);
					v23.KeyBind.TextColor3 = Color3.new(1, 1, 1);
					v23.Title.TextColor3 = Color3.new(1, 1, 1);
				end;
			end;
		end;
	end;
end;
coroutine.wrap(function()
	while true do
		u2();
		wait(0.1);	
	end;
end)();
