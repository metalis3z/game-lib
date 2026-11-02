--credit to quartz games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GardenSyncController = require(script.Parent.GardenSyncController)
local PlantVisualizerController = require(script.Parent.PlantVisualizerController)
local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
local WeightFormat = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("WeightFormat"))
local GrowEffects = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("GrowEffects"))
local PerfFlags = require(ReplicatedStorage.SharedModules.Flags.PerfFlags)
local Environment = require(ReplicatedStorage.SharedModules.Environment)
local LocalPlayer = Players.LocalPlayer
local Fruits = ReplicatedStorage.Assets.Fruits
local Fruits2 = ReplicatedStorage.PlantGenerationModules.Fruits
local Plants = ReplicatedStorage.PlantGenerationModules.Plants
local t2 = {}
local SellValueData = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("SellValueData"))
local MutationData = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("MutationData"))

require(ReplicatedStorage.SharedModules.CalculateStealDuration)

local CalculateOvertimeGrowth = require(ReplicatedStorage.SharedModules.CalculateOvertimeGrowth)
local t3 = {}
local t4 = {}
local t5 = {}
local v1 = false
local t6 = {}
local t7 = {}
local t8 = {}

local function getDesiredAgeUpdateHz() --[[ getDesiredAgeUpdateHz | Line: 39 ]]
	local ok, result = pcall(function() --[[ Line: 40 ]]
		return UserSettings().GameSettings
	end)

	if not (ok and result) then
		return 30
	end

	local SavedQualityLevel = result.SavedQualityLevel
	local v1 = nil

	if typeof(SavedQualityLevel) == "EnumItem" then
		v1 = SavedQualityLevel.Value
	elseif type(SavedQualityLevel) == "number" then
		v1 = SavedQualityLevel
	end

	if type(v1) ~= "number" then
		return 50
	end

	if v1 == 0 then
		return 30
	end

	if v1 >= 7 then
		return 60
	end

	if v1 >= 4 then
		return 25
	end

	return 30
end

local function hzToTick(p1) --[[ hzToTick | Line: 71 ]]
	if p1 <= 0 then
		return 0.02
	end

	return 1 / math.clamp(p1, 15, 60)
end

local function getCurrentAgeUpdateTick() --[[ getCurrentAgeUpdateTick | Line: 82 | Upvalues: PerfFlags (copy), GrowEffects (copy), getDesiredAgeUpdateHz (copy) ]]
	local v1 = 1 / PerfFlags.AgeUpdateMaxHz:Get()

	if not GrowEffects.SmoothGrow then
		return math.max(GrowEffects.GrowTick, 0.1, v1)
	end

	local v2 = getDesiredAgeUpdateHz()

	return math.max(if v2 <= 0 then 0.02 else 1 / math.clamp(v2, 15, 60), 0.1, v1)
end

local v2 = 1 / PerfFlags.AgeUpdateMaxHz:Get()
local v3

if GrowEffects.SmoothGrow then
	local v4 = getDesiredAgeUpdateHz()

	v3 = math.max(if v4 <= 0 then 0.02 else 1 / math.clamp(v4, 15, 60), 0.1, v2)
else
	v3 = math.max(GrowEffects.GrowTick, 0.1, v2)
end

local v6 = 0
local v7 = 0

