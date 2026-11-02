--!strict
-- LOCATION: StarterPlayerScripts/KickController

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- [ MODULES ]
local Modules = ReplicatedStorage:WaitForChild("Modules")
local LuckyBlockConfigs = require(Modules:WaitForChild("LuckyBlockConfigurations"))
local ItemConfigs = require(Modules:WaitForChild("ItemConfigurations"))
local TsunamiConfigs = require(Modules:WaitForChild("TsunamiConfigurations"))
local NotificationManager = require(Modules:WaitForChild("NotificationManager"))
local NumberFormatter = require(Modules:WaitForChild("NumberFormatter"))
local MutationConfigs = require(Modules:WaitForChild("MutationConfigurations"))
local RarityConfigs = require(Modules:WaitForChild("RarityConfigurations"))
local KickConfigs = require(Modules:WaitForChild("KickConfigurations")) 

-- [ ASSETS ]
local Templates = ReplicatedStorage:WaitForChild("Templates")
local KickAnimation = Templates:WaitForChild("KickAnimation") :: Animation
local EffectsFolder = Templates:WaitForChild("Effects")
local GlobalSounds = Workspace:WaitForChild("Sounds")
local LuckyBlocksFolder = ReplicatedStorage:WaitForChild("LuckyBlocks")
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")
local TsunamisFolder = ReplicatedStorage:WaitForChild("Tsunamis") 
local Events = ReplicatedStorage:WaitForChild("Events")

-- [ REFERENCE TO TOGGLE EVENT ]
local ToggleMorphEvent = Events:WaitForChild("ToggleMorphVisibility")

-- [ WORKSPACE REFERENCES ]
local TsunamiEndPart = Workspace:WaitForChild("Tsunami", 10) and Workspace.Tsunami:WaitForChild("End", 10) :: BasePart

-- [ UI REFERENCES ]
local gui = playerGui:WaitForChild("GUI")
local hud = gui:WaitForChild("HUD")
local kickButton = hud:WaitForChild("Kick") :: GuiButton

-- PowerBar References
local powerBar = hud:WaitForChild("PowerBar") :: Frame
local barFill = powerBar:WaitForChild("Bar") :: Frame

powerBar.Visible = false

-- [ STATE ]
local loadedKickTrack: AnimationTrack? = nil
local isKicking = false
local isSelectingPower = false

-- Escape Sequence State
local isEscaping = false
local targetCollectionPart: BasePart? = nil
local activeMorphItem: string? = nil
local activeMorphRarity: string? = nil
local activeMorph: Model? = nil
local originalTransparencies = {}

-- Tsunami State
local activeTsunami: Model? = nil
local tsunamiSpeed: number = 0
local tsunamiDir: Vector3 = Vector3.zero

-- Power Bar Math State
local currentPower = 0
local powerDir = 1

print("[KickController] Loaded (Tsunami Cooldown Reduced to 2s)")

-- [ HELPER: CHARACTER VISIBILITY ]
local function setCharacterVisibility(character: Model, visible: boolean)
	for _, part in ipairs(character:GetDescendants()) do
		if activeMorph and part:IsDescendantOf(activeMorph) then continue end
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			if visible then
				part.Transparency = part:GetAttribute("OriginalTransparency") or 0
			else
				if not part:GetAttribute("OriginalTransparency") then
					part:SetAttribute("OriginalTransparency", part.Transparency)
				end
				part.Transparency = 1
			end
		elseif part:IsA("Decal") and part.Name == "face" then
			part.Transparency = visible and 0 or 1
		elseif part:IsA("ParticleEmitter") or part:IsA("Trail") then
			if visible then
				local orig = part:GetAttribute("OriginalEnabled")
				if orig ~= nil then part.Enabled = orig end
			else
				if part:GetAttribute("OriginalEnabled") == nil then
					part:SetAttribute("OriginalEnabled", part.Enabled)
				end
				part.Enabled = false
			end
		end
	end
end

