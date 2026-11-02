local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
print("hi");
local v3 = require(script.Parent);
local v4 = game["Run Service"];
local l__TweenService__5 = game:GetService("TweenService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__GuiService__7 = game:GetService("GuiService");
local l__MarketplaceService__8 = game:GetService("MarketplaceService");
local v9 = require(game.ReplicatedFirst.GetPlaceId);
local v10 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
local v11 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local v12, v13 = v11();
v3.platform = v12;
v3.controller = v13;
while true do
	wait(0.5);
	if v10.data and v10.data.Settings then
		break;
	end;
end;
local u1 = l__UserInputService__6.GamepadEnabled;
local function v14()
	if v10.data and v10.data ~= nil and v10.data.Settings then
		game.SoundService.Main.Music.Volume = v10.data.Settings.VolumeMusic / 50;
		game.SoundService.MusicLobby.Volume = v10.data.Settings.VolumeMusicLobby / 50;
		local v15, v16 = v11();
		v3.platform = v15;
		v3.controller = v16;
		u1 = l__UserInputService__6.GamepadEnabled;
	end;
end;
v14();
script.Parent:WaitForChild("Music"):Play();
local v17 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("IsEnglish"));
local l__Parent__18 = script.Parent.Parent.Parent;
local l__SideButtons__19 = l__Parent__18:WaitForChild("LobbyFrame"):WaitForChild("SideButtons");
local v20 = {
	store = l__Parent__18:WaitForChild("LobbyFrame"):WaitForChild("Shop"), 
	ach = l__Parent__18:WaitForChild("LobbyFrame"):WaitForChild("Achievements"), 
	voice = l__Parent__18:WaitForChild("LobbyFrame"):WaitForChild("VoiceChat"), 
	set = l__Parent__18:WaitForChild("Settings")
};
local v21 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local v22 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetProductPrice"));
local v23 = require(game:GetService("ReplicatedStorage"):WaitForChild("Products"));
while true do
	wait(0.5);
	if l__Parent__18.LobbyFrame.WarningScreen.Visible == false then
		break;
	end;
end;
l__SideButtons__19.Visible = true;
l__SideButtons__19:TweenPosition(UDim2.new(0, 0, 0.5, 50), "Out", "Quad", 1, true);
pcall(function()
	v10.event.Settings.Event:Connect(v14);
	v14();
end);
function update()
	v14();
	if u1 then
		if v20.store.Visible then
			if v20.store.Frame.Visible then
				l__GuiService__7.SelectedObject = v20.store.Frame.Products.Boost;
			else
				l__GuiService__7.SelectedObject = v20.store.UGC:FindFirstChild("Asset", true);
			end;
		elseif v20.ach.Visible then
			l__GuiService__7.SelectedObject = v20.ach.List;
		elseif v20.set.Visible then
			l__GuiService__7.SelectedObject = v20.set.List.ReduceMotion;
		else
			l__GuiService__7.SelectedObject = nil;
		end;
	else
		l__GuiService__7.SelectedObject = nil;
	end;
	if v20.store.Visible then
		if v10.data then
			if v10.data.PaidInKnobs then
				if 2400 <= v10.data.PaidInKnobs then
					v20.store.Frame.Products.Frame[1].Visible = false;
					v20.store.Frame.Products.Frame[2].Visible = false;
					v20.store.Frame.Products.Frame[3].Visible = false;
					v20.store.Frame.Products.Frame[4].Visible = false;
					v20.store.Frame.Products.Frame[5].Visible = true;
					v20.store.Frame.Products.Frame[6].Visible = true;
					v20.store.Frame.Products.Frame[7].Visible = true;
					v20.store.Frame.Products.Frame.Back.Visible = true;
				end;
			end;
		end;
	end;
end;
local function u2(p1)
	local v24 = false;
	for v25, v26 in pairs(v20) do
		if v26 ~= p1 then
			v26.Visible = false;
		else
			v24 = true;
			v26.Visible = not v26.Visible;
		end;
	end;
	update();
	if not v24 then
		return;
	end;
	return p1.Visible;
