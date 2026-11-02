local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local v2 = require(script.Parent.ItemModule);
local v3 = require(script.Parent.LevelModule);
local v4 = require(script.Parent.XboxModule);
v0.Commafy = function(v5) --[[ Line: 8 ]]
	local l_v5_0 = v5;
	repeat
		local v7, v8 = string.gsub(l_v5_0, "^(-?%d+)(%d%d%d)", "%1,%2");
		k = v8;
		l_v5_0 = v7;	
	until k == 0;
	return l_v5_0;
end;
local l_TweenService_0 = game:GetService("TweenService");
local v10 = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local v11 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local _ = function(v12) --[[ Line: 41 ]] --[[ Name: PlayTweens ]]
	for _, v14 in pairs(v12) do
		v14:Play();
	end;
end;
local v16 = {
	VersusFrame = true, 
	Title = true, 
	LevelUp = false
};
local _ = Color3.fromRGB(125, 125, 125);
local v18 = {
	Sheriff = "Hero", 
	Hero = "Sheriff"
};
local function v23(v19) --[[ Line: 78 ]] --[[ Name: GetCharacterIcon ]]
	local v20 = _G.PlayerIcons[v19];
	if v20 == nil then
		print("No Player Image: " .. tostring(v19));
		local l_FirstChild_0 = game.Players:FindFirstChild(v19);
		local v22 = l_FirstChild_0 and l_FirstChild_0.userId or 0;
		v20 = game.Players:GetUserThumbnailAsync(math.abs(v22), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352);
	end;
	return v20;
