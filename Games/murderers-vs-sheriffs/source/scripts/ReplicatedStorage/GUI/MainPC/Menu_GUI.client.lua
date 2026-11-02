local l_Game_0 = script.Parent:WaitForChild("Game");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v2 = true;
if game.PlaceId ~= 5895823254 then
	v2 = game.PlaceId == 5928494131;
end;
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_CurrentRoundClient_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CurrentRoundClient"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Attribute_0 = game.Players.LocalPlayer.PlayerGui:GetAttribute("Device");
local v7 = true;
if l_Attribute_0 ~= "Tablet" then
	v7 = l_Attribute_0 == "Phone";
end;
local v8 = l_Attribute_0 == "Tablet" and l_Game_0:WaitForChild("TabletLevel") or l_Game_0:WaitForChild("Level");
local l_LevelModule_0 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("LevelModule"));
local l_FadeModule_0 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("FadeModule"));
local l_EarnedXP_0 = l_Game_0:WaitForChild("EarnedXP");
local v12 = nil;
local v13 = nil;
local v14 = nil;
local v15 = nil;
local v16 = nil;
local v17 = true;
local v18 = 900;
comma_value = function(v19) --[[ Line: 28 ]] --[[ Name: comma_value ]]
	local l_v19_0 = v19;
	repeat
		local v21, v22 = string.gsub(l_v19_0, "^(-?%d+)(%d%d%d)", "%1,%2");
		k = v22;
		l_v19_0 = v21;
	until k == 0;
	return l_v19_0;
end;
local function _(v23) --[[ Line: 39 ]] --[[ Name: GetTimeText ]]
	local v24 = math.floor(v23 / 60);
	local v25 = v23 - v24 * 60;
	return (v24 > 0 and v24 .. "m " or "") .. v25 .. "s";
end;
UpdateLevel = function() --[[ Line: 48 ]] --[[ Name: UpdateLevel ]]
	-- upvalues: l_ProfileData_0 (copy), v8 (copy), l_LevelModule_0 (copy)
	local l_NewXP_0 = l_ProfileData_0.NewXP;
	local l_XP_0 = v8:WaitForChild("XPBar").XP;
	v8.LevelText.Text = l_LevelModule_0.GetLevel(l_NewXP_0);
	local v29 = l_LevelModule_0.GetProgressToNextLevel(l_NewXP_0);
	l_XP_0.Size = UDim2.new(v29, l_XP_0.Size.X.Offset, l_XP_0.Size.Y.Scale, l_XP_0.Size.Y.Offset);
	if l_LevelModule_0.GetLevel(l_NewXP_0) >= 100 then
		v8.Prestige.Visible = true;
		return;
	else
		v8.Prestige.Visible = false;
		return;
	end;
end;
UpdateCash = function() --[[ Line: 62 ]] --[[ Name: UpdateCash ]]
	-- upvalues: l_ProfileData_0 (copy), l_Game_0 (copy)
	local l_Coins_0 = l_ProfileData_0.Coins;
	local l_Gems_0 = l_ProfileData_0.Gems;
	l_Game_0.Shop.Title.Coins.Container.Amount.Text = comma_value((math.floor(l_Coins_0)));
	l_Game_0.Shop.Title.Gems.Container.Amount.Text = comma_value(l_Gems_0);
end;
local function v33() --[[ Line: 70 ]] --[[ Name: onPrestigeButtonClicked ]]
	-- upvalues: l_ProfileData_0 (copy), l_LevelModule_0 (copy), l_Game_0 (copy)
	local l_NewXP_1 = l_ProfileData_0.NewXP;
	if l_LevelModule_0.GetLevel(l_NewXP_1) < 100 then
		return;
	else
		l_Game_0.Prestige.Visible = true;
		return;
	end;
end;
local function v34() --[[ Line: 78 ]] --[[ Name: onPrestigeCancelled ]]
	-- upvalues: l_Game_0 (copy)
	l_Game_0.Prestige.Visible = false;