local function profileBegin(p1) --[[ profileBegin | Line: 103 ]]
	debug.profilebegin("Controllers/FruitVisualizerController/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 107 ]]
	debug.profileend()
end

local function setFruitAgeWithScale(p1, p2, p3, p4, p5) --[[ setFruitAgeWithScale | Line: 111 ]]
	p1:SetAttribute("Age", p2)
end

local function setFruitGrowthState(p1, p2) --[[ setFruitGrowthState | Line: 121 | Upvalues: t6 (copy), t7 (copy) ]]
	if p2 then
		t6[p1] = nil
		t7[p1] = true
	else
		t7[p1] = nil
		t6[p1] = true
	end
end

local function computeFruitVisibleCenter(p1) --[[ computeFruitVisibleCenter | Line: 131 ]]
	local PrimaryPart = p1.PrimaryPart
	local sum = Vector3.new(0, 0, 0)
	local count = 0

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and (v2 ~= PrimaryPart and v2.Transparency < 1) then
			sum = sum + v2.Position
			count = count + 1
		end
	end

	if count == 0 then
		return nil
	end

	return sum / count
end

local function v8(p1, p2, p3, p4) --[[ reportFruitWorldPosition | Line: 145 | Upvalues: LocalPlayer (copy), computeFruitVisibleCenter (copy), Networking (copy), v8 (copy) ]]
	if type(p1) ~= "string" or type(p2) ~= "string" then
		return
	end

	if tonumber(p3:GetAttribute("UserId")) ~= LocalPlayer.UserId then
		return
	end

	Networking.ObjectPositionService.CreateServerValue:Fire(p1, p2, computeFruitVisibleCenter(p3) or p3:GetPivot().Position)

	if p4 then
		return
	end

	task.delay(3, function() --[[ Line: 154 | Upvalues: p3 (copy), v8 (ref), p1 (copy), p2 (copy) ]]
		if not (p3 and p3.Parent) then
			return
		end

		v8(p1, p2, p3, true)
	end)
end

local function refreshFruitGrowthState(p1) --[[ refreshFruitGrowthState | Line: 162 | Upvalues: t5 (copy), t6 (copy), t7 (copy) ]]
	local v1 = t5[p1]

	if not v1 then
		t6[p1] = nil
		t7[p1] = nil

		return
	end

	local v3 = v1.MaxAge or 0

	if if v3 > 0 then v3 <= (v1.CurrentAge or 0) else false then
		t6[p1] = nil
		t7[p1] = true
	else
		t7[p1] = nil
		t6[p1] = true
	end
end

local function getOrCreateHarvestPart(p1) --[[ getOrCreateHarvestPart | Line: 175 ]]
	local HarvestPart = p1:FindFirstChild("HarvestPart")

	if HarvestPart and HarvestPart:IsA("BasePart") then
		return HarvestPart
	end

	local v1 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")

	if v1 then
		local HarvestPart2 = Instance.new("Part")

		HarvestPart2.Name = "HarvestPart"
		HarvestPart2.Size = Vector3.new(1, 1, 1)
		HarvestPart2.Transparency = 1
		HarvestPart2.Anchored = true
		HarvestPart2.CanCollide = false
		HarvestPart2.CanTouch = false
		HarvestPart2.CanQuery = false
		HarvestPart2.CFrame = v1.CFrame
		HarvestPart2.Parent = p1

		return HarvestPart2
	end

	return nil
end

function t.CalculateFruitWeight(p1, p2) --[[ CalculateFruitWeight | Line: 200 | Upvalues: GardenSyncController (copy), t4 (copy) ]]
	local v1 = tonumber(p2:GetAttribute("UserId"))
	local v2 = p2:GetAttribute("PlantId")
	local v3 = p2:GetAttribute("FruitId")
	local v4 = p2:GetAttribute("CorePartName")

	if v1 and v2 then
		local v5 = GardenSyncController:GetPlant(v1, v2)

		if v5 and v5.PlantName then
			v4 = v5.PlantName
		end
	end

	local v6 = p2:GetAttribute("SizeMulti") or 1
	local v7 = 1

	if v1 and (v2 and v3) then
		local v8 = GardenSyncController:GetPlant(v1, v2)
		local v9 = if v8 then v8.Fruits and v8.Fruits[v3] else v8

		if v9 and v9.OvertimeGrowth then
			v7 = v9.OvertimeGrowth
		end
	end

	local v10 = t4[v4]
	local v11 = if v10 then v10.GrowData and v10.GrowData.BaseWeight else v10

	if v11 then
		return v11 * v6 * v7
	end

	return nil
end

local v9 = RunService:IsStudio() or Environment.env == "Dev"

local function dprintWeight(...) --[[ dprintWeight | Line: 237 | Upvalues: v9 (copy) ]]
	if not v9 then
		return
	end

	print("[PlantWeight]", ...)
end

function t.CalculatePlantWeight(p1, p2) --[[ CalculatePlantWeight | Line: 243 | Upvalues: dprintWeight (copy), GardenSyncController (copy), t2 (copy), CalculateOvertimeGrowth (copy) ]]
	local v1 = tonumber(p2:GetAttribute("UserId"))
	local v2 = p2:GetAttribute("PlantId")

	if not v1 or type(v2) ~= "string" then
		dprintWeight("FAIL: missing UserId/PlantId attributes on", p2:GetFullName(), "UserId =", p2:GetAttribute("UserId"), "PlantId =", p2:GetAttribute("PlantId"))

		return nil
	end

	local v3 = GardenSyncController:GetPlant(v1, v2)

	if v3 and v3.PlantName then
		local v4 = t2[v3.PlantName]
		local v5 = if v4 then v4.GrowData and v4.GrowData.BaseWeight else v4

		if v5 then
			local v6 = v3.SizeMultiplier or 1
			local OvertimeGrowth = v3.OvertimeGrowth

			if type(OvertimeGrowth) ~= "number" or OvertimeGrowth <= 0 then
				local FinishedGrowingAt = v3.FinishedGrowingAt

				OvertimeGrowth = if type(FinishedGrowingAt) == "number" and FinishedGrowingAt > 0 then math.max(CalculateOvertimeGrowth(os.time() - FinishedGrowingAt), 1) else 1
			end

			local v9 = math.clamp(OvertimeGrowth, 1, 100)

			dprintWeight(("OK: %s base=%.1f size=%.2f overtime=%.2f -> %.1fg"):format(v3.PlantName, v5, v6, v9, v5 * v6 * v9))

			return v5 * v6 * v9
		end

		dprintWeight("FAIL:", v3.PlantName, if v4 == nil then "has no Plants generation module" else "module has no GrowData.BaseWeight")

		return nil
	end

	dprintWeight("FAIL: GardenSyncController:GetPlant returned", if v3 == nil then "nil" else "data with no PlantName", "for", v1, v2)

	return nil
end

local function getPromptObjectText(p1) --[[ getPromptObjectText | Line: 288 | Upvalues: GardenSyncController (copy), t (copy), WeightFormat (copy) ]]
	local v1 = tonumber(p1:GetAttribute("UserId"))
	local v2 = p1:GetAttribute("PlantId")
	local v3 = "Fruit"

	if v1 and v2 then
		local v4 = GardenSyncController:GetPlant(v1, v2)

		if v4 and v4.PlantName then
			v3 = v4.PlantName
		end
	end

	local v5 = p1:GetAttribute("Mutation")

	return ("%*%* [%*]"):format(v3, v5 and v5 ~= "" and (" [%*]"):format(v5) or "", (WeightFormat.FormatGrams(t:CalculateFruitWeight(p1) or 0)))
end

function t.Init(p1) --[[ Init | Line: 308 | Upvalues: Fruits2 (copy), t4 (copy), Plants (copy), t2 (copy) ]]
	for v1, v2 in Fruits2:GetChildren() do
		if v2:IsA("ModuleScript") then
			t4[v2.Name] = require(v2)
		end
	end

	for v3, v4 in Plants:GetChildren() do
		if v4:IsA("ModuleScript") then
			t2[v4.Name] = require(v4)
		end
	end
end
function t.UpdateFruitMutation(p1, p2, p3, p4, p5) --[[ UpdateFruitMutation | Line: 321 | Upvalues: v1 (ref), t3 (copy) ]]
	if v1 then
		return
	end

	local v12 = t3[("%*_%*_%*"):format(p2, p3, p4)]

	if not v12 then
		return
	end

	if p5 and p5 ~= "" then
		v12:SetAttribute("Mutation", p5)
	else
		v12:SetAttribute("Mutation", nil)
	end

	local v2 = v12:FindFirstChild("HarvestPrompt", true) or v12:FindFirstChild("StealPrompt", true)

	if not v2 then
		return
	end

	v2:IsA("ProximityPrompt")
end
function t.Start(p1) --[[ Start | Line: 343 | Upvalues: GardenSyncController (copy), t3 (copy), v3 (ref), PerfFlags (copy), GrowEffects (copy), getDesiredAgeUpdateHz (copy), RunService (copy), v6 (ref), v7 (ref), t7 (copy), t8 (copy), v8 (copy) ]]
	GardenSyncController:OnFruitMutationUpdated(function(p12, p2, p3, p4) --[[ Line: 344 | Upvalues: p1 (copy) ]]
		p1:UpdateFruitMutation(p12, p2, p3, p4)
	end)
	GardenSyncController:OnFruitAdded(function(p12, p2, p3, p4) --[[ Line: 348 | Upvalues: p1 (copy) ]]
		p1:SpawnFruitFromData(p12, p2, p3, p4)
	end)
	GardenSyncController:OnFruitVisualCheck(function(p12, p2, p3, p4) --[[ Line: 352 | Upvalues: t3 (ref), p1 (copy) ]]
		if t3[("%*_%*_%*"):format(p12, p2, p3)] then
			return
		end

		p1:SpawnFruitFromData(p12, p2, p3, p4)
	end)
	GardenSyncController:OnFruitRemoved(function(p12, p2, p3) --[[ Line: 359 | Upvalues: p1 (copy) ]]
		p1:RemoveFruitById(p12, p2, p3)
	end)
	GardenSyncController:OnFruitGrowthUpdated(function(p12, p2, p3, p4, p5) --[[ Line: 363 | Upvalues: p1 (copy) ]]
		p1:UpdateFruitGrowthData(p12, p2, p3, p4, p5)
	end)
	GardenSyncController:OnFruitAgeSync(function(p12, p2, p3) --[[ Line: 367 | Upvalues: p1 (copy) ]]
		p1:SyncFruitAges(p12, p2, p3)
	end)
	GardenSyncController:OnFruitOvertimeGrowthUpdated(function(p12, p2, p3, p4) --[[ Line: 371 | Upvalues: p1 (copy) ]]
		p1:UpdateFruitOvertimeGrowth(p12, p2, p3, p4)
	end)

	local ok, result = pcall(function() --[[ Line: 375 ]]
		return UserSettings().GameSettings
	end)

	if not (ok and (result and result.GetPropertyChangedSignal)) then
		PerfFlags.AgeUpdateMaxHz.Changed:Connect(function() --[[ Line: 384 | Upvalues: v3 (ref), PerfFlags (ref), GrowEffects (ref), getDesiredAgeUpdateHz (ref) ]]
			local v1 = 1 / PerfFlags.AgeUpdateMaxHz:Get()
			local v2

			if GrowEffects.SmoothGrow then
				local v32 = getDesiredAgeUpdateHz()

				v2 = math.max(if v32 <= 0 then 0.02 else 1 / math.clamp(v32, 15, 60), 0.1, v1)
			else
				v2 = math.max(GrowEffects.GrowTick, 0.1, v1)
			end

			v3 = v2
		end)
		RunService.Heartbeat:Connect(function(p13) --[[ Line: 388 | Upvalues: v6 (ref), v7 (ref), v3 (ref), p1 (copy), t7 (ref), t8 (ref), t3 (ref), v8 (ref) ]]
			debug.profilebegin("Controllers/FruitVisualizerController/Heartbeat")
			v6 = v6 + p13
			v7 = v7 + p13

			local count2 = 0

			while v3 <= v6 and count2 < 5 do
				v6 = v6 - v3
				p1:UpdateFruitAges(v3)
				count2 = count2 + 1
			end

			if v6 >= 1 then
				local v2 = math.min(v6, 5)

				v6 = 0
				p1:UpdateFruitAges(v2)
			end

			if v7 >= 0.5 then
				v7 = 0

				for v32 in t7 do
					if not t8[v32] then
						local v4 = t3[v32]

						if v4 and v4.Parent then
							t8[v32] = true
							v8(v4:GetAttribute("PlantId"), v4:GetAttribute("FruitId"), v4)
						end
					end
				end
			end

			debug.profileend()
		end)

		return
	end

	result:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() --[[ Line: 379 | Upvalues: v3 (ref), PerfFlags (ref), GrowEffects (ref), getDesiredAgeUpdateHz (ref) ]]
		local v1 = 1 / PerfFlags.AgeUpdateMaxHz:Get()
		local v2

		if GrowEffects.SmoothGrow then
			local v32 = getDesiredAgeUpdateHz()

			v2 = math.max(if v32 <= 0 then 0.02 else 1 / math.clamp(v32, 15, 60), 0.1, v1)
		else
			v2 = math.max(GrowEffects.GrowTick, 0.1, v1)
		end

		v3 = v2
	end)
	PerfFlags.AgeUpdateMaxHz.Changed:Connect(function() --[[ Line: 384 | Upvalues: v3 (ref), PerfFlags (ref), GrowEffects (ref), getDesiredAgeUpdateHz (ref) ]]
		local v1 = 1 / PerfFlags.AgeUpdateMaxHz:Get()
		local v2

		if GrowEffects.SmoothGrow then
			local v32 = getDesiredAgeUpdateHz()

			v2 = math.max(if v32 <= 0 then 0.02 else 1 / math.clamp(v32, 15, 60), 0.1, v1)
		else
			v2 = math.max(GrowEffects.GrowTick, 0.1, v1)
		end

		v3 = v2
	end)
	RunService.Heartbeat:Connect(function(p13) --[[ Line: 388 | Upvalues: v6 (ref), v7 (ref), v3 (ref), p1 (copy), t7 (ref), t8 (ref), t3 (ref), v8 (ref) ]]
		debug.profilebegin("Controllers/FruitVisualizerController/Heartbeat")
		v6 = v6 + p13
		v7 = v7 + p13

		local count2 = 0

		while v3 <= v6 and count2 < 5 do
			v6 = v6 - v3
			p1:UpdateFruitAges(v3)
			count2 = count2 + 1
		end

		if v6 >= 1 then
			local v2 = math.min(v6, 5)

			v6 = 0
			p1:UpdateFruitAges(v2)
		end

		if v7 >= 0.5 then
			v7 = 0

			for v32 in t7 do
				if not t8[v32] then
					local v4 = t3[v32]

					if v4 and v4.Parent then
						t8[v32] = true
						v8(v4:GetAttribute("PlantId"), v4:GetAttribute("FruitId"), v4)
					end
				end
			end
		end

		debug.profileend()
	end)
