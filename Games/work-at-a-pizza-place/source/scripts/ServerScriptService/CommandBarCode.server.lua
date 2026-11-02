


--ban player pixel art
local userId = 82471
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local data = (game.PlaceId == Enums.PizzaPlaceId    and game:GetService("DataStoreService"):GetDataStore("PizzaPlace1")) or
		     (game.PlaceId == Enums.PizzaPlaceTestId and game:GetService("DataStoreService"):GetDataStore("TestDataStore" ..  Enums.TestDataStoreVersion))

local playerData = data:GetAsync(tostring(userId))

local numDays = 5
local secondsInADay = 86400 
--playerData.Banned = tick() + (secondsInADay * numDays)
playerData.Banned = false --Unban player
playerData.CanvasProjects = {}

data:SetAsync(tostring(userId),playerData)

--get selection path
print("game." .. game.Selection:Get()[1]:GetFullName())



--reset saved data
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
game:GetService("DataStoreService"):GetGlobalDataStore():SetAsync("82471",-1)
game:GetService("DataStoreService"):GetDataStore("TestDataStore" ..  Enums.TestDataStoreVersion):SetAsync("82471",-1)


--printing values for online mode
local Global = require(game.ServerScriptService:WaitForChild("Global"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
Utility:PrintTable(Global.Players[game.Players.Dued1].House.Furniture)



--convert offset-only to scale
local selection = game.Selection:Get()[1]
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
selection.Size = UDim2.new(selection.AbsoluteSize.X / selection.Parent.AbsoluteSize.X,0,selection.AbsoluteSize.Y / selection.Parent.AbsoluteSize.Y,0)
selection.Position = UDim2.new(Utility:ConvertScale(selection.AbsolutePosition.X,{selection.Parent.AbsolutePosition.X,selection.Parent.AbsolutePosition.X+ selection.Parent.AbsoluteSize.X},{0,1})
,0,Utility:ConvertScale(selection.AbsolutePosition.Y,{selection.Parent.AbsolutePosition.Y,selection.Parent.AbsolutePosition.Y+ selection.Parent.AbsoluteSize.Y},{0,1})
,0)



--convert offset-only to scale BUTTONS ONLY
local selection = game.Selection:Get()[1]
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
selection.Size = UDim2.new(selection.AbsoluteSize.X / (selection.Parent.AbsoluteSize.X-24),0,selection.AbsoluteSize.Y / (selection.Parent.AbsoluteSize.Y-24),0)
selection.Position = UDim2.new(Utility:ConvertScale(selection.AbsolutePosition.X,{selection.Parent.AbsolutePosition.X+12,selection.Parent.AbsolutePosition.X + 12 + (selection.Parent.AbsoluteSize.X-24)},{0,1})
,0,Utility:ConvertScale(selection.AbsolutePosition.Y,{selection.Parent.AbsolutePosition.Y+12,selection.Parent.AbsolutePosition.Y + 12 + (selection.Parent.AbsoluteSize.Y-24)},{0,1})
,0)
--Utility:ConvertScale(selection.AbsolutePosition.X,{selection.Parent.AbsolutePosition.X,selection.Parent.AbsolutePosition.X+ selection.Parent.AbsoluteSize.X},{0,1})


--insert aspect ratio
local selection = game.Selection:Get()[1]
local ui = Instance.new("UIAspectRatioConstraint")
ui.AspectRatio = selection.AbsoluteSize.X/selection.AbsoluteSize.Y
ui.AspectType = Enum.AspectType.ScaleWithParentSize
ui.DominantAxis = Enum.DominantAxis.Width
ui.Parent = selection


--get house positions
for _,s in ipairs(game.Selection:Get()) do
	print("CFrame.new(" .. s.Upgrades.Medium.Marker.CFrame .. "),")
end

function PutObjectPointerInsideScript(model)
	for _,child in ipairs(model:GetChildren()) do
		if child:IsA("Script") then
			local str = Instance.new("ObjectValue")
			str.Name = "SoundFXId"
			str.Parent = child
			child.SoundId = ""
		else
			PutSoundIdInsideSound(child)
		end
	end
end

PutObjectPointerInsideScript(game.ServerScriptService.MainModule)


for _,obj in ipairs(game.Players.Dued1.PlayerGui:GetChildren()) do
	obj:Destroy()
end

workspace.Dued1:Destroy()



function DisableScripts(model)
	for _,child in ipairs(model:GetChildren()) do
		if child:IsA("Script") then
			child.Disabled = true
		else
			DisableScripts(child)
		end
	end
end
DisableScripts(game.ServerScriptService.MainModule)


function PutSoundIdInsideSound(model)
	for _,child in ipairs(model:GetChildren()) do
		if child:IsA("Sound") then
			local str = Instance.new("StringValue",child)
			str.Value = child.SoundId
			str.Name = "SoundFXId"
			child.SoundId = ""
		else
			PutSoundIdInsideSound(child)
		end
	end
end

PutSoundIdInsideSound(game.ServerScriptService.MainModule)





function ClearJoints(root)
	for _,obj in ipairs(root:GetChildren()) do
		if obj:IsA("JointInstance") then
			obj:Destroy()
		else
			ClearJoints(obj)
		end
	end
end

ClearJoints(workspace.House)

print(workspace.House.Upgrades.Backyard.Doors.FrontDoor.DoorTouch.CFrame:toObjectSpace(workspace.CurrentCamera.CoordinateFrame))
workspace.CurrentCamera.CameraType = "Scriptable"
workspace.CurrentCamera.CFrame = workspace.House.Upgrades.Backyard.Doors.FrontDoor.DoorTouch.CFrame:toWorldSpace(CFrame.new(-28.2813873, 10.1073589, 18.9193115, 0.531057775, 0.344561845, -0.774115622, -0, 0.913588047, 0.406641483, 0.847335696, -0.215950117, 0.485167891))

--change the name of floor and wallpaper texture objects
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local house = workspace.House
for _,upgrade in ipairs(house.Upgrades:GetChildren()) do
	for _,part in ipairs(upgrade:GetChildren()) do
		if part:IsA("BasePart") then
			for _,room in ipairs(upgrade.Rooms:GetChildren()) do
				if Utility.IsPointInsideBox(room,part.Position) then
					if part.Name == "Wall" and part:FindFirstChild("Wallpaper") then
						part.Wallpaper.Name = room.Name
					elseif part.Name == "Floor" and part:FindFirstChild("Floor") then
						part.Floor.Name = room.Name
					end
				end
			end
				
		end
	end
end

--virus search
local function search(dir)
	for _,obj in ipairs(dir:GetChildren()) do
		if obj:IsA("RotateP") then
			print(obj)
		end
		search(obj)
	end
end
search(workspace)



--change transparency of room blocks
for _,house in ipairs(workspace.House.Upgrades:GetChildren()) do
	for _,room in ipairs(house.Rooms:GetChildren()) do
		room.Transparency = 1
	end
end



--set season or time of day
local Environment = require(game.ServerScriptService:WaitForChild("Environment"))
Environment:SetTimeOfDay("Morning")
Environment:SetSeason("Winter")

	
	
--set saved data values
local userId = 82471
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local data = (game.PlaceId == Enums.PizzaPlaceId    and game:GetService("DataStoreService"):GetDataStore("PizzaPlace1")) or
		     (game.PlaceId == Enums.PizzaPlaceTestId and game:GetService("DataStoreService"):GetDataStore("TestDataStore" ..  Enums.TestDataStoreVersion))

local playerData = data:GetAsync(tostring(userId))
Utility:PrintTable(playerData)

playerData.Moneyz = playerData.Moneyz + 1

data:SetAsync(tostring(userId),playerData)


--printing saved data
local userId = 63639300
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))

