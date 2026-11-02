local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):WaitForChild("4Eyeball")

local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

local vvv = game:GetService("PhysicsService")

local door = script.Parent.Parent
door:PivotTo(script.Parent.Parent.Parent:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, 0.7))

local Music = game.SoundService.Main:FindFirstChild("ChaseInSession")
local l__TweenService__1 = game:GetService("TweenService");

local requd = require(game.ServerScriptService.Game.Directory["RoomGeneration"])
requd:Open(script.Parent)
requd:Generate(script.Parent)
game.Workspace.GameSettings.Server.RunRush.Value = true

script.Parent.Parent.Parent.RoomEnd.Touched:Connect(function(foot)
	
	local player = game.Players:GetPlayerFromCharacter(foot.Parent)
	
	if player then
		if script.Parent.Parent.Parent.RoomEnd:GetAttribute(player.Name) then

		else
			if script.Parent.Parent.Door:FindFirstChild("LightAttach") then
				script.Parent.Parent.Door.LightAttach:Destroy()
			end

			if player then
				script.Parent.Parent.Parent.RoomEnd:SetAttribute(player.Name, true)
				player.Character.Humanoid:SetAttribute("SpeedBoost", 0)
				player.Character.Humanoid:SetAttribute("SpeedBoostBehind", 0)
				game.ReplicatedStorage.ClientBricks.SeekEnd:FireClient(player)
				game.ReplicatedStorage.EntityInfo.ChangeModuleVariable:FireClient(player, "hideplayers", 0)
				game.ReplicatedStorage.EntityInfo.ChangeModuleVariable:FireClient(player, "chase", false)
				game.ReplicatedStorage.EntityInfo.SeekClientEnd:FireClient(player)

				local ach = "SurviveSeek"
				local p1_player = player

				if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
					local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
					local req = require(game.ReplicatedStorage.Achievements)[ach]

					if achive.Value == false then
						achive.Value = true
						if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
							game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
							game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
						end
					end

				end
			end
		end
	end
	
end)

script.Parent.Parent.CloseDoorSeek.Changed:Connect(function()
	if script.Parent.Parent.CloseDoorSeek.Value == true then
		
		if script.Parent.Parent.Door:FindFirstChild("LightAttach") then
			script.Parent.Parent.Door.LightAttach:Destroy()
		end
		
		game.ReplicatedStorage.GameData.ChaseInSession.Value = false
		script.Parent.Parent.HingeConstraint.ServoMaxTorque = 7000
		script.Parent.Parent.HingeConstraint.TargetAngle = 0
		script.Parent.Parent.Collid.CanCollide = true
		vvv:SetPartCollisionGroup(script.Parent.Parent.Collid, "SeekBlock")
	end
end)

local currentRoomValue = game.Workspace.CurrentRooms.CurrentRoom.Value
if currentRoomValue >= 4 then
	local cur = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value
	local cur1 = cur - 1
	local cur2 = cur - 2
	local cur3 = cur - 3
	local cur4 = cur - 4
	local g = currentRoomValue - 5

	if game.Workspace.CurrentRooms:FindFirstChild(tostring(g)) then
		game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value = g + 1

		local curRoom = game.Workspace.CurrentRooms:FindFirstChild(tostring(cur))

		-- Function to move the door to OnDeletedDoors
		local function moveToOnDeletedDoors(roomNum)
			local roomNumOld = roomNum - 1
			local door = curRoom:FindFirstChild("Door")
			if door then
				door.Name = "Door"..roomNum
				door.Parent = game.Workspace.OnDeletedDoors
				door.HingeConstraint.TargetAngle = 0
				door.HingeConstraint.ServoMaxTorque = 255565
				door.Collicion.CanCollide = true
				if game.Workspace.OnDeletedDoors:FindFirstChild("Door"..roomNumOld) then
					game.Workspace.OnDeletedDoors:FindFirstChild("Door"..roomNumOld):Destroy()
				end
			end
		end

		-- Move the current room's door to OnDeletedDoors
		moveToOnDeletedDoors(cur)

		-- Destroy the current room and previous rooms
		for _, roomNum in ipairs({cur1, cur2, cur3, cur4}) do
			local room = game.Workspace.CurrentRooms:FindFirstChild(tostring(roomNum))
			if room then
					--[[local door = room:FindFirstChild("Door")
					if door then
						door:Destroy()
					end--]]
				room:Destroy()
				moveToOnDeletedDoors(roomNum)
			end
		end

		wait(.1)
		game.Workspace.CurrentRooms.CurrentRoom.Door.Value += 1
		game.Workspace.CurrentRooms.CurrentRoom.Door.DoorAlt.Value += 1
	end
end