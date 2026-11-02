local SeekRig = script.Parent:FindFirstChild("SeekRig") -- SeekRig from this model

script.Parent.Figure.Hitbox.CanTouch = true

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
local crucifixend1 = SeekRig.AnimCrucifixEnd
local running = hum:LoadAnimation(runanim)
local rising = hum:LoadAnimation(raiseanim)
local crucifixend = hum:LoadAnimation(crucifixend1)
local crucifixSeek = hum:LoadAnimation(SeekRig.AnimCrucifix)
rising.Looped = false
running.Looped = true
waypointmove.Parent = workspace.CurrentRooms

script.Parent.StopAnimCrucifix.Event:Connect(function()
	crucifixSeek:Stop()
end)

local SpawnerLibrary = {
	LerpTo = function(object, offset, speed)
		local alpha = 0
		local object = object or error("object must be part.")
		local offset = offset or error("offset Recommended")
		local speed = speed or 21
		
		if game.Workspace.Game.Modifiers:FindFirstChild("FireShoot") then
			if game.Workspace.Game.Modifiers:FindFirstChild("FireShoot").Value == true then
				speed = 23
			end
		end
		
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
if script.Parent:GetAttribute("SeekRunning", true) then
	crucifixSeek:Stop()
	crucifixend:Play()
	crucifixend:AdjustSpeed(1)
	Figure.Footsteps:Stop()
	Figure.FootstepsFar:Stop()
	rising:AdjustSpeed(1)
	wait(3)
	Figure.Footsteps:Play()
	Figure.FootstepsFar:Play()
	running:Play()
else
	script.Parent.Fire.Event:Connect(function()
		script.Parent:SetAttribute("SeekRunning", true)
		
		if game.Workspace.Game.Modifiers:FindFirstChild("FireShoot") then
			if game.Workspace.Game.Modifiers:FindFirstChild("FireShoot").Value == true then
				
				for i, v in pairs(game.Workspace:GetDescendants()) do
					if v:IsA("Beam") and v.Name == "StringCheese" then
						v.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
					end
				end
				
				SeekRig.Head.Eye.Color = Color3.fromRGB(255, 0, 0)
				Figure.Angry.Enabled = true
				running:AdjustSpeed(1.3)
				Figure.Footsteps.PlaybackSpeed = 2
				Figure.FootstepsFar.PlaybackSpeed = 2
			end
		end
		
		rising:Play()
		rising:AdjustSpeed(1)
		local Music = Instance.new("Sound")
		Music.Volume = 0.4
		Music.Name = "ChaseInSession"
		Music.SoundGroup = game.SoundService.Main
		Music.SoundId = "rbxassetid://13330944342"
		Music.Parent = game:GetService("SoundService").Main
		Music:Play()
		wait(7.4)
		Figure.Footsteps:Play()
		Figure.FootstepsFar:Play()
	end)
end

if script.Parent:GetAttribute("SeekRunning", true) then
	crucifixend.Stopped:Wait()
	running:Play()
else
	rising.Stopped:Wait()
	running:Play()
end

if script.Parent.Settings.GetCrucifixed.Value == true then
	SeekRig.Head.Eye.Color = Color3.fromRGB(255, 0, 0)
	Figure.Scream:Play()
	Figure.Angry.Enabled = true
	running:AdjustSpeed(1.3)
	Figure.Footsteps.PlaybackSpeed = 2
	Figure.FootstepsFar.PlaybackSpeed = 2
end

for i = script.Parent.Settings.SeekLastDot.Value, #waypointmove:GetChildren() do
	if script.Parent.Settings.GetCrucifixed.Value == true then
		SpawnerLibrary.LerpTo(waypointmove:GetChildren()[i], CFrame.new(0, 4, 0), 27)
	else
		SpawnerLibrary.LerpTo(waypointmove:GetChildren()[i], CFrame.new(0, 4, 0), 20)
	end
	print(i.." Reached point")
	if i == 1 then
		Figure.Scream:Play()
	end
	if i == 17 then
		if game.Workspace:FindFirstChild("CloseDoorSeek", true) then
			game.Workspace:FindFirstChild("CloseDoorSeek", true).Value = true
		end
		Figure.Hitbox.Script.Enabled = false
	end
	script.Parent.Settings.SeekLastDot.Value += 1
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
wait(2)

game.SoundService:FindFirstChild("ChaseInSession", true):Destroy()

for i, v in pairs(game.Workspace:GetDescendants()) do
	if v:IsA("Model") and v.Name == "SeekMoving" then
		v:Destroy()
	end
end

for i, v in pairs(game.Workspace.CurrentRooms:GetChildren()) do
	if v:IsA("NumberValue") and string.find(v.Name, "VariantSeek") then
		v:Destroy()
	end
	
	if v:IsA("Folder") and string.find(v.Name, "SeekPathWay") then
		v:Destroy()
	end
end