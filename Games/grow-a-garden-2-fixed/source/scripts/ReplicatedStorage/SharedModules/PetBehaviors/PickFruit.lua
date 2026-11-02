--credit to leon games studio
local BehaviorBase = require(script.Parent.BehaviorBase)
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Services = ServerScriptService:WaitForChild("Services")
local DataService = require(Services.DataService)
local ObjectPositionService = require(Services.ObjectPositionService)
local PetData = require(ReplicatedStorage.SharedData.PetData)
local PetSizes = require(ReplicatedStorage.SharedData.PetSizes)
local PetTypes = require(ReplicatedStorage.SharedData.PetTypes)
local RarityVisuals = require(ReplicatedStorage.SharedModules.RarityVisuals)
local t = {}

for v1, v2 in require(ReplicatedStorage.SharedModules.SeedData) do
	if type(v2) == "table" and type(v2.SeedName) == "string" then
		t[v2.SeedName] = v2.Rarity or "Common"
	end
end

local function GetFruitRarity(p1) --[[ GetFruitRarity | Line: 33 | Upvalues: t (copy) ]]
	return t[p1] or "Common"
end

local function GetSpeciesRarity(p1) --[[ GetSpeciesRarity | Line: 37 | Upvalues: PetData (copy) ]]
	local v1 = PetData[p1]

	if type(v1) ~= "table" then
		return "Common"
	end

	if type(v1.Rarity) == "string" then
		return v1.Rarity
	end

	return "Common"
end

local v3 = nil

local function GetMonkeyService() --[[ GetMonkeyService | Line: 47 | Upvalues: v3 (ref), Services (copy) ]]
	if v3 then
		return v3
	end

	v3 = require(Services:WaitForChild("MonkeyService"))

	return v3
end

local t2 = {
	Big = 1.3,
	Huge = 1.6
}
local PickFruit = setmetatable({}, {
	__index = BehaviorBase
})

PickFruit.__index = PickFruit
PickFruit.Name = "PickFruit"

local function OwnerIsHome(p1) --[[ OwnerIsHome | Line: 78 ]]
	return p1:GetAttribute("IsInOwnGarden") == true
end