-- [ HELPER: ATTACH INFO GUI ]
local function attachInfoGUI(model: Model, itemName: string, rarity: string, mutation: string)
	local rootPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
	if not rootPart then return end

	local existingGui = model:FindFirstChild("InfoGUI")
	if existingGui then existingGui:Destroy() end

	local infoGuiTemplate = Templates:FindFirstChild("InfoGUI")
	if not infoGuiTemplate then return end

	local infoGui = infoGuiTemplate:Clone() :: BillboardGui
	infoGui.Name = "InfoGUI"

	local labelsFrame = infoGui:WaitForChild("TextLabels")
	local lblEarnings = labelsFrame:WaitForChild("Earnings") :: TextLabel
	local lblRarity = labelsFrame:WaitForChild("Rarity") :: TextLabel
	local lblName = labelsFrame:WaitForChild("Name") :: TextLabel
	local lblMutation = labelsFrame:WaitForChild("Mutation") :: TextLabel

	lblName.Text = itemName

	local itemData = ItemConfigs.GetItemData(itemName)
	local baseIncome = itemData and itemData.Income or 0
	local rebirths = 0

	local ls = player:FindFirstChild("leaderstats")
	if ls and ls:FindFirstChild("Rebirths") then
		rebirths = ls.Rebirths.Value
	end

	local rebMult = 1 + (rebirths * 0.5)
	local totalIncome = baseIncome * rebMult

	lblEarnings.Text = "+$" .. NumberFormatter.Format(totalIncome) .. "/s"

	local rarityConfig = RarityConfigs[rarity]
	if rarityConfig then
		lblRarity.Text = rarityConfig.DisplayName or rarity
		lblRarity.TextColor3 = rarityConfig.TextColor
		local stroke = lblRarity:FindFirstChild("UIStroke") or lblRarity:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = rarityConfig.StrokeColor; stroke.Thickness = rarityConfig.StrokeThickness end
		local gradient = lblRarity:FindFirstChild("UIGradient") or lblRarity:FindFirstChildOfClass("UIGradient")
		if gradient then gradient.Color = rarityConfig.GradientColor end
	end

	local mutationConfig = MutationConfigs[mutation]
	if mutationConfig then
		lblMutation.Text = mutationConfig.DisplayName or mutation
		lblMutation.TextColor3 = mutationConfig.TextColor
		local stroke = lblMutation:FindFirstChild("UIStroke") or lblMutation:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = mutationConfig.StrokeColor; stroke.Thickness = mutationConfig.StrokeThickness end
		local gradient = lblMutation:FindFirstChild("UIGradient") or lblMutation:FindFirstChildOfClass("UIGradient")
		if gradient then gradient.Color = mutationConfig.GradientColor end
	end

	infoGui.Adornee = rootPart

	-- Position the GUI above the model based on its bounding box height
	local bbCFrame, bbSize = model:GetBoundingBox()
	local rootPos = rootPart.Position
	local modelTopOffset = bbCFrame.Position.Y + bbSize.Y / 2 - rootPos.Y
	infoGui.StudsOffset = Vector3.new(0, modelTopOffset - 0.9, 0)

	infoGui.Parent = model
end

-- [ ANIMATION SETUP ]
local function setupAnimation(char: Model)
	loadedKickTrack = nil
	isEscaping = false
	activeMorph = nil

	if activeTsunami then activeTsunami:Destroy(); activeTsunami = nil end

	local humanoid = char:WaitForChild("Humanoid", 5) :: Humanoid
	if not humanoid then return end

	local animator = humanoid:WaitForChild("Animator", 5) :: Animator
	if not animator then return end

	loadedKickTrack = animator:LoadAnimation(KickAnimation)
end

player.CharacterAdded:Connect(setupAnimation)
if player.Character then
	task.spawn(setupAnimation, player.Character)
end

-- [ HELPER: RESTORE CAMERA ]
local function restoreCamera(char: Model?)
	if camera then
		camera.CameraType = Enum.CameraType.Custom
		if char then
			local humanoid = char:FindFirstChild("Humanoid")
			if humanoid then camera.CameraSubject = humanoid end
		end
	end
end