end;
local function v36() --[[ Line: 82 ]] --[[ Name: onPrestigeAccepted ]]
	-- upvalues: l_Game_0 (copy), l_LocalPlayer_0 (copy)
	game.ReplicatedStorage.Remotes.Inventory.Prestige:FireServer();
	l_Game_0.Prestige.Visible = false;
	UpdateLevel();
	local v35 = l_LocalPlayer_0:GetAttribute("Prestige") or 0;
	l_LocalPlayer_0:SetAttribute("Prestige", v35 + 1);
end;
local function v39(v37) --[[ Line: 90 ]] --[[ Name: onBackpackChildAdded ]]
	-- upvalues: l_CurrentRoundClient_0 (copy), l_LocalPlayer_0 (copy), v13 (ref), l_EarnedXP_0 (copy), l_Game_0 (copy)
	if not v37:FindFirstChild("IsGun") then
		return;
	else
		local v38 = l_CurrentRoundClient_0.GetLatestPlayerData();
		if v38[l_LocalPlayer_0.Name] ~= nil and v38[l_LocalPlayer_0.Name].Role == "Hero" then
			v13 = "Hero";
			l_EarnedXP_0.Visible = false;
			l_Game_0.Timer.Visible = true;
		end;
		return;
	end;
end;
local function v40() --[[ Line: 103 ]] --[[ Name: onDataUpdated ]]
	UpdateCash();
	UpdateLevel();
end;
local function v43(v41, v42) --[[ Line: 108 ]] --[[ Name: onRoundStart ]]
	-- upvalues: v2 (copy), v18 (ref), l_LocalPlayer_0 (copy), v14 (ref), v16 (ref), v15 (ref), v13 (ref), v12 (ref), l_EarnedXP_0 (copy), l_Game_0 (copy)
	if v2 then
		return;
	else
		v18 = v41 * 5;
		if v42[l_LocalPlayer_0.Name] ~= nil and v42[l_LocalPlayer_0.Name].Dead == false then
			v14 = time();
			v16 = v41;
			if v42[l_LocalPlayer_0.Name].Role == "Innocent" then
				v15 = 0;
				v13 = "Innocent";
				v12 = true;
				l_EarnedXP_0.XPText.Text = 0;
				l_EarnedXP_0.Visible = true;
				return;
			else
				v12 = true;
				if not v2 then
					l_Game_0.Timer.Visible = true;
					l_Game_0.RoleSelector.Visible = false;
				end;
			end;
		end;
		return;
	end;
end;
local function onRoundTimeUpdated(newTime)
	newTime = tonumber(newTime)
	if not newTime or v14 == nil then
		return
	end
	v14 = time()
	v16 = math.max(0, math.floor(newTime))
	v18 = v16 * 5
	if not v2 then
		l_Game_0.Timer.Visible = true
	end
end;
local function v44() --[[ Line: 141 ]] --[[ Name: onVictoryScreenShown ]]
	-- upvalues: v13 (ref), v14 (ref)
	v13 = nil;
	v14 = nil;
end;
local function v45() --[[ Line: 146 ]] --[[ Name: onDockToggled ]]
	-- upvalues: v17 (ref), l_Game_0 (copy)
	v17 = not v17;
	l_Game_0.Dock.Touch.Title.Text = v17 and "<" or ">";
	l_Game_0.Dock:TweenPosition(UDim2.new(0, v17 and 0 or -135, 0.5, -150), "Out", "Quad", 0.2, true);
end;
game.ReplicatedStorage.Remotes.Gameplay.SpecialXPEvent.OnClientEvent:connect(function(Text)
	local XPText = script.XPText:Clone();
	XPText.Text = Text;
	XPText.Parent = l_Game_0;
	XPText.Visible = true
	game.Debris:AddItem(XPText,4);
end)
l_Game_0:WaitForChild("Dock"):WaitForChild("Shop").Activated:Connect(function() --[[ Line: 63 ]]
	-- upvalues: l_WindowService_0 (copy)
	l_WindowService_0:ToggleFrame("Shop");
end);
local function v46() --[[ Line: 155 ]] --[[ Name: onDied ]]
	-- upvalues: l_FadeModule_0 (copy), l_EarnedXP_0 (copy), v12 (ref)
	l_FadeModule_0.DeathFlash();
	l_EarnedXP_0.XPText.TextColor3 = BrickColor.new("Medium stone grey").Color;
	l_EarnedXP_0.VictoryLabel.TextColor3 = BrickColor.new("Medium stone grey").Color;
	v12 = false;
