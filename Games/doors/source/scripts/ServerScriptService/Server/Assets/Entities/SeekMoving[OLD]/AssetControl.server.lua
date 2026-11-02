local SeekRig = script.Parent:FindFirstChild("SeekRig") -- SeekRig from this model

if game.Workspace.CurrentRooms:GetAttribute("Seek2Mode", true) then
	waypointmove = game.Workspace:FindFirstChild("Seek2PathWay1", true)
else
	if game.Workspace:FindFirstChild("VariantSeek", true).Value == 1 then
		waypointmove = game.Workspace:FindFirstChild("SeekPathWay1", true)
	elseif game.Workspace:FindFirstChild("VariantSeek", true).Value == 2 then
		waypointmove = game.Workspace:FindFirstChild("SeekPathWay2", true)
	elseif game.Workspace:FindFirstChild("VariantSeek", true).Value == 3 then
		waypointmove = game.Workspace:FindFirstChild("SeekPathWay3", true)
	elseif game.Workspace:FindFirstChild("VariantSeek", true).Value == 4 then
		waypointmove = game.Workspace:FindFirstChild("SeekPathWay4", true)
	elseif game.Workspace:FindFirstChild("VariantSeek", true).Value == 5 then
		waypointmove = game.Workspace:FindFirstChild("SeekPathWay5", true)
	elseif game.Workspace:FindFirstChild("VariantSeek", true).Value == 6 then
		waypointmove = game.Workspace:FindFirstChild("SeekPathWay6", true)
	end
end

-- The rest of your script

--game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms:GetAttribute("SeekRoomMain")).SeekPathWay1
local Figure = script.Parent:WaitForChild("Figure") -- Figure from this model
local RunSrevice = game:GetService('RunService')
local hum = SeekRig.AnimationController
local runanim = SeekRig.AnimRun
local raiseanim = SeekRig.AnimRaise
local running = hum:LoadAnimation(runanim)
local rising = hum:LoadAnimation(raiseanim)
rising.Looped = false
running.Looped = true
waypointmove.Parent = workspace

local SpawnerLibrary = {
	LerpTo = function(object, offset, speed)
		local alpha = 0
		local object = object or error("object must be part.")
		local offset = offset or error("offset Recommended")
		local speed = speed or 21
		local distance = (Figure.Position - object.Position).Magnitude
		local relativeSpeed = distance / speed
		local startCFrame = SeekRig.PrimaryPart.CFrame
		local loop
		local reachedEvent = Instance.new("BindableEvent")
		loop = RunSrevice.Heartbeat:Connect(function(delta)
			local goalCFrame = startCFrame:Lerp(object.CFrame * offset, alpha)
			SeekRig:PivotTo(goalCFrame)
			alpha += delta / relativeSpeed
			if alpha >= 1 then
				loop:Disconnect()
				reachedEvent:Fire()
			end
		end)
		reachedEvent.Event:Wait()
	end,
}

wait()
game.ReplicatedStorage.GameData.ChaseInSession.Value = true
rising:Play()
rising:AdjustSpeed(0)
script.Parent.Fire.Event:Connect(function()
	if game.Workspace:FindFirstChild("VariantSeek", true).Value == 1 then
		if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms:GetAttribute("Seek2RoomMain")) then
			SeekRig:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms:GetAttribute("Seek2RoomMain")).SeekNewPos.CFrame)
		end
	else
		if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms:GetAttribute("SeekRoomMain")) then
			SeekRig:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms:GetAttribute("SeekRoomMain")).SeekNewPos.CFrame)
		end
	end
	rising:AdjustSpeed(1)
	local Music = Instance.new("Sound")
	Music.Volume = 0.4
	Music.Name = "ChaseInSession"
	Music.SoundId = "rbxassetid://13330944342"
	Music.Parent = game:GetService("SoundService").Main
	Music:Play()
	wait(6.4)
	Figure.Footsteps:Play()
	Figure.FootstepsFar:Play()
end)
--[[script.Parent.Seeking.Changed:Connect(function()
	if script.Parent.Seeking.Value == true then
	end
end)--]]
rising.Stopped:Wait()
running:Play()

for i = 1, #waypointmove:GetChildren() do
	SpawnerLibrary.LerpTo(waypointmove:GetChildren()[i], CFrame.new(0, 4, 0), 20)
	if i == 10 then
		Figure.Scream:Play()
	end
	if i == 17 then
		game.Workspace:FindFirstChild("CloseDoorSeek", true).Value = true
	end
end
Figure.Knock:Play()
Figure.Footsteps:Stop()
Figure.FootstepsFar:Stop()
Figure.Hitbox.Script.Enabled = false
game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(1.7, 12, 0, 0.7)
wait(1)
game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(2, 12, 0, 0.7)
wait(1)
game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(1.9, 12, 0, 0.7)
wait(1)
if game.Workspace:FindFirstChild("VariantSeek2", true) then
	SpawnerLibrary.LerpTo(waypointmove["15"], CFrame.new(0, 4, 0), 20)
else
	if game.Workspace:FindFirstChild("VariantSeek", true).Value == 3 then
		SpawnerLibrary.LerpTo(waypointmove["14"], CFrame.new(0, 4, 0), 20)
	else
		SpawnerLibrary.LerpTo(waypointmove["12"], CFrame.new(0, 4, 0), 20)
	end
end
wait(4)
game.Workspace:FindFirstChild("SeekGetEnd", true).Value = true
