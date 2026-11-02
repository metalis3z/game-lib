-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Assets = require(ReplicatedStorage.Data.Assets)
local BaseUpgrade = require(ReplicatedStorage.Client.BaseUpgrade)
local BaseUpgradeTransitionLifecycle = require(ReplicatedStorage.Client.BaseUpgradeTransitionLifecycle)
local EggState = require(ReplicatedStorage.Client.EggState)
local Signal = require(ReplicatedStorage.Packages.Signal)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {}

v1.__index = v1
v1.__class = "MilestoneAdapter"

local LocalPlayer = Players.LocalPlayer
local BackpackController = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("GUI"):WaitForChild("BackpackController")
local v2 = require(BackpackController:WaitForChild("Main"))
local __OBJECTS = Workspace.__OBJECTS
local Folder = __OBJECTS:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS must be a Folder")
local Areas = __OBJECTS.Areas
local Folder_2 = Areas:IsA("Folder")
assert(Folder_2, "Workspace.__OBJECTS.Areas must be a Folder")
local SeparationLine = Areas.SeparationLine
local BasePart = SeparationLine:IsA("BasePart")
assert(BasePart, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

function v1.new() -- line 39 | captures: Signal, Trove, v1
    local v3 = {}
    local v4 = setmetatable(v3, v1)
    v4.Changed = Signal.new()
    v4._areaEggCarryState = nil
    v4._destroyed = false
    v4._hatchedEgg = false
    v4._hadPlacedPet = false
    v4._knownEggCount = 0
    v4._treadmillIntroFinished = false
    v4._trove = Trove.new()
    v4:_bindObservers()
    return v4
end

local function _fireChanged(v5) -- line 52
    v5.Changed:Fire()
end

v1._fireChanged = _fireChanged

function v1._getSaveData(v6) -- line 55 | captures: Save
    return Save.Get()
end

function v1._getEquippedTool(v7, v8) -- line 58 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    if Character ~= nil then
        for v9, v10 in ipairs(Character:GetChildren()) do
            if v10:IsA("Tool") and v10:GetAttribute("ItemType") == v8 then
                return v10
            end
        end
    end
    return nil
end

local function countUnplacedEggs(v11) -- line 70
    if v11 == nil then
        return 0
    end
    local v12 = 0
    for v13, v14 in pairs(v11.EggInventory) do
        if v14.Placement == nil then
            v12 += 1
        end
    end
    return v12
end

local function getPlacedEggCount(v15) -- line 82
    if v15 == nil then
        return 0
    end
    local v16 = 0
    for v17, v18 in pairs(v15.EggInventory) do
        if v18.Placement ~= nil then
            v16 += 1
        end
    end
    return v16
end

local function getTotalEggCount(v19) -- line 94
    if v19 == nil then
        return 0
    end
    local v20 = 0
    for v21 in pairs(v19.EggInventory) do
        v20 += 1
    end
    return v20
end

local function getEggGrowthTime(v22) -- line 104 | captures: Assets
    local v23 = Assets.Directory[v22]
    local v24 = v23 ~= nil
    local v25 = ("Missing asset config for %*"):format(v22)
    assert(v24, v25)
    return v23.Egg.GrowthTime
end

function v1._getLowestHatchTimeEggUid(v26) -- line 110 | captures: Assets
    local v27 = v26:_getSaveData()
    if v27 == nil then
        return nil
    end
    local v28
    local v29 = (1/0)
    for v30, v31 in pairs(v27.EggInventory) do
        if v31.Placement == nil then
            local AssetCategory = v31.AssetCategory
            local v32 = Assets.Directory[AssetCategory]
            local v33 = v32 ~= nil
            local v34 = ("Missing asset config for %*"):format(AssetCategory)
            assert(v33, v34)
            local GrowthTime = v32.Egg.GrowthTime
            if GrowthTime < v29 then
                v28 = v30
                v29 = GrowthTime
            end
        end
    end
    return v28
end

local function _bindCharacterTools(v35, v36) -- line 133
    if v36 == nil then
        return
    end
    v35._trove:Connect(v36.ChildAdded, function(v37) -- line 137 | captures: v35
        if v37:IsA("Tool") then
            v35:_fireChanged()
        end
    end)
    v35._trove:Connect(v36.ChildRemoved, function(v38) -- line 142 | captures: v35
        if v38:IsA("Tool") then
            v35:_fireChanged()
        end
    end)
end

v1._bindCharacterTools = _bindCharacterTools

function v1._bindObservers(v39) -- line 148 | captures: AssetRoster, BaseUpgradeTransitionLifecycle, EggState, PlacedEggRenderer, PlotState, Save, LocalPlayer
    local Backpack = LocalPlayer:WaitForChild("Backpack")
    local Backpack_2 = Backpack:IsA("Backpack")
    assert(Backpack_2, "LocalPlayer.Backpack must be a Backpack")
    local v40 = v39:_getSaveData()
    local v41 = 0
    if v40 ~= nil then
        for v42 in pairs(v40.EggInventory) do
            v41 += 1
        end
    end
    v39._knownEggCount = v41
    v39._trove:Add(Save.FieldSignal("EggInventory"):Connect(function() -- line 164 | captures: v39
        local v43 = v39:_getSaveData()
        local v44 = 0
        if v43 ~= nil then
            for v45 in pairs(v43.EggInventory) do
                v44 += 1
            end
        end
        if v44 < v39._knownEggCount then
            v39._hatchedEgg = true
        end
        v39._knownEggCount = v44
        v39:_fireChanged()
    end))
    v39._trove:Add(Save.FieldSignal("Inventory"):Connect(function() -- line 182 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Add(Save.FieldSignal("Money"):Connect(function() -- line 185 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Add(Save.FieldSignal("BaseUpgradeLevel"):Connect(function() -- line 188 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Add(PlotState.LocalPlotChanged:Connect(function() -- line 191 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Add(AssetRoster.SnapshotRefreshed:Connect(function() -- line 194 | captures: v39, AssetRoster, LocalPlayer
        local v46 = next(AssetRoster.ReadOwnerPen(LocalPlayer.UserId)) ~= nil
        if v46 ~= v39._hadPlacedPet then
            v39._hadPlacedPet = v46
            v39:_fireChanged()
        end
    end))
    v39._trove:Add(BaseUpgradeTransitionLifecycle.Completed:Connect(function() -- line 202 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Add(PlacedEggRenderer.LocalEggHatchStarted:Connect(function() -- line 205 | captures: v39
        v39._hatchedEgg = true
        v39:_fireChanged()
    end))
    v39._trove:Add(EggState.OwnerRefreshed:Connect(function(v47) -- line 209 | captures: v39, LocalPlayer
        if v47 == LocalPlayer.UserId then
            v39:_fireChanged()
        end
    end))
    v39._trove:Add(EggState.CarryChanged:Connect(function(v48) -- line 214 | captures: v39
        v39._areaEggCarryState = v48
        v39:_fireChanged()
    end))
    v39._trove:Add(EggState.FieldRefreshed:Connect(function() -- line 218 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Add(EggState.FieldShifted:Connect(function() -- line 221 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Add(EggState.FieldGone:Connect(function() -- line 224 | captures: v39
        v39:_fireChanged()
    end))
    v39._trove:Connect(Backpack.ChildAdded, function() -- line 227 | captures: v39
        v39:_fireChanged()
    end)
    v39._trove:Connect(Backpack.ChildRemoved, function() -- line 230 | captures: v39
        v39:_fireChanged()
    end)
    v39._trove:Connect(LocalPlayer.CharacterAdded, function(v49) -- line 233 | captures: v39
        v39:_bindCharacterTools(v49)
        v39:_fireChanged()
    end)
    v39:_bindCharacterTools(LocalPlayer.Character)
    v39._hadPlacedPet = next(AssetRoster.ReadOwnerPen(LocalPlayer.UserId)) ~= nil
end

local function HasStolenFirstEgg(v50) -- line 241
    local v51 = v50:_getSaveData()
    local v52 = 0
    if v51 ~= nil then
        for v53, v54 in pairs(v51.EggInventory) do
            if v54.Placement == nil then
                v52 += 1
            end
        end
    end
    if v52 <= 0 then
        local v55 = v50:_getSaveData()
        local v56 = 0
        if v55 ~= nil then
            for v57, v58 in pairs(v55.EggInventory) do
                if v58.Placement ~= nil then
                    v56 += 1
                end
            end
        end
        return v56 > 0
    end
    return true
end

v1.HasStolenFirstEgg = HasStolenFirstEgg

local function IsCarryingAreaEgg(v59) -- line 273
    local _areaEggCarryState = v59._areaEggCarryState
    if _areaEggCarryState == nil then
        return false
    end
    return _areaEggCarryState.IsCarrying
end

v1.IsCarryingAreaEgg = IsCarryingAreaEgg

function v1.HasReturnedToPen(v60) -- line 279 | captures: Player, PlotState
    local v61 = Player.Optional.HumanoidRootPart()
    local v62 = PlotState.ResolvePlot()
    if v61 == nil or v62 == nil then
        return false
    end
    if PlotState.ContainsLocalPoint(v61.Position) then
        return true
    end
    local PetArea = v62.PetArea
    local v63 = PetArea.CFrame:PointToObjectSpace(v61.Position)
    local v64 = PetArea.Size * 0.5
    local X = v63.X
    local v65 = -v64.X
    local X_2 = v64.X
    local v66 = math.clamp(X, v65, X_2)
    local Y = v63.Y
    local v67 = -v64.Y
    local Y_2 = v64.Y
    local v68 = math.clamp(Y, v67, Y_2)
    local v69 = -v64.Z
    local Z = v63.Z
    local Z_2 = v64.Z
    local v70 = math.clamp(Z, v69, Z_2)
    local v71 = Vector3.new(v66, v68, v70)
    return (v61.Position - PetArea.CFrame:PointToWorldSpace(v71)).Magnitude <= 18
end

local function HasEquippedEgg(v72) -- line 298
    return v72:_getEquippedTool("AssetEgg") ~= nil
end

v1.HasEquippedEgg = HasEquippedEgg

local function HasPlacedEgg(v73) -- line 302
    local v74 = v73:_getSaveData()
    local v75 = 0
    if v74 ~= nil then
        for v76, v77 in pairs(v74.EggInventory) do
            if v77.Placement ~= nil then
                v75 += 1
            end
        end
    end
    return v75 > 0
end

v1.HasPlacedEgg = HasPlacedEgg

function v1.HasHatchableEgg(v78) -- line 319 | captures: EggState, LocalPlayer
    for v79 in pairs(EggState.ReadOwnerEggs(LocalPlayer.UserId)) do
        if EggState.IsReadyToHatch(v79) then
            return true
        end
    end
    return false
end

local function HasHatchedEgg(v80) -- line 327
    return v80._hatchedEgg
end

v1.HasHatchedEgg = HasHatchedEgg

local function HasPlacedPet(v81) -- line 330
    return v81._hadPlacedPet
end

v1.HasPlacedPet = HasPlacedPet

local function HasPetInInventory(v82) -- line 333
    if v82:_getEquippedTool("Asset") == nil then
        local v83 = v82:_getSaveData()
        if v83 == nil then
            return false
        end
        return next(v83.Inventory) ~= nil
    end
    return true
end

v1.HasPetInInventory = HasPetInInventory

function v1.IsLocalPlayerInGameplay(v84) -- line 341 | captures: GuardAreaGeometry, Player, SeparationLine
    local v85 = Player.Optional.HumanoidRootPart()
    if v85 == nil then
        return false
    end
    return (GuardAreaGeometry.IsPastLine(SeparationLine, v85.Position))
end

function v1.GetClosestAreaEggTarget(v86) -- line 346 | captures: AreaEggs, EggState, Player
    local v87 = Player.Optional.HumanoidRootPart()
    local v88
    if v87 then
        v88 = v87.Position
    else
        v88 = Vector3.new(0, 0, 0)
    end
    local Position
    local v89 = (1/0)
    for v90, v91 in ipairs(EggState.ReadFieldEggs().Records) do
        if v91.State == AreaEggs.States.Slot and string.find(v91.Uid, "FirstAreaEgg_", 1, true) == 1 then
            local Magnitude = (v91.BottomCFrame.Position - v88).Magnitude
            if Magnitude < v89 then
                Position = v91.BottomCFrame.Position
                v89 = Magnitude
            end
        end
    end
    return Position
end

function v1.GetGameplayExitTarget(v92) -- line 367 | captures: Player, SeparationLine
    local v93 = SeparationLine.Position + Vector3.new(0, 3, 0) - SeparationLine.CFrame.LookVector.Unit * 1
    local v94 = Player.Optional.HumanoidRootPart()
    if v94 == nil then
        return v93
    end
    local X = v93.X
    local Y = v93.Y
    local Z = v94.Position.Z
    return (Vector3.new(X, Y, Z))
end

function v1.GetGameplayEntryTarget(v95) -- line 376 | captures: SeparationLine
    return SeparationLine.Position + Vector3.new(0, 3, 0) + SeparationLine.CFrame.LookVector.Unit * 1
end

function v1.GetPlotSpawnTarget(v96) -- line 380 | captures: PlotState
    local v97 = PlotState.ResolvePlot()
    if v97 == nil then
        return nil
    end
    local RespawnPointCFrame = v97.RespawnPointCFrame
    if RespawnPointCFrame then
        return RespawnPointCFrame.Position
    end
    return v97.CenterPoint.Position
end

function v1.GetEggPlacementBillboardCFrame(v98) -- line 391 | captures: Player, PlotState
    local v99 = PlotState.ResolvePlot()
    local v100 = Player.Optional.HumanoidRootPart()
    if v99 ~= nil and v100 ~= nil and v99.RespawnPointCFrame ~= nil then
        local PetArea = v99.PetArea
        local RespawnPointCFrame = v99.RespawnPointCFrame
        local v101 = PetArea.CFrame:PointToObjectSpace(v100.Position)
        local v102 = PetArea.Size * 0.5
        local X = v101.X
        local v103 = -v102.X
        local X_2 = v102.X
        local v104 = math.clamp(X, v103, X_2)
        local v105 = -v102.Z
        local Y = v102.Y
        local Z = v101.Z
        local Z_2 = v102.Z
        local v106 = math.clamp(Z, v105, Z_2)
        local v107 = Vector3.new(v104, Y, v106)
        local v108 = PetArea.CFrame:PointToWorldSpace(v107)
        local v109 = RespawnPointCFrame + RespawnPointCFrame.LookVector * 13
        return CFrame.new(v109.Position.X, v108.Y, v109.Position.Z)
    end
    return nil
end

function v1.GetNearestHatchableEggTarget(v110) -- line 409 | captures: EggState, Player, PlotState, LocalPlayer
    local v111 = Player.Optional.HumanoidRootPart()
    local v112
    if v111 then
        v112 = v111.Position
    else
        v112 = Vector3.new(0, 0, 0)
    end
    local Position
    local v113 = (1/0)
    for v114, v115 in pairs(EggState.ReadOwnerEggs(LocalPlayer.UserId)) do
        if v115.Placement ~= nil and EggState.IsReadyToHatch(v114) then
            local v116 = PlotState.ResolvePlot()
            if v116 ~= nil then
                local Position_2 = (v116.CenterPoint.CFrame * v115.Placement.LocalCFrame).Position
                local Magnitude = (Position_2 - v112).Magnitude
                if Magnitude < v113 then
                    Position = Position_2
                    v113 = Magnitude
                end
            end
        end
    end
    return Position
end

function v1.GetEggHotbarTarget(v117) -- line 434 | captures: v2
    local v118 = v117:_getLowestHatchTimeEggUid()
    if v118 then
        return (v2:GetEggSlotFrame(v118))
    end
    return nil
end

function v1.ForceBestEggIntoHotbar(v119) -- line 441 | captures: v2
    local v120 = v119:_getLowestHatchTimeEggUid()
    if v120 then
        return (v2:ForceEggIntoTutorialHotbar(v120))
    end
    return nil
end

local function HasPetToolEquipped(v121) -- line 448
    return v121:_getEquippedTool("Asset") ~= nil
end

v1.HasPetToolEquipped = HasPetToolEquipped

function v1.CanAffordFirstBaseExpansion(v122) -- line 452 | captures: BaseUpgrade
    local v123 = v122:_getSaveData()
    if v123 ~= nil and v123.BaseUpgradeLevel == 0 then
        return (BaseUpgrade.IsNextTierAffordable(v123))
    end
    return false
end

function v1.HasFinishedFirstBaseExpansion(v124) -- line 457 | captures: BaseUpgradeTransitionLifecycle
    local v125 = v124:_getSaveData()
    if v125 ~= nil and v125.BaseUpgradeLevel > 0 then
        return not BaseUpgradeTransitionLifecycle.IsPlaying()
    end
    return false
end

function v1.GetPlotUpgradeSignTarget(v126) -- line 462 | captures: PlotState
    local v127 = PlotState.ResolvePlot()
    if v127 ~= nil then
        local PlotUpgrade = v127.PlotFolder:FindFirstChild("PlotUpgrade")
        if PlotUpgrade ~= nil and PlotUpgrade:IsA("Model") then
            local Sign = PlotUpgrade:FindFirstChild("Sign")
            if Sign ~= nil and Sign:IsA("BasePart") then
                return Sign
            end
        end
    end
    return nil
end

local function HasFinishedTreadmillIntro(v128) -- line 480
    return v128._treadmillIntroFinished
end

v1.HasFinishedTreadmillIntro = HasFinishedTreadmillIntro

local function MarkTreadmillIntroFinished(v129) -- line 483
    if not v129._treadmillIntroFinished then
        v129._treadmillIntroFinished = true
        v129:_fireChanged()
    end
end

v1.MarkTreadmillIntroFinished = MarkTreadmillIntroFinished

local function Destroy(v130) -- line 490
    v130._destroyed = true
    v130._trove:Destroy()
    v130.Changed:Destroy()
end

v1.Destroy = Destroy
return v1
