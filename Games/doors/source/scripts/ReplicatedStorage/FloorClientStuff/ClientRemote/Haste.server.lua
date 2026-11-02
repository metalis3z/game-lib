script.Parent.HasteRemote.OnClientEvent:Connect(function(id)
	if id ~= "server-sided" then
		return
	end
	print("spawned")
	local model = script.EntityModel:Clone()
	model.Parent = workspace
	local busy = false
	model.Main.Footsteps:Play()
	task.wait(5)
	local function check(pos)
		if busy then
			return
		end
		local list = workspace:children()
		local HumanoidRootPart = nil
		local dist = 85
		local temp = nil
		local human = nil
		local temp2 = nil
		for x = 1, #list do
			temp2 = list[x]
			if temp2:IsA("Model") and temp2 ~= script.Parent then
				temp = temp2:FindFirstChild("HumanoidRootPart")
				human = temp2:FindFirstChild("Humanoid")
				if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
					if (temp.Position - pos).Magnitude < dist then
						HumanoidRootPart = temp
						dist = (temp.Position - pos).Magnitude
						busy = true
						game.ReplicatedStorage.Bricks.HasteInClient:FireServer()
						wait(0.1)
						busy = false
					end
				end
			end
		end
		return HumanoidRootPart
	end
	local Figure = model.Main
	local SpawnerLibrary = {
		LerpTo = function(object, offset, speed)
			local alpha = 0
			local object = object or error("object must be part.")
			local offset = offset or error("offset Recommended")
			local speed = 85
			local distance = (Figure.Position - object.Position).Magnitude
			local relativeSpeed = distance / speed
			local startCFrame = model.PrimaryPart.CFrame
			local loop
			local reachedEvent = Instance.new("BindableEvent")
			loop = game["Run Service"].Heartbeat:Connect(function(delta)
				local goalCFrame = startCFrame:Lerp(object.CFrame - offset, alpha)
				model:PivotTo(goalCFrame)
				check(model:GetPivot().Position)
				alpha += delta / relativeSpeed
				if alpha >= 1 then
					loop:Disconnect()
					reachedEvent:Fire()
				end
			end)
			wait(0.01)
		end,
	}
	local function lerp_plus(model)
		SpawnerLibrary.LerpTo(model, Vector3.new(-1, 0, -1), 0)
		wait(0.15)
		SpawnerLibrary.LerpTo(model, Vector3.new(-0.5, 0, -0.5), 0)
		wait(0.15)
		SpawnerLibrary.LerpTo(model, Vector3.new(-0.15, 0, -0.15), 0)
		wait(0.15)
		SpawnerLibrary.LerpTo(model, Vector3.new(0, 0, 0), 0)
	end
	local some_prev = workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2]
	model:SetPrimaryPartCFrame(some_prev.RoomEntrance.CFrame)
	local lastroom = workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value]
	local pt = game.Players.LocalPlayer
	if pt.Character:WaitForChild("Humanoid").Health > 0 then
		pt.Stats.Death.Value = "Haste"
		lerp_plus(pt.Character.PrimaryPart)
	end
	model:Destroy()
end)