end
function t.AddFruitHarvestPrompt(p1, p2, p3, p4) --[[ AddFruitHarvestPrompt | Line: 420 | Upvalues: getOrCreateHarvestPart (copy), LocalPlayer (copy), SellValueData (copy), MutationData (copy) ]]
	if p2:FindFirstChild("HarvestPrompt", true) then
		return
	end

	if p2:FindFirstChild("StealPrompt", true) then
		return
	end

	local v1 = getOrCreateHarvestPart(p2)

	if not v1 then
		return
	end

	local isUserId = tonumber(p2:GetAttribute("UserId")) == LocalPlayer.UserId
	local StealPrompt = Instance.new("ProximityPrompt")

	StealPrompt.Style = Enum.ProximityPromptStyle.Custom

	if isUserId then
		StealPrompt.MaxActivationDistance = 10
		StealPrompt.RequiresLineOfSight = false
		StealPrompt.Enabled = true
		StealPrompt.Name = "HarvestPrompt"
		StealPrompt.ActionText = "Harvest"
		StealPrompt.HoldDuration = 0
		StealPrompt:AddTag("HarvestPrompt")
	else
		local v2 = p2:GetAttribute("CorePartName")
		local v3 = p2:GetAttribute("SizeMulti") or 1
		local v4 = p2:GetAttribute("Mutation")

		math.floor((SellValueData[v2] or 100) * v3 ^ 3 * (if v4 then MutationData.ReturnPriceMultiplier(v4) else 1))
		StealPrompt.Name = "StealPrompt"
		StealPrompt.ActionText = "Steal"
		StealPrompt:AddTag("StealPrompt")
		StealPrompt.HoldDuration = 0
	end

	StealPrompt.Parent = v1
