local desc = game.Workspace:GetDescendants()

local serva = game.ReplicatedStorage.server

local maxFuel = 10
local pricePerGal = 50

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
					local sub = math.clamp(maxFuel - Fuel.Value,0,maxFuel)
					if Fuel.Value == maxFuel then
						return game.ReplicatedStorage.Notify:FireClient(player,"Car fuel is already full!", 3)
					end
					
					local price = math.round(sub*pricePerGal)
					local wallet = player.stored.Money
					
					if wallet.Value < price then
						return game.ReplicatedStorage.Notify:FireClient(player,"You do not have enough money, (" .. tostring(price) .. ")", 3)
					end
					
					wallet.Value -= price
					car.FUEL.Value = maxFuel
					game.ReplicatedStorage.server:FireClient(player,"money", price)

					spawn(function()
						local UI = player.PlayerGui:FindFirstChild("A-Chassis Interface")
						UI.FuelOut.Value = false
					end)
					serva:FireClient(player,"fillcar")
				end
			end
			wait(0.3)
			if carf == false then
				game.ReplicatedStorage.Notify:FireClient(player,"You are not inside a car!", 3)
			end
		end		
	end)
end

for i,v in pairs(desc) do
	if v.Name == "FuelArea" then
		init(v)
	end
end