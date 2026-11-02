--credit to leon games studio
local BehaviorBase = require(script.Parent.BehaviorBase)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedModules = ReplicatedStorage:WaitForChild("SharedModules")
local Networking = require(SharedModules.Networking)
local PetTypes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetTypes"))
local PetSizes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetSizes"))
local PetData = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetData"))
local Services = game:GetService("ServerScriptService"):WaitForChild("Services")
local v1 = nil

local function GetBeeDefenseService() --[[ GetBeeDefenseService | Line: 32 | Upvalues: v1 (ref), Services (copy) ]]
	if v1 then
		return v1
	end

	v1 = require(Services:WaitForChild("BeeDefenseService"))

	return v1
end

local v2 = nil

local function GetPetBehaviorService() --[[ GetPetBehaviorService | Line: 40 | Upvalues: v2 (ref), Services (copy) ]]
	if v2 then
		return v2
	end

	v2 = require(Services:WaitForChild("PetBehaviorService"))

	return v2
end

local v3 = nil
local v4 = nil

local function GetPetRecord(p1, p2) --[[ GetPetRecord | Line: 52 | Upvalues: v4 (ref), v3 (ref), Services (copy) ]]
	if v4 then
		return v4(v3, p1, p2)
	end

	v3 = require(Services:WaitForChild("DataService"))
	v4 = v3.GetPet

	return v4(v3, p1, p2)
end

local t = {
	Big = 1.75,
	Huge = 2.5
}

local function StingDurationMultiplierForSize(p1) --[[ StingDurationMultiplierForSize | Line: 90 | Upvalues: PetSizes (copy), t (copy) ]]
	local v1 = PetSizes.Normalize(p1)

	if v1 then
		return t[v1] or 1
	end

	return 1
end

local t2 = {
	Big = 1.5,
	Huge = 1.75
}

local function SwarmSpeedMultiplierForSize(p1) --[[ SwarmSpeedMultiplierForSize | Line: 106 | Upvalues: PetSizes (copy), t2 (copy) ]]
	local v1 = PetSizes.Normalize(p1)

	if v1 then
		return t2[v1] or 1
	end

	return 1
end

local v5 = setmetatable({}, {
	__mode = "k"
})
local v6 = setmetatable({}, {
	__mode = "k"
})

local function GetLastStingAt(p1, p2) --[[ GetLastStingAt | Line: 128 | Upvalues: v6 (copy) ]]
	local v1 = v6[p1]

	if v1 then
		return v1[p2]
	end

	return nil
end

local function MarkLastStingAt(p1, p2, p3) --[[ MarkLastStingAt | Line: 134 | Upvalues: v6 (copy) ]]
	local v1 = v6[p1]

	if not v1 then
		v1 = {}
		v6[p1] = v1
	end

	v1[p2] = p3
end

local DefendGarden = setmetatable({}, {
	__index = BehaviorBase
})

DefendGarden.__index = DefendGarden
DefendGarden.Name = "DefendGarden"

local function MakeGoalCFrame(p1, p2) --[[ MakeGoalCFrame | Line: 150 ]]
	local v1 = p2 - p1

	if v1.Magnitude < 0.001 then
		return CFrame.new(p2)
	end

	return CFrame.lookAt(p2, p2 + v1.Unit)
end

local function FlyTo(p1, p2, p3) --[[ FlyTo | Line: 162 ]]
	local v1 = p1.Control:GetSlotPosition()

	if not v1 then
		return
	end

	local v2 = p2 - v1

	p1.Control:SetGoal(if v2.Magnitude < 0.001 then CFrame.new(p2) else CFrame.lookAt(p2, p2 + v2.Unit), p3)
end

local function FlyToContact(p1, p2, p3) --[[ FlyToContact | Line: 175 ]]
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

local function ClearCombatHover(p1) --[[ ClearCombatHover | Line: 189 ]]
	if not (p1.Control and p1.Control.SetSlotAttribute) then
		return
	end

	p1.Control:SetSlotAttribute("Hovering", nil)
end

local function DistanceTo(p1, p2) --[[ DistanceTo | Line: 195 ]]
	local v1 = p1.Control:GetSlotPosition()

	if v1 then
		return (p2 - v1).Magnitude
	end

	return (1 / 0)
end

local function TargetKey(p1) --[[ TargetKey | Line: 201 ]]
	if not p1 then
		return nil
	end

	if p1.Kind == "Player" and p1.Player then
		return "P:" .. tostring(p1.Player.UserId)
	end

	if p1.Kind == "Raccoon" and (p1.RaccoonOwner and p1.RaccoonPetId) then
		local v1 = tostring(p1.RaccoonOwner.UserId)

		return "R:" .. v1 .. ":" .. tostring(p1.RaccoonPetId)
	end

	return nil
