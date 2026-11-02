--credit to leon games studio
local BehaviorBase = require(script.Parent.BehaviorBase)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Services = game:GetService("ServerScriptService"):WaitForChild("Services")
local DataService = require(Services.DataService)
local ShovelService = require(Services.ShovelService)
local ObjectPositionService = require(Services.ObjectPositionService)
local FruitHarvestService = require(Services.FruitHarvestService)
local GardenZoneService = require(Services.GardenZoneService)
local BadgesService = require(Services.BadgesService)
local Fruits = ReplicatedStorage:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits")
local PetData = require(ReplicatedStorage.SharedData.PetData)
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

local StealFruit = setmetatable({}, {
	__index = BehaviorBase
})

StealFruit.__index = StealFruit
StealFruit.Name = "StealFruit"

local v3 = nil

local function GetPetBehaviorService() --[[ GetPetBehaviorService | Line: 63 | Upvalues: v3 (ref), Services (copy) ]]
	if v3 then
		return v3
	end

	v3 = require(Services.PetBehaviorService)

	return v3
end

local v4 = nil

local function GetWanderService() --[[ GetWanderService | Line: 76 | Upvalues: v4 (ref), Services (copy) ]]
	if v4 then
		return v4
	end

	local ok, result = pcall(require, Services:FindFirstChild("WanderService"))

	if not ok then
		return v4
	end

	v4 = result

	return result
end

local function GetFruitBaseWeight(p1) --[[ GetFruitBaseWeight | Line: 85 | Upvalues: Fruits (copy) ]]
	local v1 = Fruits:FindFirstChild(p1)

	if not v1 then
		return 1
	end

	local ok, result = pcall(require, v1)

	if ok and (result and result.GrowData) then
		return result.GrowData.BaseWeight or 1
	end

	return 1
end

local function GetPlotFolder(p1) --[[ GetPlotFolder | Line: 94 ]]
	local v1 = p1:GetAttribute("PlotId")

	if type(v1) ~= "number" then
		return nil
	end

	local Gardens = workspace:FindFirstChild("Gardens")

	if Gardens then
		return Gardens:FindFirstChild("Plot" .. tostring(v1))
	end

	return nil
end

local function IsNightTime() --[[ IsNightTime | Line: 103 | Upvalues: ReplicatedStorage (copy) ]]
	local Night = ReplicatedStorage:FindFirstChild("Night")

	if not (Night and Night:IsA("BoolValue")) then
		return false
	end

	return Night.Value == true
end

local function GardenIsEmpty(p1) --[[ GardenIsEmpty | Line: 110 | Upvalues: GardenZoneService (copy) ]]
	local v1 = p1:GetAttribute("PlotId")

	if type(v1) ~= "number" then
		return false
	end

	return #GardenZoneService:GetPlayersInGarden(v1) == 0
end

local function MakeGoalCFrame(p1, p2) --[[ MakeGoalCFrame | Line: 118 ]]
	local v3 = Vector3.new(p2.X - p1.X, 0, p2.Z - p1.Z)

	if v3.Magnitude < 0.001 then
		return CFrame.new(p2)
	end

	return CFrame.lookAt(p2, p2 + v3.Unit)
end

local function ClearCarryAttributes(p1) --[[ ClearCarryAttributes | Line: 127 ]]
	p1:SetSlotAttribute("CarryingFruit", nil)
	p1:SetSlotAttribute("CarryingFruitSeed", nil)
	p1:SetSlotAttribute("CarryingFruitSize", nil)
	p1:SetSlotAttribute("CarryingFruitOvertimeGrowth", nil)
	p1:SetSlotAttribute("CarryingFruitMutation", nil)
end