end
function t.RemoveFruitHarvestPrompt(p1, p2) --[[ RemoveFruitHarvestPrompt | Line: 469 ]]
	local v1 = p2:FindFirstChild("HarvestPrompt", true) or p2:FindFirstChild("StealPrompt", true)

	if not v1 then
		return
	end

	v1:Destroy()
end
function t.UpdateFruitAges(p1, p2) --[[ UpdateFruitAges | Line: 476 | Upvalues: v1 (ref), t6 (copy), t3 (copy), PlantVisualizerController (copy), t5 (copy), t7 (copy), v8 (copy) ]]
	if v1 then
		return
	end

	debug.profilebegin("Controllers/FruitVisualizerController/UpdateFruitAges/iterateGrowingFruits")

	for v12, v2 in t6 do
		local v3 = t3[v12]

		if v3 and v3.Parent then
			local v4 = tonumber(v3:GetAttribute("UserId"))

			if not (v4 and PlantVisualizerController:HasOfflineCutsceneSnapshot(v4)) then
				local v5 = t5[v12]

				if v5 then
					local v6 = v5.CurrentAge or 0
					local v82 = math.min(v6 + p2 * v5.GrowthRate, v5.MaxAge)
					local v9 = if v6 < v5.MaxAge then true else false
					local v10 = if v5.MaxAge <= v82 then true else false

					v5.CurrentAge = v82

					local MaxAge2 = v5.MaxAge
					local _ = v5.OvertimeGrowth or 1

					v3:SetAttribute("Age", v82)

					if v9 and v10 then
						local v11 = v3:GetAttribute("FruitId")
						local v122 = v3:GetAttribute("PlantId")

						p1:AddFruitHarvestPrompt(v3, v122, v11)
						t6[v12] = nil
						t7[v12] = true
						v8(v122, v11, v3)
					end
				end
			end

			continue
		end

		t6[v12] = nil
		t7[v12] = nil
	end

	debug.profileend()