local function PickRandomOwnFruit(p1) --[[ PickRandomOwnFruit | Line: 83 | Upvalues: DataService (copy), v3 (ref), Services (copy) ]]
	local v1 = DataService:GetAllPlants(p1)

	if not v1 then
		return nil
	end

	if not v3 then
		v3 = require(Services:WaitForChild("MonkeyService"))
	end

	local v2 = v3
	local t = {}

	for k, v in pairs(v1) do
		if not v.IsPotted then
			local Fruits = v.Fruits

			if Fruits then
				for k2, v4 in pairs(Fruits) do
					if type(v4) == "table" and (v4.Age and (v4.MaxAge and not (v4.Age < v4.MaxAge or v2:IsFruitReserved(p1, k, k2)))) then
						table.insert(t, {
							PlantId = k,
							FruitId = k2,
							PlantData = v,
							FruitData = v4
						})
					end
				end
			end
		end
	end

	if #t == 0 then
		return nil
	end

	return t[math.random(1, #t)]
end

local function FruitIsStillValid(p1, p2, p3) --[[ FruitIsStillValid | Line: 115 | Upvalues: DataService (copy) ]]
	if not (p1 and p1.Parent) then
		return false
	end

	local v1 = DataService:GetFruit(p1, p2, p3)

	if not v1 then
		return false
	end

	if v1.Age and v1.MaxAge then
		return not (v1.Age < v1.MaxAge)
	end

	return false
end

local function MakeGoalCFrame(p1, p2) --[[ MakeGoalCFrame | Line: 125 ]]
	local v3 = Vector3.new(p2.X - p1.X, 0, p2.Z - p1.Z)

	if v3.Magnitude < 0.001 then
		return CFrame.new(p2)
	end

	return CFrame.lookAt(p2, p2 + v3.Unit)
end

local function WalkTo(p1, p2, p3) --[[ WalkTo | Line: 133 ]]
	local v1 = p1.Control:GetSlotPosition()

	if not v1 then
		return
	end

	local v4 = Vector3.new(p2.X - v1.X, 0, p2.Z - v1.Z)

	p1.Control:SetGoal(if v4.Magnitude < 0.001 then CFrame.new(p2) else CFrame.lookAt(p2, p2 + v4.Unit), p3)
end

local function DistanceTo(p1, p2) --[[ DistanceTo | Line: 139 ]]
	local v1 = p1.Control:GetSlotPosition()

	if v1 then
		local v2 = p2.X - v1.X
		local v3 = p2.Z - v1.Z

		return math.sqrt(v2 * v2 + v3 * v3)
	end

	return (1 / 0)
end

local function OwnerPosition(p1) --[[ OwnerPosition | Line: 148 ]]
	local Character = p1.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
		return HumanoidRootPart.Position
	end

	return nil
end

local function GetSpeedMultiplier(p1) --[[ GetSpeedMultiplier | Line: 158 | Upvalues: PetSizes (copy), t2 (copy), PetTypes (copy) ]]
	if not p1 then
		return 1
	end

	local v1 = 1
	local v2 = PetSizes.Normalize(p1:GetAttribute("PetSize"))

	if v2 and t2[v2] then
		v1 = v1 * t2[v2]
	end

	if p1:GetAttribute("PetType") == PetTypes.Rainbow then
		v1 = v1 * 1.15
	end

	return v1
end

local function ClearCarryAttributes(p1) --[[ ClearCarryAttributes | Line: 171 ]]
	p1:SetSlotAttribute("CarryingFruit", nil)
	p1:SetSlotAttribute("CarryingFruitSeed", nil)
	p1:SetSlotAttribute("CarryingFruitSize", nil)
	p1:SetSlotAttribute("CarryingFruitOvertimeGrowth", nil)
	p1:SetSlotAttribute("CarryingFruitMutation", nil)
end

local function BuildStates() --[[ BuildStates | Line: 179 | Upvalues: PickRandomOwnFruit (copy), v3 (ref), Services (copy), ObjectPositionService (copy), DataService (copy), ClearCarryAttributes (copy), RarityVisuals (copy), PetData (copy), t (copy) ]]
	return {
		Targeting = {
			Enter = function(p1) --[[ Enter | Line: 184 | Upvalues: PickRandomOwnFruit (ref), v3 (ref), Services (ref), ObjectPositionService (ref) ]]
				local v1 = PickRandomOwnFruit(p1.Player)

				if not v1 then
					p1:Stop("NoFruit")

					return
				end

				if not v3 then
					v3 = require(Services:WaitForChild("MonkeyService"))
				end

				if not v3:TryReserve(p1.Player, v1.PlantId, v1.FruitId) then
					p1:Stop("Reserved")

					return
				end

				p1.PlantId = v1.PlantId
				p1.FruitId = v1.FruitId
				p1.FruitName = v1.PlantData.PlantName
				p1.Reserved = true

				local v2 = ObjectPositionService:GetStoredFruitEntry(p1.Player, v1.FruitId)
				local v32 = if v2 then v2.Position else v2

				if typeof(v32) == "Vector3" then
					p1.FruitWorldPos = v32
					p1:TransitionTo("Outbound")
				else
					p1:Stop("NoFruitPosition")
				end
			end
		},
		Outbound = {
			Enter = function(p1) --[[ Enter | Line: 215 ]]
				local FruitWorldPos = p1.FruitWorldPos
				local v1 = p1.Control:GetSlotPosition()

				if not v1 then
					return
				end

				local v4 = Vector3.new(FruitWorldPos.X - v1.X, 0, FruitWorldPos.Z - v1.Z)

				p1.Control:SetGoal(if v4.Magnitude < 0.001 then CFrame.new(FruitWorldPos) else CFrame.lookAt(FruitWorldPos, FruitWorldPos + v4.Unit), p1.TravelSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 219 | Upvalues: DataService (ref) ]]
				local Player = p1.Player
				local PlantId = p1.PlantId
				local FruitId = p1.FruitId
				local v1

				if Player and Player.Parent then
					local v2 = DataService:GetFruit(Player, PlantId, FruitId)

					v1 = if v2 and (v2.Age and v2.MaxAge) then if v2.Age < v2.MaxAge then false else true else false
				else
					v1 = false
				end

				if not v1 then
					p1:TransitionTo("Aborting")

					return
				end

				local FruitWorldPos = p1.FruitWorldPos
				local TravelSpeed = p1.TravelSpeed
				local v3 = p1.Control:GetSlotPosition()

				if v3 then
					local v6 = Vector3.new(FruitWorldPos.X - v3.X, 0, FruitWorldPos.Z - v3.Z)

					p1.Control:SetGoal(if v6.Magnitude < 0.001 then CFrame.new(FruitWorldPos) else CFrame.lookAt(FruitWorldPos, FruitWorldPos + v6.Unit), TravelSpeed)
				end

				local FruitWorldPos2 = p1.FruitWorldPos
				local v10 = p1.Control:GetSlotPosition()
				local v11

				if v10 then
					local v12 = FruitWorldPos2.X - v10.X
					local v13 = FruitWorldPos2.Z - v10.Z

					v11 = math.sqrt(v12 * v12 + v13 * v13)
				else
					v11 = (1 / 0)
				end

				if v11 <= 3 then
					p1:TransitionTo("Picking")

					return
				end

				if p1:TimeInState() >= p1.LegTimeout then
					p1:TransitionTo("Aborting")
				end
			end
		},
		Picking = {
			Enter = function(p1) --[[ Enter | Line: 241 ]]
				local v1 = p1.Control:GetSlotPosition()

				if not v1 then
					return
				end

				local v2 = p1.Control:GetSlotPosition()

				if not v2 then
					return
				end

				local v5 = Vector3.new(v1.X - v2.X, 0, v1.Z - v2.Z)

				p1.Control:SetGoal(if v5.Magnitude < 0.001 then CFrame.new(v1) else CFrame.lookAt(v1, v1 + v5.Unit), 0)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 248 | Upvalues: DataService (ref), v3 (ref), Services (ref) ]]
				if p1:TimeInState() < p1.PickDuration then
					return
				end

				if p1.PickedUp then
					return
				end

				local Player = p1.Player
				local PlantId = p1.PlantId
				local FruitId = p1.FruitId
				local v1

				if Player and Player.Parent then
					local v2 = DataService:GetFruit(Player, PlantId, FruitId)

					v1 = if v2 and (v2.Age and v2.MaxAge) then if v2.Age < v2.MaxAge then false else true else false
				else
					v1 = false
				end

				if not v1 then
					p1:TransitionTo("Aborting")

					return
				end

				local v32 = DataService:GetFruit(p1.Player, p1.PlantId, p1.FruitId)

				if not v32 then
					p1:TransitionTo("Aborting")

					return
				end

				p1.Control:SetSlotAttribute("CarryingFruitSeed", v32.Seed or 0)
				p1.Control:SetSlotAttribute("CarryingFruitSize", v32.SizeMultiplier or 1)
				p1.Control:SetSlotAttribute("CarryingFruitOvertimeGrowth", (math.max(v32.OvertimeGrowth or 1, 1)))
				p1.Control:SetSlotAttribute("CarryingFruitMutation", v32.Mutation or "")
				p1.Control:SetSlotAttribute("CarryingFruit", p1.FruitName)

				if not v3 then
					v3 = require(Services:WaitForChild("MonkeyService"))
				end

				v3:MarkPickedUp(p1.Player, p1.PlantId, p1.FruitId)
				p1.PickedUp = true
				p1:TransitionTo("Returning")
			end
		},
		Returning = {
			Update = function(p1, p2, p3) --[[ Update | Line: 281 ]]
				local Character = p1.Player.Character
				local v1

				if Character then
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

					v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart.Position else nil
				else
					v1 = nil
				end

				if v1 then
					local TravelSpeed = p1.TravelSpeed
					local v2 = p1.Control:GetSlotPosition()

					if v2 then
						local v5 = Vector3.new(v1.X - v2.X, 0, v1.Z - v2.Z)

						p1.Control:SetGoal(if v5.Magnitude < 0.001 then CFrame.new(v1) else CFrame.lookAt(v1, v1 + v5.Unit), TravelSpeed)
					end

					local v9 = p1.Control:GetSlotPosition()
					local v10

					if v9 then
						local v11 = v1.X - v9.X
						local v12 = v1.Z - v9.Z

						v10 = math.sqrt(v11 * v11 + v12 * v12)
					else
						v10 = (1 / 0)
					end

					if v10 <= p1.DeliveryRadius then
						p1:TransitionTo("Delivering")

						return
					end

					if p1:TimeInState() >= p1.LegTimeout * 2 then
						p1:TransitionTo("Aborting")
					end
				else
					if not (p1:TimeInState() >= p1.LegTimeout * 2) then
						return
					end

					p1:TransitionTo("Aborting")
				end
			end
		},
		Delivering = {
			Enter = function(p1) --[[ Enter | Line: 306 | Upvalues: v3 (ref), Services (ref), ClearCarryAttributes (ref), RarityVisuals (ref), PetData (ref), t (ref) ]]
				if not v3 then
					v3 = require(Services:WaitForChild("MonkeyService"))
				end

				local v1, v2 = v3:Commit(p1.Player, p1.PlantId, p1.FruitId)

				p1.Reserved = false
				p1.PickedUp = false
				ClearCarryAttributes(p1.Control)

				if v1 then
					local v32 = PetData.GetSpeciesDisplayName(p1.Species)
					local v4 = PetData[p1.Species]

					p1.Control:Notify((("Your %* brought you a %*!"):format(RarityVisuals.RichText(v32, if type(v4) == "table" then if type(v4.Rarity) == "string" then v4.Rarity else "Common" else "Common"), (RarityVisuals.RichText(tostring(p1.FruitName), t[p1.FruitName] or "Common")))))
				elseif v2 == "Full" then
					p1.Control:Notify("Your Monkey couldn\'t deliver -- your inventory is full!")
				end

				p1:Stop("Delivered")
			end
		},
		Aborting = {
			Enter = function(p1) --[[ Enter | Line: 329 ]]
				local Character = p1.Player.Character
				local v1

				if Character then
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

					v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart.Position else nil
				else
					v1 = nil
				end

				if not v1 then
					return
				end

				local v2 = p1.Control:GetSlotPosition()

				if not v2 then
					return
				end

				local v5 = Vector3.new(v1.X - v2.X, 0, v1.Z - v2.Z)

				p1.Control:SetGoal(if v5.Magnitude < 0.001 then CFrame.new(v1) else CFrame.lookAt(v1, v1 + v5.Unit), p1.TravelSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 336 ]]
				if not (p1:TimeInState() >= p1.LegTimeout) then
					return
				end

				p1:Stop("Aborted")
			end
		}
	}
