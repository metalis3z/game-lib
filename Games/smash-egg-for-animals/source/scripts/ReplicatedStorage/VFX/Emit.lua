-- ROPILOT_VFX_EMIT 2
-- Emit: plays the visual effects in ReplicatedStorage.VFX.
-- Ported from Roqer (S4US), used with the author's permission.
--
-- Installed by Ropilot (ropilot_vfx_capture installs and updates it). Edit it
-- freely: once its source differs from what Ropilot installed, Ropilot leaves
-- it alone.
--
-- Effects are instances with attributes, the convention the popular VFX
-- editors share, so an artist can open and tune what the agent builds.
-- Require it from client code; effects are presentation.
--
--   local Emit = require(game.ReplicatedStorage.VFX.Emit)
--   local handle = Emit.play("Slam", hitCFrame)     -- a name in ReplicatedStorage.VFX, or a Model or part
--   handle:freeze(0.06)                              -- hitstop
--   Emit.emit(sword.Blade)                           -- an effect already in place (a weapon, an aura)
--   Emit.play("Aura", nil, { follow = character.HumanoidRootPart })
--
-- Attributes it reads:
--   ParticleEmitter  EmitDelay, EmitCount (a burst, at most 500),
--                    EmitDuration (emit at Rate for that long)
--   Beam, Trail      EmitDelay, EmitDuration (enabled for that long)
--   PointLight, SpotLight, SurfaceLight
--                    EmitDelay, EmitDuration (on, then Brightness fades to 0
--                    over it, Quad Out)
--   Mesh motion      a Model or Folder holding BaseParts named Start and End.
--                    Start is shown and moves to End's CFrame, Size, Transparency
--                    and Color (and a SpecialMesh's Scale) over Duration seconds;
--                    Decals on Start fade to the Transparency of End's same-named
--                    Decal. End only carries the target values; it is never shown.
--                    Container attributes: EmitDelay, Duration (0.4), Easing ("Quad"),
--                    EasingDirection ("Out"), Spin (degrees about Start's up axis).
--   The effect root  EffectDuration overrides when the effect ends, for an
--                    effect whose emitters run on their own without attributes.
--
-- Anything without these attributes is left alone: an Enabled emitter with no
-- EmitCount or EmitDuration keeps emitting on its own, and is not slowed or
-- frozen with the rest.
--
-- EmitDelay is absolute, counted from the effect's start; editors that set a
-- delay on a group write it onto every descendant, so delays are not summed.
-- An effect lasts at most 30 seconds. Problems are reported with warn(),
-- prefixed "VFXEmit:".
--
-- One clock drives everything, scaled by the handle's time scale, which also
-- multiplies every emitter's own TimeScale, scales every beam's TextureSpeed and
-- stretches every trail's Lifetime: setTimeScale(0.1) is slow motion and
-- freeze(seconds) is hitstop for particles, trails and meshes alike.
--
-- Emit.play(effect, at?, options?) -> handle
--   Plays a copy of effect (a Model, a BasePart, or the name of one in
--   ReplicatedStorage.VFX) at `at` (a CFrame, Vector3, BasePart, Attachment or
--   Model) and destroys the copy when it ends. Its parts are anchored and never
--   collide, cast shadows or answer raycasts.
--   options: parent (default workspace), timeScale (0 to 1; speed is the same),
--   onDone (called when it ends), follow (a part, attachment or model the effect
--   stays on, instead of at), offset (a CFrame from follow).
-- Emit.emit(root, options?) -> handle
--   Plays the effects under root where they already are and restores everything
--   it changed when it ends. Emitting a root that is still playing stops the
--   earlier play first (retrying its cleanup if an earlier stop() failed); if
--   that cleanup still fails, emit errors with the failed steps instead of
--   playing from a half-restored state. options: timeScale (or speed), onDone, parent (where
--   effects added with handle:add go; default workspace).
-- Emit.duration(effect)          seconds the effect lasts
-- Emit.check(effect)             a list of problems, one line each (empty when none)
-- Emit.preload(effect, timeout?) loads its textures and meshes so the first play
--                                isn't blank; yields at most timeout seconds
--                                (default 10) and returns whether loading finished
--
-- A handle has root (model is the same), time, finished and duration, and:
--   handle:setTimeScale(s)   1 normal, 0.1 slow motion, 0 paused (0 to 1); does
--                            nothing once finished, and cancels a freeze
--   handle:freeze(seconds)   hitstop: pause for that many real seconds, then go on
--   handle:stop()            end it now; returns true once its cleanup (destroying
--                            the copy, or restoring what emit changed) is done.
--                            If a step fails, the rest still run and it returns
--                            false and a list of the failed steps (and warns);
--                            call it again to retry just those. A step for an
--                            instance that is gone from the place counts as done
--   handle:getTime(), handle:getSpeed(), handle:setSpeed(s) (= setTimeScale), handle:isDone()
--   handle:onDone(fn)
--   handle:onStep(fn)        fn(time, dt) every frame, on the effect's clock
--   handle:add(effect, at?, delay?)   play another effect on this one's clock,
--                            delay seconds in; this handle isn't done until it is

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")

local Emit = {}
Emit.VERSION = 2

local MAX_EMIT_COUNT = 500
local MAX_EFFECT_SECONDS = 30
local DEFAULT_MESH_SECONDS = 0.4
local MAX_TRAIL_LIFETIME = 20
local DEFAULT_PRELOAD_SECONDS = 10
local PREVIEW_TEXTURE_PREFIX = "rbxasset://textures/ropilot/"
-- Attributes of Emit 1, which animated each part on its own.
local OLD_PART_ATTRIBUTES = { "Lifetime", "SizeEnd", "TransparencyEnd", "SpinEnd", "OffsetEnd" }
local NUMBER_ATTRIBUTES = { "EmitDelay", "EmitCount", "EmitDuration", "Duration", "Spin", "EffectDuration" }

-- Effects played in place, so emitting one again stops the earlier play.
local playingInPlace = setmetatable({}, { __mode = "k" })

local function numberAttribute(instance, name, default, loud)
	local value = instance:GetAttribute(name)
	if typeof(value) == "number" and value == value then
		return value
	end
	if value ~= nil and loud then
		warn(`VFXEmit: {instance:GetFullName()}.{name} should be a number, got {typeof(value)}`)
	end
	return default
end

local function enumAttribute(instance, name, enumType, default, loud)
	local value = instance:GetAttribute(name)
	if value == nil then
		return default
	end
	local ok, item = pcall(function()
		return (enumType :: any)[value]
	end)
	if ok and item then
		return item
	end
	if loud then
		warn(`VFXEmit: {instance:GetFullName()}.{name} is not a valid {tostring(enumType)} name: {tostring(value)}`)
	end
	return default
end

local function isLight(instance)
	return instance:IsA("PointLight") or instance:IsA("SpotLight") or instance:IsA("SurfaceLight")
end

local function everything(root)
	local list = root:GetDescendants()
	table.insert(list, root)
	return list
end

-- Start and End of a mesh motion container, when it is one.
local function meshPair(container)
	if not (container:IsA("Model") or container:IsA("Folder")) then
		return nil
	end
	local start = container:FindFirstChild("Start")
	local finish = container:FindFirstChild("End")
	if start and finish and start:IsA("BasePart") and finish:IsA("BasePart") then
		return start, finish
	end
	return nil
end

local function vfxFolder()
	return script.Parent or ReplicatedStorage:FindFirstChild("VFX")
end

local function resolve(effect, level)
	if typeof(effect) == "Instance" then
		return effect
	end
	if type(effect) == "string" then
		local folder = vfxFolder()
		local found = folder and folder:FindFirstChild(effect)
		if found then
			return found
		end
		error(("Emit: no effect named %q in %s"):format(effect, folder and folder:GetFullName() or "ReplicatedStorage.VFX"), level or 3)
	end
	error("Emit: the effect must be a template or its name", level or 3)
end

local function toCFrame(at, level)
	local kind = typeof(at)
	if kind == "CFrame" then
		return at
	elseif kind == "Vector3" then
		return CFrame.new(at)
	elseif kind == "Instance" then
		if at:IsA("Attachment") then
			return at.WorldCFrame
		elseif at:IsA("BasePart") then
			return at.CFrame
		elseif at:IsA("Model") then
			return at:GetPivot()
		end
	end
	error("Emit: play it at a CFrame, Vector3, part, attachment or model", level or 3)
end

-- Moves an effect copy to `cframe`. A part's own parts move with it.
local function place(root, cframe)
	if root:IsA("Model") then
		root:PivotTo(cframe)
		return
	end
	local pivot = root.CFrame
	for _, instance in root:GetDescendants() do
		if instance:IsA("BasePart") then
			instance.CFrame = cframe * pivot:ToObjectSpace(instance.CFrame)
		end
	end
	root.CFrame = cframe
end

-- What everything under root does, read from its attributes without changing
-- anything. `scheduled` is when the last switch or motion happens; `tail` also
-- waits for the last particle and trail to fade.
local function timeline(root, loud)
	local entries, meshes = {}, {}
	local scheduled, tail = 0, 0
	local function mark(at, lingers)
		scheduled = math.max(scheduled, at)
		tail = math.max(tail, at + (lingers or 0))
	end
	for _, instance in everything(root) do
		if instance:IsA("ParticleEmitter") then
			local delay = math.max(numberAttribute(instance, "EmitDelay", 0, loud), 0)
			local count = numberAttribute(instance, "EmitCount", nil, loud)
			local on = numberAttribute(instance, "EmitDuration", nil, loud)
			if count ~= nil or on ~= nil then
				-- A particle lives Lifetime seconds of its emitter's own TimeScale.
				local lifetime = instance.Lifetime.Max / math.max(instance.TimeScale, 0.05)
				if count ~= nil then
					local bounded = math.clamp(math.floor(count), 0, MAX_EMIT_COUNT)
					if bounded ~= count and loud then
						warn(`VFXEmit: {instance:GetFullName()} EmitCount {count} was bounded to {bounded}`)
					end
					count = bounded
					mark(delay, lifetime)
				end
				if on ~= nil then
					on = math.max(on, 0)
					mark(delay + on, lifetime)
				end
				table.insert(entries, { kind = "emitter", instance = instance, delay = delay, count = count, on = on })
			end
		elseif instance:IsA("Beam") or instance:IsA("Trail") then
			local delay = math.max(numberAttribute(instance, "EmitDelay", 0, loud), 0)
			local on = numberAttribute(instance, "EmitDuration", nil, loud)
			if on ~= nil then
				on = math.max(on, 0)
				mark(delay + on, if instance:IsA("Trail") then instance.Lifetime else 0)
				table.insert(entries, { kind = "ribbon", instance = instance, delay = delay, on = on })
			end
		elseif isLight(instance) then
			local delay = math.max(numberAttribute(instance, "EmitDelay", 0, loud), 0)
			local on = numberAttribute(instance, "EmitDuration", nil, loud)
			if on ~= nil then
				on = math.max(on, 0)
				mark(delay + on)
				table.insert(entries, { kind = "light", instance = instance, delay = delay, on = on })
			end
		else
			local start, finish = meshPair(instance)
			if start then
				local delay = math.max(numberAttribute(instance, "EmitDelay", 0, loud), 0)
				local duration = math.max(numberAttribute(instance, "Duration", DEFAULT_MESH_SECONDS, loud), 0)
				mark(delay + duration)
				table.insert(meshes, {
					kind = "mesh",
					instance = instance,
					start = start,
					finish = finish,
					delay = delay,
					duration = duration,
					style = enumAttribute(instance, "Easing", Enum.EasingStyle, Enum.EasingStyle.Quad, loud),
					direction = enumAttribute(instance, "EasingDirection", Enum.EasingDirection, Enum.EasingDirection.Out, loud),
					spin = math.rad(numberAttribute(instance, "Spin", 0, loud)),
				})
			end
		end
	end
	-- Meshes last, so End is read before anything else could change it.
	for _, mesh in meshes do
		table.insert(entries, mesh)
	end
	return entries, scheduled, tail
end

-- Seconds the effect lasts: EffectDuration (but not before its last switch or
-- motion), else when its last particle fades; at most 30.
local function effectLength(root, scheduled, tail, loud)
	local override = numberAttribute(root, "EffectDuration", nil, loud)
	local length = if override ~= nil then math.max(override, scheduled) else tail
	return math.clamp(length, 0, MAX_EFFECT_SECONDS), override
end

--- Seconds the effect lasts.
function Emit.duration(effect)
	local root = resolve(effect)
	local _, scheduled, tail = timeline(root, false)
	return (effectLength(root, scheduled, tail, false))
end

local function relativeName(root, instance)
	if instance == root then
		return root.Name
	end
	local names = {}
	local node = instance
	while node and node ~= root do
		table.insert(names, 1, node.Name)
		node = node.Parent
	end
	return table.concat(names, ".")
end

local function textureOf(instance)
	if instance:IsA("ParticleEmitter") or instance:IsA("Beam") or instance:IsA("Trail") or instance:IsA("Decal") then
		return instance.Texture
	elseif instance:IsA("MeshPart") then
		return instance.TextureID
	end
	return nil
end

--- Problems that make an effect play wrong, one line each (empty when none).
function Emit.check(effect)
	local root = resolve(effect)
	local problems = {}
	local function add(instance, text)
		table.insert(problems, relativeName(root, instance) .. ": " .. text)
	end
	local previews = 0
	for _, instance in everything(root) do
		for _, name in NUMBER_ATTRIBUTES do
			local value = instance:GetAttribute(name)
			if value ~= nil and (typeof(value) ~= "number" or value ~= value) then
				add(instance, name .. " must be a number, not a " .. typeof(value))
			end
		end
		for _, pair in { { "Easing", Enum.EasingStyle }, { "EasingDirection", Enum.EasingDirection } } do
			local value = instance:GetAttribute(pair[1])
			if value ~= nil and enumAttribute(instance, pair[1], pair[2], nil, false) == nil then
				add(instance, ("%s %s is not an Enum.%s name"):format(pair[1], tostring(value), pair[1] == "Easing" and "EasingStyle" or "EasingDirection"))
			end
		end
		if instance:IsA("BasePart") then
			for _, name in OLD_PART_ATTRIBUTES do
				if instance:GetAttribute(name) ~= nil then
					add(instance, name .. " is no longer read; animate a mesh with a Start/End pair in a Model or Folder")
				end
			end
		end
		local count = numberAttribute(instance, "EmitCount", nil, false)
		if count and count > MAX_EMIT_COUNT then
			add(instance, ("EmitCount %d is capped at %d"):format(count, MAX_EMIT_COUNT))
		end
		if numberAttribute(instance, "EmitDelay", 0, false) > MAX_EFFECT_SECONDS or numberAttribute(instance, "EmitDuration", 0, false) > MAX_EFFECT_SECONDS then
			add(instance, ("timings past %d seconds are cut off: an effect lasts at most %d seconds"):format(MAX_EFFECT_SECONDS, MAX_EFFECT_SECONDS))
		end
		local texture = textureOf(instance)
		if type(texture) == "string" and texture:sub(1, #PREVIEW_TEXTURE_PREFIX) == PREVIEW_TEXTURE_PREFIX then
			previews += 1
		end
		local on = numberAttribute(instance, "EmitDuration", nil, false)
		if instance:IsA("ParticleEmitter") then
			if count == nil and on == nil then
				if instance.Enabled and instance.Rate > 0 then
					add(instance, "has no EmitCount or EmitDuration, so it runs on its own, not slowed or frozen with the effect (fine for an aura; give the effect an EffectDuration)")
				else
					add(instance, "has no EmitCount or EmitDuration and isn't emitting, so it never emits")
				end
			elseif not (count and count >= 1) and not (on and on > 0) then
				add(instance, "EmitCount and EmitDuration are 0, so it never emits")
			end
			if instance.Orientation == Enum.ParticleOrientation.VelocityPerpendicular and instance.Speed.Max <= 0 then
				add(instance, "is VelocityPerpendicular with Speed 0, which doesn't draw; set Speed to 0.001")
			end
			if instance.Texture == "" then
				add(instance, "has no Texture")
			end
		elseif instance:IsA("Beam") or instance:IsA("Trail") or isLight(instance) then
			if on == nil and instance:GetAttribute("EmitDelay") ~= nil then
				add(instance, "has EmitDelay but no EmitDuration, so Emit leaves it as it is")
			end
			if not isLight(instance) and (not instance.Attachment0 or not instance.Attachment1) then
				add(instance, "needs both Attachment0 and Attachment1")
			end
		end
		local start, finish = instance:FindFirstChild("Start"), instance:FindFirstChild("End")
		if instance:IsA("Model") or instance:IsA("Folder") then
			if start and finish and not (start:IsA("BasePart") and finish:IsA("BasePart")) then
				add(instance, ("Start and End must both be BaseParts, not a %s and a %s"):format(start.ClassName, finish.ClassName))
			elseif (start or finish) and not (start and finish) then
				add(instance, if start then "has a Start but no End, so nothing moves" else "has an End but no Start, so nothing moves")
			end
		elseif start and finish and start:IsA("BasePart") and finish:IsA("BasePart") then
			add(instance, "holds Start and End, but only a Model or Folder moves them; put them in one")
		end
	end
	if root:GetAttribute("Duration") ~= nil and meshPair(root) == nil then
		add(root, "Duration only times a Start/End motion; use EffectDuration for how long the effect lasts")
	end
	if previews > 0 then
		table.insert(problems, ("%d texture(s) are local previews (rbxasset://textures/ropilot/...), which only show in Studio on this computer: upload them and swap in the asset ids before publishing"):format(previews))
	end
	if Emit.duration(root) <= 0 then
		table.insert(problems, "nothing in it has EmitCount, EmitDuration, a Start/End pair or EffectDuration, so it ends as soon as it starts")
	end
	return problems
end

--- Loads the effect's textures and meshes, so its first play isn't blank.
--- Yields at most `timeout` seconds (default 10); returns whether loading
--- finished.
function Emit.preload(effect, timeout)
	local root = resolve(effect)
	local seconds = tonumber(timeout) or DEFAULT_PRELOAD_SECONDS
	local loaded = false
	task.spawn(function()
		pcall(ContentProvider.PreloadAsync, ContentProvider, { root })
		loaded = true
	end)
	local deadline = os.clock() + seconds
	while not loaded and os.clock() < deadline do
		task.wait()
	end
	return loaded
end

local Handle = {}
Handle.__index = Handle

-- Places and starts a copy of an effect without driving it; set further down.
local startCopy

-- Schedules `run` at effect time `at`.
function Handle:_at(at, run)
	table.insert(self._events, { at = at, run = run })
end

-- Runs `step(alpha)` every frame from `from` for `seconds` of effect time.
function Handle:_over(from, seconds, step)
	table.insert(self._tracks, { from = from, seconds = math.max(seconds, 1e-3), step = step })
end

function Handle:_emitter(entry)
	local emitter = entry.instance
	-- An emitter's own TimeScale (lingering smoke at 0.7, say) is part of the
	-- design; the handle's time scale multiplies it rather than replacing it.
	local authored = emitter.TimeScale
	self._timeScales[emitter] = authored
	self._restore[emitter] = { Enabled = emitter.Enabled, TimeScale = authored }
	emitter.Enabled = false
	if entry.count ~= nil then
		self:_at(entry.delay, function()
			emitter:Emit(entry.count)
		end)
	end
	if entry.on ~= nil then
		self:_at(entry.delay, function()
			emitter.Enabled = true
		end)
		self:_at(entry.delay + entry.on, function()
			emitter.Enabled = false
		end)
	end
end

function Handle:_ribbon(entry)
	local ribbon = entry.instance
	local restore = { Enabled = ribbon.Enabled }
	self._restore[ribbon] = restore
	ribbon.Enabled = false
	self:_at(entry.delay, function()
		ribbon.Enabled = true
	end)
	self:_at(entry.delay + entry.on, function()
		ribbon.Enabled = false
	end)
	if ribbon:IsA("Trail") then
		-- A trail fades in real time; its lifetime follows the time scale instead.
		restore.Lifetime = ribbon.Lifetime
		table.insert(self._trails, { trail = ribbon, lifetime = ribbon.Lifetime })
	else
		restore.TextureSpeed = ribbon.TextureSpeed
		self._beams[ribbon] = ribbon.TextureSpeed
	end
end

function Handle:_light(entry)
	local light = entry.instance
	local brightness = light.Brightness
	self._restore[light] = { Enabled = light.Enabled, Brightness = brightness }
	light.Enabled = false
	self:_at(entry.delay, function()
		light.Enabled = true
	end)
	self:_over(entry.delay, entry.on, function(alpha)
		light.Brightness = brightness * (1 - TweenService:GetValue(alpha, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
	end)
	self:_at(entry.delay + entry.on, function()
		light.Enabled = false
	end)
end

function Handle:_mesh(entry)
	local start, finish = entry.start, entry.finish
	local from = { CFrame = start.CFrame, Size = start.Size, Transparency = start.Transparency, Color = start.Color }
	local to = { CFrame = finish.CFrame, Size = finish.Size, Transparency = finish.Transparency, Color = finish.Color }
	-- Relative to where the effect was placed, so a followed effect carries it.
	local fromRelative = self._origin:ToObjectSpace(from.CFrame)
	local toRelative = self._origin:ToObjectSpace(to.CFrame)
	local startMesh = start:FindFirstChildOfClass("SpecialMesh")
	local finishMesh = finish:FindFirstChildOfClass("SpecialMesh")
	local startScale = startMesh and startMesh.Scale
	local finishScale = finishMesh and finishMesh.Scale
	if startMesh then
		self._restore[startMesh] = { Scale = startScale }
	end
	-- Decals on Start fade to the Transparency of End's decal of the same name.
	-- A Decal is how a mesh shows a texture that fades: TextureID ignores alpha.
	local decals = {}
	for _, child in start:GetChildren() do
		if child:IsA("Decal") then
			local target = finish:FindFirstChild(child.Name)
			local goal = if target and target:IsA("Decal") then target.Transparency else child.Transparency
			table.insert(decals, { decal = child, from = child.Transparency, to = goal })
			self._restore[child] = { Transparency = child.Transparency }
			child.Transparency = 1
		end
	end
	-- End only carries the target values; it is never shown.
	if self._owned then
		finish:Destroy()
	else
		self._restore[finish] = { Transparency = finish.Transparency }
		finish.Transparency = 1
	end
	self._restore[start] = from
	start.Transparency = 1

	local spin = entry.spin
	self:_over(entry.delay, entry.duration, function(alpha)
		local eased = TweenService:GetValue(alpha, entry.style, entry.direction)
		start.CFrame = self._placement * fromRelative:Lerp(toRelative, eased) * CFrame.Angles(0, spin * eased, 0)
		start.Size = from.Size:Lerp(to.Size, eased)
		start.Transparency = from.Transparency + (to.Transparency - from.Transparency) * eased
		start.Color = from.Color:Lerp(to.Color, eased)
		if startMesh and startScale and finishScale then
			startMesh.Scale = startScale:Lerp(finishScale, eased)
		end
		for _, decal in decals do
			decal.decal.Transparency = decal.from + (decal.to - decal.from) * eased
		end
		-- Hidden once the motion is done. This is part of the last update rather
		-- than an event, because events run before tracks and the last update
		-- would show Start again at End's Transparency.
		if alpha >= 1 then
			start.Transparency = 1
			for _, decal in decals do
				decal.decal.Transparency = 1
			end
		end
	end)
end

function Handle:_applyScale(scale)
	self._scale = scale
	for emitter, authored in self._timeScales do
		emitter.TimeScale = authored * scale
	end
	for _, entry in self._trails do
		-- Trail.Lifetime stops at 20 s, which is as near to frozen as a trail gets.
		local lifetime = entry.lifetime
		entry.trail.Lifetime = math.min(lifetime / math.max(scale, lifetime / MAX_TRAIL_LIFETIME, 1e-6), MAX_TRAIL_LIFETIME)
	end
	for beam, speed in self._beams do
		beam.TextureSpeed = speed * scale
	end
	for _, child in self._children do
		if child.handle and not child.handle.finished then
			child.handle:_applyScale(scale)
		end
	end
end

function Handle:setTimeScale(scale)
	-- A finished effect has put back what it changed; scaling it again would undo that.
	if self.finished then
		return
	end
	self._freezeToken = nil
	self:_applyScale(math.clamp(tonumber(scale) or 1, 0, 1))
end

Handle.setSpeed = Handle.setTimeScale

-- Hitstop: holds particles, trails and meshes for `seconds` of real time, then
-- goes on at the time scale it had. Freezing again while frozen extends it.
function Handle:freeze(seconds)
	if self.finished then
		return
	end
	if self._freezeToken == nil then
		self._resume = self._scale
	end
	local token = {}
	self._freezeToken = token
	self:_applyScale(0)
	task.delay(math.max(tonumber(seconds) or 0, 0), function()
		if self._freezeToken == token and not self.finished then
			self._freezeToken = nil
			self:_applyScale(self._resume)
		end
	end)
end

function Handle:getTime()
	return self.time
end

function Handle:getSpeed()
	return self._scale
end

function Handle:isDone()
	return self.finished
end

function Handle:onDone(fn)
	if self.finished then
		task.spawn(fn)
	else
		table.insert(self._onDone, fn)
	end
end

function Handle:onStep(fn)
	table.insert(self._onStep, fn)
end

--- Plays another effect on this handle's clock, delay seconds into it (default
--- now), at `at` (default where this effect is). This handle isn't done until
--- that one is.
function Handle:add(effect, at, delay)
	resolve(effect)
	if at ~= nil then
		toCFrame(at)
	elseif not (self.root:IsA("Model") or self.root:IsA("BasePart")) then
		error("Emit: add needs where to play the effect", 2)
	end
	table.insert(self._children, { effect = effect, at = at, delay = math.max(tonumber(delay) or self.time, 0) })
end

-- Advances the effect by dt seconds of its own clock.
function Handle:_advance(dt)
	if self.finished then
		return
	end
	self.time += dt
	if self._follow then
		if not self._follow.Parent then
			self:stop()
			return
		end
		self._placement = toCFrame(self._follow) * self._offset
		place(self.root, self._placement)
	end
	for _, fn in table.clone(self._onStep) do
		local ok, err = pcall(fn, self.time, dt)
		if not ok then
			warn(`VFXEmit: onStep error: {err}`)
		end
	end
	if self.finished then
		return
	end
	local now = self.time
	local pending = {}
	for _, event in self._events do
		if event.at <= now then
			event.run()
		else
			table.insert(pending, event)
		end
	end
	self._events = pending
	local running = {}
	for _, track in self._tracks do
		if now >= track.from then
			local alpha = math.min((now - track.from) / track.seconds, 1)
			track.step(alpha)
			if alpha < 1 then
				table.insert(running, track)
			end
		else
			table.insert(running, track)
		end
	end
	self._tracks = running
	local childrenDone = true
	for _, child in self._children do
		if not child.handle and now >= child.delay then
			local at = child.at or self.root:GetPivot()
			local ok, result = pcall(startCopy, child.effect, at, { parent = self._childParent })
			if ok then
				child.handle = result
				result:_applyScale(self._scale)
				result:_advance(now - child.delay)
			else
				warn(`VFXEmit: {result}`)
				child.handle = { finished = true }
			end
		elseif child.handle and not child.handle.finished then
			child.handle:_advance(dt)
		end
		if not (child.handle and child.handle.finished) then
			childrenDone = false
		end
	end
	if now >= self.duration and childrenDone then
		self:stop()
	end
end

-- Whether an instance has left the place (destroyed, or removed from it).
local function isGone(instance)
	local ok, inside = pcall(function()
		return instance:IsDescendantOf(game)
	end)
	return ok and not inside
end

-- The cleanup stop() does, one step per thing that can fail on its own. A step
-- with a target counts as done when it fails because that target is gone.
function Handle:_cleanupSteps()
	local steps = {}
	local function add(name, run, target)
		table.insert(steps, { name = name, run = run, target = target })
	end
	add("disconnect from Heartbeat", function()
		if self._connection then
			self._connection:Disconnect()
			self._connection = nil
		end
	end)
	for index, child in self._children do
		if child.handle and child.handle.stop then
			add(`stop added effect {index}`, function()
				local ok, failed = child.handle:stop()
				if ok == false then
					error(table.concat(failed, "; "), 0)
				end
			end)
		end
	end
	if self._owned then
		add(`destroy {self.root:GetFullName()}`, function()
			self.root:Destroy()
		end, self.root)
	else
		for instance, properties in self._restore do
			for name, value in properties do
				add(`restore {instance:GetFullName()}.{name}`, function()
					local target: any = instance
					target[name] = value
				end, instance)
			end
		end
	end
	return steps
end

-- Ends the effect now. An owned copy is destroyed; an effect played in place
-- gets back the state it had before. Returns true once that cleanup is done.
-- When a step of it fails, the others still run, and it warns and returns
-- false and the failed steps; calling stop() again retries only those. A step
-- whose instance has left the place (destroyed, or no longer under game)
-- counts as done even if it fails; an added effect counts as done once its own
-- stop() returns true.
-- finished is true and onDone fires (once) from the first call either way.
function Handle:stop()
	if not self.finished then
		self.finished = true
		self._freezeToken = nil
		self._pending = self:_cleanupSteps()
	end
	local pending = self._pending
	local failed = {}
	if pending then
		local remaining = {}
		for _, step in pending do
			local ok, err = pcall(step.run)
			if not ok and not (step.target and isGone(step.target)) then
				table.insert(remaining, step)
				table.insert(failed, `{step.name}: {err}`)
			end
		end
		self._pending = if #remaining > 0 then remaining else nil
		if self._pending == nil and playingInPlace[self.root] == self then
			playingInPlace[self.root] = nil
		end
	end
	if not self._doneFired then
		self._doneFired = true
		for _, fn in self._onDone do
			task.spawn(fn)
		end
		table.clear(self._onDone)
	end
	if #failed > 0 then
		warn(`VFXEmit: stopping {self.root.Name} didn't finish; call stop() again. {table.concat(failed, "; ")}`)
		return false, failed
	end
	return true
end

local function start(root, owned, options, origin)
	local entries, scheduled, tail = timeline(root, true)
	local duration, override = effectLength(root, scheduled, tail, true)
	if override == nil and #entries == 0 then
		warn(`VFXEmit: nothing under {root:GetFullName()} has EmitCount, EmitDuration or Start/End to play`)
	end
	local self = setmetatable({
		root = root,
		model = root,
		time = 0,
		finished = false,
		duration = duration,
		_owned = owned,
		_scale = 1,
		_events = {},
		_tracks = {},
		_timeScales = {},
		_trails = {},
		_beams = {},
		_restore = {},
		_children = {},
		_onDone = {},
		_onStep = {},
		_origin = origin or CFrame.identity,
		_placement = origin or CFrame.identity,
		_childParent = options.parent or workspace,
	}, Handle)
	if type(options.onDone) == "function" then
		table.insert(self._onDone, options.onDone)
	end
	if owned then
		for _, instance in everything(root) do
			if instance:IsA("BasePart") then
				-- Effect parts never collide, cast shadows or answer raycasts.
				instance.Anchored = true
				instance.CanCollide = false
				instance.CanQuery = false
				instance.CanTouch = false
				instance.CastShadow = false
			end
		end
	end
	for _, entry in entries do
		if entry.kind == "emitter" then
			self:_emitter(entry)
		elseif entry.kind == "ribbon" then
			self:_ribbon(entry)
		elseif entry.kind == "light" then
			self:_light(entry)
		else
			self:_mesh(entry)
		end
	end
	self:_applyScale(math.clamp(tonumber(options.timeScale or options.speed) or 1, 0, 1))
	return self
end

-- A child effect is driven by its parent's clock, so this doesn't connect.
function startCopy(effect, at, options)
	local template = resolve(effect, 4)
	if not (template:IsA("Model") or template:IsA("BasePart")) then
		error(`Emit.play: {template:GetFullName()} must be a Model or a BasePart`, 4)
	end
	local follow = options.follow
	local offset = if typeof(options.offset) == "CFrame" then options.offset else CFrame.identity
	local origin = if follow ~= nil then toCFrame(follow, 4) * offset else toCFrame(at, 4)
	local copy = template:Clone()
	if copy == nil then
		error(`Emit.play: {template:GetFullName()} can't be copied; turn its Archivable back on`, 4)
	end
	place(copy, origin)
	local self = start(copy, true, options, if follow ~= nil then origin else nil)
	self._follow = follow
	self._offset = offset
	copy.Parent = options.parent or workspace
	return self
end

local function drive(self)
	self:_advance(0)
	if not self.finished then
		self._connection = RunService.Heartbeat:Connect(function(dt)
			self:_advance(dt * self._scale)
		end)
	end
	return self
end

--- Plays a copy of `effect` at `at` and destroys it when it ends.
--- options: parent, timeScale (or speed), onDone, follow, offset.
function Emit.play(effect, at, options)
	return drive(startCopy(effect, at, options or {}))
end

--- Plays the effects under `root` where they are, and restores them when it
--- ends. For an effect that lives on a weapon or a character.
--- options: timeScale (or speed), onDone, parent (for effects added to it).
--- A play of root that is still going, or whose cleanup didn't finish, is
--- stopped first; if that cleanup still fails, this errors with the failed
--- steps rather than play from a half-restored state (its values would be
--- what the new play restores to).
function Emit.emit(root, options)
	if typeof(root) ~= "Instance" then
		error("Emit.emit: pass the instance whose effects should play", 2)
	end
	local previous = playingInPlace[root]
	if previous then
		local ok, failed = previous:stop()
		if ok == false then
			error(`Emit.emit: the previous play of {root:GetFullName()} couldn't be put back, so it can't play again yet: {table.concat(failed, "; ")}`, 2)
		end
	end
	local self = start(root, false, options or {}, nil)
	playingInPlace[root] = self
	return drive(self)
end

return Emit
