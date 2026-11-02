--!strict
-- Pattern: MeleeCombo (ModuleScript, SERVER)
-- Credit: the rules come from jujutsu-shenanigans (Combat.server: 4-hit combo that resets after 1.5 s,
-- DamageHandler: blocking only works if the attacker is in front, counters, stun on hit;
-- HitboxHandler: GetPartBoundsInBox + "already hit" list) and bite-by-night (Parry.lua: a parry
-- window attribute, punished with weakness if it whiffs; HitboxManager: debug boxes).
--
-- What it does:
--   Server-authoritative M1 combo. Call MeleeCombo.Attack(character) when the client asks to swing:
--     * cooldown between swings, combo step 1..N, combo resets if you wait too long
--     * box hitbox in front of the attacker (spatial query, not .Touched)
--     * target Blocking (attribute) and facing the attacker -> chip damage, no stun
--     * target inside a parry window -> the ATTACKER gets stunned instead
--     * otherwise damage + short stun (attribute "StunnedUntil"), last hit knocks back
--   MeleeCombo.SetBlocking(character, bool) and MeleeCombo.Parry(character) for the defensive side.
--
-- Usage (Script in ServerScriptService):
--   local MeleeCombo = require(path.to.MeleeCombo)
--   MeleeCombo.Configure({ damage = { 6, 6, 7, 10 }, debug = true })
--   remote.OnServerEvent:Connect(function(player, action, value)
--       local character = player.Character
--       if not character then return end
--       if action == "M1" then
--           local result = MeleeCombo.Attack(character)   -- { step = 2, hits = { {target=..., outcome="Hit"} } }
--       elseif action == "Block" then
--           MeleeCombo.SetBlocking(character, value == true)
--       elseif action == "Parry" then
--           MeleeCombo.Parry(character)
--       end
--   end)
--   Clients read character attributes "ComboStep", "Blocking", "StunnedUntil" to play animations.

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

export type Config = {
	damage: { number }?, -- damage per combo step; its length is the combo size
	swingCooldown: number?, -- seconds between swings
	finisherCooldown: number?, -- extra wait after the last hit of the combo
	comboReset: number?, -- combo restarts if you wait longer than this
	hitboxSize: Vector3?,
	hitboxOffset: CFrame?, -- relative to the attacker's root
	stunTime: number?,
	blockDamageMultiplier: number?,
	blockAngle: number?, -- dot product: 0.3 means the attacker must be within ~72 degrees of the blocker's front
	parryWindow: number?,
	parryStun: number?,
	parryMissStun: number?, -- self-stun if a parry hits nothing
	knockback: number?,
	debug: boolean?,
}

export type HitResult = { target: Model, outcome: "Hit" | "Blocked" | "Parried", damage: number }
export type AttackResult = { step: number, hits: { HitResult } }

local MeleeCombo = {}

local cfg: Config = {}
local lastSwing: { [Model]: number } = setmetatable({}, { __mode = "k" }) :: any
local nextSwingAt: { [Model]: number } = setmetatable({}, { __mode = "k" }) :: any

function MeleeCombo.Configure(config: Config)
	cfg = config
end

local function now(): number
	return workspace:GetServerTimeNow()
end

local function rootOf(model: Model): BasePart?
	return model:FindFirstChild("HumanoidRootPart") :: BasePart?
end

function MeleeCombo.IsStunned(character: Model): boolean
	return ((character:GetAttribute("StunnedUntil") :: number?) or 0) > now()
end

function MeleeCombo.Stun(character: Model, seconds: number)
	local untilTime = math.max((character:GetAttribute("StunnedUntil") :: number?) or 0, now() + seconds)
	character:SetAttribute("StunnedUntil", untilTime)
	character:SetAttribute("Blocking", false)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 4
		task.delay(seconds, function()
			if humanoid.Parent and not MeleeCombo.IsStunned(character) then
				humanoid.WalkSpeed = 16
			end
		end)
	end
end

function MeleeCombo.SetBlocking(character: Model, blocking: boolean)
	if blocking and MeleeCombo.IsStunned(character) then
		return
	end
	character:SetAttribute("Blocking", blocking)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid and not MeleeCombo.IsStunned(character) then
		humanoid.WalkSpeed = if blocking then 8 else 16
	end
end

function MeleeCombo.Parry(character: Model)
	if MeleeCombo.IsStunned(character) or ((character:GetAttribute("ParryUntil") :: number?) or 0) > now() then
		return
	end
	local window = cfg.parryWindow or 0.3
	local untilTime = now() + window
	character:SetAttribute("ParryUntil", untilTime)
	character:SetAttribute("ParrySucceeded", false)
	task.delay(window, function()
		-- missed parry: punish with a short self-stun (bite-by-night does the same with "weakness")
		if character.Parent and character:GetAttribute("ParryUntil") == untilTime and not character:GetAttribute("ParrySucceeded") then
			MeleeCombo.Stun(character, cfg.parryMissStun or 0.6)
		end
	end)
