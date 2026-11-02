local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ADMIN_IDS = { [1557378019,11405260393,11465819882] = true }
local banStore = DataStoreService:GetDataStore("BannedPlayers_v2")
local banEvent = ReplicatedStorage:WaitForChild("BanSystemEvent")
local bannedCache = {}

local success, data = pcall(function() return banStore:GetAsync("banned_list") end)
if success and type(data) == "table" then
	for k in pairs(data) do bannedCache[k] = true end
end

local function saveBanned()
	pcall(function() banStore:SetAsync("banned_list", bannedCache) end)
end

Players.PlayerAdded:Connect(function(plr)
	if bannedCache[plr.Name:lower()] then plr:Kick("Vous etes banni.") end
end)

banEvent.OnServerEvent:Connect(function(player, action, target)
	if not ADMIN_IDS[player.UserId] then return end
	target = tostring(target or ""):gsub("^%s+",""):gsub("%s+$","")
	if target == "" then banEvent:FireClient(player, "⚠ Entrez un pseudo."); return end
	local tl = target:lower()
	if action == "ban" then
		if bannedCache[tl] then banEvent:FireClient(player, "⚠ "..target.." est deja banni."); return end
		bannedCache[tl] = true; saveBanned()
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Name:lower() == tl then p:Kick("Banni par un admin.") break end
		end
		banEvent:FireClient(player, "✅ "..target.." banni.")
	elseif action == "unban" then
		if not bannedCache[tl] then banEvent:FireClient(player, "⚠ "..target.." n'est pas banni."); return end
		bannedCache[tl] = nil; saveBanned()
		banEvent:FireClient(player, "✅ "..target.." unban.")
	end
end)