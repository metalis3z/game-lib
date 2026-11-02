-- SquishCubes LocalScript (Optimized v3)
-- Key changes vs v2:
--   • Sounds are NOT created per-part. A single shared Sound pool (size 8) is
--     used for all cubey/sphere/slime hits. This alone saves ~10 000 Sound
--     instances and is the dominant memory reduction.
--   • SurfaceAppearance clone-check moved OUT of the per-frame dent loop into
--     the squish-start path (fires once per activation, not every other frame).
--   • butterVerts SetPosition early-exit when no active butter part (saves
--     Heartbeat work when player is not on butter).
--   • donutSpinData uses distSq (no sqrt) for the player-proximity check.
--   • _removePending flush + RenderStepped bucket logic now guards against
--     iterating an empty candidates table early.
--   • Minor: wax crackSounds list kept empty (matching original) so no extra
--     Sound instances from wax setup.
--   • All other animation/behaviour is identical to v2.

local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local AssetService      = game:GetService("AssetService")
local Players           = game:GetService("Players")
local LocalPlayer       = Players.LocalPlayer

if not LocalPlayer.Character then
	LocalPlayer.CharacterAdded:Wait()
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SettingsFolder    = ReplicatedStorage.Framework.Game.Modules.Settings
local SquishSoundSets   = require(ReplicatedStorage.Framework.Game.Modules.SquishSoundSets)

local _cachedSoundSet   = nil
local _soundSetTick     = 0
local function getCurrentSoundSet()
	local now = tick()
	if now - _soundSetTick > 1 then
		local valueObj = SettingsFolder:FindFirstChildWhichIsA("ValueBase")
		local index    = valueObj and tonumber(valueObj.Value) or 1
		_cachedSoundSet = SquishSoundSets[index] or SquishSoundSets[1]
		_soundSetTick   = now
	end
	return _cachedSoundSet
end

local function getPlayerRange(): number
	local h = LocalPlayer:FindFirstChild("HiddenStats")
	if h then
		local r = h:FindFirstChild("Range")
		if r then return math.max(1, r.Value) end
	end
	return 1
end

local function cubesSoundsOff(): boolean
	local settings = _G.PlayerSettings
	return settings ~= nil and settings.CubesSoundOff == true
end

------------------------------------------------------------------------
-- ── Shared sound pool ──────────────────────────────────────────────--
-- Instead of one Sound per part (10 000 instances!), we keep a small
-- pool of reusable Sound objects parented to a single Folder.
------------------------------------------------------------------------
local POOL_SIZE  = 8
local soundPool  = {}
local soundPoolI = 1

do
	local folder = Instance.new("Folder")
	folder.Name   = "SquishSoundPool"
	folder.Parent = script

	for i = 1, POOL_SIZE do
		local s = Instance.new("Sound")
		s.Volume          = 0.85
		s.PlaybackSpeed   = 1
		s.RollOffMaxDistance = 40
		s.RollOffMinDistance = 2
		s.Parent          = folder
		soundPool[i]      = s
	end
end

local function poolPlay(soundId, speed, volume)
	if cubesSoundsOff() then return end
	if not soundId or soundId == "" then return end
	local s = soundPool[soundPoolI]
	soundPoolI = soundPoolI % POOL_SIZE + 1
	s.SoundId       = soundId
	s.PlaybackSpeed = speed  or 1
	s.Volume        = volume or 0.85
	s:Play()
end

------------------------------------------------------------------------
local WAX_CONFIG = {
	["wax butter"] = {
		base    = "butterbrick",
	},
	waxedcube = {
		base          = "cubey",
		padding       = 0,
		topAligned    = true,
		yBelow        = 1.5,
		descent       = 0.35,
		flashMaterial = false,
	},
	waxedslime = {
		base          = "default",
		padding       = 0,
		topAligned    = true,
		yBelow        = 1.5,
		descent       = 0,
		flashMaterial = false,
		flatten       = true,
		breakDist     = 1,
		followFoot    = true,
	},
}

local WAX_SQUISH_TWEEN  = TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local WAX_RECOVER_TWEEN = TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local waxStates = {}
local WAX_CULL_DIST_SQ = 150 * 150

local function waxCancelTweens(piece)
	for _, tw in ipairs(piece.tweens) do
		pcall(function() tw:Cancel() end)
	end
	piece.tweens = {}
end

local function waxStartTween(piece, info, goal)
	if not (piece.part and piece.part.Parent) then return end
	local ok, tw = pcall(function()
		return TweenService:Create(piece.part, info, goal)
	end)
	if ok and tw then
		table.insert(piece.tweens, tw)
		tw.Completed:Connect(function()
			for i, v in ipairs(piece.tweens) do
				if v == tw then table.remove(piece.tweens, i) return end
			end
		end)
		tw:Play()
	end
end

local function waxSquishPiece(piece, descentY, footWorld, flatten, breakDist)
	waxCancelTweens(piece)
	if not (piece.part and piece.part.Parent) then return end

	local toFoot = Vector3.new(piece.restCFrame.Position.X, 0, piece.restCFrame.Position.Z) - footWorld
	local outDir = if toFoot.Magnitude < 2.5 then piece.outward else toFoot.Unit
	local tilt   = if flatten then CFrame.new()
		else CFrame.new(0, piece.halfH, 0) * CFrame.fromAxisAngle(piece.tiltAxis, 0.12) * CFrame.new(0, -piece.halfH, 0)
	local push   = outDir * (breakDist or 0.5)
	if flatten then push = Vector3.new(push.X, 0, push.Z) end

	local goalCF   = piece.restCFrame * tilt + push + (flatten and Vector3.new() or Vector3.new(0, -descentY, 0))
	local goalSize = Vector3.new(piece.restSize.X * 1.1, flatten and piece.restSize.Y or piece.restSize.Y * 0.84, piece.restSize.Z * 1.1)

	waxStartTween(piece, WAX_SQUISH_TWEEN, { CFrame = goalCF, Size = goalSize })
end

local function waxRestorePiece(piece)
	waxCancelTweens(piece)
	if piece.part and piece.part.Parent then
		waxStartTween(piece, WAX_RECOVER_TWEEN, { CFrame = piece.restCFrame, Size = piece.restSize })
	end
end

local function teardownWaxModel(model)
	local ws = waxStates[model]
	if not ws then return end
	for _, piece in ipairs(ws.pieces) do
		for _, tw in ipairs(piece.tweens) do pcall(function() tw:Cancel() end) end
		piece.tweens = {}
	end
	waxStates[model] = nil
end