-- [ INPUT LOGIC: SCREEN CLICK/TAP ]
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not isSelectingPower then return end

	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isSelectingPower = false
		powerBar.Visible = false

		local finalPowerPercent = math.floor(currentPower * 100)
		isKicking = true

		local char = player.Character
		if not char then isKicking = false return end

		local root = char:FindFirstChild("HumanoidRootPart") :: BasePart
		if not root then isKicking = false return end

		-- [[ EFFECT LOGIC ]] --
		local effectName = nil
		if finalPowerPercent >= KickConfigs.EffectThresholds.Perfect then effectName = "Perfect"
		elseif finalPowerPercent >= KickConfigs.EffectThresholds.Great then effectName = "Great"
		elseif finalPowerPercent >= KickConfigs.EffectThresholds.Good then effectName = "Good" end

		if effectName then
			local effectTemplate = EffectsFolder:FindFirstChild(effectName)
			if effectTemplate and effectTemplate:IsA("Attachment") then
				local effectClone = effectTemplate:Clone()
				effectClone.Parent = root

				local effectSound = GlobalSounds:FindFirstChild("Effect")
				if effectSound and effectSound:IsA("Sound") then
					local soundClone = effectSound:Clone()
					soundClone.Parent = root
					soundClone:Play()
					Debris:AddItem(soundClone, soundClone.TimeLength + 0.1)
				end

				for _, emitter in ipairs(effectClone:GetChildren()) do
					if emitter:IsA("ParticleEmitter") then emitter.Enabled = true end
				end

				task.delay(0.25, function()
					if effectClone and effectClone.Parent then
						for _, emitter in ipairs(effectClone:GetChildren()) do
							if emitter:IsA("ParticleEmitter") then emitter.Enabled = false end
						end
						Debris:AddItem(effectClone, 3)
					end
				end)
			end
		end

		root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(180), 0)
		root.Anchored = true

		if loadedKickTrack then
			loadedKickTrack:Play()

			task.wait(1)

			local playerPower = 0
			local leaderstats = player:FindFirstChild("leaderstats")
			if leaderstats then
				local powerStat = leaderstats:FindFirstChild("Power")
				if powerStat then playerPower = powerStat.Value end
			end

			local blockName = LuckyBlockConfigs.GetBlockByPower(playerPower)
			local blockTemplate = LuckyBlocksFolder:FindFirstChild(blockName)
			local blockClone: Instance? = nil
			local primary: BasePart? = nil

			if blockTemplate then
				blockClone = blockTemplate:Clone()
				primary = blockClone:IsA("Model") and blockClone.PrimaryPart or (blockClone:IsA("BasePart") and blockClone or nil)

				if primary and primary:IsA("BasePart") then
					blockClone.Parent = Workspace

					local forwardCFrame = root.CFrame * CFrame.new(0, 0, -2.5)
					local flatSpawnCFrame = CFrame.new(forwardCFrame.Position) * CFrame.Angles(0, math.rad(180), 0)

					if blockClone:IsA("Model") then blockClone:PivotTo(flatSpawnCFrame) else primary.CFrame = flatSpawnCFrame end

					local excludeList = {char, blockClone}
					local zonesFolder = Workspace:FindFirstChild("Zones")
					if zonesFolder then table.insert(excludeList, zonesFolder) end

					local rayParams = RaycastParams.new()
					rayParams.FilterType = Enum.RaycastFilterType.Exclude
					rayParams.FilterDescendantsInstances = excludeList

					local rayOrigin = forwardCFrame.Position + Vector3.new(0, 5, 0)
					local rayResult = Workspace:Raycast(rayOrigin, Vector3.new(0, -100, 0), rayParams)
					local floorY = rayResult and rayResult.Position.Y or (root.Position.Y - 3)

					if blockClone:IsA("Model") then
						local bboxCFrame, bboxSize = blockClone:GetBoundingBox()
						local bottomY = bboxCFrame.Position.Y - (bboxSize.Y / 2)
						local offset = floorY - bottomY
						blockClone:PivotTo(blockClone:GetPivot() + Vector3.new(0, offset, 0))

						for _, desc in ipairs(blockClone:GetDescendants()) do
							if desc:IsA("BasePart") then
								desc.Anchored = true
								desc.CanCollide = true
								desc.CollisionGroup = "LuckyBlocks"
							end
						end
					else
						local bottomY = primary.Position.Y - (primary.Size.Y / 2)
						local offset = floorY - bottomY
						primary.CFrame = primary.CFrame + Vector3.new(0, offset, 0)
						primary.Anchored = true
						primary.CanCollide = true
						primary.CollisionGroup = "LuckyBlocks"
					end
				end
			end

			task.wait(2.4)

			if blockClone and primary then
				if blockClone:IsA("Model") then
					for _, desc in ipairs(blockClone:GetDescendants()) do
						if desc:IsA("BasePart") then desc.Anchored = false end
					end
				else
					primary.Anchored = false
				end

				-- [[ APPLY FORCES ]] --
				local bonusPower = math.pow(playerPower, KickConfigs.PowerScalingExponent)

				local forwardForce = KickConfigs.BaseForwardForce + (bonusPower * currentPower)
				local upwardForce = KickConfigs.BaseUpwardForce + ((bonusPower * KickConfigs.UpwardForceScaling) * currentPower)

				primary.AssemblyLinearVelocity = (root.CFrame.LookVector * forwardForce) + Vector3.new(0, upwardForce, 0)
				primary.AssemblyAngularVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))

				-- [[ CINEMATIC SEQUENCE BEGINS ]] --

				camera.CameraType = Enum.CameraType.Custom
				camera.CameraSubject = primary

				local zonesFolder = Workspace:FindFirstChild("Zones")

				task.spawn(function()
					local activeZoneFolder = nil
					local hitZone = false
					local timeout = 5 
					local startTime = tick()

					while (tick() - startTime) < timeout and blockClone.Parent do
						RunService.Heartbeat:Wait()

						if zonesFolder and primary then
							for _, zoneFolder in ipairs(zonesFolder:GetChildren()) do
								local detectionPart = zoneFolder:FindFirstChild("Detection") :: BasePart
								if detectionPart and detectionPart:IsA("BasePart") then
									local relPos = detectionPart.CFrame:PointToObjectSpace(primary.Position)
									local size = detectionPart.Size

									-- ## REDUCED FORGIVENESS PADDING ##
									local padX = (primary.Size.X / 2) + 1.5
									local padY = (primary.Size.Y / 2) + 8
									local padZ = (primary.Size.Z / 2) + 1.5

									if math.abs(relPos.X) <= (size.X / 2) + padX and 
										math.abs(relPos.Y) <= (size.Y / 2) + padY and 
										math.abs(relPos.Z) <= (size.Z / 2) + padZ then
										hitZone = true
										activeZoneFolder = zoneFolder
										break
									end
								end
							end
						end
						if hitZone then break end
					end

					if hitZone and blockClone.Parent then
						primary.AssemblyLinearVelocity = Vector3.zero
						primary.AssemblyAngularVelocity = Vector3.zero

						local flatCFrame = CFrame.new(primary.Position)
						if blockClone:IsA("Model") then blockClone:PivotTo(flatCFrame) else primary.CFrame = flatCFrame end

						local excludeList = {char, blockClone}
						if zonesFolder then table.insert(excludeList, zonesFolder) end

						local rayParams = RaycastParams.new()
						rayParams.FilterType = Enum.RaycastFilterType.Exclude
						rayParams.FilterDescendantsInstances = excludeList

						local rayOrigin = primary.Position + Vector3.new(0, 5, 0)
						local rayResult = Workspace:Raycast(rayOrigin, Vector3.new(0, -100, 0), rayParams)
						local floorY = rayResult and rayResult.Position.Y or (primary.Position.Y - 2)

						if blockClone:IsA("Model") then
							local bboxCFrame, bboxSize = blockClone:GetBoundingBox()
							local bottomY = bboxCFrame.Position.Y - (bboxSize.Y / 2)
							local offset = floorY - bottomY
							blockClone:PivotTo(blockClone:GetPivot() + Vector3.new(0, offset, 0))

							for _, p in ipairs(blockClone:GetDescendants()) do
								if p:IsA("BasePart") then p.Anchored = true end
							end
						else
							local bottomY = primary.Position.Y - (primary.Size.Y / 2)
							local offset = floorY - bottomY
							primary.CFrame = primary.CFrame + Vector3.new(0, offset, 0)
							primary.Anchored = true
						end

						-- [[ PHASE 1: SHAKE & SQUISH ]]
						local highlight = Instance.new("Highlight")
						highlight.FillColor = Color3.fromRGB(255, 255, 255)
						highlight.OutlineTransparency = 1
						highlight.FillTransparency = 1
						highlight.DepthMode = Enum.HighlightDepthMode.Occluded
						highlight.Parent = blockClone
						TweenService:Create(highlight, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {FillTransparency = 0.2}):Play()

						local shakeStart = tick()
						local originalCFrame = blockClone:IsA("Model") and blockClone:GetPivot() or primary.CFrame

						local shakeConn = RunService.RenderStepped:Connect(function()
							if not blockClone.Parent then return end
							local t = tick() - shakeStart
							if t > 1.5 then return end

							local intensity = (t / 1.5) * 15
							local offset = CFrame.Angles(
								math.rad(math.random(-intensity, intensity)),
								math.rad(math.random(-intensity, intensity)),
								math.rad(math.random(-intensity, intensity))
							)
							if blockClone:IsA("Model") then blockClone:PivotTo(originalCFrame * offset) else primary.CFrame = originalCFrame * offset end
						end)

						task.wait(1.5)
						if shakeConn then shakeConn:Disconnect() end
						if blockClone:IsA("Model") then blockClone:PivotTo(originalCFrame) else primary.CFrame = originalCFrame end

						local scaleVal = Instance.new("NumberValue")
						scaleVal.Value = blockClone:IsA("Model") and blockClone:GetScale() or 1
						local scaleConn = scaleVal.Changed:Connect(function(val)
							if blockClone.Parent and blockClone:IsA("Model") then blockClone:ScaleTo(val) end
						end)

						local squishTween = TweenService:Create(scaleVal, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = scaleVal.Value * 0.5})
						squishTween:Play()
						squishTween.Completed:Wait()
						scaleConn:Disconnect()
						blockClone:Destroy()

						-- [[ PHASE 2: GROW & POP ]]
						local randomItemName = LuckyBlockConfigs.GetRandomDrop(blockName)

						if not randomItemName then
							local itemNames = {}
							for name, _ in pairs(ItemConfigs.Items) do table.insert(itemNames, name) end
							randomItemName = itemNames[math.random(1, #itemNames)]
						end

						local randomItemData = ItemConfigs.Items[randomItemName]
						local activeRarity = randomItemData and randomItemData.Rarity or "Common"

						local itemSource = ItemsFolder:FindFirstChild("Normal") and ItemsFolder.Normal:FindFirstChild(randomItemName)
						local fakeItem = nil

						if itemSource then
							fakeItem = itemSource:Clone() :: Model
							fakeItem.Name = "HatchedItem"
							fakeItem.Parent = Workspace

							attachInfoGUI(fakeItem, randomItemName, activeRarity, "Normal")

							local bboxCFrame, bboxSize = fakeItem:GetBoundingBox()
							fakeItem.WorldPivot = bboxCFrame
							local itemSpawnCFrame = originalCFrame * CFrame.new(0, bboxSize.Y / 2, 0)
							fakeItem:PivotTo(itemSpawnCFrame)

							for _, p in ipairs(fakeItem:GetDescendants()) do
								if p:IsA("BasePart") then p.Anchored = true; p.CanCollide = false end
							end

							local targetPart = fakeItem.PrimaryPart or fakeItem:FindFirstChildWhichIsA("BasePart")
							camera.CameraSubject = targetPart

							local revealSoundTemplate = GlobalSounds:FindFirstChild("Reveal")
							if revealSoundTemplate and targetPart then
								local soundClone = revealSoundTemplate:Clone()
								soundClone.Parent = targetPart
								soundClone:Play()
								Debris:AddItem(soundClone, soundClone.TimeLength + 0.1)
							end

							local revealAtt: Attachment? = nil
							local revealTemplate = Templates:FindFirstChild("Reveal")
							if revealTemplate and revealTemplate:IsA("Attachment") and targetPart then
								revealAtt = revealTemplate:Clone()
								revealAtt.Parent = targetPart

								for _, child in ipairs(revealAtt:GetChildren()) do
									if child:IsA("ParticleEmitter") then
										child.Enabled = true
									end
								end
							end

							local camShakeStart = tick()
							local camShakeConn = RunService.RenderStepped:Connect(function()
								local t = tick() - camShakeStart
								if t > 1.5 then return end
								local fadeOut = 1 - (t / 1.5)
								local intensity = 3
								local offset = CFrame.Angles(
									math.rad((math.random() - 0.5) * intensity * fadeOut),
									math.rad((math.random() - 0.5) * intensity * fadeOut),
									math.rad((math.random() - 0.5) * intensity * fadeOut)
								)
								camera.CFrame = camera.CFrame * offset
							end)

							local targetScale = fakeItem:GetScale()
							local itemScale = Instance.new("NumberValue")
							itemScale.Value = 0.01
							fakeItem:ScaleTo(0.01)

							local iScaleConn = itemScale.Changed:Connect(function(val)
								if fakeItem and fakeItem.Parent then fakeItem:ScaleTo(val) end
							end)

							local growTween = TweenService:Create(itemScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Value = targetScale})
							growTween:Play()

							local tickCount = 0
							local itemRenderConn = RunService.RenderStepped:Connect(function(dt2)
								if fakeItem and (fakeItem.PrimaryPart or fakeItem.WorldPivot) then
									tickCount += dt2
									local newCFrame = itemSpawnCFrame * CFrame.Angles(0, math.rad(tickCount * 120), 0)
									fakeItem:PivotTo(newCFrame)
								end
							end)

							task.spawn(function()
								growTween.Completed:Wait()
								iScaleConn:Disconnect()
							end)

							task.wait(2.5)

							if itemRenderConn then itemRenderConn:Disconnect() end
							if camShakeConn then camShakeConn:Disconnect() end

							if revealAtt then
								for _, child in ipairs(revealAtt:GetChildren()) do
									if child:IsA("ParticleEmitter") then
										child.Enabled = false
									end
								end
								Debris:AddItem(revealAtt, 2)
							end
						end

						-- [[ PHASE 3: MORPH PLAYER AND START ESCAPE ]]
						if activeZoneFolder and fakeItem then
							targetCollectionPart = activeZoneFolder:FindFirstChild("Collection") :: BasePart

							if targetCollectionPart then
								local targetPos = fakeItem:GetPivot().Position

								for _, desc in ipairs(fakeItem:GetDescendants()) do
									if desc:IsA("Script") or desc:IsA("LocalScript") then
										desc:Destroy()
									end
								end

								local morphPrimary = fakeItem.PrimaryPart or fakeItem:FindFirstChildWhichIsA("BasePart")
								if morphPrimary then
									for _, p in ipairs(fakeItem:GetDescendants()) do
										if p:IsA("BasePart") then
											p.CanCollide = false
											p.CanQuery = false
											p.CanTouch = false
											p.Massless = true
											p.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)

											if p ~= morphPrimary then
												p.Anchored = false
												local w = Instance.new("WeldConstraint")
												w.Part0 = morphPrimary
												w.Part1 = p
												w.Parent = p
											end
										end
									end
									morphPrimary.Anchored = true
								end

								activeMorph = fakeItem
								setCharacterVisibility(char, false)

								fakeItem.Parent = char
								fakeItem.Name = "ActiveMorph"

								for _, p in ipairs(char:GetDescendants()) do
									if p:IsA("BasePart") then
										p.CollisionGroup = "LuckyBlocks"
									end
								end

								root.AssemblyLinearVelocity = Vector3.zero
								root.AssemblyAngularVelocity = Vector3.zero
								char:MoveTo(Vector3.new(targetPos.X, targetPos.Y + 5, targetPos.Z))

								activeMorphItem = randomItemName
								activeMorphRarity = activeRarity
								isEscaping = true

								ToggleMorphEvent:FireServer(true)

								task.spawn(function()
									task.wait(2) -- Tsunami cooldown changed to 2s

									if not isEscaping then return end 

									local spawnPart = activeZoneFolder:FindFirstChild("Spawn") :: BasePart
									if spawnPart and TsunamisFolder and TsunamiEndPart then
										local tData = TsunamiConfigs.GetTsunamiData(activeZoneFolder.Name)
										local tTemplate = TsunamisFolder:FindFirstChild(tData.ModelName)
										if tTemplate then
											activeTsunami = tTemplate:Clone() :: Model

											for _, desc in ipairs(activeTsunami:GetDescendants()) do
												if desc:IsA("Script") or desc:IsA("LocalScript") then
													desc:Destroy()
												elseif desc:IsA("BasePart") then
													desc.CanCollide = false
													desc.CanTouch = false
													desc.CanQuery = false
												end
											end

											activeTsunami.Parent = Workspace

											local startPos = spawnPart.Position
											local endPos = TsunamiEndPart.Position
											local flatEnd = Vector3.new(endPos.X, startPos.Y, endPos.Z)

											activeTsunami:PivotTo(CFrame.new(startPos, flatEnd))

											tsunamiSpeed = tData.Speed
											tsunamiDir = (flatEnd - startPos).Unit
										end
									end
								end)

							else
								if fakeItem then fakeItem:Destroy() end
							end
						end
					else
						if blockClone then blockClone:Destroy() end
					end

					restoreCamera(char)

					if root and root.Parent then root.Anchored = false end
					isKicking = false
				end)
			else
				if root and root.Parent then root.Anchored = false end
				isKicking = false
			end

			loadedKickTrack.Stopped:Wait()
		end

		if not loadedKickTrack then
			if root and root.Parent then root.Anchored = false end
			isKicking = false
		end
	end
