local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):WaitForChild("4Eyeball")

local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

function doorin()
	local currentRoomValue = game.Workspace.CurrentRooms.CurrentRoom.Value
	if currentRoomValue >= 4 then
		local cur = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value
		local cur1 = cur - 1
		local cur2 = cur - 2
		local cur3 = cur - 3
		local cur4 = cur - 4
		local g = currentRoomValue - 5 --4

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
end

-- ROOM SETTINGS -- 

local DarkRoomRandom = math.random(8, 48)

script.Parent.Parent.Parent.Func_Open.Event:Connect(function(boolen)
	if boolen == true then
		local hum = script.Parent.Parent.Parent.Padlock:WaitForChild("AnimationController")
		local humanim = hum:LoadAnimation(script.Parent.Parent.Parent.Padlock.Animations:FindFirstChild("open"))
		humanim:Play()
		script.Parent.Parent.Parent.Padlock.ActivateEventPrompt.Enabled = false
		task.delay(humanim.Length - 0.3, function()
			hum.Parent:Destroy()
		end)
		wait(1.5)
		doorin()
		script.Parent.Parent.Parent.Door1.Open:Play()
		script.Parent.Parent.Parent.Door2.Open:Play()
		script.Parent.Parent.Parent.Door1.Anchored = false
		script.Parent.Parent.Parent.Door1.CanCollide = false
		script.Parent.Parent.Parent.Door2.Anchored = false
		script.Parent.Parent.Parent.Door2.CanCollide = false
		script.Parent.Parent.Parent.HingeConstraint2.TargetAngle = -100
		script.Parent.Parent.Parent.HingeConstraint.TargetAngle = 100
		if script.Parent.Parent.Parent:FindFirstChild("Padlock") then
			script.Parent.Parent.Parent.Padlock.Main.Attachment.PointLight.Enabled = false
		end
		script.Parent.Parent.Parent.Lever.Box.LightAttach:Remove()
	end
end)

local vvv = game:GetService("PhysicsService")

script.Parent.Parent.Parent.Func_Close.Event:Connect(function(boolen)
	if boolen == true then
		game.Workspace.Ambience_Figure:Stop()
		game.Workspace.Ambience_FigureEnd:Play()
		game.Workspace.GameSettings.Server.NextRush.Value = false
		workspace:FindFirstChild("FigureMovement", true).Head.Growl:Play()
		workspace:FindFirstChild("FigureMovement", true).Root.Anchored = true
		workspace:FindFirstChild("FigureMovement", true).FigureRagdoll.HumanoidRootPart.Anchored = true
		workspace:FindFirstChild("FigureMovement", true).AssetControl.Enabled = false
		game.Workspace.Ambience_FigureEnd.TimePosition = 178.5
		script.Parent.Parent.Parent.HingeConstraint2.TargetAngle = 0
		script.Parent.Parent.Parent.HingeConstraint.TargetAngle = 0
		script.Parent.Parent.Parent.Collicion.CanCollide = true
		vvv:SetPartCollisionGroup(script.Parent.Parent.Parent.Collicion, "SeekBlock")
		game.Workspace.GameSettings.Server.RunRush.Value = true
		
		for i, v in pairs(game.Players:GetPlayers()) do 
			if v.Character then 
				if v.Character.Humanoid.Health == 0 then

				else
					v.Character:PivotTo(script.Parent.Parent.Parent.Parent.End.CFrame)
				end
			end
		end
	end
end)

script.Parent.Parent.Parent.Parent.End.Touched:Connect(function()
	script.Parent.Parent.Parent.Func_Close:Fire(true)
	script.Parent.Parent.Parent.Parent.End.CanTouch = false
end)

local doorModel = script.Parent.Parent
local generated = false
local endtouch = false

script.Parent.ActivateEventPrompt.Triggered:Connect(function(Player)
	if workspace.CurrentRooms["50"].FigureSetup.Modules.Unlocked.Value == true then
		workspace.CurrentRooms["50"].FigureSetup.Modules.Unlocked.Value = false
		doorModel.LeverConstraint.TargetPosition = -5.6
		script.Parent.SoundToPlay:Play()
		local d = doorModel.Parent.Padlock.Core
		script.Parent.Parent.Parent.Func_Open:Fire(true)
		game.Workspace.CurrentRooms["50"].FigureSetup.Modules.CanBeUnLibrary.Value = true
	else
		game.ReplicatedStorage.Bricks.KeyRequire:FireClient(Player, "Cannot")
	end
end)

while wait(1) do
	--[[if workspace.Rooms:FindFirstChild("50") then
		workspace.Rooms["50"].FigureSetup.Modules.Unlocked.Value = true
		script.Parent.LightAttach.HelpLight.Enabled = true
		script.Parent.LightAttach.HelpParticle.Enabled = true
	end--]]
	if workspace.CurrentRooms:FindFirstChild("50") then
		if workspace.CurrentRooms["50"].FigureSetup.Modules.Unlocked.Value == true then
			script.Parent.LightAttach.HelpLight.Enabled = true
			script.Parent.LightAttach.HelpParticle.Enabled = true
		end
	end
	if game.Workspace.Ambience_FigureEnd.TimePosition >= 200 then
		game.Workspace.Ambience_FigureEnd:Stop()
	end
	if game.Workspace.CurrentRooms:FindFirstChild("50") then
		if game.Workspace.CurrentRooms:FindFirstChild("50").FigureSetup.Modules.Lever5Triggered.Value == true then
			if generated == false then
				generated = true
			end
		end
	end
end