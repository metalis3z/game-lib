local CollectionService = game:GetService("CollectionService")

local stageObjects = {}

local stageDebounce = false

local player = game.Players.LocalPlayer

local runs = game:GetService("RunService")
local rs = game:GetService("ReplicatedStorage")

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	local stage = cp:GetAttribute("Stage")

	if not stageObjects[stage] then
		stageObjects[stage] = {}
	end


	table.insert(stageObjects[stage], cp)
end

if rs.Loaded.Value == true then
	value = true
	if value == true then
		stageObjects = {}
		for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do

			cp:WaitForChild("Collider")
			local part = cp.Collider
			cp:WaitForChild("CheckpointMarker")
			local particleHost = cp.CheckpointMarker
			local debounce = false
			local rs = game:GetService("ReplicatedStorage")

			part.Touched:Connect(function(otherPart)
				if rs.Loaded.Value == false then
					return
				end
				if otherPart.Parent == workspace.Ignore and not debounce then
					debounce = true
					if player.Name == otherPart.Name then
						if game:GetService("Players"):FindFirstChild(otherPart.Name) then
							local player = game:GetService("Players"):FindFirstChild(otherPart.Name) 
							if player.leaderstats.Stage.Value <= cp:GetAttribute("Stage") then
								player.leaderstats.Stage.Value = cp:GetAttribute("Stage")
								rs.RemoteEvents.stageUpdate:FireServer(cp:GetAttribute("Stage"))
							end
						end
						local ts = game:GetService("TweenService")
						local ti = TweenInfo.new(0.5)
						if cp:FindFirstChild("Flag") then
							local CFrameOG = cp.Flag.CFrame
							local propertyToTween = {CFrame = CFrameOG * CFrame.Angles(0,0,math.pi)}
							ts:Create(cp.Flag, ti, propertyToTween):Play()
							ts:Create(cp.Flag.Part, ti, {Color = Color3.new(0,1,0)}):Play()
						end
						particleHost.NotChecked.Enabled = false
						particleHost.Checked:Emit(5)
						cp.CircleTex.Confetti1:Emit(10)
						cp.CircleTex.Confetti2:Emit(10)
						cp.CircleTex.Confetti3:Emit(10)
						cp.CircleTex.Confetti4:Emit(10)
						cp.CircleTex.Confetti5:Emit(10)
						cp.CircleTex.Confetti6:Emit(10)
						cp.CircleTex.Decal.Transparency = 0
					end
				end
				if value == false then

				end
			end)

			player:WaitForChild("leaderstats")

			player.leaderstats.Stage.Changed:Connect(function(value)
				if value < cp:GetAttribute("Stage") then
				end
			end)
			local event
			local function endEvent()
				event:Disconnect()
			end
			event = runs.RenderStepped:Connect(function(dt)
				if player.leaderstats.Stage.Value >= cp:GetAttribute("Stage") then
					debounce = true
					if not particleHost:FindFirstChild("NotChecked") then
						endEvent()
						return
					end
					particleHost.NotChecked.Enabled = false
					cp.CircleTex.Decal.Transparency = 0
				else
					debounce = false
					if not particleHost:FindFirstChild("NotChecked") then
						endEvent()
						return
					end
					particleHost.NotChecked.Enabled = true
					cp.CircleTex.Decal.Transparency = 1
				end
			end)
		end
	end
end
rs.Loaded.Changed:Connect(function(value)
	if value == true then
		stageObjects = {}
		for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do

			cp:WaitForChild("Collider")
			local part = cp.Collider
			cp:WaitForChild("CheckpointMarker")
			local particleHost = cp.CheckpointMarker
			local debounce = false
			local rs = game:GetService("ReplicatedStorage")

			part.Touched:Connect(function(otherPart)
				if rs.Loaded.Value == false then
					return
				end
				if otherPart.Parent == workspace.Ignore and not debounce then
					debounce = true
					if player.Name == otherPart.Name then
						if game:GetService("Players"):FindFirstChild(otherPart.Name) then
							local player = game:GetService("Players"):FindFirstChild(otherPart.Name) 
							if player.leaderstats.Stage.Value <= cp:GetAttribute("Stage") then
								player.leaderstats.Stage.Value = cp:GetAttribute("Stage")
								rs.RemoteEvents.stageUpdate:FireServer(cp:GetAttribute("Stage"))
							end
						end
						local ts = game:GetService("TweenService")
						local ti = TweenInfo.new(0.5)
						if cp:FindFirstChild("Flag") then
							local CFrameOG = cp.Flag.CFrame
							local propertyToTween = {CFrame = CFrameOG * CFrame.Angles(0,0,math.pi)}
							ts:Create(cp.Flag, ti, propertyToTween):Play()
							ts:Create(cp.Flag.Part, ti, {Color = Color3.new(0,1,0)}):Play()
						end
						particleHost.NotChecked.Enabled = false
						particleHost.Checked:Emit(5)
						cp.CircleTex.Confetti1:Emit(10)
						cp.CircleTex.Confetti2:Emit(10)
						cp.CircleTex.Confetti3:Emit(10)
						cp.CircleTex.Confetti4:Emit(10)
						cp.CircleTex.Confetti5:Emit(10)
						cp.CircleTex.Confetti6:Emit(10)
						cp.CircleTex.Decal.Transparency = 0
					end
				end
				if value == false then
					
				end
			end)

			player:WaitForChild("leaderstats")

			player.leaderstats.Stage.Changed:Connect(function(value)
				if value < cp:GetAttribute("Stage") then
				end
			end)
			local event
			local function endEvent()
				event:Disconnect()
			end
			event = runs.RenderStepped:Connect(function(dt)
				if player.leaderstats.Stage.Value >= cp:GetAttribute("Stage") then
					debounce = true
					if not particleHost:FindFirstChild("NotChecked") then
						endEvent()
						return
					end
					particleHost.NotChecked.Enabled = false
					cp.CircleTex.Decal.Transparency = 0
				else
					debounce = false
					if not particleHost:FindFirstChild("NotChecked") then
						endEvent()
						return
					end
					particleHost.NotChecked.Enabled = true
					cp.CircleTex.Decal.Transparency = 1
				end
			end)
		end
	end
end)

game:GetService("ReplicatedStorage").RemoteEvents.clientTP.OnClientEvent:Connect(function()
	return
	--[[local otherPart = workspace.Ignore:FindFirstChild(player.Name)
	if game:GetService("Players"):FindFirstChild(otherPart.Name) then
		print('ok')
		local player = game:GetService("Players"):FindFirstChild(otherPart.Name)
		local stage = player.leaderstats.Stage.Value
		local stageObjects = {}

		local CollectionService = game:GetService("CollectionService")

		for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
			local stage = cp:GetAttribute("Stage")

			if not stageObjects[stage] then
				stageObjects[stage] = {}
			end

			table.insert(stageObjects[stage], cp)
		end
		
		if stageObjects[stage] then
			for i, v in pairs(stageObjects[stage]) do
				if v.Name == "Checkpoint" then
					local FakeChar = workspace.Ignore:FindFirstChild(player.Name)
					FakeChar.Velocity = Vector3.new(0,0,0)
					FakeChar.Position = v.CheckpointMarker.Position + Vector3.new(0,2,0)
					game:GetService("ReplicatedStorage").SpeedTimer.Value = 0
				end
			end
		end
	end]]--
end)