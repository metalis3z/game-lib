--credit to quartz games studio
local BehaviorBase = require(script.Parent.BehaviorBase)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetTypes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetTypes"))
local PetSizes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetSizes"))
local Services = game:GetService("ServerScriptService"):WaitForChild("Services")
local v1 = nil

local function GetDragonDefenseService() --[[ GetDragonDefenseService | Line: 21 | Upvalues: v1 (ref), Services (copy) ]]
	if v1 then
		return v1
	end

	v1 = require(Services:WaitForChild("DragonDefenseService"))

	return v1
end

local v2 = nil

local function GetIceSerpentFireService() --[[ GetIceSerpentFireService | Line: 29 | Upvalues: v2 (ref), Services (copy) ]]
	if v2 then
		return v2
	end

	v2 = require(Services:WaitForChild("IceSerpentFireService"))

	return v2
end

local v3 = nil
local v4 = nil

local function GetPetRecord(p1, p2) --[[ GetPetRecord | Line: 41 | Upvalues: v4 (ref), v3 (ref), Services (copy) ]]
	if v4 then
		return v4(v3, p1, p2)
	end

	v3 = require(Services:WaitForChild("DataService"))
	v4 = v3.GetPet

	return v4(v3, p1, p2)
end

local t = {
	Big = 1.5,
	Huge = 2
}

local function DamageMultiplierForSize(p1) --[[ DamageMultiplierForSize | Line: 78 | Upvalues: PetSizes (copy), t (copy) ]]
	local v1 = PetSizes.Normalize(p1)

	if v1 then
		return t[v1] or 1
	end

	return 1
end

local t2 = {
	Big = 1.5,
	Huge = 1.8
}

local function FreezeMultiplierForSize(p1) --[[ FreezeMultiplierForSize | Line: 94 | Upvalues: PetSizes (copy), t2 (copy) ]]
	local v1 = PetSizes.Normalize(p1)

	if v1 then
		return t2[v1] or 1
	end

	return 1
end

local function FreezeMultiplierForType(p1) --[[ FreezeMultiplierForType | Line: 102 | Upvalues: PetTypes (copy) ]]
	if p1 == PetTypes.Rainbow then
		return 1.25
	end

	return 1
end

local IceSerpentDefend = setmetatable({}, {
	__index = BehaviorBase
})

IceSerpentDefend.__index = IceSerpentDefend
IceSerpentDefend.Name = "IceSerpentDefend"

local function MakeGoalCFrame(p1, p2) --[[ MakeGoalCFrame | Line: 114 ]]
	local v1 = p2 - p1

	if v1.Magnitude < 0.001 then
		return CFrame.new(p2)
	end

	return CFrame.lookAt(p2, p2 + v1.Unit)
end

local function FlyToContact(p1, p2, p3) --[[ FlyToContact | Line: 125 ]]
	local v1 = p1.Control:GetSlotPosition()

	if not v1 then
		return
	end

	local v2 = 0

	if p1.Module and p1.Module.IsFlying and type(p1.Module.AirHeight) == "number" then
		v2 = p1.Module.AirHeight
	end

	local v4 = Vector3.new(p2.X, v1.Y - v2, p2.Z)

	p1.Control:SetSlotAttribute("Hovering", true)

	local v5 = v4 - v1

	p1.Control:SetGoal(if v5.Magnitude < 0.001 then CFrame.new(v4) else CFrame.lookAt(v4, v4 + v5.Unit), p3)
end

local function HoldFacing(p1, p2, p3, p4) --[[ HoldFacing | Line: 144 ]]
	local v1 = 0

	if p1.Module and p1.Module.IsFlying and type(p1.Module.AirHeight) == "number" then
		v1 = p1.Module.AirHeight
	end

	local v3 = Vector3.new(p2.X, p2.Y - v1, p2.Z)
	local v4 = p3 - p2
	local v5 = if v4.Magnitude > 0.001 then v4.Unit else Vector3.new(0, 0, -1)

	p1.Control:SetSlotAttribute("Hovering", true)
	p1.Control:SetGoal(CFrame.lookAt(v3, v3 + v5), p4)
end

local function ClearCombatHover(p1) --[[ ClearCombatHover | Line: 160 ]]
	if not (p1.Control and p1.Control.SetSlotAttribute) then
		return
	end

	p1.Control:SetSlotAttribute("Hovering", nil)
end

