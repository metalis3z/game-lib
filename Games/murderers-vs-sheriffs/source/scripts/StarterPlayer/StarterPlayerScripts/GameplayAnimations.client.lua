local TweenService = game:GetService("TweenService");

_G.LastRound = -1;
_G.PlayerIcons = {};

local function v3()
	for _, v2 in pairs(game.Players:GetPlayers()) do
		if _G.PlayerIcons[v2.Name] == nil then
			spawn(function()
				_G.PlayerIcons[v2.Name] = game.Players:GetUserThumbnailAsync(math.abs(v2.userId), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size352x352);
			end);
		end;
	end;
end;

v3();

game.Players.PlayerAdded:connect(v3);
game.Players.PlayerRemoving:connect(v3);

local v4 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v5 = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0);

local v6 = require(game.ReplicatedStorage.Modules.FadeModule);
local function v19(RoleName)
	local v11 = script.Victory:Clone()
	local v12 = v11:FindFirstChild(RoleName .. "Victory") or (v11:FindFirstChild(RoleName) or v11.MurdererVictory)

	v12.Visible = true
	v11.Parent = game.Players.LocalPlayer.PlayerGui

	task.wait(0.05)

	local v13 = { TweenService:Create(v12.Container, v4, {
		["Size"] = UDim2.new(1, 0, 1, 0)
	}), TweenService:Create(v12.KnifeRight, v4, {
			["Position"] = UDim2.new(0.975, 0, 0.5, 0),
			["Rotation"] = 0
		}), TweenService:Create(v12.KnifeLeft, v4, {
			["Position"] = UDim2.new(0.025, 0, 0.5, 0),
			["Rotation"] = 0
		}) }
	for _, v14 in pairs(v13) do
		v14:Play()
	end

	task.wait(8)

	local v15 = { TweenService:Create(v12, v4, {
		["Position"] = UDim2.new(0.5, 0, 0, -(v12.Container.AbsoluteSize.Y * 2) - 10)
	}) }

	for _, v16 in pairs(v15) do
		v16:Play()
	end

	task.wait(v4.Time)
	v11:Destroy()
end

local v20 = {
	Innocent = { 
		Time = true, 
		MurdererDied = true, 
		MurdererLeft = true, 
		InnocentsEscaped = true 
	}, 
	Hero = { 
		Time = true, 
		MurdererDied = true, 
		MurdererLeft = true 
	}, 
	Sheriff = { 
		MurdererDied = true, 
		MurdererLeft = true, 
		SheriffWin = true 
	}, 
	Murderer = { 
		MurdererWin = true 
	}, 
	Assassin = { 
		PlayerWon = true 
	},
	Zombie = { 
		ZombiesWin = true 
	}, 
	Survivor = { 
		SurvivorsWin = true, 
		Time = true 
	}, 
	Freezer = { 
		FreezersWin = true 
	}, 
	Runner = { 
		RunnersWin = true, 
		Time = true 
	}, 
	Team1 = { 
		Team1Victory = true 
	}, 
	Team2 = { 
		Team2Victory = true 
	}, 
	Vampire = { 
		VampireWin = true 
	}, 
	Hunter = { 
		Time = true, 
		InnocentWin = true 
	}, 
	Villager = { 
		Time = true, 
		InnocentWin = true 
	}
}

local _ = function()
	local DeathFade = script.DeathFade:Clone();
	local Fade = DeathFade.Fade;
	DeathFade.Parent = game.Players.LocalPlayer.PlayerGui;
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
	local v23 = {
		TweenService:Create(Fade, v5, {
			BackgroundTransparency = 0
		})
	};
	for _, v25 in pairs(v23) do
		v25:Play();
	end;
end;

