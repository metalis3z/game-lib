-- ConfettiFX: rainbow confetti burst ported from the "Grow Your Lucky Block"
-- place (its ScreenGui.ConfettiFrame + Shared.CelebrateFX.spawnConfetti). The
-- ConfettiFrame + its colour-image templates are rebuilt in code (instances
-- created in Studio edit mode don't persist; runtime build does) so this is
-- fully self-contained -- no copied assets, no authored-UI changes.
--
-- Lucky-block claim celebration adds a world-space firework burst on top of
-- the UI confetti: a clone of workspace.ConfettiEmitter (a ParticleEmitter
-- the designer dropped into Workspace) is attached above the player's head,
-- emits a big burst, and gets cleaned up by Debris. The accompanying
-- firework-explosion SFX (134947109312227) is played 3D at the player so the
-- pop feels positional.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- Firework explosion SFX for the lucky-block claim moment (provided by the
-- designer; replaces the older soft confetti chime which lived on this id).
local CONFETTI_SOUND_ID = "rbxassetid://134947109312227"

-- World-space firework burst: how many particles to emit and how long the
-- carrier part lingers before Debris cleans it up. Lifetime > emitter's max
-- particle lifetime so we don't cut particles off mid-flight.
local WORLD_BURST_PARTICLES = 120
local WORLD_BURST_PART_LIFETIME = 4
local WORLD_BURST_HEAD_OFFSET = Vector3.new(0, 4, 0)

-- Resolves workspace.ConfettiEmitter -- the designer added this manually
-- (lowercase "confettiemitter" at the time of writing, but a case-insensitive
-- fallback walk catches future renames).
local function findConfettiEmitter()
	local direct = Workspace:FindFirstChild("ConfettiEmitter")
		or Workspace:FindFirstChild("confettiemitter")
	if direct and direct:IsA("ParticleEmitter") then return direct end
	for _, c in ipairs(Workspace:GetChildren()) do
		if c:IsA("ParticleEmitter") and c.Name:lower() == "confettiemitter" then
			return c
		end
	end
	return nil
end

-- Fires the workspace ConfettiEmitter clone at the player's position with the
-- firework SFX. No-op (silently) if the emitter isn't present in Workspace,
-- so the UI confetti still plays even if the designer hasn't dropped the
-- emitter in yet.
local function fireworkBurstAtPlayer()
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local emitter = findConfettiEmitter()

	-- Carrier part: invisible, anchored to follow the player via the
	-- WeldConstraint so the burst stays at the player even if they move
	-- mid-animation. Anchored=false + welded to HRP keeps the part glued to
	-- the character without any per-frame work.
	local part = Instance.new("Part")
	part.Name = "_LuckyClaimFirework"
	part.Size = Vector3.new(0.2, 0.2, 0.2)
	part.Transparency = 1
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.Massless = true
	part.Anchored = false
	part.CFrame = hrp.CFrame * CFrame.new(WORLD_BURST_HEAD_OFFSET)
	part.Parent = Workspace

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = part
	weld.Part1 = hrp
	weld.Parent = part
	-- Offset the weld so the carrier sits above the head, not inside the
	-- torso (WeldConstraint freezes the current relative CFrame at parent time).

	local attachment = Instance.new("Attachment")
	attachment.Name = "FireworkAttachment"
	attachment.Parent = part

	if emitter then
		local clone = emitter:Clone()
		clone.Enabled = false   -- we use :Emit() for a single burst, not continuous
		clone.Parent = attachment
		clone:Emit(WORLD_BURST_PARTICLES)
	end

	-- 3D firework SFX parented to the carrier so it positions at the player.
	local sound = Instance.new("Sound")
	sound.SoundId = CONFETTI_SOUND_ID
	sound.Volume = 1.0
	sound.RollOffMode = Enum.RollOffMode.InverseTapered
	sound.RollOffMaxDistance = 200
	sound.Parent = part
	sound:Play()
	sound.Ended:Once(function() if sound and sound.Parent then sound:Destroy() end end)

	Debris:AddItem(part, WORLD_BURST_PART_LIFETIME)
end

-- name -> imageId, mirrored from the source ConfettiFrame children.
local CONFETTI_IMAGES = {
	{ "GreenConfettiImage", "rbxassetid://70595396202234" },
	{ "RedConfettiImage", "rbxassetid://135285110603696" },
	{ "BlueConfettiImage", "rbxassetid://125037894780909" },
	{ "YellowConfettiImage", "rbxassetid://117023931808592" },
	{ "PurpleConfettiImage", "rbxassetid://105225163755284" },
	{ "TealConfettiImage", "rbxassetid://110696159859973" },
}

local ConfettiFX = {}

local cache = nil -- { frame=, templates={}, sound= }

local function build()
	if cache and cache.frame and cache.frame.Parent and cache.gui and cache.gui.Parent then
		return cache
	end
	local pg = player:FindFirstChildOfClass("PlayerGui")
	if not pg then return nil end

	-- Reuse an existing ConfettiGui if one is already present (survives
	-- respawns; collapses any duplicates) so guis never stack.
	local existing
	for _, g in ipairs(pg:GetChildren()) do
		if g.Name == "ConfettiGui" and g:IsA("ScreenGui") then
			if existing then g:Destroy() else existing = g end
		end
	end
	if existing then
		local frame = existing:FindFirstChild("ConfettiFrame")
		if frame then
			local templates = {}
			for _, x in ipairs(frame:GetChildren()) do
				if x:IsA("ImageLabel") and x.Name:find("ConfettiImage") then
					x.Visible = false
					templates[#templates + 1] = x
				end
			end
			if #templates > 0 then
				cache = { gui = existing, frame = frame, templates = templates, sound = existing:FindFirstChild("ConfettiSound") }
				return cache
			end
		end
		existing:Destroy()
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "ConfettiGui"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 50
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local frame = Instance.new("Frame")
	frame.Name = "ConfettiFrame"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = UDim2.new(1, 0, 0.921751857, 0)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.ClipsDescendants = false
	frame.Parent = gui

	local arc = Instance.new("UIAspectRatioConstraint")
	arc.AspectRatio = 2.041614055633545
	arc.AspectType = Enum.AspectType.FitWithinMaxSize
	arc.DominantAxis = Enum.DominantAxis.Width
	arc.Parent = frame

	local templates = {}
	for _, entry in ipairs(CONFETTI_IMAGES) do
		local img = Instance.new("ImageLabel")
		img.Name = entry[1]
		img.Image = entry[2]
		img.BackgroundTransparency = 1
		img.BorderSizePixel = 0
		img.ScaleType = Enum.ScaleType.Stretch
		img.Size = UDim2.new(0.11210072, 0, 0.0675972179, 0)
		img.Visible = false
		local iarc = Instance.new("UIAspectRatioConstraint")
		iarc.AspectRatio = 3.3857
		iarc.AspectType = Enum.AspectType.FitWithinMaxSize
		iarc.Parent = img
		img.Parent = frame
		templates[#templates + 1] = img
	end

	local sound = Instance.new("Sound")
	sound.Name = "ConfettiSound"
	sound.SoundId = CONFETTI_SOUND_ID
	sound.Volume = 1.4
	sound.Parent = gui

	gui.Parent = pg
	cache = { gui = gui, frame = frame, templates = templates, sound = sound }
	return cache
end

-- Rainbow confetti burst from the bottom edge -- ported verbatim from
-- CelebrateFX.spawnConfetti (tween feel kept identical).
local function spawnConfetti(confettiFrame, templates, piecesPerColor)
	piecesPerColor = piecesPerColor or 8
	-- Build the burst a dozen pieces per frame instead of ~48 clones + ~96
	-- tweens in ONE frame: that single-frame spike landed exactly on the
	-- loot-claim / surfacing moment. The whole burst still starts within
	-- ~4 frames, visually identical.
	task.spawn(function()
	local spawned = 0
	for _, template in ipairs(templates) do
		for _ = 1, piecesPerColor do
			if not confettiFrame.Parent then return end
			local piece = template:Clone()
			piece.Name = "ConfettiBurst"
			piece.Visible = true
			local startX = math.random(10, 90) / 100
			piece.Position = UDim2.fromScale(startX, 0.95)
			piece.AnchorPoint = Vector2.new(0.5, 0.5)
			piece.Rotation = math.random(-180, 180)
			piece.ImageTransparency = 0
			piece.Parent = confettiFrame

			local targetX = math.clamp(startX + (math.random(-30, 30) / 100), 0, 1)
			local targetY = math.random(0, 60) / 100
			local endRot = piece.Rotation + math.random(-540, 540)
			local dur = (math.random(60, 95)) / 100

			TweenService:Create(
				piece,
				TweenInfo.new(dur, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
				{ Position = UDim2.fromScale(targetX, targetY), Rotation = endRot }
			):Play()
			TweenService:Create(
				piece,
				TweenInfo.new(dur, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
				{ ImageTransparency = 1 }
			):Play()

			Debris:AddItem(piece, dur + 0.15)
			spawned += 1
			if spawned % 12 == 0 then
				task.wait()
			end
		end
	end
	end)
end

-- Fire a confetti burst (+ firework explosion). Safe to call repeatedly.
-- Layers two effects: (1) screen-space UI confetti from the bottom edge
-- and (2) a world-space firework burst at the player using
-- workspace.ConfettiEmitter + the firework SFX. The world burst is the
-- celebration the lucky-block claim is built around; the UI confetti
-- stays on top for extra screen pop.
function ConfettiFX.Burst(piecesPerColor)
	-- World-space firework comes first so the explosion is felt the
	-- instant the player sees the reveal, even if the GUI build path is
	-- slow (cold PlayerGui on first claim of a session).
	pcall(fireworkBurstAtPlayer)

	local c = build()
	if not c then return end
	c.frame.Visible = true
	-- The old in-GUI confetti chime sound was replaced by the firework SFX
	-- played in 3D at the player above; not playing it from the GUI as well
	-- so the explosion doesn't double-trigger.
	spawnConfetti(c.frame, c.templates, piecesPerColor)
end

return ConfettiFX