local function BreatheLean(p1, p2, p3, p4, p5) --[[ BreatheLean | Line: 170 ]]
	local v1 = 0

	if p1.Module and p1.Module.IsFlying and type(p1.Module.AirHeight) == "number" then
		v1 = p1.Module.AirHeight
	end

	local v4 = Vector3.new(p3.X - p2.X, 0, p3.Z - p2.Z)
	local Magnitude = v4.Magnitude
	local v5 = if Magnitude > 0.001 then v4.Unit else Vector3.new(0, 0, -1)
	local v6 = p2 + v5 * (math.min(4, Magnitude * 0.5) * p4)
	local v8 = Vector3.new(v6.X, p2.Y - v1, v6.Z)
	local v9 = p3 - v6
	local v10 = if v9.Magnitude > 0.001 then v9.Unit else Vector3.new(0, 0, -1)

	p1.Control:SetSlotAttribute("Hovering", true)
	p1.Control:SetGoal(CFrame.lookAt(v8, v8 + v10), p5)
end

local function WithinBreathRange(p1, p2) --[[ WithinBreathRange | Line: 200 ]]
	local v1 = p1.Control:GetSlotPosition()

	if not v1 then
		return false
	end

	local v2 = p2.X - v1.X
	local v3 = p2.Z - v1.Z

	return math.sqrt(v2 * v2 + v3 * v3) <= 10
end

local function TargetPosition(p1) --[[ TargetPosition | Line: 210 ]]
	if not (p1 and p1.Player) then
		return nil
	end

	local Character = p1.Player.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
		return HumanoidRootPart.Position
	end

	return nil
end

local function TargetTorsoPosition(p1) --[[ TargetTorsoPosition | Line: 221 ]]
	if not (p1 and p1.Player) then
		return nil
	end

	local Character = p1.Player.Character

	if not Character then
		return nil
	end

	local v1 = Character:FindFirstChild("UpperTorso") or (Character:FindFirstChild("Torso") or Character:FindFirstChild("HumanoidRootPart"))

	if v1 and v1:IsA("BasePart") then
		return v1.Position
	end

	return nil
end

local function IsTargetStillValid(p1, p2) --[[ IsTargetStillValid | Line: 235 | Upvalues: v1 (ref), Services (copy) ]]
	if not p2 then
		return false
	end

	local Player = p2.Player

	if not (Player and Player.Parent) then
		return false
	end

	if Player:GetAttribute("InSafeZone") == true then
		return false
	end

	if Player:GetAttribute("IsInOwnGarden") == true then
		return false
	end

	local Character = Player.Character

	if not Character then
		return false
	end

	if not Character:FindFirstChild("HumanoidRootPart") then
		return false
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid or Humanoid.Health <= 0 then
		return false
	end

	if p2.ShovelAggro then
		if not v1 then
			v1 = require(Services:WaitForChild("DragonDefenseService"))
		end

		local v12 = v1

		return (if v12 then v12:GetDragonAggroTarget(p1.Player) else v12) == Player
	end

	return Player:GetAttribute("CarryingStolenFruit") == true
end

local function PickTarget(p1) --[[ PickTarget | Line: 259 | Upvalues: v1 (ref), Services (copy) ]]
	if not v1 then
		v1 = require(Services:WaitForChild("DragonDefenseService"))
	end

	local v12 = v1

	if not v12 then
		return nil
	end

	local v2 = v12:GetDragonAggroTarget(p1.Player)

	if v2 then
		return {
			ShovelAggro = true,
			Player = v2
		}
	end

	local v3 = v12:PickTargetFor(p1.Player)

	if v3 and v3.Player then
		return {
			ShovelAggro = false,
			Player = v3.Player
		}
	end

	return nil
end

