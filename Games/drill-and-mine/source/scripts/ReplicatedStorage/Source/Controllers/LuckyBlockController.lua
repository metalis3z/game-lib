local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local BuyTransitionController = require(ReplicatedStorage.Source.Controllers.BuyTransitionController)

local LuckyBlockController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local LuckyBlockRemotes = Remotes:WaitForChild("LuckyBlockService")
local RequestOpenFunc = LuckyBlockRemotes:WaitForChild("RequestOpen")
local OpenResultEvent = LuckyBlockRemotes:WaitForChild("OpenResult")
local ConfirmLuckyRevealEvent = LuckyBlockRemotes:WaitForChild("ConfirmLuckyReveal")

local InventoryRemotes = Remotes:WaitForChild("InventoryService")
local EquippedItemUpdateEvent = InventoryRemotes:WaitForChild("EquippedItemUpdate")
local RequestEquippedItemFunc = InventoryRemotes:WaitForChild("RequestEquippedItem")

local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")

-- Deferred to avoid any controller-load-order surprise; cached after first lookup.
local NotificationsController = nil
local function getNotificationsController()
	if NotificationsController == false then return nil end
	if NotificationsController then return NotificationsController end
	local ok, mod = pcall(function()
		return require(ReplicatedStorage.Source.Controllers.NotificationsController)
	end)
	NotificationsController = (ok and mod) or false
	return NotificationsController or nil
end

local function getBrainrotDisplayName(brainrotId)
	local cfg = GameConfig.Items and GameConfig.Items[brainrotId]
	return (cfg and (cfg.DisplayName or cfg.displayName)) or brainrotId
end

local function notifyUnboxed(brainrotId)
	local nc = getNotificationsController()
	if not nc then return end
	nc.SendGreen(string.format("You unboxed %s!", getBrainrotDisplayName(brainrotId)))
end

local LuckyBlockModels = ReplicatedStorage:FindFirstChild("LuckyBlocks")
-- Brainrot templates now live under ReplicatedStorage.Brainrots.<Rarity>.<Mutation>.<id>.
-- Resolution goes through GameConfig.GetBrainrotTemplate so callers don't need to
-- know the rarity bucket the id lives in.
local BrainrotModels = nil
local function lookupBrainrotByName(modelName)
	return GameConfig.GetBrainrotTemplate and GameConfig.GetBrainrotTemplate(modelName, nil) or nil
end
local HighlightsFolder = ReplicatedStorage:FindFirstChild("Highlights")
local EffectsFolder = ReplicatedStorage:FindFirstChild("Effects")

local camera = Workspace.CurrentCamera
local player = Players.LocalPlayer

local cachedEquippedItemSummary = nil
local isOpening = false

local ARC_DURATION = 0.8
local GROUND_HOVER = 0.5
local WOBBLE_SPEED = 3.0
local WOBBLE_ANGLE = 12
local WOBBLE_DURATION = 1.5
local SHRINK_DURATION = 0.3
local REVEAL_TOTAL_TIME = 2.5
local REVEAL_SLOW_START = 0.12
local REVEAL_FAST_END = 0.04
local REVEAL_HOLD_TIME = 1.5
local FLY_TO_PLAYER_DURATION = 0.5
local HIDDEN_CF = CFrame.new(0, -10000, 0)
local MAX_POOL_SIZE = 4

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local activeBrainrots = {}
local activeBrainrotCount = 0
local billboardConn = nil

local cleanedBrainrotTemplates = {}

local function getCleanedBrainrotTemplate(modelName)
	if not modelName then return nil end
	if cleanedBrainrotTemplates[modelName] then return cleanedBrainrotTemplates[modelName] end

	local original = lookupBrainrotByName(modelName)
	if not original then return nil end

	local template = original:Clone()

	for _, desc in template:GetDescendants() do
		if desc:IsA("BasePart") then
			desc.CanCollide = false
			desc.CanQuery = false
			desc.CanTouch = false
			desc.Anchored = true
		elseif desc:IsA("KeyframeSequence") or desc:IsA("CFrameValue") then
			-- Strip authoring leftovers only. Bones drive skinned-mesh
			-- deformation -- removing them froze the reveal roulette models
			-- in their rest pose. The AnimationController is needed for the
			-- Idle animation we kick off in spawnBrainrotAtPosition below.
			desc:Destroy()
		end
	end

	cleanedBrainrotTemplates[modelName] = template
	return template
end

local function warmupTemplates()
	for modelName, cfg in pairs(GameConfig.Items) do
		getCleanedBrainrotTemplate(cfg.ModelName or modelName)
	end
end

