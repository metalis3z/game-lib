-- Projectiles fired by guns (RPG, Bow, Grenade Launcher, Paintball Gun, Daggers, Flare Gun,
-- Scepter, Slingshot, Freeze Ray...), simulated on the server.
--
-- Each one is an invisible anchored part the server moves every frame; the item tells clients
-- about it with ("ProjectileEffect", part, settings?) and Gun._ProjectileEffect draws the
-- projectile's model (Assets.Projectiles) over it, oriented by the part's velocity.
--
-- Every step sweeps the path with a sphere of ProjectileRaycastRadius against the environment's
-- geometry and the hitboxes of valid targets (GameplayUtility.GetRaycastWhitelist):
--   a target  -> direct damage (CriticalDamage on a head hitbox), up to ProjectileMaxHits
--   the world -> the projectile stops
-- Where it stops (or when ProjectileLifetime runs out) it explodes when it has an explosion
-- radius, and a projectile with an explosion radius explodes on the first target instead of
-- dealing direct damage. ProjectileLogicDisabled ones (Flare Gun) stay where they land and
-- burn what is around them.

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameplayUtility = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GameplayUtility"))

-- How often a projectile refreshes the list of what it can hit.
local WHITELIST_REFRESH = 0.25
local MAX_BURN_SECONDS = 5

local Projectiles = {}

-- Set by ItemService: damage(player, fighter, entity, amount, critical, position) and
-- explode(player, fighter, position, radius, damage).
local context = nil

function Projectiles.Init(newContext)
	context = newContext
end

local active = {}

local function setting(projectile, name: string)
	local overrides = projectile.overrides
	if overrides and overrides[name] ~= nil then
		return overrides[name]
	end
	return projectile.info[name]
end

-- worldHit: the RaycastResult when it stopped against the world (not a target, not timing out).
local function finish(projectile, position: Vector3?, worldHit: RaycastResult?)
	if projectile.done then
		return
	end
	projectile.done = true
	if projectile.onStop then
		local ok, err = pcall(projectile.onStop, position, worldHit, projectile.velocity)
		if not ok then
			warn("[Projectiles] onStop: " .. tostring(err))
		end
	end

	local radius = setting(projectile, "ShootExplosionRadius") or 0
	if position and radius > 0 then
		if setting(projectile, "ProjectileLogicDisabled") then
			-- Burns where it landed (Flare Gun).
			projectile.part.Anchored = true
			projectile.part.CFrame = CFrame.new(position)
			local perSecond = setting(projectile, "DamagePerSecond") or 0
			local ticks = math.max(setting(projectile, "DamageTicksPerSecond") or 1, 1)
			local duration = math.min(setting(projectile, "ProjectileLifetime") or MAX_BURN_SECONDS, MAX_BURN_SECONDS)
			context.explode(projectile.player, projectile.fighter, position, radius, setting(projectile, "AfterburnDamage") or 0)
			task.spawn(function()
				local stop = os.clock() + duration
				while os.clock() < stop and projectile.part.Parent do
					task.wait(1 / ticks)
					context.explode(projectile.player, projectile.fighter, position, radius, perSecond / ticks, true)
				end
				projectile.part:Destroy()
			end)
			return
		end
		context.explode(projectile.player, projectile.fighter, position, radius, setting(projectile, "ShootExplosionDamage") or setting(projectile, "ShootDamage") or 0)
	end
	projectile.part:Destroy()
end

local function whitelist(projectile)
	local now = os.clock()
	if not projectile.list or now >= projectile.nextRefresh then
		projectile.nextRefresh = now + WHITELIST_REFRESH
		local list, byHitbox = GameplayUtility:GetRaycastWhitelist(projectile.environmentID, projectile.params, projectile.alreadyHit)
		projectile.list = list
		projectile.byHitbox = byHitbox or {}
		projectile.raycastParams.FilterDescendantsInstances = list
	end
	return projectile.raycastParams
end

