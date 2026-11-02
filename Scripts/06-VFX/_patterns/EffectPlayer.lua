--!strict
-- Pattern: EffectPlayer (ModuleScript, client or server)
-- Credit: combines the attribute conventions used by bite-by-night (EffectUtility: EmitCount / EmitDelay),
-- steal-a-brainrot (VFX.lua: EmitDuration, copy-to-CFrame, weld-follow) and smash-egg-for-animals
-- (FightFilm.Fx: never touch the template, clone it, work out the longest lifetime, clean up).
--
-- What it does:
--   Takes a template (a Part, Model or Attachment full of ParticleEmitters / Beams / Trails / Lights),
--   clones it at a position or onto a moving part, fires it, and destroys the clone once every
--   particle is gone. Artists control the effect with attributes on each emitter:
--     EmitCount    (number)  particles for a one-shot :Emit()       (default 1; 0 = skip)
--     EmitDelay    (number)  seconds to wait before emitting        (default 0)
--     EmitDuration (number)  also leave .Enabled = true for N seconds (default 0)
--     Loop         (boolean) stay enabled until handle:Stop()
--   One-shot effects delete themselves. Effects that contain a Loop emitter, a Beam or a Trail keep
--   running until you call handle:Stop() or pass options.lifetime.
--
-- Usage:
--   local EffectPlayer = require(path.to.EffectPlayer)
--   EffectPlayer.Play(ReplicatedStorage.VFX.HitSpark, hitPosition)                      -- one shot in the world
--   EffectPlayer.Play(ReplicatedStorage.VFX.Explosion, cframe, { scale = 2, color = Color3.new(1, 0, 0) })
--   local aura = EffectPlayer.Play(ReplicatedStorage.VFX.Aura, character.HumanoidRootPart, { follow = true })
--   task.wait(5); aura:Stop()                                                            -- fades out, then cleans up
--
--   Run it on the client for cosmetic effects (fire a RemoteEvent with the position from the server).

local Debris = game:GetService("Debris")

export type Options = {
	scale: number?, -- multiplies particle size / speed
	color: Color3?, -- recolors emitters, beams and trails
	countMultiplier: number?, -- multiplies EmitCount (e.g. lower on low graphics)
	follow: boolean?, -- weld to the target part instead of staying where it spawned
	parent: Instance?, -- where the clone goes (default workspace or workspace.Terrain for attachments)
	lifetime: number?, -- override the automatic cleanup time
}

export type Handle = {
	Instance: Instance,
	Stop: (self: Handle) -> (),
}

local EffectPlayer = {}

local function scaleSequence(seq: NumberSequence, k: number): NumberSequence
	local points = {}
	for _, p in seq.Keypoints do
		table.insert(points, NumberSequenceKeypoint.new(p.Time, p.Value * k, p.Envelope * k))
	end
	return NumberSequence.new(points)
end

local function tune(emitter: ParticleEmitter, options: Options)
	local k = options.scale
	if k and k ~= 1 then
		emitter.Size = scaleSequence(emitter.Size, k)
		emitter.Speed = NumberRange.new(emitter.Speed.Min * k, emitter.Speed.Max * k)
		emitter.Acceleration *= k
	end
	if options.color then
		emitter.Color = ColorSequence.new(options.color)
	end
end

local function place(clone: Instance, target: Vector3 | CFrame | BasePart, follow: boolean?)
	local cf: CFrame
	if typeof(target) == "Vector3" then
		cf = CFrame.new(target)
	elseif typeof(target) == "CFrame" then
		cf = target
	else
		cf = (target :: BasePart).CFrame
	end

	if clone:IsA("Attachment") then
		if follow and typeof(target) == "Instance" then
			clone.Parent = target -- attachments follow their parent part for free
		else
			clone.WorldCFrame = cf
		end
	elseif clone:IsA("BasePart") then
		clone.CFrame = cf
		if follow and typeof(target) == "Instance" then
			clone.Anchored = false
			clone.Massless = true
			clone.CanCollide = false
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = target :: BasePart
			weld.Part1 = clone
			weld.Parent = clone
		end
	elseif clone:IsA("Model") then
		clone:PivotTo(cf)
		if follow and typeof(target) == "Instance" and clone.PrimaryPart then
			for _, d in clone:GetDescendants() do
				if d:IsA("BasePart") then
					d.Anchored = false
					d.Massless = true
					d.CanCollide = false
				end
			end
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = target :: BasePart
			weld.Part1 = clone.PrimaryPart
			weld.Parent = clone.PrimaryPart
		end
	end