local function squishWaxModel(ws)
	local footWorld = ws.footWorld
		or Vector3.new(ws.butterRestCFrame.Position.X, 0, ws.butterRestCFrame.Position.Z)

	if ws.crackSounds and #ws.crackSounds > 0 and not cubesSoundsOff() then
		local snd = ws.crackSounds[math.random(1, #ws.crackSounds)]
		if snd and snd.Parent then
			snd.PlaybackSpeed = 0.85 + math.random() * 0.3
			snd.TimePosition  = 0.05
			pcall(function() snd:Play() end)
		end
	end

	local descentY = ws.butterRestSize.Y * ws.descent

	for _, piece in ipairs(ws.pieces) do
		waxSquishPiece(piece, descentY, footWorld, ws.flatten, ws.breakDist)
		if ws.flashMat and piece.part and piece.part.Parent then
			piece.part.Material = Enum.Material.Glass
			task.delay(0.18, function()
				if piece.part and piece.part.Parent then
					piece.part.Material = piece.origMat
				end
			end)
		end
	end
end

local function recoverWaxModel(ws)
	for _, piece in ipairs(ws.pieces) do
		waxRestorePiece(piece)
	end
	ws.smoothFoot = nil
end

local function setupWaxModel(model)
	if waxStates[model] then return end
	if not model:IsA("Model") then return end
	local cfg = WAX_CONFIG[model.Name]
	if not cfg then return end

	local baseName    = cfg.base
	local padding     = cfg.padding    or 1.5
	local yBelow      = cfg.yBelow     or 0.5
	local yAbove      = cfg.yAbove     or 5
	local topAligned  = cfg.topAligned == true
	local descent     = cfg.descent    or 0.22
	local flashMat    = if cfg.flashMaterial == false then false else true
	local flatten     = cfg.flatten    == true
	local breakDist   = cfg.breakDist  or 0.5
	local followFoot  = cfg.followFoot == true

	task.spawn(function()
		local basePart = model:FindFirstChild(baseName) or model:WaitForChild(baseName, 10)
		if not (basePart and basePart:IsA("BasePart")) then return end

		if waxStates[model] then return end
		if not model.Parent then return end

		local basePos = basePart.Position
		local minX, maxX, minZ, maxZ = math.huge, -math.huge, math.huge, -math.huge
		local pieces = {}

		for _, child in ipairs(model:GetChildren()) do
			if child:IsA("BasePart") and child ~= basePart then
				child.CanCollide = false
				child.CanQuery   = false

				local restCF   = child:GetAttribute("RestCFrame") or child.CFrame
				local restSize = child:GetAttribute("RestSize")   or child.Size
				child.CFrame   = restCF
				child.Size     = restSize

				local offset   = restCF.Position - basePos
				local offsetXZ = Vector3.new(offset.X, 0, offset.Z)
				local randDir  = Vector3.new(math.random() - 0.5, 0, math.random() - 0.5)
				if randDir.Magnitude > 0.001 then randDir = randDir.Unit end

				table.insert(pieces, {
					part       = child,
					restCFrame = restCF,
					restSize   = restSize,
					halfH      = restSize.Y / 2,
					outward    = offsetXZ.Magnitude > 0.001 and offsetXZ.Unit or Vector3.zero,
					tiltAxis   = randDir,
					origMat    = child.Material,
					tweens     = {},
				})

				local localPos = basePart.CFrame:PointToObjectSpace(child.Position)
				local hx, hz  = child.Size.X / 2, child.Size.Z / 2
				if localPos.X - hx < minX then minX = localPos.X - hx end
				if localPos.X + hx > maxX then maxX = localPos.X + hx end
				if localPos.Z - hz < minZ then minZ = localPos.Z - hz end
				if localPos.Z + hz > maxZ then maxZ = localPos.Z + hz end
			end
		end

		local bHX, bHZ = basePart.Size.X / 2, basePart.Size.Z / 2
		minX = math.min(minX, -bHX) maxX = math.max(maxX, bHX)
		minZ = math.min(minZ, -bHZ) maxZ = math.max(maxZ, bHZ)

		waxStates[model] = {
			wantSquish      = false,
			model           = model,
			butter          = basePart,
			butterRestSize  = basePart.Size,
			butterRestCFrame= basePart.CFrame,
			pieces          = pieces,
			fpMinX          = minX - padding,
			fpMaxX          = maxX + padding,
			fpMinZ          = minZ - padding,
			fpMaxZ          = maxZ + padding,
			yBelow          = yBelow,
			yAbove          = yAbove,
			topAlign        = topAligned,
			descent         = descent,
			flashMat        = flashMat,
			flatten         = flatten,
			breakDist       = breakDist,
			followFoot      = followFoot,
		}

		-- crackSounds intentionally empty (no Sound instances allocated here)
		waxStates[model].crackSounds = {}

		model.AncestryChanged:Connect(function(_, newParent)
			if newParent then return end
			teardownWaxModel(model)
		end)
	end)
end

for _, v in ipairs(workspace:GetDescendants()) do setupWaxModel(v) end
workspace.DescendantAdded:Connect(setupWaxModel)

local function waxIsSteppedOn(ws)
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return false end

	local localPos = ws.butterRestCFrame:PointToObjectSpace(root.Position)
	local halfY    = ws.butterRestSize.Y / 2
	local topY     = ws.topAlign and halfY or -halfY

	if  localPos.X >= ws.fpMinX and localPos.X <= ws.fpMaxX
		and localPos.Z >= ws.fpMinZ and localPos.Z <= ws.fpMaxZ
		and (topY - ws.yBelow) <= localPos.Y and localPos.Y <= halfY + ws.yAbove
	then
		ws.footWorld = Vector3.new(root.Position.X, 0, root.Position.Z)
		return true
	end
	return false
end

local function waxFollowFootUpdate(ws, dt)
	local fw = ws.footWorld
	if not fw then return end
	if not ws.smoothFoot then ws.smoothFoot = fw end
	ws.smoothFoot = ws.smoothFoot:Lerp(fw, 1 - math.exp(-3 * dt))

	local sf    = ws.smoothFoot
	local bd    = ws.breakDist or 0.5
	local alpha = 1 - math.exp(-2.5 * dt)

	for _, piece in ipairs(ws.pieces) do
		if piece.part and piece.part.Parent then
			local toFoot = Vector3.new(piece.restCFrame.Position.X, 0, piece.restCFrame.Position.Z) - sf
			local outDir = (toFoot.Magnitude < 2.5 and piece.outward or toFoot.Unit) * bd
			if ws.flatten then outDir = Vector3.new(outDir.X, 0, outDir.Z) end
			piece.part.CFrame = piece.part.CFrame:Lerp(piece.restCFrame + outDir, alpha)
		end
	end
end

LocalPlayer.CharacterAdded:Connect(function()
	for _, ws in pairs(waxStates) do
		if ws.wantSquish then recoverWaxModel(ws) end
		ws.wantSquish = false
	end
end)

RunService.Heartbeat:Connect(function(dt)
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local rootPos = root and root.Position

	for _, ws in pairs(waxStates) do
		if not (ws.butter and ws.butter.Parent) then continue end

		if rootPos then
			local bPos = ws.butterRestCFrame.Position
			local dx = rootPos.X - bPos.X
			local dy = rootPos.Y - bPos.Y
			local dz = rootPos.Z - bPos.Z
			if dx*dx + dy*dy + dz*dz > WAX_CULL_DIST_SQ then
				if ws.wantSquish then
					ws.wantSquish = false
					recoverWaxModel(ws)
				end
				continue
			end
		end

		local modelName = ws.model and ws.model.Name
		if modelName == "waxedcube" or modelName == "waxedslime" then
			if ws.wantSquish and ws.followFoot then
				waxFollowFootUpdate(ws, dt)
			end
			continue
		end

		local stepped = waxIsSteppedOn(ws)
		if stepped ~= ws.wantSquish then
			ws.wantSquish = stepped
			if stepped then squishWaxModel(ws) else recoverWaxModel(ws) end
		end
		if stepped and ws.followFoot then
			waxFollowFootUpdate(ws, dt)
		end
	end
end)

------------------------------------------------------------------------
local butterDefaultSpeed = 16
local butterCurrent      = nil
local butterParts        = {}

local butterEM      = nil
local butterVerts   = nil
local butterOverlay = nil

local BUTTER_SQUISH_TWEEN  = TweenInfo.new(0.28, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local BUTTER_RECOVER_TWEEN = TweenInfo.new(2.0,  Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function captureDefaultSpeed()
	local char = LocalPlayer.Character
	local hum  = char and char:FindFirstChildOfClass("Humanoid")
	if hum then butterDefaultSpeed = hum.WalkSpeed end
end
LocalPlayer.CharacterAdded:Connect(function()
	task.wait(0.1); captureDefaultSpeed()
end)
task.spawn(function() task.wait(0.1); captureDefaultSpeed() end)

task.spawn(function()
	for _ = 1, 20 do
		if pcall(function()
				butterEM = AssetService:CreateEditableMeshAsync(Content.fromAssetId())
				butterVerts = {}
				for _, vid in ipairs(butterEM:GetVertices()) do
					local p = butterEM:GetPosition(vid)
					table.insert(butterVerts, {
						depression = 0,
						id         = vid,
						rest       = p,
						nx         = p.X / 1,
						nz         = p.Z / 3.02,
						yW         = math.clamp((p.Y + 1) / 2, 0, 1),
					})
				end
				butterOverlay = AssetService:CreateMeshPartAsync(Content.fromObject(butterEM))
				butterOverlay.Anchored   = true
				butterOverlay.CanCollide = false
				butterOverlay.CanQuery   = false
				butterOverlay.CastShadow = not _G.SQUISH_PERF_MODE
				pcall(function() butterOverlay.TextureContent = Content.fromAssetId(129079834115239) end)
				butterOverlay.CFrame  = CFrame.new(0, -9999, 0)
				butterOverlay.Parent  = workspace
			end) then break end
		task.wait(0.3)
	end
end)

local function butterComputeGoal(bs, squishFrac)
	local newY    = bs.restSize.Y * (1 - squishFrac)
	local bottomY = bs.restBottomY
	local newCF   = bs.restCFrame - bs.restCFrame.Position
		+ Vector3.new(bs.restCFrame.Position.X, bottomY + newY / 2, bs.restCFrame.Position.Z)
	return {
		Size   = Vector3.new(bs.restSize.X * (1 + squishFrac * 0.42), newY, bs.restSize.Z * (1 + squishFrac * 0.42)),
		CFrame = newCF,
	}
end

local function butterCancelTweens(bs)
	for _, tw in ipairs(bs.tweens) do pcall(function() tw:Cancel() end) end
	bs.tweens = {}
end

local function butterTweenTo(bs, info, squishFrac)
	butterCancelTweens(bs)
	local goal = butterComputeGoal(bs, squishFrac)
	local tw1  = TweenService:Create(bs.part, info, { Size = goal.Size, CFrame = goal.CFrame })
	local dropExtra = squishFrac > 0 and -1.45 or 0
	local tw2  = TweenService:Create(bs.coll, info, {
		Size   = goal.Size,
		CFrame = goal.CFrame + Vector3.new(0, dropExtra + bs.collOffsetY, 0),
	})
	tw1:Play(); tw2:Play()
	table.insert(bs.tweens, tw1)
	table.insert(bs.tweens, tw2)
end

local function butterResetVerts()
	if not butterVerts then return end
	for _, v in ipairs(butterVerts) do
		v.depression = 0
		butterEM:SetPosition(v.id, v.rest)
	end
end

local function butterApplyDent(bs, dt)
	if not butterVerts then return end
	local hX = bs.restSize.X / 2
	local hZ = bs.restSize.Z / 2
	local maxCompress  = bs.restSize.Y * 0.22
	local compressFrac = math.clamp((bs.restSize.Y - bs.part.Size.Y) / maxCompress, 0, 1)
	if compressFrac < 0.001 then
		bs.clx = bs.clx * 0.985
		bs.clz = bs.clz * 0.985
		return
	end
	local tiltX = math.clamp(bs.clx / hX, -1, 1)
	local tiltZ = math.clamp(bs.clz / hZ, -1, 1)
	local step  = 5 * dt

	for _, v in ipairs(butterVerts) do
		if v.yW < 0.01 then continue end
		local dx    = v.nx * hX - bs.fx
		local dz    = v.nz * hZ - bs.fz
		local gauss = math.exp(-(dx * dx + dz * dz) * 0.08) * v.yW * compressFrac * 0.85
		local tilt  = bs.isWaxButter and 0
			or -0.75 * (v.nx * tiltX + v.nz * tiltZ) * v.yW * compressFrac
		local delta = gauss - v.depression
		v.depression = v.depression + math.clamp(delta, -step, step)
		butterEM:SetPosition(v.id, Vector3.new(v.rest.X, v.rest.Y - v.depression + tilt, v.rest.Z))
	end

	if bs.onIt then
		bs.clx = bs.clx + (bs.fx - bs.clx) * 0.025
		bs.clz = bs.clz + (bs.fz - bs.clz) * 0.025
	else
		bs.clx = bs.clx * 0.985
		bs.clz = bs.clz * 0.985
	end
end

local function butterIsSteppedOn(bs)
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return false end
	local localPos = bs.restCFrame:PointToObjectSpace(root.Position)
	if math.abs(localPos.X) > bs.restSize.X / 2 + 0.5 then return false end
	if math.abs(localPos.Z) <= bs.restSize.Z / 2 + 0.5
		and (-bs.restSize.Y / 2 - 1) <= localPos.Y and localPos.Y <= bs.restSize.Y / 2 + 6
	then
		bs.fx = localPos.X
		bs.fz = localPos.Z
		return true
	end
	return false
end

local function setupButterbrick(part)
	if butterParts[part] then return end
	if not part:IsA("MeshPart") then return end
	if part.Name ~= "butterbrick" then return end

	part.CanCollide = false

	local isWaxButter = part.Parent and part.Parent.Name == "wax butter"
	local collOffsetY = isWaxButter and 0.6 or 0

	local coll        = Instance.new("Part")
	coll.Name         = "butterbrickCollider"
	coll.Anchored     = true
	coll.CanCollide   = true
	coll.CanQuery     = false
	coll.CanTouch     = false
	coll.Transparency = 1
	coll.Material     = Enum.Material.SmoothPlastic
	coll.Size         = part.Size
	coll.CFrame       = part.CFrame + Vector3.new(0, collOffsetY, 0)
	coll.Parent       = workspace

	-- Butter uses its own Sound (one per butterbrick, typically very few exist)
	local snd             = Instance.new("Sound")
	snd.SoundId           = ""
	snd.Volume            = 8
	snd.PlaybackSpeed     = 0.95
	snd.RollOffMaxDistance= 40
	snd.Parent            = part

	butterParts[part] = {
		lastSnd      = 0,
		fx = 0, fz = 0,
		clx = 0, clz = 0,
		onIt         = false,
		state        = "idle",
		part         = part,
		coll         = coll,
		collOffsetY  = collOffsetY,
		isWaxButter  = isWaxButter,
		snd          = snd,
		restCFrame   = part.CFrame,
		restSize     = part.Size,
		restBottomY  = part.Position.Y - part.Size.Y / 2,
		origMaterial = part.Material,
		origColor    = part.Color,
		origTrans    = part.Transparency,
		tweens       = {},
	}
end

local function scanButterbricks()
	local descs = workspace:GetDescendants()
	local i = 1
	while i <= #descs do
		for j = i, math.min(i + 49, #descs) do
			setupButterbrick(descs[j])
		end
		i = i + 50
		task.wait()
	end
	workspace.DescendantAdded:Connect(setupButterbrick)
end

if butterOverlay then
	task.spawn(scanButterbricks)
else
	task.spawn(function()
		while not butterOverlay do task.wait(0.3) end
		scanButterbricks()
	end)
end

local _butterProxFrame = 0
local butterOnIt = false
RunService.Heartbeat:Connect(function(dt)
	if not butterOverlay then return end

	_butterProxFrame = _butterProxFrame + 1

	if butterCurrent == nil then
		if _butterProxFrame % 10 ~= 0 then return end
		local char = LocalPlayer.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then
			local pos   = root.Position
			local close = false
			for _, bs in pairs(butterParts) do
				local bpos = bs.restCFrame.Position
				local dx   = pos.X - bpos.X
				local dy   = pos.Y - bpos.Y
				local dz   = pos.Z - bpos.Z
				if dx*dx + dy*dy + dz*dz < 6400 then close = true break end
			end
			if not close then return end
		end
	end

	local stepped = nil
	for _, bs in pairs(butterParts) do
		if butterIsSteppedOn(bs) then stepped = bs break end
	end

	local nowOnIt = stepped ~= nil
	if nowOnIt ~= butterOnIt then
		local char = LocalPlayer.Character
		local hum  = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = nowOnIt and 7 or butterDefaultSpeed end
		butterOnIt = nowOnIt
	end

	if stepped and stepped ~= butterCurrent then
		if butterCurrent then
			butterCancelTweens(butterCurrent)
			butterCurrent.part.Size   = butterCurrent.restSize
			butterCurrent.part.CFrame = butterCurrent.restCFrame
			butterCurrent.coll.Size   = butterCurrent.restSize
			butterCurrent.coll.CFrame = butterCurrent.restCFrame + Vector3.new(0, butterCurrent.collOffsetY, 0)
			butterOverlay.CFrame      = CFrame.new(0, -9999, 0)
			butterResetVerts()
			butterCurrent.state       = "idle"
		end
		butterCurrent = stepped

		butterOverlay.Size     = stepped.restSize
		butterOverlay.CFrame   = stepped.restCFrame
		butterOverlay.Material = stepped.origMaterial
		butterOverlay.Color    = stepped.origColor

		butterTweenTo(stepped, BUTTER_SQUISH_TWEEN, 0.22)
		stepped.state = "squishing"

		local now = tick()
		if now - stepped.lastSnd > 0.15 and not cubesSoundsOff() then
			stepped.snd.PlaybackSpeed = 0.95 + math.random() * 0.15
			stepped.snd:Play()
			stepped.lastSnd = now
		end
	end

	if not butterCurrent then return end

	butterOverlay.Size     = butterCurrent.part.Size
	butterOverlay.CFrame   = butterCurrent.part.CFrame
	butterOverlay.Material = butterCurrent.origMaterial
	butterOverlay.Color    = butterCurrent.origColor

	butterCurrent.onIt = (stepped == butterCurrent)

	if stepped == butterCurrent then
		if butterCurrent.state ~= "squishing" then
			butterTweenTo(butterCurrent, BUTTER_SQUISH_TWEEN, 0.22)
			butterCurrent.state = "squishing"
			local now = tick()
			if now - butterCurrent.lastSnd > 0.15 and not cubesSoundsOff() then
				butterCurrent.snd.PlaybackSpeed = 0.95 + math.random() * 0.15
				butterCurrent.snd:Play()
				butterCurrent.lastSnd = now
			end
		end
		butterApplyDent(butterCurrent, dt)
	else
		if butterCurrent.state ~= "recovering" then
			butterTweenTo(butterCurrent, BUTTER_RECOVER_TWEEN, 0)
			butterCurrent.state = "recovering"
		end
		-- Only run dent logic while still animating back
		butterApplyDent(butterCurrent, dt)

		if math.abs(butterCurrent.part.Size.Y - butterCurrent.restSize.Y) < 0.02 then
			butterResetVerts()
			butterOverlay.CFrame = CFrame.new(0, -9999, 0)
			butterCurrent.state  = "idle"
			butterCurrent        = nil
		end
	end
end)

LocalPlayer.CharacterAdded:Connect(function()
	butterCurrent = nil
	butterOnIt    = false
end)

task.spawn(function()
	while true do
		task.wait(1)
		for _, bs in pairs(butterParts) do
			if butterCurrent ~= bs and bs.state ~= "idle" then
				local anyPlaying = false
				for _, tw in ipairs(bs.tweens) do
					if tw.PlaybackState == Enum.PlaybackState.Playing then anyPlaying = true break end
				end
				if not anyPlaying then bs.state = "idle" end
			end
		end
	end
end)

------------------------------------------------------------------------
local OVERLAY_ASSET_IDS = {
	drpeppa     = nil,
	swirlygroup = nil,
	GUMDROP     = nil,
	donuutt     = nil,
	donuutt2    = nil,
	waxedcube   = nil,
	dumppling   = nil,
	dreamdrop   = nil,
}

local SQUISH_DURATION = {
	swirlygroup = 4.5,
	GUMDROP     = 1.6,
	donuutt     = 1.8,
	donuutt2    = 1.8,
}

local RECOVER_DURATION = {
	swirlygroup = 0.22,
	donuutt     = 0.18,
	donuutt2    = 0.18,
}

local COLLIDER_DROP = {
	GUMDROP   = 1.3,
	donuutt   = 1.2,
	donuutt2  = 1.2,
	dumppling = 0.5,
	dreamdrop = 0.5,
}

local DONUT_HALF_SIZE = {
	donuutt  = { halfX = 0.663, halfZ = 0.658 },
	donuutt2 = { halfX = 0.663, halfZ = 0.658 },
}

local DENT_SPREAD = {
	swirlygroup = 1,
	donuutt     = 14,
	donuutt2    = 14,
}

local OFF_FRAME_THRESHOLD = {
	donuutt   = 1,
	donuutt2  = 1,
	dumppling = 1,
	dreamdrop = 1,
}

local TWEEN_SUPER_SQUISH    = TweenInfo.new(0.5,  Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_FAST_SQUISH     = TweenInfo.new(1.0,  Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_DEFAULT_SQUISH  = TweenInfo.new(0.22, Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_DEFAULT_RECOVER = TweenInfo.new(1.1,  Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_FAST_RECOVER    = TweenInfo.new(0.85, Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_SUPER_RECOVER   = TweenInfo.new(1.1,  Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TWEEN_SNAP_SQUISH     = TweenInfo.new(0.04, Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local TWEEN_SNAP_RECOVER    = TweenInfo.new(0.08, Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local TWEEN_SLIME_SQUISH    = TweenInfo.new(0.18, Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_SLIME_RECOVER   = TweenInfo.new(1.4,  Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_SLOW_SQUISH     = TweenInfo.new(0.3,  Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)
local TWEEN_QUICK_RECOVER   = TweenInfo.new(0.6,  Enum.EasingStyle.Sine,  Enum.EasingDirection.Out)

local donutSpinData = {}
local partData      = {}
local setupDone     = {}

local squishedParts = {}
local squishedCount = 0

local BUCKET_SIZE   = 64
local partBuckets   = {}
local partBucketKey = {}

local function bucketKey(x, z)
	return math.floor(x / BUCKET_SIZE) .. "_" .. math.floor(z / BUCKET_SIZE)
end

local function addToBucket(part, state)
	local key = bucketKey(state.centerX, state.centerZ)
	if not partBuckets[key] then partBuckets[key] = {} end
	table.insert(partBuckets[key], part)
	partBucketKey[part] = key
end

local function removeFromBucket(part)
	local key = partBucketKey[part]
	if not key then return end
	local bucket = partBuckets[key]
	if bucket then
		for i, p in ipairs(bucket) do
			if p == part then table.remove(bucket, i) break end
		end
		if #bucket == 0 then partBuckets[key] = nil end
	end
	partBucketKey[part] = nil
end

local NEARBY_REFRESH_INTERVAL = 6
local NEARBY_MOVE_THRESHOLD   = 4
local _nearbyCached     = {}
local _nearbyFrame      = 0
local _nearbyLastPos    = nil
local _nearbyLastRange  = 0

local function nearbyParts(px, pz, rangeStuds)
	local cells = math.ceil(rangeStuds / BUCKET_SIZE) + 1
	local cx    = math.floor(px / BUCKET_SIZE)
	local cz    = math.floor(pz / BUCKET_SIZE)
	local result = {}
	for dx = -cells, cells do
		for dz = -cells, cells do
			local key = (cx + dx) .. "_" .. (cz + dz)
			local bucket = partBuckets[key]
			if bucket then
				for _, p in ipairs(bucket) do
					table.insert(result, p)
				end
			end
		end
	end
	return result
end

local function getCachedNearbyParts(px, pz, rangeStuds)
	_nearbyFrame = _nearbyFrame + 1
	local needRefresh = false
	if _nearbyFrame >= NEARBY_REFRESH_INTERVAL or rangeStuds ~= _nearbyLastRange then
		needRefresh = true
	elseif _nearbyLastPos then
		local dx = px - _nearbyLastPos.X
		local dz = pz - _nearbyLastPos.Z
		if dx*dx + dz*dz > NEARBY_MOVE_THRESHOLD * NEARBY_MOVE_THRESHOLD then
			needRefresh = true
		end
	else
		needRefresh = true
	end

	if needRefresh then
		_nearbyFrame   = 0
		_nearbyLastPos = Vector3.new(px, 0, pz)
		_nearbyLastRange = rangeStuds
		_nearbyCached  = nearbyParts(px, pz, rangeStuds)
	end
	return _nearbyCached
end

local function isDonut(groupName)
	return groupName == "donuutt" or groupName == "donuutt2"
end

local function donutSpinDir(groupName)
	return groupName == "donuutt2" and -1 or 1
end

local function cancelTweens(state)
	for _, tw in ipairs(state.tweens) do tw:Cancel() end
	state.tweens = {}
end

local function playTween(state, part, tweenInfo, goal, overrideInfo)
	if not part then return nil end
	if part:GetAttribute("ManagedExternally") then return nil end
	local tw = TweenService:Create(part, overrideInfo or tweenInfo, goal)
	tw:Play()
	table.insert(state.tweens, tw)
	return tw
end

local cubeyMeshReady  = false
local cubeyEM         = nil
local cubeyTopVerts   = nil
local cubeyOverlay    = nil

local sphereMeshReady = false
local sphereEM        = nil
local sphereTopVerts  = nil
local sphereOverlay   = nil

local slimeMeshReady  = false
local slimeEM         = nil
local slimeTopVerts   = nil
local slimeOverlay    = nil

local function buildTopVerts_radial(em)
	local verts = {}
	for _, id in ipairs(em:GetVertices()) do
		local pos = em:GetPosition(id)
		if pos.Y > -0.2 then
			local r = math.sqrt(pos.X * pos.X + pos.Z * pos.Z)
			local w = math.exp(-r * r * 2.5) * math.clamp((pos.Y + 0.2) / 1.2, 0, 1)
			if w > 0.001 then
				table.insert(verts, { id = id, rest = pos, w = w })
			end
		end
	end
	return verts
end

local function spawnMeshLoader(assetId, onSuccess)
	task.spawn(function()
		for _ = 1, 20 do
			local ok = pcall(function()
				local em      = AssetService:CreateEditableMeshAsync(Content.fromAssetId(assetId))
				local verts   = buildTopVerts_radial(em)
				local overlay = AssetService:CreateMeshPartAsync(Content.fromObject(em))
				overlay.Anchored    = true
				overlay.CanCollide  = false
				overlay.CanQuery    = false
				overlay.CastShadow  = not _G.SQUISH_PERF_MODE
				overlay.CFrame      = CFrame.new(0, -9999, 0)
				overlay.Parent      = workspace
				onSuccess(em, verts, overlay)
			end)
			if ok then break end
			task.wait(0.5)
		end
	end)
end

spawnMeshLoader( function(em, verts, overlay)
	cubeyEM = em; cubeyTopVerts = verts; cubeyOverlay = overlay; cubeyMeshReady = true
end)

spawnMeshLoader( function(em, verts, overlay)
	sphereEM = em; sphereTopVerts = verts; sphereOverlay = overlay; sphereMeshReady = true
end)

task.spawn(function()
	for _ = 1, 20 do
		local ok = pcall(function()
			local em    = AssetService:CreateEditableMeshAsync(Content.fromAssetId())
			local maxX, maxZ = 0, 0
			for _, id in ipairs(em:GetVertices()) do
				local pos = em:GetPosition(id)
				maxX = math.max(maxX, math.abs(pos.X))
				maxZ = math.max(maxZ, math.abs(pos.Z))
			end
			local verts = {}
			for _, id in ipairs(em:GetVertices()) do
				local pos = em:GetPosition(id)
				if pos.Y > -0.2 then
					table.insert(verts, {
						depression = 0,
						id         = id,
						rest       = pos,
						nx         = maxX > 0 and pos.X / maxX or 0,
						nz         = maxZ > 0 and pos.Z / maxZ or 0,
					})
				end
			end
			local overlay = AssetService:CreateMeshPartAsync(Content.fromObject(em))
			overlay.Anchored   = true; overlay.CanCollide = false
			overlay.CanQuery   = false; overlay.CastShadow = not _G.SQUISH_PERF_MODE
			overlay.CFrame     = CFrame.new(0, -9999, 0)
			overlay.Parent     = workspace
			slimeEM = em; slimeTopVerts = verts; slimeOverlay = overlay; slimeMeshReady = true
		end)
		if ok and slimeMeshReady then break end
		task.wait(0.5)
	end
end)

local groupOverlays = {}
for groupName, assetId in pairs(OVERLAY_ASSET_IDS) do
	local gName = groupName
	task.spawn(function()
		for _ = 1, 10 do
			local ok = pcall(function()
				local em    = AssetService:CreateEditableMeshAsync(Content.fromAssetId(assetId))
				local verts = buildTopVerts_radial(em)
				local ov    = AssetService:CreateMeshPartAsync(Content.fromObject(em))
				ov.Anchored = true; ov.CanCollide = false
				ov.CanQuery = false; ov.CastShadow = not _G.SQUISH_PERF_MODE
				ov.CFrame   = CFrame.new(0, -9999, 0)
				ov.Parent   = workspace
				groupOverlays[gName] = { meshOk = true, ov = ov, em = em, topVerts = verts }
			end)
			if ok then break end
			task.wait(0.3)
		end
	end)
end

local function getOverlay(state)
	if state.overlayCache then
		local c = state.overlayCache
		return c.ov, c.meshOk, c.em, c.topVerts
	end
	local ov, meshOk, em, topVerts
	if state and state.part and state.part.Parent then
		local groupName = state.part.Parent.Name
		local groupData = groupOverlays[groupName]
		if groupData then
			ov = groupData.ov; meshOk = groupData.meshOk
			em = groupData.em; topVerts = groupData.topVerts
		elseif OVERLAY_ASSET_IDS[groupName] then
			return nil, false, nil, nil
		end
	end
	if ov == nil then
		if state and state.isSlime  then ov = slimeOverlay;  meshOk = slimeMeshReady;  em = slimeEM;  topVerts = slimeTopVerts
		elseif state and state.isSphere then ov = sphereOverlay; meshOk = sphereMeshReady; em = sphereEM; topVerts = sphereTopVerts
		else ov = cubeyOverlay; meshOk = cubeyMeshReady; em = cubeyEM; topVerts = cubeyTopVerts
		end
	end
	if meshOk then
		state.overlayCache = { ov = ov, meshOk = meshOk, em = em, topVerts = topVerts }
	end
	return ov, meshOk, em, topVerts
end

local function makeCollider(name, size, cf)
	local col = Instance.new("Part")
	col.Name = name; col.Anchored = true; col.CanCollide = true
	col.CanQuery = true; col.CanTouch = false; col.Transparency = 1
	col.Material = Enum.Material.SmoothPlastic; col.CastShadow = false
	col.Size = size; col.CFrame = cf; col.Parent = workspace
	return col
end

local function makeSlimeCollider(part)
	part.CanCollide = false
	return makeCollider("slimeCollider", part.Size, part.CFrame)
end

local function isSlimePart(part)
	if part.Name ~= "default" then return false end
	local pName = part.Parent and part.Parent.Name
	return pName == "slime part" or pName == "waxedslime"
end

------------------------------------------------------------------------
-- ── Sound-id lookup tables (replaces per-part Sound instances) ───────
-- Each entry maps parentName → soundId string.
-- Used by poolPlay() at squish-time instead of storing snd on state.
------------------------------------------------------------------------
local CUBEY_SOUND_PARENT_DEFAULT = ""   -- fallback; actual id set from soundSet at runtime

local function setupCubey(part)
	local parentName = part.Parent and part.Parent.Name
	local isDumpling = part.Name == "default" and (parentName == "dumppling" or parentName == "dreamdrop")
	local isBigCubey = part.Name == "bigcubey"
	if part.Name ~= "cubey" and not isDumpling and not isBigCubey then return end
	if parentName == "cheesebrick" then return end
	if setupDone[part] then return end
	setupDone[part] = true

	local isSuper      = parentName == "SuperCubeyGroup"
	local isFast       = parentName == "FASTCubeyGroup"
	local isBounce     = parentName == "bounceCubeyGroup"
	local isBig        = parentName == "BIGCubeyGroup" or part.Name == "bigcubey"
	local isCheckpoint = parentName == "checkpointCubeyGroup"
	local isDonutGroup = isDonut(parentName or "")
	local isWaxedCube  = parentName == "waxedcube"

	local squishTween, recoverTween
	if isFast then
		squishTween = TWEEN_SNAP_SQUISH;    recoverTween = TWEEN_SNAP_RECOVER
	elseif isSuper then
		squishTween = TWEEN_FAST_SQUISH;    recoverTween = TWEEN_SUPER_RECOVER
	elseif parentName == "cheesebrick" then
		squishTween = TWEEN_SUPER_SQUISH;   recoverTween = TWEEN_SLOW_SQUISH
	elseif isDonutGroup then
		squishTween = TWEEN_SLOW_SQUISH;    recoverTween = TWEEN_QUICK_RECOVER
	else
		squishTween = TWEEN_DEFAULT_SQUISH; recoverTween = TWEEN_DEFAULT_RECOVER
	end

	local size      = part.Size
	local cf        = part.CFrame
	local bottomY   = cf.Position.Y - size.Y / 2
	local squishAmt = isCheckpoint and 0.18 or 0.42

	local function squishGoal(t)
		local newY = size.Y * (1 - t)
		return {
			Size   = Vector3.new(size.X * (1 + t * squishAmt), newY, size.Z * (1 + t * squishAmt)),
			CFrame = cf + Vector3.new(0, bottomY + newY / 2 - cf.Position.Y, 0),
		}
	end

	-- NO Sound instance created here — pool is used at play-time

	local collPart      = nil
	local needsCollider = parentName == "cheesebrick" or parentName == "GUMDROP"
		or isDonut(parentName or "") or parentName == "dumppling" or parentName == "dreamdrop"

	if parentName and needsCollider then
		local useMeshClone = isDonut(parentName) or parentName == "dumppling" or parentName == "dreamdrop"
		if useMeshClone then
			local col = part:Clone()
			col.Transparency = 1; col.LocalTransparencyModifier = 0
			for _, child in ipairs(col:GetChildren()) do child:Destroy() end
			col.Name = parentName == "dumppling" and "dumpplingCollider"
				or parentName == "dreamdrop" and "dreamdropCollider" or "donutCollider"
			col.Anchored = true; col.CanCollide = true; col.CanQuery = true
			col.CanTouch = false; col.Material = Enum.Material.SmoothPlastic
			col.CastShadow = false; col.Size = size
			local drop = (parentName == "dumppling" or parentName == "dreamdrop")
				and Vector3.new(0, -0.5, 0) or Vector3.zero
			col.CFrame = cf + drop
			col.Parent = workspace; collPart = col
		else
			collPart = makeCollider(
				parentName == "GUMDROP" and "gumdropCollider" or "cheesebrickCollider", size, cf)
		end
		collPart:SetAttribute("OwnerCubey", part:GetFullName())
		part.CanCollide = false
	end

	local squishTarget = isCheckpoint and 0.3 or 0.35
	local state = {
		isSphere = false, isSlime = false,
		isSuper = isSuper, isFast = isFast, isBounce = isBounce,
		isBig = isBig, isCheckpoint = isCheckpoint,
		isWaxedCube = isWaxedCube,
		lastSndTime = 0, wasOn = false, onFrames = 0, offFrames = 0,
		clampX = 0, clampZ = 0, lockUntil = 0, dentX = 0, dentZ = 0,
		part = part, collPart = collPart,
		sz = size, cf = cf, bot = bottomY,
		centerX = cf.Position.X, centerZ = cf.Position.Z,
		color = part.Color, mat = part.Material, trans = part.Transparency,
		rest = squishGoal(0), sqG = squishGoal(squishTarget),
		useSqI = squishTween, useRcI = recoverTween,
		-- snd removed; pool is used instead
		tweens = {},
		overlayCache = nil,
		parentName = parentName,
		-- SurfaceAppearance sync: cached flag set on first activation
		_saSync = false,
	}
	partData[part] = state
	addToBucket(part, state)

	if isDonutGroup then
		donutSpinData[part] = {
			x = cf.Position.X, y = cf.Position.Y, z = cf.Position.Z,
			dir = donutSpinDir(parentName),
		}
	end
end

local function setupSphere(part)
	if setupDone[part] then return end
	setupDone[part] = true

	local size    = part.Size
	local cf      = part.CFrame
	local bottomY = cf.Position.Y - size.Y / 2

	local function sphereGoal(t)
		local newY = size.Y * (1 - t)
		return {
			Size   = Vector3.new(size.X * (1 + t * 0.42), newY, size.Z * (1 + t * 0.42)),
			CFrame = cf + Vector3.new(0, bottomY + newY / 2 - cf.Position.Y, 0),
		}
	end

	-- NO Sound instance created here

	local isJumpKill = part.Parent and part.Parent.Name == "jumpkillspheresquish"
	local squishTw   = isJumpKill
		and TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		or TWEEN_DEFAULT_SQUISH

	local sqY = size.Y * 0.65
	local state = {
		isSphere = true, isSlime = false, isSuper = false, isFast = false,
		isBounce = false, isBig = false, isCheckpoint = false, isWaxedCube = false,
		lastSndTime = 0, wasOn = false, onFrames = 0, offFrames = 0,
		clampX = 0, clampZ = 0, lockUntil = 0,
		sz = size, cf = cf, bot = bottomY,
		centerX = cf.Position.X, centerZ = cf.Position.Z,
		color = part.Color, mat = part.Material, trans = part.Transparency,
		rest = sphereGoal(0),
		sqG  = {
			Size   = Vector3.new(size.X * 1.147, sqY, size.Z * 1.147),
			CFrame = cf + Vector3.new(0, bottomY + sqY / 2 - cf.Position.Y, 0),
		},
		useSqI = squishTw, useRcI = TWEEN_DEFAULT_RECOVER,
		tweens = {},
		overlayCache = nil,
		parentName = part.Parent and part.Parent.Name,
		_saSync = false,
	}
	partData[part] = state
	addToBucket(part, state)
end

local function setupSlime(part)
	if setupDone[part] then return end
	setupDone[part] = true

	local size    = part.Size
	local cf      = part.CFrame
	local bottomY = cf.Position.Y - size.Y / 2

	local function slimeGoal(t)
		local newY = size.Y * (1 - t)
		return {
			Size   = Vector3.new(size.X * (1 + t * 0.06), newY, size.Z * (1 + t * 0.06)),
			CFrame = cf + Vector3.new(0, bottomY + newY / 2 - cf.Position.Y, 0),
		}
	end

	-- NO Sound instance created here

	local state = {
		isSphere = false, isSlime = true, isSuper = false, isFast = false,
		isBounce = false, isBig = false, isCheckpoint = false, isWaxedCube = false,
		lastSndTime = 0, wasOn = false, onFrames = 0, offFrames = 0,
		clampX = 0, clampZ = 0, lockUntil = 0, slimeVal = 0, collPart = nil,
		sz = size, cf = cf, bot = bottomY,
		centerX = cf.Position.X, centerZ = cf.Position.Z,
		color = part.Color, mat = part.Material, trans = part.Transparency,
		rest = slimeGoal(0),
		sqG  = { Size = size, CFrame = cf + Vector3.new(0, -1.3, 0) },
		useSqI = TWEEN_SLIME_SQUISH, useRcI = TWEEN_SLIME_RECOVER,
		tweens = {},
		overlayCache = nil,
		parentName = part.Parent and part.Parent.Name,
		_saSync = false,
	}
	partData[part] = state
	addToBucket(part, state)
end

local function attachSlimeCollider(part)
	local state = partData[part]
	if not state then return end
	part.CanCollide = false
	state.collPart  = makeSlimeCollider(part)
end

local function registerPart(part)
	if not part:IsA("BasePart") then return end
	if part.Name == "cubey" or part.Name == "bigcubey" then
		setupCubey(part)
	elseif part.Name == "default" then
		local pName = part.Parent and part.Parent.Name
		if pName == "dumppling" or pName == "dreamdrop" then
			setupCubey(part)
		elseif pName == "spheresquish" or pName == "jumpkillspheresquish" then
			setupSphere(part)
		elseif isSlimePart(part) then
			setupSlime(part)
			attachSlimeCollider(part)
		end
	end
end

task.spawn(function()
	local descs = workspace:GetDescendants()
	for i = 1, #descs, 50 do
		for j = i, math.min(i + 49, #descs) do
			registerPart(descs[j])
		end
		task.wait()
	end
	workspace.DescendantAdded:Connect(function(part)
		task.defer(registerPart, part)
	end)
	task.wait(2)
	for _, desc in ipairs(workspace:GetDescendants()) do
		if not setupDone[desc] then registerPart(desc) end
	end
end)

-- Donut spin: use distSq to avoid sqrt in proximity check
RunService.Heartbeat:Connect(function(dt)
	local serverTime = workspace:GetServerTimeNow() * 2.6179938779914944
	local character  = LocalPlayer.Character
	local rootPart   = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid   = character and character:FindFirstChildOfClass("Humanoid")

	for part, spinState in pairs(donutSpinData) do
		if not part.Parent then donutSpinData[part] = nil continue end
		local angle      = serverTime * spinState.dir % (2 * math.pi)
		local angleDelta = 2.6179938779914944 * dt * spinState.dir
		local pState     = partData[part]
		local squishT    = pState and math.clamp(1 - part.Size.Y / pState.sz.Y, 0, 0.18) or 0
		local squishN    = squishT / 0.18
		local posY       = spinState.y + (pState and -pState.sz.Y * squishT / 2 or 0)

		part.CFrame = CFrame.new(spinState.x, posY, spinState.z) * CFrame.Angles(0, angle, 0)
		if pState and pState.collPart then
			local dropAmt = (part.Parent and COLLIDER_DROP[part.Parent.Name] or 1.2) * squishN
			pState.collPart.CFrame = CFrame.new(spinState.x, posY - dropAmt, spinState.z) * CFrame.Angles(0, angle, 0)
		end

		if rootPart and humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
			local dx   = rootPart.Position.X - spinState.x
			local dz   = rootPart.Position.Z - spinState.z
			-- distSq avoids sqrt; threshold is (halfW+1)^2
			local distSq = dx * dx + dz * dz
			local dy   = rootPart.Position.Y - spinState.y
			local halfW = (pState and pState.sz or part.Size).X / 2
			local thresh = halfW + 1
			if distSq < thresh * thresh and dy > -1 and dy < 6 then
				local rotatedOffset = CFrame.Angles(0, angleDelta, 0):VectorToWorldSpace(Vector3.new(dx, 0, dz))
				local newPos = Vector3.new(spinState.x + rotatedOffset.X, rootPart.Position.Y, spinState.z + rotatedOffset.Z)
				rootPart.CFrame = CFrame.new(newPos) * CFrame.Angles(0, angleDelta, 0)
					* (rootPart.CFrame - rootPart.CFrame.Position)
			end
		end
	end
end)

local activePart    = nil
local squishCounter = 0
local _removePending = {}

local _dentFrame = 0

RunService.RenderStepped:Connect(function(dt)
	_dentFrame = _dentFrame + 1

	for _, part in ipairs(_removePending) do
		local removedState = partData[part]
		if removedState and removedState.wasOn then
			squishedCount = math.max(0, squishedCount - 1)
			squishedParts[part] = nil
		end
		removeFromBucket(part)
		partData[part] = nil
		if activePart == part then activePart = nil end
	end
	_removePending = {}

	local character = LocalPlayer.Character
	local rootPart  = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid  = character and character:FindFirstChildOfClass("Humanoid")

	local squishRange = getPlayerRange()

	local standingOn     = nil
	local standingHitPos = nil

	if rootPart then
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		local excluded = { character, cubeyOverlay, sphereOverlay, slimeOverlay }
		for _, gData in pairs(groupOverlays) do table.insert(excluded, gData.ov) end
		params.FilterDescendantsInstances = excluded

		local hit = workspace:Raycast(rootPart.Position, Vector3.new(0, -9, 0), params)
		if hit and (hit.Normal.Y > 0.3 or partData[hit.Instance]) then
			standingOn = hit.Instance
			local colliderNames = {
				cheesebrickCollider = true, gumdropCollider = true,
				donutCollider = true, dumpplingCollider = true, dreamdropCollider = true,
			}
			if standingOn and colliderNames[standingOn.Name] then
				for visualPart, state in pairs(partData) do
					if state.collPart == standingOn then standingOn = visualPart break end
				end
			end
			standingHitPos = hit.Position
		end
	end

	if humanoid and humanoid.FloorMaterial == Enum.Material.Air then
		standingOn = nil; standingHitPos = nil
	end

	-- ── Overlay / dent update for activePart (throttled every other frame) ──
	if activePart and (_dentFrame % 2 == 0) then
		local state = partData[activePart]
		local ov, meshOk, em, topVerts = getOverlay(state)

		if state and meshOk and (ov or state.isSlime) then
			if standingOn == activePart and standingHitPos then
				local offset = standingHitPos - activePart.CFrame.Position
				local normX  = math.clamp(offset.X / (state.sz.X / 2) * 0.789, -0.45, 0.45)
				local normZ  = math.clamp(offset.Z / (state.sz.Z / 2) * 0.789, -0.45, 0.45)
				state.clampX = state.clampX + (normX - state.clampX) * 0.06
				state.clampZ = state.clampZ + (normZ - state.clampZ) * 0.06

				local localHit = activePart.CFrame:PointToObjectSpace(standingHitPos)
				local fnx = localHit.X / (state.sz.X / 2)
				local fnz = localHit.Z / (state.sz.Z / 2)
				state.dentX = (state.dentX or fnx) + (fnx - (state.dentX or fnx)) * 0.1
				state.dentZ = (state.dentZ or fnz) + (fnz - (state.dentZ or fnz)) * 0.1
			end

			local maxSquish  = state.isSlime and 0.65
				or state.isBig and 0.18 or state.isCheckpoint and 0.3 or 0.35
			local squishFrac = math.clamp(1 - activePart.Size.Y / state.sz.Y, 0, maxSquish) / maxSquish

			if ov then
				ov.Size         = activePart.Size
				ov.Color        = state.color
				ov.Material     = state.mat
				ov.Transparency = state.trans

				-- SurfaceAppearance sync: only run once per activation, not every frame
				if not state._saSync then
					state._saSync = true
					local sa  = activePart:FindFirstChildOfClass("SurfaceAppearance")
					local sa2 = ov:FindFirstChildOfClass("SurfaceAppearance")
					if sa and not sa2 then sa:Clone().Parent = ov
					elseif sa2 and not sa then sa2:Destroy() end
				end

				local tiltAng = math.rad(8 * squishFrac)
				ov.CFrame = activePart.CFrame
					* CFrame.Angles(tiltAng * (state.clampZ / 0.789), 0, -tiltAng * (state.clampX / 0.789))
			end

			if topVerts and #topVerts > 0 then
				if state.isSlime and rootPart then
					local target   = state.wasOn and 1 or 0
					state.slimeVal = state.slimeVal + (target - state.slimeVal) * math.min(dt * 2 * (state.wasOn and 4 or 2), 1)

					local footLocal = activePart.CFrame:PointToObjectSpace(rootPart.Position + Vector3.new(0, -2.5, 0))
					local fx = footLocal.X / (state.sz.X * 0.5)
					local fz = footLocal.Z / (state.sz.Z * 0.5)

					for _, v in ipairs(topVerts) do
						local dx     = v.nx - fx
						local dz     = v.nz - fz
						local gauss  = math.exp(-(dx * dx + dz * dz) * 25)
						local depress= gauss * math.clamp((v.rest.Y - 0.5) / 0.83, 0, 1) * state.slimeVal
						if v.depression < depress then
							v.depression = depress
						else
							v.depression = math.max(depress, v.depression - 0.35 * dt * 2)
						end
						em:SetPosition(v.id, Vector3.new(v.rest.X, math.max(v.rest.Y - v.depression * 4, -1.1), v.rest.Z))
					end
				else
					local pName      = state.parentName
					local spread     = pName and DENT_SPREAD[pName] or 2.5
					local invSpread  = 6.91 / spread
					local halfSizes  = pName and DONUT_HALF_SIZE[pName]
					local cx = halfSizes and (state.dentX or 0) * halfSizes.halfX or state.clampX * 0.45
					local cz = halfSizes and (state.dentZ or 0) * halfSizes.halfZ or state.clampZ * 0.45

					state._dented = state._dented or {}
					local newDented = {}

					for _, v in ipairs(topVerts) do
						local dx = v.rest.X - cx; local dz = v.rest.Z - cz
						local dist2 = dx * dx + dz * dz
						if dist2 <= invSpread then
							local g = math.exp(-dist2 * spread)
							em:SetPosition(v.id, Vector3.new(
								v.rest.X,
								v.rest.Y - g * math.clamp((v.rest.Y + 0.2) / 1.2, 0, 1) * 0.4 * squishFrac,
								v.rest.Z))
							newDented[v.id] = v
						end
					end

					for id, v in pairs(state._dented) do
						if not newDented[id] then
							local dx = v.rest.X - cx; local dz = v.rest.Z - cz
							local g  = math.exp(-(dx * dx + dz * dz) * spread)
							em:SetPosition(id, Vector3.new(
								v.rest.X,
								v.rest.Y - g * math.clamp((v.rest.Y + 0.2) / 1.2, 0, 1) * 0.4 * squishFrac,
								v.rest.Z))
							if squishFrac > 0.005 then newDented[id] = v end
						end
					end
					state._dented = newDented
				end
			end
		end
	end

	-- ── Build candidate set ──
	local candidates = {}
	local seen       = {}

	if standingOn and partData[standingOn] then
		candidates[standingOn] = true
		seen[standingOn]       = true
	end

	if activePart and partData[activePart] then
		candidates[activePart] = true
		seen[activePart]       = true
	end

	if rootPart and squishRange > 1 then
		local rangeStuds = squishRange * 12
		local px, pz     = rootPart.Position.X, rootPart.Position.Z
		for _, part in ipairs(getCachedNearbyParts(px, pz, rangeStuds + BUCKET_SIZE)) do
			if not seen[part] then
				seen[part]        = true
				candidates[part]  = true
			end
		end
	end

	for part in pairs(candidates) do
		local state = partData[part]
		if not state then continue end

		if not part.Parent then
			table.insert(_removePending, part)
			continue
		end

		local isNearby = false
		if rootPart and squishRange > 1 and standingOn ~= part and not state.isBig then
			local dx = rootPart.Position.X - state.centerX
			local dz = rootPart.Position.Z - state.centerZ
			local dy = rootPart.Position.Y - state.cf.Position.Y
			local distXZ      = math.sqrt(dx * dx + dz * dz)
			local rangeRadius = (state.sz.X / 2 + state.sz.Z / 2) * squishRange
			if distXZ <= rangeRadius and dy > -2 and dy < state.sz.Y + 8 then isNearby = true end
		end

		if standingOn == part or isNearby then
			state.onFrames  = math.min(state.onFrames + 1, 2)
			state.offFrames = 0
		else
			state.onFrames  = 0
			state.offFrames = math.min(state.offFrames + 1, 4)
		end

		local isOn      = state.onFrames >= 1
		local pName     = state.parentName
		local threshold = pName and OFF_FRAME_THRESHOLD[pName] or 3
		local isOff     = state.offFrames >= threshold and tick() > state.lockUntil

		if isOn and not state.wasOn then
			state.wasOn     = true
			squishedCount   = squishedCount + 1
			squishedParts[part] = state
			state.lockUntil = state.isFast  and tick() + 0.06
				or state.isSuper and tick() + 0.3 or 0

			if not state.isSlime then
				local customT = pName and SQUISH_DURATION[pName]
				local squishT = customT or (state.isBig and 0.18) or (state.isCheckpoint and 0.3) or 0.35
				local squishA = state.isBig and 0.1 or state.isCheckpoint and 0.18 or 0.42
				local newY    = state.sz.Y * (1 - squishT)
				state.sqG = {
					Size  = Vector3.new(state.sz.X * (1 + squishT * squishA), newY, state.sz.Z * (1 + squishT * squishA)),
					CFrame= state.cf + Vector3.new(0, state.bot + newY / 2 - state.cf.Position.Y, 0),
				}
			else
				state.sqG = { Size = state.sz, CFrame = state.cf + Vector3.new(0, -1.3, 0) }
			end

			if activePart and activePart ~= part then
				local prevState = partData[activePart]
				if prevState then
					local prevOv = getOverlay(prevState)
					cancelTweens(prevState)
					playTween(prevState, activePart, prevState.useRcI, prevState.rest)
					activePart.Transparency = prevState.trans
					if prevOv then prevOv.CFrame = CFrame.new(0, -9999, 0) end
					-- reset SA sync flag so next activation re-checks
					prevState._saSync = false
				end
			end

			cancelTweens(state)

			if standingOn == part then
				activePart    = part
				squishCounter = squishCounter + 1
				-- reset SA sync so it runs once on this activation
				state._saSync = false

				local ov, meshOk = getOverlay(state)
				if ov and meshOk then
					ov.Size = state.sz; ov.CFrame = part.CFrame
					ov.Color = state.color; ov.Material = state.mat
					ov.Transparency = state.trans
					if state.isSlime or (part.TextureID and part.TextureID ~= "") then
						pcall(function()
							if part.TextureContent then ov.TextureContent = part.TextureContent end
							ov.TextureID = part.TextureID
						end)
					end
					part.Transparency = 1
				end
			end

			if state.isWaxedCube or (state.isSlime and part.Parent and WAX_CONFIG[part.Parent.Name]) then
				local waxModel = part.Parent
				if waxModel and waxStates[waxModel] then
					if not waxStates[waxModel].wantSquish then
						squishWaxModel(waxStates[waxModel])
					end
				end
			end

			-- ── Sound via pool ────────────────────────────────────────────
			local sndCooldown = state.isSlime and 0
				or (isDonut(pName or "") or pName == "dumppling" or pName == "dreamdrop") and 0.05 or 0.4

			if sndCooldown < tick() - state.lastSndTime and not cubesSoundsOff() then
				local soundSet = getCurrentSoundSet()
				local soundId
				if pName == "dreamdrop" or pName == "dumppling" then
					soundId = ""
				elseif pName == "GUMDROP" and soundSet.Gumdrop then
					soundId = soundSet.Gumdrop
				elseif isDonut(pName or "") and soundSet.Donut then
					soundId = soundSet.Donut
				elseif soundSet.Cubey then
					soundId = soundSet.Cubey
				end

				local speed
				if pName == "dreamdrop"     then speed = math.random(100, 115) / 100
				elseif pName == "dumppling" then speed = math.random(95,  105) / 100
				elseif pName == "GUMDROP"   then speed = math.random(60,   70) / 100
				elseif isDonut(pName or "") then speed = math.random(65,   75) / 100
				elseif pName == "drpeppa"   then speed = math.random(40,   70) / 100
				else                             speed = math.random(65,  105) / 100
				end

				local vol = math.random(75, 95) / 100

				if pName ~= "waxedcube" then
					poolPlay(soundId, speed, vol)
					-- dumppling/dreamdrop: short stop handled implicitly by pool (next
					-- pool play will naturally cut over; explicit stop not needed for
					-- pooled sounds since they are shared)
				end
				state.lastSndTime = tick()
			end

			if state.isSlime and state.collPart then
				local flatH = state.sz.Y * 0.05
				playTween(state, state.collPart, state.useSqI, {
					Size  = Vector3.new(state.sz.X * 1.019, flatH, state.sz.Z * 1.019),
					CFrame= state.cf + Vector3.new(0, state.bot + flatH / 2 - state.cf.Position.Y, 0),
				})
			elseif not state.isSlime then
				if isDonut(pName or "") then
					playTween(state, part, state.useSqI, { Size = state.sqG.Size })
					if state.collPart then
						playTween(state, state.collPart, state.useSqI, { Size = state.sqG.Size })
					end
				else
					playTween(state, part, state.useSqI, state.sqG)
					if state.collPart then
						local drop    = (part.Parent and COLLIDER_DROP[pName or ""] or 1.3)
						playTween(state, state.collPart, state.useSqI, {
							Size  = state.sqG.Size,
							CFrame= state.sqG.CFrame + Vector3.new(0, -drop, 0),
						})
					end
				end
			end

			if state.isSlime then
				local hum = character and character:FindFirstChildOfClass("Humanoid")
				if hum then hum.WalkSpeed = hum.WalkSpeed * 0.38 end
			end

			if state.isBounce then
				task.delay(state.useSqI.Time, function()
					if not (rootPart and rootPart.Parent) then return end
					if not state.wasOn then return end
					local hum         = character and character:FindFirstChildOfClass("Humanoid")
					local compression = math.clamp(1 - part.Size.Y / state.sz.Y, 0, 1)
					local launchY     = compression * 25 + 75
					if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
					rootPart.CFrame   = rootPart.CFrame + Vector3.new(0, 0.3, 0)
					rootPart.AssemblyLinearVelocity = Vector3.new(
						rootPart.AssemblyLinearVelocity.X,
						math.max(rootPart.AssemblyLinearVelocity.Y, launchY),
						rootPart.AssemblyLinearVelocity.Z)
				end)
			end

		elseif isOff and state.wasOn then
			state.wasOn   = false
			squishedCount = math.max(0, squishedCount - 1)
			squishedParts[part] = nil
			cancelTweens(state)

			if state.isWaxedCube or (state.isSlime and part.Parent and WAX_CONFIG[part.Parent.Name]) then
				local waxModel = part.Parent
				if waxModel and waxStates[waxModel] and waxStates[waxModel].wantSquish then
					recoverWaxModel(waxStates[waxModel])
				end
			end

			if state.isSlime and state.collPart then
				playTween(state, state.collPart, state.useRcI, { Size = state.sz, CFrame = state.cf })
			else
				if isDonut(pName or "") then
					playTween(state, part, state.useRcI, { Size = state.rest.Size })
					if state.collPart then
						playTween(state, state.collPart, state.useRcI, { Size = state.rest.Size })
					end
				else
					playTween(state, part, state.useRcI, state.rest)
					if state.collPart then
						local drop = (pName == "dumppling" or pName == "dreamdrop")
							and Vector3.new(0, -0.5, 0) or Vector3.zero
						playTween(state, state.collPart, state.useRcI, {
							Size  = state.rest.Size,
							CFrame= state.rest.CFrame + drop,
						})
					end
				end
			end

			if state.isSlime then
				local hum = character and character:FindFirstChildOfClass("Humanoid")
				if hum then hum.WalkSpeed = 16 end
			end

			if activePart == part then
				local token = squishCounter
				task.delay(state.useRcI.Time, function()
					if activePart ~= part or squishCounter ~= token or state.wasOn then return end
					activePart = nil
					local ov = getOverlay(state)
					if ov then ov.CFrame = CFrame.new(0, -9999, 0) end
					part.Transparency = state.trans
					state._saSync = false   -- reset for next activation
				end)
			end
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(0.5)
		for _, state in pairs(partData) do
			if state.collPart and state.collPart.Parent and state.collPart.Transparency ~= 1 then
				state.collPart.Transparency = 1
			end
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(0.5)
		if squishedCount == 0 then continue end

		local character = LocalPlayer.Character
		local rootPart  = character and character:FindFirstChild("HumanoidRootPart")
		local playerPos = rootPart and rootPart.Position

		if activePart and not partData[activePart] then activePart = nil end

		for part, state in pairs(squishedParts) do
			if not part.Parent then
				table.insert(_removePending, part)
				squishedParts[part] = nil
				continue
			end

			local restH = state.rest and state.rest.Size and state.rest.Size.Y or state.sz and state.sz.Y
			if restH and part.Size.Y < restH - 0.01 then
				local farEnough = true
				if playerPos then
					local dx = playerPos.X - part.Position.X
					local dz = playerPos.Z - part.Position.Z
					if dx * dx + dz * dz < (part.Size.X * 1.5) ^ 2 then farEnough = false end
				end
				if farEnough and not state.wasOn and #state.tweens == 0 then
					cancelTweens(state)
					part.Size = state.rest.Size; part.CFrame = state.rest.CFrame
					if state.collPart and state.collPart.Parent then
						state.collPart.Size   = state.rest.Size
						state.collPart.CFrame = state.rest.CFrame
					end
					part.Transparency = state.trans or 0
					if activePart == part then activePart = nil end
					squishedParts[part] = nil
				end
			else
				squishedParts[part] = nil
			end
		end
	end
end)