local function step(projectile, dt: number)
	local gravity = Vector3.new(0, -workspace.Gravity * (setting(projectile, "ProjectileGravity") or 0), 0)
	local velocity = projectile.velocity + gravity * dt
	local from = projectile.position
	local travel = (projectile.velocity + velocity) * 0.5 * dt
	projectile.velocity = velocity

	local params = whitelist(projectile)
	local radius = setting(projectile, "ProjectileRaycastRadius") or 0
	local result
	if travel.Magnitude > 0 then
		result = radius > 0 and workspace:Spherecast(from, radius, travel, params) or workspace:Raycast(from, travel, params)
	end

	if result then
		local entity = projectile.byHitbox[result.Instance]
		if not entity then
			finish(projectile, result.Position, result)
			return
		end

		if (setting(projectile, "ShootExplosionRadius") or 0) > 0 then
			finish(projectile, result.Position)
			return
		end

		local critical = string.find(result.Instance.Name, "Head") ~= nil
		local damage = critical and setting(projectile, "CriticalDamage") or setting(projectile, "ShootDamage") or 0
		context.damage(projectile.player, projectile.fighter, entity, damage, critical, result.Position)
		projectile.alreadyHit[entity] = true
		projectile.list = nil
		projectile.hits += 1
		if projectile.hits >= (setting(projectile, "ProjectileMaxHits") or 1) then
			finish(projectile, nil)
			return
		end
		projectile.position = result.Position
	else
		projectile.position = from + travel
	end

	local part = projectile.part
	part.CFrame = velocity.Magnitude > 0.01 and CFrame.lookAt(projectile.position, projectile.position + velocity) or CFrame.new(projectile.position)
	part.AssemblyLinearVelocity = velocity
end

RunService.Heartbeat:Connect(function(dt: number)
	local now = os.clock()
	for projectile in active do
		if projectile.done or not projectile.part.Parent then
			active[projectile] = nil
		elseif now >= projectile.expires then
			active[projectile] = nil
			finish(projectile, projectile.position)
		else
			local ok, err = pcall(step, projectile, dt)
			if not ok then
				warn("[Projectiles] " .. tostring(err))
				active[projectile] = nil
				finish(projectile, nil)
			end
			if projectile.done then
				active[projectile] = nil
			end
		end
	end
end)

-- Fire(args): { player, fighter, item, info, params (EntityLookupParams), environmentID,
--   origin (CFrame: where the shot comes from, the head), target (Vector3), overrides?,
--   onStop?(position, worldHit, velocity) }   onStop runs once when it stops, before it is removed
function Projectiles.Fire(args)
	local info = args.info
	local overrides = args.overrides
	local projectile = {
		player = args.player,
		fighter = args.fighter,
		info = info,
		overrides = overrides,
		params = args.params,
		environmentID = args.environmentID,
		onStop = args.onStop,
		alreadyHit = {},
		hits = 0,
		nextRefresh = 0,
		raycastParams = RaycastParams.new(),
	}
	projectile.raycastParams.FilterType = Enum.RaycastFilterType.Include

	-- It leaves from the muzzle side of the camera, unless that point is behind a wall.
	local origin = args.origin
	local spawnOffset = setting(projectile, "ProjectileSpawnOffset") or CFrame.identity
	local spawnPosition = (origin * spawnOffset).Position
	if setting(projectile, "ProjectileWallClipPreventionEnabled") ~= false then
		local params = whitelist(projectile)
		if workspace:Raycast(origin.Position, spawnPosition - origin.Position, params) then
			spawnPosition = origin.Position
		end
	end

	local direction = args.target - spawnPosition
	direction = direction.Magnitude > 0.01 and direction.Unit or origin.LookVector
	projectile.position = spawnPosition
	projectile.velocity = direction * (setting(projectile, "ProjectileSpeed") or 100)
	projectile.expires = os.clock() + (setting(projectile, "ProjectileLifetime") or 5)

	local part = Instance.new("Part")
	part.Name = "Projectile"
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Transparency = 1
	part.Size = Vector3.one * math.max((setting(projectile, "ProjectileRaycastRadius") or 0.5) * 2, 0.2)
	part.CFrame = CFrame.lookAt(spawnPosition, spawnPosition + direction)
	part.Parent = workspace
	projectile.part = part

	args.item.ReplicateToClient:Fire("ProjectileEffect", part, overrides)
	active[projectile] = true
	return projectile
end

return Projectiles