end
function t.UpdateFruitGrowthData(p1, p2, p3, p4, p5, p6) --[[ UpdateFruitGrowthData | Line: 520 | Upvalues: v1 (ref), PlantVisualizerController (copy), t5 (copy), t3 (copy), t6 (copy), t7 (copy) ]]
	if v1 then
		return
	end

	if PlantVisualizerController:HasOfflineCutsceneSnapshot(p2) then
		return
	end

	local v12 = ("%*_%*_%*"):format(p2, p3, p4)
	local v2 = t5[v12]

	if not v2 then
		return
	end

	local v3 = if v2.CurrentAge < v2.MaxAge then true else false

	v2.GrowthRate = p6

	local v5 = math.min(math.max(p5, v2.CurrentAge), v2.MaxAge)

	v2.CurrentAge = v5

	local v6, v7

	if v2.MaxAge <= v5 then
		v6 = v12
		v7 = true
	else
		v6 = v12
		v7 = false
	end

	local v8 = t3[v6]

	if v8 and v8.Parent then
		local MaxAge2 = v2.MaxAge
		local _ = v2.OvertimeGrowth or 1

		v8:SetAttribute("Age", v5)

		if v3 and v7 then
			p1:AddFruitHarvestPrompt(v8, p3, p4)
		end
	end

	local v9 = t5[v6]

	if not v9 then
		t6[v6] = nil
		t7[v6] = nil

		return
	end

	local v11 = v9.MaxAge or 0

	if if v11 > 0 then v11 <= (v9.CurrentAge or 0) else false then
		t6[v6] = nil
		t7[v6] = true
	else
		t7[v6] = nil
		t6[v6] = true
	end
