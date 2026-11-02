repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hotel_FirstRoom" and game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("Type") == "Hotel" then

else
	return
end

local RoomInteractable = require(game.ServerScriptService.Game.Controls.RoomInteractable)

local room = game.Workspace.CurrentRooms:FindFirstChild("0")
local Drawers = require(game.ServerScriptService.Game.Directory.Drawers)
local ItemsControls = require(game.ServerScriptService.Game.Controls.Items)

-- Created and Fixed by BUILDG Studios

RoomInteractable:PlayerAttribute(game.Workspace.CurrentRooms["0"])

local FurnitureSpawned = false

local ReplicatedStorage = game:GetService("ServerScriptService")
local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
local Furnituress = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")

local d = require(ReplicatedStorage2.ClientModules.Module_Events)

local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
--

--ItemsControls:BuyableItem(game.Workspace.CurrentRooms["0"].Stuff.Crucifix)

function generateRoom() -- Function Generator Rooms
	local clonedroom = room
	
	--require(game.ServerScriptService.Game.Directory.EntryRoomNodes).Path(clonedroom)
	
	if FurnitureSpawned == true then
		return
	end
	FurnitureSpawned = true
	for i, v in pairs(clonedroom:WaitForChild("PaintingPoint"):GetChildren()) do
		local addPainting = math.random(1, 5) 

		if addPainting < 3 then
			local Painting = Paintings:WaitForChild("Painting_Small"):Clone()
			Painting.Parent = room:WaitForChild("Assets")
			require(game.ServerScriptService.Game.Controls.Paintings):Small(Painting)
			Painting:PivotTo(v.CFrame)
		end
	end
	
	if clonedroom:FindFirstChild("FurniturePoint") then
		for i, v in pairs(clonedroom:WaitForChild("FurniturePoint"):GetChildren()) do
			local addFurniture = math.random(1, 240)

			if v:GetAttribute("Type") == "Dresser" then
				--[[local Dresser = Furnituress:WaitForChild("Hotel_Dresser"):Clone()
				Dresser.Name = "Dresser"
				Dresser.Parent = clonedroom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)
				
				Drawers.Scan(Dresser)
				print("Spawned", Dresser:GetPivot().Position)]]
			elseif v:GetAttribute("Type") == "Table" then
				local Dresser = Furnituress:WaitForChild("Hotel_Table"):Clone()
				Dresser.Name = "Table"
				Dresser.Parent = clonedroom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)

				Drawers.SetDebris(Dresser)
				
			elseif v:GetAttribute("Type") == "TableObtain" then
				local Dresser = Furnituress:WaitForChild("Hotel_RedTable"):Clone()
				Dresser.Name = "Table"
				Dresser.Parent = clonedroom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)

				Drawers.SetDebris(Dresser)
				
			elseif v:GetAttribute("Type") == "Random" then
				if addFurniture > 0 and addFurniture < 25 then
					local Dresser = Furnituress:WaitForChild("Hotel_Drawer_Table"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

					Drawers.SetDebris(Dresser)
					
				elseif addFurniture > 35 and addFurniture < 45 then
					local Dresser = Furnituress:WaitForChild("Hotel_Table"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)
					
				elseif addFurniture > 45 and addFurniture < 85 then
					local Dresser = Furnituress:WaitForChild("Hotel_TDrawer"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

					Drawers.SetDebris(Dresser)
					
				elseif addFurniture > 85 and addFurniture < 125 then
					local Dresser = Furnituress:WaitForChild("Hotel_RedTableFront"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)
					
				elseif addFurniture > 125 and addFurniture < 165 then
					local Dresser = Furnituress:WaitForChild("Hotel_RedTableOpened"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)
					
				end
			end
		end
		-- clonedroom:WaitForChild("FurniturePoint"):Destroy()
		--print("potato")
	end
end

generateRoom()