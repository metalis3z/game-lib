-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local AreaEggs = require(ReplicatedStorage.Library.Types.AreaEggs)
local Assets = require(ReplicatedStorage.Directory.Assets)
local BaseUpgradeClient = require(ReplicatedStorage.Library.Client.BaseUpgradeClient)
local BaseUpgradeTransitionLifecycle = require(ReplicatedStorage.Library.Client.BaseUpgradeTransitionLifecycle)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local GuardAreaLookupUtil = require(ReplicatedStorage.Library.Util.GuardAreaLookupUtil)
local PlacedEggRenderer = require(ReplicatedStorage.Library.Client.Eggs.PlacedEggRenderer)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Player = require(ReplicatedStorage.Library.Player)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t
t.__class = "MilestoneAdapter"

local LocalPlayer = Players.LocalPlayer
local Main = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("GUI"):WaitForChild("BackpackController"):WaitForChild("Main"))
local __OBJECTS = Workspace.__OBJECTS

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local SeparationLine = Areas.SeparationLine

assert(SeparationLine:IsA("BasePart"), "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")
function t.new() --[[ new | Line: 69 | Upvalues: t (copy), Signal (copy), Trove (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Changed = Signal.new()
	v2._areaEggCarryState = nil
	v2._destroyed = false
	v2._hatchedEgg = false
	v2._hadPlacedPet = false
	v2._knownEggCount = 0
	v2._treadmillIntroFinished = false
	v2._trove = Trove.new()
	v2:_bindObservers()

	return v2
end
function t._fireChanged(p1) --[[ _fireChanged | Line: 90 ]]
	p1.Changed:Fire()
end
function t._getSaveData(p1) --[[ _getSaveData | Line: 94 | Upvalues: Save (copy) ]]
	return Save.Get()
end
function t._getEquippedTool(p1, p2) --[[ _getEquippedTool | Line: 98 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character == nil then
		return nil
	end

	for i, v in ipairs(Character:GetChildren()) do
		if v:IsA("Tool") and v:GetAttribute("ItemType") == p2 then
			return v
		end
	end

	return nil
end

local function countUnplacedEggs(p1) --[[ countUnplacedEggs | Line: 111 ]]
	if p1 == nil then
		return 0
	end

	local count = 0

	for k, v in pairs(p1.EggInventory) do
		if v.Placement == nil then
			count = count + 1
		end
	end

	return count
end

local function getPlacedEggCount(p1) --[[ getPlacedEggCount | Line: 125 ]]
	if p1 == nil then
		return 0
	end

	local count = 0

	for k, v in pairs(p1.EggInventory) do
		if v.Placement ~= nil then
			count = count + 1
		end
	end

	return count
end

local function getTotalEggCount(p1) --[[ getTotalEggCount | Line: 139 ]]
	if p1 == nil then
		return 0
	end

	local count = 0

	for k in pairs(p1.EggInventory) do
		count = count + 1
	end

	return count
end

local function getEggGrowthTime(p1) --[[ getEggGrowthTime | Line: 151 | Upvalues: Assets (copy) ]]
	local v1 = Assets.Directory[p1]

	assert(v1 ~= nil, (("Missing asset config for %*"):format(p1)))

	return v1.Egg.GrowthTime
end

function t._getLowestHatchTimeEggUid(p1) --[[ _getLowestHatchTimeEggUid | Line: 157 | Upvalues: Assets (copy) ]]
	local v1 = p1:_getSaveData()

	if v1 == nil then
		return nil
	end

	local v2 = (1 / 0)
	local v3 = nil

	for k, v in pairs(v1.EggInventory) do
		if v.Placement == nil then
			local AssetCategory = v.AssetCategory
			local v4 = Assets.Directory[AssetCategory]

			assert(if v4 == nil then false else true, (("Missing asset config for %*"):format(AssetCategory)))

			local GrowthTime = v4.Egg.GrowthTime

			if GrowthTime < v2 then
				v2 = GrowthTime
				v3 = k
			end
		end
	end

	return v3
end
function t._bindCharacterTools(p1, p2) --[[ _bindCharacterTools | Line: 179 ]]
	if p2 ~= nil then
		p1._trove:Connect(p2.ChildAdded, function(p12) --[[ Line: 184 | Upvalues: p1 (copy) ]]
			if not p12:IsA("Tool") then
				return
			end

			p1:_fireChanged()
		end)
		p1._trove:Connect(p2.ChildRemoved, function(p12) --[[ Line: 189 | Upvalues: p1 (copy) ]]
			if not p12:IsA("Tool") then
				return
			end

			p1:_fireChanged()
		end)
	end
end
function t._bindObservers(p1) --[[ _bindObservers | Line: 196 | Upvalues: LocalPlayer (copy), Save (copy), PlotCmds (copy), AssetCmds (copy), BaseUpgradeTransitionLifecycle (copy), PlacedEggRenderer (copy), EggCmds (copy) ]]
	local Backpack = LocalPlayer:WaitForChild("Backpack")

	assert(Backpack:IsA("Backpack"), "LocalPlayer.Backpack must be a Backpack")

	local v2 = p1:_getSaveData()
	local v3

	if v2 == nil then
		v3 = 0
	else
		local count = 0

		for k in pairs(v2.EggInventory) do
			count = count + 1
		end

		v3 = count
	end

	p1._knownEggCount = v3
	p1._trove:Add(Save.GetStatChangedSignal("EggInventory"):Connect(function() --[[ Line: 201 | Upvalues: p1 (copy) ]]
		local v1 = p1:_getSaveData()
		local v2

		if v1 == nil then
			v2 = 0
		else
			local count = 0

			for k in pairs(v1.EggInventory) do
				count = count + 1
			end

			v2 = count
		end

		if not (v2 < p1._knownEggCount) then
			p1._knownEggCount = v2
			p1:_fireChanged()

			return
		end

		p1._hatchedEgg = true
		p1._knownEggCount = v2
		p1:_fireChanged()
	end))
	p1._trove:Add(Save.GetStatChangedSignal("Inventory"):Connect(function() --[[ Line: 209 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Add(Save.GetStatChangedSignal("Money"):Connect(function() --[[ Line: 212 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Add(Save.GetStatChangedSignal("BaseUpgradeLevel"):Connect(function() --[[ Line: 215 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Add(PlotCmds.OnLocalPlotUpdated:Connect(function() --[[ Line: 218 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Add(AssetCmds.RuntimeSnapshotUpdated:Connect(function() --[[ Line: 221 | Upvalues: AssetCmds (ref), LocalPlayer (ref), p1 (copy) ]]
		local v1 = next(AssetCmds.GetOwnerRuntimeRecords(LocalPlayer.UserId)) ~= nil

		if v1 ~= p1._hadPlacedPet then
			p1._hadPlacedPet = v1
			p1:_fireChanged()
		end
	end))
	p1._trove:Add(BaseUpgradeTransitionLifecycle.Completed:Connect(function() --[[ Line: 229 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Add(PlacedEggRenderer.LocalEggHatchStarted:Connect(function() --[[ Line: 232 | Upvalues: p1 (copy) ]]
		p1._hatchedEgg = true
		p1:_fireChanged()
	end))
	p1._trove:Add(EggCmds.RuntimeOwnerUpdated:Connect(function(p12) --[[ Line: 236 | Upvalues: LocalPlayer (ref), p1 (copy) ]]
		if p12 ~= LocalPlayer.UserId then
			return
		end

		p1:_fireChanged()
	end))
	p1._trove:Add(EggCmds.AreaEggCarryStateChanged:Connect(function(p12) --[[ Line: 241 | Upvalues: p1 (copy) ]]
		p1._areaEggCarryState = p12
		p1:_fireChanged()
	end))
	p1._trove:Add(EggCmds.AreaEggSnapshotUpdated:Connect(function() --[[ Line: 245 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Add(EggCmds.AreaEggUpdated:Connect(function() --[[ Line: 248 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Add(EggCmds.AreaEggRemoved:Connect(function() --[[ Line: 251 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end))
	p1._trove:Connect(Backpack.ChildAdded, function() --[[ Line: 254 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end)
	p1._trove:Connect(Backpack.ChildRemoved, function() --[[ Line: 257 | Upvalues: p1 (copy) ]]
		p1:_fireChanged()
	end)
	p1._trove:Connect(LocalPlayer.CharacterAdded, function(p12) --[[ Line: 260 | Upvalues: p1 (copy) ]]
		p1:_bindCharacterTools(p12)
		p1:_fireChanged()
	end)
	p1:_bindCharacterTools(LocalPlayer.Character)
	p1._hadPlacedPet = next(AssetCmds.GetOwnerRuntimeRecords(LocalPlayer.UserId)) ~= nil
end
function t.HasStolenFirstEgg(p1) --[[ HasStolenFirstEgg | Line: 272 ]]
	local v1 = true
	local v2 = p1:_getSaveData()
	local v3

	if v2 == nil then
		v3 = 0
	else
		local count = 0

		for k, v in pairs(v2.EggInventory) do
			if v.Placement == nil then
				count = count + 1
			end
		end

		v3 = count
	end

	if not (v3 > 0) then
		local v4 = p1:_getSaveData()
		local v5

		if v4 == nil then
			v5 = 0
		else
			local count = 0

			for k, v in pairs(v4.EggInventory) do
				if v.Placement ~= nil then
					count = count + 1
				end
			end

			v5 = count
		end

		v1 = v5 > 0
	end

	return v1
end
function t.IsCarryingAreaEgg(p1) --[[ IsCarryingAreaEgg | Line: 276 ]]
	local _areaEggCarryState = p1._areaEggCarryState

	return if _areaEggCarryState == nil then false else _areaEggCarryState.IsCarrying
end
function t.HasReturnedToPen(p1) --[[ HasReturnedToPen | Line: 281 | Upvalues: Player (copy), PlotCmds (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart()
	local v2 = PlotCmds.GetPlotData()

	if v1 == nil or v2 == nil then
		return false
	end

	if PlotCmds.IsWorldPositionWithinLocalPlotBounds(v1.Position) then
		return true
	end

	local PetArea = v2.PetArea
	local v3 = PetArea.CFrame:PointToObjectSpace(v1.Position)
	local v4 = PetArea.Size * 0.5

	return (v1.Position - PetArea.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v3.X, -v4.X, v4.X), math.clamp(v3.Y, -v4.Y, v4.Y), (math.clamp(v3.Z, -v4.Z, v4.Z)))))).Magnitude <= 18
end
function t.HasEquippedEgg(p1) --[[ HasEquippedEgg | Line: 304 ]]
	return p1:_getEquippedTool("AssetEgg") ~= nil
end
function t.HasPlacedEgg(p1) --[[ HasPlacedEgg | Line: 308 ]]
	local v1 = p1:_getSaveData()
	local v2

	if v1 == nil then
		v2 = 0
	else
		local count = 0

		for k, v in pairs(v1.EggInventory) do
			if v.Placement ~= nil then
				count = count + 1
			end
		end

		v2 = count
	end

	return v2 > 0
end
function t.HasHatchableEgg(p1) --[[ HasHatchableEgg | Line: 312 | Upvalues: EggCmds (copy), LocalPlayer (copy) ]]
	for k in pairs(EggCmds.GetOwnerRuntimeRecords(LocalPlayer.UserId)) do
		if EggCmds.IsLocalEggReady(k) then
			return true
		end
	end

	return false
end
function t.HasHatchedEgg(p1) --[[ HasHatchedEgg | Line: 321 ]]
	return p1._hatchedEgg
end
function t.HasPlacedPet(p1) --[[ HasPlacedPet | Line: 325 ]]
	return p1._hadPlacedPet
end
function t.HasPetInInventory(p1) --[[ HasPetInInventory | Line: 329 ]]
	if p1:_getEquippedTool("Asset") ~= nil then
		return true
	end

	local v1 = p1:_getSaveData()

	return if v1 == nil then false else next(v1.Inventory) ~= nil
end
function t.IsLocalPlayerInGameplay(p1) --[[ IsLocalPlayerInGameplay | Line: 338 | Upvalues: Player (copy), GuardAreaLookupUtil (copy), SeparationLine (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart()

	return if v1 == nil then false else GuardAreaLookupUtil.IsInGameplaySide(SeparationLine, v1.Position)
end
function t.GetClosestAreaEggTarget(p1) --[[ GetClosestAreaEggTarget | Line: 343 | Upvalues: Player (copy), EggCmds (copy), AreaEggs (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart()
	local v2 = if v1 then v1.Position else Vector3.new(0, 0, 0)
	local v3 = (1 / 0)
	local v4 = nil

	for i, v in ipairs(EggCmds.GetAreaEggSnapshot().Records) do
		if v.State == AreaEggs.States.Slot and string.find(v.Uid, "FirstAreaEgg_", 1, true) == 1 then
			local Magnitude = (v.BottomCFrame.Position - v2).Magnitude

			if Magnitude < v3 then
				v4 = v.BottomCFrame.Position
				v3 = Magnitude
			end
		end
	end

	return v4
end
function t.GetGameplayExitTarget(p1) --[[ GetGameplayExitTarget | Line: 364 | Upvalues: SeparationLine (copy), Player (copy) ]]
	local v1 = SeparationLine.Position + Vector3.new(0, 3, 0) - SeparationLine.CFrame.LookVector.Unit * 1
	local v2 = Player.Optional.HumanoidRootPart()

	if v2 == nil then
		return v1
	end

	return Vector3.new(v1.X, v1.Y, v2.Position.Z)
end
function t.GetGameplayEntryTarget(p1) --[[ GetGameplayEntryTarget | Line: 372 | Upvalues: SeparationLine (copy) ]]
	return SeparationLine.Position + Vector3.new(0, 3, 0) + SeparationLine.CFrame.LookVector.Unit * 1
end
function t.GetPlotSpawnTarget(p1) --[[ GetPlotSpawnTarget | Line: 378 | Upvalues: PlotCmds (copy) ]]
	local v1 = PlotCmds.GetPlotData()

	if v1 == nil then
		return nil
	end

	local RespawnPointCFrame = v1.RespawnPointCFrame

	if RespawnPointCFrame then
		return RespawnPointCFrame.Position
	end

	return v1.CenterPoint.Position
end
function t.GetEggPlacementBillboardCFrame(p1) --[[ GetEggPlacementBillboardCFrame | Line: 387 | Upvalues: PlotCmds (copy), Player (copy) ]]
	local v1 = PlotCmds.GetPlotData()
	local v2 = Player.Optional.HumanoidRootPart()

	if v1 == nil or (v2 == nil or v1.RespawnPointCFrame == nil) then
		return nil
	end

	local PetArea = v1.PetArea
	local RespawnPointCFrame = v1.RespawnPointCFrame
	local v3 = PetArea.CFrame:PointToObjectSpace(v2.Position)
	local v4 = PetArea.Size * 0.5
	local v10 = PetArea.CFrame:PointToWorldSpace((Vector3.new(math.clamp(v3.X, -v4.X, v4.X), v4.Y, (math.clamp(v3.Z, -v4.Z, v4.Z)))))
	local v11 = RespawnPointCFrame + RespawnPointCFrame.LookVector * 13

	return CFrame.new(v11.Position.X, v10.Y, v11.Position.Z)
end
function t.GetNearestHatchableEggTarget(p1) --[[ GetNearestHatchableEggTarget | Line: 408 | Upvalues: Player (copy), EggCmds (copy), LocalPlayer (copy), PlotCmds (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart()
	local v2 = if v1 then v1.Position else Vector3.new(0, 0, 0)
	local v3 = (1 / 0)
	local v4 = nil

	for k, v in pairs(EggCmds.GetOwnerRuntimeRecords(LocalPlayer.UserId)) do
		if v.Placement ~= nil and EggCmds.IsLocalEggReady(k) then
			local v5 = PlotCmds.GetPlotData()

			if v5 ~= nil then
				local Position = (v5.CenterPoint.CFrame * v.Placement.LocalCFrame).Position
				local Magnitude = (Position - v2).Magnitude

				if Magnitude < v3 then
					v3 = Magnitude
					v4 = Position
				end
			end
		end
	end

	return v4
end
function t.GetEggHotbarTarget(p1) --[[ GetEggHotbarTarget | Line: 432 | Upvalues: Main (copy) ]]
	local v1 = p1:_getLowestHatchTimeEggUid()

	if v1 then
		return Main:GetEggSlotFrame(v1)
	end

	return nil
end
function t.ForceBestEggIntoHotbar(p1) --[[ ForceBestEggIntoHotbar | Line: 437 | Upvalues: Main (copy) ]]
	local v1 = p1:_getLowestHatchTimeEggUid()

	if v1 then
		return Main:ForceEggIntoTutorialHotbar(v1)
	end

	return nil
end
function t.HasPetToolEquipped(p1) --[[ HasPetToolEquipped | Line: 442 ]]
	return p1:_getEquippedTool("Asset") ~= nil
end
function t.CanAffordFirstBaseExpansion(p1) --[[ CanAffordFirstBaseExpansion | Line: 446 | Upvalues: BaseUpgradeClient (copy) ]]
	local v1 = p1:_getSaveData()

	return if v1 == nil or v1.BaseUpgradeLevel ~= 0 then false else BaseUpgradeClient.CanAffordNext(v1)
end
function t.HasFinishedFirstBaseExpansion(p1) --[[ HasFinishedFirstBaseExpansion | Line: 451 | Upvalues: BaseUpgradeTransitionLifecycle (copy) ]]
	local v1 = p1:_getSaveData()

	return if v1 == nil or not (v1.BaseUpgradeLevel > 0) then false else not BaseUpgradeTransitionLifecycle.IsPlaying()
end
function t.GetPlotUpgradeSignTarget(p1) --[[ GetPlotUpgradeSignTarget | Line: 456 | Upvalues: PlotCmds (copy) ]]
	local v1 = PlotCmds.GetPlotData()

	if v1 == nil then
		return nil
	end

	local PlotUpgrade = v1.PlotFolder:FindFirstChild("PlotUpgrade")

	if PlotUpgrade == nil or not PlotUpgrade:IsA("Model") then
		return nil
	end

	local Sign = PlotUpgrade:FindFirstChild("Sign")

	if Sign == nil or not Sign:IsA("BasePart") then
		return nil
	end

	return Sign
end
function t.HasFinishedTreadmillIntro(p1) --[[ HasFinishedTreadmillIntro | Line: 470 ]]
	return p1._treadmillIntroFinished
end
function t.MarkTreadmillIntroFinished(p1) --[[ MarkTreadmillIntroFinished | Line: 474 ]]
	if not p1._treadmillIntroFinished then
		p1._treadmillIntroFinished = true
		p1:_fireChanged()
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 482 ]]
	p1._destroyed = true
	p1._trove:Destroy()
	p1.Changed:Destroy()
end

return t