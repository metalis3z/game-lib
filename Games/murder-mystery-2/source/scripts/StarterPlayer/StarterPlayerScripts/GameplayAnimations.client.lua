-- Decompiled with the Synapse X Luau decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local u7 = require(game.ReplicatedStorage.Modules.FadeModule);
local LocalPlayer = game.Players.LocalPlayer
local function u1(p1)
	for v5, v6 in pairs(p1) do
		v6:Play();
	end;
end;
local u2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u3 = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0);
local v7 = true;
local function u5(p2)
	if p2 ~= nil and p2.Character ~= nil and p2.Character:FindFirstChild("Radio") and (p2.Character.Radio:FindFirstChild("Sound") and p2.Character.Radio.Sound.IsPlaying == true) then
		return;
	end;
	if _G.Mute == true then
		return
	end
	local v8 = game.Players.LocalPlayer.PlayerGui.MainGUI;
	local v9 = { "rbxassetid://13851001792", "rbxassetid://13851004685"};
	local v10 = Instance.new("Sound", v8);
	v10.SoundId = v9[math.random(1, #v9)];
	v10.Volume = 0.6;
	v10.Looped = false;
	v10.PlayOnRemove = false;
	Instance.new("NumberValue", v10).Value = v10.Volume;
	v10:Play();
	game.Debris:AddItem(v10,20);
end;
local function u6(p3)
	local v11 = script.Victory:Clone();
	game.Debris:AddItem(v11,10)
	local v12 = v11:FindFirstChild(p3 .. "Victory") or v11:FindFirstChild(p3);
	if p3 ~= "TimesUp" then
		u5(game.Players.LocalPlayer)
		end
	v12.Visible = true;
	v11.Parent = game.Players.LocalPlayer.PlayerGui;
	wait(0.05);
	u1({ l__TweenService__1:Create(v12.Container, u2, {
			Size = UDim2.new(1, 0, 1, 0)
		}), l__TweenService__1:Create(v12.KnifeRight, u2, {
			Position = UDim2.new(0.975, 0, 0.5, 0), 
			Rotation = 0
		}), l__TweenService__1:Create(v12.KnifeLeft, u2, {
			Position = UDim2.new(0.025, 0, 0.5, 0), 
			Rotation = 0
		}) });
	wait(8);
	u1({ l__TweenService__1:Create(v12, u2, {
			Position = UDim2.new(0.5, 0, 0, -(v12.Container.AbsoluteSize.Y * 2) - 10)
		}) });
end;
game.ReplicatedStorage.SpectateMurderer.OnClientEvent:Connect(function(MurderName)	
	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer()
	if PlayerData[LocalPlayer.Name]["Role"] == "Innocent" or PlayerData[LocalPlayer.Name]["Role"] == "Hero" or PlayerData[LocalPlayer.Name]["Role"] == "Sheriff" then
		local Board = game.ReplicatedStorage.Victory:Clone()
		Board.Parent = game.Players[MurderName].Character.Head
		u7.FadeToWinner(MurderName)

		u5(game.Players.LocalPlayer)
	end
end)
game.ReplicatedStorage.SpectateSheriff.OnClientEvent:Connect(function(SheriffName)
	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer()
	if PlayerData[LocalPlayer.Name]["Dead"] == true and PlayerData[SheriffName]["Role"] == "Sheriff" then
		local Board = game.ReplicatedStorage.Victory:Clone()
		Board.TextLabel.TextColor3 =Color3.new(0, 0, 1)
		Board.Parent = game.Players[SheriffName].Character.Head
		game.Players[SheriffName].Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		u7.FadeToWinner(SheriffName)
		u5(game.Players.LocalPlayer)
	elseif PlayerData[LocalPlayer.Name]["Dead"] == true and PlayerData[SheriffName]["Role"] == "Hero" then
		game.Players[SheriffName].Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		u7.FadeToWinner(SheriffName)
		u5(game.Players.LocalPlayer)
	end
end)
game.ReplicatedStorage.EndCurrentRound.OnClientEvent:Connect(function(TimerData)
	local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer()
    if PlayerData[LocalPlayer.Name] then
	if PlayerData[LocalPlayer.Name]["Role"] == "Innocent" and PlayerData[LocalPlayer.Name]["Dead"] == false then
		u6("InnocentVictory")
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Sheriff" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData <= 0 then
			u6("TimesUp")
			u5(game.Players.LocalPlayer)
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Sheriff" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData > 0 then
		u6("SheriffVictory")
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Hero" and PlayerData[LocalPlayer.Name]["Dead"] == false then
		u6("HeroVictory")
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Murderer" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData > 0 then
		if tonumber(CountInnocentsAlive(PlayerData)) <= 0 then
			u6("MurdererVictory")
		else 
			u6("TimesUp")
		end
	elseif PlayerData[LocalPlayer.Name]["Role"] == "Murderer" and PlayerData[LocalPlayer.Name]["Dead"] == false and TimerData <= 0 then
			u6("TimesUp")
			u5(game.Players.LocalPlayer)
		end
		end
end)
function CountInnocentsAlive(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if Data["Role"] == "Innocent" and Data["Dead"] == false then
			Count = Count + 1;
		end
	end
	return Count;
end

function CountInnocentsDead(PlayerData)
	local Count = 0;
	for PlayerName,Data in pairs(PlayerData) do
		if (Data["Role"] == "Innocent" or Data["Role"] == "Sheriff") and Data["Dead"] == true then
			Count = Count + 1;
		end
	end
	return Count;
end
game.ReplicatedStorage.FadeScreens.OnClientEvent:Connect(function()
	u7.PlayCameraFade("In");
end)