end;
local function v54(_) --[[ Line: 164 ]] --[[ Name: onUpdate ]]
	-- upvalues: v14 (ref), l_Game_0 (copy), v2 (copy), v16 (ref), v13 (ref), v18 (ref), l_EarnedXP_0 (copy)
	if v14 == nil then
		l_Game_0.Timer.Visible = false;
		return;
	elseif v2 then
		return;
	else
		local v48 = math.floor(time() - v14);
		local v49 = v16 - v48;
		if v13 == "Innocent" then
			local v50 = v48 * 5;
			if v18 <= v50 then
				l_EarnedXP_0.XPText.Text = v18;
				l_EarnedXP_0.VictoryLabel.Text = "Game Over!";
				l_EarnedXP_0.XPText.TextColor3 = Color3.new(0, 1, 0);
				return;
			else
				l_EarnedXP_0.XPText.Text = v50;
				return;
			end;
		else
			if v49 > 0 then
				local l_XPText_0 = l_Game_0.Timer.XPText;
				local v52 = math.floor(v49 / 60);
				local v53 = v49 - v52 * 60;
				l_XPText_0.Text = (v52 > 0 and v52 .. "m " or "") .. v53 .. "s";
				if v49 <= 30 then
					l_Game_0.Timer.XPText.TextColor3 = Color3.new(255, 0, 0);
					return;
				end;
			else
				l_Game_0.Timer.XPText.Text = "Game Over!";
				l_Game_0.Timer.XPText.TextColor3 = Color3.new(1, 1, 1);
			end;
			return;
		end;
	end;
end;
(function() --[[ Line: 193 ]] --[[ Name: Initialize ]]
	_G.LockTarget = nil;
	l_LocalPlayer_0.CameraMode = Enum.CameraMode.Classic;
	UpdateCash();
	UpdateLevel();
	game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("VictoryScreen").OnClientEvent:Connect(v44);
	game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoundStart").OnClientEvent:Connect(v43);
	game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoundTimeUpdated").OnClientEvent:Connect(onRoundTimeUpdated);
	l_Remotes_0:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v55, _) --[[ Line: 204 ]]
		if v55 == "NewXP" then
			UpdateLevel();
			return;
		else
			if v55 == "Coins" or v55 == "Gems" then
				UpdateCash();
			end;
			return;
		end;
	end);
	game.ReplicatedStorage:WaitForChild("UpdateData2").OnClientEvent:Connect(v40);
	l_LocalPlayer_0:WaitForChild("Backpack").ChildAdded:Connect(v39);
	game:GetService("RunService").PreSimulation:Connect(v54);
	l_Game_0.Leaderboard.Inspect.Container.Prestige.Activated:Connect(v33);
	l_Game_0.Prestige.Accept.Activated:Connect(v36);
	l_Game_0.Prestige.Decline.Activated:Connect(v34);
	l_Game_0.Dock.Touch.Visible = game:GetService("UserInputService").TouchEnabled;
	l_Game_0.Dock.Touch.Button.Activated:Connect(v45);
	repeat
		task.wait();
	until l_LocalPlayer_0.Character ~= nil;
	task.wait();
	l_LocalPlayer_0.CameraMode = "Classic";
	l_LocalPlayer_0.CameraMinZoomDistance = 7;
	task.wait(0.5);
	l_LocalPlayer_0.CameraMinZoomDistance = 0.5;
	game.StarterGui:SetCoreGuiEnabled("Health", false);
	game.StarterGui:SetCoreGuiEnabled("PlayerList", false);
	local v57 = nil;
	repeat
		task.wait();
		v57 = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid");
	until v57 ~= nil;
	v57.Died:Connect(v46);
	local l_PlaceVersion_0 = game.PlaceVersion;
	l_Game_0.Dock.Version.Text = l_PlaceVersion_0;
end)();