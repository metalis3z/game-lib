repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hunt_FirstRoom" then

else
	return
end

local Hunt_Generation = require(game.ServerScriptService.Game.Directory.Hunt_RoomGeneration)
local KeyObtain = require(game.ServerScriptService.Game.Directory.Hunt_KeyObtain)

wait(1)

Hunt_Generation:HuntDoorKeyGenerateFirstRoom(game.Workspace.CurrentRooms:FindFirstChild("0"))
game.Workspace.CurrentRooms:FindFirstChild("0"):FindFirstChild("Door"):SetAttribute("LoadModule", "Loaded")
Hunt_Generation:SetRoomGenerate(true)
wait(.1)
KeyObtain:Load(game.Workspace.CurrentRooms:WaitForChild("0"):WaitForChild("Door").Lock, true)

function p()
	local ReplicatedStorage = game:GetService("ServerScriptService")
	local clonedRoom = game.Workspace.CurrentRooms:FindFirstChild("0")
	local Drawers = require(game.ServerScriptService.Game.Directory.Hunt_Drawers)
	local Furnituress = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")

	if clonedRoom:FindFirstChild("FurniturePoints") then
		for i, v in pairs(clonedRoom:WaitForChild("FurniturePoints"):GetChildren()) do
			local addFurniture = math.random(1, 3)

			if string.find(v.Name, "Smalltabl") then
				local Dresser = Furnituress:WaitForChild("Backdoor_TableSmall"):Clone()
				Dresser.Name = "Table"
				Dresser.Parent = clonedRoom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)

				Drawers.Scan(Dresser)
			end

			if string.find(v.Name, "JustRandomPart") then
				if addFurniture == 1 then
					local Dresser = Furnituress:WaitForChild("Backdoor_TableCommon"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedRoom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

				elseif addFurniture == 2 then
					local Dresser = Furnituress:WaitForChild("Backdoor_TablePress"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedRoom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

				elseif addFurniture == 3 then
					local Dresser = Furnituress:WaitForChild("Backdoor_TableWithout"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedRoom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)
				end
			end
		end

		if clonedRoom:FindFirstChild("FurniturePoints") then
			clonedRoom:FindFirstChild("FurniturePoints"):Destroy()
		end
	end
end

p()