local function PickRandomTarget(p1) --[[ PickRandomTarget | Line: 136 | Upvalues: ReplicatedStorage (copy), Players (copy), GardenZoneService (copy), v3 (ref), Services (copy), DataService (copy) ]]
	local Night = ReplicatedStorage:FindFirstChild("Night")

	if not (if Night and Night:IsA("BoolValue") then if Night.Value == true then true else false else false) then
		return nil
	end

	local t = {}

	for k, v in pairs(Players:GetPlayers()) do
		if v ~= p1 and v:HasTag("DataLoaded") then
			local v2 = v:GetAttribute("PlotId")

			if if type(v2) == "number" then if #GardenZoneService:GetPlayersInGarden(v2) == 0 then true else false else false then
				if not v3 then
					v3 = require(Services.PetBehaviorService)
				end

				if not v3:IsVictimOnCooldown(p1.UserId, v.UserId) then
					local v4 = DataService:GetAllPlants(v)

					if v4 then
						for k2, v5 in pairs(v4) do
							if not v5.IsPotted then
								local Fruits = v5.Fruits

								if Fruits then
									for k3, v6 in pairs(Fruits) do
										if type(v6) == "table" and (v6.Age and (v6.MaxAge and not (v6.Age < v6.MaxAge))) then
											table.insert(t, {
												VictimPlayer = v,
												PlantId = k2,
												PlantData = v5,
												FruitId = k3,
												FruitData = v6
											})
										end
									end
								end
							end
						end
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

local function ResolveFruitWorldPos(p1, p2) --[[ ResolveFruitWorldPos | Line: 181 | Upvalues: ObjectPositionService (copy) ]]
	local v1 = ObjectPositionService:GetStoredFruitEntry(p1, p2)

	if not v1 then
		return nil
	end

	if typeof(v1.Position) == "Vector3" then
		return v1.Position
	end

	return nil
end

local function FruitIsStillValid(p1, p2, p3) --[[ FruitIsStillValid | Line: 188 | Upvalues: DataService (copy) ]]
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

local function FlyTo(p1, p2, p3) --[[ FlyTo | Line: 198 ]]
	local v1 = p1.Control:GetSlotPosition()

	if not v1 then
		return
	end

	local v4 = Vector3.new(p2.X - v1.X, 0, p2.Z - v1.Z)

	p1.Control:SetGoal(if v4.Magnitude < 0.001 then CFrame.new(p2) else CFrame.lookAt(p2, p2 + v4.Unit), p3)
end

local function DistanceTo(p1, p2) --[[ DistanceTo | Line: 206 ]]
	local v1 = p1.Control:GetSlotPosition()

	if v1 then
		local v2 = p2.X - v1.X
		local v3 = p2.Z - v1.Z

		return math.sqrt(v2 * v2 + v3 * v3)
	end

	return (1 / 0)
end

local function NotifyScare(p1, p2) --[[ NotifyScare | Line: 215 ]]
	local v1 = if p2 then p2.Scarer else p2
	local v2 = p1.Species or "Pet"
	local Player = p1.Player

	if v1 and v1.Parent then
		local v4, v5

		if Player then
			v4 = Player.Name

			if v4 then
				v5 = v1
			else
				v4 = "a player"
				v5 = v1
			end
		else
			v4 = "a player"
			v5 = v1
		end

		p1.Control:NotifyPlayer(v5, "You shooed away " .. v4 .. "\'s " .. v2 .. "!")
	end

	if not Player or (not Player.Parent or v1 == Player) then
		return
	end

	p1.Control:Notify((v1 and v1.Name or "Someone") .. " shooed away your " .. v2 .. "!")
end