end
function t.SyncFruitAges(p1, p2, p3, p4) --[[ SyncFruitAges | Line: 553 | Upvalues: v1 (ref), PlantVisualizerController (copy), t5 (copy), t3 (copy), t6 (copy), t7 (copy) ]]
	if v1 then
		return
	end

	if PlantVisualizerController:HasOfflineCutsceneSnapshot(p2) then
		return
	end

	for v3, v4 in p4 do
		local v12, v2
		local v5 = ("%*_%*_%*"):format(p2, p3, v3)
		local v6 = t5[v5]
		local v7 = t3[v5]

		if v6 then
			local v8 = if v6.CurrentAge < v6.MaxAge then true else false
			local v9 = math.max(v4, v6.CurrentAge)

			if v6.CurrentAge >= v6.MaxAge and v4 < v6.MaxAge then
				v9 = v6.MaxAge
			end

			local v10 = math.min(v9, v6.MaxAge)

			if v6.MaxAge <= v10 then
				v12 = v5
				v2 = true
			else
				v12 = v5
				v2 = false
			end

			v6.CurrentAge = v10

			if v8 and (v2 and v7) then
				p1:AddFruitHarvestPrompt(v7, p3, v3)
			end
		else
			v12 = v5
		end

		if v7 then
			local v11 = v6 and v6.CurrentAge or v4

			if v6 then
				local MaxAge = v6.MaxAge
				local _ = v6.MaxAge <= v11
				local _2 = v6.OvertimeGrowth or 1
			end

			v7:SetAttribute("Age", v11)
		end

		local v122 = t5[v12]

		if v122 then
			local v14 = v122.MaxAge or 0

			if if v14 > 0 then v14 <= (v122.CurrentAge or 0) else false then
				t6[v12] = nil
				t7[v12] = true

				continue
			end

			t7[v12] = nil
			t6[v12] = true

			continue
		end

		t6[v12] = nil
		t7[v12] = nil
	end
