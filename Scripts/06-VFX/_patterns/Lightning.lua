--!strict
-- Pattern: Lightning (ModuleScript, client recommended)
-- Credit: the idea of "neon parts that fade out over a few frames" is from natural-disaster
-- (LightningScript by Stickmasterluke); the cloned-template + Debris cleanup style follows
-- jujutsu-shenanigans (Reversal Red / LimbTrail) and the per-limb crackle from murder-mystery-2
-- (LightningDeathModule).
--
-- What it does:
--   Draws a jagged lightning bolt between two points out of thin neon parts, with optional side
--   branches and a point light flash, then fades and deletes it. No assets needed.
--
-- Usage:
--   local Lightning = require(path.to.Lightning)
--   Lightning.Strike(skyPosition, groundPosition)                                  -- defaults
--   Lightning.Strike(handPos, enemyPos, { color = Color3.fromRGB(120, 200, 255), segments = 10,
--       jitter = 1.5, thickness = 0.25, branches = 3, lifetime = 0.25, flicker = 2 })
--   Lightning.Arc(partA, partB, 1.0)   -- keeps re-drawing a crackling arc between two parts for 1 second

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

export type Options = {
	color: Color3?,
	segments: number?,
	jitter: number?, -- max sideways offset of each joint, in studs
	thickness: number?,
	branches: number?,
	lifetime: number?, -- seconds the bolt stays fully visible before fading
	flicker: number?, -- how many times to redraw a new random shape during lifetime
	light: boolean?,
	parent: Instance?,
}

local Lightning = {}

local rng = Random.new()

local function makeSegment(a: Vector3, b: Vector3, thickness: number, color: Color3, parent: Instance): Part
	local length = (b - a).Magnitude
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false
	p.Material = Enum.Material.Neon
	p.Color = color
	p.Size = Vector3.new(thickness, thickness, length)
	p.CFrame = CFrame.lookAt((a + b) / 2, b)
	p.Parent = parent
	return p
end

-- Returns the joint positions of a jagged line from a to b.
local function jaggedPoints(a: Vector3, b: Vector3, segments: number, jitter: number): { Vector3 }
	local points = { a }
	local dir = b - a
	local cf = CFrame.lookAt(a, b)
	for i = 1, segments - 1 do
		local t = i / segments
		-- less jitter near the ends so the bolt connects cleanly
		local falloff = math.sin(t * math.pi)
		local offset = cf.RightVector * rng:NextNumber(-jitter, jitter) * falloff
			+ cf.UpVector * rng:NextNumber(-jitter, jitter) * falloff
		table.insert(points, a + dir * t + offset)
	end
	table.insert(points, b)
	return points
end

local function drawBolt(a: Vector3, b: Vector3, opts: Options, folder: Instance)
	local segments = opts.segments or 8
	local jitter = opts.jitter or ((b - a).Magnitude / 12)
	local thickness = opts.thickness or 0.3
	local color = opts.color or Color3.fromRGB(170, 210, 255)

	local points = jaggedPoints(a, b, segments, jitter)
	for i = 1, #points - 1 do
		makeSegment(points[i], points[i + 1], thickness, color, folder)
	end

	for _ = 1, opts.branches or 2 do
		local startIndex = rng:NextInteger(2, math.max(2, #points - 1))
		local start = points[startIndex]
		local mainDir = (b - a).Unit
		local side = (mainDir + rng:NextUnitVector() * 0.9).Unit
		local branchEnd = start + side * (b - a).Magnitude * rng:NextNumber(0.15, 0.3)
		local branchPoints = jaggedPoints(start, branchEnd, math.max(2, math.floor(segments / 2)), jitter * 0.6)
		for i = 1, #branchPoints - 1 do
			makeSegment(branchPoints[i], branchPoints[i + 1], thickness * 0.55, color, folder)
		end
	end
end

local function fadeAndDestroy(folder: Instance, time: number)
	for _, p in folder:GetDescendants() do
		if p:IsA("BasePart") then
			TweenService:Create(p, TweenInfo.new(time), { Transparency = 1 }):Play()
		elseif p:IsA("PointLight") then
			TweenService:Create(p, TweenInfo.new(time), { Brightness = 0 }):Play()
		end
	end
	Debris:AddItem(folder, time + 0.05)
end

function Lightning.Strike(a: Vector3, b: Vector3, options: Options?)
	local opts: Options = options or {}
	local folder = Instance.new("Folder")
	folder.Name = "LightningBolt"
	folder.Parent = opts.parent or workspace

	local lifetime = opts.lifetime or 0.2
	local flicker = math.max(1, opts.flicker or 1)

	if opts.light ~= false then
		local holder = Instance.new("Part")
		holder.Transparency = 1
		holder.Anchored = true
		holder.CanCollide = false
		holder.CanQuery = false
		holder.Size = Vector3.one * 0.1
		holder.Position = b
		holder.Parent = folder
		local light = Instance.new("PointLight")
		light.Color = opts.color or Color3.fromRGB(170, 210, 255)
		light.Range = 30
		light.Brightness = 6
		light.Parent = holder
	end

	task.spawn(function()
		local boltFolder = Instance.new("Folder")
		boltFolder.Parent = folder
		for i = 1, flicker do
			boltFolder:ClearAllChildren()
			drawBolt(a, b, opts, boltFolder)
			task.wait(lifetime / flicker)
		end
		fadeAndDestroy(folder, 0.15)
	end)
end

-- Repeatedly redraws a thin arc between two parts (electric tether / chain lightning).
function Lightning.Arc(partA: BasePart, partB: BasePart, duration: number, options: Options?)
	local opts: Options = table.clone(options or {})
	opts.light = false
	opts.branches = opts.branches or 0
	opts.thickness = opts.thickness or 0.15
	task.spawn(function()
		local stopAt = os.clock() + duration
		while os.clock() < stopAt and partA.Parent and partB.Parent do
			Lightning.Strike(partA.Position, partB.Position, { color = opts.color, segments = opts.segments, jitter = opts.jitter,
				thickness = opts.thickness, branches = opts.branches, lifetime = 0.06, light = false, parent = opts.parent })
			task.wait(0.07)
		end
	end)
end

return Lightning
