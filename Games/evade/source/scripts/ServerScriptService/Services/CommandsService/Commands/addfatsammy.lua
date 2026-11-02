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
			if amount < 0 then
				return false, "Amount must be at least 0"
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
			v35:Play();
			task.wait(0.1);
			v9:PlaySound(l_ReplicatedStorage_0.Sounds.Events.FatSammy.Eat, l_Sammy_0:GetPivot().Position);

			if FatSammy.InMachine >= FatSammy.Max then
			end

			return true, string.format("Added %d brainrot(s) to FatSammy (%d/%d)", actualAdded, FatSammy.InMachine, FatSammy.Max)
		end,
	})
end

return module