end
function t.GetPlantModel(p1, p2, p3) --[[ GetPlantModel | Line: 593 | Upvalues: PlantVisualizerController (copy) ]]
	local v1 = ("%*_%*"):format(p2, p3)
	local v2 = PlantVisualizerController:GetPlantsFolder(p2)

	if v2 then
		return v2:FindFirstChild(v1)
	end

	return nil
end
function t.WaitForPlantModel(p1, p2, p3) --[[ WaitForPlantModel | Line: 601 | Upvalues: PlantVisualizerController (copy) ]]
	local v1 = os.clock()
	local v3, v4 = nil, ("%*_%*"):format(p2, p3)

	while os.clock() - v1 < 10 do
		local v5 = PlantVisualizerController:GetPlantsFolder(p2)

		v3 = v5

		if v5 then
			break
		end

		task.wait()
	end

	if not v3 then
		return nil
	end

	local v6 = v3:FindFirstChild(v4)

	while not v6 and os.clock() - v1 < 10 do
		task.wait()
		v6 = v3:FindFirstChild(v4)
	end

	if not v6 then
		return nil
	end

	while not v6:HasTag("InitializationComplete") and os.clock() - v1 < 10 do
		task.wait()
	end

	if not v6:HasTag("InitializationComplete") then
		return nil
	end

	while v6:GetAttribute("PlantGrowthReady") ~= true and os.clock() - v1 < 10 do
		task.wait()
	end

	if v6:GetAttribute("PlantGrowthReady") == true then
		return v6
	end

	return nil
end
function t.SpawnFruitFromData(p1, p2, p3, p4, p5) --[[ SpawnFruitFromData | Line: 633 | Upvalues: t3 (copy), v1 (ref), GardenSyncController (copy), t4 (copy), Fruits (copy), PlantVisualizerController (copy), t5 (copy), Networking (copy), t6 (copy), t7 (copy), v8 (copy) ]]
	local v12 = ("%*_%*_%*"):format(p2, p3, p4)

	if t3[v12] then
		if v1 then
			return
		end

		p1:RemoveFruitById(p2, p3, p4)
	end

	local v2 = p1:WaitForPlantModel(p2, p3)

	if not v2 then
		return
	end

	local v3 = GardenSyncController:GetPlant(p2, p3)

	if not v3 then
		return
	end

	local PlantName = v3.PlantName

	if not PlantName then
		return
	end

	local v4 = t4[PlantName]

	if not v4 then
		return
	end

	local FruitSpawnLocations = v2:FindFirstChild("FruitSpawnLocations")

	if not FruitSpawnLocations then
		return
	end

	local v5 = FruitSpawnLocations:GetChildren()[p5.SpawnLocationIndex]

	if not (v5 and v5:IsA("BasePart")) then
		return
	end

	local v6 = Fruits:FindFirstChild(PlantName)

	if not v6 then
		return
	end

	local v7 = v6:Clone()

	v7.Name = v12
	v7:SetAttribute("FruitId", p4)
	v7:SetAttribute("PlantId", p3)
	v7:SetAttribute("UserId", p2)
	v7:SetAttribute("MaxAge", p5.MaxAge)
	v7:SetAttribute("SizeMulti", p5.SizeMultiplier or 1)
	v7:SetAttribute("CorePartName", PlantName)

	local Fruits2 = v2:FindFirstChild("Fruits")

	if not Fruits2 then
		local Fruits3 = Instance.new("Folder")

		Fruits3.Name = "Fruits"
		Fruits3.Parent = v2
		Fruits2 = Fruits3
	end

	local v82 = p5.Age or 0
	local v11 = PlantVisualizerController:GetOfflineCutsceneOldFruitAge(p2, p3, p4)
	local v13 = if v11 == nil then false else true
	local v14 = if v13 then v11 else v82

	t5[v12] = {
		CurrentAge = v14,
		GrowthRate = p5.GrowRate or 0.025,
		MaxAge = p5.MaxAge,
		OvertimeGrowth = p5.OvertimeGrowth or 1,
		_syncedAge = v82
	}
	v7:SetAttribute("Age", v14)
	v7:SetAttribute("Mutation", p5.Mutation)
	v7:PivotTo(v5.CFrame)
	v4.InitFruit(v7, p5.Seed, p5.SizeMultiplier or 1)
	Networking.ObjectPositionService.CreateServerValue:Fire(p3, p4, v5.Position)

	repeat
		task.wait()
	until v7:HasTag("InitializationComplete")

	v4.BeginFruitGrowth(v7)
	v7.Parent = Fruits2

	if v13 then
		v7:SetAttribute("Age", v14)
		t5[v12].CurrentAge = v14
	end

	t3[v12] = v7

	local v15 = t5[v12]

	if v15 then
		local v17 = v15.MaxAge or 0

		if if v17 > 0 then v17 <= (v15.CurrentAge or 0) else false then
			t6[v12] = nil
			t7[v12] = true
		else
			t7[v12] = nil
			t6[v12] = true
		end
	else
		t6[v12] = nil
		t7[v12] = nil
	end

	local v19 = t5[v12]
	local _ = v19 and v19.OvertimeGrowth

	if v13 or not ((v19 and v19.MaxAge or p5.MaxAge) <= (t5[v12] and v19.CurrentAge or v82)) then
		return
	end

	p1:AddFruitHarvestPrompt(v7, p3, p4)
	v8(p3, p4, v7)
