local ContentProvider = game:GetService("ContentProvider")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local SWING_ANIMATION_ID = "rbxassetid://114618216071691"
-- Custom sound IDs removed -- waiting on the final in-game asset IDs. Put the
-- real "rbxassetid://..." back into these two and everything (preloaded
-- templates, clone playback, volume) works again. Empty = no sound, no errors.
local SWING_SOUND_ID = "rbxassetid://137901267020570"
local CHOP_HIT_SOUND_ID = "rbxassetid://102961878961484"
local PICKUP_IMAGE_ID = "rbxassetid://116440192832927"
local PICKUP_SOUND_ID = "rbxassetid://72264591133889"

local SWING_SPEED = 1.6
local CHOP_IMPACT_DELAY = 0.13

-- Quieter chop/swing SFX. Templates are created at module load so the assets
-- finish loading long before the first chop (fixes the delayed first wood-
-- break sound); each play is a fresh clone so rapid hits never cut off.
local CHOP_VOLUME = 0.35
local SWING_VOLUME = 0.2
local chopSoundTemplate = Instance.new("Sound")
chopSoundTemplate.SoundId = CHOP_HIT_SOUND_ID
chopSoundTemplate.Volume = CHOP_VOLUME
chopSoundTemplate.Parent = SoundService
local swingSoundTemplate = Instance.new("Sound")
swingSoundTemplate.SoundId = SWING_SOUND_ID
swingSoundTemplate.Volume = SWING_VOLUME
swingSoundTemplate.Parent = SoundService

local SLIDE_DOWN_TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
local SLIDE_UP_TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local SLIDE_DOWN_SCALE_OFFSET = 0.6
local HOTKEY_ACTION = "_TreeAreaBlockHotkeys"

local InventoryRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InventoryService")
local ToggleEquipFunc = InventoryRemotes:WaitForChild("ToggleEquip")
local EquippedItemUpdateEvent = InventoryRemotes:WaitForChild("EquippedItemUpdate")

local BLOCKED_KEYS = {
	Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three,
	Enum.KeyCode.Four, Enum.KeyCode.Five, Enum.KeyCode.Six,
	Enum.KeyCode.Seven, Enum.KeyCode.Eight, Enum.KeyCode.Nine,
	Enum.KeyCode.G,
}

local savedInvPos = nil
local activeInvTween = nil

local MATERIAL_ATTRIBUTE = "BridgeMaterial"
local MAX_STORAGE_ATTRIBUTE = "MaxStorage"
local BASE_DAMAGE_ATTRIBUTE = "BaseDamage"

local currentLevel = nil
local currentCharacter = nil

local TreeAreaController = {}

local LEVEL_AXES = {
	[1] = "NormalAxe",
	[2] = "GoldAxe",
	[3] = "DiamondAxe",
	[4] = "VoidAxe",
}

local SELECTED_AXE_ATTR = "SelectedAxe"

local function getAxeForLevel(plr, level)
	local selected = plr:GetAttribute(SELECTED_AXE_ATTR)
	if type(selected) == "string" and selected ~= "" and GameConfig.Axes and GameConfig.Axes[selected] then
		return selected
	end
	return LEVEL_AXES[level]
end

local Y_SLACK_BELOW = 1
local Y_SLACK_ABOVE = 12

local function slideInvDown(inv)
	if not inv then
		return
	end
	if not savedInvPos then
		savedInvPos = inv.Position
	end
	if activeInvTween then
		activeInvTween:Cancel()
	end
	local target = UDim2.new(
		savedInvPos.X.Scale,
		savedInvPos.X.Offset,
		savedInvPos.Y.Scale + SLIDE_DOWN_SCALE_OFFSET,
		savedInvPos.Y.Offset
	)
	activeInvTween = TweenService:Create(inv, SLIDE_DOWN_TWEEN_INFO, { Position = target })
	activeInvTween:Play()
end

local function slideInvUp(inv)
	if not inv then
		return
	end
	if not savedInvPos then
		savedInvPos = inv.Position
		return
	end
	if activeInvTween then
		activeInvTween:Cancel()
	end
	activeInvTween = TweenService:Create(inv, SLIDE_UP_TWEEN_INFO, { Position = savedInvPos })
	activeInvTween:Play()
