local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local CupidsMachineService = require(ServerScriptService.Services.CupidsMachineService)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("forcecupidsoutput", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "Output1",
				suggestions = {
					"Heart Lucky Block",
					"Nothing", 
					"Cupid Cupid Sahur",
					"Lovin Rose"
				}
			},
			{
				kind = "argument",
				type = "number",
				name = "Chance1",
				optional = true
			},
			{
				kind = "argument",
				type = "string",
				name = "Output2",
				suggestions = {
					"Heart Lucky Block",
					"Nothing", 
					"Cupid Cupid Sahur",
					"Lovin Rose"
				},
				optional = true
			},
			{
				kind = "argument",
				type = "number",
				name = "Chance2",
				optional = true
			},
			{
				kind = "argument",
				type = "string",
				name = "Output3",
				suggestions = {
					"Heart Lucky Block",
					"Nothing", 
					"Cupid Cupid Sahur",
					"Lovin Rose"
				},
				optional = true
			},
			{
				kind = "argument",
				type = "number",
				name = "Chance3",
				optional = true
			},
			{
				kind = "argument",
				type = "string",
				name = "Output4",
				suggestions = {
					"Heart Lucky Block",
					"Nothing", 
					"Cupid Cupid Sahur",
					"Lovin Rose"
				},
				optional = true
			},
			{
				kind = "argument",
				type = "number",
				name = "Chance4",
				optional = true
			}
		end,

		callback = function(player, output1, chance1, output2, chance2, output3, chance3, output4, chance4)
			local channel = Synchronizer:Get(player)
			if not channel then
				return false, "Player channel not found"
			end

		
			local outputs = {}
			local totalChance = 0

			local function addOutput(name, chance)
				if name and chance then
					table.insert(outputs, {
						Name = name,
						Chance = chance
					})
					totalChance = totalChance + chance
				end
			end

		
			addOutput(output1, chance1 or 0)
			addOutput(output2, chance2)
			addOutput(output3, chance3)
			addOutput(output4, chance4)

	
			if #outputs == 0 then
				return false, "No outputs specified"
			end

		
			if math.abs(totalChance - 100) > 0.01 then
				if totalChance == 0 then
					
					local equalChance = 100 / #outputs
					for _, output in ipairs(outputs) do
						output.Chance = equalChance
					end
				else
			
					for _, output in ipairs(outputs) do
						output.Chance = (output.Chance / totalChance) * 100
					end
				end
			end


			channel:Set("CupidsMachine.ForcedOutputs", outputs)

		
			local machineData = channel:Get("CupidsMachine") or {}
			if machineData.StartTime and machineData.StartTime > 0 then
			
				local currentRecipe = nil
				local pcallSuccess, fetchResult = pcall(function()
					return CupidsMachineService.Fetch.OnServerInvoke(player)
				end)

				if pcallSuccess and fetchResult then
				
					require(ReplicatedStorage.Packages.Net):RemoteEvent("CupidsMachineService/Update"):FireClient(player, {
						Recipe = fetchResult.Recipe,
						Outputs = outputs, 
						Refresh = fetchResult.Refresh,
						StartTime = machineData.StartTime or 0,
						FinishTime = machineData.FinishTime or 0,
						InstantSkips = machineData.InstantSkips or 0
					})
				end
			end

	
			local outputList = {}
			for _, output in ipairs(outputs) do
				table.insert(outputList, string.format("%s (%.2f%%)", output.Name, output.Chance))
			end

			return true, string.format("Forced outputs set for %s:\n%s", player.Name, table.concat(outputList, "\n"))
		end,
	})

	Conch.register("clearcupidsoutput", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				}
		end,

		callback = function(player)
			local channel = Synchronizer:Get(player)
			if not channel then
				return false, "Player channel not found"
			end

			channel:Set("CupidsMachine.ForcedOutputs", nil)

			
			local machineData = channel:Get("CupidsMachine") or {}
			if machineData.StartTime and machineData.StartTime > 0 then
				local pcallSuccess, fetchResult = pcall(function()
					return CupidsMachineService.Fetch.OnServerInvoke(player)
				end)

				if pcallSuccess and fetchResult then
					require(ReplicatedStorage.Packages.Net):RemoteEvent("CupidsMachineService/Update"):FireClient(player, {
						Recipe = fetchResult.Recipe,
						Outputs = fetchResult.Outputs, 
						Refresh = fetchResult.Refresh,
						StartTime = machineData.StartTime or 0,
						FinishTime = machineData.FinishTime or 0,
						InstantSkips = machineData.InstantSkips or 0
					})
				end
			end

			return true, string.format("Cleared forced outputs for %s", player.Name)
		end,
	})

	Conch.register("forcecupidsrecipe", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "string",
				name = "Brainrot1"
			},
			{
				kind = "argument",
				type = "string",
				name = "Brainrot2"
			},
			{
				kind = "argument",
				type = "string",
				name = "RecipeName",
				optional = true
			},
			{
				kind = "argument",
				type = "number",
				name = "Cost",
				optional = true
			}
		end,

		callback = function(player, brainrot1, brainrot2, recipeName, cost)
			local channel = Synchronizer:Get(player)
			if not channel then
				return false, "Player channel not found"
			end

	
			channel:Set("CupidsMachine.ForcedRecipe", {
				Name = recipeName or "Forced Match",
				Recipe = {brainrot1, brainrot2},
				Cost = cost or 250
			})

			
			local machineData = channel:Get("CupidsMachine") or {}
			if machineData.StartTime and machineData.StartTime > 0 then
				local pcallSuccess, fetchResult = pcall(function()
					return CupidsMachineService.Fetch.OnServerInvoke(player)
				end)

				if pcallSuccess and fetchResult then
					local forcedOutputs = channel:Get("CupidsMachine.ForcedOutputs")
					require(ReplicatedStorage.Packages.Net):RemoteEvent("CupidsMachineService/Update"):FireClient(player, {
						Recipe = { -- Forced recipe
							Name = recipeName or "Forced Match",
							Recipe = {brainrot1, brainrot2},
							Cost = cost or 250
						},
						Outputs = forcedOutputs or fetchResult.Outputs, -- Use forced outputs if available
						Refresh = fetchResult.Refresh,
						StartTime = machineData.StartTime or 0,
						FinishTime = machineData.FinishTime or 0,
						InstantSkips = machineData.InstantSkips or 0
					})
				end
			end

			return true, string.format("Forced recipe set for %s: %s + %s", player.Name, brainrot1, brainrot2)
		end,
	})
end

return module