-- Style du jeu : pas de coins arrondis. Les fenêtres et boutons créés pendant la partie par d'autres scripts perdent leur UICorner ici.
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local function strip(d)
	if d:IsA("UICorner") then task.defer(function() d:Destroy() end) end
end
for _, d in playerGui:GetDescendants() do strip(d) end
playerGui.DescendantAdded:Connect(strip)