end

local function blockHotkeys()
	ContextActionService:BindAction(
		HOTKEY_ACTION,
		function()
			return Enum.ContextActionResult.Sink
		end,
		false,
		table.unpack(BLOCKED_KEYS)
	)
end

local function unblockHotkeys()
	pcall(function()
		ContextActionService:UnbindAction(HOTKEY_ACTION)
	end)
end

local function isAxeTool(child)
	if not child:IsA("Tool") then
		return false
	end
	local axes = GameConfig.Axes
	if not axes then
		return false
	end
	return axes[child.Name] ~= nil
end

local function findAxeTool(player, character, preferredName)
	local backpack = player:FindFirstChildOfClass("Backpack")
	local places = { character, backpack }

	if preferredName then
		for _, place in ipairs(places) do
			if place then
				local t = place:FindFirstChild(preferredName)
				if t and isAxeTool(t) then
					return t
				end
			end
		end
	end

	for _, place in ipairs(places) do
		if place then
			for _, child in ipairs(place:GetChildren()) do
				if isAxeTool(child) then
					return child
				end
			end
		end
	end

	return nil
end

local function isPointInLevel(point, levelPart)
	local localPos = levelPart.CFrame:PointToObjectSpace(point)
	local half = levelPart.Size / 2
	if math.abs(localPos.X) > half.X then
		return false
	end
	if math.abs(localPos.Z) > half.Z then
		return false
	end
	if localPos.Y < -half.Y - Y_SLACK_BELOW or localPos.Y > half.Y + Y_SLACK_ABOVE then
		return false
	end
	return true
end

local function findLevelForPosition(map, point)
	for i = 1, 4 do
		-- Recursive lookup: TreeLevel parts are nested inside Persistent Model
		-- wrappers (TreeLevel<n>_Persistent) so they don't stream out on camera
		-- movement. See PodiumService.Init for the wrap step.
		local lvl = map:FindFirstChild("TreeLevel" .. i, true)
		if lvl and isPointInLevel(point, lvl) then
			return i
		end
	end
	return nil
end

local function playChopHitSound()
	if CHOP_HIT_SOUND_ID == "" then
		return
	end
	-- Clone of the preloaded template (asset already cached -> no delay on the
	-- first hit); on SoundService so the felled tree can't cut it off.
	local sound = chopSoundTemplate:Clone()
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Once(function()
		sound:Destroy()
	end)
	task.delay(5, function()
		if sound and sound.Parent then
			sound:Destroy()
		end
	end)
end

local function flashTree(tree)
	if tree:FindFirstChild("_ChopFlash") then
		return
	end
	local highlight = Instance.new("Highlight")
	highlight.Name = "_ChopFlash"
	highlight.FillColor = Color3.new(1, 1, 1)
	highlight.FillTransparency = 0.4
	highlight.OutlineTransparency = 1
	highlight.Parent = tree

	local tween = TweenService:Create(highlight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FillTransparency = 1 })
	tween:Play()
	tween.Completed:Once(function()
		highlight:Destroy()
	end)
end

local function popTreeBounce(tree)
	if tree:GetAttribute("_Popping") then
		return
	end
	tree:SetAttribute("_Popping", true)
	local startCF = tree:GetPivot()

	local tiltAxis = Vector3.new(math.random() - 0.5, 0, math.random() - 0.5)
	if tiltAxis.Magnitude < 0.05 then
		tiltAxis = Vector3.new(1, 0, 0)
	end
	tiltAxis = tiltAxis.Unit
	-- Smooth, gentle hit sway (low-frequency, no jitter).
	local tiltAngle = math.rad(math.random(7, 11)) * (math.random() < 0.5 and -1 or 1)
	local hopHeight = math.random(16, 24) / 100

	local proxy = Instance.new("NumberValue")
	proxy.Value = 0

	local conn
	conn = proxy:GetPropertyChangedSignal("Value"):Connect(function()
		if not tree.Parent then
			return
		end
		local t = proxy.Value
		local hop = hopHeight * math.sin(t * math.pi)
		-- Single low-frequency damped sway -> smooth, not jittery.
		local wobble = math.sin(t * math.pi * 2) * (1 - t)
		local tilt = CFrame.fromAxisAngle(tiltAxis, tiltAngle * wobble)
		tree:PivotTo(startCF * CFrame.new(0, hop, 0) * tilt)
	end)

	local tween = TweenService:Create(proxy, TweenInfo.new(0.34, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Value = 1 })
	tween:Play()
	tween.Completed:Once(function()
		conn:Disconnect()
		proxy:Destroy()
		if tree.Parent then
			tree:PivotTo(startCF)
		end
		tree:SetAttribute("_Popping", false)
	end)