end
function t.RemoveFruitById(p1, p2, p3, p4) --[[ RemoveFruitById | Line: 732 | Upvalues: t3 (copy), t5 (copy), t6 (copy), t7 (copy), t8 (copy) ]]
	local v1 = ("%*_%*_%*"):format(p2, p3, p4)
	local v2 = t3[v1]

	if not v2 then
		return
	end

	v2:Destroy()
	t3[v1] = nil
	t5[v1] = nil
	t6[v1] = nil
	t7[v1] = nil
	t8[v1] = nil
end
function t.UpdateFruitOvertimeGrowth(p1, p2, p3, p4, p5) --[[ UpdateFruitOvertimeGrowth | Line: 746 | Upvalues: v1 (ref), t5 (copy) ]]
	if v1 then
		return
	end

	local v12 = t5[("%*_%*_%*"):format(p2, p3, p4)]

	if not v12 then
		return
	end

	v12.OvertimeGrowth = p5
end
function t.SetOfflineCutsceneState(p1, p2) --[[ SetOfflineCutsceneState | Line: 760 | Upvalues: v1 (ref) ]]
	v1 = p2

	if p2 then
		return
	end

	p1:AddMissingPrompts()
end
function t.AddMissingPrompts(p1) --[[ AddMissingPrompts | Line: 767 | Upvalues: t3 (copy), t5 (copy) ]]
	for v1, v2 in t3 do
		if v2 and (v2.Parent and not (v2:FindFirstChild("HarvestPrompt", true) or v2:FindFirstChild("StealPrompt", true))) then
			local v3 = t5[v1]

			if v3 and not (v3.CurrentAge < v3.MaxAge) then
				local v4 = v2:GetAttribute("PlantId")
				local v5 = v2:GetAttribute("FruitId")

				if v4 and v5 then
					p1:AddFruitHarvestPrompt(v2, v4, v5)
				end
			end
		end
	end
end
function t.GetSpawnedFruit(p1, p2, p3, p4) --[[ GetSpawnedFruit | Line: 785 | Upvalues: t3 (copy) ]]
	return t3[("%*_%*_%*"):format(p2, p3, p4)]
end
function t.GetFruitGrowthData(p1, p2, p3, p4) --[[ GetFruitGrowthData | Line: 790 | Upvalues: t5 (copy) ]]
	return t5[("%*_%*_%*"):format(p2, p3, p4)]
end
function t.FixFruitAgeAfterFailedCutscene(p1, p2, p3, p4, p5) --[[ FixFruitAgeAfterFailedCutscene | Line: 795 | Upvalues: t3 (copy), t5 (copy) ]]
	local v1 = ("%*_%*_%*"):format(p2, p3, p4)
	local v2 = t3[v1]
	local v3 = t5[v1]

	if not (v2 and (v3 and p5.Age)) then
		return
	end

	v2:SetAttribute("Age", p5.Age)
	v3.CurrentAge = p5.Age

	if p5.OvertimeGrowth then
		v3.OvertimeGrowth = p5.OvertimeGrowth
	end

	if not (p5.Age >= p5.MaxAge) then
		return
	end

	p1:AddFruitHarvestPrompt(v2, p3, p4)
end

return t