local data =game:GetService("DataStoreService"):GetDataStore("PizzaPlace2")--[[(game.PlaceId == Enums.PizzaPlaceId and game:GetService("DataStoreService"):GetDataStore("PizzaPlace1")) or
			(game.PlaceId == Enums.PizzaPlaceTestId and game:GetService("DataStoreService"):GetDataStore("TestDataStore" ..  Enums.TestDataStoreVersion)) or
			 (game.PlaceId == Enums.PizzaPlacePrivateTestId and game:GetService("DataStoreService"):GetDataStore("PrivateTestDataStore" ..  Enums.PrivateTestDataStoreVersion)) or
				 (game.PlaceId == Enums.PizzaPlaceInsideUniverseTestId and game:GetService("DataStoreService"):GetDataStore("PizzaPlace" .. Enums.InternalTestDataStoreVersion))
]]
local playerData = data:GetAsync(tostring(userId))
Utility:PrintTable(playerData)




--for conversion testing
local userId = 82471
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))

local data = game:GetService("DataStoreService"):GetGlobalDataStore()
local playerData = data:GetAsync(tostring(userId))
Utility:PrintTable(playerData)


--setting data for old version
local userId = 82471
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local data = game:GetService("DataStoreService"):GetGlobalDataStore()
local playerData = data:GetAsync(tostring(userId))

