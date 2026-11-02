local lighting = game:GetService("Lighting")

local spawns = game.Workspace:WaitForChild("Prison_spawn")
local CafeteriaSpawn = spawns:WaitForChild("Cafeteria"):GetChildren()
local CellSpawn = spawns:WaitForChild("Cells"):GetChildren()
local ExteriorSpawn = spawns:WaitForChild("Courtyard"):GetChildren()
local NexusSpawn = spawns:WaitForChild("Nexus"):GetChildren()
local SpawnCell = spawns:WaitForChild("cellsblock"):GetChildren()

local Lunch = game.Workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("Lunch"):GetChildren()

local cells = game.Workspace:WaitForChild("Prison_Cellblock"):WaitForChild("doors"):GetChildren()

local Annoucement = game.ReplicatedStorage:WaitForChild("AnnoucementDay")

local DayValues = game.ReplicatedStorage:WaitForChild("DayValue")
local Title = DayValues:WaitForChild("Title")
local Desc = DayValues:WaitForChild("Desc")

local DoorValue = game.ReplicatedStorage:WaitForChild("DoorValue")
local OpenDoorCV = DoorValue:WaitForChild("OpenDoorCV")

local times = 719

local speed = false

while true do
	times = times + 1
	
	lighting:SetMinutesAfterMidnight(times)
	
	
	if times == 1440 then
		times = 0
	elseif times == 1320 then
		speed = true
	elseif times == 360 then
		speed = false
		
		--print("ejhfiqshdi")

		for i,v in pairs(CafeteriaSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(CellSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(ExteriorSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(NexusSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(SpawnCell) do
			v.Enabled = false
		end


		for i,v in pairs(Lunch) do
			if v:IsA("UnionOperation") then
				v.Transparency = 0
				v.CanCollide = true
			end
		end

		for i, v in pairs(cells) do
			spawn(function()
				for a = 1, 15 do
					v.CFrame = v.CFrame * CFrame.new(-0.28, 0, 0)

					wait()
				end
			end)
		end

		Title.Value = "Breakfast" 
		Desc.Value = "Breakfast time. Get you mandatory breakfast in the cafeteria."

		Annoucement:FireAllClients("Breakfast", "Breakfast time. Get you mandatory breakfast in the cafeteria.", "Breakfast time. Get you mandatory breakfast in the cafeteria.")

	elseif  times == 480 then
		for i,v in pairs(CafeteriaSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(CellSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(ExteriorSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(NexusSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(SpawnCell) do
			v.Enabled = false
		end

		for i,v in pairs(Lunch) do
			if v:IsA("UnionOperation") then
				v.Transparency = 1
				v.CanCollide = false
			end
		end

		OpenDoorCV.Value = true

		Title.Value = "Yartime" 
		Desc.Value = "Yardtime, folks. Get to the yard."

		Annoucement:FireAllClients("Yartime", "Yardtime, folks. Get to the yard.", "Yardtime, folks. Get to the yard.")
	end

	if lighting.TimeOfDay == "12:00:00" then
		for i,v in pairs(CafeteriaSpawn) do
			v.Enabled = true
		end
		
		for i,v in pairs(CellSpawn) do
			v.Enabled = false
		end
		
		for i,v in pairs(ExteriorSpawn) do
			v.Enabled = false
		end
		
		for i,v in pairs(NexusSpawn) do
			v.Enabled = true
		end
		
		for i,v in pairs(SpawnCell) do
			v.Enabled = false
		end
		
		for i,v in pairs(Lunch) do
			if v:IsA("UnionOperation") then
				v.Transparency = 0
				v.CanCollide = true
			end
		end
		
		spawn(function()
			wait(30)
			OpenDoorCV.Value = false
		end)
		
		Title.Value = "Lunch" 
		Desc.Value = "Lunch is being served in the cafeteria. Attendance is mandatory."

		Annoucement:FireAllClients("Lunch", "Lunch is being served in the cafeteria. Attendance is mandatory", "Lunch is being served in the cafeteria. Attendance is mandatory.")
		
	elseif lighting.TimeOfDay == "14:00:00" then
		for i,v in pairs(CafeteriaSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(CellSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(ExteriorSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(NexusSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(SpawnCell) do
			v.Enabled = false
		end

		for i,v in pairs(Lunch) do
			if v:IsA("UnionOperation") then
				v.Transparency = 1
				v.CanCollide = false
			end
		end
		
		OpenDoorCV.Value = true

		Title.Value = "Free time" 
		Desc.Value = "It is now free-time for all prisoners."

		Annoucement:FireAllClients("Free time", "It is now free-time for all prisoners.", "It is now free-time for all prisoners.")
		
	elseif lighting.TimeOfDay == "18:00:00" then
		for i,v in pairs(CafeteriaSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(CellSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(ExteriorSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(NexusSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(SpawnCell) do
			v.Enabled = false
		end

		for i,v in pairs(Lunch) do
			if v:IsA("UnionOperation") then
				v.Transparency = 0
				v.CanCollide = true
			end
		end
		
		spawn(function()
			wait(30)
			OpenDoorCV.Value = false
		end)

		Title.Value = "Dinner" 
		Desc.Value = "all prisoners must report to the cafeteria for dinner."

		Annoucement:FireAllClients("Dinner", "all prisoners must report to the cafeteria for dinner.", "all prisoners must report to the cafeteria for dinner.")
		
	elseif lighting.TimeOfDay == "21:00:00" then
		for i,v in pairs(CafeteriaSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(CellSpawn) do
			v.Enabled = true
		end

		for i,v in pairs(ExteriorSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(NexusSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(SpawnCell) do
			v.Enabled = false
		end

		for i,v in pairs(Lunch) do
			if v:IsA("UnionOperation") then
				v.Transparency = 1
				v.CanCollide = false
			end
		end
		
		Title.Value = "Lockdown" 
		Desc.Value = "Prisoners must return to their cell block for lockup. Doors close and light out at 10:00pm"

		Annoucement:FireAllClients("Lockdown", "Prisoners must return to their cell block for lockup. Doors close and light out at 10:00pm", "Prisoners must return to their cell block for lockup. Doors close and light out at 10:00pm")
		
	elseif lighting.TimeOfDay == "22:00:00" then
		for i,v in pairs(CafeteriaSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(CellSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(ExteriorSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(NexusSpawn) do
			v.Enabled = false
		end

		for i,v in pairs(SpawnCell) do
			v.Enabled = true
		end
		
		
		for i, v in pairs(cells) do
			spawn(function()
				for a = 1, 15 do
					v.CFrame = v.CFrame * CFrame.new(0.28, 0, 0)
					
					wait()
				end
			end)
		end
		
		for i,v in pairs(game.Players:GetChildren()) do
			if v.Team == game.Teams.Inmates then
				v:WaitForChild("valueArrest").Value = true
			end
		end
		
		Title.Value = "Lights out" 
		Desc.Value = "all prisoners must be in their cell. Lights are out."

		Annoucement:FireAllClients("Lights out", "all prisoners must be in their cell. Lights are out.", "all prisoners must be in their cell. Lights are out.")
	end
	
	if speed == true then
		wait(0.1)	
	else
		wait(1)
	end
end