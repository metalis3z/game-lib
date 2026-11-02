-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Library = ReplicatedStorage:WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Types = Library:WaitForChild("Types")
local CurrencyOrb = script:WaitForChild("CurrencyOrb")
local OrbCollect = Assets:WaitForChild("Particles"):WaitForChild("Orbs"):WaitForChild("OrbCollect")
local FallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
local Functions = require(Library.Functions)
local CurrencyItem = require(Items.CurrencyItem)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Currency = require(ReplicatedStorage.Directory.Currency)
local InstanceCache = require(Library.Modules.Packages.InstanceCache)
local Variables = require(Library.Variables)
local Orbs = require(Types.Orbs)
local CoinSounds = require(script.CoinSounds)
local v1 = if workspace.StreamingEnabled then (1 / 0) else 400
local Orbs2 = workspace:WaitForChild("__OBJECTS"):WaitForChild("Orbs")
local v2 = Random.new()
local LocalPlayer = Players.LocalPlayer
local v3 = RaycastParams.new()

v3.FilterDescendantsInstances = {}
v3.FilterType = Enum.RaycastFilterType.Exclude
v3.IgnoreWater = true
v3.CollisionGroup = "Orbs"
v3.RespectCanCollide = true

local t = {
	DefaultPickupDistance = 70,
	CollectDistance = 2.5,
	CombineDistance = 16,
	CombineDelay = 0.8,
	BillboardDistance = 800,
	CollectAnimationDuration = 0.6,
	CollectAnimationHeight = 12,
	CollectAnimationSpin = 1.5707963267948966,
	SoundDistance = v1
}

local function setEffectsEnabled(p1, p2) --[[ setEffectsEnabled | Line: 101 ]]
	debug.profilebegin("SetEffectsEnabled")

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Enabled = p2
		end
	end

	debug.profileend()
end

function t.new(p1, p2, p3, p4, p5, p6, p7) --[[ new | Line: 125 | Upvalues: t (copy), Orbs2 (copy), Functions (copy), v2 (copy), Orbs (copy), setEffectsEnabled (copy) ]]
	local v1, v22, v3, v4, v5, v6 = t.CreatePart(p3, p4)

	v1.Name = tostring(p1)

	for i, v in ipairs(v22) do
		v.Enabled = false
		v.Lifetime = NumberRange.new(20)
		v.TimeScale = 0
	end

	local v7 = v1.PivotOffset:Inverse()

	v1:PivotTo(p5)
	v1.Parent = Orbs2

	for i, v in ipairs(v22) do
		v:Emit(1)
	end

	local Type = p4.Type
	local v8 = v1:GetAttribute("CrossSectionalArea")

	if not v8 then
		v8 = Functions.AverageCrossSectionalArea(if v1:IsA("Part") then v1.Shape else Enum.PartType.Block, v1.Size)
	end

	local v10 = v8 * (v1:GetAttribute("CrossSectionalAreaMultiplier") or 1)
	local v11 = v1:GetAttribute("DragCoefficient") or 0.7
	local v12 = p4.PickupDelay or v2:NextNumber(0.5, 2.1)
	local v14 = nil

	if Type == Orbs.Types.Orb then
		assert(if #p3 == 1 then true else false, "Orb items count must equal 1")

		local v16 = p3[1]

		if v16:IsA("Currency") then
			v14 = v16:GetId()
		end
	else
		error("Unexpected orb type")
	end

	if v4 then
		task.defer(setEffectsEnabled, v1, true)
	end

	local t2 = {
		_destroyed = false,
		_anchored = false,
		_nextParentCheck = 0,
		_dt = 0,
		_collected = false,
		_isAnimating = false,
		_animStart = 0,
		_id = p1,
		_timestamp = p2,
		_items = p3,
		_typeNumber = Type,
		_contentType = v3,
		_part = v1,
		_maybePartCache = v4,
		_pivotOffsetInv = v7,
		_cframeRender = p5,
		_currencyType = p7,
		_cframePhysics = p5,
		_velocity = p6,
		_assemblyMass = v1.AssemblyMass,
		_dragCoefficient = v11,
		_crossSectionalArea = v10,
		_physicalProperties = v1.CurrentPhysicalProperties,
		_pickupDelay = v12
	}

	t2._pickupDistanceOverride = if v6 then v6 else p4.OverridePickupDistance
	t2._combineDelay = v12 + t.CombineDelay
	t2._combineKey = v14
	t2._combinedIds = {}
	t2._staticParticles = v22
	t2._lootTierIndex = p4.Index
	t2._collectDistanceOverride = v5
	t2._animStartCFrame = p5

	return setmetatable(t2, {
		__index = t
	})
end
function t.RenderStepped(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ RenderStepped | Line: 236 | Upvalues: FallenPartsDestroyHeight (copy), Orbs (copy), t (copy), v1 (copy) ]]
	debug.profilebegin("Orb :: RenderStepped")

	local v12 = p3 - p1._timestamp

	if p1._destroyed then
		return false
	end

	if p1._cframePhysics.Position.Y < FallenPartsDestroyHeight or Orbs.DespawnTime <= v12 then
		debug.profileend()

		return false
	end

	if p1._nextParentCheck <= v12 then
		p1._nextParentCheck = v12 + 2.5 + 5 * math.random()

		if not p1._part.Parent then
			debug.profileend()

			return false
		end
	end

	local v2, v3

	if p7 then
		v2 = p7.Position - p1._pivotOffsetInv.Position
		v3 = (p1._cframePhysics.Position - v2).Magnitude
	else
		v2 = Vector3.new(0, 0, 0)
		v3 = (1 / 0)
	end

	local v4 = nil
	local v5, v6, v7

	if p1._pickupDelay <= v12 and (not v4 and p7) then
		v5 = true

		if p9 or p1._pickupDistanceOverride then
			p8 = p1._pickupDistanceOverride or 9999999
		end

		v6 = v2
		v4 = p6
		v7 = v3
	else
		v5 = false
		v6 = nil
		v7 = nil
	end

	local v8 = p1._collectDistanceOverride or t.CollectDistance
	local v9 = false

	if v7 then
		if p9 and (v5 and (v6 and v7 > 150)) then
			p1:Collect(nil, nil, true)
			debug.profileend()

			return false
		end

		if v7 <= v8 then
			p1:Collect(v4)

			return false
		end

		if v7 <= v8 + p8 then
			p1._anchored = false
			v9 = true
		end
	end

	if not v9 and v1 < v3 then
		p1._anchored = true
	end

	if p1._anchored then
		debug.profileend()

		return true
	end

	p1:SimulatePhysics(p2, v12, p4, p5, v6, p8)
	debug.profileend()

	return true
