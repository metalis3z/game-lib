local v1 = script:FindFirstAncestor("MainUI");
local l__Parent__2 = script.Parent.Parent.Parent;
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local v4 = require(script.Parent);
local v5 = game["Run Service"];
local l__TweenService__6 = game:GetService("TweenService");
local l__UserInputService__7 = game:GetService("UserInputService");
local l__GuiService__8 = game:GetService("GuiService");
local v9 = require(game.ReplicatedFirst.GetPlaceId);
local v10 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
local v11 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local v12, v13 = v11();
v4.platform = v12;
v4.controller = v13;
local u1 = l__UserInputService__7.GamepadEnabled;
local v16 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("IsEnglish"));
local v17 = {
	set = l__Parent__2:WaitForChild("Settings")
};
local function u2()
	if v10.data then
		pcall(function()
			game.SoundService.Main.Music.Volume = v10.data.Settings.VolumeMusic / 50;
			game.SoundService.MusicLobby.Volume = v10.data.Settings.VolumeMusicLobby / 50;
			local v18, v19 = v11();
			v4.platform = v18;
			v4.controller = v19;
			u1 = v4.controller == "console";
		end);
	end;
end;
pcall(function()
	v10.event.Settings.Event:Connect(u2);
	if v10.data then
		pcall(function()
			game.SoundService.Main.Music.Volume = v10.data.Settings.VolumeMusic / 50;
			game.SoundService.MusicLobby.Volume = v10.data.Settings.VolumeMusicLobby / 50;
			local v20, v21 = v11();
			v4.platform = v20;
			v4.controller = v21;
			u1 = v4.controller == "console";
		end);
	end;
end);
function update()
	if v10.data then
		pcall(function()
			game.SoundService.Main.Music.Volume = v10.data.Settings.VolumeMusic / 50;
			game.SoundService.MusicLobby.Volume = v10.data.Settings.VolumeMusicLobby / 50;
			local v22, v23 = v11();
			v4.platform = v22;
			v4.controller = v23;
			u1 = v4.controller == "console";
		end);
	end;
	if u1 then

	else
		l__GuiService__8.SelectedObject = nil;
		return;
	end;
	if v17.set.Visible then

	else
		l__GuiService__8.SelectedObject = nil;
		return;
	end;
	l__GuiService__8.SelectedObject = v17.set.List.ReduceMotion;
	--v4.update() -- new
end;
local function u3(p1)
	local v24 = false;
	for v25, v26 in pairs(v17) do
		if v26 ~= p1 then
			v26.Visible = false;
		else
			v24 = true;
			v26.Visible = not v26.Visible;
		end;
	end;
	if not v24 then
		update();
		
		return;
	end;
	return p1.Visible;
end;
local function v27()
	local v28 = {};
	for v29, v30 in pairs({
		Sensitivity = 50, 
		VolumeMusic = 50, 
		VolumeMusicLobby = 50, 
		ReduceMotion = false, 
		ToggleCrouch = true, 
		ForcePlatform = false, 
		Input = v11()
	}) do
		local v31 = v17.set:FindFirstChild(v29, true);
		if v31 then
			v28[v29] = v31:GetAttribute("Setting");
		else
			warn("can't find " .. tostring(v29));
		end;
	end;
	game.ReplicatedStorage.EntityInfo:WaitForChild("ChangeSettings"):FireServer(v28);
	u3();
