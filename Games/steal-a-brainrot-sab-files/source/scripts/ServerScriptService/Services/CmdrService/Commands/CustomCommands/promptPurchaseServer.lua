local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MessagingService = require(ServerScriptService.Services.MessagingService)
local isadmin = require(ReplicatedStorage.Shared.IsAdmin)

local TOPIC_NAME = "GlobalPurchasePrompt"

local function promptInThisServer(kind, id)
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			if kind == "gamepass" then
				MarketplaceService:PromptGamePassPurchase(player, id)
			else
				MarketplaceService:PromptProductPurchase(player, id)
			end
		end)
	end
end

MessagingService:SubscribeAsync(TOPIC_NAME, function(payload)
	if type(payload) ~= "table" then return end
	local kind = payload.kind
	local id = tonumber(payload.id)
	if (kind ~= "product" and kind ~= "gamepass") or not id then return end
	promptInThisServer(kind, id)
end)

return function(context, kind, id, jobid)
	if not isadmin(context.Executor.UserId) then
		return false, "Unauthorized"
	end

	kind = string.lower(kind)
	if kind ~= "product" and kind ~= "gamepass" then
		return false, "Invalid type. Use 'product' (developer product) or 'gamepass'."
	end

	jobid = (jobid and jobid ~= "") and jobid or nil

	if jobid then
		local ok = MessagingService:PublishAsync(TOPIC_NAME, { kind = kind, id = id }, jobid)
		if not ok then
			return string.format("invalid jobid '%s' (or publish failed).", jobid)
		end
		return string.format("%s purchase prompt (id %s) sent to server %s only!", kind, tostring(id), jobid)
	end

	local success = MessagingService:PublishAsync(TOPIC_NAME, { kind = kind, id = id })
	if not success then
		warn("[PromptPurchase] Failed to queue message to MessagingService wrapper.")
	end

	promptInThisServer(kind, id)

	return string.format("%s purchase prompt (id %s) sent to all servers!", kind, tostring(id))
end
