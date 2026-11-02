-- Huge Egg : un toutes les 30 minutes (avant : toutes les 6 nuits ; la nuit a été retirée).
-- ReplicatedStorage.HugeEggAt = heure serveur du prochain (compteur "HUGE EGG IN" + panneau HugeEggSign).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local HUGE_EVERY = 30 * 60 -- secondes entre deux Huge Eggs

local bindables = ServerStorage:WaitForChild("GameBindables")
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

while true do
	local at = workspace:GetServerTimeNow() + HUGE_EVERY
	ReplicatedStorage:SetAttribute("HugeEggAt", at)
	while workspace:GetServerTimeNow() < at do task.wait(1) end
	local huge = bindables:WaitForChild("SpawnHugeEgg", 10)
	local ok, info = pcall(function() return huge and huge:Invoke() end)
	if ok and type(info) == "table" then
		for _, player in Players:GetPlayers() do
			notifyRemote:FireClient(player, "A HUGE EGG (" .. math.floor(info.Kg / 1000) .. "K kg) appeared in the " .. tostring(info.Zone) .. "!")
		end
		local announce = remotes:FindFirstChild("EggSpawnAnnounce")
		if announce then announce:FireAllClients(info.Name, info.Zone, info.Rarity, nil, nil, nil, info.Giant) end
	elseif not ok then
		warn("[HugeEggServer] spawn failed: " .. tostring(info))
	end
end