end;
v17.set.CloseButton.MouseButton1Down:Connect(v27);
for v32, v33 in (v17.set.List:GetDescendants()) do
	if v33:IsA("TextButton") then
		if v33.Parent.Name == "Input" then
			local function u4()
				if not v17.set.List.ForcePlatform:GetAttribute("Setting") then
					return;
				end;
				v33.Parent:SetAttribute("Setting", v33.Name);
				for v34, v35 in (v17.set.List.Input:GetChildren()) do -- error: for v34, v35 in v33.Parent() do 
					if v35:IsA("TextButton") then
						local v36 = {
							BackgroundColor3 = Color3.fromRGB(91, 59, 52)
						};
						local v37 = {
							ImageColor3 = Color3.fromRGB(255, 222, 189)
						};
						if v35 == v33 then
							v36 = {
								BackgroundColor3 = Color3.fromRGB(255, 222, 189)
							};
							v37 = {
								ImageColor3 = Color3.fromRGB(91, 59, 52)
							};
						end;
						local v38 = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
						l__TweenService__6:Create(v35, v38, v36):Play();
						l__TweenService__6:Create(v35.Icon, v38, v37):Play();
					end;
				end;
			end;
			v33.MouseButton1Down:Connect(function()
				script.SoundPress:Play();
				u4();
			end);
			pcall(function()
				if v10.data.Settings.Input == v33.Name then
					u4();
				end;
			end);
		elseif v33:FindFirstChild("Bar") and v33:FindFirstChild("MoveBar") then
			local v39 = v10.data.Settings[v33.Name];
			v33:SetAttribute("Setting", v39);
			local u5 = tick();
			local function v40(p2, p3)
				if p2 and p2 ~= nil then
					p2 = math.ceil(math.clamp(p2, 0, 100));
					if u5 + 0.1 <= tick() or p3 then
						v33.Bar.Switch:TweenPosition(UDim2.new(p2 / 100, 0, 0.5, 0), "Out", "Quad", 0.05, true);
						v33.Bar.Bar:TweenSize(UDim2.new(0.01 + p2 / 100, 0, 1, 0), "Out", "Quad", 0.05, true);
					end;
					if v33.Name == "VolumeMusicLobby" then
						game.SoundService.MusicLobby.Volume = p2 / 50;
					end;
					local l__Warning__41 = v33:FindFirstChild("Warning");
					if p2 <= 1 and l__Warning__41 then
						l__Warning__41.Visible = true;
					elseif l__Warning__41 then
						l__Warning__41.Visible = false;
					end;
					if not p3 then
						script.SoundTick.Pitch = 1.5 + p2 / 100;
						script.SoundTick:Play();
					end;
					v33:SetAttribute("Setting", p2);
				end;
			end;
			v40(v39, true);
			local l__X__6 = v33.Bar.AbsoluteSize.X;
			v33.MouseButton1Down:Connect(function(p4, p5)
				if v4.controller ~= "console" then
					local v42 = Vector2.new(p4, p5);
					local u7 = false;
					local u8 = nil;
					local u9 = nil;
					u8 = l__UserInputService__7.InputEnded:Connect(function(p6, p7)
						if p6.UserInputType == Enum.UserInputType.MouseButton2 or p6.UserInputType == Enum.UserInputType.MouseButton1 or p6.UserInputType == Enum.UserInputType.Touch then
							v40(math.round(math.clamp(p6.Position.X - v33.Bar.AbsolutePosition.X, 0, l__X__6) / l__X__6 * 100), true);
							u7 = true;
							u8:Disconnect();
							u9:Disconnect();
						end;
					end);
					u9 = l__UserInputService__7.InputChanged:Connect(function(p8, p9)
						if p8.UserInputType == Enum.UserInputType.MouseMovement or p8.UserInputType == Enum.UserInputType.Touch then
							v40((math.round(math.clamp(p8.Position.X - v33.Bar.AbsolutePosition.X, 0, l__X__6) / l__X__6 * 100)));
						end;
					end);
					return;
				end;
				local v43 = tick();
				l__GuiService__8.SelectedObject = v33.Bar.Rungs.Rung5;
				wait(0.1);
				local u10 = false;
				local u11 = nil;
				u11 = l__UserInputService__7.InputBegan:Connect(function(p10, p11)
					if p10.KeyCode == Enum.KeyCode.ButtonA or p10.KeyCode == Enum.KeyCode.ButtonX or p10.KeyCode == Enum.KeyCode.ButtonB then
						u10 = true;
						u11:Disconnect();
					end;
				end);
				for v44 = 1, 1000000 do
					task.wait(0.1);
					print("looking");
					if u10 then
						break;
					end;
					if not v17.set.Visible then
						break;
					end;
					if not l__GuiService__8.SelectedObject then
						break;
					end;
					if l__GuiService__8.SelectedObject.Parent ~= v33.Bar.Rungs then
						break;
					end;
					v40(tonumber(string.sub(l__GuiService__8.SelectedObject.Name, 5)) * 10, true);
				end;
			end);
		elseif v33:FindFirstChild("Toggle") then
			v33:SetAttribute("Setting", v10.data.Settings[v33.Name]);
			local function v45(p12)
				if not p12 or p12 ~= true then
					local v46
					v33:SetAttribute("Setting", not v33:GetAttribute("Setting"));
					if v33:GetAttribute("Setting") then
						v46 = 1.5;
					else
						v46 = 1;
					end;
					script.SoundClick.Pitch = v46;
					script.SoundClick:Play();
				end;
				local v47 = Color3.fromRGB(121, 86, 74);
				local v48 = 0.9;
				local v49 = UDim2.new(0.2, 0, 0.5, 0);
				if v33:GetAttribute("Setting") then
					v47 = Color3.fromRGB(255, 222, 189);
					v48 = 0.35;
					v49 = UDim2.new(0.8, 0, 0.5, 0);
				end;
				l__TweenService__6:Create(v33.Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					BackgroundTransparency = v48
				}):Play();
				l__TweenService__6:Create(v33.Toggle.Switch, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Position = v49, 
					BackgroundColor3 = v47
				}):Play();
				if v33.Name == "ForcePlatform" then
					local v50
					if v33:GetAttribute("Setting") then
						v50 = 1;
					else
						v50 = 0.1;
					end;
					v33.Parent.Input.BackgroundTransparency = v50;
				end;
			end;
			v45(true);
			v33.MouseButton1Down:Connect(v45);
		else
			warn(v33);
		end;
	end;
end;
l__UserInputService__7.InputBegan:Connect(function(p13, p14)
	if l__Parent__2.ItemShop.Visible then
		return;
	end;
	if v4.dead then
		return;
	end;
	if l__Parent__2.Statistics.Visible then
		return;
	end;
	if p13.KeyCode == Enum.KeyCode.ButtonB and v17.set.Visible then
		update();
		v27();
	end;
	if (p13.KeyCode == Enum.KeyCode.Tab or p13.KeyCode == Enum.KeyCode.M) and not p14 or p13.KeyCode == Enum.KeyCode.ButtonSelect then
		if v17.set.Visible then
			v27();
			v17.set.Visible = false;
			update();
			return;
		end;
		v17.set.Visible = true;
		update();
	end;
end);
local l__SettingsButton__51 = l__Parent__2:WaitForChild("SettingsButton");
l__SettingsButton__51.MouseButton1Down:Connect(function()
	if not v17.set.Visible then
		v17.set.Visible = true;
		update();
		return;
	end;
	v27();
	v17.set.Visible = false;
	update();
end);
if l__UserInputService__7.TouchEnabled then
	l__SettingsButton__51.Visible = true;
end;
for v52 = 1, 100000 do
	wait(5);
	if v4.dead then
		l__SettingsButton__51.Visible = true;
	end;
end;
