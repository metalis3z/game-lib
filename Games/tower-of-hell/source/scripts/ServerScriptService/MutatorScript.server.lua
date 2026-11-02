local replicatedStorage = game:GetService("ReplicatedStorage")
local lighting = game:GetService("Lighting")

local mutatorVals = replicatedStorage.Mutators
local mutatorEvent = replicatedStorage.MutatorEvent

mutatorEvent.OnServerEvent:Connect(function(player, mutator)
	if player.leaderstats.Coins.Value < mutator.Price then return end
	if not mutatorVals:FindFirstChild(mutator.Name) then return end
	if mutatorVals[mutator.Name].Value then return end
	mutatorVals[mutator.Name].Value = true
	player.leaderstats.Coins.Value = player.leaderstats.Coins.Value - mutator.Price
	mutatorEvent:FireAllClients(player.Name .. " bought " .. mutator.Name .. "!")
end)

spawn(function()
	for _,mutator in pairs(mutatorVals:GetChildren()) do
		mutator.Changed:Connect(function(val)
			if mutator.Name == "Low Gravity" then
				if val then workspace.Gravity = 125
				else workspace.Gravity = 196.2
				end
			elseif mutator.Name == "Foggy" then
				if val then lighting.FogEnd = 50
				else lighting.FogEnd = 100000
				end
			elseif mutator.Name == "Negative" then
				lighting:WaitForChild("Negative").Enabled = val
			elseif mutator.name == "Extra Time" then
				replicatedStorage.Minutes.Value = replicatedStorage.Minutes.Value + 2
			end
		end)
	end
end)