local function BuildStates() --[[ BuildStates | Line: 275 | Upvalues: PickTarget (copy), FlyToContact (copy), IsTargetStillValid (copy), TargetTorsoPosition (copy), BreatheLean (copy), v2 (ref), Services (copy), HoldFacing (copy) ]]
	return {
		Acquire = {
			Enter = function(p1) --[[ Enter | Line: 279 | Upvalues: PickTarget (ref) ]]
				local v1 = PickTarget(p1)

				if v1 then
					p1.Target = v1
					p1:TransitionTo("Approach")
				else
					p1:Stop("NoThreat")
				end
			end
		},
		Approach = {
			Enter = function(p1) --[[ Enter | Line: 291 | Upvalues: FlyToContact (ref) ]]
				local Target = p1.Target
				local v1

				if Target and Target.Player then
					local Character = Target.Player.Character

					if Character then
						local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

						v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart.Position else nil
					else
						v1 = nil
					end
				else
					v1 = nil
				end

				if not v1 then
					return
				end

				FlyToContact(p1, v1, p1.ApproachSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 296 | Upvalues: IsTargetStillValid (ref), FlyToContact (ref) ]]
				if not IsTargetStillValid(p1, p1.Target) then
					p1:TransitionTo("Return")

					return
				end

				local Target = p1.Target
				local v1

				if Target and Target.Player then
					local Character = Target.Player.Character

					if Character then
						local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

						v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart.Position else nil
					else
						v1 = nil
					end
				else
					v1 = nil
				end

				if not v1 then
					p1:TransitionTo("Return")

					return
				end

				FlyToContact(p1, v1, p1.ApproachSpeed)

				local v2 = p1.Control:GetSlotPosition()
				local v3

				if v2 then
					local v4 = v1.X - v2.X
					local v5 = v1.Z - v2.Z

					v3 = if math.sqrt(v4 * v4 + v5 * v5) <= 10 then true else false
				else
					v3 = false
				end

				if v3 then
					if p1.BreathReadyAt <= p2 then
						p1:TransitionTo("Breathe")
					else
						p1:TransitionTo("Cooldown")
					end
				elseif p1:TimeInState() >= p1.ApproachLegTimeout then
					p1:TransitionTo("Acquire")
				end
			end
		},
		Breathe = {
			Enter = function(p1) --[[ Enter | Line: 327 ]]
				local Target = p1.Target
				local v1

				if Target and Target.Player then
					local Character = Target.Player.Character

					if Character then
						local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

						v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart.Position else nil
					else
						v1 = nil
					end
				else
					v1 = nil
				end

				if v1 then
					p1._BreathAnchor = p1.Control:GetSlotPosition() or v1
					p1._BreathLastPos = v1
					p1._BreathStartAt = os.clock()
					p1._BreathFireAt = p1._BreathStartAt + p1.BreathWindup
					p1._BreathEndsAt = p1._BreathFireAt + p1.BreathDuration
					p1._BreathFired = false
				else
					p1:TransitionTo("Return")
				end
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 342 | Upvalues: TargetTorsoPosition (ref), IsTargetStillValid (ref), BreatheLean (ref), v2 (ref), Services (ref) ]]
				local v1 = TargetTorsoPosition(p1.Target)
				local Target = p1.Target
				local v22

				if Target and Target.Player then
					local Character = Target.Player.Character

					if Character then
						local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

						v22 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart.Position else nil
					else
						v22 = nil
					end
				else
					v22 = nil
				end

				if v1 then
					p1._BreathLastPos = v1
				end

				if not (p1._BreathFired and (if p2 < p1._BreathEndsAt then true else false)) then
					if not IsTargetStillValid(p1, p1.Target) then
						p1:TransitionTo("Return")

						return
					end

					if not v22 then
						p1:TransitionTo("Return")

						return
					end

					if (v22 - p1._BreathAnchor).Magnitude > p1.BreathLeash then
						p1.BreathReadyAt = p2 + p1.BreathCooldown
						p1:TransitionTo("Approach")

						return
					end
				end

				BreatheLean(p1, p1._BreathAnchor, if v1 then v1 else p1._BreathLastPos or p1._BreathAnchor, math.sin(math.clamp((p2 - p1._BreathStartAt) / math.max(0.001, p1._BreathEndsAt - p1._BreathStartAt), 0, 1) * math.pi), p1.ApproachSpeed)

				if not p1._BreathFired and p1._BreathFireAt <= p2 then
					p1._BreathFired = true

					if not v2 then
						v2 = require(Services:WaitForChild("IceSerpentFireService"))
					end

					local v10 = v2

					if v10 then
						pcall(function() --[[ Line: 385 | Upvalues: v10 (copy), p1 (copy) ]]
							v10:StartBreath(p1.Slot, p1.Player, p1.Target.Player, p1.BreathDuration, p1.DmgMult, p1.FreezeMult)
						end)
					end
				end

				if p1._BreathEndsAt <= p2 then
					p1.BreathReadyAt = p2 + p1.BreathCooldown
					p1:TransitionTo("Cooldown")
				end
			end
		},
		Cooldown = {
			Update = function(p1, p2, p3) --[[ Update | Line: 400 | Upvalues: IsTargetStillValid (ref), FlyToContact (ref), HoldFacing (ref) ]]
				if not IsTargetStillValid(p1, p1.Target) then
					p1:TransitionTo("Return")

					return
				end

				local Target = p1.Target
				local v1

				if Target and Target.Player then
					local Character = Target.Player.Character

					if Character then
						local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

						v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart.Position else nil
					else
						v1 = nil
					end
				else
					v1 = nil
				end

				if not v1 then
					p1:TransitionTo("Return")

					return
				end

				local v2 = p1.Control:GetSlotPosition()
				local v3

				if v2 then
					local v4 = v1.X - v2.X
					local v5 = v1.Z - v2.Z

					v3 = if math.sqrt(v4 * v4 + v5 * v5) <= 10 then true else false
				else
					v3 = false
				end

				if v3 then
					HoldFacing(p1, p1.Control:GetSlotPosition() or v1, v1, p1.ApproachSpeed)
				else
					FlyToContact(p1, v1, p1.ApproachSpeed)
				end

				if not (p1.BreathReadyAt <= p2) then
					return
				end

				local v6 = p1.Control:GetSlotPosition()
				local v7

				if v6 then
					local v8 = v1.X - v6.X
					local v9 = v1.Z - v6.Z

					v7 = math.sqrt(v8 * v8 + v9 * v9) <= 10
				else
					v7 = false
				end

				if v7 then
					p1:TransitionTo("Breathe")

					return
				end

				p1:TransitionTo("Approach")
			end
		},
		Return = {
			Enter = function(p1) --[[ Enter | Line: 434 ]]
				if p1.Control and p1.Control.SetSlotAttribute then
					p1.Control:SetSlotAttribute("Hovering", nil)
				end

				p1:Stop("Disengaged")
			end
		}
	}