end

function PickFruit.new(p1) --[[ new | Line: 346 | Upvalues: BehaviorBase (copy), PickFruit (copy), PetSizes (copy), t2 (copy), PetTypes (copy), BuildStates (copy) ]]
	local v1 = BehaviorBase.New(PickFruit, p1)
	local Slot = v1.Slot
	local v3

	if Slot then
		local v4 = 1
		local v5 = PetSizes.Normalize(Slot:GetAttribute("PetSize"))

		if v5 and t2[v5] then
			v4 = v4 * t2[v5]
		end

		if Slot:GetAttribute("PetType") == PetTypes.Rainbow then
			v4 = v4 * 1.15
		end

		v3 = v4
	else
		v3 = 1
	end

	v1.TravelSpeed = (v1.Config.TravelSpeed or 20) * v3
	v1.LegTimeout = v1.Config.LegTimeout or 20
	v1.PickDuration = v1.Config.PickDuration or 1
	v1.DeliveryRadius = v1.Config.DeliveryRadius or 8
	v1.PlantId = nil
	v1.FruitId = nil
	v1.FruitName = nil
	v1.FruitWorldPos = nil
	v1.Reserved = false
	v1.PickedUp = false
	v1.States = BuildStates()

	return v1
end
function PickFruit.GetInitialState(p1) --[[ GetInitialState | Line: 365 ]]
	return "Targeting"
