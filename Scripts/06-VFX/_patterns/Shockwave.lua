--!strict
-- Pattern: Shockwave (ModuleScript, client recommended)
-- Credit: ideas from jujutsu-shenanigans (BarrageArms.createShockwave: grow + fade a ring part;
-- FXController.DomainBurst: sphere that grows to 75 studs while going transparent) and
-- smash-egg-for-animals (FightFilm.Fx.mesh: mesh that grows from size0 to size1 while fading).
--
-- What it does:
--   Shockwave.Ring(position, options)   flat expanding ring on the ground
--   Shockwave.Sphere(position, options) expanding see-through sphere (impact / domain burst)
--   Shockwave.Rocks(position, options)  circle of rocks that pop out of the ground, using the
--                                       ground's material and color (raycast), then sink back
--   Everything is built from plain parts; no assets needed.
--
-- Usage:
--   local Shockwave = require(path.to.Shockwave)
--   Shockwave.Ring(hitPos, { radius = 20, time = 0.4, color = Color3.new(1, 1, 1) })
--   Shockwave.Sphere(hitPos, { radius = 15, time = 0.3 })
--   Shockwave.Rocks(hitPos, { radius = 10, count = 12, size = 2.5, ignore = { character } })

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

export type Options = {
	radius: number?,
	time: number?,
	color: Color3?,
	material: Enum.Material?,
	count: number?,
	size: number?,
	ignore: { Instance }?,
	parent: Instance?,
}

local Shockwave = {}
local rng = Random.new()

local function basePart(parent: Instance): Part
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false
	p.Parent = parent
	return p
end

function Shockwave.Ring(position: Vector3, options: Options?)
	local opts: Options = options or {}
	local radius = opts.radius or 15
	local time = opts.time or 0.45
	local ring = basePart(opts.parent or workspace)
	ring.Shape = Enum.PartType.Cylinder
	ring.Material = opts.material or Enum.Material.Neon
	ring.Color = opts.color or Color3.new(1, 1, 1)
	ring.Transparency = 0.2
	ring.Size = Vector3.new(0.2, 1, 1)
	-- a Cylinder's round faces point along X, so roll it 90 degrees to lie flat
	ring.CFrame = CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90))

	local info = TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	TweenService:Create(ring, info, { Size = Vector3.new(0.05, radius * 2, radius * 2), Transparency = 1 }):Play()
	Debris:AddItem(ring, time + 0.1)
end

function Shockwave.Sphere(position: Vector3, options: Options?)
	local opts: Options = options or {}
	local radius = opts.radius or 12
	local time = opts.time or 0.35
	local ball = basePart(opts.parent or workspace)
	ball.Shape = Enum.PartType.Ball
	ball.Material = opts.material or Enum.Material.ForceField
	ball.Color = opts.color or Color3.fromRGB(200, 220, 255)
	ball.Transparency = 0
	ball.Size = Vector3.one
	ball.Position = position

	local info = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(ball, info, { Size = Vector3.one * radius * 2, Transparency = 1 }):Play()
	Debris:AddItem(ball, time + 0.1)
end

function Shockwave.Rocks(position: Vector3, options: Options?)
	local opts: Options = options or {}
	local radius = opts.radius or 8
	local count = opts.count or 10
	local size = opts.size or 2
	local stay = opts.time or 1.5

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = opts.ignore or {}

	local folder = Instance.new("Folder")
	folder.Name = "ShockwaveRocks"
	folder.Parent = opts.parent or workspace
	params:AddToFilter(folder)

	for i = 1, count do
		local angle = (i / count) * math.pi * 2
		local flat = Vector3.new(math.cos(angle), 0, math.sin(angle)) * radius
		local origin = position + flat + Vector3.new(0, 5, 0)
		local hit = workspace:Raycast(origin, Vector3.new(0, -15, 0), params)
		if hit then
			local rock = basePart(folder)
			local s = size * rng:NextNumber(0.7, 1.3)
			rock.Size = Vector3.new(s, s, s)
			rock.Material = hit.Material
			rock.Color = hit.Instance.Color
			-- tilt the rock away from the center so it looks like the ground cracked outwards
			local outward = CFrame.lookAt(hit.Position, hit.Position + flat) * CFrame.Angles(math.rad(-35), 0, 0)
			local up = outward * CFrame.Angles(rng:NextNumber(-0.4, 0.4), rng:NextNumber(-0.4, 0.4), rng:NextNumber(-0.4, 0.4))
			rock.CFrame = up - Vector3.new(0, s, 0) -- start buried
			TweenService:Create(rock, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { CFrame = up + Vector3.new(0, s * 0.25, 0) }):Play()
			task.delay(stay, function()
				TweenService:Create(rock, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					CFrame = up - Vector3.new(0, s * 1.2, 0),
					Size = rock.Size * 0.4,
				}):Play()
			end)
		end
	end
	Debris:AddItem(folder, stay + 0.7)
end

return Shockwave
