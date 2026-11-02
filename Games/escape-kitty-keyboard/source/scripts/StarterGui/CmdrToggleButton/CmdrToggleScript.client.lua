local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local gui = script.Parent
local button = gui:WaitForChild("OpenCmdrButton")
local player = Players.LocalPlayer

-- Seul ssimoletarer123 peut voir le bouton
if player.Name ~= "KIPPENDANS_9" then
	gui:Destroy()
	return
end

-- Vérification d'autorisation côté serveur
local remotes = ReplicatedStorage:WaitForChild("Remotes")
local isCmdrAuthorized = remotes:WaitForChild("IsCmdrAuthorized")

local authorized = false
local success, result = pcall(function()
	return isCmdrAuthorized:InvokeServer()
end)
if success then
	authorized = result
end

if not authorized then
	gui:Destroy()
	return
end

-- Attendre que CmdrClient soit disponible dans ReplicatedStorage
local CmdrClient = ReplicatedStorage:WaitForChild("CmdrClient", 30)
if not CmdrClient then
	warn("[CmdrToggleButton] CmdrClient introuvable dans ReplicatedStorage")
	return
end

local Cmdr = require(CmdrClient)

button.MouseButton1Click:Connect(function()
	Cmdr:Toggle()
end)