end

local function TargetPosition(p1) --[[ TargetPosition | Line: 214 ]]
	if not p1 then
		return nil
	end

	if p1.Kind == "Player" and p1.Player then
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

	if p1.Kind == "Raccoon" and (p1.Slot and p1.Slot.Parent) then
		return p1.Slot.Position
	end

	return nil
end

local function IsTargetStillValid(p1, p2) --[[ IsTargetStillValid | Line: 236 | Upvalues: v1 (ref), Services (copy) ]]
	if not p2 then
		return false
	end

	if p2.Kind == "Player" then
		local Player = p2.Player

		if not (Player and Player.Parent) then
			return false
		end

		if Player:GetAttribute("InSafeZone") == true then
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

		if not p2.ShovelAggro then
			return true
		end

		if not v1 then
			v1 = require(Services:WaitForChild("BeeDefenseService"))
		end

		local v12 = v1

		if (if v12 then v12:GetShovelAggroTarget(p1.Player) else v12) == Player then
			return true
		end

		return false
	end

	if p2.Kind ~= "Raccoon" then
		return false
	end

	if not (p2.Slot and p2.Slot.Parent) then
		return false
	end

	if p2.Slot:GetAttribute("PetSpecies") == "Raccoon" then
		return p2.Slot:GetAttribute("PetClaim") == "StealFruit"
	end

	return false
end

local function GetHomePos(p1) --[[ GetHomePos | Line: 268 ]]
	local v1 = nil
	local v2 = p1.Player:GetAttribute("PlotId")

	if type(v2) == "number" then
		local Gardens = workspace:FindFirstChild("Gardens")

		if Gardens then
			v1 = Gardens:FindFirstChild("Plot" .. tostring(v2))
		end
	end

	if not v1 then
		return nil
	end

	local SpawnPoint = v1:FindFirstChild("SpawnPoint")

	if SpawnPoint and SpawnPoint:IsA("BasePart") then
		return SpawnPoint.Position
	end

	if v1:IsA("Model") then
		return v1:GetPivot().Position
	end

	return nil
end

local function FireSting(p1, p2) --[[ FireSting | Line: 289 | Upvalues: v4 (ref), v3 (ref), Services (copy), v1 (ref), PetSizes (copy), t (copy), PetTypes (copy), PetData (copy), Networking (copy) ]]
	if not (p2 and p2.Parent) then
		return
	end

	if not v4 then
		v3 = require(Services:WaitForChild("DataService"))
		v4 = v3.GetPet
	end

	local v12 = v4(v3, p1.Player, p1.PetId)
	local v2 = if v12 then v12.Size else nil

	if not v1 then
		v1 = require(Services:WaitForChild("BeeDefenseService"))
	end

	local v32 = v1
	local v42

	if v32 then
		local v5 = PetSizes.Normalize(v2)
		local v6 = if v5 then t[v5] or 1 else 1

		v42 = v32:ApplyStingEffect(p2, v6 * PetTypes.GetBoostMultiplier(if v12 then v12.Type else nil))
	else
		v42 = 0
	end

	local v8 = p1.Slot and p1.Slot:GetAttribute("PetSpecies")
	local v9 = if typeof(v8) == "string" and v8 ~= "" then PetData.GetDisplayName(v8, v2) else "Bee"

	pcall(function() --[[ Line: 314 | Upvalues: Networking (ref), p2 (copy), p1 (copy), v9 (copy) ]]
		Networking.Notification:FireClient(p2, (("%*\'s %* stung you! You feel woozy..."):format(p1.Player.Name, v9)))
	end)
	pcall(function() --[[ Line: 321 | Upvalues: Networking (ref), p2 (copy), v42 (ref) ]]
		Networking.Bee.Sting:FireClient(p2, v42)
	end)

	local Character = p2.Character

	if not Character then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local v11 = HumanoidRootPart.Position - (p1.Control:GetSlotPosition() or HumanoidRootPart.Position)
	local v122 = Vector3.new(v11.X, 0, v11.Z)
	local v13

	if v122.Magnitude < 0.001 then
		local v14 = HumanoidRootPart.CFrame.LookVector * -1
		local v15 = Vector3.new(v14.X, 0, v14.Z)

		v13 = if v15.Magnitude < 0.001 then Vector3.new(0, 0, -1) else v15.Unit
	else
		v13 = v122.Unit
	end

	local v16

	if not Humanoid then
		v16 = Instance.new("BodyVelocity")
		v16.MaxForce = Vector3.new(inf, inf, inf)
		v16.Velocity = v13 * 6 + Vector3.new(0, 12, 0)
		v16.Parent = HumanoidRootPart
		task.delay(0.3, function() --[[ Line: 365 | Upvalues: v16 (copy) ]]
			if not (v16 and v16.Parent) then
				return
			end

			v16:Destroy()
		end)

		return
	end

	Humanoid.PlatformStand = true
	task.delay(0.5, function() --[[ Line: 352 | Upvalues: Humanoid (copy) ]]
		if not (Humanoid and Humanoid.Parent) then
			return
		end

		Humanoid.PlatformStand = false
	end)
	v16 = Instance.new("BodyVelocity")
	v16.MaxForce = Vector3.new(inf, inf, inf)
	v16.Velocity = v13 * 6 + Vector3.new(0, 12, 0)
	v16.Parent = HumanoidRootPart
	task.delay(0.3, function() --[[ Line: 365 | Upvalues: v16 (copy) ]]
		if not (v16 and v16.Parent) then
			return
		end

		v16:Destroy()
	end)