local function BuildStates() --[[ BuildStates | Line: 229 | Upvalues: PickRandomTarget (copy), ObjectPositionService (copy), DataService (copy), NotifyScare (copy), Fruits (copy), HttpService (copy), ShovelService (copy), ClearCarryAttributes (copy), BadgesService (copy), FruitHarvestService (copy), RarityVisuals (copy), PetData (copy), t (copy), v3 (ref), Services (copy) ]]
	return {
		Targeting = {
			Enter = function(p1) --[[ Enter | Line: 235 | Upvalues: PickRandomTarget (ref), ObjectPositionService (ref) ]]
				local v1 = PickRandomTarget(p1.Player)

				if not v1 then
					p1:Stop("NoTarget")

					return
				end

				p1.VictimPlayer = v1.VictimPlayer
				p1.VictimUserId = v1.VictimPlayer.UserId
				p1.PlantId = v1.PlantId
				p1.FruitId = v1.FruitId
				p1.FruitName = v1.PlantData.PlantName
				p1.FruitData = v1.FruitData

				local v2 = ObjectPositionService:GetStoredFruitEntry(v1.VictimPlayer, v1.FruitId)

				p1.FruitWorldPos = if v2 then if typeof(v2.Position) == "Vector3" then v2.Position else nil else nil

				if p1.FruitWorldPos then
					p1:TransitionTo("Outbound")
				else
					p1:Stop("NoFruitPosition")
				end
			end
		},
		Outbound = {
			Enter = function(p1) --[[ Enter | Line: 261 ]]
				local FruitWorldPos = p1.FruitWorldPos
				local v1 = p1.Control:GetSlotPosition()

				if not v1 then
					return
				end

				local v4 = Vector3.new(FruitWorldPos.X - v1.X, 0, FruitWorldPos.Z - v1.Z)

				p1.Control:SetGoal(if v4.Magnitude < 0.001 then CFrame.new(FruitWorldPos) else CFrame.lookAt(FruitWorldPos, FruitWorldPos + v4.Unit), p1.TravelSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 265 | Upvalues: DataService (ref) ]]
				local VictimPlayer = p1.VictimPlayer
				local PlantId = p1.PlantId
				local FruitId = p1.FruitId
				local v1

				if VictimPlayer and VictimPlayer.Parent then
					local v2 = DataService:GetFruit(VictimPlayer, PlantId, FruitId)

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
					p1:TransitionTo("Stealing")

					return
				end

				if p1:TimeInState() >= p1.LegTimeout then
					p1:TransitionTo("Aborting")
				end
			end,
			OnEvent = function(p1, p2, p3) --[[ OnEvent | Line: 288 | Upvalues: NotifyScare (ref) ]]
				if p2 ~= "Scared" then
					return
				end

				NotifyScare(p1, p3)
				p1:TransitionTo("Aborting")
			end
		},
		Stealing = {
			Enter = function(p1) --[[ Enter | Line: 298 ]]
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
			Update = function(p1, p2, p3) --[[ Update | Line: 306 | Upvalues: DataService (ref), Fruits (ref), HttpService (ref), ShovelService (ref) ]]
				if p1.VictimPlayer and p1.VictimPlayer.Parent then
					if p1:TimeInState() < p1.StealDuration then
						return
					end

					if p1.StealCommitInFlight then
						return
					end

					p1.StealCommitInFlight = true

					local v1 = DataService:GetFruit(p1.VictimPlayer, p1.PlantId, p1.FruitId)

					if not v1 then
						p1:TransitionTo("Aborting")

						return
					end

					if not v1.Age or (not v1.MaxAge or v1.Age < v1.MaxAge) then
						p1:TransitionTo("Aborting")

						return
					end

					local v2 = Fruits:FindFirstChild(p1.FruitName)
					local v3

					if v2 then
						local ok, result = pcall(require, v2)

						v3 = if ok and (result and result.GrowData) then result.GrowData.BaseWeight or 1 else 1
					else
						v3 = 1
					end

					local v4 = v1.SizeMultiplier or 1
					local v5 = v1.OvertimeGrowth or 1
					local v6 = v3 * v4 * math.max(v5, 1)
					local t = {}

					t.Id = if type(p1.FruitId) == "string" and p1.FruitId ~= "" then p1.FruitId else HttpService:GenerateGUID(false)
					t.Seed = v1.Seed
					t.Weight = v6
					t.FruitName = p1.FruitName
					t.SizeMultiplier = v4
					t.OvertimeGrowth = v5
					t.Mutation = v1.Mutation
					p1.HarvestedPayload = t
					ShovelService:RemoveFruit(p1.VictimPlayer, p1.PlantId, p1.FruitId)
					p1.Control:SetSlotAttribute("CarryingFruitSeed", v1.Seed or 0)
					p1.Control:SetSlotAttribute("CarryingFruitSize", v4)
					p1.Control:SetSlotAttribute("CarryingFruitOvertimeGrowth", v5)
					p1.Control:SetSlotAttribute("CarryingFruitMutation", v1.Mutation or "")
					p1.Control:SetSlotAttribute("CarryingFruit", p1.FruitName)
					p1:TransitionTo("Returning")
				else
					p1:TransitionTo("Aborting")
				end
			end,
			OnEvent = function(p1, p2, p3) --[[ OnEvent | Line: 361 | Upvalues: NotifyScare (ref) ]]
				if p2 ~= "Scared" then
					return
				end

				NotifyScare(p1, p3)
				p1:TransitionTo("Aborting")
			end
		},
		Returning = {
			Enter = function(p1) --[[ Enter | Line: 371 ]]
				local v1 = p1.Player:GetAttribute("PlotId")
				local v2

				if type(v1) == "number" then
					local Gardens = workspace:FindFirstChild("Gardens")

					v2 = if Gardens then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
				else
					v2 = nil
				end

				if not v2 then
					p1:TransitionTo("Aborting")

					return
				end

				local SpawnPoint = v2:FindFirstChild("SpawnPoint")

				p1.HomePos = v2:FindFirstChild("SpawnPoint") and SpawnPoint.Position or v2:GetPivot().Position

				local HomePos = p1.HomePos
				local v5 = p1.Control:GetSlotPosition()

				if not v5 then
					return
				end

				local v8 = Vector3.new(HomePos.X - v5.X, 0, HomePos.Z - v5.Z)

				p1.Control:SetGoal(if v8.Magnitude < 0.001 then CFrame.new(HomePos) else CFrame.lookAt(HomePos, HomePos + v8.Unit), p1.TravelSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 382 ]]
				local HomePos = p1.HomePos
				local TravelSpeed = p1.TravelSpeed
				local v1 = p1.Control:GetSlotPosition()

				if v1 then
					local v4 = Vector3.new(HomePos.X - v1.X, 0, HomePos.Z - v1.Z)

					p1.Control:SetGoal(if v4.Magnitude < 0.001 then CFrame.new(HomePos) else CFrame.lookAt(HomePos, HomePos + v4.Unit), TravelSpeed)
				end

				local HomePos2 = p1.HomePos
				local v8 = p1.Control:GetSlotPosition()
				local v9

				if v8 then
					local v10 = HomePos2.X - v8.X
					local v11 = HomePos2.Z - v8.Z

					v9 = math.sqrt(v10 * v10 + v11 * v11)
				else
					v9 = (1 / 0)
				end

				if v9 <= p1.DeliveryRadius then
					p1:TransitionTo("Delivering")

					return
				end

				if p1:TimeInState() >= p1.LegTimeout * 2 then
					p1:TransitionTo("Aborting")
				end
			end,
			OnEvent = function(p1, p2, p3) --[[ OnEvent | Line: 396 | Upvalues: ClearCarryAttributes (ref), NotifyScare (ref) ]]
				if p2 ~= "Scared" then
					return
				end

				p1.HarvestedPayload = nil
				ClearCarryAttributes(p1.Control)
				NotifyScare(p1, p3)
				p1:TransitionTo("Aborting")
			end
		},
		Delivering = {
			Enter = function(p1) --[[ Enter | Line: 409 | Upvalues: DataService (ref), BadgesService (ref), FruitHarvestService (ref), RarityVisuals (ref), PetData (ref), t (ref), ClearCarryAttributes (ref) ]]
				if p1.HarvestedPayload and (p1.Player and p1.Player.Parent) then
					DataService:AddHarvestedFruit(p1.Player, p1.HarvestedPayload)
					BadgesService:OnFruitHarvested(p1.Player, p1.HarvestedPayload)
					FruitHarvestService:refreshPlayerFruitTools(p1.Player, DataService:GetAllHarvestedFruits(p1.Player))

					local v3 = PetData.GetDisplayName(p1.Species, p1.Slot and p1.Slot:GetAttribute("PetSize"))
					local v4 = PetData[p1.Species]

					p1.Control:Notify((("Your %* stole a %* from %*!"):format(RarityVisuals.RichText(v3, if type(v4) == "table" then if type(v4.Rarity) == "string" then v4.Rarity else "Common" else "Common"), RarityVisuals.RichText(tostring(p1.FruitName), t[p1.FruitName] or "Common"), p1.VictimPlayer and p1.VictimPlayer.Name or "someone")))
				end

				ClearCarryAttributes(p1.Control)
				p1:Stop("Delivered")
			end
		},
		Aborting = {
			Enter = function(p1) --[[ Enter | Line: 429 | Upvalues: ClearCarryAttributes (ref), v3 (ref), Services (ref) ]]
				p1.HarvestedPayload = nil
				ClearCarryAttributes(p1.Control)

				if p1.VictimUserId then
					if not v3 then
						v3 = require(Services.PetBehaviorService)
					end

					v3:SetVictimCooldown(p1.Player.UserId, p1.VictimUserId, p1.VictimCooldown)
				end

				local v1 = p1.Player:GetAttribute("PlotId")
				local v2

				if type(v1) == "number" then
					local Gardens = workspace:FindFirstChild("Gardens")

					v2 = if Gardens then Gardens:FindFirstChild("Plot" .. tostring(v1)) else nil
				else
					v2 = nil
				end

				local v4 = if v2 then v2:FindFirstChild("SpawnPoint") else v2

				p1.HomePos = v4 and v4.Position or (v2 and v2:GetPivot().Position or nil)

				if not p1.HomePos then
					return
				end

				local HomePos = p1.HomePos
				local v6 = p1.Control:GetSlotPosition()

				if not v6 then
					return
				end

				local v9 = Vector3.new(HomePos.X - v6.X, 0, HomePos.Z - v6.Z)

				p1.Control:SetGoal(if v9.Magnitude < 0.001 then CFrame.new(HomePos) else CFrame.lookAt(HomePos, HomePos + v9.Unit), p1.TravelSpeed)
			end,
			Update = function(p1, p2, p3) --[[ Update | Line: 447 ]]
				if not p1.HomePos then
					p1:Stop("Aborted")

					return
				end

				local HomePos = p1.HomePos
				local v1 = p1.Control:GetSlotPosition()
				local v2

				if v1 then
					local v3 = HomePos.X - v1.X
					local v4 = HomePos.Z - v1.Z

					v2 = math.sqrt(v3 * v3 + v4 * v4)
				else
					v2 = (1 / 0)
				end

				if v2 <= 50 then
					p1:Stop("Aborted")

					return
				end

				if p1:TimeInState() >= p1.LegTimeout then
					p1:Stop("Aborted")
				end
			end
		}
	}