end

local function isFacing(defenderRoot: BasePart, attackerRoot: BasePart, minDot: number): boolean
	local toAttacker = (attackerRoot.Position - defenderRoot.Position) * Vector3.new(1, 0, 1)
	if toAttacker.Magnitude < 0.01 then
		return true
	end
	local look = defenderRoot.CFrame.LookVector * Vector3.new(1, 0, 1)
	return look.Unit:Dot(toAttacker.Unit) >= minDot
end

local function knockback(target: Model, fromRoot: BasePart, strength: number)
	local root = rootOf(target)
	if not root then
		return
	end
	-- A constraint made on the server replicates and is simulated by whoever owns the physics
	-- (the target player's client), which is why fighting games use body movers for knockback.
	local att = Instance.new("Attachment")
	att.Parent = root
	local lv = Instance.new("LinearVelocity")
	lv.Attachment0 = att
	lv.RelativeTo = Enum.ActuatorRelativeTo.World
	lv.MaxForce = 1e5
	lv.VectorVelocity = fromRoot.CFrame.LookVector * strength + Vector3.new(0, strength * 0.35, 0)
	lv.Parent = root
	Debris:AddItem(lv, 0.15)
	Debris:AddItem(att, 0.15)
end

local function debugBox(cf: CFrame, size: Vector3)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch = true, false, false, false
	p.Transparency = 0.7
	p.Color = Color3.fromRGB(255, 60, 60)
	p.Material = Enum.Material.ForceField
	p.CFrame, p.Size = cf, size
	p.Parent = workspace
	Debris:AddItem(p, 0.2)
end

local function query(attacker: Model, root: BasePart): { Model }
	local size = cfg.hitboxSize or Vector3.new(5, 5, 5)
	local cf = root.CFrame * (cfg.hitboxOffset or CFrame.new(0, 0, -3.5))
	if cfg.debug then
		debugBox(cf, size)
	end
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { attacker }

	local found: { Model } = {}
	local seen: { [Model]: boolean } = {}
	for _, part in workspace:GetPartBoundsInBox(cf, size, params) do
		local model = part:FindFirstAncestorOfClass("Model")
		if model and not seen[model] then
			local humanoid = model:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				seen[model] = true
				table.insert(found, model)
			end
		end
	end
	return found
end

function MeleeCombo.Attack(attacker: Model): AttackResult?
	local root = rootOf(attacker)
	local humanoid = attacker:FindFirstChildOfClass("Humanoid")
	if not root or not humanoid or humanoid.Health <= 0 then
		return nil
	end
	if MeleeCombo.IsStunned(attacker) or attacker:GetAttribute("Blocking") then
		return nil
	end
	local t = now()
	if t < (nextSwingAt[attacker] or 0) then
		return nil
	end

	local damageTable = cfg.damage or { 5, 5, 5, 8 }
	local maxStep = #damageTable
	local step = (attacker:GetAttribute("ComboStep") :: number?) or 0
	if t - (lastSwing[attacker] or 0) > (cfg.comboReset or 1.5) or step >= maxStep then
		step = 0
	end
	step += 1
	lastSwing[attacker] = t
	attacker:SetAttribute("ComboStep", step)

	local isFinisher = step == maxStep
	nextSwingAt[attacker] = t + (cfg.swingCooldown or 0.35) + (if isFinisher then (cfg.finisherCooldown or 0.8) else 0)

	local result: AttackResult = { step = step, hits = {} }
	for _, target in query(attacker, root) do
		local targetRoot = rootOf(target)
		local targetHumanoid = target:FindFirstChildOfClass("Humanoid")
		if not targetRoot or not targetHumanoid then
			continue
		end
		local damage = damageTable[step]

		if ((target:GetAttribute("ParryUntil") :: number?) or 0) > t then
			target:SetAttribute("ParrySucceeded", true)
			MeleeCombo.Stun(attacker, cfg.parryStun or 1.2)
			table.insert(result.hits, { target = target, outcome = "Parried", damage = 0 })
			break -- a parry stops the whole swing
		elseif target:GetAttribute("Blocking") and isFacing(targetRoot, root, cfg.blockAngle or 0.3) then
			local chip = damage * (cfg.blockDamageMultiplier or 0.15)
			targetHumanoid:TakeDamage(chip)
			table.insert(result.hits, { target = target, outcome = "Blocked", damage = chip })
		else
			targetHumanoid:TakeDamage(damage)
			MeleeCombo.Stun(target, cfg.stunTime or 0.45)
			if isFinisher then
				knockback(target, root, cfg.knockback or 45)
			end
			-- tag who hit whom (for kill credit), same idea as the "creator" ObjectValue in classic tools
			target:SetAttribute("LastHitBy", (Players:GetPlayerFromCharacter(attacker) or attacker).Name)
			table.insert(result.hits, { target = target, outcome = "Hit", damage = damage })
		end
	end
	return result
end

return MeleeCombo
