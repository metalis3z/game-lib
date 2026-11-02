--credit to prince games studio
local t = {
	StartOrder = 4
}
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GardenSyncController = require(script.Parent.GardenSyncController)
local OfflineGrowthAnimationController = require(script.Parent.OfflineGrowthAnimationController)
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local PlantLifecycleHandler = require(script.Parent.PlantLifecycleHandler)
local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))

require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("SellValueData"))

local GrowRateData = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("GrowRateData"))
local GrowEffects = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("GrowEffects"))
local PerfFlags = require(ReplicatedStorage.SharedModules.Flags.PerfFlags)
local v1 = nil

require(ReplicatedStorage.SharedModules.CalculateStealDuration)

local LocalPlayer = Players.LocalPlayer
local Gardens = workspace:WaitForChild("Gardens")
local Plants = ReplicatedStorage.PlantGenerationModules.Plants
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local v2 = false
local t8 = {}
local v3 = 0
local t9 = {}
local v4 = nil

local function getDesiredAgeUpdateHz() --[[ getDesiredAgeUpdateHz | Line: 64 ]]
	local ok, result = pcall(function() --[[ Line: 65 ]]
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

local function hzToTick(p1) --[[ hzToTick | Line: 86 ]]
	if p1 <= 0 then
		return 0.02
	end

	return 1 / math.clamp(p1, 15, 60)
end

local function getCurrentAgeUpdateTick() --[[ getCurrentAgeUpdateTick | Line: 97 | Upvalues: PerfFlags (copy), GrowEffects (copy), getDesiredAgeUpdateHz (copy) ]]
	local v1 = 1 / PerfFlags.AgeUpdateMaxHz:Get()

	if not GrowEffects.SmoothGrow then
		return math.max(GrowEffects.GrowTick, 0.1, v1)
	end

	local v2 = getDesiredAgeUpdateHz()

	return math.max(if v2 <= 0 then 0.02 else 1 / math.clamp(v2, 15, 60), 0.1, v1)
end

local v5 = 1 / PerfFlags.AgeUpdateMaxHz:Get()
local v6

if GrowEffects.SmoothGrow then
	local v7 = getDesiredAgeUpdateHz()

	v6 = math.max(if v7 <= 0 then 0.02 else 1 / math.clamp(v7, 15, 60), 0.1, v5)
else
	v6 = math.max(GrowEffects.GrowTick, 0.1, v5)
end

local v9 = 0

local function profileBegin(p1) --[[ profileBegin | Line: 112 ]]
	debug.profilebegin("Controllers/PlantVisualizerController/" .. p1)
end

local function profileEnd() --[[ profileEnd | Line: 113 ]]
	debug.profileend()
end

local function setPlantAgeWithScale(p1, p2, p3, p4) --[[ setPlantAgeWithScale | Line: 125 | Upvalues: GrowEffects (copy) ]]
	if GrowEffects.InitialScale == 1 then
		p1:SetAttribute("Age", p2)

		return
	end

	p1:SetAttribute("Age", p2)

	local v1 = if p4 then 1 else GrowEffects.GetGrowthScale(p2, p3)

	if not (math.abs(v1 - p1:GetScale()) > 0.0001) then
		return
	end

	p1:ScaleTo(v1)
end

local function refreshPlantGrowthState(p1) --[[ refreshPlantGrowthState | Line: 150 | Upvalues: t5 (copy), t9 (copy) ]]
	local v1 = t5[p1]

	if not v1 then
		t9[p1] = nil

		return
	end

	local v2 = v1.MaxAge or 0

	if v2 > 0 and v2 <= (v1.CurrentAge or 0) then
		t9[p1] = nil
	else
		t9[p1] = true
	end
end

local function getOrCreateHarvestPart(p1) --[[ getOrCreateHarvestPart | Line: 165 ]]
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

function t.AddGrowPrompt(p1, p2) --[[ AddGrowPrompt | Line: 185 | Upvalues: getOrCreateHarvestPart (copy) ]]
	if p2:FindFirstChild("GrowPrompt", true) then
		return
	end

	local v1 = getOrCreateHarvestPart(p2)

	if v1 then
		local GrowPrompt = Instance.new("ProximityPrompt")

		GrowPrompt.Name = "GrowPrompt"
		GrowPrompt.ActionText = "Grow Plant\240\159\140\177"
		GrowPrompt.MaxActivationDistance = 10
		GrowPrompt.RequiresLineOfSight = false
		GrowPrompt.HoldDuration = 0
		GrowPrompt.Enabled = true
		GrowPrompt.Style = Enum.ProximityPromptStyle.Custom
		GrowPrompt:AddTag("GrowPrompt")
		GrowPrompt.Parent = v1
	end
end
function t.RemoveGrowPrompt(p1, p2) --[[ RemoveGrowPrompt | Line: 203 ]]
	local GrowPrompt = p2:FindFirstChild("GrowPrompt", true)

	if not GrowPrompt then
		return
	end

	GrowPrompt:Destroy()
end

local function hasMeaningfulOfflineGrowthData(p1) --[[ hasMeaningfulOfflineGrowthData | Line: 208 ]]
	if not (p1 and (p1.oldPlants and p1.newPlants)) then
		return false
	end

	for v1, v2 in p1.newPlants do
		local v3 = p1.oldPlants[v1]
		local v4 = if v3 then v3.Age or 0 else 0

		if math.abs((v2.Age or v4) - v4) > 0.0001 then
			return true
		end

		local v6 = v3 and v3.Fruits or {}

		for v8, v9 in v2.Fruits or {} do
			local v10 = v6[v8]
			local v11 = if v10 then v10.Age or 0 else 0

			if math.abs((v9.Age or v11) - v11) > 0.0001 then
				return true
			end

			local v13 = if v10 then v10.OvertimeGrowth or 1 else 1
			local v16 = math.max(math.abs(v13), 0.0001)

			if math.abs((v9.OvertimeGrowth or v13) - v13) / v16 > 0.05 then
				return true
			end
		end
	end

	return false
end

local function buildCutsceneParams(p1, p2) --[[ buildCutsceneParams | Line: 235 | Upvalues: v1 (ref) ]]
	local t = {
		oldPlants = p1.oldPlants,
		newPlants = p1.newPlants,
		effectiveGrowthTime = p1.effectiveGrowthTime,
		actualOfflineTime = p1.actualOfflineTime
	}

	t.skipCamera = if p1.skipCamera == true then true else false
	t.skipUI = if p1.skipUI == true then true else false
	t.skipLighting = if p1.skipLighting == true then true else false
	t.skipMusicDuck = if p1.skipMusicDuck == true then true else false
	t.skipSFX = if p1.skipSFX == true then true else false
	t.outlineGrowthPlants = if p1.outlineGrowthPlants == true then true else false
	t.targetUserId = p1.targetUserId
	t.tweenCameraRestore = if p1.tweenCameraRestore == true then true else false
	function t.getSpawnPoint(p1) --[[ getSpawnPoint | Line: 265 | Upvalues: p2 (copy) ]]
		return p2:GetSpawnPoint(p1)
	end
	function t.getSpawnedPlant(p1, p22) --[[ getSpawnedPlant | Line: 266 | Upvalues: p2 (copy) ]]
		return p2:GetSpawnedPlant(p1, p22)
	end
	function t.getPlantGrowthData(p1, p22) --[[ getPlantGrowthData | Line: 267 | Upvalues: p2 (copy) ]]
		return p2:GetPlantGrowthData(p1, p22)
	end
	function t.isSingleHarvestPlant(p1) --[[ isSingleHarvestPlant | Line: 268 | Upvalues: p2 (copy) ]]
		return p2:IsSingleHarvestPlant(p1)
	end
	function t.addPlantHarvestPrompt(p1) --[[ addPlantHarvestPrompt | Line: 269 | Upvalues: p2 (copy) ]]
		p2:AddHarvestPrompt(p1)
	end
	function t.getSpawnedFruit(p1, p2, p3) --[[ getSpawnedFruit | Line: 270 | Upvalues: v1 (ref) ]]
		if v1 then
			return v1:GetSpawnedFruit(p1, p2, p3)
		end

		return nil
	end
	function t.getFruitGrowthData(p1, p2, p3) --[[ getFruitGrowthData | Line: 274 | Upvalues: v1 (ref) ]]
		if v1 then
			return v1:GetFruitGrowthData(p1, p2, p3)
		end

		return nil
	end
	function t.addFruitHarvestPrompt(p1, p2, p3) --[[ addFruitHarvestPrompt | Line: 278 | Upvalues: v1 (ref) ]]
		if not v1 then
			return
		end

		v1:AddFruitHarvestPrompt(p1, p2, p3)
	end

	return t
end

local function applyFailedCutsceneFallback(p1, p2) --[[ applyFailedCutsceneFallback | Line: 286 | Upvalues: LocalPlayer (copy), t2 (copy), t5 (copy), v1 (ref) ]]
	for v12, v2 in p2 do
		local v3 = ("%*_%*"):format(LocalPlayer.UserId, v12)
		local v4 = t2[v3]
		local v5 = t5[v3]

		if v4 and (v5 and v2.Age) then
			v4:SetAttribute("Age", v2.Age)
			v5.CurrentAge = v2.Age

			if v2.Age >= v2.MaxAge and p1:IsSingleHarvestPlant(v2.PlantName) then
				p1:AddHarvestPrompt(v4)
			end
		end
	end

	if not v1 then
		return
	end

	for v6, v7 in p2 do
		if v7.Fruits then
			for v8, v9 in v7.Fruits do
				v1:FixFruitAgeAfterFailedCutscene(LocalPlayer.UserId, v6, v8, v9)
			end
		end
	end
end

local function restoreGrowAllCutsceneState(p1) --[[ restoreGrowAllCutsceneState | Line: 315 | Upvalues: t8 (copy), LocalPlayer (copy), ProximityPromptService (copy), Networking (copy) ]]
	p1:SetOfflineCutsceneState(false)
	t8[LocalPlayer.UserId] = nil
	ProximityPromptService.Enabled = true
	Networking.Garden.RequestGardens:Fire()
end

local function runCutscene(p1, p2) --[[ runCutscene | Line: 328 | Upvalues: OfflineGrowthAnimationController (copy), buildCutsceneParams (copy) ]]
	return OfflineGrowthAnimationController:PlayOfflineCutscene((buildCutsceneParams(p2, p1)))
end

local function reconcileLocalGardenUntilFilled() --[[ reconcileLocalGardenUntilFilled | Line: 339 | Upvalues: LocalPlayer (copy), GardenSyncController (copy), t2 (copy) ]]
	while LocalPlayer:GetAttribute("LoadingScreenActive") == true do
		task.wait()
	end

	local UserId = LocalPlayer.UserId

	for i = 1, 8 do
		local count = 0
		local v1 = false

		for v2 in GardenSyncController:GetGarden(UserId) do
			count = count + 1

			if not t2[("%*_%*"):format(UserId, v2)] then
				v1 = true
			end
		end

		if count > 0 and not v1 then
			break
		end

		GardenSyncController:ReconcileLocalGarden()
		task.wait(0.5)
	end
end

local function runOfflineLoginCutscene(p1) --[[ runOfflineLoginCutscene | Line: 370 | Upvalues: LocalPlayer (copy), Networking (copy), t8 (copy), ProximityPromptService (copy), OfflineGrowthAnimationController (copy), buildCutsceneParams (copy), applyFailedCutsceneFallback (copy), reconcileLocalGardenUntilFilled (copy) ]]
	repeat
		task.wait()
	until LocalPlayer:HasTag("DataLoaded")

	local v1 = os.clock()

	while LocalPlayer:GetAttribute("OfflineGrowthProcessed") ~= true and os.clock() - v1 < 10 do
		task.wait()
	end

	local v2

	if LocalPlayer:GetAttribute("OfflineGrowthProcessed") == true then
		local v3 = Networking.Garden.RequestOfflineGrowthData:Fire()

		v2 = if v3 and v3.processed then nil else v3
	else
		v2 = nil
	end

	local v4 = if v2 then v2.oldPlants and (v2.newPlants and (if next(v2.newPlants) == nil then false else true)) else v2
	local v5 = if v2 then if (v2.actualOfflineTime or 0) >= 300 then true else false else v2 -- MODDED: cutscene offline solo tras 5 min

	if v4 and v5 then
		t8[LocalPlayer.UserId] = v2.oldPlants
	end

	while LocalPlayer:GetAttribute("LoadingScreenActive") == true do
		task.wait()
	end

	if v4 and v5 then
		p1:SetOfflineCutsceneState(true)
		ProximityPromptService.Enabled = false
		t8[LocalPlayer.UserId] = v2.oldPlants

		if not OfflineGrowthAnimationController:PlayOfflineCutscene((buildCutsceneParams(v2, p1))) then
			applyFailedCutsceneFallback(p1, v2.newPlants)
		end
	end

	ProximityPromptService.Enabled = true
	p1:SetOfflineCutsceneState(false)
	t8[LocalPlayer.UserId] = nil
	Networking.Garden.RequestGardens:Fire()
	reconcileLocalGardenUntilFilled()
end

local function handleGrowAllStarting(p1) --[[ handleGrowAllStarting | Line: 434 | Upvalues: v3 (ref), ProximityPromptService (copy), t8 (copy), LocalPlayer (copy), Networking (copy) ]]
	v3 = v3 + 1

	local v1 = v3

	p1:SetOfflineCutsceneState(true)
	ProximityPromptService.Enabled = false
	task.delay(30, function() --[[ Line: 441 | Upvalues: v3 (ref), v1 (copy), p1 (copy), t8 (ref), LocalPlayer (ref), ProximityPromptService (ref), Networking (ref) ]]
		if v3 ~= v1 then
			return
		end

		p1:SetOfflineCutsceneState(false)
		t8[LocalPlayer.UserId] = nil
		ProximityPromptService.Enabled = true
		Networking.Garden.RequestGardens:Fire()
	end)
end

local function handleGrowAllComplete(p1) --[[ handleGrowAllComplete | Line: 452 | Upvalues: v3 (ref), Networking (copy), t8 (copy), LocalPlayer (copy), ProximityPromptService (copy), OfflineGrowthAnimationController (copy), buildCutsceneParams (copy), applyFailedCutsceneFallback (copy) ]]
	v3 = v3 + 1

	local v1 = Networking.Garden.RequestGrowAllData:Fire()

	if not v1 or not v1.oldPlants or not v1.newPlants or not next(v1.newPlants) then
		p1:SetOfflineCutsceneState(false)
		t8[LocalPlayer.UserId] = nil
		ProximityPromptService.Enabled = true
		Networking.Garden.RequestGardens:Fire()

		return
	end

	local v32 = if v1.skipUI == true then true elseif v1.skipCamera == true then true else false

	t8[LocalPlayer.UserId] = v1.oldPlants
	p1:SetOfflineCutsceneState(true)
	Networking.Garden.RequestGardens:Fire()

	if v1.playCutscene == true then
		if v32 then
			ProximityPromptService.Enabled = true
		else
			ProximityPromptService.Enabled = false
		end

		v1.tweenCameraRestore = true

		if not OfflineGrowthAnimationController:PlayOfflineCutscene((buildCutsceneParams(v1, p1))) then
			applyFailedCutsceneFallback(p1, v1.newPlants)
		end
	else
		applyFailedCutsceneFallback(p1, v1.newPlants)
	end

	p1:SetOfflineCutsceneState(false)
	t8[LocalPlayer.UserId] = nil
	ProximityPromptService.Enabled = true
	Networking.Garden.RequestGardens:Fire()
end

function t.FormatTimeRemaining(p1, p2) --[[ FormatTimeRemaining | Line: 507 ]]
	if p2 <= 0 then
		return "Done!"
	end

	local v1 = math.floor(p2 / 3600)
	local v2 = math.floor(p2 % 3600 / 60)
	local v3 = math.floor(p2 % 60)

	if v1 > 0 then
		return string.format("%dh %dm", v1, v2)
	end

	if v2 > 0 then
		return string.format("%dm %ds", v2, v3)
	end

	return string.format("%ds", v3)
end
function t.Init(p1) --[[ Init | Line: 518 | Upvalues: Plants (copy), t3 (copy), SeedData (copy), t4 (copy), v1 (ref) ]]
	for v12, v2 in Plants:GetChildren() do
		if v2:IsA("ModuleScript") then
			t3[v2.Name] = require(v2)
		end
	end

	for v3, v4 in SeedData do
		t4[v4.SeedName] = v4
	end

	task.defer(function() --[[ Line: 527 | Upvalues: v1 (ref) ]]
		v1 = require(script.Parent.FruitVisualizerController)
	end)
end
function t.UpdatePlantMutation(p1, p2, p3, p4) --[[ UpdatePlantMutation | Line: 532 | Upvalues: v2 (ref), t2 (copy) ]]
	if v2 then
		return
	end

	local v1 = t2[("%*_%*"):format(p2, p3)]

	if not v1 then
		return
	end

	if p4 and p4 ~= "" then
		v1:SetAttribute("Mutation", p4)

		return
	end

	v1:SetAttribute("Mutation", nil)
end
function t.Start(p1) --[[ Start | Line: 545 | Upvalues: GardenSyncController (copy), t2 (copy), Networking (copy), PlantLifecycleHandler (copy), v6 (ref), PerfFlags (copy), GrowEffects (copy), getDesiredAgeUpdateHz (copy), RunService (copy), v9 (ref), v1 (ref), runOfflineLoginCutscene (copy), v3 (ref), ProximityPromptService (copy), t8 (copy), LocalPlayer (copy), handleGrowAllComplete (copy), OfflineGrowthAnimationController (copy), buildCutsceneParams (copy) ]]
	GardenSyncController:OnPlantMutationUpdated(function(p12, p2, p3) --[[ Line: 546 | Upvalues: p1 (copy) ]]
		p1:UpdatePlantMutation(p12, p2, p3)
	end)
	GardenSyncController:OnPlantAdded(function(p12, p2, p3) --[[ Line: 549 | Upvalues: p1 (copy) ]]
		p1:SpawnPlantFromData(p12, p2, p3)
	end)
	GardenSyncController:OnPlantVisualCheck(function(p12, p2, p3) --[[ Line: 552 | Upvalues: t2 (ref), p1 (copy) ]]
		if t2[("%*_%*"):format(p12, p2)] then
			return
		end

		p1:SpawnPlantFromData(p12, p2, p3)
	end)
	GardenSyncController:OnPlantRemoved(function(p12, p2) --[[ Line: 558 | Upvalues: p1 (copy) ]]
		p1:RemovePlantById(p12, p2)
	end)
	GardenSyncController:OnPlantGrowthUpdated(function(p12, p2, p3, p4) --[[ Line: 561 | Upvalues: p1 (copy) ]]
		p1:UpdatePlantGrowthData(p12, p2, p3, p4)
	end)
	GardenSyncController:OnPlantAgeSync(function(p12, p2) --[[ Line: 564 | Upvalues: p1 (copy) ]]
		p1:SyncPlantAges(p12, p2)
	end)
	Networking.Garden.PlantLifecycleUpdated.OnClientEvent:Connect(function(p1, p2, p3, p4) --[[ Line: 568 | Upvalues: t2 (ref), PlantLifecycleHandler (ref) ]]
		local v1 = t2[tostring(p1) .. "_" .. p2]

		PlantLifecycleHandler:RegisterPlantModel(p1, p2, p3, p4, v1, t2[tostring(p1) .. "_" .. p2] and v1:GetAttribute("Mutation") or nil)
	end)

	local ok, result = pcall(function() --[[ Line: 575 ]]
		return UserSettings().GameSettings
	end)

	if ok and (result and result.GetPropertyChangedSignal) then
		result:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() --[[ Line: 577 | Upvalues: v6 (ref), PerfFlags (ref), GrowEffects (ref), getDesiredAgeUpdateHz (ref) ]]
			local v1 = 1 / PerfFlags.AgeUpdateMaxHz:Get()
			local v2

			if GrowEffects.SmoothGrow then
				local v3 = getDesiredAgeUpdateHz()

				v2 = math.max(if v3 <= 0 then 0.02 else 1 / math.clamp(v3, 15, 60), 0.1, v1)
			else
				v2 = math.max(GrowEffects.GrowTick, 0.1, v1)
			end

			v6 = v2
		end)
	end

	PerfFlags.AgeUpdateMaxHz.Changed:Connect(function() --[[ Line: 582 | Upvalues: v6 (ref), PerfFlags (ref), GrowEffects (ref), getDesiredAgeUpdateHz (ref) ]]
		local v1 = 1 / PerfFlags.AgeUpdateMaxHz:Get()
		local v2

		if GrowEffects.SmoothGrow then
			local v3 = getDesiredAgeUpdateHz()

			v2 = math.max(if v3 <= 0 then 0.02 else 1 / math.clamp(v3, 15, 60), 0.1, v1)
		else
			v2 = math.max(GrowEffects.GrowTick, 0.1, v1)
		end

		v6 = v2
	end)
	RunService.Heartbeat:Connect(function(p12) --[[ Line: 586 | Upvalues: v9 (ref), v6 (ref), p1 (copy) ]]
		debug.profilebegin("Controllers/PlantVisualizerController/Heartbeat")
		v9 = v9 + p12

		local count = 0

		while v6 <= v9 and count < 5 do
			v9 = v9 - v6
			p1:UpdatePlantAges(v6)
			count = count + 1
		end

		if v9 >= 1 then
			local v2 = math.min(v9, 5)

			v9 = 0
			p1:UpdatePlantAges(v2)
		end

		debug.profileend()
	end)
	v1 = require(script.Parent.FruitVisualizerController)
	p1:SetOfflineCutsceneState(false)
	task.spawn(runOfflineLoginCutscene, p1)
	Networking.Garden.GrowAllStarting.OnClientEvent:Connect(function() --[[ Line: 608 | Upvalues: p1 (copy), v3 (ref), ProximityPromptService (ref), t8 (ref), LocalPlayer (ref), Networking (ref) ]]
		local v1 = p1

		v3 = v3 + 1

		local v2 = v3

		v1:SetOfflineCutsceneState(true)
		ProximityPromptService.Enabled = false
		task.delay(30, function() --[[ Line: 441 | Upvalues: v3 (ref), v2 (copy), v1 (copy), t8 (ref), LocalPlayer (ref), ProximityPromptService (ref), Networking (ref) ]]
			if v3 ~= v2 then
				return
			end

			v1:SetOfflineCutsceneState(false)
			t8[LocalPlayer.UserId] = nil
			ProximityPromptService.Enabled = true
			Networking.Garden.RequestGardens:Fire()
		end)
	end)
	Networking.Garden.GrowAllComplete.OnClientEvent:Connect(function() --[[ Line: 612 | Upvalues: handleGrowAllComplete (ref), p1 (copy) ]]
		task.spawn(handleGrowAllComplete, p1)
	end)
	Networking.Garden.GrowAllStartingForObserver.OnClientEvent:Connect(function(p1, p2) --[[ Line: 619 | Upvalues: LocalPlayer (ref), t8 (ref) ]]
		if typeof(p1) ~= "number" or type(p2) ~= "table" then
			return
		end

		if p1 ~= LocalPlayer.UserId then
			t8[p1] = p2
		end
	end)
	Networking.Garden.GrowAllCompleteForObserver.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 629 | Upvalues: LocalPlayer (ref), t8 (ref), OfflineGrowthAnimationController (ref), buildCutsceneParams (ref), p1 (copy), v1 (ref) ]]
		if typeof(p12) ~= "number" then
			return
		end

		if p12 == LocalPlayer.UserId then
			return
		end

		if type(p2) ~= "table" or next(p2) == nil then
			t8[p12] = nil

			return
		end

		local v12 = t8[p12]

		if type(v12) ~= "table" then
			return
		end

		local v2 = if type(p3) == "table" then p3 else {}

		task.spawn(function() --[[ Line: 651 | Upvalues: v12 (copy), p2 (copy), v2 (copy), p12 (copy), OfflineGrowthAnimationController (ref), buildCutsceneParams (ref), p1 (ref), v1 (ref), t8 (ref) ]]
			local t = {
				effectiveGrowthTime = 86400,
				actualOfflineTime = 86400,
				oldPlants = v12,
				newPlants = p2
			}

			t.skipCamera = v2.skipCamera == true
			t.skipUI = v2.skipUI == true
			t.skipLighting = v2.skipLighting == true
			t.skipMusicDuck = v2.skipMusicDuck == true
			t.skipSFX = v2.skipSFX == true
			t.targetUserId = p12

			local ok, _ = pcall(function() --[[ Line: 664 | Upvalues: OfflineGrowthAnimationController (ref), buildCutsceneParams (ref), t (copy), p1 (ref) ]]
				OfflineGrowthAnimationController:PlayOfflineCutscene((buildCutsceneParams(t, p1)))
			end)

			if ok or not v1 then
				t8[p12] = nil

				return
			end

			for v13, v22 in p2 do
				if v22.Fruits then
					for v3, v4 in v22.Fruits do
						v1:FixFruitAgeAfterFailedCutscene(p12, v13, v3, v4)
					end
				end
			end

			t8[p12] = nil
		end)
	end)