end

local function applyShrink(tree)
	local hp = tree:GetAttribute("Health") or 0
	local maxHp = tree:GetAttribute("MaxHealth") or 1
	if maxHp <= 0 then
		return
	end
	local ratio = math.clamp(hp / maxHp, 0, 1)
	local minScale = (GameConfig.Bridge and GameConfig.Bridge.MinTreeScale) or 0.45
	local scale = minScale + (1 - minScale) * ratio
	tree:ScaleTo(scale)
end

local function chopDownTree(tree, levelIndex, row, col, respawnDelay)
	if tree:GetAttribute("_Chopped") then
		return
	end
	tree:SetAttribute("_Chopped", true)
	-- The crown has already broken away top->bottom across the chops; let the
	-- last band's break tween finish, then clear stragglers and queue respawn.
	task.delay(0.4, function()
		if tree and tree.Parent then
			tree:Destroy()
		end
		local TreeController = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Controllers"):WaitForChild("TreeController"))
		TreeController.RespawnSlot(levelIndex, row, col, respawnDelay)
	end)
end

local cachedMaxStorageFromUpgrade = nil

task.spawn(function()
	local Remotes = ReplicatedStorage:WaitForChild("Remotes", 30)
	local svc = Remotes and Remotes:WaitForChild("UpgradeShopService", 30)
	if not svc then return end
	local updateEvent = svc:WaitForChild("UpgradeUpdate", 30)
	local requestFunc = svc:WaitForChild("RequestUpgradeData", 30)
	if updateEvent then
		updateEvent.OnClientEvent:Connect(function(payload)
			if type(payload) == "table" and payload.Storage and typeof(payload.Storage.Value) == "number" then
				cachedMaxStorageFromUpgrade = payload.Storage.Value
			end
		end)
	end
	if requestFunc then
		for attempt = 1, 30 do
			local ok, payload = pcall(function()
				return requestFunc:InvokeServer()
			end)
			if ok and type(payload) == "table" and payload.Storage and typeof(payload.Storage.Value) == "number" then
				cachedMaxStorageFromUpgrade = payload.Storage.Value
				break
			end
			task.wait(0.5)
		end
	end
end)

local function getMaxStorage()
	if typeof(cachedMaxStorageFromUpgrade) == "number" and cachedMaxStorageFromUpgrade > 0 then
		return cachedMaxStorageFromUpgrade
	end
	local player = Players.LocalPlayer
	local v = player and player:GetAttribute(MAX_STORAGE_ATTRIBUTE)
	if typeof(v) == "number" and v > 0 then
		return v
	end
	local upg = GameConfig.Upgrades and GameConfig.Upgrades.Storage
	if upg then
		return upg.Base or 10
	end
	return (GameConfig.Bridge and GameConfig.Bridge.MaxStorage) or 10
end

local MaterialAddRemote = nil
local function getAddMaterialRemote()
	if MaterialAddRemote then
		return MaterialAddRemote
	end
	local remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local svc = remotes and remotes:FindFirstChild("MaterialService")
	MaterialAddRemote = svc and svc:FindFirstChild("AddMaterial")
	return MaterialAddRemote
end

local function awardMaterial(player, amount)
	local maxStorage = getMaxStorage()
	local current = player:GetAttribute(MATERIAL_ATTRIBUTE) or 0
	local newVal = math.min(current + amount, maxStorage)
	local delta = newVal - current
	player:SetAttribute(MATERIAL_ATTRIBUTE, newVal)
	if delta > 0 then
		local remote = getAddMaterialRemote()
		if remote then
			remote:FireServer(delta)
		end
	end
end