local function startBillboardLoop()
	if billboardConn then return end
	billboardConn = RunService.RenderStepped:Connect(function()
		if activeBrainrotCount == 0 then return end

		local camCF = camera.CFrame
		local camX, _, camZ = camCF.Position.X, camCF.Position.Y, camCF.Position.Z

		local i = 1
		while i <= activeBrainrotCount do
			local entry = activeBrainrots[i]
			local mdl = entry.Model

			if not mdl or not mdl.Parent or not mdl.PrimaryPart then
				activeBrainrots[i] = activeBrainrots[activeBrainrotCount]
				activeBrainrots[activeBrainrotCount] = nil
				activeBrainrotCount = activeBrainrotCount - 1
				continue
			end

			local pivot = mdl:GetPivot()
			local px, py, pz = pivot.Position.X, pivot.Position.Y, pivot.Position.Z
			local dx = camX - px
			local dz = camZ - pz

			if dx * dx + dz * dz > 0.0001 then
				local targetCF = CFrame.lookAt(
					Vector3.new(px, py, pz),
					Vector3.new(px + dx, py, pz + dz)
				)
				mdl:PivotTo(targetCF)
			end

			i = i + 1
		end
	end)
end

local function registerBrainrot(model)
	activeBrainrotCount = activeBrainrotCount + 1
	activeBrainrots[activeBrainrotCount] = { Model = model }
	startBillboardLoop()
end

local function unregisterBrainrot(model)
	for i = 1, activeBrainrotCount do
		if activeBrainrots[i].Model == model then
			activeBrainrots[i] = activeBrainrots[activeBrainrotCount]
			activeBrainrots[activeBrainrotCount] = nil
			activeBrainrotCount = activeBrainrotCount - 1
			return
		end
	end
end

local function updateRayFilter()
	local ignore = {}
	local char = player.Character
	if char then ignore[1] = char end
	for _, child in Workspace:GetChildren() do
		if child.Name == "LuckyBlockOpen" then
			ignore[#ignore + 1] = child
		end
	end
	rayParams.FilterDescendantsInstances = ignore
end

local function getGroundY(xzPos, fallbackY)
	local origin = Vector3.new(xzPos.X, fallbackY + 50, xzPos.Z)
	local result = Workspace:Raycast(origin, Vector3.new(0, -200, 0), rayParams)
	if result then return result.Position.Y end
	return fallbackY
end

local function getArcPositions(count, origin, forward, right)
	updateRayFilter()
	local positions = table.create(count)

	if count == 1 then
		local flat = origin + forward * 10
		positions[1] = Vector3.new(flat.X, getGroundY(flat, origin.Y) + GROUND_HOVER, flat.Z)
	elseif count == 3 then
		for i = 1, 3 do
			local angle = math.rad(-30 + (i - 1) * 30)
			local dir = forward * math.cos(angle) + right * math.sin(angle)
			local flat = origin + dir * 10
			positions[i] = Vector3.new(flat.X, getGroundY(flat, origin.Y) + GROUND_HOVER, flat.Z)
		end
	else
		for i = 1, count do
			local angle = math.rad((360 / count) * (i - 1))
			local dir = forward * math.cos(angle) + right * math.sin(angle)
			local flat = origin + dir * 12
			positions[i] = Vector3.new(flat.X, getGroundY(flat, origin.Y) + GROUND_HOVER, flat.Z)
		end
	end

	return positions
end

local function tweenModelScale(model, targetScale, duration, easingStyle, easingDir)
	local info = TweenInfo.new(duration, easingStyle or Enum.EasingStyle.Quad, easingDir or Enum.EasingDirection.Out)
	local startScale = model:GetScale()
	local val = Instance.new("NumberValue")
	val.Value = 0

	local tween = TweenService:Create(val, info, { Value = 1 })
	tween:Play()

	local conn
	conn = val.Changed:Connect(function()
		local s = startScale + (targetScale - startScale) * val.Value
		if model and model.Parent then model:ScaleTo(s) end
	end)

	tween.Completed:Connect(function()
		conn:Disconnect()
		val:Destroy()
		if model and model.Parent then model:ScaleTo(targetScale) end
	end)

	return tween
end

local function getLuckyBlockTemplate(modelName)
	if not modelName then return nil end
	if LuckyBlockModels then
		local t = LuckyBlockModels:FindFirstChild(modelName)
		if t then return t end
	end
	return ReplicatedStorage:FindFirstChild(modelName)
end

-- Pivot offset stored as an attribute so the landing/wobble math can lift the
-- model up by half its height — otherwise the pivot lands at ground level and
-- the bottom half of the box sinks into the terrain.
local function recordPivotToBottom(model)
	local bbCF, bbSize = model:GetBoundingBox()
	local pivotY = model:GetPivot().Position.Y
	local pivotToBottom = pivotY - (bbCF.Position.Y - bbSize.Y / 2)
	model:SetAttribute("_PivotToBottom", pivotToBottom)
end

-- Computes the "natural visible" scale for an unboxing lucky block model so
-- the arc animation grows it to a consistent ~5-stud size regardless of the
-- model's source GetScale() (the new pack ships at 0.020 baseline; the old
-- pre-shrink target of 1.0 was a ~50× upscale).
local OPEN_ANIM_TARGET_MAX_DIM = 5.0
local function computeOpenTargetScale(model)
	local _, curSize = model:GetBoundingBox()
	local maxDim = math.max(curSize.X, curSize.Y, curSize.Z, 0.01)
	return model:GetScale() * (OPEN_ANIM_TARGET_MAX_DIM / maxDim)
