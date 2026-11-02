--[[Ulysse94]]--
customLeaderboard = true --Do you use a custom one? (false/true) It will disable the default one and won't reactive it.
customBackpack = true --same
customChat = false --same, doesn't count radios ofc
enableResetButton = true --Re-enable it.
enableEmojis = false
enableHealth = true

--DO NOT EDIT
local ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SolitaryUI")
local hum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local torso = game.Players.LocalPlayer.Character:FindFirstChild("Torso") or game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso")
local effect = script:WaitForChild("ColorCorrection")
local service = game:GetService("TweenService")
local inf = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)
local prop1 = {Position = UDim2.fromScale(0.216, 0.252)}
local prop2 = {Position = UDim2.fromScale(0.216, -1.5)}
local tweenin = service:Create(ui:FindFirstChild("Frame"), inf, prop1)
local tweenout = service:Create(ui:FindFirstChild("Frame"), inf, prop2)
local debounce = false

local function inside(part)
	debounce = true
	local module = require(part:FindFirstChildOfClass("ModuleScript"))
	local allowed = false
	
	for i = 1, #module["AllowedGroups"] do
		local child = module["AllowedGroups"][i]
		if game.Players.LocalPlayer:GetRankInGroup(child[1]) >= child[2] then
			allowed = true
		end
	end
	if table.find(module["AllowedTeams"], game.Players.LocalPlayer.Team.Name) then
		allowed = true
	end
	if allowed == true and hum.Health > 0  then
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		game.StarterGui:SetCore("ResetButtonCallback", false)
		local uis = {}
		for i, child in pairs(script.Parent.Parent:GetChildren()) do
			if child:IsA("ScreenGui") then
				table.insert(uis, 1, child)
				child.Enabled = false
			end
		end
		ui.Enabled = true
		ui.Frame.Cooldown.Text = module["Timer"]
		tweenin:Play()
		game.ReplicatedStorage.Solitary.SolitaryStart:FireServer()
		local cc = module["Timer"]
		repeat if game.Lighting:FindFirstChild("ColorCorrection") and game.Lighting:FindFirstChild("ColorCorrection").Saturation == -1 and not effect == game.Lighting:FindFirstChild("ColorCorrection") then
				effect.Parent = script
			else effect.Parent = game.Lighting
			end
			ui.Frame.Cooldown.Text = cc
			ui.Frame.Cooldown.Back.Text = cc
			wait(1)
			cc = cc - 1
		until cc <= -1
		game.ReplicatedStorage.Solitary.SolitaryEnd:FireServer()
		for i, child in pairs(uis) do
			if child then
				child.Enabled = true
			end
		end
		tweenout:Play()
		wait(.5)
		effect.Parent = script
		ui.Enabled = false
		if enableHealth == true then
				game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, true)
		end
		if enableEmojis == true then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true)
		end
		if customLeaderboard == false then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end
		if customBackpack == false then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end
		if customChat == false then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		end
		if enableResetButton == true then
			game.StarterGui:SetCore("ResetButtonCallback", true)
		end
	end
	debounce = false
end

while wait() do
	local t = workspace:FindPartsInRegion3(Region3.new(torso.Position - torso.Size / 2, torso.Position + torso.Size / 2), torso, 100)
	for i, child in pairs(t) do
		if child:IsA("BasePart") and child.Name == "SolitaryCell" and debounce == false then
			coroutine.resume(coroutine.create(inside), child)
		end
	end
end