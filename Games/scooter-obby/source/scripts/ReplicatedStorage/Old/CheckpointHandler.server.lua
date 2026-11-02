local CollectionService = game:GetService("CollectionService")

local stageObjects = {}

local stageDebounce = false

local player = game.Players.LocalPlayer

local runs = game:GetService("RunService")

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	local stage = cp:GetAttribute("Stage")

	if not stageObjects[stage] then
		stageObjects[stage] = {}
	end
	
	
	table.insert(stageObjects[stage], cp)
end

for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
	print("Checkpoint " .. cp:GetAttribute("Stage") .. " tagged.")

	cp:WaitForChild("Collider")
	local part = cp.Collider
	cp:WaitForChild("CheckpointMarker")
	local particleHost = cp.CheckpointMarker
	local debounce = false
	local warningDebounce = false
	local rs = game:GetService("ReplicatedStorage")
	
	part.Touched:Connect(function(otherPart)
		if debounce and not warningDebounce and player.leaderstats.Stage.Value > cp:GetAttribute('Stage') then
			warningDebounce = true
			--player.PlayerGui.GameGUI.Frame.CashNotificationHandler.errorWrite:Fire("You've already gotten this checkpoint!")
			wait(3)
			warningDebounce = false
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
	end)
	
	player:WaitForChild("leaderstats")
	player.leaderstats.Stage.Changed:Connect(function(value)
		if value < cp:GetAttribute("Stage") then
		end
	end)
	runs.RenderStepped:Connect(function(dt)
		if player.leaderstats.Stage.Value >= cp:GetAttribute("Stage") then
			debounce = true
			particleHost.NotChecked.Enabled = false
			cp.CircleTex.Decal.Transparency = 0
		else
			debounce = false
			particleHost.NotChecked.Enabled = true
			cp.CircleTex.Decal.Transparency = 1
		end
	end)
end