end

local function TryHit(p1, p2, p3) --[[ TryHit | Line: 381 | Upvalues: TargetKey (copy), v6 (copy), v1 (ref), Services (copy), FireSting (copy), v2 (ref) ]]
	local v12 = TargetKey(p2)

	if not v12 then
		return false
	end

	if p2.Kind == "Player" and p2.Player then
		local Player = p2.Player
		local v22 = v6[p1.Slot]
		local v3 = if v22 then v22[v12] else nil

		if v3 and p3 - v3 < p1.StingCooldown then
			return false
		end

		if not v1 then
			v1 = require(Services:WaitForChild("BeeDefenseService"))
		end

		local v4 = v1

		if v4 and v4:IsTargetStingInvulnerable(Player) then
			return false
		end

		local Slot = p1.Slot
		local v5 = v6[Slot]

		if not v5 then
			v5 = {}
			v6[Slot] = v5
		end

		v5[v12] = p3

		if v4 then
			v4:MarkTargetStung(Player)
		end

		FireSting(p1, Player)
	else
		if p2.Kind ~= "Raccoon" or not (p2.RaccoonOwner and p2.RaccoonPetId) then
			return false
		end

		if not v2 then
			v2 = require(Services:WaitForChild("PetBehaviorService"))
		end

		local v62 = v2

		if not v62 then
			return true
		end

		pcall(function() --[[ Line: 409 | Upvalues: v62 (copy), p2 (copy), p1 (copy) ]]
			v62:OnPetScared(p2.RaccoonOwner, p2.RaccoonPetId, p1.Player)
		end)
	end

	return true
end

local function IsShovelAggroOnCooldown(p1) --[[ IsShovelAggroOnCooldown | Line: 420 | Upvalues: v5 (copy) ]]
	if not p1 then
		return false
	end

	local v1 = v5[p1]

	return if v1 == nil then false else os.clock() < v1
end

local function MarkShovelAggroStarted(p1, p2) --[[ MarkShovelAggroStarted | Line: 426 | Upvalues: v5 (copy) ]]
	if p1 then
		v5[p1] = os.clock() + p2
	end
end

