-- Affiche l'argent du joueur (attribut "Money") avec un compteur qui défile
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))

local player = Players.LocalPlayer
local amountLabel = script.Parent:WaitForChild("Holder"):WaitForChild("Amount")
local scale = amountLabel:WaitForChild("UIScale")

local COUNT_TIME = 0.5
local POP_SCALE = 1.15

local shown = player:GetAttribute("Money") or 0
local from, to, elapsed = shown, shown, COUNT_TIME
amountLabel.Text = Config.FormatMoney(shown)

player:GetAttributeChangedSignal("Money"):Connect(function()
	local money = player:GetAttribute("Money") or 0
	local spent = money < to
	from, to, elapsed = shown, money, 0
	if spent then -- petit "pop" seulement quand on dépense (les revenus arrivent chaque seconde)
		scale.Scale = POP_SCALE
		TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end
end)

RunService.RenderStepped:Connect(function(dt)
	if elapsed >= COUNT_TIME then return end
	elapsed = math.min(elapsed + dt, COUNT_TIME)
	local a = 1 - (1 - elapsed / COUNT_TIME) ^ 3
	shown = from + (to - from) * a
	amountLabel.Text = Config.FormatMoney(elapsed >= COUNT_TIME and to or shown)
end)