end
function t.GetPlayerPlot(p1, p2) --[[ GetPlayerPlot | Line: 694 | Upvalues: Players (copy), Gardens (copy) ]]
	local v1 = Players:GetPlayerByUserId(p2)

	if not v1 then
		return nil
	end

	local v2 = v1:GetAttribute("PlotId")

	if not v2 then
		for i = 1, 50 do
			task.wait(0.1)

			local v3 = Players:GetPlayerByUserId(p2)

			if not v3 then
				return nil
			end

			local v4 = v3:GetAttribute("PlotId")

			v2 = v4

			if v4 then
				break
			end
		end
	end

	if v2 then
		return Gardens:WaitForChild("Plot" .. v2, 10)
	end

	return nil
end
function t.GetSpawnPoint(p1, p2) --[[ GetSpawnPoint | Line: 718 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if v1 then
		return v1:WaitForChild("SpawnPoint", 10)
	end

	return nil
end
function t.GetPlantsFolder(p1, p2) --[[ GetPlantsFolder | Line: 724 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if v1 then
		return v1:WaitForChild("Plants", 10)
	end

	return nil
end
function t.GetSeedData(p1, p2) --[[ GetSeedData | Line: 730 | Upvalues: t4 (copy) ]]
	return t4[p2]
end
function t.GetOfflineCutsceneOldPlantAge(p1, p2, p3) --[[ GetOfflineCutsceneOldPlantAge | Line: 734 | Upvalues: t8 (copy) ]]
	local v1 = t8[p2]

	if not v1 then
		return nil
	end

	local v2 = v1[p3]

	if not v2 then
		return nil
	end

	if typeof(v2.Age) == "number" then
		return v2.Age
	end

	return nil
end
function t.GetOfflineCutsceneOldFruitAge(p1, p2, p3, p4) --[[ GetOfflineCutsceneOldFruitAge | Line: 742 | Upvalues: t8 (copy) ]]
	local v1 = t8[p2]

	if not v1 then
		return nil
	end

	local v2 = v1[p3]
	local v3 = if v2 then v2.Fruits else v2
	local v4 = if v3 then v3[p4] else v3

	if not v4 then
		return 0
	end

	if typeof(v4.Age) == "number" then
		return v4.Age
	end

	return 0
end
function t.HasOfflineCutsceneSnapshot(p1, p2) --[[ HasOfflineCutsceneSnapshot | Line: 761 | Upvalues: t8 (copy) ]]
	return t8[p2] ~= nil
end
function t.IsSingleHarvestPlant(p1, p2) --[[ IsSingleHarvestPlant | Line: 765 ]]
	local v1 = p1:GetSeedData(p2)

	if not v1 then
		return false
	end

	return v1.IsSingleHarvest == true
end
function t.AddHarvestPrompt(p1, p2) --[[ AddHarvestPrompt | Line: 771 | Upvalues: getOrCreateHarvestPart (copy), LocalPlayer (copy) ]]
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

	StealPrompt.MaxActivationDistance = 10
	StealPrompt.RequiresLineOfSight = false
	StealPrompt.Enabled = true
	StealPrompt.Style = Enum.ProximityPromptStyle.Custom

	if isUserId then
		StealPrompt.Name = "HarvestPrompt"
		StealPrompt.ActionText = "Harvest"
		StealPrompt.HoldDuration = 0
		StealPrompt:AddTag("HarvestPrompt")
	else
		p2:GetAttribute("SeedName")
		StealPrompt.Name = "StealPrompt"
		StealPrompt.ActionText = "Steal"
		StealPrompt:AddTag("StealPrompt")
		StealPrompt.HoldDuration = 0
	end

	StealPrompt.Parent = v1
end

local GrowSFX = game.SoundService.SFX.GrowSFX
local t10 = {
	{
		Range = 3,
		SFX = GrowSFX.Small,
		VolumeRange = {
			Lowest = 0,
			Highest = 3
		},
		VolumeRangeSFX = {
			Lowest = 0.02,
			Highest = 0.07
		}
	},
	{
		Range = 40,
		SFX = GrowSFX.Medium,
		VolumeRange = {
			Lowest = 3,
			Highest = 40
		},
		VolumeRangeSFX = {
			Lowest = 0.07,
			Highest = 0.125
		}
	},
	{
		Range = (1 / 0),
		SFX = GrowSFX.Large,
		VolumeRange = {
			Lowest = 40,
			Highest = 100
		},
		VolumeRangeSFX = {
			Lowest = 0.125,
			Highest = 0.5
		}
	}
}
local Plants2 = game.ReplicatedStorage.PlantGenerationModules.Plants
local TweenService = game:GetService("TweenService")
local v10 = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)

function t.AddGrowthSFX(p1, p2, p3) --[[ AddGrowthSFX | Line: 858 | Upvalues: t10 (copy), GrowRateData (copy), TweenService (copy), v10 (copy) ]]
	if not p2.PrimaryPart then
		return
	end

	if p2.PrimaryPart:FindFirstChild("GrowSFX") then
		return
	end

	local _, v1 = p2:GetBoundingBox()
	local Magnitude = v1.Magnitude
	local v2 = nil
	local v3 = 0

	for v4, v5 in t10 do
		if Magnitude <= v5.Range then
			local Lowest = v5.VolumeRange.Lowest
			local Highest = v5.VolumeRange.Highest
			local Lowest2 = v5.VolumeRangeSFX.Lowest
			local v6 = if Lowest < Highest then math.clamp((Magnitude - Lowest) / (Highest - Lowest), 0, 1) else 0

			v2 = v5.SFX
			v3 = Lowest2 + v6 * (v5.VolumeRangeSFX.Highest - Lowest2)

			break
		end
	end

	if not v2 then
		return
	end

	local v9 = math.clamp(0.7 + (GrowRateData[p3.SeedName] and GrowRateData[p3.SeedName].GrowRate or 0.2) * 3, 0.7, 1.3)
	local GrowSFX = v2:Clone()

	GrowSFX.Name = "GrowSFX"
	GrowSFX.Looped = true
	GrowSFX.Playing = true
	GrowSFX.Volume = 0

	local v102 = TweenService:Create(GrowSFX, v10, {
		Volume = v3 * math.random(9, 11) * 0.1
	})

	v102:Play()
	game.Debris:AddItem(v102, v10.Time)
	GrowSFX.RollOffMaxDistance = math.sqrt(v3 * 100) * 10 * math.random(9, 11) * 0.1
	GrowSFX.PlaybackSpeed = v9 * (math.random(9, 11) * 0.1)
	GrowSFX.Parent = p2.PrimaryPart
end
function t.RemoveGrowthSFX(p1, p2) --[[ RemoveGrowthSFX | Line: 907 | Upvalues: TweenService (copy), v10 (copy) ]]
	local GrowSFX = p2:FindFirstChild("GrowSFX", true)

	if not GrowSFX then
		return
	end

	if not GrowSFX:HasTag("Removing") then
		GrowSFX:AddTag("Removing")

		local v1 = TweenService:Create(GrowSFX, v10, {
			Volume = 0
		})

		v1:Play()
		game.Debris:AddItem(v1, v10.Time)
		game.Debris:AddItem(GrowSFX, v10.Time)
	end
end
function t.RemoveHarvestPrompt(p1, p2) --[[ RemoveHarvestPrompt | Line: 918 ]]
	local HarvestPrompt = p2:FindFirstChild("HarvestPrompt", true)

	if not HarvestPrompt then
		return
	end

	HarvestPrompt:Destroy()
end
function t.CreateDebugGui(p1, p2, p3) --[[ CreateDebugGui | Line: 923 ]]
	local DebugGui = Instance.new("BillboardGui")

	DebugGui.Name = "DebugGui"
	DebugGui.Size = UDim2.new(0, 250, 0, 60)
	DebugGui.StudsOffset = Vector3.new(0, 3, 0)
	DebugGui.AlwaysOnTop = true
	DebugGui.Parent = p2
	DebugGui.Enabled = false

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	TextLabel.BackgroundTransparency = 0.5
	TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	TextLabel.TextScaled = true
	TextLabel.Font = Enum.Font.SourceSansBold
	TextLabel.Parent = DebugGui
end
function t._StepPlantVisual(p1, p2, p3, p4) --[[ _StepPlantVisual | Line: 944 | Upvalues: t2 (copy), t8 (copy), t5 (copy), setPlantAgeWithScale (copy), t9 (copy) ]]
	local v1 = t2[p2]

	if v1 and v1.Parent then
		if p4 then
			local v2 = tonumber(v1:GetAttribute("UserId"))

			if v2 and t8[v2] then
				return false
			end
		end

		local v3 = t5[p2]

		if not v3 then
			return false
		end

		local v4 = v3.CurrentAge or 0
		local v6 = math.min(v4 + p3 * v3.StableGrowthAmount, v3.MaxAge)
		local v7 = if v4 < v3.MaxAge then true else false
		local v8 = if v3.MaxAge <= v6 then true else false

		v3.CurrentAge = v6
		setPlantAgeWithScale(v1, v6, v3.MaxAge, v8)

		if v7 and v8 then
			t9[p2] = nil
			p1:RemoveGrowPrompt(v1)

			local v9 = v1:GetAttribute("SeedName")

			p1:RemoveGrowthSFX(v1)

			if not p1:IsSingleHarvestPlant(v9) then
				return true
			end

			p1:AddHarvestPrompt(v1)

			return true
		end

		local DebugGui = v1:FindFirstChild("DebugGui")

		if not (DebugGui and DebugGui:IsA("BillboardGui")) then
			return false
		end

		local TextLabel = DebugGui:FindFirstChildOfClass("TextLabel")

		if not TextLabel then
			return false
		end

		TextLabel.Text = string.format("%.2f/%.0f | %s\nRate: %.2f/s", v6, v3.MaxAge, p1:FormatTimeRemaining(v3.StableGrowthAmount > 0 and (v3.MaxAge - v6) / v3.StableGrowthAmount or 0), v3.StableGrowthAmount)

		return false
	end

	t9[p2] = nil

	if not v1 then
		return true
	end

	p1:RemoveGrowthSFX(v1)

	return true
end
function t.UpdatePlantAges(p1, p2) --[[ UpdatePlantAges | Line: 998 | Upvalues: v2 (ref), t8 (copy), t9 (copy), t5 (copy), v4 (ref), PerfFlags (copy) ]]
	if v2 then
		return
	end

	local v1 = if next(t8) == nil then false else true

	debug.profilebegin("Controllers/PlantVisualizerController/UpdatePlantAges/accumulate")

	local count = 0

	for v22 in t9 do
		local v3 = t5[v22]

		if v3 then
			v3._pendingDt = (v3._pendingDt or 0) + p2
		end

		count = count + 1
	end

	debug.profileend()

	if count == 0 then
		v4 = nil

		return
	end

	debug.profilebegin("Controllers/PlantVisualizerController/UpdatePlantAges/iterateGrowingPlants")

	local v6 = math.min(math.floor((PerfFlags.PlantVisualizerBudget:Get())), count)
	local v7 = v4

	if v7 ~= nil and not t9[v7] then
		v7 = nil
	end

	local count2 = 0

	while count2 < v6 do
		local v8
		local v9 = next(t9, v7)

		if v9 == nil then
			local v10 = next(t9, nil)

			if v10 == nil then
				break
			end

			v9 = v10
		end

		local v11 = t5[v9]

		if v11 then
			v8 = v11._pendingDt

			if v8 then
				v7 = v9
			else
				v8 = 0
				v7 = v9
			end
		else
			v8 = 0
			v7 = v9
		end

		if v11 then
			v11._pendingDt = 0
		end

		p1:_StepPlantVisual(v9, v8, v1)
		count2 = count2 + 1
	end

	v4 = v7
	debug.profileend()
end
function t.UpdatePlantGrowthData(p1, p2, p3, p4, p5) --[[ UpdatePlantGrowthData | Line: 1061 | Upvalues: v2 (ref), t8 (copy), t5 (copy), t6 (copy), t2 (copy), setPlantAgeWithScale (copy), t9 (copy) ]]
	if v2 then
		return
	end

	if t8[p2] then
		return
	end

	local v1 = ("%*_%*"):format(p2, p3)
	local v22 = t5[v1]

	if not v22 then
		t6[v1] = {
			Age = p4,
			StableGrowthAmount = p5
		}

		return
	end

	local v3 = if v22.CurrentAge < v22.MaxAge then true else false
	local v5 = math.max(v22.CurrentAge or 0, p4)
	local v6, v7

	if v22.MaxAge <= v5 then
		v6 = v1
		v7 = true
	else
		v6 = v1
		v7 = false
	end

	v22.StableGrowthAmount = p5
	v22.CurrentAge = v5

	local v8 = t2[v6]

	if v8 then
		if v8.Parent then
			setPlantAgeWithScale(v8, v5, v22.MaxAge, v7)
		end

		if v3 and v7 then
			local v9 = v8:GetAttribute("SeedName")

			p1:RemoveGrowPrompt(v8)
			p1:RemoveGrowthSFX(v8)

			if p1:IsSingleHarvestPlant(v9) then
				p1:AddHarvestPrompt(v8)
			end
		end
	end

	local v10 = t5[v6]

	if not v10 then
		t9[v6] = nil

		return
	end

	local v11 = v10.MaxAge or 0

	if v11 > 0 and v11 <= (v10.CurrentAge or 0) then
		t9[v6] = nil
	else
		t9[v6] = true
	end
end
function t.SyncPlantAges(p1, p2, p3) --[[ SyncPlantAges | Line: 1103 | Upvalues: v2 (ref), t8 (copy), t5 (copy), t2 (copy), t7 (copy), setPlantAgeWithScale (copy), t9 (copy) ]]
	if v2 then
		return
	end

	if t8[p2] then
		return
	end

	for v3, v4 in p3 do
		local v1, v22
		local v5 = ("%*_%*"):format(p2, v3)
		local v6 = t5[v5]
		local v7 = t2[v5]

		if v6 and v7 then
			local v8 = if v6.CurrentAge < v6.MaxAge then true else false
			local v10 = math.max(v6.CurrentAge or 0, v4)

			if v6.CurrentAge >= v6.MaxAge and v4 < v6.MaxAge then
				v10 = v6.MaxAge
			end

			v6.CurrentAge = v10

			if v8 and v6.MaxAge <= v10 then
				local v11 = v7:GetAttribute("SeedName")

				p1:RemoveGrowPrompt(v7)
				p1:RemoveGrowthSFX(v7)

				if p1:IsSingleHarvestPlant(v11) then
					p1:AddHarvestPrompt(v7)
				end
			end

			if v6.CurrentAge >= v6.MaxAge and v4 < v6.MaxAge then
				v1 = v6.MaxAge
				v22 = v5

				if not v1 then
					v1 = v4
				end
			else
				v22 = v5
				v1 = v4
			end

			setPlantAgeWithScale(v7, v1, v6.MaxAge, if v6.MaxAge <= v1 then true else false)

			local v14 = t5[v22]

			if v14 then
				local v15 = v14.MaxAge or 0

				if v15 > 0 and v15 <= (v14.CurrentAge or 0) then
					t9[v22] = nil

					continue
				end

				t9[v22] = true

				continue
			end

			t9[v22] = nil

			continue
		end

		t7[v5] = math.max(t7[v5] or 0, v4)
	end
end
function t.SpawnPlantFromData(p1, p2, p3, p4) --[[ SpawnPlantFromData | Line: 1145 | Upvalues: t2 (copy), t3 (copy), t6 (copy), GrowRateData (copy), t7 (copy), t5 (copy), GrowEffects (copy), PlantLifecycleHandler (copy), t9 (copy), ReplicatedStorage (copy), LocalPlayer (copy), v2 (ref), t8 (copy) ]]
	local v1 = ("%*_%*"):format(p2, p3)

	if t2[v1] then
		p1:RemovePlantById(p2, p3)
	end

	local v22 = p1:GetSpawnPoint(p2)

	if not v22 then
		return
	end

	local v3 = p1:GetPlantsFolder(p2)

	if not v3 then
		return
	end

	local PlantName = p4.PlantName

	if not PlantName then
		return
	end

	local v5 = v22.CFrame:PointToWorldSpace((Vector3.new(p4.Positions.PosX, p4.Positions.PosY, p4.Positions.PosZ)))
	local _, v7, _2 = v22.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, 0)) * CFrame.Angles(0, math.rad(p4.Positions.Rotation), 0)):ToEulerAnglesYXZ()
	local v8 = CFrame.new(v5) * CFrame.Angles(0, v7, 0)
	local v9 = t3[PlantName]
	local v10 = p1:GetSeedData(PlantName)

	if not v9 then
		return error((("[%*] Missing Generation Module for %*"):format(script.Name, PlantName)))
	end

	local v11 = v10.PlantModel:Clone()

	v11.Name = v1
	v11:SetAttribute("PlantId", p3)
	v11:SetAttribute("UserId", p2)
	v11:SetAttribute("SeedName", PlantName)
	v11:SetAttribute("MaxAge", p4.MaxAge)

	if p4.PlantedAt then
		v11:SetAttribute("PlantedAt", p4.PlantedAt)
	end

	v11.Parent = v3
	v11:PivotTo(v8)

	local v12 = p4.Age or 0
	local v13 = t6[v1]
	local v14 = GrowRateData[PlantName] and GrowRateData[PlantName].GrowRate
	-- El server envejece en tiempo real (1 unidad/seg hasta MaxAge=PrimeTime), asi
	-- que la planta debe crecer localmente a 1/seg para ir pareja con la edad
	-- autoritativa. Antes usaba GrowRate (ej. 0.4) y el sync la corregia a saltos.
	local v15 = v13 and v13.StableGrowthAmount or 1
	local v17 = if v13 and v13.Age ~= nil then math.max(v12, v13.Age) else v12

	if t7[v1] ~= nil then
		v17 = math.max(v17, t7[v1])
	end

	local v21 = p1:GetOfflineCutsceneOldPlantAge(p2, p3)

	if typeof(v21) == "number" then
		v17 = v21
	end

	t5[v1] = {
		CurrentAge = v17,
		StableGrowthAmount = v15,
		MaxAge = p4.MaxAge,
		_syncedAge = v12
	}
	t6[v1] = nil
	t7[v1] = nil
	p1:CreateDebugGui(v11, v1)
	v11:SetAttribute("Age", v17)
	v11:SetAttribute("Mutation", p4.Mutation)
	v9.InitPlant(v11, p4.Seed or 0, p4.SizeMultiplier or 1)
	t2[v1] = v11

	if not v11:HasTag("InitializationComplete") then
		repeat
			task.wait()
		until v11:HasTag("InitializationComplete")
	end

	-- MODDED: estiramiento no uniforme (alto/ancho) para las OpSize seeds del
	-- comando admin /opseed. Se aplica DESPUÉS de InitPlant (geometría base ya
	-- horneada con SizeMultiplier) y ANTES del crecimiento: como BeginPlantGrowth
	-- usa ScaleTo (uniforme), la proporción alto/ancho se conserva mientras crece.
	do
		local wMul = p4.WidthMultiplier or 1
		local hMul = p4.HeightMultiplier or 1
		if math.abs(wMul - 1) > 0.0001 or math.abs(hMul - 1) > 0.0001 then
			local pivotCF = v11:GetPivot()
			for _, d in v11:GetDescendants() do
				if d:IsA("BasePart") then
					local rel = pivotCF:ToObjectSpace(d.CFrame)
					local relPos = rel.Position
					local newRelPos = Vector3.new(relPos.X * wMul, relPos.Y * hMul, relPos.Z * wMul)
					d.Size = Vector3.new(d.Size.X * wMul, d.Size.Y * hMul, d.Size.Z * wMul)
					d.CFrame = pivotCF:ToWorldSpace((rel - relPos) + newRelPos)
				elseif d:IsA("SpecialMesh") then
					d.Scale = Vector3.new(d.Scale.X * wMul, d.Scale.Y * hMul, d.Scale.Z * wMul)
				end
			end
		end
	end

	v9.BeginPlantGrowth(v11)
	v11:SetAttribute("PlantGrowthReady", true)

	if GrowEffects.InitialScale ~= 1 and v17 < p4.MaxAge then
		local v222 = GrowEffects.GetGrowthScale(v17, p4.MaxAge)

		if math.abs(v222 - 1) > 0.0001 then
			v11:ScaleTo(v222)
		end
	end

	PlantLifecycleHandler:RegisterPlantModel(p2, p3, PlantName, p4.PrimeStartedAt, v11, p4.Mutation, p4.ReviveProgress)

	local v23 = t5[v1]

	if v23 then
		local v24 = v23.MaxAge or 0

		if v24 > 0 and v24 <= (v23.CurrentAge or 0) then
			t9[v1] = nil
		else
			t9[v1] = true
		end
	else
		t9[v1] = nil
	end

	if p4.IsPotted then
		local PotVisual = ReplicatedStorage.Assets.POT:Clone()

		PotVisual.Name = "PotVisual"
		PotVisual:ScaleTo(p4.SizeMultiplier or 1)

		for k, v in pairs(PotVisual:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Anchored = true
				v.CanCollide = true
				v.CanQuery = true
			end
		end

		local _3, v25 = PotVisual:GetBoundingBox()
		local v26 = PotVisual:GetPivot()

		PotVisual:PivotTo(CFrame.new(v8.Position.X, v8.Position.Y + (v26.Position.Y - (v26.Position.Y - v25.Y / 2)), v8.Position.Z) * CFrame.Angles(0, v7, 0))
		PotVisual.Parent = workspace

		local PlantRoot = PotVisual:FindFirstChild("PlantRoot", true)

		if PlantRoot then
			v11:PivotTo(v11:GetPivot() * CFrame.new(0, PlantRoot.WorldPosition.Y - v8.Position.Y, 0))
		end

		PotVisual.Parent = v11

		local PrimaryPart = PotVisual.PrimaryPart

		if PrimaryPart then
			local PickUpPottedPlantPrompt = Instance.new("ProximityPrompt")

			PickUpPottedPlantPrompt.Name = "PickUpPottedPlantPrompt"
			PickUpPottedPlantPrompt.ActionText = "Pick Up"
			PickUpPottedPlantPrompt.ObjectText = PlantName .. " [Potted]"
			PickUpPottedPlantPrompt.HoldDuration = 1
			PickUpPottedPlantPrompt.KeyboardKeyCode = Enum.KeyCode.Q
			PickUpPottedPlantPrompt.MaxActivationDistance = 10
			PickUpPottedPlantPrompt.RequiresLineOfSight = false
			PickUpPottedPlantPrompt.Style = Enum.ProximityPromptStyle.Custom
			PickUpPottedPlantPrompt:AddTag("PickUpPottedPlantPrompt")
			PickUpPottedPlantPrompt.Parent = PrimaryPart

			if tonumber(p2) ~= LocalPlayer.UserId then
				PickUpPottedPlantPrompt.Enabled = false
			end
		end
	end

	if v2 or t8[p2] then
		return
	end

	if p4.MaxAge <= (t5[v1] and t5[v1].CurrentAge or v17) then
		if p1:IsSingleHarvestPlant(PlantName) then
			p1:AddHarvestPrompt(v11)
		end
	else
		p1:AddGrowthSFX(v11, v10)
	end
end
function t.RemovePlantById(p1, p2, p3) --[[ RemovePlantById | Line: 1338 | Upvalues: t2 (copy), PlantLifecycleHandler (copy), t5 (copy), t6 (copy), t7 (copy), t9 (copy) ]]
	local v1 = p2 .. "_" .. p3
	local v2 = t2[v1]

	if not v2 then
		return
	end

	PlantLifecycleHandler:UnregisterPlantModel(p2, p3)
	v2:Destroy()
	t2[v1] = nil
	t5[v1] = nil
	t6[v1] = nil
	t7[v1] = nil
	t9[v1] = nil
end
function t.SetOfflineCutsceneState(p1, p2) --[[ SetOfflineCutsceneState | Line: 1352 | Upvalues: v2 (ref), t8 (copy), LocalPlayer (copy), v1 (ref) ]]
	v2 = p2

	if not p2 then
		t8[LocalPlayer.UserId] = nil
		p1:AddMissingPrompts()
	end

	if not v1 then
		return
	end

	v1:SetOfflineCutsceneState(p2)
end
function t.GetOfflineCutsceneState(p1) --[[ GetOfflineCutsceneState | Line: 1367 | Upvalues: v2 (ref) ]]
	return v2
end
function t.AddMissingPrompts(p1) --[[ AddMissingPrompts | Line: 1371 | Upvalues: t2 (copy), t5 (copy), t9 (copy) ]]
	for v1, v2 in t2 do
		if v2 and v2.Parent then
			local v3 = t5[v1]

			if v3 and not (v3.CurrentAge < v3.MaxAge) then
				t9[v1] = nil
				p1:RemoveGrowPrompt(v2)
				p1:RemoveGrowthSFX(v2)

				if not v2:FindFirstChild("HarvestPrompt", true) and (not v2:FindFirstChild("StealPrompt", true) and p1:IsSingleHarvestPlant((v2:GetAttribute("SeedName")))) then
					p1:AddHarvestPrompt(v2)
				end
			end
		end
	end
end
function t.GetSpawnedPlant(p1, p2, p3) --[[ GetSpawnedPlant | Line: 1393 | Upvalues: t2 (copy) ]]
	return t2[("%*_%*"):format(p2, p3)]
end
function t.GetPlantGrowthData(p1, p2, p3) --[[ GetPlantGrowthData | Line: 1397 | Upvalues: t5 (copy) ]]
	return t5[("%*_%*"):format(p2, p3)]
end

return t