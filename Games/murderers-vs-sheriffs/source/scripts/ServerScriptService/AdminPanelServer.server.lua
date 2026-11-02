local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(ReplicatedStorage:WaitForChild("Constants"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminSettings = Remotes:WaitForChild("AdminSettings")
local GameplayRemotes = Remotes:WaitForChild("Gameplay")

local ADMIN_GAMEPASS_ID = Constants.Gamepasses.AdminMenu or 1933372241
local ADMIN_OWNER_IDS = {
	[24029404] = true,
}

local function hasAdmin(player)
	if not player then
		return false
	end
	if ADMIN_OWNER_IDS[player.UserId] or player:GetAttribute("AdminPanelAccess") == true then
		return true
	end
	local ok, ownsPass = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, ADMIN_GAMEPASS_ID)
	end)
	if not ok then
		warn("[AdminPanel] Could not verify admin gamepass for", player.Name, ownsPass)
		return false
	end
	return ownsPass == true
end

local function firePlayerDataChanged(playerData)
	GameplayRemotes.PlayerDataChanged:FireAllClients(playerData)
	local modules = ReplicatedStorage:FindFirstChild("Modules")
	local currentRoundClient = modules and modules:FindFirstChild("CurrentRoundClient")
	local changed = currentRoundClient and currentRoundClient:FindFirstChild("PlayerDataChanged")
	if changed and changed:IsA("BindableEvent") then
		changed:Fire(playerData)
	end
end

local endRoundRemote = AdminSettings:FindFirstChild("EndRound")
if not endRoundRemote then
	endRoundRemote = Instance.new("RemoteFunction")
	endRoundRemote.Name = "EndRound"
	endRoundRemote.Parent = AdminSettings
end

endRoundRemote.OnServerInvoke = function(player)
	if not hasAdmin(player) then
		return {message = "Admin gamepass required.", exp = true}
	end

	local gameVariables = _G.GameVariables
	local playerData = gameVariables and gameVariables.PlayerData
	if _G.RoundEnded == true or type(playerData) ~= "table" or next(playerData) == nil then
		return {message = "No active round to end.", exp = false}
	end

	local changed = false
	for _, data in pairs(playerData) do
		if type(data) == "table" and data.Role == "Murderer" and data.Dead ~= true then
			data.Dead = true
			data.DeadTime = gameVariables.GameTimer or data.DeadTime or 0
			changed = true
		end
	end

	if not changed then
		return {message = "Round is already ending.", exp = false}
	end

	firePlayerDataChanged(playerData)
	return {message = "Ending round.", exp = false}
end