end;
l__SideButtons__19.ButtonShop.MouseButton1Down:Connect(function()
	u2(v20.store);
end);
l__SideButtons__19.ButtonAchievements.MouseButton1Down:Connect(function()
	task.wait(0.1);
	u2(v20.ach);
end);
if game:GetService("VoiceChatService"):IsVoiceEnabledForUserIdAsync(l__LocalPlayer__2.UserId) then
	if game.ReplicatedStorage.EntityInfo.IsNotPrivateServer:InvokeServer() or game.PlaceId == v9.LobbyVoice then
		if game.PlaceId == v9.LobbyVoice then
			l__SideButtons__19.ButtonVoiceChat.Name = "Erm...";
			l__SideButtons__19.ButtonVoiceChatAlt.Name = "ButtonVoiceChat";
			v20.voice.VoiceChat.Visible = false;
			v20.voice.Normal.Visible = true;
		else
			v20.voice.VoiceChat.Description.Visible = v17;
			v20.voice.VoiceChat.Warning.Visible = v17;
		end;
	else
		v20.voice.VoiceChat.Visible = false;
		v20.voice.NotEnabled.Visible = true;
	end;
elseif game.PlaceId == v9.LobbyVoice then
	if game.PlaceId == v9.LobbyVoice then
		l__SideButtons__19.ButtonVoiceChat.Name = "Erm...";
		l__SideButtons__19.ButtonVoiceChatAlt.Name = "ButtonVoiceChat";
		v20.voice.VoiceChat.Visible = false;
		v20.voice.Normal.Visible = true;
	else
		v20.voice.VoiceChat.Description.Visible = v17;
		v20.voice.VoiceChat.Warning.Visible = v17;
	end;
else
	v20.voice.VoiceChat.Visible = false;
	v20.voice.NotEnabled.Visible = true;
end;
l__SideButtons__19.ButtonVoiceChat.MouseButton1Down:Connect(function()
	u2(v20.voice);
end);
local function u3()
	local v27 = {};
	for v28, v29 in pairs({
		Sensitivity = 50, 
		VolumeSounds = 50, 
		VolumeMusic = 50, 
		VolumeMusicLobby = 50, 
		ReduceMotion = false, 
		ToggleCrouch = true, 
		ForcePlatform = false, 
		Input = "pc"
	}) do
		local v30 = v20.set:FindFirstChild(v28, true);
		if v30 then
			v27[v28] = v30:GetAttribute("Setting");
		else
			warn("can't find " .. tostring(v28));
		end;
	end;
	game.ReplicatedStorage.EntityInfo:WaitForChild("ChangeSettings"):FireServer(v27);
	u2(v20.set);
