local desc = game.Workspace:GetDescendants()

local serva = game.ReplicatedStorage.server

local maxFuel = 10

local pricePerGal = 3

function init(attachment)
	local p = script.ProximityPrompt:Clone()
	p.Parent = attachment
	p.Triggered:Connect(function(player)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			local cars = game.Workspace.CivCars:GetChildren()
			local carf = false
			for ind,car in cars do
				if car:FindFirstChild("DriveSeat") and car:FindFirstChild("DriveSeat").Occupant and car:FindFirstChild("DriveSeat").Occupant == player.Character:FindFirstChild("Humanoid") then
					carf = true
					
					local Fuel = car:FindFirstChild("FUEL")
					-- how much fuel is missing
					local sub = math.clamp(maxFuel - Fuel.Value,0,maxFuel)
					if Fuel.Value == maxFuel then
						return serva:FireClient(player,"alert","Car is full!")
					end
					
					local price = math.round(sub*pricePerGal)
					local wallet = player.stored.Money
					
					if wallet.Value < price then
						return serva:FireClient(player,"alert","You do not have enough money ($"..price.." required)!")
					end
					
					wallet.Value -= price
					car.FUEL.Value = maxFuel
					
					serva:FireClient(player,"money","You paid $"..price.." for gas.")

					spawn(function()
						local UI = player.PlayerGui:FindFirstChild("A-Chassis Interface")
						UI.FuelOut.Value = false
						print("Removed fuel")
					end)
					serva:FireClient(player,"fillcar")
					print("Completed")
				end
			end
			wait(0.3)
			if carf == false then
				serva:FireClient(player,"alert","You are not inside a car!")
			end
		end		
	end)
end

for i,v in pairs(desc) do
	if v.Name == "GasAttachment" then
		init(v)
	end
end