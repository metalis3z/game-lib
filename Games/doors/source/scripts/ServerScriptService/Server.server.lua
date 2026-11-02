game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(c)
		c.Humanoid:SetAttribute("SpeedBoost", 0)
		c.Humanoid:SetAttribute("SpeedBoostExtra", 0)
		c.Humanoid:SetAttribute("SpeedBoostBehind", 0)
		c.Humanoid:SetAttribute("SeekChase", false)
	end)
end)

repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hunt_FirstRoom" then
	return
else

end

-- Created and Fixed by BUILDG Studios

local JeffShopID = 52 -- Jeff room (52)
local FigurePreRoomID = 49 --Figure Pre room (49)
local BayourdID = 99 -- Bayourd (99)
local ElevatorRoomID = 100 -- Elevator room (100)
local InfirmaryID = 71 -- Infirmary room with Rift (71)

function update()
	local DarkChance1 = math.random(1, 15)
	local DarkChance2 = math.random(1, 15)
	
	game.Workspace.CurrentRooms:SetAttribute("DarkChance1", DarkChance1)
	game.Workspace.CurrentRooms:SetAttribute("DarkChance2", DarkChance2)
end

local HaltRoomRandom = math.random(15, 34)
local JackRoomRandom = math.random(5, 23)
local SeekRoomRandom = math.random(25, 35)
local SeekRoom2Random = math.random(75, 80)
local LookmanRoomRandom = math.random(6, 15)
local CourtyardRoomRandom = math.random(65, 70)

--[[local DarkRoomRandom1 = math.random(12, 15)
local DarkRoomRandom2 = math.random(25, 40)
local DarkRoomRandom3 = math.random(40, 55)
local DarkRoomRandom4 = math.random(60, 70)
local DarkRoomRandom5 = math.random(71, 75)
local DarkRoomRandom6 = math.random(78, 90)--
local DarkRoomRandom7 = math.random(90, 98)--]]

local LookMan1 = math.random(10, 19)
local LookMan2 = math.random(26, 35)
local LookMan3 = math.random(79, 85)
local LookMan4 = math.random(91, 97)

local SeekRoomMain = SeekRoomRandom + 3
local Seek1Room1 = SeekRoomRandom
local Seek1Room2 = SeekRoomRandom + 1
local Seek1Room3 = SeekRoomRandom + 2

local Seek2RoomMain = SeekRoom2Random + 3
local Seek2Room1 = SeekRoom2Random
local Seek2Room2 = SeekRoom2Random + 1
local Seek2Room3 = SeekRoom2Random + 2

local OnDeletedDoors = Instance.new("Folder")
OnDeletedDoors.Parent = workspace
OnDeletedDoors.Name = "OnDeletedDoors"

local Thing = Instance.new("Folder")
Thing.Parent = workspace
Thing.Name = "Things"

local Rooms = game.Workspace.CurrentRooms
Rooms:SetAttribute("CourtyardRoom", CourtyardRoomRandom)
Rooms:SetAttribute("SeekRoom", SeekRoomRandom)

Rooms:SetAttribute("Difficulty", 1)

Rooms:SetAttribute("JackRoom", JackRoomRandom)

Rooms:SetAttribute("JeffShopID", JeffShopID)
Rooms:SetAttribute("InfirmaryID", InfirmaryID)

Rooms:SetAttribute("FigurePreRoom", FigurePreRoomID)
Rooms:SetAttribute("BayourdId", BayourdID)
Rooms:SetAttribute("ElevatorRoomId", ElevatorRoomID)

Rooms:SetAttribute("HaltRoomRandom1", HaltRoomRandom)

Rooms:SetAttribute("SeekRoomMain", SeekRoomMain)
Rooms:SetAttribute("Seek1Room1", Seek1Room1)
Rooms:SetAttribute("Seek1Room2", Seek1Room2)
Rooms:SetAttribute("Seek1Room3", Seek1Room3)

Rooms:SetAttribute("Seek2RoomMain", Seek2RoomMain)
Rooms:SetAttribute("Seek2Room1", Seek2Room1)
Rooms:SetAttribute("Seek2Room2", Seek2Room2)
Rooms:SetAttribute("Seek2Room3", Seek2Room3)

Rooms:SetAttribute("LookManRoom1", LookMan1)
Rooms:SetAttribute("LookManRoom2", LookMan2)
Rooms:SetAttribute("LookManRoom3", LookMan3)
Rooms:SetAttribute("LookManRoom4", LookMan4)

Rooms:SetAttribute("DarkActived", false)
Rooms:SetAttribute("RoomDespawn", 0)
Rooms:SetAttribute("SeekMode", false)
Rooms:SetAttribute("Seek2Mode", false)

local Room = workspace.CurrentRooms:FindFirstChild("0")
local randomwallcolor = math.random(1, 6)
local coloratribute
local keyatribute = false
local Type = "Hotel_"
local Dark = false
local colors = Room.Colors

--local Keycrept = script.Scripts.UnlockPrompt:Clone()
--Keycrept.Enabled = true
--Keycrept.Parent = Room.Lock.UnlockPrompt
--Keycrept.Name = "AssetControl"

if randomwallcolor == 1 then
	local color = Instance.new("Color3Value")
	color.Value = Color3.fromRGB(109, 70, 70)
	color.Name = "color"
	color.Parent = colors.Wall
	colors.Wall.colortrue.Value = true
	coloratribute = Color3.fromRGB(109, 70, 70)
elseif randomwallcolor == 2 then
	local color = Instance.new("Color3Value")
	color.Value = Color3.fromRGB(89, 116, 117)
	color.Name = "color"
	color.Parent = colors.Wall
	colors.Wall.colortrue.Value = true
	coloratribute = Color3.fromRGB(89, 116, 117)
elseif randomwallcolor == 3 then
	local color = Instance.new("Color3Value")
	color.Value = Color3.fromRGB(69, 81, 109)
	color.Name = "color"
	color.Parent = colors.Wall
	colors.Wall.colortrue.Value = true
	coloratribute = Color3.fromRGB(69, 81, 109)
elseif randomwallcolor == 4 then
	local color = Instance.new("Color3Value")
	color.Value = Color3.fromRGB(76, 109, 91)
	color.Name = "color"
	color.Parent = colors.Wall
	colors.Wall.colortrue.Value = true
	coloratribute = Color3.fromRGB(76, 109, 91)
elseif randomwallcolor == 5 then
	local color = Instance.new("Color3Value")
	color.Value = Color3.fromRGB(134, 116, 95)
	color.Name = "color"
	color.Parent = colors.Wall
	colors.Wall.colortrue.Value = true
	coloratribute = Color3.fromRGB(134, 116, 95)
elseif randomwallcolor == 6 then
	local color = Instance.new("Color3Value")
	color.Value = Color3.fromRGB(72, 88, 125)
	color.Name = "color"
	color.Parent = colors
	colors.Wall.colortrue.Value = true
	coloratribute = Color3.fromRGB(72, 88, 125)
end

Room:SetAttribute("ColorAmbient", coloratribute)
Room:SetAttribute("RoomNumber", workspace.CurrentRooms.CurrentRoom.Value -1)
Room:SetAttribute("KeyRequire", keyatribute)
Room:SetAttribute("Dark", Dark)
Room:SetAttribute(Type, true)

while true do
	wait(2)
	update()
end