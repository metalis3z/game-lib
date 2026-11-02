
local TweenHandler = require(game:GetService("ReplicatedStorage").Tween)
local Equipped = false
local Player = game.Players.LocalPlayer
local Character = Player.Character
local RequiredKills = 4500
local ClaimButton = script.Parent.ImageButton
local ClaimImage = script.Parent.ImageLabel
local KillsValue = Player.leaderstats.Kills

local function WaitForKills()
	script.Parent.Info.Info.Text = "" .. RequiredKills .. " KILLS"
	if KillsValue.Value >= RequiredKills then
		script.Parent.Info.Info.TextColor = BrickColor.new("Sea green")
		ClaimImage.ImageColor3 = Color3.new(0.176471, 0.176471, 0.176471)
	elseif KillsValue.Value <= RequiredKills then
		ClaimImage.ImageColor3 = Color3.new(0, 0, 0)
		script.Parent.Info.Info.TextColor = BrickColor.new("Persimmon")
	end
end

ClaimButton.MouseButton1Click:Connect(function()
	if Equipped == false then
		if KillsValue.Value >= RequiredKills then
			Equipped = true
			TweenHandler.Tween(ClaimImage,{ImageColor3 = Color3.new(1, 1, 1)},0.5,"Quart",false,0)
			script.Equip:FireServer()
		end
	else
		if KillsValue.Value >= RequiredKills then
			Equipped = false
			TweenHandler.Tween(ClaimImage,{ImageColor3 = Color3.new(0.176471, 0.176471, 0.176471)},0.5,"Quart",false,0)
			script.Unequip:FireServer()
		end
	end
end)

KillsValue.Changed:Connect(function()
	WaitForKills()
end)

WaitForKills()