end
function t.Combine(p1, p2) --[[ Combine | Line: 333 | Upvalues: Orbs (copy) ]]
	if p1 == p2 then
		return false
	end

	if p1._destroyed then
		return false
	end

	if p1._collected then
		return false
	end

	if p2._destroyed then
		return false
	end

	if p2._collected then
		return false
	end

	local _typeNumber = p1._typeNumber

	if _typeNumber ~= p2._typeNumber then
		return false
	end

	if p1._contentType ~= p2._contentType then
		return false
	end

	if _typeNumber ~= Orbs.Types.Orb then
		return false
	end

	local v1 = p1._items[1]
	local v2 = p2._items[1]

	if not v1:IsLikeExact(v2) then
		return false
	end

	if v1:GetMaxAmount() < v1:GetAmount() + v2:GetAmount() then
		return false
	end

	p2:Destroy()
	table.insert(p1._combinedIds, p2._id)

	for i, v in ipairs(p2._combinedIds) do
		table.insert(p1._combinedIds, v)
	end

	local v3 = v1:GetOrbIcon()

	v1:SetAmount(v1:GetAmount() + v2:GetAmount())

	local v4 = v1:GetOrbIcon()

	if v3 == v4 then
		return true
	end

	for i, v in ipairs(p1._staticParticles) do
		v.Texture = v4
	end

	return true
end
function t.Collect(p1, p2, p3, p4) --[[ Collect | Line: 403 | Upvalues: CurrencyItem (copy), Functions (copy), LocalPlayer (copy), t (copy), CoinSounds (copy), Variables (copy), OrbCollect (copy) ]]
	if p1._destroyed then
		return
	end

	if p1._collected then
		return
	end

	p1._collected = true

	local v1 = p3 and p3.Position or p1._cframePhysics.Position
	local v2 = true

	for i, v in ipairs(p1._items) do
		local v3 = CurrencyItem:TryCast(v)

		if v3 and not p4 then
			if v2 and Functions.VerifyPlayerMagnitude(LocalPlayer, v1, t.SoundDistance) then
				CoinSounds.Queue(v3:GetId(), p1._lootTierIndex)
				v2 = false
			end

			continue
		end

		warn("Invalid item")
	end

	if not p2 or Variables.PotatoMode then
		return
	end

	local v4 = nil

	if p2:IsA("Model") then
		v4 = p2.PrimaryPart
	elseif p2:IsA("BasePart") then
		v4 = p2
	end

	if not v4 then
		return
	end

	local v5 = v4:FindFirstChild(OrbCollect.Name, true)

	if not v5 then
		local v6 = OrbCollect:Clone()

		v6.Parent = v4
		v5 = v6
	end

	v5:Emit(1)
end

