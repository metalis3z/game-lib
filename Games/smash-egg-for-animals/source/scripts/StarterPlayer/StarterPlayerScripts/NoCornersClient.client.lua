-- Style du jeu : pas de coins arrondis. Les fenêtres et boutons créés pendant la partie par d'autres scripts perdent leur UICorner ici.
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
-- exceptions : les boutons de la barre du haut (comme ceux de Roblox), le bouton ADMIN, le sondage global
local KEEP = {TopBarGui = true, GlobalPollGui = true}
local function strip(d)
	if not d:IsA("UICorner") then return end
	local gui = d:FindFirstAncestorOfClass("ScreenGui")
	if gui and KEEP[gui.Name] then return end
	if d.Parent and d.Parent:GetAttribute("KeepCorners") then return end
	task.defer(function() d:Destroy() end)
end
for _, d in playerGui:GetDescendants() do strip(d) end
playerGui.DescendantAdded:Connect(strip)
