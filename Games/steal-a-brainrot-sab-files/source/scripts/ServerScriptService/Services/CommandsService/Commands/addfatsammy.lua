local module = function(Conch, Config)
	Conch.register("addfatsammy", {
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
			if amount < 1 then
				return false, "Amount must be at least 1"
			end

			local ServerScriptService = game:GetService("ServerScriptService")

			local success, FatSammy = pcall(function()
				return require(ServerScriptService.Services.EventService.Events.FatSammy)
			end)

			if not success or not FatSammy then
				return false, "Could not find FatSammy module at ServerScriptService.Services.EventService.Events.FatSammy"
			end

			local beforeAmount = FatSammy.InMachine

			FatSammy.InMachine = math.min(FatSammy.InMachine + amount, FatSammy.Max)

			local afterAmount = FatSammy.InMachine
			local actualAdded = afterAmount - beforeAmount

			print(string.format("%d add", actualAdded))
			print(string.format("%d/%d", FatSammy.InMachine, FatSammy.Max))

			if FatSammy.InMachine >= FatSammy.Max then
			end

			return true, string.format("Added %d brainrot(s) to FatSammy (%d/%d)", actualAdded, FatSammy.InMachine, FatSammy.Max)
		end,
	})
end

return module