local function computeImpact(p1, p2, p3, p4, p5) --[[ computeImpact | Line: 478 ]]
	local v3 = p1:Dot(p2) * p2

	return (v3 - 2 * v3:Dot(p2) * p2) * ((p4.Elasticity * p4.ElasticityWeight + p5.Elasticity * p5.ElasticityWeight) / (p4.ElasticityWeight + p5.ElasticityWeight)), (p1 - v3) * (1 - (p4.Friction * p4.FrictionWeight + p5.Friction * p5.FrictionWeight) / (p4.FrictionWeight + p5.FrictionWeight))
end

local function computeMotion(p1, p2, p3, p4, p5) --[[ computeMotion | Line: 510 ]]
	local v1 = math.clamp(p4 * p5 ^ 2, 0, 1)
	local v2 = p2 - p2 * v1
	local v3 = p3 - p3 * v1

	return p1 + v2 * p5 + v3 * 0.5 * p5 ^ 2, v2 + v3 * p5
end

function t.SimulatePhysics(p1, p2, p3, p4, p5, p6, p7) --[[ SimulatePhysics | Line: 536 | Upvalues: t (copy), Functions (copy), v3 (copy), computeImpact (copy) ]]
	debug.profilebegin("Orb :: SimulatePhysics")

	local _assemblyMass = p1._assemblyMass
	local _physicalProperties = p1._physicalProperties
	local v1 = p2 + p1._dt
	local Position = p1._cframePhysics.Position
	local _velocity = p1._velocity

	for i = 1, p5 do
		if not (v1 > 0.001) then
			break
		end

		local v2 = math.min(v1, 0.06666666666666667)
		local v32, v4 = p1:ComputeAcceleration(p4)

		if p6 then
			local v5 = p6 - Position
			local Magnitude = v5.Magnitude

			if Magnitude > 0.001 and Magnitude <= (p1._collectDistanceOverride or t.CollectDistance) + p7 then
				local v7 = math.max(p7, 150)

				_velocity = v5 * (math.clamp((v7 - Magnitude) / v7, 0, 1) ^ 2 * 100 + 40) / Magnitude

				if Magnitude < _velocity.Magnitude * v2 then
					_velocity = _velocity * Magnitude / (_velocity.Magnitude * v2)
				end

				v32 = Vector3.new(0, 0, 0)
				v4 = 0
			end
		end

		local v8 = math.clamp(v4 * v2 ^ 2, 0, 1)
		local v9 = _velocity - _velocity * v8
		local v10 = v32 - v32 * v8
		local v11 = Position + v9 * v2 + v10 * 0.5 * v2 ^ 2
		local v12 = v9 + v10 * v2
		local v13 = v11 - Position
		local Magnitude = v13.Magnitude

		if Magnitude ~= Magnitude then
			break
		end

		if Magnitude <= 0.001 then
			_velocity = v12
			v1 = 0

			break
		end

		if v13.Y >= 0 then
			_velocity = v12
			v1 = 0
			Position = v11

			break
		end

		local v14 = Functions.SafeRaycast(Position, v13, v3, 0.001)

		if v14 then
			local Position2 = v14.Position
			local v15 = Functions.GetMaterialPhysicalProperties(v14.Material)
			local v17 = math.clamp(v14.Distance * v2 / Magnitude, 0, v2)
			local v18 = math.clamp(v4 * v17 ^ 2, 0, 1)
			local v19, v20 = computeImpact(_velocity - _velocity * v18 + (v32 - v32 * v18) * v17, v14.Normal, _assemblyMass, _physicalProperties, v15)
			local v21 = v19 + v20

			if v17 <= 0.001 then
				_velocity = v21
				v1 = 0
				Position = Position2

				break
			end

			_velocity, v1, Position = v21, v1 - v17, Position2
		else
			_velocity = v12
			v1 = 0
			Position = v11

			break
		end
	end

	if _velocity.Magnitude < 0.001 then
		p1._anchored = true
		v1 = 0
	end

	p1._dt = v1
	p1._cframePhysics = CFrame.new(Position) * p1._cframePhysics.Rotation
	p1._velocity = _velocity
	debug.profileend()
end
function t.RenderParticles(p1, p2, p3) --[[ RenderParticles | Line: 648 ]]
	local Magnitude = (p1._cframePhysics.Position - p2).Magnitude

	if not (Magnitude < 500) then
		return
	end

	local v1 = NumberSequence.new(1 + 9 * Magnitude * p3)

	for i, v in ipairs(p1._staticParticles) do
		v.Size = v1
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 662 | Upvalues: setEffectsEnabled (copy), Functions (copy) ]]
	if p1._destroyed then
		return false
	end

	p1._destroyed = true

	if not p1._part then
		return true
	end

	if p1._maybePartCache then
		setEffectsEnabled(p1._part, false)
		p1._maybePartCache:ReturnPart(p1._part)
	else
		Functions.AddDebris(p1._part)
	end

	return true