end

function IceSerpentDefend.new(p1) --[[ new | Line: 444 | Upvalues: BehaviorBase (copy), IceSerpentDefend (copy), v4 (ref), v3 (ref), Services (copy), PetSizes (copy), t (copy), PetTypes (copy), t2 (copy), v2 (ref), BuildStates (copy) ]]
	local v1 = BehaviorBase.New(IceSerpentDefend, p1)

	if not v4 then
		v3 = require(Services:WaitForChild("DataService"))
		v4 = v3.GetPet
	end

	local v22 = v4(v3, v1.Player, v1.PetId)
	local v32 = if v22 then v22.Size else nil
	local v5 = if v22 then v22.Type else nil

	v1.ApproachSpeed = v1.Config.ApproachSpeed or 22
	v1.BreathDuration = v1.Config.BreathDuration or 1.5
	v1.BreathCooldown = v1.Config.BreathCooldown or 8
	v1.ApproachLegTimeout = v1.Config.ApproachLegTimeout or 8
	v1.BreathWindup = v1.Config.BreathWindup or 1

	local v6 = PetSizes.Normalize(v32)
	local v7 = if v6 then t[v6] or 1 else 1

	v1.DmgMult = v7 * PetTypes.GetBoostMultiplier(v5)

	local v8 = PetSizes.Normalize(v32)

	v1.FreezeMult = (if v8 then t2[v8] or 1 else 1) * (if v5 == PetTypes.Rainbow then 1.25 else 1)

	if not v2 then
		v2 = require(Services:WaitForChild("IceSerpentFireService"))
	end

	local v11 = v2

	if v11 then
		v1.StartBreathDistance = v11:GetStartBreathDistance(v32)
		v1.BreathLeash = v11:GetBreathLeash(v32)
	else
		v1.StartBreathDistance = 8
		v1.BreathLeash = 40
	end

	v1.Target = nil
	v1.BreathReadyAt = 0
	v1._BreathAnchor = nil
	v1._BreathLastPos = nil
	v1._BreathStartAt = 0
	v1._BreathFireAt = 0
	v1._BreathEndsAt = 0
	v1._BreathFired = false
	v1.States = BuildStates()

	return v1
end
function IceSerpentDefend.GetInitialState(p1) --[[ GetInitialState | Line: 488 ]]
	return "Acquire"
end
function IceSerpentDefend.OnStop(p1, p2) --[[ OnStop | Line: 492 ]]
	if not (p1.Control and p1.Control.SetSlotAttribute) then
		return
	end

	p1.Control:SetSlotAttribute("Hovering", nil)
end
function IceSerpentDefend.CanStart(p1) --[[ CanStart | Line: 496 | Upvalues: PickTarget (copy) ]]
	local Player = p1.Player

	if not (Player and Player.Parent) then
		return false
	end

	return PickTarget(p1) ~= nil
end

return IceSerpentDefend