local function notifyStorageFull()
	local ok, RedNotification = pcall(require, ReplicatedStorage.Source.Controllers.RedNotificationController)
	if ok and RedNotification and RedNotification.Send then
		RedNotification.Send("Upgrade storage!")
	end
end

local function getStorageScreenCenter(player)
	local pg = player:FindFirstChildOfClass("PlayerGui")
	local gui = pg and pg:FindFirstChild("GUI")
	local hud = gui and gui:FindFirstChild("HUD")
	local leftDown = hud and hud:FindFirstChild("LeftDownSide")
	local storage = leftDown and leftDown:FindFirstChild("Storage")
	if not storage then
		return nil
	end
	return storage.AbsolutePosition + storage.AbsoluteSize / 2
end

local function ensureFlyGui(player)
	local pg = player:FindFirstChildOfClass("PlayerGui")
	if not pg then
		return nil
	end
	local gui = pg:FindFirstChild("_TreeMaterialFly")
	if gui then
		return gui
	end
	gui = Instance.new("ScreenGui")
	gui.Name = "_TreeMaterialFly"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 100
	gui.Parent = pg
	return gui
end

local function spawnFlyingPickup(player, startScreen)
	local flyGui = ensureFlyGui(player)
	if not flyGui then
		awardMaterial(player, 1)
		return
	end

	local size = 44
	local image = Instance.new("ImageLabel")
	image.Image = PICKUP_IMAGE_ID
	image.BackgroundTransparency = 1
	image.AnchorPoint = Vector2.new(0.5, 0.5)
	image.Size = UDim2.new(0, size, 0, size)
	image.Position = UDim2.new(0, startScreen.X, 0, startScreen.Y)
	image.Parent = flyGui

	local scatter = Vector2.new(math.random(-50, 50), math.random(-60, -10))
	local scatterPos = startScreen + scatter

	local scatterTween = TweenService:Create(image, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, scatterPos.X, 0, scatterPos.Y),
		Size = UDim2.new(0, size * 1.15, 0, size * 1.15),
	})
	scatterTween:Play()
	scatterTween.Completed:Once(function()
		local target = getStorageScreenCenter(player)
		if not target then
			awardMaterial(player, 1)
			image:Destroy()
			return
		end
		local flyTween = TweenService:Create(image, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(0, target.X, 0, target.Y),
			Size = UDim2.new(0, size * 0.55, 0, size * 0.55),
			ImageTransparency = 0.2,
		})
		flyTween:Play()
		flyTween.Completed:Once(function()
			awardMaterial(player, 1)
			local sound = Instance.new("Sound")
			sound.SoundId = PICKUP_SOUND_ID
			sound.Parent = SoundService
			sound:Play()
			sound.Ended:Once(function()
				sound:Destroy()
			end)
			task.delay(5, function()
				if sound and sound.Parent then
					sound:Destroy()
				end
			end)
			image:Destroy()
		end)
	end)
end

local function flyMaterialPickups(player, treeWorldPos, count)
	local maxStorage = getMaxStorage()
	local current = player:GetAttribute(MATERIAL_ATTRIBUTE) or 0
	local available = math.max(0, maxStorage - current)

	if available <= 0 then
		notifyStorageFull()
		return
	end

	local toSpawn = math.min(count, available)

	local cam = Workspace.CurrentCamera
	if not cam then
		awardMaterial(player, toSpawn)
		if toSpawn < count then
			notifyStorageFull()
		end
		return
	end

	local screenPos = cam:WorldToScreenPoint(treeWorldPos)
	local start = Vector2.new(screenPos.X, screenPos.Y)

	for i = 1, toSpawn do
		task.delay((i - 1) * 0.06, function()
			spawnFlyingPickup(player, start)
		end)
	end

	if toSpawn < count then
		task.delay(toSpawn * 0.06, notifyStorageFull)
	end
end