end;
v0.DisplayScoreboard = function(v24) --[[ Line: 93 ]]
	local v25 = true;
	if game.Players.LocalPlayer.PlayerGui:GetAttribute("Device") ~= "Phone" then
		v25 = game.Players.LocalPlayer.PlayerGui:GetAttribute("Device") == "Tablet";
	end;
	_G.LastRound = v24.RoundCount;
	local l_GameModeName_0 = v24.GameModeName;
	local l_PlayerData_0 = v24.PlayerData;
	local l_XPRewards_0 = {};
	local l_TotalEarnedXP_0 = 0;
	local l_WinCondition_0 = v24.WinCondition;
	local _ = v24.RoundCount;
	if l_GameModeName_0 == "FreezeTag" then
		return;
	else
		local v32 = v25 and game.Players.LocalPlayer.PlayerGui.Scoreboard_Phone or game.Players.LocalPlayer.PlayerGui.Scoreboard;
		local l_Container_0 = (v32:FindFirstChild(l_GameModeName_0) or v32.BonusModes).Container;
		local v34 = l_Container_0:FindFirstChild("RewardContainer") or l_Container_0;
		if v34.Name == "RewardContainer" then
			v34.Visible = false;
		end;
		local v35 = l_Container_0.VersusFrame:FindFirstChild("Title") or l_Container_0.Title;
		for _, v37 in pairs(v32:GetChildren()) do
			v37.Visible = v37 == l_Container_0.Parent;
		end;
		if game:GetService("UserInputService").GamepadEnabled and not game:GetService("UserInputService").MouseEnabled then
			v35.Close.Visible = false;
			v35.CloseXbox.Visible = true;
		end;
		v4.Bind("CloseScoreboard", Enum.KeyCode.ButtonY, function() --[[ Line: 134 ]]
			v32.Enabled = false;
			v4.Unbind("CloseScoreboard");
		end);
		for _, v39 in pairs(v34:GetChildren()) do
			if v39:IsA("Frame") then
				v39.Visible = v16[v39.Name] ~= nil;
				if v39.Name == "LevelUp" then
					v39.Visible = false;
				end;
			end;
		end;
		if v24.GameModeName == "Classic" then
			local v40 = nil;
			local v41 = nil;
			for v42, v43 in pairs(v24.PlayerData) do
				if v43.Role == "Sheriff" then
					v41 = v42;
				elseif v43.Role == "Murderer" then
					v40 = v42;
				end;
			end;
			if v40 == nil or v41 == nil then
				warn("Scoreboard bail: Murderer=", v40, "Sheriff=", v41)
				v32.Enabled = false;
				v4.Unbind("CloseScoreboard");
				return;
			else
				local l_Container_1 = l_Container_0.VersusFrame.Container;
				local l_Container_2 = l_Container_1.Murderer.Container;
				l_Container_2.PlayerIcon.Image = v23(v40);
				l_Container_2.PlayerName.Text = v40;
				l_Container_2.Dead.Visible = l_PlayerData_0[v40].Dead;
				local l_Container_3 = l_Container_1.Sheriff.Container;
				local v47 = ((l_WinCondition_0 == "MurdererDied" or l_WinCondition_0 == "SheriffWin") and v24.Shooter) or v41;
				if not v47 or not l_PlayerData_0[v47] then
					v47 = v41;
				end;
				l_Container_3.PlayerIcon.Image = v23(v47);
				local l_Role_0 = l_PlayerData_0[v47].Role;
				l_Container_3[l_Role_0].Visible = true;
				l_Container_3[v18[l_Role_0]].Visible = false;
				l_Container_3.PlayerName.Text = v47;
				l_Container_3.Dead.Visible = l_PlayerData_0[v47].Dead;
				v2.DisplayItem(l_Container_1.KnifeFrame, l_Sync_0.Weapons[l_PlayerData_0[v40].Knife]);
				v2.DisplayItem(l_Container_1.GunFrame, l_Sync_0.Weapons[l_PlayerData_0[v47].Gun]);
				local v49 = l_WinCondition_0 == "MurdererWin" and "MurdererWin" or "Innocents";
				if l_WinCondition_0 == "SheriffWin" then
					v49 = "Sheriff";
				elseif l_WinCondition_0 == "MurdererDied" then
					v49 = l_Role_0 == "Hero" and "Hero" or l_Role_0 == "Sheriff" and "Sheriff" or "Innocents";
				elseif l_WinCondition_0 == "Innocents" then
					v49 = "Innocents";
				elseif v49 == "Innocents" and v24.Was1v1 == true then
					v49 = "Draw";
				end;
				for _, v51 in pairs(v35:GetChildren()) do
					if v51.Name ~= "Close" and v51.Name ~= "CloseXbox" then
						v51.Visible = v51.Name == v49;
					end;
				end;
			end;
		elseif v24.GameModeName == "Assassin" then
			v35.Draw.Visible = l_WinCondition_0 == "TimeRanOut";
			v35.MurdererWin.Visible = l_WinCondition_0 == "PlayerWon";
			local v52 = "No-one";
			if l_WinCondition_0 == "PlayerWon" then
				for v53, v54 in pairs(l_PlayerData_0) do
					if v54.Dead == false then
						v52 = v53;
						break;
					end;
				end;
			else
				v52 = game.Players.LocalPlayer.Name;
			end;
			v35.MurdererWin.Text = v52 .. " has won!";
			local l_Container_4 = l_Container_0.VersusFrame.Container;
			local l_Container_5 = l_Container_4.Murderer.Container;
			if v52 ~= "No-one" then
				l_Container_5.PlayerIcon.Image = v23(v52);
			else
				l_Container_5.PlayerIcon.Image = "";
			end;
			l_Container_5.PlayerName.Text = v52;
			l_Container_5.Role.Visible = l_WinCondition_0 == "PlayerWon";
			if v52 == game.Players.LocalPlayer then
				l_Container_5.PlayerName.Text = "(You)";
			end;
			if v52 ~= "No-one" then
				v2.DisplayItem(l_Container_4.KnifeFrame, l_Sync_0.Weapons[l_PlayerData_0[v52].Knife]);
			end;
		elseif v24.GameModeName == "ScaryMode" then
			local v57 = nil;
			for v58, v59 in pairs(v24.PlayerData) do
				if v59.Role == "Murderer" then
					v57 = v58;
				end;
			end;
			v35.MurdererWin.Visible = l_WinCondition_0 == "MurdererWin";
			v35.InnocentsEscaped.Visible = l_WinCondition_0 ~= "MurdererWin";
			local l_v57_0 = v57;
			local l_Container_6 = l_Container_0.VersusFrame.Container.Murderer.Container;
			l_Container_6.PlayerIcon.Image = v23(l_v57_0);
			l_Container_6.PlayerName.Text = l_v57_0;
			l_Container_6.Dead.Visible = l_PlayerData_0[v57].Dead or l_WinCondition_0 == "InnocentsEscaped";
		elseif l_GameModeName_0 == "FreezeTag" then
			v35.Freezers.Visible = l_WinCondition_0 == "FreezersWin";
			local l_Runners_0 = v35.Runners;
			local v63 = true;
			if l_WinCondition_0 ~= "RunnersWin" then
				v63 = l_WinCondition_0 == "Time";
			end;
			l_Runners_0.Visible = v63;
		end;
		local v64 = l_PlayerData_0[game.Players.LocalPlayer.Name];
		if v64 ~= nil or v24.Was1v1 then
			local l_XP_0 = v64.XP;
			local l_XP_1 = l_Container_0.LevelUp.Level.XPBar.XP;
			local v67 = v3.GetLevel(l_XP_0);
			local v68 = v3.GetProgressToNextLevel(l_XP_0);
			l_Container_0.LevelUp.Level.Level.LevelText.Text = v67 < 100 and v67 + 1 or 100;
			local v69 = v68 > 1 and 1 or v68;
			l_XP_1.Size = UDim2.new(v69, l_XP_1.Size.X.Offset, l_XP_1.Size.Y.Scale, l_XP_1.Size.Y.Offset);
			l_Container_0.LevelUp.Coins.CoinIcon.TextLabel.Text = v64.Coins or 0;
			l_Container_0.LevelUp.TotalXP.XPIcon.TextLabel.Text = "+0";
			v32.Enabled = true;
			wait(1);
			for v70, v71 in pairs(l_XPRewards_0) do
				wait(0.5);
				local rewardFrame = v34:FindFirstChild(v70)
				if rewardFrame and rewardFrame:FindFirstChild("Container") then
					local l_Container_7 = rewardFrame.Container;
					l_Container_7.TextLabel.Text = v71.Text;
					l_Container_7.XPIcon.TextLabel.Text = (v71.Multiplier or "+") .. v0.Commafy(v71.XP);
					l_Container_7.Parent.Visible = true;
					v34.Visible = true;
				else
					warn("Scoreboard missing reward frame:", v70)
				end
			end;
			wait(0.5);
			local l_TweenValue_0 = l_Container_0.LevelUp.TotalXP.XPIcon.TextLabel.TweenValue;
			l_TweenValue_0.Value = 0;
			l_TweenValue_0.Changed:connect(function() --[[ Line: 331 ]]
				l_Container_0.LevelUp.TotalXP.XPIcon.TextLabel.Text = "+" .. v0.Commafy((math.floor(l_TweenValue_0.Value)));
			end);
			local v74 = {
				l_TweenService_0:Create(l_TweenValue_0, v11, {
					Value = l_TotalEarnedXP_0
				})
			};
			for _, v76 in pairs(v74) do
				v76:Play();
			end;
			v74 = v3.GetLevel(l_XP_0 + l_TotalEarnedXP_0) - v3.GetLevel(l_XP_0);
			local v77 = v3.GetLevel(l_XP_0 + l_TotalEarnedXP_0);
			local v78 = v77 + 1;
			print("CurrentLevel", v67, "TotalEarnedXP", l_TotalEarnedXP_0, "LevelsGained", v74, "NewLevel", v77, "MyXP", l_XP_0);
			if v78 > 100 then
				v78 = 100;
			end;
			if v77 > 100 then
				v77 = 100;
			end;
			if v74 > 0 then
				for v79 = 1, v74 do
					local v80 = 0.7;
					if v79 == 1 then
						v80 = v80 * (1 - v68);
					end;
					local v81 = TweenInfo.new(v80, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0);
					local v82 = {
						l_TweenService_0:Create(l_XP_1, v81, {
							Size = UDim2.new(1, 0, 1, 0)
						})
					};
					for _, v84 in pairs(v82) do
						v84:Play();
					end;
					wait(v80);
					l_XP_1.Size = UDim2.new(0, 0, 1, 0);
					l_Container_0.LevelUp.Level.Level.LevelText.Text = v67 + v79 + 1;
				end;
			end;
			local v85 = l_XP_0 + l_TotalEarnedXP_0;
			if v85 > 1237500 then
				v85 = 1237500;
			end;
			local v86 = v3.GetProgressToNextLevel(v85);
			if v86 > 1 then
				v86 = 1;
			elseif v86 < 0 then
				v86 = 0;
			end;
			local v87 = {
				l_TweenService_0:Create(l_XP_1, v10, {
					Size = UDim2.new(v86, 0, 1, 0)
				})
			};
			for _, v89 in pairs(v87) do
				v89:Play();
			end;
			wait(1.5);
		else
			l_Container_0.Enabled = true;
		end;
		wait(10);
		v32.Enabled = false;
		v4.Unbind("CloseScoreboard");
		return;
	end;
end;
return v0;