local function BuildStates() --[[ BuildStates | Line: 431 | Upvalues: v1 (ref), Services (copy), v5 (copy), TargetPosition (copy), FlyToContact (copy), IsTargetStillValid (copy), TryHit (copy), GetHomePos (copy) ]]
	return {
		Acquire = {
			Enter = function(p1) --[[ Enter | Line: 438 | Upvalues: v1 (ref), Services (ref), v5 (ref) ]]
				if not v1 then
					v1 = require(Services:WaitForChild("BeeDefenseService"))
				end

				local v12 = v1

				if v12 then
					local Slot = p1.Slot
					local v2

					if Slot then
						local v3 = v5[Slot]

						v2 = if v3 == nil then false else os.clock() < v3
					else
						v2 = false
					end

					if not v2 then
						local v4 = v12:GetShovelAggroTarget(p1.Player)

						if v4 then
							local Slot2 = p1.Slot
							local ShovelAggroCooldown = p1.ShovelAggroCooldown

							if not Slot2 then
								p1.Target = {
									Kind = "Player",
									ShovelAggro = true,
									Player = v4
								}
								p1:TransitionTo("Dive")

								return
							end

							v5[Slot2] = os.clock() + ShovelAggroCooldown
							p1.Target = {
								Kind = "Player",
								ShovelAggro = true,
								Player = v4
							}
							p1:TransitionTo("Dive")

							return
						end
					end
				end

				local v52 = if v12 then v12:PickTargetFor(p1.Player) else v12

				if v52 then
					p1.Target = v52
					p1:TransitionTo("Dive")
				else
					p1:Stop("NoThreat")
				end
			end
		},
		Dive = {
			Enter = function(p1) --[[ Enter | Line: 472 | Upvalues: TargetPosition (ref), FlyToContact (ref) ]]
				local v1 = TargetPosition(p1.Target)

				if not v1 then
					return
				end

				FlyToContact(p1, v1, p1.AttackSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 477 | Upvalues: IsTargetStillValid (ref), TargetPosition (ref), FlyToContact (ref), TryHit (ref) ]]
				if not IsTargetStillValid(p1, p1.Target) then
					p1:TransitionTo("Acquire")

					return
				end

				local v1 = TargetPosition(p1.Target)

				if not v1 then
					p1:TransitionTo("Acquire")

					return
				end

				FlyToContact(p1, v1, p1.AttackSpeed)

				local v2 = p1.Control:GetSlotPosition()

				if (if v2 then (v1 - v2).Magnitude else (1 / 0)) <= p1.HitRadius then
					TryHit(p1, p1.Target, p2)
					p1:TransitionTo("Orbit")

					return
				end

				if p1:TimeInState() >= p1.DiveLegTimeout then
					p1:TransitionTo("Acquire")
				end
			end
		},
		Orbit = {
			Enter = function(p1) --[[ Enter | Line: 510 | Upvalues: TargetPosition (ref), FlyToContact (ref) ]]
				local v1 = TargetPosition(p1.Target)

				if not v1 then
					return
				end

				local v2 = math.random() * math.pi * 2
				local v3 = p1.OrbitYMin + math.random() * (p1.OrbitYMax - p1.OrbitYMin)

				p1._OrbitBaseY = v3

				local v4 = v3 + (math.random() * 2 - 1) * p1.OrbitYJitter

				FlyToContact(p1, v1 + Vector3.new(math.cos(v2) * p1.OrbitRadius, v4, math.sin(v2) * p1.OrbitRadius), p1.AttackSpeed)
				p1._OrbitAngle = v2
				p1._OrbitDir = if math.random() < 0.5 then 1 else -1
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 532 | Upvalues: TargetPosition (ref), FlyToContact (ref), v1 (ref), Services (ref), v5 (ref), IsTargetStillValid (ref) ]]
				local v12 = TargetPosition(p1.Target)

				if v12 and p1._OrbitAngle then
					p1._OrbitAngle = p1._OrbitAngle + p1._OrbitDir * 4 * p3

					local v2 = p1._OrbitBaseY + (math.random() * 2 - 1) * p1.OrbitYJitter

					FlyToContact(p1, v12 + Vector3.new(math.cos(p1._OrbitAngle) * p1.OrbitRadius, v2, math.sin(p1._OrbitAngle) * p1.OrbitRadius), p1.AttackSpeed)
				end

				if p1:TimeInState() < p1.OrbitDuration then
					return
				end

				if not v1 then
					v1 = require(Services:WaitForChild("BeeDefenseService"))
				end

				local v52 = v1
				local v6 = p1.Target and p1.Target.ShovelAggro

				if v52 and not v6 then
					local Slot = p1.Slot
					local v7

					if Slot then
						local v8 = v5[Slot]

						v7 = if v8 == nil then false else os.clock() < v8
					else
						v7 = false
					end

					if not v7 then
						local v9 = v52:GetShovelAggroTarget(p1.Player)

						if v9 then
							local Slot2 = p1.Slot
							local ShovelAggroCooldown = p1.ShovelAggroCooldown

							if not Slot2 then
								p1.Target = {
									Kind = "Player",
									ShovelAggro = true,
									Player = v9
								}
								p1:TransitionTo("Dive")

								return
							end

							v5[Slot2] = os.clock() + ShovelAggroCooldown
							p1.Target = {
								Kind = "Player",
								ShovelAggro = true,
								Player = v9
							}
							p1:TransitionTo("Dive")

							return
						end
					end
				end

				if v6 then
					if IsTargetStillValid(p1, p1.Target) then
						p1:TransitionTo("Dive")
					else
						p1:TransitionTo("Return")
					end
				else
					local v10 = if v52 then v52:PickTargetFor(p1.Player) else v52

					if v10 then
						p1.Target = v10
						p1:TransitionTo("Dive")
					else
						p1:TransitionTo("Return")
					end
				end
			end
		},
		Return = {
			Enter = function(p1) --[[ Enter | Line: 599 | Upvalues: GetHomePos (ref) ]]
				if p1.Control and p1.Control.SetSlotAttribute then
					p1.Control:SetSlotAttribute("Hovering", nil)
				end

				p1.HomePos = GetHomePos(p1)

				if not p1.HomePos then
					return
				end

				local HomePos = p1.HomePos
				local v1 = p1.Control:GetSlotPosition()

				if not v1 then
					return
				end

				local v2 = HomePos - v1

				p1.Control:SetGoal(if v2.Magnitude < 0.001 then CFrame.new(HomePos) else CFrame.lookAt(HomePos, HomePos + v2.Unit), p1.ReturnSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 609 ]]
				if not p1.HomePos then
					p1:Stop("NoHome")

					return
				end

				local HomePos = p1.HomePos
				local ReturnSpeed = p1.ReturnSpeed
				local v1 = p1.Control:GetSlotPosition()

				if v1 then
					local v2 = HomePos - v1

					p1.Control:SetGoal(if v2.Magnitude < 0.001 then CFrame.new(HomePos) else CFrame.lookAt(HomePos, HomePos + v2.Unit), ReturnSpeed)
				end

				local v6 = p1.Control:GetSlotPosition()

				if (if v6 then (p1.HomePos - v6).Magnitude else (1 / 0)) <= p1.ReturnArriveRadius then
					p1:Stop("Returned")

					return
				end

				if p1:TimeInState() >= p1.ReturnLegTimeout then
					p1:Stop("ReturnTimeout")
				end
			end
		}
	}