local function preloadAssets()
	local assets = {}

	local anim = Instance.new("Animation")
	anim.AnimationId = SWING_ANIMATION_ID
	table.insert(assets, anim)

	for _, soundId in ipairs({ SWING_SOUND_ID, CHOP_HIT_SOUND_ID, PICKUP_SOUND_ID }) do
		local s = Instance.new("Sound")
		s.SoundId = soundId
		table.insert(assets, s)
	end

	local img = Instance.new("ImageLabel")
	img.Image = PICKUP_IMAGE_ID
	table.insert(assets, img)

	task.spawn(function()
		if game:GetService("RunService"):IsStudio() then return end
		local ok, err = pcall(function()
			ContentProvider:PreloadAsync(assets)
		end)
		if not ok then
			warn(string.format("[TreeAreaController] Preload failed: %s", tostring(err)))
		end
		for _, a in ipairs(assets) do
			a:Destroy()
		end
	end)
end

local function getChopsToFell(level)
	local list = GameConfig.Bridge and GameConfig.Bridge.ChopsToFell
	local v = list and list[level]
	if type(v) == "number" and v >= 1 then
		return math.floor(v)
	end
	return 5
end

-- A few tiny "stud" cubes that smoothly fly out and fade on each hit.
-- Little stud blocks that pop out of the chop point and shrink/fade away.
-- Parts only (no particles) -- emanates from the topmost still-visible part
-- so it reads as the wood being knocked off.
local function spawnChopDebris(tree)
	local top, topY, sample
	for _, d in ipairs(tree:GetDescendants()) do
		if d:IsA("BasePart") then
			sample = sample or d
			if not d:GetAttribute("_Hidden") and (not topY or d.Position.Y > topY) then
				topY = d.Position.Y
				top = d
			end
		end
	end
	local src = top or sample
	if not src then
		return
	end
	-- Spawn ABOVE the chopped block, in open air -- the old code spawned them
	-- inside the opaque foliage and shrank them instantly, so nothing showed.
	local crown = src.Position + Vector3.new(0, src.Size.Y / 2 + 0.5, 0)
	local color = src.Color
	local mat = src.Material
	for _ = 1, math.random(10, 14) do
		local p = Instance.new("Part")
		p.Name = "ChopDebris"
		p.Size = Vector3.new(1, 1, 1) * (0.8 + math.random() * 0.9)
		p.Color = color
		p.Material = mat
		p.Anchored = false
		p.CanCollide = true
		p.CanQuery = false
		p.CanTouch = false
		p.CastShadow = false
		p.CFrame = CFrame.new(crown + Vector3.new((math.random() - 0.5) * 2, (math.random() - 0.5) * 1, (math.random() - 0.5) * 2))
			* CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
		p.Parent = Workspace
		-- Pop out + up with real velocity; gravity arcs it down so it falls,
		-- lands and tumbles on the ground, then fades out and is cleaned up.
		local dir = Vector3.new((math.random() - 0.5) * 2, math.random() * 0.5 + 0.8, (math.random() - 0.5) * 2).Unit
		p.AssemblyLinearVelocity = dir * (22 + math.random() * 14)
		p.AssemblyAngularVelocity = Vector3.new(
			(math.random() - 0.5) * 30,
			(math.random() - 0.5) * 30,
			(math.random() - 0.5) * 30
		)
		task.delay(1.8, function()
			if p and p.Parent then
				local tw = TweenService:Create(p, TweenInfo.new(0.35, Enum.EasingStyle.Quad), { Transparency = 1 })
				tw:Play()
				tw.Completed:Once(function()
					if p and p.Parent then
						p:Destroy()
					end
				end)
			end
		end)
		task.delay(2.3, function()
			if p and p.Parent then
				p:Destroy()
			end
		end)
	end
end