end;
l__SideButtons__19.ButtonSettings.MouseButton1Down:Connect(function()
	if v20.set.Visible == true then
		u3();
		return;
	end;
	u2(v20.set);
end);
v20.store.CloseButton.MouseButton1Down:Connect(u2);
v20.voice.CloseButton.MouseButton1Down:Connect(u2);
v20.ach.CloseButton.MouseButton1Down:Connect(u2);
v20.set.CloseButton.MouseButton1Down:Connect(u3);
v20.store.UGCButton.MouseButton1Down:Connect(function()
	v20.store.Frame.Visible = not v20.store.Frame.Visible;
	v20.store.UGC.Visible = not v20.store.Frame.Visible;
	if not v20.store.Frame.Visible then
		local v31 = "BACK";
	else
		v31 = "UGC";
	end;
	v20.store.UGCButton.Text = v31;
	update();
end);
v20.store:WaitForChild("Code"):WaitForChild("Confirm").MouseButton1Down:Connect(function()
	game.ReplicatedStorage.EntityInfo.ShopCode:FireServer(v20.store.Code.Text);
end);
v20.store:WaitForChild("Code").ReturnPressedFromOnScreenKeyboard:Connect(function()
	game.ReplicatedStorage.EntityInfo.ShopCode:FireServer(v20.store.Code.Text);
end);
v20.store:WaitForChild("Code").FocusLost:Connect(function()
	game.ReplicatedStorage.EntityInfo.ShopCode:FireServer(v20.store.Code.Text);
end);
for v32, v33 in v20.store.UGC() do
	if v33:IsA("TextButton") and v33:GetAttribute("ProductID") ~= nil and (v33.Visible or v33:GetAttribute("DoAnyway")) then
		v33.ImageLabel.Image = "rbxthumb://type=Asset&id=" .. v33:GetAttribute("ProductID") .. "&w=420&h=420";
		pcall(function()
			v33.Price.Text = v22(v33:GetAttribute("ProductID"), Enum.InfoType.Asset);
			if v33.Price.Text ~= "0" then
				v33.Price.Visible = true;
			end;
		end);
		v33.MouseButton1Down:Connect(function()
			print("erm");
			l__MarketplaceService__8:PromptPurchase(l__LocalPlayer__2, v33:GetAttribute("ProductID"));
		end);
	end;
end;
for v34, v35 in v20.store.Frame() do
	if v35:IsA("TextButton") then
		if v35:GetAttribute("ProductID") ~= nil and (v35.Visible or v35:GetAttribute("DoAnyway")) then
			v35.Price.Text = v22(v35:GetAttribute("ProductID"));
			v35.MouseButton1Down:Connect(function()
				l__MarketplaceService__8:PromptProductPurchase(l__LocalPlayer__2, v35:GetAttribute("ProductID"));
			end);
		elseif v35:GetAttribute("BuyPremium") then
			v35.MouseButton1Down:Connect(function()
				l__MarketplaceService__8:PromptPremiumPurchase(l__LocalPlayer__2);
			end);
			pcall(function()
				if l__LocalPlayer__2.MembershipType == Enum.MembershipType.Premium then
					v35.Visible = false;
				end;
			end);
		elseif v35:GetAttribute("GoBack") then
			v35.MouseButton1Down:Connect(function()
				v20.store.Frame.Products.Frame[1].Visible = true;
				v20.store.Frame.Products.Frame[2].Visible = true;
				v20.store.Frame.Products.Frame[3].Visible = true;
				v20.store.Frame.Products.Frame[4].Visible = true;
				v20.store.Frame.Products.Frame[5].Visible = false;
				v20.store.Frame.Products.Frame[6].Visible = false;
				v20.store.Frame.Products.Frame[7].Visible = false;
				v20.store.Frame.Products.Frame.Back.Visible = false;
			end);
		end;
	end;
end;
for v36, v37 in v20.voice() do
	if v37:IsA("TextButton") then
		if v37.Name == "Close" then
			v37.MouseButton1Down:Connect(function()
				script.SoundPress:Play();
				u2();
			end);
		elseif v37.Name == "Confirm" then
			v37.MouseButton1Down:Connect(function()
				script.SoundPress:Play();
				game.ReplicatedStorage.EntityInfo.SwitchServers:FireServer();
				l__Parent__18.LobbyFrame.LoadingUI.Visible = true;
				l__TweenService__5:Create(l__Parent__18.LobbyFrame.LoadingUI, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
					BackgroundTransparency = 0, 
					TextTransparency = 0
				}):Play();
				l__TweenService__5:Create(script.Parent.Music, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Volume = 0
				}):Play();
				l__TweenService__5:Create(game.SoundService.Main, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Volume = 0
				}):Play();
				script.Parent.MusicEnd:Play();
				u2();
				wait(15);
				l__TweenService__5:Create(l__Parent__18.LobbyFrame.LoadingUI, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
					BackgroundTransparency = 1, 
					TextTransparency = 1
				}):Play();
				l__TweenService__5:Create(game.SoundService.Main, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Volume = 1
				}):Play();
				wait(0.5);
				l__Parent__18.LobbyFrame.LoadingUI.Visible = false;
				script.Parent.Music:Play();
				script.Parent.Music.Volume = 1;
			end);
		end;
	end;
