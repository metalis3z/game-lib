-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local AssetRuntime = require(ReplicatedStorage.Library.Types.AssetRuntime)
local AssetGenderUtil = require(ReplicatedStorage.Library.Util.AssetGenderUtil)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)

require(script.Parent.AssetBillboardController)

local AssetComponent = require(script.Parent.AssetComponent)

require(script.Parent.AssetMovementBatch)

local ActiveAssetPerformanceTestConfig = require(script.Parent.ActiveAssetPerformanceTestConfig)
local v1 = Log.new()
local v2 = Random.new()
local t = {}
local v3 = nil
local t2 = {}
local v4 = nil
local v5 = nil

for k in pairs(Assets.Directory) do
	if k ~= "Frigo Camelo" then
		table.insert(t, k)
	end
end

table.sort(t)
assert(if #t > 0 then true else false, "Active asset performance test requires at least one eligible category")

local t3 = {}

local function buildRuntimeRecord(p1, p2) --[[ buildRuntimeRecord | Line: 57 | Upvalues: t (copy), v2 (copy), EggItemUtil (copy), AssetGenderUtil (copy), Personalities (copy), Players (copy), AssetGenerationUtil (copy), AssetRuntime (copy) ]]
	local v1 = t[v2:NextInteger(1, #t)]
	local v22 = EggItemUtil.BuildSavedEgg(v1, v2)

	v22.AssetGender = AssetGenderUtil.ResolveForCategory(v1, nil, v2)
	v22.AssetPersonality = Personalities.Roll(v2)

	local v3 = EggItemUtil.BuildAssetItemData(v22)

	v3.HasBeenFirstPlaced = true

	local v4 = ("PERFORMANCE_TEST_%*_%*"):format(p1, p2)
	local t2 = {
		OwnerUserId = Players.LocalPlayer.UserId,
		UID = v4,
		ItemData = v3,
		MoneyPerSecond = AssetGenerationUtil.GetRate(v3, 0),
		Seed = v2:NextInteger(1, 2147483647)
	}

	assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(t2), "Invalid performance-test asset record")

	return t2
end

local function destroySlot(p1) --[[ destroySlot | Line: 76 | Upvalues: t2 (copy), v4 (ref) ]]
	local v1 = t2[p1]

	if v1 == nil then
		return
	end

	t2[p1] = nil

	for i, v in ipairs(v1.Components) do
		v4:Remove(v:GetModel())
		v:Destroy()
	end

	v1.Container:Destroy()
end

local function activateSlot(p1, p2) --[[ activateSlot | Line: 89 | Upvalues: v5 (ref), ActiveAssetPerformanceTestConfig (copy), buildRuntimeRecord (copy), AssetComponent (copy), Players (copy), v4 (ref), v3 (ref), t2 (copy), v1 (copy) ]]
	local v12 = Instance.new("Folder")

	v12.Name = ("Plot%*"):format(p1)
	v12.Parent = v5

	local t = {}

	for i = 1, ActiveAssetPerformanceTestConfig.PetsPerPlot do
		local v2 = buildRuntimeRecord(p1, i)
		local v32 = AssetComponent.new(v2, Players.LocalPlayer, p2, v12, v4, v3, nil)

		v4:Add(v32:GetModel(), v2.ItemData, v2.MoneyPerSecond)
		table.insert(t, v32)
	end

	t2[p1] = {
		Area = p2,
		Components = t,
		Container = v12
	}
	v1:AtInfo():Log((("Created %* performance-test pets for plot %*"):format(ActiveAssetPerformanceTestConfig.PetsPerPlot, p1)))
end

local function syncSlot(p1) --[[ syncSlot | Line: 109 | Upvalues: PlotCmds (copy), t2 (copy), destroySlot (copy), activateSlot (copy) ]]
	local v1 = nil
	local v2 = PlotCmds.GetPlotsFolder()
	local v3

	if v2 == nil then
		v3 = false
	else
		local v4 = v2:FindFirstChild((tostring(p1)))

		v3 = v4 ~= nil

		local v5 = if v4 == nil then nil else v4:FindFirstChild("ToUpdate")
		local v6 = if v5 == nil or not v5:IsA("Model") then nil else v5:FindFirstChild("PetArea")

		if v6 ~= nil and v6:IsA("BasePart") then
			v1 = v6
		end
	end

	local v7 = t2[p1]

	if not v3 then
		destroySlot(p1)

		return
	end

	if v1 == nil then
		return
	end

	if v7 == nil then
		activateSlot(p1, v1)

		return
	end

	if v7.Area == v1 then
		return
	end

	v7.Area = v1

	for i, v in ipairs(v7.Components) do
		v:SetAssetArea(v1)
	end
end

local function syncAllSlots() --[[ syncAllSlots | Line: 143 | Upvalues: PlotCmds (copy), syncSlot (copy), t2 (copy), destroySlot (copy) ]]
	local v1 = PlotCmds.GetPlotsFolder()
	local t = {}

	if v1 ~= nil then
		for i, v in ipairs(v1:GetChildren()) do
			local v3 = tonumber(v.Name)

			if v3 ~= nil then
				t[v3] = true
				syncSlot(v3)
			end
		end
	end

	for k in pairs(t2) do
		if t[k] ~= true then
			destroySlot(k)
		end
	end
end

function t3.Start(p1, p2, p3) --[[ Start | Line: 166 | Upvalues: ActiveAssetPerformanceTestConfig (copy), v4 (ref), v3 (ref), v5 (ref), PlotCmds (copy), syncSlot (copy), syncAllSlots (copy) ]]
	assert(if ActiveAssetPerformanceTestConfig.PetsPerPlot > 0 then ActiveAssetPerformanceTestConfig.PetsPerPlot % 1 == 0 else false, "PetsPerPlot must be a positive integer")
	v4 = p2
	v3 = p3
	v5 = Instance.new("Folder")
	v5.Name = "PerformanceTestAssets"
	v5.Parent = p1
	PlotCmds.OnAnyPlotUpdated:Connect(syncSlot)
	PlotCmds.OnPlotsFolderUpdated:Connect(syncAllSlots)
	syncAllSlots()
end

return t3