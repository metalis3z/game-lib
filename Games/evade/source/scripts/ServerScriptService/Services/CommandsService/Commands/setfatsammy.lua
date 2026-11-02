local Players = game:GetService("Players")
local module = function(Conch, Config)
	Conch.register("setfatsammy", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "number",
					name = "Amount",
				},
			}
		end,
		callback = function(amount)
			if amount < 0 then
				return false, "Amount must be at least 0"
			end

			if amount > 1000000000000000000000000000000000000000000000000000000000000000000 then
				return false, "Amount cannot exceed 1000000000000000000000000000000000000000000000000000000000000000000"
			end

			local ServerScriptService = game:GetService("ServerScriptService")

			local success, FatSammy = pcall(function()
				return require(ServerScriptService.Services.EventService.Events.FatSammy)
			end)

			if not success or not FatSammy then
				return false, "Could not find FatSammy module at ServerScriptService.Services.EventService.Events.FatSammy"
			end

			local currentProgress = FatSammy.InMachine

			FatSammy.Max = amount

			FatSammy.InMachine = math.min(currentProgress, amount)

			FatSammy.FullTriggered = false

			print(string.format("%d", amount))
			print(string.format("%d/%d", FatSammy.InMachine, FatSammy.Max))

			return true, string.format("Set FatSammy max brainrots to %d", amount)
		end,
	})
end



return module