end;
for v38, v39 in v20.set.List() do
	if v39:IsA("TextButton") then
		if v39.Parent.Name == "Input" then
			local function u4()
				if not v20.set.List.ForcePlatform:GetAttribute("Setting") then
					return;
				end;
				v39.Parent:SetAttribute("Setting", v39.Name);
				for v40, v41 in v39.Parent() do
					if v41:IsA("TextButton") then
						local v42 = {
							BackgroundColor3 = Color3.fromRGB(91, 59, 52)
						};
						local v43 = {
							ImageColor3 = Color3.fromRGB(255, 222, 189)
						};
						if v41 == v39 then
							v42 = {
								BackgroundColor3 = Color3.fromRGB(255, 222, 189)
							};
							v43 = {
								ImageColor3 = Color3.fromRGB(91, 59, 52)
							};
						end;
						local v44 = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
						l__TweenService__5:Create(v41, v44, v42):Play();
						l__TweenService__5:Create(v41.Icon, v44, v43):Play();
					end;
				end;
			end;
			v39.MouseButton1Down:Connect(function()
				script.SoundPress:Play();
				u4();
			end);
			pcall(function()
				if v10.data.Settings.Input == v39.Name then
					u4();
				end;
			end);
		elseif v39:FindFirstChild("Bar") and v39:FindFirstChild("MoveBar") then
			local v45 = v10.data.Settings[v39.Name];
			v39:SetAttribute("Setting", v45);
			local u5 = tick();
			local function v46(p2, p3)
				p2 = math.ceil(math.clamp(p2, 0, 100));
				if u5 + 0.1 <= tick() or p3 then
					v39.Bar.Switch:TweenPosition(UDim2.new(p2 / 100, 0, 0.5, 0), "Out", "Quad", 0.05, true);
					v39.Bar.Bar:TweenSize(UDim2.new(0.01 + p2 / 100, 0, 1, 0), "Out", "Quad", 0.05, true);
				end;
				if v39.Name == "VolumeMusicLobby" then
					game.SoundService.MusicLobby.Volume = p2 / 50;
				end;
				local l__Warning__47 = v39:FindFirstChild("Warning");
				if p2 <= 1 and l__Warning__47 then
					l__Warning__47.Visible = true;
				elseif l__Warning__47 then
					l__Warning__47.Visible = false;
				end;
				if not p3 then
					script.SoundTick.Pitch = 1.5 + p2 / 100;
					script.SoundTick:Play();
				end;
				v39:SetAttribute("Setting", p2);
			end;
			v46(v45, true);
			local l__X__6 = v39.Bar.AbsoluteSize.X;
			v39.MouseButton1Down:Connect(function(p4, p5)
				if v3.controller ~= "console" then
					local v48 = Vector2.new(p4, p5);
					local u7 = false;
					local u8 = nil;
					local u9 = nil;
					u8 = l__UserInputService__6.InputEnded:Connect(function(p6, p7)
						if p6.UserInputType == Enum.UserInputType.MouseButton2 or p6.UserInputType == Enum.UserInputType.MouseButton1 or p6.UserInputType == Enum.UserInputType.Touch then
							v46(math.round(math.clamp(p6.Position.X - v39.Bar.AbsolutePosition.X, 0, l__X__6) / l__X__6 * 100), true);
							u7 = true;
							u8:Disconnect();
							u9:Disconnect();
						end;
					end);
					u9 = l__UserInputService__6.InputChanged:Connect(function(p8, p9)
						if p8.UserInputType == Enum.UserInputType.MouseMovement or p8.UserInputType == Enum.UserInputType.Touch then
							v46((math.round(math.clamp(p8.Position.X - v39.Bar.AbsolutePosition.X, 0, l__X__6) / l__X__6 * 100)));
						end;
					end);
					return;
				end;
				local v49 = tick();
				l__GuiService__7.SelectedObject = v39.Bar.Rungs.Rung5;
				local u10 = false;
				local u11 = nil;
				u11 = l__UserInputService__6.InputBegan:Connect(function(p10, p11)
					if p10.UserInputType.KeyCode == Enum.KeyCode.ButtonA or p10.UserInputType.KeyCode == Enum.KeyCode.ButtonX or p10.UserInputType.KeyCode == Enum.KeyCode.ButtonB then
						u10 = true;
						u11:Disconnect();
					end;
				end);
				for v50 = 1, 1000000 do
					task.wait(0.1);
					if u10 then
						break;
					end;
					if not v20.set.Visible then
						break;
					end;
					if not l__GuiService__7.SelectedObject then
						break;
					end;
					if l__GuiService__7.SelectedObject.Parent ~= v39.Bar.Rungs then
						break;
					end;
					v46(tonumber(string.sub(l__GuiService__7.SelectedObject.Name, 5)) * 10, true);
				end;
			end);
		elseif v39:FindFirstChild("Toggle") then
			v39:SetAttribute("Setting", v10.data.Settings[v39.Name]);
			local function v51(p12)
				if not p12 or p12 ~= true then
					v39:SetAttribute("Setting", not v39:GetAttribute("Setting"));
					if v39:GetAttribute("Setting") then
						local v52 = 1.5;
					else
						v52 = 1;
					end;
					script.SoundClick.Pitch = v52;
					script.SoundClick:Play();
				end;
				local v53 = Color3.fromRGB(121, 86, 74);
				local v54 = 0.9;
				local v55 = UDim2.new(0.2, 0, 0.5, 0);
				if v39:GetAttribute("Setting") then
					v53 = Color3.fromRGB(255, 222, 189);
					v54 = 0.35;
					v55 = UDim2.new(0.8, 0, 0.5, 0);
				end;
				l__TweenService__5:Create(v39.Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					BackgroundTransparency = v54
				}):Play();
				l__TweenService__5:Create(v39.Toggle.Switch, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Position = v55, 
					BackgroundColor3 = v53
				}):Play();
				if v39.Name == "ForcePlatform" then
					if v39:GetAttribute("Setting") then
						local v56 = 1;
					else
						v56 = 0.1;
					end;
					v39.Parent.Input.BackgroundTransparency = v56;
				end;
			end;
			v51(true);
			v39.MouseButton1Down:Connect(v51);
		else
			warn(v39);
		end;
	end;