end

function EffectPlayer.Play(template: Instance, target: Vector3 | CFrame | BasePart, options: Options?): Handle
	local opts: Options = options or {}
	local clone = template:Clone()

	if opts.parent then
		clone.Parent = opts.parent
	elseif clone:IsA("Attachment") then
		clone.Parent = workspace.Terrain
	else
		clone.Parent = workspace
	end
	place(clone, target, opts.follow)

	local longest = 0
	local loops: { ParticleEmitter | Beam | Trail | Light } = {}
	local all = clone:GetDescendants()
	table.insert(all, clone)

	for _, d in all do
		if d:IsA("ParticleEmitter") then
			tune(d, opts)
			longest = math.max(longest, d.Lifetime.Max)
			local count = math.floor(((d:GetAttribute("EmitCount") :: number?) or 1) * (opts.countMultiplier or 1) + 0.5)
			local delayTime = (d:GetAttribute("EmitDelay") :: number?) or 0
			local duration = (d:GetAttribute("EmitDuration") :: number?) or 0
			local loop = d:GetAttribute("Loop") == true
			longest = math.max(longest, delayTime + duration + d.Lifetime.Max)

			local function fire()
				if not d.Parent then
					return
				end
				if count > 0 then
					d:Emit(count)
				end
				if loop then
					d.Enabled = true
				elseif duration > 0 then
					d.Enabled = true
					task.delay(duration, function()
						d.Enabled = false
					end)
				end
			end
			d.Enabled = false
			if loop then
				table.insert(loops, d)
			end
			if delayTime > 0 then
				task.delay(delayTime, fire)
			else
				fire()
			end
		elseif d:IsA("Beam") or d:IsA("Trail") then
			if opts.color then
				d.Color = ColorSequence.new(opts.color)
			end
			d.Enabled = true
			table.insert(loops, d)
			if d:IsA("Trail") then
				longest = math.max(longest, d.Lifetime)
			end
		elseif d:IsA("Light") then
			table.insert(loops, d)
		end
	end

	local stopped = false
	local handle = {} :: Handle
	handle.Instance = clone

	function handle.Stop(_self: Handle)
		if stopped then
			return
		end
		stopped = true
		for _, e in loops do
			e.Enabled = false
		end
		-- let already-emitted particles finish before deleting
		Debris:AddItem(clone, longest + 0.25)
	end

	-- Effects with nothing looping clean themselves up.
	local hasLoop = false
	for _, e in loops do
		if not e:IsA("Light") and (not e:IsA("ParticleEmitter") or e:GetAttribute("Loop") == true) then
			hasLoop = true
			break
		end
	end
	if opts.lifetime then
		task.delay(opts.lifetime, function()
			handle:Stop()
		end)
	elseif not hasLoop then
		stopped = true
		Debris:AddItem(clone, longest + 0.25)
	end

	return handle
end

-- Emits every ParticleEmitter under `container` once using its EmitCount attribute (no cloning).
function EffectPlayer.EmitAll(container: Instance, multiplier: number?)
	for _, d in container:GetDescendants() do
		if d:IsA("ParticleEmitter") then
			local count = math.floor(((d:GetAttribute("EmitCount") :: number?) or 1) * (multiplier or 1) + 0.5)
			local delayTime = (d:GetAttribute("EmitDelay") :: number?) or 0
			if delayTime > 0 then
				task.delay(delayTime, d.Emit, d, count)
			else
				d:Emit(count)
			end
		end
	end
end

return EffectPlayer
