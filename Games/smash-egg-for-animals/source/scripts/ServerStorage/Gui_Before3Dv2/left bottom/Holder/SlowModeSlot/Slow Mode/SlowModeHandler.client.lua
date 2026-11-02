-- Bouton Slow Mode (colonne de gauche) : un interrupteur. Allumé, le joueur marche à la vitesse de départ (16) au lieu de sa
-- vitesse gagnée sur le tapis ; son speed n'est pas perdu. Le serveur applique la vitesse (SpeedServer, attribut SlowMode).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local button = script.Parent
local switch = button:WaitForChild("ToggleOn")
local knob = switch:WaitForChild("Knob")
local state = switch:WaitForChild("State")
local remote = ReplicatedStorage:WaitForChild("SpeedSystem"):WaitForChild("SlowMode")

local ON = ColorSequence.new(Color3.fromRGB(150, 245, 90), Color3.fromRGB(50, 180, 60))
local OFF = ColorSequence.new(Color3.fromRGB(255, 120, 110), Color3.fromRGB(200, 40, 50))
local SLIDE = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function show(on, instant)
	switch.UiGradient.Color = on and ON or OFF
	state.Text = on and "ON" or "OFF"
	state.Position = on and UDim2.fromScale(0.08, 0.18) or UDim2.fromScale(0.5, 0.18)
	local goal = {Position = on and UDim2.fromScale(0.74, 0.5) or UDim2.fromScale(0.26, 0.5)}
	if instant then knob.Position = goal.Position else TweenService:Create(knob, SLIDE, goal):Play() end
end

local on = player:GetAttribute("SlowMode") == true
show(on, true)
button.Activated:Connect(function()
	on = not on
	show(on)
	remote:FireServer(on)
end)
player:GetAttributeChangedSignal("SlowMode"):Connect(function()
	local now = player:GetAttribute("SlowMode") == true
	if now ~= on then on = now show(on) end
end)