end

-- Anchors every BasePart, removes collisions, and tags the model with the
-- precomputed open-animation target scale (used by playOpenSequence).
local function prepareOpenLuckyBlockModel(model)
	local primary = model.PrimaryPart
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
			d.CastShadow = false
		elseif d:IsA("ProximityPrompt") or d:IsA("BillboardGui") then
			d:Destroy()
		end
	end
	local target = computeOpenTargetScale(model)
	model:SetAttribute("_OpenTargetScale", target)
end

local function spawnLuckyBlockFast(luckyBlockId)
	local cfg = GameConfig.LuckyBlocks and GameConfig.LuckyBlocks[luckyBlockId]
	if not cfg then return nil end

	local template = getLuckyBlockTemplate(cfg.ModelName)
	if not template then return nil end

	if template:IsA("Model") then
		local model = template:Clone()
		recordPivotToBottom(model)
		prepareOpenLuckyBlockModel(model)
		model:ScaleTo(0.01)
		return model
	elseif template:IsA("BasePart") then
		local part = template:Clone()
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.PivotOffset = CFrame.new()
		local model = Instance.new("Model")
		model.Name = template.Name
		part.Parent = model
		model.PrimaryPart = part
		recordPivotToBottom(model)
		prepareOpenLuckyBlockModel(model)
		model:ScaleTo(0.01)
		return model
	end
	return nil
end

local function playEffectAtPosition(pos)
	if not EffectsFolder then return end
	local effectAttachment = EffectsFolder:FindFirstChild("HatchEffect")
	if not effectAttachment then return end

	local effectPart = Instance.new("Part")
	effectPart.Size = Vector3.new(1, 1, 1)
	effectPart.Transparency = 1
	effectPart.CanCollide = false
	effectPart.Anchored = true
	effectPart.Position = pos
	effectPart.Parent = Workspace

	local cloned = effectAttachment:Clone()
	cloned.Parent = effectPart

	for _, emitter in cloned:GetDescendants() do
		if emitter:IsA("ParticleEmitter") then
			emitter.Enabled = true
			task.delay(0.3, function() emitter.Enabled = false end)
		end
	end

	Debris:AddItem(effectPart, 2)
end

local function getPlayerPosition()
	local character = player.Character
	if not character then return Vector3.zero end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return Vector3.zero end
	return rootPart.Position + Vector3.new(0, 1, 0)
end

local function getBrainrotGroundCFrame(position, model)
	local boundsCF, modelSize = model:GetBoundingBox()
	local bottomOfModel = boundsCF.Position.Y - modelSize.Y / 2
	local pivotY = model:GetPivot().Position.Y
	local pivotToBottom = pivotY - bottomOfModel
	return CFrame.new(position + Vector3.new(0, pivotToBottom, 0))
end

local function playRevealIdle(model)
	local controller = model:FindFirstChildWhichIsA("AnimationController", true)
	if not controller then return end
	local animator = controller:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = controller
	end
	local idle
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("Animation") and d.Name == "Idle" then
			idle = d
			break
		end
	end
	if not idle or idle.AnimationId == "" then return end
	local track = animator:LoadAnimation(idle)
	track.Looped = true
	track:Play()
end

local function spawnBrainrotAtPosition(brainrotKey, position, parent, withHighlight)
	local cfg = GameConfig.Items[brainrotKey]
	if not cfg then return nil end

	-- GameConfig.Items entries don't carry a ModelName field; the dict key IS
	-- the model name. Mirror the fallback warmupTemplates already uses.
	local template = getCleanedBrainrotTemplate(cfg.ModelName or brainrotKey)
	if not template then return nil end

	local mdl = template:Clone()
	mdl:PivotTo(getBrainrotGroundCFrame(position, mdl))
	mdl.Parent = parent
	-- Roulette cycle + landed reveal both feel dead without the rig moving.
	-- Idle is a sibling of AnimationController on the template (and survives
	-- the cleaner after the fix above), so this just loads + loops it.
	-- Wrapped in pcall so a single broken template (e.g. missing AnimationId
	-- on a freshly-added brainrot) can't bubble up and abort the open flow.
	pcall(playRevealIdle, mdl)

	if withHighlight and HighlightsFolder then
		local blackHL = HighlightsFolder:FindFirstChild("Black")
		if blackHL then
			local hl = blackHL:Clone()
			hl.Parent = mdl
			hl.Adornee = mdl
			hl.Enabled = true
		end
	end

	registerBrainrot(mdl)
	return mdl
end