playerData.Upgrade = 7

data:SetAsync(tostring(userId),playerData)


--[[

function search(obj)
	for _,child in ipairs(obj:GetChildren()) do
		if child:FindFirstChild("Script") and child.Script:FindFirstChild("Laying") then
			child.Script:Destroy()
		else
			search(child)
		end
	end
end
search(game.ReplicatedStorage)]]




--edit path nodes poperties
for _,chair in ipairs(workspace.Seating:GetChildren()) do
	for _,seat in ipairs(chair:GetChildren()) do
		if seat:IsA("Seat") then
			for _,folder in ipairs({seat.PathExit,seat.PathEnter}) do
				for _,node in ipairs(folder:GetChildren()) do
					node.Anchored = true
					node.CanCollide = false
					node.Transparency = 1
					node.Locked = true
				end
			end
		end
	end
end















--remove/add water
workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-7,-8,-197), Vector3int16.new(24,-2,60)),Enum.CellMaterial.Empty,0,0)
workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-66,-8,-157), Vector3int16.new(66,-2,-65)),Enum.CellMaterial.Empty,0,0)
workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-500,-7,-500), Vector3int16.new(500,-2,500)),Enum.CellMaterial.Water,0,0)


--set updated mainmodule id
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))

local DataStore = Enums.DataStore

DataStore:GetGlobalDataStore():SetAsync("MainModule",419593920)



--change color of chairs
for _,mo in ipairs(workspace:GetChildren()) do 
	if mo.Name == "Table" or mo.Name == "Chair" then 
		for _,part in ipairs(mo:GetChildren()) do
			if part.Name == "Cushion" then
				part.BrickColor = BrickColor.new("Bright red")
			elseif part.Name == "Wood" then
				--part.BrickColor = BrickColor.new("Brown")
			end
		end
	end
end


--change color of tables
for _,mo in ipairs(workspace:GetChildren()) do 
	if mo.Name == "Table" then 
		for _,part in ipairs(mo:GetChildren()) do
			if part.BrickColor == BrickColor.new("Burgundy") then
				part.Name = "Cushion"
			elseif part.BrickColor == BrickColor.new("Reddish brown") then
				part.Name = "Wood"
			end
		end
	end
end



--turn trees into balls

for _,obj in ipairs(workspace:GetChildren()) do
	if obj.Name == "Tree" then
		for _,part in ipairs(obj:GetChildren()) do
			if part.Size.Y == 14 and part.Name ~= "trunk" then
				
				part.Shape = "Ball"
				part.Size = Vector3.new(17,17,17)
				
			elseif part.Name ~= "trunk" then
				part.Transparency = 1
			end
		end
	end
end



--add lights to trees

for _,obj in ipairs(workspace:GetChildren()) do
	if obj.Name == "Tree" then
		for _,part in ipairs(obj:GetChildren()) do
			if part:FindFirstChild("ParticleEmitter") then
				local l = Instance.new("PointLight",part)
				l.Enabled = false
				l.Range = 20
				l.Brightness = 1999
			end
		end
	end
end