end

function DefendGarden.new(p1) --[[ new | Line: 631 | Upvalues: BehaviorBase (copy), DefendGarden (copy), v4 (ref), v3 (ref), Services (copy), PetTypes (copy), PetSizes (copy), t2 (copy), BuildStates (copy) ]]
	local v1 = BehaviorBase.New(DefendGarden, p1)

	if not v4 then
		v3 = require(Services:WaitForChild("DataService"))
		v4 = v3.GetPet
	end

	local v2 = v4(v3, v1.Player, v1.PetId)
	local v5 = PetTypes.GetBoostMultiplier(if v2 then v2.Type else nil)
	local v7 = PetSizes.Normalize(if v2 then v2.Size else nil)

	v1.AttackSpeed = (v1.Config.AttackSpeed or 27) * (v5 * (if v7 then t2[v7] or 1 else 1))
	v1.ReturnSpeed = v1.Config.ReturnSpeed or 27
	v1.StingCooldown = v1.Config.StingCooldown or 10
	v1.HitRadius = v1.Config.HitRadius or 3.5
	v1.OrbitRadius = v1.Config.OrbitRadius or 9
	v1.OrbitDuration = v1.Config.OrbitDuration or 0.8
	v1.OrbitYJitter = v1.Config.OrbitYJitter or 1
	v1.OrbitYMin = v1.Config.OrbitYMin or -1
	v1.OrbitYMax = v1.Config.OrbitYMax or 5
	v1.DiveLegTimeout = v1.Config.DiveLegTimeout or 2.5
	v1.ReturnLegTimeout = v1.Config.ReturnLegTimeout or 6
	v1.ReturnArriveRadius = v1.Config.ReturnArriveRadius or 6
	v1.ShovelAggroCooldown = v1.Config.ShovelAggroCooldown or 10
	v1.Target = nil
	v1.HomePos = nil
	v1._OrbitAngle = nil
	v1._OrbitDir = 1
	v1._OrbitBaseY = 0
	v1.States = BuildStates()

	return v1
end
function DefendGarden.GetInitialState(p1) --[[ GetInitialState | Line: 667 ]]
	return "Acquire"
end
function DefendGarden.OnStop(p1, p2) --[[ OnStop | Line: 675 ]]
	if not (p1.Control and p1.Control.SetSlotAttribute) then
		return
	end

	p1.Control:SetSlotAttribute("Hovering", nil)
end
function DefendGarden.CanStart(p1) --[[ CanStart | Line: 682 | Upvalues: v1 (ref), Services (copy), v5 (copy) ]]
	local Player = p1.Player

	if not (Player and Player.Parent) then
		return false
	end

	if not v1 then
		v1 = require(Services:WaitForChild("BeeDefenseService"))
	end

	local v12 = v1

	if not v12 then
		return false
	end

	local Slot = p1.Slot
	local v2

	if Slot then
		local v3 = v5[Slot]

		v2 = if v3 == nil then false elseif os.clock() < v3 then true else false
	else
		v2 = false
	end

	if not v2 and v12:GetShovelAggroTarget(Player) then
		return true
	end

	return v12:PickTargetFor(Player) ~= nil
end

return DefendGarden