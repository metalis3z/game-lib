--credit to prince games studio
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

local function GetDragonFireService() --[[ GetDragonFireService | Line: 29 | Upvalues: v2 (ref), Services (copy) ]]
	if v2 then
		return v2
	end

	v2 = require(Services:WaitForChild("DragonFireService"))

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

local function DamageMultiplierForSize(p1) --[[ DamageMultiplierForSize | Line: 66 | Upvalues: PetSizes (copy), t (copy) ]]
	local v1 = PetSizes.Normalize(p1)

	if v1 then
		return t[v1] or 1
	end

	return 1
end

local BlackDragonDefend = setmetatable({}, {
	__index = BehaviorBase
})

BlackDragonDefend.__index = BlackDragonDefend
BlackDragonDefend.Name = "BlackDragonDefend"

local function MakeGoalCFrame(p1, p2) --[[ MakeGoalCFrame | Line: 81 ]]
	local v1 = p2 - p1

	if v1.Magnitude < 0.001 then
		return CFrame.new(p2)
	end

	return CFrame.lookAt(p2, p2 + v1.Unit)
end

local function FlyToContact(p1, p2, p3) --[[ FlyToContact | Line: 92 ]]
	local v1 = p1.Control:GetSlotPosition()

	if not v1 then
		return
	end

	local v2 = 0

	if p1.Module and p1.Module.IsFlying and type(p1.Module.AirHeight) == "number" then
		v2 = p1.Module.AirHeight
	end

	local v4 = Vector3.new(p2.X, p2.Y - v2, p2.Z)

	p1.Control:SetSlotAttribute("Hovering", true)

	local v5 = v4 - v1

	p1.Control:SetGoal(if v5.Magnitude < 0.001 then CFrame.new(v4) else CFrame.lookAt(v4, v4 + v5.Unit), p3)
end

local function HoldFacing(p1, p2, p3, p4) --[[ HoldFacing | Line: 106 ]]
	local v1 = 0

	if p1.Module and p1.Module.IsFlying and type(p1.Module.AirHeight) == "number" then
		v1 = p1.Module.AirHeight
	end

	local v3 = Vector3.new(p2.X, p2.Y - v1, p2.Z)

	p1.Control:SetSlotAttribute("Hovering", true)

	local v4 = p3 - v3

	p1.Control:SetGoal(if v4.Magnitude < 0.001 then CFrame.new(p3) else CFrame.lookAt(p3, p3 + v4.Unit), p4)
end

local function ClearCombatHover(p1) --[[ ClearCombatHover | Line: 116 ]]
	if not (p1.Control and p1.Control.SetSlotAttribute) then
		return
	end

	p1.Control:SetSlotAttribute("Hovering", nil)
end

local function DistanceTo(p1, p2) --[[ DistanceTo | Line: 122 ]]
	local v1 = p1.Control:GetSlotPosition()

	if v1 then
		return (p2 - v1).Magnitude
	end

	return (1 / 0)
end

local function TargetPosition(p1) --[[ TargetPosition | Line: 129 ]]
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

local function IsTargetStillValid(p1, p2) --[[ IsTargetStillValid | Line: 141 | Upvalues: v1 (ref), Services (copy) ]]
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

	if not v1 then
		v1 = require(Services:WaitForChild("DragonDefenseService"))
	end

	local v12 = v1

	if v12 and v12:IsPlayerAtOwnPlot(Player) then
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

		local v2 = v1

		return (if v2 then v2:GetDragonAggroTarget(p1.Player) else v2) == Player
	end

	return Player:GetAttribute("CarryingStolenFruit") == true
end

local function PickTarget(p1) --[[ PickTarget | Line: 170 | Upvalues: v1 (ref), Services (copy) ]]
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

