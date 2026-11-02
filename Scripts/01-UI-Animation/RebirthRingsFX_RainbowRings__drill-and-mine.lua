-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ReplicatedStorage/Source/Modules/RebirthRingsFX.lua  (luau, 94 lines)
-- Categories: ui-animation 12.0
-- What it does: Train of expanding rainbow UIStroke rings on a BillboardGui around the player (rotating UIGradient per ring, fade as they grow).

-- Rainbow ripple rings around the character on rebirth.
-- Same 2D style as the shop badge pulse (NotifyPulse): expanding circle
-- strokes that fade as they grow, but rainbow-colored and world-sized,
-- drawn on a BillboardGui so they always face the camera like flat UI.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local RebirthRingsFX = {}

local DURATION = 2.6        -- how long new rings keep spawning
local RING_INTERVAL = 0.18  -- delay between successive rings
local RING_LIFE = 0.9       -- each ring's grow + fade time
local MAX_DIAMETER = 16     -- studs; billboard size = final ring size
local START_SCALE = 0.12    -- rings start small around the torso
local THICKNESS = 6

local player = Players.LocalPlayer

local function rainbowGradient(rotation)
	local g = Instance.new("UIGradient")
	local keypoints = {}
	for i = 0, 6 do
		table.insert(keypoints, ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6, 1, 1)))
	end
	g.Color = ColorSequence.new(keypoints)
	g.Rotation = rotation
	return g
end

-- one expanding rainbow ring, fading as it grows, then cleans itself up
local function spawnRing(gui, hueRotation)
	local r = Instance.new("Frame")
	r.Name = "RainbowRing"
	r.AnchorPoint = Vector2.new(0.5, 0.5)
	r.Position = UDim2.fromScale(0.5, 0.5)
	r.Size = UDim2.fromScale(START_SCALE, START_SCALE)
	r.BackgroundTransparency = 1

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.5, 0)
	corner.Parent = r

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = THICKNESS
	stroke.Transparency = 0
	stroke.Color = Color3.new(1, 1, 1)
	local gradient = rainbowGradient(hueRotation)
	gradient.Parent = stroke
	stroke.Parent = r

	r.Parent = gui

	local info = TweenInfo.new(RING_LIFE, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(r, info, { Size = UDim2.fromScale(1, 1) }):Play()
	TweenService:Create(gradient, info, { Rotation = hueRotation + 160 }):Play()
	local fade = TweenService:Create(stroke, info, { Transparency = 1 })
	fade:Play()
	fade.Completed:Once(function()
		r:Destroy()
	end)
end

function RebirthRingsFX.PlayAtPlayer(targetPlayer)
	targetPlayer = targetPlayer or player
	local character = targetPlayer.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end

	local gui = Instance.new("BillboardGui")
	gui.Name = "RebirthRingsFX"
	gui.Adornee = rootPart
	gui.Size = UDim2.new(MAX_DIAMETER, 0, MAX_DIAMETER, 0) -- UDim2 scale = studs on billboards
	gui.AlwaysOnTop = true
	gui.LightInfluence = 0
	gui.ClipsDescendants = false
	gui.Parent = rootPart

	task.spawn(function()
		local ringCount = math.floor(DURATION / RING_INTERVAL)
		for i = 0, ringCount - 1 do
			if not gui.Parent then return end
			-- step each ring's gradient around the hue wheel so the train shimmers
			spawnRing(gui, (i % 7) * (360 / 7))
			task.wait(RING_INTERVAL)
		end
	end)

	Debris:AddItem(gui, DURATION + RING_LIFE + 0.5)
end

return RebirthRingsFX
