-- Wrapper module that redirects to the actual BoostService
local ServerScriptService = game:GetService("ServerScriptService")

local BoostServiceServer = {}

function BoostServiceServer:init()
	-- The actual BoostService initializes itself via handlerzib
	print("[BoostServiceServer] Wrapper initialized")
end

function BoostServiceServer:addBoost(player, boostKind, amount)
	local services = ServerScriptService:FindFirstChild("Services")
	if not services then
		warn("[BoostServiceServer] Services folder not found")
		return nil
	end

	local boostService = services:FindFirstChild("BoostService")
	if not boostService then
		warn("[BoostServiceServer] BoostService not found")
		return nil
	end

	local ok, service = pcall(require, boostService)
	if not ok or type(service) ~= "table" then
		warn("[BoostServiceServer] Could not require BoostService")
		return nil
	end

	if service.applyBoost then
		return service:applyBoost(player, boostKind, amount)
	else
		warn("[BoostServiceServer] BoostService does not have applyBoost method")
		return nil
	end
end

return BoostServiceServer