local function BuildStates() --[[ BuildStates | Line: 186 | Upvalues: PickTarget (copy), FlyToContact (copy), IsTargetStillValid (copy), HoldFacing (copy), v2 (ref), Services (copy) ]]
	return {
		Acquire = {
			Enter = function(p1) --[[ Enter | Line: 190 | Upvalues: PickTarget (ref) ]]
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
			Enter = function(p1) --[[ Enter | Line: 202 | Upvalues: FlyToContact (ref) ]]
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
			Update = function(p1, p2, p3) --[[ Update | Line: 207 | Upvalues: IsTargetStillValid (ref), FlyToContact (ref) ]]
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

				if (if v2 then (v1 - v2).Magnitude else (1 / 0)) <= p1.StartBreathDistance then
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
			Enter = function(p1) --[[ Enter | Line: 238 ]]
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
					p1._BreathFireAt = os.clock() + p1.BreathWindup
					p1._BreathEndsAt = p1._BreathFireAt + p1.BreathDuration
					p1._BreathFired = false
				else
					p1:TransitionTo("Return")
				end
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 251 | Upvalues: IsTargetStillValid (ref), HoldFacing (ref), v2 (ref), Services (ref) ]]
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

				if (v1 - p1._BreathAnchor).Magnitude > p1.BreathLeash then
					p1.BreathReadyAt = p2 + p1.BreathCooldown
					p1:TransitionTo("Approach")

					return
				end

				HoldFacing(p1, p1._BreathAnchor, v1, p1.ApproachSpeed)

				if not p1._BreathFired and p1._BreathFireAt <= p2 then
					p1._BreathFired = true

					if not v2 then
						v2 = require(Services:WaitForChild("DragonFireService"))
					end

					local v22 = v2

					if v22 then
						pcall(function() --[[ Line: 277 | Upvalues: v22 (copy), p1 (copy) ]]
							v22:StartBreath(p1.Slot, p1.Player, p1.Target.Player, p1.BreathDuration, p1.DmgMult)
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
			Update = function(p1, p2, p3) --[[ Update | Line: 292 | Upvalues: IsTargetStillValid (ref), FlyToContact (ref), HoldFacing (ref) ]]
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

				if p1.StartBreathDistance < (if v2 then (v1 - v2).Magnitude else (1 / 0)) then
					FlyToContact(p1, v1, p1.ApproachSpeed)
				else
					HoldFacing(p1, p1.Control:GetSlotPosition() or v1, v1, p1.ApproachSpeed)
				end

				if not (p1.BreathReadyAt <= p2) then
					return
				end

				local v4 = p1.Control:GetSlotPosition()

				if (if v4 then (v1 - v4).Magnitude else (1 / 0)) <= p1.BreathLeash then
					p1:TransitionTo("Breathe")

					return
				end

				p1:TransitionTo("Approach")
			end
		},
		Return = {
			Enter = function(p1) --[[ Enter | Line: 326 ]]
				if p1.Control and p1.Control.SetSlotAttribute then
					p1.Control:SetSlotAttribute("Hovering", nil)
				end

				p1:Stop("Disengaged")
			end
		}
	}
end

function BlackDragonDefend.new(p1) --[[ new | Line: 336 | Upvalues: BehaviorBase (copy), BlackDragonDefend (copy), v4 (ref), v3 (ref), Services (copy), PetSizes (copy), t (copy), PetTypes (copy), v2 (ref), BuildStates (copy) ]]
	local v1 = BehaviorBase.New(BlackDragonDefend, p1)

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
	v1.BreathWindup = v1.Config.BreathWindup or 1.5

	local v6 = PetSizes.Normalize(v32)
	local v7 = if v6 then t[v6] or 1 else 1

	v1.DmgMult = v7 * PetTypes.GetBoostMultiplier(v5)

	if not v2 then
		v2 = require(Services:WaitForChild("DragonFireService"))
	end

	local v8 = v2

	if v8 then
		v1.StartBreathDistance = v8:GetStartBreathDistance(v32)
		v1.BreathLeash = v8:GetBreathLeash(v32)
	else
		v1.StartBreathDistance = 8
		v1.BreathLeash = 40
	end

	v1.Target = nil
	v1.BreathReadyAt = 0
	v1._BreathAnchor = nil
	v1._BreathFireAt = 0
	v1._BreathEndsAt = 0
	v1._BreathFired = false
	v1.States = BuildStates()

	return v1
end
function BlackDragonDefend.GetInitialState(p1) --[[ GetInitialState | Line: 375 ]]
	return "Acquire"
end
function BlackDragonDefend.OnStop(p1, p2) --[[ OnStop | Line: 379 ]]
	if not (p1.Control and p1.Control.SetSlotAttribute) then
		return
	end

	p1.Control:SetSlotAttribute("Hovering", nil)
end
function BlackDragonDefend.CanStart(p1) --[[ CanStart | Line: 383 | Upvalues: PickTarget (copy) ]]
	local Player = p1.Player

	if not (Player and Player.Parent) then
		return false
	end

	return PickTarget(p1) ~= nil
end

return BlackDragonDefend