-- "Breaks off" the tree crown downward. Stages 1..5 = top fifth .. bottom
-- fifth; each newly-reached stage flings + fades that vertical band of parts.
-- Cleanly hides the tree's parts strictly TOP -> BOTTOM. Parts are sorted by
-- height and faded out (no flinging, no destroy) so the number gone always
-- tracks chop progress exactly -- never leaves random parts behind.
local function applyTreeReveal(tree, chops, chopsToFell)
	local parts = {}
	for _, d in ipairs(tree:GetDescendants()) do
		if d:IsA("BasePart") then
			parts[#parts + 1] = d
		end
	end
	local total = tree:GetAttribute("_TotalParts")
	if not total then
		total = #parts
		tree:SetAttribute("_TotalParts", total)
	end
	if total <= 0 then
		return
	end

	local targetHidden
	if chops >= chopsToFell then
		targetHidden = total
	else
		targetHidden = math.floor(total * chops / chopsToFell + 0.5)
	end

	local hidden = 0
	local visible = {}
	for _, p in ipairs(parts) do
		if p:GetAttribute("_Hidden") then
			hidden = hidden + 1
		else
			visible[#visible + 1] = p
		end
	end
	table.sort(visible, function(a, b)
		return a.Position.Y > b.Position.Y
	end)

	local i = 1
	while hidden < targetHidden and i <= #visible do
		local p = visible[i]
		i = i + 1
		hidden = hidden + 1
		p:SetAttribute("_Hidden", true)
		p.CanCollide = false
		p.CanQuery = false
		p.CastShadow = false
		TweenService:Create(p, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Transparency = 1,
		}):Play()
	end
end

local function chopNearestTree(player, character, tool)
	local level = currentLevel
	if not level then
		return
	end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	local map = Workspace:FindFirstChild("Assets")
	map = map and map:FindFirstChild("Map")
	local levelPart = map and map:FindFirstChild("TreeLevel" .. level, true)
	local container = levelPart and levelPart:FindFirstChild("Trees")
	if not container then
		return
	end

	local chopRange = (GameConfig.Bridge and GameConfig.Bridge.ChopRange) or 8
	local facingDot = (GameConfig.Bridge and GameConfig.Bridge.ChopFacingDot) or 0.3
	local forward = hrp.CFrame.LookVector
	local nearest
	local nearestDist = chopRange
	for _, tree in ipairs(container:GetChildren()) do
		if tree:IsA("Model") and not tree:GetAttribute("_Chopped") then
			local toTree = tree:GetPivot().Position - hrp.Position
			local dist = toTree.Magnitude
			if dist < nearestDist and dist > 0.01 then
				local horizontalDir = Vector3.new(toTree.X, 0, toTree.Z)
				if horizontalDir.Magnitude > 0.01 then
					local horizontalForward = Vector3.new(forward.X, 0, forward.Z)
					if horizontalForward.Magnitude > 0.01 then
						local dot = horizontalForward.Unit:Dot(horizontalDir.Unit)
						if dot >= facingDot then
							nearestDist = dist
							nearest = tree
						end
					end
				end
			end
		end
	end

	if not nearest then
		return
	end

	-- Per-swing chops = player BaseDamage * axe DamageMultiplier / BASE_REF.
	-- BASE_REF = 5 matches the starting BaseDamage so a brand-new player with
	-- NormalAxe lands exactly 1 chop per swing (preserves the old baseline).
	-- Upgrading Damage stat AND switching axes both compound: a maxed Damage
	-- (155) player with the RainbowAxe (800x) chops at 155*800/5 = 24,800 per
	-- swing -- enough to one-shot the toughest Void tree (2000 chops).
	local chopsToFell = getChopsToFell(level)
	local axeName = tool and tool.Name
	local axeCfg = axeName and GameConfig.Axes and GameConfig.Axes[axeName]
	local axeMult = (axeCfg and axeCfg.DamageMultiplier) or 1.0
	local baseDamage = (player and player:GetAttribute(BASE_DAMAGE_ATTRIBUTE)) or 5
	local BASE_DAMAGE_REF = 5
	local perSwing = math.max(1, baseDamage * axeMult / BASE_DAMAGE_REF)
	local chops = (nearest:GetAttribute("_Chops") or 0) + perSwing
	nearest:SetAttribute("_Chops", chops)

	-- Roll the tree's total wood reward ONCE on the first chop and stash it.
	-- The reward is drip-fed swing-by-swing below; rolling it once keeps the
	-- total deterministic per tree even though it pays out incrementally.
	local treeCfg = GameConfig.Trees and GameConfig.Trees[level] or {}
	local totalReward = nearest:GetAttribute("_TotalReward")
	if not totalReward then
		local minR = treeCfg.MaterialRewardMin or treeCfg.MaterialReward or 1
		local maxR = treeCfg.MaterialRewardMax or minR
		totalReward = math.random(minR, maxR)
		local matMult = player:GetAttribute("MaterialMultiplier")
		if typeof(matMult) == "number" and matMult > 0 then
			totalReward = math.max(1, math.floor(totalReward * matMult + 0.5))
		end
		nearest:SetAttribute("_TotalReward", totalReward)
	end

	flashTree(nearest)
	popTreeBounce(nearest)
	playChopHitSound(nearest)
	spawnChopDebris(nearest)

	-- Clean top->bottom disappearance, exactly tracking chop progress.
	applyTreeReveal(nearest, chops, chopsToFell)

	-- Wood is granted only on the final felling swing, not drip-fed per hit.
	-- User-requested pacing: chopping should feel like an investment that
	-- pays out at the end, not like steady-income gathering.
	if chops >= chopsToFell then
		local alreadyPaid = nearest:GetAttribute("_RewardPaidOut") or 0
		local remaining = totalReward - alreadyPaid
		if remaining > 0 then
			nearest:SetAttribute("_RewardPaidOut", totalReward)
			local treePos = nearest:GetPivot().Position
			flyMaterialPickups(player, treePos, remaining)
		end

		local row = nearest:GetAttribute("Row") or 0
		local col = nearest:GetAttribute("Col") or 0
		local respawnDelay = treeCfg.RespawnDelay or 10
		chopDownTree(nearest, level, row, col, respawnDelay)
	end
end

local function ensureSwingAnimation(tool)
	local anim = tool:FindFirstChild("SwingAnim")
	if anim then
		return anim
	end
	anim = Instance.new("Animation")
	anim.Name = "SwingAnim"
	anim.AnimationId = SWING_ANIMATION_ID
	anim.Parent = tool
	return anim
end

local function ensureSwingSound(tool)
	local handle = tool:FindFirstChild("Handle")
	if not handle then
		return nil
	end
	local sound = handle:FindFirstChild("SwingSound")
	if sound then
		return sound
	end
	sound = Instance.new("Sound")
	sound.Name = "SwingSound"
	sound.SoundId = SWING_SOUND_ID
	sound.Parent = handle
	return sound
end

local function hookToolActivation(tool)
	if tool:GetAttribute("_TreeAreaSwingHook") then
		return
	end
	tool:SetAttribute("_TreeAreaSwingHook", true)

	local anim = ensureSwingAnimation(tool)
	local sound = ensureSwingSound(tool)

	tool.Activated:Connect(function()
		local character = tool.Parent
		if not character or not character:IsA("Model") then
			return
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			return
		end

		local cfg = GameConfig.Axes and GameConfig.Axes[tool.Name]
		local cooldown = (cfg and cfg.SwingTime) or 1.0
		local now = os.clock()
		local last = tool:GetAttribute("_LastSwing") or 0
		if now - last < cooldown then
			return
		end
		tool:SetAttribute("_LastSwing", now)

		local track = animator:LoadAnimation(anim)
		track:Play(0.05, 1, SWING_SPEED)

		if SWING_SOUND_ID ~= "" then
			local sw = swingSoundTemplate:Clone()
			sw.PlaybackSpeed = SWING_SPEED
			sw.Parent = SoundService
			sw:Play()
			sw.Ended:Once(function()
				sw:Destroy()
			end)
			task.delay(4, function()
				if sw and sw.Parent then
					sw:Destroy()
				end
			end)
		end

		task.delay(CHOP_IMPACT_DELAY, function()
			if character.Parent then
				chopNearestTree(Players.LocalPlayer, character, tool)
			end
		end)
	end)
end

local function equipAxe(player, character, preferredName)
	for _, child in ipairs(character:GetChildren()) do
		if isAxeTool(child) then
			hookToolActivation(child)
			return
		end
	end

	local tool = findAxeTool(player, character, preferredName)
	if not tool then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	humanoid:EquipTool(tool)
	hookToolActivation(tool)
end

local function unequipAxes(player, character)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack then
		return
	end
	for _, child in ipairs(character:GetChildren()) do
		if isAxeTool(child) then
			child.Parent = backpack
		end
	end
end

local function swapEquippedAxe(player, character, targetAxeName)
	if not targetAxeName then
		return
	end
	local currentAxe
	for _, child in ipairs(character:GetChildren()) do
		if isAxeTool(child) then
			currentAxe = child
			break
		end
	end
	if currentAxe and currentAxe.Name == targetAxeName then
		return
	end
	if currentAxe then
		local backpack = player:FindFirstChildOfClass("Backpack")
		if backpack then
			currentAxe.Parent = backpack
		end
	end
	equipAxe(player, character, targetAxeName)
end

local currentEquippedUid = ""

local function unequipBrainrot()
	if currentEquippedUid == "" or currentEquippedUid == nil then
		return
	end
	local uid = currentEquippedUid
	task.spawn(function()
		pcall(function()
			ToggleEquipFunc:InvokeServer(uid)
		end)
	end)
end

function TreeAreaController.Init()
	local player = Players.LocalPlayer
	local map = Workspace:WaitForChild("Assets"):WaitForChild("Map")

	preloadAssets()

	pcall(function()
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	end)

	EquippedItemUpdateEvent.OnClientEvent:Connect(function(summary)
		currentEquippedUid = (summary and summary.ItemId) or ""
	end)

	-- Shared axe equip/unequip toggle, used by the AxeSlot click and the
	-- "1" key. The axe is never auto-equipped; the player toggles it.
	local function toggleAxeEquip()
		local character = currentCharacter or player.Character
		if not character then
			return
		end
		local equipped
		for _, c in ipairs(character:GetChildren()) do
			if isAxeTool(c) then
				equipped = c
				break
			end
		end
		if equipped then
			unequipAxes(player, character)
		else
			-- Single-hold rule: equipping the axe clears any held brainrot /
			-- lucky block in inventory so the player only carries one thing.
			unequipBrainrot()
			equipAxe(player, character, getAxeForLevel(player, 1))
		end
	end

	-- Axes were removed from the game: no "1"-key axe toggle and no permanent
	-- AxeSlot in the hotbar anymore. toggleAxeEquip is kept (unused) so the
	-- rest of the controller stays intact.
	local _ = toggleAxeEquip

	local function onCharacter(character)
		currentCharacter = character
		currentLevel = nil

		-- Hook the swing handler onto any axe tool that lands in the
		-- character, regardless of who put it there (manual toggle, auto-
		-- equip on join, etc.). Without this, an axe parented straight to
		-- the character bypasses TreeAreaController.equipAxe and the
		-- Activated event never gets connected — the player holds the axe
		-- but can't swing.
		for _, c in ipairs(character:GetChildren()) do
			if isAxeTool(c) then
				hookToolActivation(c)
			end
		end
		character.ChildAdded:Connect(function(c)
			if isAxeTool(c) then
				hookToolActivation(c)
			end
		end)
	end

	if player.Character then
		onCharacter(player.Character)
	end
	player.CharacterAdded:Connect(onCharacter)

	player:GetAttributeChangedSignal(SELECTED_AXE_ATTR):Connect(function()
		-- Only swap the held axe if one is already equipped (don't force-equip
		-- on shop selection -- the player equips via the axe slot).
		local character = currentCharacter
		if not character then
			return
		end
		local hasAxe = false
		for _, c in ipairs(character:GetChildren()) do
			if isAxeTool(c) then
				hasAxe = true
				break
			end
		end
		if hasAxe then
			swapEquippedAxe(player, character, getAxeForLevel(player, 1))
		end
	end)

	RunService.Heartbeat:Connect(function()
		local character = currentCharacter
		if not character or not character.Parent then
			return
		end

		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			return
		end

		local level = findLevelForPosition(map, hrp.Position)
		if level == currentLevel then
			return
		end

		currentLevel = level

		local playerGui = player:FindFirstChildOfClass("PlayerGui")
		local gui = playerGui and playerGui:FindFirstChild("GUI")
		local folder = gui and gui:FindFirstChild("Folder")
		local inventoryBottom = folder and folder:FindFirstChild("InventoryBottom")
		local inventoryFrame = folder and folder:FindFirstChild("InventoryFrame")

		if level then
			-- Inventory hotbar stays put (no slide-away) when entering a tree zone.
			blockHotkeys()
			unequipBrainrot()
		else
			unblockHotkeys()
		end
	end)
end

return TreeAreaController
