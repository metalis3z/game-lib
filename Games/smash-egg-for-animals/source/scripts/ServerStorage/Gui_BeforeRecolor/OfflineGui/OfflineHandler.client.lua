-- Argent gagné hors ligne : le serveur le calcule à l'arrivée (attributs "OfflineMoney" / "OfflineSeconds") et le joueur le récupère ici.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local system = ReplicatedStorage:WaitForChild("EggSystem")
local Config = require(system:WaitForChild("EggConfig"))
local claim = system:WaitForChild("Remotes"):WaitForChild("ClaimOffline")
local dim = script.Parent:WaitForChild("Dim")
local main = dim:WaitForChild("Main")
local fit = main:WaitForChild("Fit")

local function duration(seconds)
	seconds = math.floor(seconds)
	if seconds < 60 then return seconds .. "s" end
	if seconds < 3600 then return math.floor(seconds / 60) .. "m " .. seconds % 60 .. "s" end
	if seconds < 86400 then return math.floor(seconds / 3600) .. "h " .. math.floor(seconds % 3600 / 60) .. "m" end
	return math.floor(seconds / 86400) .. "d " .. math.floor(seconds % 86400 / 3600) .. "h"
end

-- la fenêtre tient dans l'écran (la taille de l'écran n'est pas encore connue pendant le chargement)
local function fitScale()
	local size = workspace.CurrentCamera.ViewportSize
	if size.X < 200 or size.Y < 200 then return 1 end
	return math.min(1, size.X / 560, size.Y / 380)
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	if dim.Visible then fit.Scale = fitScale() end
end)

local function show()
	local money = player:GetAttribute("OfflineMoney") or 0
	if money <= 0 then
		dim.Visible = false
		return
	end
	main.Away.Text = "You were offline for " .. duration(player:GetAttribute("OfflineSeconds") or 0) .. "."
	main.Amount.Text = Config.FormatMoney(money)
	local base = fitScale()
	fit.Scale = base * 0.6
	dim.Visible = true
	TweenService:Create(fit, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = base}):Play()
end

main.Ok.Activated:Connect(function()
	claim:FireServer(false)
	dim.Visible = false
end)
main.Double.Activated:Connect(function()
	claim:FireServer(true) -- le serveur répond "bientôt" tant que le produit Robux n'existe pas
end)

player:GetAttributeChangedSignal("OfflineMoney"):Connect(show)
show()