end;
v20.store.Frame.Products.Frame.Back.MouseButton1Down:Connect(function()
	v20.store.Frame.Products.Frame[1].Visible = true;
	v20.store.Frame.Products.Frame[2].Visible = true;
	v20.store.Frame.Products.Frame[3].Visible = true;
	v20.store.Frame.Products.Frame[4].Visible = true;
	v20.store.Frame.Products.Frame[5].Visible = false;
	v20.store.Frame.Products.Frame[6].Visible = false;
	v20.store.Frame.Products.Frame[7].Visible = false;
	v20.store.Frame.Products.Frame.Back.Visible = false;
end);
local function v57()
	u1 = false;
	if v3.controller == "console" then
		u1 = true;
	end;
	if v3.platform == "console" then
		u1 = true;
	end;
	for v58, v59 in pairs(game:GetService("CollectionService"):GetTagged("XBox")) do
		v59.Visible = u1;
	end;
	l__SideButtons__19.ButtonVoiceChat.Visible = game.ReplicatedStorage.EntityInfo.IsNotPrivateServer:InvokeServer() and v3.platform ~= "console";
	local v60 = true;
	if v3.platform == "console" then
		v60 = v3.controller ~= "console";
	end;
	l__SideButtons__19.ButtonSettings.Visible = v60;
	v20.ach.List.CanvasPosition = Vector2.new(0, 0);
	if u1 then
		v20.ach.List.UIGridLayout.CellSize = UDim2.new(0.07, 0, 0.08, 0);
		v20.ach.List.UIGridLayout.CellPadding = UDim2.new(0.01, 0, 0.01, 0);
		v20.ach.List.ScrollingEnabled = false;
		return;
	end;
	v20.ach.List.UIGridLayout.CellSize = UDim2.new(0.108, 0, 0.125, 0);
	v20.ach.List.UIGridLayout.CellPadding = UDim2.new(0.02, 0, 0.02, 0);
	v20.ach.List.ScrollingEnabled = true;
