local module = function(Conch, Config)
	local function listRituals()
		local RitualService = require(game:GetService("ServerScriptService").Services.RitualService)
		if not RitualService then
			return {}
		end
		local rituals = {}
		for ritualName, _ in pairs(RitualService.Rituals) do
			table.insert(rituals, ritualName)
		end
		return rituals
	end

	Conch.register("activateritual", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "Ritual",
					name = "Ritual",
				}
			}
		end,
		argumentChoices = function()
			return {
				{
					name = "Ritual",
					choices = listRituals(),
				}
			}
		end,
		callback = function(ritualName)
			local RitualService = require(game:GetService("ServerScriptService").Services.RitualService)
			if not RitualService then
				return false, "RitualService not initialized"
			end
			if not RitualService.Rituals[ritualName] then
				return false, "Ritual not found"
			end
			local success, err = pcall(function()
				RitualService:ActivateRitual(ritualName)
			end)
			return success, success and "Ritual executed" or ("Failed to execute ritual: " .. (err or "Unknown error"))
		end,
	})
end

return module