end
function t.ComputeAcceleration(p1, p2) --[[ ComputeAcceleration | Line: 685 ]]
	return Vector3.new(0, -p2, 0), 0.5 * p1._dragCoefficient * 1.225 * p1._crossSectionalArea
end
function t.ComputeInitialCFrame(p1) --[[ ComputeInitialCFrame | Line: 695 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)
	Asserts.Vector3(p1.pos)

	local v1 = CFrame.new(p1.pos) and v1 * CFrame.new(0, 0.25, 0)

	return v1
end
function t.ComputeInitialVelocity(p1, p2, p3) --[[ ComputeInitialVelocity | Line: 713 | Upvalues: v2 (copy) ]]
	local v1 = if p3.CustomVelocity then p3.CustomVelocity else nil

	if not v1 and p2 then
		local v22 = p2.Position - p1.Position

		if Vector2.new(v22.X, v22.Z).Magnitude < 50 then
			local v3 = math.atan2(v22.Y, v22.X) + 6.283185307179586 * v2:NextNumber(-0.25, 0.25)
			local v4 = v2:NextNumber(7, 11)

			v1 = Vector3.new(v4 * math.cos(v3), 50, v4 * math.sin(v3))
		end
	end

	if not v1 then
		v1 = Vector3.new(v2:NextNumber(-10, 10), 50, v2:NextNumber(-10, 10))
	end

	return v1 * (p3.VelocityMultiplier or 1)
end

local function prepareInstance(p1) --[[ prepareInstance | Line: 738 ]]
	p1.CanCollide = false
	p1.CanQuery = false
	p1.CanTouch = false
	p1.CastShadow = false
	p1.Anchored = true
	p1.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	p1.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	p1.CollisionGroup = "Orbs"
	p1.PivotOffset = CFrame.new(0, p1.Size.Y * -0.5, 0)

	return p1
end

function t.CreatePart(p1, p2) --[[ CreatePart | Line: 757 | Upvalues: Orbs (copy), InstanceCache (copy), CurrencyOrb (copy), v2 (copy) ]]
	if p2.Type ~= Orbs.Types.Orb then
		error("unimplemented orb type")
	end

	local v1 = p1[1]

	if not v1:IsA("Currency") then
		error("unimplemented orb type")
	end

	local v22 = v1:GetOrbInstance()
	local v3 = nil
	local v4 = nil
	local v5

	if v22 then
		if InstanceCache.is(v22) then
			local v6 = v22:GetPart()

			v6.CanCollide = false
			v6.CanQuery = false
			v6.CanTouch = false
			v6.CastShadow = false
			v6.Anchored = true
			v6.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			v6.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			v6.CollisionGroup = "Orbs"
			v6.PivotOffset = CFrame.new(0, v6.Size.Y * -0.5, 0)
			v5 = v6
			v4 = v22
		else
			local v7 = v22:Clone()

			v7.CanCollide = false
			v7.CanQuery = false
			v7.CanTouch = false
			v7.CastShadow = false
			v7.Anchored = true
			v7.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			v7.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			v7.CollisionGroup = "Orbs"
			v7.PivotOffset = CFrame.new(0, v7.Size.Y * -0.5, 0)
			v5 = v7
		end
	else
		local v8 = CurrencyOrb:Clone()

		v3 = v8.Center.Item
		v3.Texture = v1:GetOrbIcon()
		v3.ZOffset = v3.ZOffset + v2:NextNumber(0, 0.1)
		v5 = v8
	end

	if p2.ColorOverride then
		v5.Color = p2.ColorOverride
	end

	local v9, v10

	if v3 then
		v9 = { v3 }
		v10 = v5
	else
		v10 = v5
		v9 = {}
	end

	return v10, v9, 1, v4, v1:GetCollectDistanceOverride(), v1:GetPickupDistanceOverride()
end
task.spawn(function() --[[ Line: 803 | Upvalues: setEffectsEnabled (copy), Currency (copy), InstanceCache (copy) ]]
	local function softDisableEffectsInCache(p1) --[[ softDisableEffectsInCache | Line: 806 | Upvalues: setEffectsEnabled (ref) ]]
		local v1 = os.clock()

		for i, v in ipairs(p1.CacheHolder:GetChildren()) do
			setEffectsEnabled(v, false)

			if os.clock() - v1 >= 0.002 then
				task.wait()
				v1 = os.clock()
			end
		end
	end

	for k, v in pairs(Currency.Directory) do
		local v1 = v.Instance

		if InstanceCache.is(v1) then
			softDisableEffectsInCache(v1)
		end
	end
end)

return t