local v27 = false;
local function v33(player, index)
	pcall(function()
		if player and player.Character and player.Character:FindFirstChild("Radio") then
			local radioSound = player.Character.Radio:FindFirstChild("Sound")
			if radioSound and radioSound.IsPlaying then
				return
			end
		end

		local soundIds = {
			"rbxassetid://100131816746670",
			"rbxassetid://135824017711074",
			"rbxassetid://78424939982302",
			"rbxassetid://128191357312843"
		}

		local playbackSpeeds = {
			1,
			1,
			1,
			1
		}

		index = index or 1
		if not soundIds[index] then
			index = 1
		end

		local sound = Instance.new("Sound")
		sound.SoundId = soundIds[index]
		sound.Volume = 0.4
		sound.Looped = false
		sound.PlayOnRemove = false
		sound.SoundGroup = game:GetService("SoundService"):FindFirstChild("Music")
		sound.PlaybackSpeed = playbackSpeeds[index]
		Instance.new("NumberValue", sound).Value = sound.Volume
		sound.Parent = game:GetService("SoundService")
		sound:Play()
		game.Debris:AddItem(sound, 10)
	end)
end

game.ReplicatedStorage.Remotes.Gameplay.VictoryScreen.OnClientEvent:connect(function(v34, v35, v36, v37, v38)
	print(v34, v35, v36, v37);

	if v35 == "Zombie" or v35 == "Survivor" then
		task.wait(0.5);
		v33(game.Players.LocalPlayer, v38);
		v19(v35);
		return;
	elseif v35 == "Freezer" or v35 == "Runner" then
		task.wait(0.5);
		v33(game.Players.LocalPlayer, v38);
		v19(v35);
		return;
	elseif v37 == "Red Team" or v37 == "Blue Team" then
		v33(game.Players.LocalPlayer, v38);
		v19(v37);
		return;	
	else
		if v20[v35] then
			if v20[v35][v36] and v34 then
				task.wait(0.5);
				v33(game.Players.LocalPlayer, v38);
				v19(v35);
				return;
			elseif v37 and v34 == false then
				local v39 = game.Players.LocalPlayer.Character ~= nil;
				v6.FadeToWinner(v37.Name, v39);
				v33(v37, v38);
				return;
			elseif v34 then
				task.wait(0.5);
				v33(game.Players.LocalPlayer, v38);
				v19(v27 and "InnocentsEscaped" or "TimesUp");
				return;
			end;
		else
			v33(game.Players.LocalPlayer, v38);
			v19("TimesUp");
		end;
	end;
end);

game.ReplicatedStorage.Remotes.Gameplay.FadeScreens.OnClientEvent:Connect(function()
	v6.PlayCameraFade('In')
end)
local v41 = require(game.ReplicatedStorage.Modules.ScoreboardModule);

_G.ShowResults = function(_)
	for attempt = 1, 10 do
		local ok, v43 = pcall(function()
			return game.ReplicatedStorage.Remotes.Gameplay.GetLastRoundRewards:InvokeServer();
		end)
		if ok and v43 ~= nil then
			if v43.RoundCount ~= _G.LastRound then
				local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
				if not playerGui:FindFirstChild("Scoreboard") then
					warn("ShowResults: 'Scoreboard' GUI not found under PlayerGui")
					return
				end
				local displayOk, displayError = pcall(function()
					v41.DisplayScoreboard(v43);
				end)
				if not displayOk then
					warn("ShowResults: failed to display scoreboard:", displayError)
				end
			end;
			return;
		end;
		task.wait(0.5)
	end
	warn("ShowResults: round rewards were not ready after retrying.")
end;

local showingResults = false
local function requestResults()
	if showingResults then
		return
	end
	showingResults = true
	task.spawn(function()
		_G.ShowResults()
		task.wait(2)
		showingResults = false
	end)
end

game.ReplicatedStorage.Remotes.Gameplay.RoundEndFade.OnClientEvent:connect(requestResults);
game.ReplicatedStorage.Remotes.Gameplay.RoundEnd.OnClientEvent:connect(requestResults);
