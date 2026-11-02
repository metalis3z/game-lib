local ServerScriptService = game:GetService("ServerScriptService")

local TOPIC = "refreshcraft-global-topic"
local subscribed = false

local module = function(Conch, Config)

	Conch.register("refreshcraft", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {}
		end,
		callback = function()
			-- Refresh locally first
			local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)
			if CraftingMachineService then
				CraftingMachineService.forceRegenerate()
			end
			
			-- Publish to all servers (only works in published game, not Studio)
			local MessagingService = game:GetService("MessagingService")
			local success, err = pcall(function()
				MessagingService:PublishAsync(TOPIC, {
					Refresh = true,
					Timestamp = os.time(),
			})
			end)

			if not success then
				warn("[RefreshCraft] Failed to publish (normal in Studio):", err)
			end

			return "Crafting machine refreshed!"
		end,
	})

	-- Subscribe to refresh events from other servers (only works in published game)
	if not subscribed then
		subscribed = true

		local MessagingService = game:GetService("MessagingService")
		local subSuccess, subErr = pcall(function()
			MessagingService:SubscribeAsync(TOPIC, function(message)
				local data = message.Data
				if typeof(data) ~= "table" then return end

				if data.Refresh then
					local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)
					if CraftingMachineService then
						CraftingMachineService.forceRegenerate()
						print("[RefreshCraft] Crafting machine refreshed from another server!")
					end
				end
			end)
		end)

		if not subSuccess then
			warn("[RefreshCraft] Failed to subscribe (normal in Studio):", subErr)
		end
	end
end

return module
