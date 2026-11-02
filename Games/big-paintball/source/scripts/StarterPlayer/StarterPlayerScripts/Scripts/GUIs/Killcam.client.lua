-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = v1.Player.Get();
local v4 = require(v1.Player.Get("Player"):WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetCameras();
local u1 = v1.Player.Get("Camera");
local l__Killcam__2 = v1.GUI.Killcam;
local l__Crosshair__3 = v1.GUI.Crosshair;
local u4 = {};
local u5 = nil;
local v8
local function u6(p1, p2)
	local v5 = tick();
	local v6 = v1.Save.Get(p1);
	if not v6 then
		return;
	end;
	if not p1 then
		v1.Print("No killer found");
		return;
	end;
	local l__CFrame__7 = u1.CFrame;
	if p2 and p2.PrimaryPart ~= nil and p2.PrimaryPart.Position ~= nil then
		local v8 = p2.PrimaryPart.Position;
		if not v8 then
			if p1.Character and p1.Character:FindFirstChild("HumanoidRootPart") then
				v8 = p1.Character:FindFirstChild("HumanoidRootPart").Position or Vector3.new(0, 0, 0);
			else
				v8 = Vector3.new(0, 0, 0);
			end;
		end;
	elseif p1.Character and p1.Character:FindFirstChild("HumanoidRootPart") then
		v8 = p1.Character:FindFirstChild("HumanoidRootPart").Position or Vector3.new(0, 0, 0);
	else
		v8 = Vector3.new(0, 0, 0);
	end;
	local l__magnitude__9 = (l__CFrame__7.p - v8).magnitude;
	local l__EquippedGun__10 = v1.Entity.Get(p1).EquippedGun;
	if not l__EquippedGun__10 then
		v1.Print("Failed to properly render equipped gun, couldn't find it!");
	end;
	u1.CameraType = Enum.CameraType.Scriptable;
	v1.Functions.FastTween(u1, {
		FieldOfView = 30
	}, { 0.75, "Quad", "Out" });
	v1.UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
	v1.UserInputService.MouseIconEnabled = true;
	l__Killcam__2.Gui.Enabled = true;
	l__Crosshair__3.Gui.Enabled = false;
	v1.GUI.Killstreaks.Gui.Enabled = false;
	v1.GUI.Feed.Gui.Enabled = false;
	v1.GUIFX.BubbleScale(l__Killcam__2.Frame);
	v1.GUIFX.BubbleScale(l__Killcam__2.Frame.Info.Skip);
	l__Killcam__2.Frame.Info.Username.Text = p1.DisplayName .. "!";
	l__Killcam__2.Frame.Info.Level.Text = "Level " .. v6.Level;
	if v6.CareerKills then
		l__Killcam__2.Frame.Info.CareerKills.Text = tostring(v6.CareerKills + 1) .. " Career Tags";
	end;
	l__Killcam__2.Frame.Info.GunIcon.Image = v1.Directory.Guns[l__EquippedGun__10].thumbnail;
	if not v1.Variables.Mobile and not v1.Variables.Console then
		l__Killcam__2.Frame.Info.Skip.KeyHint.Visible = true;
	else
		l__Killcam__2.Frame.Info.Skip.KeyHint.Visible = false;
	end;
	local v11 = p1.Character:GetChildren();
	if game.Workspace:WaitForChild("__DEBRIS"):FindFirstChild("Guns") then
		for v12, v13 in pairs(game.Workspace:WaitForChild("__DEBRIS"):FindFirstChild("Guns"):GetChildren()) do
			table.insert(v11, v13);
		end;
	end;
	if game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Drones") then
		for v14, v15 in pairs(game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Drones"):GetChildren()) do
			table.insert(v11, v15);
		end;
	end;
	if game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Sentries") then
		for v16, v17 in pairs(game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Sentries"):GetChildren()) do
			table.insert(v11, v17);
		end;
	end;
	if game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Armored Sentries") then
		for v18, v19 in pairs(game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Armored Sentries"):GetChildren()) do
			table.insert(v11, v19);
		end;
	end;
	if game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Mini Sentries") then
		for v20, v21 in pairs(game.Workspace:WaitForChild("__THINGS"):FindFirstChild("Mini Sentries"):GetChildren()) do
			table.insert(v11, v21);
		end;
	end;
	local u7 = false;
	local u8 = tick();
	local u9 = p1.Character.HumanoidRootPart.Position;
	v1.RunService:BindToRenderStep("Zombie Check", Enum.RenderPriority.Camera.Value, function(p3)
		if u7 then
			return;
		end;
		if tick() - u8 <= 0.1 then
			return;
		end;
		u8 = tick();
		if not p1 or not p1.Character or not p1.Character:FindFirstChild("Humanoid") then
			return;
		end;
		if p1.Character.Humanoid.Health > 0 then
			if p2 then
				return;
			end;
		else
			u7 = true;
			return;
		end;
		u9 = p1.Character.HumanoidRootPart.Position;
	end);
	local v22 = tick();
	local l__Skip__23 = l__Killcam__2.Frame.Info.Skip;
	local l__Size__24 = l__Skip__23.Size;
	v1.Functions.ControllerSelect(l__Skip__23);
	local u10 = v11;
	v1.RunService:BindToRenderStep("Update Killcam", Enum.RenderPriority.Camera.Value, function(p4)
		if p1 and p1.Parent == game.Players and p1.Character and p1.Character:FindFirstChild("HumanoidRootPart") then
			local v25 = p2 and p2.PrimaryPart ~= nil and p2.PrimaryPart.Position ~= nil and p2.PrimaryPart.Position or (u9 and u9 or Vector3.new(0, 0, 0));
			local v26 = CFrame.Angles(math.rad(math.cos(tick() * 2) / 8 * 25), 0, 0);
			u1.CFrame = u1.CFrame:Lerp(CFrame.new(l__CFrame__7.p:Lerp(v25, 0.5), v25), v1.Functions.Easing(p4 / 3, "Elastic", "Out"));
			local v27 = u1:GetPartsObscuringTarget({ v25, v25 + Vector3.new(2, 0, 0), v25 + Vector3.new(-2, 0, 0), v25 + Vector3.new(0, 0, 2), v25 + Vector3.new(0, 0, -2) }, u10);
			for v28, v29 in pairs(u4) do
				if v28 and v29 then
					local v30 = false;
					for v31, v32 in pairs(v27) do
						if v31 == v28 then
							v30 = true;
						end;
					end;
					if not v30 then
						v28.LocalTransparencyModifier = 0;
					end;
				end;
			end;
			for v33, v34 in pairs(v27) do
				v34.LocalTransparencyModifier = 0.75;
				if not u4[v34] then
					u4[v34] = true;
				end;
			end;
		end;
	end);
	local v35 = {};
	local u11 = {};
	function v35.Disconnect()
		u10 = {};
		for v36, v37 in pairs(u11) do
			if v37.Disconnect then
				v37:Disconnect();
			end;
		end;
	end;
	return v35;
end;
v1.Network.Fired("Do Killcam"):Connect(function(p5, p6)
	u5 = u6(p5, p6);
end);
local u12 = false;
l__Killcam__2.Frame.Info.Skip.Activated:Connect(function()
	if u12 then
		return;
	end;
	u12 = true;
	v1.Network.Fire("Do Respawn");
	wait(1);
	u12 = false;
end);
v1.UserInputService.InputEnded:Connect(function(p7, p8)
	if p8 then
		return;
	end;
	if not l__Killcam__2.Gui.Enabled or v1.Variables.Typing then
		return;
	end;
	if p7.KeyCode == Enum.KeyCode.Space then
		if u12 then
			return;
		end;
		u12 = true;
		v1.Network.Fire("Do Respawn");
		wait(1);
		u12 = false;
	end;
end);
local function u13(p9)
	if u5 then
		u5:Disconnect();
		u5 = nil;
	end;
	u1.FieldOfView = 70;
	for v38, v39 in pairs(u4) do
		if v38 and v39 then
			v38.LocalTransparencyModifier = 0;
		end;
	end;
	u4 = {};
	pcall(function()
		v1.RunService:UnbindFromRenderStep("Update Killcam");
		v1.RunService:UnbindFromRenderStep("Zombie Check");
	end);
	l__Killcam__2.Gui.Enabled = false;
	u1.CameraType = Enum.CameraType.Custom;
	u1.CameraSubject = p9:WaitForChild("Humanoid");
end;
v3.CharacterAdded:Connect(function(p10)
	if u5 then
		u13(p10);
	end;
end);
v1.GUIFX.HyperInput(l__Killcam__2.Frame.Info.Skip, false, l__Killcam__2.Gui);