end)

-- [ BUTTON LOGIC: START KICK ]
kickButton.MouseButton1Click:Connect(function()
	if isKicking or not loadedKickTrack or isSelectingPower then return end

	isSelectingPower = true
	kickButton.Visible = false
	currentPower = 0
	powerDir = 1

	barFill.Size = UDim2.new(1, 0, 0, 0)
	barFill.Position = UDim2.new(0, 0, 1, 0)
	powerBar.Visible = true
end)

-- [ UPDATE LOOP ]
RunService.Heartbeat:Connect(function(dt: number)
	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart") :: BasePart
	if not root then return end

	-- [[ BUG FIX: FORCE UNEQUIP IN KICKPART & ZONES ]] --
	local inRestrictedArea = false
	local isInsideKickPart = false

	local kickPart = Workspace:FindFirstChild("KickPart") :: BasePart
	if kickPart then
		local relPos = kickPart.CFrame:PointToObjectSpace(root.Position)
		local size = kickPart.Size
		isInsideKickPart = math.abs(relPos.X) <= size.X / 2 and
			math.abs(relPos.Y) <= (size.Y / 2) + 15 and
			math.abs(relPos.Z) <= size.Z / 2

		if isInsideKickPart then
			inRestrictedArea = true
		end
	end

	if not inRestrictedArea then
		local zonesFolder = Workspace:FindFirstChild("Zones")
		if zonesFolder then
			for _, zoneFolder in ipairs(zonesFolder:GetChildren()) do
				for _, partName in ipairs({"Detection", "Collection"}) do
					local zonePart = zoneFolder:FindFirstChild(partName) :: BasePart
					if zonePart and zonePart:IsA("BasePart") then
						local relPos = zonePart.CFrame:PointToObjectSpace(root.Position)
						local size = zonePart.Size
						if math.abs(relPos.X) <= size.X / 2 and math.abs(relPos.Y) <= (size.Y / 2) + 15 and math.abs(relPos.Z) <= size.Z / 2 then
							inRestrictedArea = true
							break
						end
					end
				end
				if inRestrictedArea then break end
			end
		end
	end

	if inRestrictedArea then
		local hum = char:FindFirstChild("Humanoid") :: Humanoid
		if hum and char:FindFirstChildWhichIsA("Tool") then
			hum:UnequipTools()
		end
	end
	-- [[ END BUG FIX ]] --

	-- [[ ESCAPE DETECTION & TSUNAMI LOGIC ]] --
	if isEscaping and targetCollectionPart then
		local hum = char:FindFirstChild("Humanoid") :: Humanoid

		if hum and hum.Health <= 0 then
			isEscaping = false
			ToggleMorphEvent:FireServer(false) 
			if activeTsunami then activeTsunami:Destroy(); activeTsunami = nil end
			if activeMorph then activeMorph:Destroy(); activeMorph = nil end
			targetCollectionPart = nil
			activeMorphItem = nil
			activeMorphRarity = nil
			return
		end

		if activeTsunami then
			activeTsunami:PivotTo(activeTsunami:GetPivot() + (tsunamiDir * tsunamiSpeed * dt))

			local tCFrame, tSize
			local hitboxPart = activeTsunami:FindFirstChild("Hitbox") :: BasePart
			if hitboxPart then
				tCFrame = hitboxPart.CFrame
				tSize = hitboxPart.Size
			else
				tCFrame, tSize = activeTsunami:GetBoundingBox()
				tSize = tSize * 0.8
			end

			local dist = (tCFrame.Position - root.Position).Magnitude
			local SHAKE_DISTANCE = 80

			if hum then
				if dist < SHAKE_DISTANCE then
					local intensity = 1 - (dist / SHAKE_DISTANCE)
					local offset = Vector3.new(
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2
					) * (1.5 * intensity)
					hum.CameraOffset = offset
				else
					hum.CameraOffset = Vector3.zero
				end
			end

			local overlapParams = OverlapParams.new()
			overlapParams.FilterType = Enum.RaycastFilterType.Include
			overlapParams.FilterDescendantsInstances = {char, activeMorph}

			local hitParts = Workspace:GetPartBoundsInBox(tCFrame, tSize, overlapParams)
			if #hitParts > 0 then
				print("[KickController] Caught by Tsunami!")
				isEscaping = false
				ToggleMorphEvent:FireServer(false) 

				if hum then hum.CameraOffset = Vector3.zero end 

				if activeTsunami then activeTsunami:Destroy(); activeTsunami = nil end
				if activeMorph then activeMorph:Destroy(); activeMorph = nil end

				setCharacterVisibility(char, true)
				for _, p in ipairs(char:GetDescendants()) do
					if p:IsA("BasePart") then
						p.CollisionGroup = "PlayerCharacters"
					end
				end

				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
				local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
				if plot then
					local plotSpawn = plot:FindFirstChild("Spawn")
					if plotSpawn and plotSpawn:IsA("BasePart") then
						root.CFrame = plotSpawn.CFrame + Vector3.new(0, 5, 0)
					elseif plot.PrimaryPart then
						root.CFrame = plot.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
					end
				end

				NotificationManager.show("You are to slow!", "Error")

				targetCollectionPart = nil
				activeMorphItem = nil
				activeMorphRarity = nil
				return 
			end
		end

		if activeMorph and activeMorph.PrimaryPart then
			local rayOrigin = root.Position + Vector3.new(0, 5, 0)
			local excludeList = {char, activeMorph}
			local zonesFolder = Workspace:FindFirstChild("Zones")
			if zonesFolder then table.insert(excludeList, zonesFolder) end

			local rayParams = RaycastParams.new()
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			rayParams.FilterDescendantsInstances = excludeList

			local rayResult = Workspace:Raycast(rayOrigin, Vector3.new(0, -20, 0), rayParams)
			local floorY = rayResult and rayResult.Position.Y or (root.Position.Y - 3)

			local bboxCFrame, bboxSize = activeMorph:GetBoundingBox()
			local bottomOffset = bboxSize.Y / 2

			local _, rootRotY, _ = root.CFrame:ToEulerAnglesYXZ()

			local flatFloorCFrame = CFrame.new(root.Position.X, floorY + bottomOffset, root.Position.Z) * CFrame.Angles(0, rootRotY, 0)

			activeMorph:PivotTo(flatFloorCFrame)
		end

		local inAnyCollection = false
		local zonesFolder = Workspace:FindFirstChild("Zones")
		if zonesFolder then
			for _, zoneFolder in ipairs(zonesFolder:GetChildren()) do
				local collectionPart = zoneFolder:FindFirstChild("Collection") :: BasePart
				if collectionPart and collectionPart:IsA("BasePart") then
					local relPos = collectionPart.CFrame:PointToObjectSpace(root.Position)
					local size = collectionPart.Size

					if math.abs(relPos.X) <= (size.X / 2) + 2 and math.abs(relPos.Y) <= (size.Y / 2) + 15 and math.abs(relPos.Z) <= (size.Z / 2) + 2 then
						inAnyCollection = true
						break
					end
				end
			end
		end

		if not inAnyCollection then
			isEscaping = false
			ToggleMorphEvent:FireServer(false) 

			print("[KickController] Player Escaped Zone! Awarding Tool...")

			if hum then hum.CameraOffset = Vector3.zero end 

			if activeTsunami then activeTsunami:Destroy(); activeTsunami = nil end

			local confettiSound = GlobalSounds:FindFirstChild("Confetti")
			if confettiSound and confettiSound:IsA("Sound") then
				local soundClone = confettiSound:Clone()
				soundClone.Parent = root
				soundClone:Play()
				Debris:AddItem(soundClone, soundClone.TimeLength + 0.1)
			end

			local confettiTemplate = Templates:FindFirstChild("Confetti")
			if confettiTemplate and confettiTemplate:IsA("Attachment") then
				local confettiClone = confettiTemplate:Clone()
				confettiClone.Parent = root

				for _, child in ipairs(confettiClone:GetChildren()) do
					if child:IsA("ParticleEmitter") then
						child:Emit(child:GetAttribute("EmitCount") or 50)
					end
				end

				Debris:AddItem(confettiClone, 3)
			end

			local ClaimEvent = Events:FindFirstChild("ClaimHatchedItem")
			if ClaimEvent and activeMorphItem then
				ClaimEvent:FireServer(activeMorphItem, activeMorphRarity)

				local savedItemName = activeMorphItem
				task.spawn(function()
					local backpack = player:WaitForChild("Backpack", 5)
					local timeout = tick() + 3

					while tick() < timeout and backpack do
						local tool = backpack:FindFirstChild(savedItemName)
						if tool and tool:IsA("Tool") and hum then
							hum:EquipTool(tool)
							break
						end
						task.wait(0.1)
					end
				end)
			end

			if activeMorph then activeMorph:Destroy() end
			activeMorph = nil

			setCharacterVisibility(char, true)
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CollisionGroup = "PlayerCharacters"
				end
			end

			targetCollectionPart = nil
			activeMorphItem = nil
			activeMorphRarity = nil
		end

		return
	end

	-- [[ KICK BUTTON & POWER BAR LOGIC ]] --
	if not kickPart then 
		if kickButton.Visible then kickButton.Visible = false end
		return 
	end

	if isSelectingPower then
		if not isInsideKickPart then
			isSelectingPower = false
			powerBar.Visible = false
		else
			currentPower += powerDir * (dt * KickConfigs.PowerBarSpeed)
			if currentPower >= 1 then
				currentPower = 1
				powerDir = -1
			elseif currentPower <= 0 then
				currentPower = 0
				powerDir = 1
			end
			barFill.Size = UDim2.new(1, 0, currentPower, 0)
			barFill.Position = UDim2.new(0, 0, 1 - currentPower, 0)
		end
	end

	if isInsideKickPart and not isKicking and not isSelectingPower then
		if not kickButton.Visible then kickButton.Visible = true end
	else
		if kickButton.Visible then kickButton.Visible = false end
	end
end)