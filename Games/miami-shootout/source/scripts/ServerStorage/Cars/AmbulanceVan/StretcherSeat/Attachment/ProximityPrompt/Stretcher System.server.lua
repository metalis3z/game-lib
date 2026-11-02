local seat = script.Parent.Parent.Parent
local proximity = script.Parent
local loaded = false

seat:GetPropertyChangedSignal("Occupant"):Connect(function()
	local occpuant = seat.Occupant
	if not occpuant then
		seat.Disabled = true
		loaded = false
		proximity.ActionText = "Load"
	end
end)

local maxTries = 8

proximity.Triggered:Connect(function(p)
	if p.Team == game.Teams.EMS then
		print("triggered load")
		if p.Character:FindFirstChild("Stretcher") then
			print("has stretcher")
			if loaded then
				-- unload
				if not seat.Occupant then 
					loaded = false
					proximity.ActionText = "Load"
					return game.ReplicatedStorage.server:FireClient(p,"alert","Nobody is in the ambulance!")
				end
				
				local sseat = p.Character:FindFirstChild("Stretcher"):FindFirstChild("Seat")
				if sseat.Occupant then
					return game.ReplicatedStorage.server:FireClient(p,"alert","Your stretcher is occupied!")
				end
				
				local targetOccupant = seat.Occupant
				
				seat.Disabled = true
				local tries = 0
				
				repeat wait(0.5) 
					sseat:Sit(targetOccupant)		
					tries = tries + 1
				until tries > maxTries or sseat.Occupant == targetOccupant
				
				if tries > maxTries then
					return game.ReplicatedStorage.server:FireClient(p,"msg","Failed to unload ambulance, try again")
				end
				
				loaded = false
				proximity.ActionText = "Load"
				
				game.ReplicatedStorage.server:FireClient(p,"msg",targetOccupant.Parent.Name .. " was unloaded onto the stretcher")
			else
				-- load
				if seat.Occupant then return game.ReplicatedStorage.server:FireClient(p,"alert","Someone is already in the ambulance!") end
				local sseat = p.Character:FindFirstChild("Stretcher"):FindFirstChild("Seat")
				if sseat.Occupant == nil then
					return game.ReplicatedStorage.server:FireClient(p,"alert","Your stretcher is not occupied!")
				end
				
				local targetOccupant = sseat.Occupant

				seat.Disabled = false
				local tries = 0

				repeat wait(0.5) 
					seat:Sit(targetOccupant)
					tries = tries + 1
				until tries > maxTries or seat.Occupant == targetOccupant				
				
				if tries > maxTries then
					return game.ReplicatedStorage.server:FireClient(p,"msg","Failed to unload ambulance, try again")
				end
				
				loaded = true
				proximity.ActionText = "Unload"
				
				game.ReplicatedStorage.server:FireClient(p,"msg",targetOccupant.Parent.Name .. " was loaded into the ambulance")
			end
		end
	end
end)