end;
l__UserInputService__6.GamepadConnected:Connect(v57);
l__UserInputService__6.GamepadDisconnected:Connect(v57);
v57();
local v61, v62 = v11();
local u12 = v62;
local u13 = v61;
l__UserInputService__6.LastInputTypeChanged:Connect(function()
	local v63, v64 = v11();
	v3.platform = v63;
	v3.controller = v64;
	if u12 ~= v3.controller then
		v57();
		local v65, v66 = v11();
		u13 = v65;
		u12 = v66;
	end;
end);
while true do
	wait(0.5);
	if v10.data then
		break;
	end;
end;
for v67, v68 in pairs(v20.ach.List:GetChildren()) do
	if v68:IsA("ImageButton") and v68.Visible then
		v68:Destroy();
	end;
end;
l__UserInputService__6.InputBegan:Connect(function(p13, p14)
	if p13.KeyCode == Enum.KeyCode.ButtonA and v20.ach.Visible then
		game.ReplicatedStorage.EntityInfo.FlexAchievement:FireServer(v20.ach.Frame:GetAttribute("CurrentAchievement"));
		v20.ach.Frame.Applied.Visible = true;
		v20.ach.Frame.Apply.Visible = false;
		for v69 = 1, 3 do
			wait(0.2);
			for v70, v71 in pairs(v20.ach.List:GetChildren()) do
				if v71:IsA("ImageButton") and v71.Visible and v71:GetAttribute("Have") then
					if v10.data.FlexAchievement == v71.Name then
						v71.UIStroke.Color = Color3.fromRGB(255, 248, 174);
						v71.UIStroke.Thickness = 4;
						v71.UIStroke.Enabled = true;
					elseif v71:GetAttribute("Have") == true then
						v71.UIStroke.Enabled = false;
					end;
				end;
			end;
		end;
	end;
	if p13.KeyCode == Enum.KeyCode.ButtonB and p14 ~= true then
		u2();
		return;
	end;
	if p13.KeyCode == Enum.KeyCode.ButtonX then
		update();
		if not l__GuiService__7.SelectedObject then
			l__GuiService__7.SelectedObject = l__SideButtons__19.ButtonShop;
			return;
		end;
	else
		return;
	end;
	print(l__GuiService__7.SelectedObject);
	u2();
	l__GuiService__7.SelectedObject = nil;
end);
function resetAchievements()
	if v10.data then
		local v72, v73, v74 = pairs(v21);
		while true do
			local v75, v76 = v72(v73, v74);
			if v75 then

			else
				break;
			end;
			local v77 = v76:GetInfo();
			local v78 = v20.ach.List.Badge:Clone();
			local v79, v80, v81 = pairs(v77);
			while true do
				local v82, v83 = v79(v80, v81);
				if v82 then

				else
					break;
				end;
				v81 = v82;
				if type(v83) ~= "table" then
					v78:SetAttribute(v82, v83);
				end;			
			end;
			v78.Image = v77.Image;
			v78.Name = v77.Name;
			v78.Parent = v20.ach.List;
			v78.LayoutOrder = 5000 + v77.Category;
			v78.Visible = true;
			if 5 <= v77.Hidden then
				v78.Visible = false;
			end;
			local v84 = false;
			if table.find(v10.data.Achievements, v77.Name) then
				v78.ImageColor3 = Color3.new(1, 1, 1);
				v78.ImageTransparency = 0;
				v78.UIStroke.Enabled = false;
				v78.LayoutOrder = v78.LayoutOrder - 2000;
				v78.Visible = true;
				v77.Hidden = -1;
				v84 = true;
			end;
			if v84 == false then
				if v77.ShowHidden then
					local l__NeedAll__85 = v77.ShowHidden.NeedAll;
					local v86 = false;
					if l__NeedAll__85 == true then
						v86 = true;
					end;
					local v87, v88, v89 = pairs(v77.ShowHidden.Achievements);
					while true do
						local v90, v91 = v87(v88, v89);
						if v90 then

						else
							break;
						end;
						v89 = v90;
						if table.find(v10.data.Achievements, v91) then
							if l__NeedAll__85 ~= true then
								v86 = true;
							end;
						elseif l__NeedAll__85 == true then
							v86 = false;
						end;					
					end;
					if v86 then
						v78.Visible = true;
						v78.LayoutOrder = v78.LayoutOrder - 1000;
						v78.ImageColor3 = Color3.new(0.9, 0.8, 0.8);
						v78.ImageTransparency = 0.4;
						v78.UIStroke.Color = Color3.fromRGB(188, 124, 111);
						v77.Hidden = 0;
					end;
				end;
			end;
			v78:SetAttribute("Have", v84);
			local function v92(p15)
				v20.ach.Frame:SetAttribute("CurrentAchievement", v77.Name);
				v20.ach.Frame.Title.Text = v77.Hidden < 3 and v77.Title or "Locked Achievement";
				v20.ach.Frame.Desc.Text = v77.Hidden < 2 and v77.Desc or "Unlock this achievement to view its description!";
				v20.ach.Frame.Reason.Text = v77.Hidden < 1 and v77.Reason or "";
				v20.ach.Frame.ImageLabel.Image = v77.Image;
				if v84 then
					v20.ach.Frame.Applied.Visible = v10.data.FlexAchievement == v77.Name;
					v20.ach.Frame.Apply.Visible = not v20.ach.Frame.Applied.Visible;
				else
					v20.ach.Frame.Apply.Visible = false;
					v20.ach.Frame.Applied.Visible = false;
				end;
				v20.ach.Frame.Visible = true;
			end;
			v78.MouseButton1Down:Connect(v92);
			v78.SelectionGained:Connect(v92);		
		end;
		v20.ach.Frame.Apply.MouseButton1Down:Connect(function()
			game.ReplicatedStorage.EntityInfo.FlexAchievement:FireServer(v20.ach.Frame:GetAttribute("CurrentAchievement"));
			v20.ach.Frame.Applied.Visible = true;
			v20.ach.Frame.Apply.Visible = false;
			local v93 = 1 - 1;
			while true do
				wait(0.2);
				local v94, v95, v96 = pairs(v20.ach.List:GetChildren());
				while true do
					local v97, v98 = v94(v95, v96);
					if v97 then

					else
						break;
					end;
					v96 = v97;
					if v98:IsA("ImageButton") then
						if v98.Visible then
							if v98:GetAttribute("Have") then
								if v10.data.FlexAchievement == v98.Name then
									v98.UIStroke.Color = Color3.fromRGB(255, 248, 174);
									v98.UIStroke.Thickness = 4;
									v98.UIStroke.Enabled = true;
								elseif v98:GetAttribute("Have") == true then
									v98.UIStroke.Enabled = false;
								end;
							end;
						end;
					end;				
				end;
				if 0 <= 1 then
					if v93 < 3 then

					else
						break;
					end;
				elseif 3 < v93 then

				else
					break;
				end;
				v93 = v93 + 1;			
			end;
		end);
	end;
end;
resetAchievements();