local function playBrainrotReveal(position, possibleBrainrots, finalBrainrotId, parentContainer, onComplete)
	local roulettePool = {}
	local poolIds = {}
	local finalModel = nil
	local finalGroundCF = nil
	local poolReady = false

	-- Spread cloning across frames to avoid hitching when opening many at once
	task.spawn(function()
		local seen = {}
		for _, id in ipairs(possibleBrainrots) do
			if #poolIds >= MAX_POOL_SIZE then break end
			if not seen[id] then
				seen[id] = true
				local mdl = spawnBrainrotAtPosition(id, position, parentContainer, true)
				if mdl then
					local groundCF = mdl:GetPivot()
					local naturalScale = mdl:GetScale()
					unregisterBrainrot(mdl)
					mdl:PivotTo(HIDDEN_CF)
					roulettePool[id] = { Model = mdl, GroundCF = groundCF, NaturalScale = naturalScale }
					poolIds[#poolIds + 1] = id
				end
			end
			task.wait()
		end

		if not roulettePool[finalBrainrotId] then
			local mdl = spawnBrainrotAtPosition(finalBrainrotId, position, parentContainer, true)
			if mdl then
				local groundCF = mdl:GetPivot()
				local naturalScale = mdl:GetScale()
				unregisterBrainrot(mdl)
				mdl:PivotTo(HIDDEN_CF)
				roulettePool[finalBrainrotId] = { Model = mdl, GroundCF = groundCF, NaturalScale = naturalScale }
				poolIds[#poolIds + 1] = finalBrainrotId
			end
			task.wait()
		end

		local fMdl = spawnBrainrotAtPosition(finalBrainrotId, position, parentContainer, false)
		if fMdl then
			finalGroundCF = fMdl:GetPivot()
			unregisterBrainrot(fMdl)
			fMdl:PivotTo(HIDDEN_CF)
			finalModel = fMdl
		end

		poolReady = true
	end)

	local currentId = nil

	local function showRouletteModel(id)
		if currentId then
			local prev = roulettePool[currentId]
			if prev then
				unregisterBrainrot(prev.Model)
				prev.Model:PivotTo(HIDDEN_CF)
			end
		end
		currentId = id
		local entry = roulettePool[id]
		if not entry then return nil end
		registerBrainrot(entry.Model)
		return entry
	end

	local elapsed = 0
	local nextSwitch = 0
	local started = false

	local conn
	conn = RunService.Heartbeat:Connect(function(dt)
		if not poolReady then return end

		elapsed = elapsed + dt

		local progress = elapsed / REVEAL_TOTAL_TIME
		local interval = REVEAL_FAST_END + (REVEAL_SLOW_START - REVEAL_FAST_END) * progress

		if not started then
			started = true
			local initId = poolIds[math.random(1, #poolIds)]
			local entry = showRouletteModel(initId)
			if entry then entry.Model:PivotTo(entry.GroundCF) end
			nextSwitch = elapsed + interval
		end

		if elapsed >= REVEAL_TOTAL_TIME then
			conn:Disconnect()

			if currentId and roulettePool[currentId] then
				unregisterBrainrot(roulettePool[currentId].Model)
			end
			for _, entry in pairs(roulettePool) do
				entry.Model:Destroy()
			end

			-- Always notify, even if the visual spawn failed — the server already
			-- granted the brainrot, so the player should always see what they got.
			notifyUnboxed(finalBrainrotId)

			if not finalModel then
				if onComplete then onComplete() end
				return
			end

			local naturalScale = finalModel:GetScale()
			finalModel:ScaleTo(0.01)
			finalModel:PivotTo(finalGroundCF)
			registerBrainrot(finalModel)
			tweenModelScale(finalModel, naturalScale, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

			task.delay(REVEAL_HOLD_TIME, function()
				if not finalModel or not finalModel.PrimaryPart then
					if onComplete then onComplete() end
					return
				end

				unregisterBrainrot(finalModel)
				local startPos = finalModel:GetPivot().Position
				local midPos = (startPos + getPlayerPosition()) / 2 + Vector3.new(0, 5, 0)

				tweenModelScale(finalModel, 0.01, FLY_TO_PLAYER_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.In)

				local flyElapsed = 0
				local flyConn
				flyConn = RunService.Heartbeat:Connect(function(flyDt)
					flyElapsed = flyElapsed + flyDt
					local alpha = math.min(flyElapsed / FLY_TO_PLAYER_DURATION, 1)
					local t = alpha * alpha

					local p2 = getPlayerPosition()
					local pos = (1 - t)^2 * startPos + 2 * (1 - t) * t * midPos + t^2 * p2

					if finalModel and finalModel.PrimaryPart then
						local cx = camera.CFrame.Position.X - pos.X
						local cz = camera.CFrame.Position.Z - pos.Z
						if cx * cx + cz * cz > 0.0001 then
							finalModel:PivotTo(CFrame.lookAt(pos, pos + Vector3.new(cx, 0, cz)))
						else
							finalModel:PivotTo(CFrame.new(pos))
						end
					end

					if alpha >= 1 then
						flyConn:Disconnect()
						finalModel:Destroy()
						if onComplete then onComplete() end
					end
				end)
			end)

			return
		end

		if elapsed >= nextSwitch then
			nextSwitch = elapsed + interval

			local pick = progress > 0.85 and finalBrainrotId or poolIds[math.random(1, #poolIds)]
			local entry = showRouletteModel(pick)

			if entry and entry.Model and entry.Model.PrimaryPart then
				local shakeAmt = 0.3 * progress
				local shake = Vector3.new(
					(math.random() - 0.5) * shakeAmt,
					(math.random() - 0.5) * shakeAmt * 0.3,
					(math.random() - 0.5) * shakeAmt
				)
				entry.Model:PivotTo(entry.GroundCF + shake)
			end
		end
	end)
end

local function playOpenSequence(data)
	local luckyBlockId = data.LuckyBlockId
	local results = data.Results
	local possibleBrainrots = data.PossibleBrainrots
	local openCount = data.OpenCount
	local revealKey = data.RevealKey

	isOpening = true

	local character = player.Character
	if not character then isOpening = false return end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then isOpening = false return end

	local origin = rootPart.Position
	local lookVector = rootPart.CFrame.LookVector
	local rightVector = rootPart.CFrame.RightVector

	local groundPositions = getArcPositions(openCount, origin, lookVector, rightVector)

	local container = Instance.new("Folder")
	container.Name = "LuckyBlockOpen"
	container.Parent = Workspace

	local revealsFinished = 0
	local totalReveals = math.min(openCount, #results)

	local function onRevealDone()
		revealsFinished = revealsFinished + 1
		if revealsFinished >= totalReveals then
			if revealKey then
				ConfirmLuckyRevealEvent:FireServer(revealKey)
			end
			task.delay(0.5, function() container:Destroy() end)
			isOpening = false
		end
	end

	-- Batch open: spread cloning across frames via task.delay'd lazy spawn rather
	-- than a synchronous burst. For 10 lucky blocks this keeps every frame
	-- responsive instead of stalling on a single tick.
	local stagger = (openCount > 3) and 0.08 or 0.06

	for i = 1, openCount do
		local startPos = origin + Vector3.new(0, 2, 0)
		local landPos = groundPositions[i] or (origin + Vector3.new(0, 0, -10))
		local arcPeak = (startPos + landPos) / 2 + Vector3.new(0, 15, 0)
		local resultEntry = results[i]

		task.delay((i - 1) * stagger, function()
			local model = spawnLuckyBlockFast(luckyBlockId)
			if not model then
				onRevealDone()
				return
			end

			local groundOffset = model:GetAttribute("_PivotToBottom") or 0

			model:PivotTo(CFrame.new(startPos + Vector3.new(0, groundOffset, 0)))
			model.Parent = container
			local openTarget = model:GetAttribute("_OpenTargetScale") or computeOpenTargetScale(model)
			tweenModelScale(model, openTarget, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

			local elapsed = 0
			local arcConn
			arcConn = RunService.Heartbeat:Connect(function(dt)
				elapsed = elapsed + dt
				local alpha = math.min(elapsed / ARC_DURATION, 1)
				local t = alpha

				local pos = (1 - t)^2 * startPos + 2 * (1 - t) * t * arcPeak + t^2 * landPos
				local spin = math.rad(360) * alpha

				if model and model.PrimaryPart then
					model:PivotTo(CFrame.new(pos + Vector3.new(0, groundOffset, 0)) * CFrame.Angles(0, spin, 0))
				end

				if alpha >= 1 then
					arcConn:Disconnect()

					local wobbleElapsed = 0
					local wobbleConn
					wobbleConn = RunService.Heartbeat:Connect(function(wdt)
						wobbleElapsed = wobbleElapsed + wdt

						if wobbleElapsed >= WOBBLE_DURATION then
							wobbleConn:Disconnect()

							local shrink = tweenModelScale(model, 0.01, SHRINK_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.In)
							shrink.Completed:Connect(function()
								model:Destroy()
								playEffectAtPosition(landPos)

								if resultEntry then
									playBrainrotReveal(landPos, possibleBrainrots, resultEntry.BrainrotId, container, onRevealDone)
								else
									onRevealDone()
								end
							end)
							return
						end

						local wobble = math.sin(wobbleElapsed * WOBBLE_SPEED * math.pi * 2) * math.rad(WOBBLE_ANGLE)
						local bob = math.sin(wobbleElapsed * 2) * 0.3

						if model and model.PrimaryPart then
							model:PivotTo(
								CFrame.new(landPos + Vector3.new(0, bob + groundOffset, 0))
									* CFrame.Angles(0, 0, wobble)
							)
						end
					end)
				end
			end)
		end)
	end
end

local function getEquippedLuckyBlockCount()
	if not cachedEquippedItemSummary then return 0, nil end

	local equippedItem = cachedEquippedItemSummary.ItemId or ""
	if equippedItem == "" then return 0, nil end
	if cachedEquippedItemSummary.ItemType ~= "LuckyBlock" then return 0, nil end

	return cachedEquippedItemSummary.Amount or 0, equippedItem
end

local function tryOpenLuckyBlock()
	if isOpening then return end

	local count, luckyBlockId = getEquippedLuckyBlockCount()
	if not luckyBlockId or count <= 0 then return end

	isOpening = true

	local success = RequestOpenFunc:InvokeServer(luckyBlockId)
	if not success then
		isOpening = false
	end
end

local function onOpenResult(data)
	if not data then
		isOpening = false
		return
	end
	-- Placed-pad open (SkipInventoryAdd): the server already committed the
	-- brainrot on the pad slot, so the regular arc/fly-to-player open sequence
	-- would just spam the player with a confusing animation at their feet.
	-- PodiumController handles the at-the-pad reveal animation (keyed by
	-- data.PodiumIndex) AND fires notifyUnboxed when the animation finishes --
	-- we used to notify here, but that spoiled the reveal (the name popped up
	-- the instant the player pressed E, before the roulette played out).
	if data.SkipInventoryAdd then
		isOpening = false
		return
	end
	playOpenSequence(data)
end

local function onEquippedItemUpdate(summary)
	cachedEquippedItemSummary = summary
end

local function wireShopButtons()
	local shopCfg = GameConfig.Shop and GameConfig.Shop.LuckyBlock
	local tiers = shopCfg and shopCfg.Tiers
	if not tiers then return end

	local playerGui = player:WaitForChild("PlayerGui", 10)
	if not playerGui then return end

	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return end

	local folder = gui:WaitForChild("Folder", 10)
	if not folder then return end

	local shopFrame = folder:WaitForChild("Shop", 10)
	if not shopFrame then return end

	local rewards = shopFrame:WaitForChild("Rewards", 5)
	if not rewards then return end

	local scrollOuter = rewards:WaitForChild("ScrollingFrame", 5)
	if not scrollOuter then return end

	local scrollInner = scrollOuter:WaitForChild("ScrollingFrame", 5)
	if not scrollInner then return end

	local exclusiveFrame = scrollInner:WaitForChild("ExclusiveLuckyBlock", 5)
	if not exclusiveFrame then return end

	-- Populate the Brainrot1..N preview holders from PossibleBrainrots.
	-- Iterates the config in order — holder N maps to entry N.
	local brainrotsFrame = exclusiveFrame:FindFirstChild("Items")
	if brainrotsFrame then
		local pool = shopCfg.PossibleBrainrots or {}

		local totalWeight = 0
		for _, e in ipairs(pool) do
			totalWeight = totalWeight + (e.Chance or 0)
		end

		local function setText(label, text)
			if not label then return end
			label.Text = text
			for _, desc in ipairs(label:GetDescendants()) do
				if desc:IsA("TextLabel") then
					desc.Text = text
				end
			end
		end

		local i = 1
		while true do
			local holder = brainrotsFrame:FindFirstChild("Brainrot" .. i)
			if not holder then break end

			local entry = pool[i]
			if entry then
				holder.Visible = true
				local cfg = GameConfig.Items and GameConfig.Items[entry.BrainrotId]
				local icon = holder:FindFirstChild("Icon")
				if icon and icon:IsA("ImageLabel") and cfg and cfg.imageId then
					icon.Image = cfg.imageId
				end

				local percent = (totalWeight > 0) and ((entry.Chance or 0) / totalWeight * 100) or 0
				local text
				if percent >= 1 or percent == 0 then
					text = string.format("%d%%", math.floor(percent + 0.5))
				else
					text = string.format("%.1f%%", percent)
				end
				setText(holder:FindFirstChild("Rarity"), text)
			else
				holder.Visible = false
			end

			i = i + 1
		end
	end

	local buttonsFrame = exclusiveFrame:WaitForChild("Frame", 5)
	if not buttonsFrame then return end

	-- Price/Rarity labels on the Buy buttons are authored manually (including the
	-- Robux icon prefix). Do NOT overwrite them here — only wire the click handler.
	for buttonName, tier in pairs(tiers) do
		local btn = buttonsFrame:FindFirstChild(buttonName)
		if btn and btn:IsA("TextButton") and not btn:GetAttribute("_ShopLBWired") then
			btn:SetAttribute("_ShopLBWired", true)
			btn.MouseButton1Click:Connect(function()
				if isOpening then return end
				if not tier.ProductId or tier.ProductId == 0 then
					warn(string.format("[LuckyBlockController] %s has no ProductId set in GameConfig.Shop.LuckyBlock.Tiers", buttonName))
					return
				end
				pcall(function()
					PromptPurchaseFunc:InvokeServer(tier.ProductId, "ShopLB_" .. buttonName)
				end)
			end)
		end
	end
end


local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

-- Deferred require: CashBoostHudController / RebirthController fire BindableEvents
-- we listen to for live preview updates on the Cash pack Title labels.
local CashBoostHudController = nil
local RebirthController = nil
local function getBoostController()
	if CashBoostHudController == false then return nil end
	if CashBoostHudController then return CashBoostHudController end
	local ok, mod = pcall(function()
		return require(ReplicatedStorage.Source.Controllers.CashBoostHudController)
	end)
	CashBoostHudController = (ok and mod) or false
	return CashBoostHudController or nil
end
local function getRebirthController()
	if RebirthController == false then return nil end
	if RebirthController then return RebirthController end
	local ok, mod = pcall(function()
		return require(ReplicatedStorage.Source.Controllers.RebirthController)
	end)
	RebirthController = (ok and mod) or false
	return RebirthController or nil
end

local function getDisplayMultiplier()
	local mult = 1
	local rc = getRebirthController()
	if rc and rc.GetCurrentMultiplier then
		local ok, v = pcall(rc.GetCurrentMultiplier)
		if ok and type(v) == "number" and v > 0 then mult = mult * v end
	end
	local bc = getBoostController()
	if bc and bc.GetMultiplier then
		local ok, v = pcall(bc.GetMultiplier)
		if ok and type(v) == "number" and v > 0 then mult = mult * v end
	end
	return mult
end

local function findOwnedPlot()
	local assets = Workspace:FindFirstChild("Assets")
	local plots = assets and assets:FindFirstChild("Plots")
	if not plots then return nil end
	for _, plot in ipairs(plots:GetChildren()) do
		if plot:GetAttribute("OwnerUserId") == player.UserId then
			return plot
		end
	end
	return nil
end

local function wireShopCashButtons()
	local cashCfg = GameConfig.Shop and GameConfig.Shop.Cash
	if not cashCfg then return end

	local playerGui = player:WaitForChild("PlayerGui", 10)
	if not playerGui then return end
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return end
	local folder = gui:WaitForChild("Folder", 10)
	if not folder then return end
	local shopFrame = folder:WaitForChild("Shop", 10)
	if not shopFrame then return end
	local rewards = shopFrame:WaitForChild("Rewards", 5)
	if not rewards then return end
	local scrollOuter = rewards:WaitForChild("ScrollingFrame", 5)
	if not scrollOuter then return end
	local scrollInner = scrollOuter:WaitForChild("ScrollingFrame", 5)
	if not scrollInner then return end
	local cashFrame = scrollInner:WaitForChild("Cash", 5)
	if not cashFrame then return end

	local function setText(label, text)
		if not label then return end
		label.Text = text
		for _, desc in ipairs(label:GetDescendants()) do
			if desc:IsA("TextLabel") then
				desc.Text = text
			end
		end
	end

	local function getRawIncome(plot)
		return (plot and plot:GetAttribute("TotalCashPerSec")) or 0
	end

	local entries = {}  -- per-button refs for live refresh
	local currentPlot = nil

	local function refreshAll()
		local income = getRawIncome(currentPlot)
		local mult = getDisplayMultiplier()
		for key, ref in pairs(entries) do
			local entry = ref.entry
			local amount
			if income > 0 then
				amount = math.floor(income * mult * (entry.SecondsAhead or 0))
			end
			if not amount or amount <= 0 then
				amount = entry.FallbackAmount or 0
			end
			setText(ref.titleLabel, "$" .. FormatUtils.Abbreviate(amount))
		end
	end

	for key, entry in pairs(cashCfg) do
		local frame = cashFrame:FindFirstChild(entry.UIName or key)
		if not frame then continue end

		local titleLabel = frame:FindFirstChild("Title")
		local buy = frame:FindFirstChild("Buy")
		if not buy or not buy:IsA("TextButton") then continue end

		entries[key] = { entry = entry, titleLabel = titleLabel }

		if not buy:GetAttribute("_ShopCashWired") then
			buy:SetAttribute("_ShopCashWired", true)
			buy.MouseButton1Click:Connect(function()
				if not entry.ProductId or entry.ProductId == 0 then
					warn(string.format("[LuckyBlockController] %s has no ProductId set in GameConfig.Shop.Cash", key))
					return
				end
				pcall(function()
					PromptPurchaseFunc:InvokeServer(entry.ProductId, "ShopCash_" .. key)
				end)
			end)
		end
	end

	local incomeConn
	local function trackPlot(plot)
		currentPlot = plot
		if incomeConn then incomeConn:Disconnect() incomeConn = nil end
		if plot then
			incomeConn = plot:GetAttributeChangedSignal("TotalCashPerSec"):Connect(refreshAll)
		end
		refreshAll()
	end

	trackPlot(findOwnedPlot())

	local assets = Workspace:FindFirstChild("Assets")
	local plots = assets and assets:FindFirstChild("Plots")
	if plots then
		plots.ChildAdded:Connect(function(plot)
			task.wait(0.1)
			if plot:GetAttribute("OwnerUserId") == player.UserId then
				trackPlot(plot)
			end
		end)
		for _, plot in ipairs(plots:GetChildren()) do
			plot:GetAttributeChangedSignal("OwnerUserId"):Connect(function()
				if plot:GetAttribute("OwnerUserId") == player.UserId then
					trackPlot(plot)
				elseif currentPlot == plot then
					trackPlot(nil)
				end
			end)
		end
	end

	local bc = getBoostController()
	if bc and bc.BoostChanged then
		bc.BoostChanged:Connect(refreshAll)
	end
end

local function wireShopPassButtons()
	local passes = GameConfig.Shop and GameConfig.Shop.Passes
	if not passes then return end

	local playerGui = player:WaitForChild("PlayerGui", 10)
	if not playerGui then return end
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return end
	local folder = gui:WaitForChild("Folder", 10)
	if not folder then return end
	local shopFrame = folder:WaitForChild("Shop", 10)
	if not shopFrame then return end
	local rewards = shopFrame:WaitForChild("Rewards", 5)
	if not rewards then return end
	local scrollOuter = rewards:WaitForChild("ScrollingFrame", 5)
	if not scrollOuter then return end
	local scrollInner = scrollOuter:WaitForChild("ScrollingFrame", 5)
	if not scrollInner then return end
	local passesFrame = scrollInner:WaitForChild("Passes", 5)
	if not passesFrame then return end

	local function setText(label, text)
		if not label then return end
		label.Text = text
		for _, desc in ipairs(label:GetDescendants()) do
			if desc:IsA("TextLabel") then
				desc.Text = text
			end
		end
	end

	local function applyOwnedState(buy, owned, originalPriceText)
		if not buy then return end
		if owned then
			setText(buy:FindFirstChild("Price"), "OWNED")
			buy.Active = false
			buy.AutoButtonColor = false
		else
			if originalPriceText then
				setText(buy:FindFirstChild("Price"), originalPriceText)
			end
			buy.Active = true
			buy.AutoButtonColor = true
		end
	end

	for configKey, entry in pairs(passes) do
		local frame = passesFrame:FindFirstChild(entry.UIName or configKey)
		if not frame then continue end

		local buy = frame:FindFirstChild("Buy")
		if not buy or not buy:IsA("TextButton") then continue end

		local priceLabel = buy:FindFirstChild("Price")
		local authoredPrice = priceLabel and priceLabel.Text or tostring(entry.PriceRobux or "")

		local attrName = "OwnsGamepass_" .. configKey
		applyOwnedState(buy, player:GetAttribute(attrName) == true, authoredPrice)

		player:GetAttributeChangedSignal(attrName):Connect(function()
			applyOwnedState(buy, player:GetAttribute(attrName) == true, authoredPrice)
		end)

		if buy:GetAttribute("_ShopPassWired") then continue end
		buy:SetAttribute("_ShopPassWired", true)

		buy.MouseButton1Click:Connect(function()
			if player:GetAttribute(attrName) == true then return end
			if not entry.GamepassId or entry.GamepassId == 0 then
				warn(string.format("[LuckyBlockController] %s has no GamepassId set in GameConfig.Shop.Passes", configKey))
				return
			end
			BuyTransitionController.PromptGamePass(entry.GamepassId)
		end)
	end
end

function LuckyBlockController.Init()
	OpenResultEvent.OnClientEvent:Connect(onOpenResult)
	EquippedItemUpdateEvent.OnClientEvent:Connect(onEquippedItemUpdate)

	task.defer(function()
		local ok, summary = pcall(function()
			return RequestEquippedItemFunc:InvokeServer()
		end)
		if ok and summary then
			onEquippedItemUpdate(summary)
		end
	end)

	-- Click/E-to-open is intentionally disabled. Lucky blocks open only via the
	-- pad-placement flow with a rarity-scaled timer (PodiumService
	-- .OpenPlacedLuckyBlock). The TryOpen / RequestOpen plumbing stays for the
	-- shop instant-open animation reuse, but no direct input opens a block.

	task.defer(warmupTemplates)
	task.defer(wireShopButtons)
	task.defer(wireShopPassButtons)
	task.defer(wireShopCashButtons)
end

function LuckyBlockController.TryOpen()
	tryOpenLuckyBlock()
end

-- Public hook so PodiumController can fire the "You unboxed X!" green popup
-- AFTER the at-the-pad PadUnboxing animation finishes, instead of the
-- LuckyBlockController firing it the instant SkipInventoryAdd lands (which
-- spoiled the reveal -- the player saw the name before the roulette played).
function LuckyBlockController.NotifyUnboxed(brainrotId)
	if brainrotId and brainrotId ~= "" then
		notifyUnboxed(brainrotId)
	end
end

return LuckyBlockController