end
function PickFruit.GetChanceMultiplier(p1, p2) --[[ GetChanceMultiplier | Line: 375 | Upvalues: v3 (ref), Services (copy), PetSizes (copy), PetTypes (copy) ]]
	if not v3 then
		v3 = require(Services:WaitForChild("MonkeyService"))
	end

	local v1 = v3:GetChanceMultiplier()

	if p2 then
		local v2 = p2:GetAttribute("PetSize")
		local v32 = p2:GetAttribute("PetType")
		local v5 = v1 * PetSizes.GetBoostMultiplier(if type(v2) == "string" then v2 else nil)

		v1 = v5 * PetTypes.GetBoostMultiplier(if type(v32) == "string" then v32 else nil)
	end

	return v1
end
function PickFruit.CanStart(p1) --[[ CanStart | Line: 387 | Upvalues: PickRandomOwnFruit (copy) ]]
	local Player = p1.Player

	if not (Player and Player.Parent) then
		return false
	end

	if not (Player:GetAttribute("IsInOwnGarden") == true) then
		return false
	end

	return PickRandomOwnFruit(Player) ~= nil
end
function PickFruit.OnStop(p1, p2) --[[ OnStop | Line: 397 | Upvalues: ClearCarryAttributes (copy), v3 (ref), Services (copy) ]]
	if p1.Control then
		ClearCarryAttributes(p1.Control)
	end

	if not (p1.Reserved and (p1.PlantId and p1.FruitId)) then
		return
	end

	if not v3 then
		v3 = require(Services:WaitForChild("MonkeyService"))
	end

	v3:Release(p1.Player, p1.PlantId, p1.FruitId)
	p1.Reserved = false
end

return PickFruit