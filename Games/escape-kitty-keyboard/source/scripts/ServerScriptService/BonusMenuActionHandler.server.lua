local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local BonusMenuAction = ReplicatedStorage:WaitForChild("BonusMenuAction")
local XPMultiplierManager = require(ServerScriptService:WaitForChild("XPMultiplierManager"))
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

-- Only this admin user can activate bonus events (matches client-side check in BonusMenuHandler)
local ADMIN_USER_ID = 3845375404

BonusMenuAction.OnServerEvent:Connect(function(player, data)
	-- Security: only the admin can use this
	if player.UserId ~= ADMIN_USER_ID then return end
	if type(data) ~= "table" then return end

	local action = data.action

	if action == "activate" then
		local scope = data.scope or "server"
		local bonusType = data.bonusType or "XP"
		local multiplier = tonumber(data.multiplier)
		local duration = tonumber(data.duration)

		if not multiplier or multiplier <= 0 then return end
		if not duration or duration <= 0 then duration = nil end

		-- For now, both "server" and "player" scopes apply globally
		-- (per-player multipliers would require additional infrastructure)
		if bonusType == "XP" then
			XPMultiplierManager.Set(multiplier, duration)
		elseif bonusType == "Wins" then
			WinsMultiplierManager.Set(multiplier, duration)
		end

	elseif action == "stopAll" then
		XPMultiplierManager.Reset()
		WinsMultiplierManager.Reset()
	end
end)