end

function StealFruit.new(p1) --[[ new | Line: 469 | Upvalues: BehaviorBase (copy), StealFruit (copy), BuildStates (copy) ]]
	local v1 = BehaviorBase.New(StealFruit, p1)

	v1.TravelSpeed = v1.Config.TravelSpeed or 24
	v1.LegTimeout = v1.Config.LegTimeout or 20
	v1.StealDuration = v1.Config.StealDuration or 1
	v1.DeliveryRadius = v1.Config.DeliveryRadius or 8
	v1.VictimCooldown = v1.Config.VictimCooldown or 120
	v1.VictimPlayer = nil
	v1.VictimUserId = nil
	v1.PlantId = nil
	v1.FruitId = nil
	v1.FruitName = nil
	v1.FruitData = nil
	v1.FruitWorldPos = nil
	v1.HarvestedPayload = nil
	v1.HomePos = nil
	v1.States = BuildStates()

	return v1
end
function StealFruit.GetInitialState(p1) --[[ GetInitialState | Line: 501 ]]
	return "Targeting"
end
function StealFruit.CanStart(p1) --[[ CanStart | Line: 506 | Upvalues: ReplicatedStorage (copy), PickRandomTarget (copy) ]]
	local Player = p1.Player

	if not (Player and Player.Parent) then
		return false
	end

	local Night = ReplicatedStorage:FindFirstChild("Night")

	if not (if Night and Night:IsA("BoolValue") then if Night.Value == true then true else false else false) then
		return false
	end

	return PickRandomTarget(Player) ~= nil
end
function StealFruit.OnStop(p1, p2) --[[ OnStop | Line: 516 | Upvalues: ClearCarryAttributes (copy), v4 (ref), Services (copy) ]]
	if p1.Control then
		ClearCarryAttributes(p1.Control)
	end

	local Player = p1.Player
	local PetId = p1.PetId

	task.defer(function() --[[ Line: 528 | Upvalues: Player (copy), v4 (ref), Services (ref), PetId (copy) ]]
		if not (Player and Player.Parent) then
			return
		end

		if not v4 then
			local ok, result = pcall(require, Services:FindFirstChild("WanderService"))

			if ok then
				v4 = result
			end
		end

		local v1 = v4

		if not (v1 and v1.OnPetReleased) then
			return
		end

		v1:OnPetReleased(Player, PetId)
	end)
end

return StealFruit