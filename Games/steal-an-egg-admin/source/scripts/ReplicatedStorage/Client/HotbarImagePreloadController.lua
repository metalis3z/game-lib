-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AreaEggs)
local Areas = require(ReplicatedStorage.Data.Areas)
local AssetIconShape = require(ReplicatedStorage.Client.UI.AssetIconShape)
local Assets = require(ReplicatedStorage.Data.Assets)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggState = require(ReplicatedStorage.Client.EggState)
require(ReplicatedStorage.Shared.Types.Eggs)
local GuardChasePolicy = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardChasePolicy)
local GuardEscape = require(ReplicatedStorage.Shared.Utils.GuardEscape)
local GuardEscapePrediction = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction)
local Guards = require(ReplicatedStorage.Data.Guards)
local HotbarImagePreloadPolicy = require(ReplicatedStorage.Client.HotbarImagePreloadPolicy)
local ImagePreloader = require(ReplicatedStorage.Client.ImagePreloader)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Player = require(ReplicatedStorage.Shared.Player)
local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = Log.new()
local Areas_2 = Workspace:WaitForChild("__OBJECTS"):WaitForChild("Areas")
local GuardAreas = Areas_2:WaitForChild("GuardAreas")
local SeparationLine = Areas_2:WaitForChild("SeparationLine")
local Folder = GuardAreas:IsA("Folder")
assert(Folder, "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")
local BasePart = SeparationLine:IsA("BasePart")
assert(BasePart, "Workspace.__OBJECTS.Areas.SeparationLine must be a BasePart")

local function showDebugNotification(v2) -- line 37 | captures: Message
    if game.GameId == 10650210095 then
        Message.Bottom({
            Time = 1.5,
            Message = ("[DEBUG]: %*"):format(v2),
            Color = Color3.fromRGB(100, 200, 255)
        }, { PreventDuplicateText = true })
    end
end

local function getAreaModel(v3) -- line 43 | captures: GuardAreas
    local v4 = GuardAreas:FindFirstChild(v3)
    if v4 ~= nil and v4:IsA("Model") then
        return v4
    end
    return nil
end

local function getGuardRoot(v5) -- line 53
    local Guard = v5:FindFirstChild("Guard")
    if Guard ~= nil and Guard:IsA("Model") then
        local HumanoidRootPart = Guard:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
            return HumanoidRootPart
        end
    end
    return nil
end

local function resolveRequiredSpeedPower(v6) -- line 67 | captures: Areas, GuardChasePolicy, GuardEscape, GuardEscapePrediction, Guards, v1, SeparationLine
    local Guard = v6:FindFirstChild("Guard")
    local HumanoidRootPart
    if not (Guard ~= nil and Guard:IsA("Model")) then
    else
        HumanoidRootPart = Guard:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart ~= nil and not HumanoidRootPart:IsA("BasePart") then
            HumanoidRootPart = nil
        end
    end
    if HumanoidRootPart ~= nil then
        local HumanoidRootPart_2 = HumanoidRootPart
        local v7, v8 = pcall(function() -- line 73 | captures: v6, HumanoidRootPart_2, Areas, GuardChasePolicy, GuardEscape, GuardEscapePrediction, Guards, SeparationLine
            local v9 = Guards.Directory[Areas.Directory[v6.Name].GuardId]
            local Bounds = v6:FindFirstChild("Bounds")
            local ClosestExitPoint = v6:FindFirstChild("ClosestExitPoint")
            local v10
            if Bounds == nil then
                v10 = false
            else
                v10 = Bounds:IsA("BasePart")
            end
            local v11 = ("%*.Bounds must be a BasePart"):format((v6:GetFullName()))
            assert(v10, v11)
            local v12
            if ClosestExitPoint == nil then
                v12 = false
            else
                v12 = ClosestExitPoint:IsA("BasePart")
            end
            local v13 = ("%*.ClosestExitPoint must be a BasePart"):format((v6:GetFullName()))
            assert(v12, v13)
            local v14 = -SeparationLine.CFrame.LookVector
            return GuardEscape.RequiredSpeedPower({
                BaseGuardWalkSpeed = v9.WalkSpeed,
                ExitDirection = v14,
                ExitDistance = GuardEscapePrediction.ResolveExitDistance(Bounds.CFrame, Bounds.Size, ClosestExitPoint.Position, v14),
                FlatRadius = v9.FlatRadius,
                GuardStartPosition = HumanoidRootPart_2.Position,
                HitDistance = GuardChasePolicy.ResolveHitDistance(v9.HitDistance),
                PlayerStartPosition = ClosestExitPoint.Position
            })
        end)
        if v7 then
            return v8
        end
        local Name = v6.Name
        v1:AtWarning():Log((("Unable to resolve guard escape requirement for %*: %*"):format(Name, v8)))
    end
    return nil
end

local function cacheRequiredSpeedPower(v15, v16) -- line 99 | captures: resolveRequiredSpeedPower
    local v17 = resolveRequiredSpeedPower(v16)
    if v17 ~= nil then
        v15.RequiredSpeedPowerByAreaId[v16.Name] = v17
    end
end

local function getRequiredSpeedPower(v18, v19) -- line 105 | captures: GuardAreas, resolveRequiredSpeedPower
    local v20 = v18.RequiredSpeedPowerByAreaId[v19]
    if v20 == nil then
        local v21 = GuardAreas:FindFirstChild(v19)
        if v21 ~= nil and not v21:IsA("Model") then
            v21 = nil
        end
        if v21 == nil then
            return nil
        end
        local v22 = resolveRequiredSpeedPower(v21)
        if v22 ~= nil then
            v18.RequiredSpeedPowerByAreaId[v21.Name] = v22
        end
        return v18.RequiredSpeedPowerByAreaId[v19]
    end
    return v20
end

local function getDistanceToClaimLine() -- line 128 | captures: HotbarImagePreloadPolicy, Player, LocalPlayer, SeparationLine
    local v23 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if not (v23 ~= nil and v23:IsA("BasePart")) then
        return nil
    end
    return HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(SeparationLine, v23.Position)
end

local function requestEggIcon(v24) -- line 135 | captures: Assets, ImagePreloader, showDebugNotification
    local v25 = Assets.Directory[v24]
    if ImagePreloader.Request(v25.Egg.Icon) then
        showDebugNotification((("Preloading image for %* egg"):format(v25.DisplayName)))
    end
end

local function requestPetIcons(v26) -- line 141 | captures: AssetIconShape, Assets, EggRecords, ImagePreloader, showDebugNotification
    local v27 = EggRecords.ToAssetItemData(v26)
    local v28 = AssetIconShape.ResolveImages(v27)
    local v29 = { v28.Icon }
    if v28.RainbowOverlay ~= nil then
        v29[#v29 + 1] = v28.RainbowOverlay
    end
    if ImagePreloader.RequestAll(v29) > 0 then
        local v30 = Assets.Directory[v26.AssetCategory]
        showDebugNotification((("Preloading image for %* pet"):format(v30.DisplayName)))
    end
end

local function scanReadyEggs(v31) -- line 154 | captures: EggState, LocalPlayer, requestPetIcons
    if v31.Destroyed then
        return
    end
    local v32 = EggState.ReadOwnerEggs(LocalPlayer.UserId)
    for v33, v34 in v32 do
        if not v31.ReadyPreloadedByUid[v33] and v34.Placement ~= nil and EggState.IsReadyToHatch(v33) then
            v31.ReadyPreloadedByUid[v33] = true
            requestPetIcons(v34)
        end
    end
    for v35 in v31.ReadyPreloadedByUid do
        if v32[v35] == nil then
            v31.ReadyPreloadedByUid[v35] = nil
        end
    end
end

local function handleCarryState(v36, v37) -- line 178 | captures: Assets, HotbarImagePreloadPolicy, ImagePreloader, Player, SpeedPowerProjection, Timer, LocalPlayer, GuardAreas, SeparationLine, showDebugNotification, resolveRequiredSpeedPower
    v36.CarryGeneration += 1
    v36.CarryTrove:Clean()
    local AssetCategory, CarryGeneration, AssetCategory_2, v38, v39
    if v37.IsCarrying then
        if v37.AreaId == nil or v37.AssetCategory == nil then
            v39 = true
        else
            CarryGeneration = v36.CarryGeneration
            local AreaId = v37.AreaId
            AssetCategory_2 = v37.AssetCategory
            AssetCategory = AssetCategory_2
            v38 = v36.RequiredSpeedPowerByAreaId[AreaId]
            if v38 == nil then
                local v40 = GuardAreas:FindFirstChild(AreaId)
                if v40 == nil then
                    v38 = nil
                elseif v40:IsA("Model") then
                    if v40 == nil then
                        v38 = nil
                    else
                        local v41 = resolveRequiredSpeedPower(v40)
                        if v41 ~= nil then
                            v36.RequiredSpeedPowerByAreaId[v40.Name] = v41
                        end
                        v38 = v36.RequiredSpeedPowerByAreaId[AreaId]
                    end
                else
                    v38 = nil
                end
            end
            v39 = false
        end
    else
        v39 = true
    end
    if v39 then
        return
    end
    local v42 = SpeedPowerProjection.ReadProjected()
    local v43 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v44
    if v43 == nil then
    elseif v43:IsA("BasePart") then
        v44 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(SeparationLine, v43.Position)
    end
    if HotbarImagePreloadPolicy.ShouldPreloadCarriedEgg(v42, v38, v44) then
        local v45 = Assets.Directory[AssetCategory_2]
        if ImagePreloader.Request(v45.Egg.Icon) then
            showDebugNotification((("Preloading image for %* egg"):format(v45.DisplayName)))
        end
    else
        local CarryTrove = v36.CarryTrove
        local Simple = Timer.Simple
        local CarryGeneration_2 = CarryGeneration
        CarryTrove:Add(Simple(0.1, function() -- line 218 | captures: AssetCategory, v36, CarryGeneration_2, Assets, HotbarImagePreloadPolicy, ImagePreloader, Player, LocalPlayer, SeparationLine, showDebugNotification
            local v46, v47
            if v36.Destroyed then
                v47 = true
            elseif v36.CarryGeneration == CarryGeneration_2 then
                local v48 = Player.Optional.HumanoidRootPart(LocalPlayer)
                if v48 == nil then
                elseif v48:IsA("BasePart") then
                    v46 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(SeparationLine, v48.Position)
                end
                v47 = false
            else
                v47 = true
            end
            if v47 then
                return
            end
            local v49
            if v46 == nil then
                v49 = true
            elseif HotbarImagePreloadPolicy.IsWithinClaimPreloadDistance(v46) then
                local v50 = Assets.Directory[AssetCategory]
                if ImagePreloader.Request(v50.Egg.Icon) then
                    showDebugNotification((("Preloading image for %* egg"):format(v50.DisplayName)))
                end
                v49 = false
            else
                v49 = true
            end
            if v49 then
                return
            end
            v36.CarryTrove:Clean()
        end))
    end
end

local freeze = table.freeze
local v51 = {}

function v51.Start(v52) -- line 248 | captures: EggState, Timer, LocalPlayer, GuardAreas, resolveRequiredSpeedPower, scanReadyEggs, handleCarryState
    local v53 = not v52.Started
    assert(v53, "HotbarImagePreloadController already started")
    local v54 = not v52.Destroyed
    assert(v54, "HotbarImagePreloadController is destroyed")
    v52.Started = true
    for v55, v56 in GuardAreas:GetChildren() do
        if v56:IsA("Model") then
            local v57 = resolveRequiredSpeedPower(v56)
            if v57 ~= nil then
                v52.RequiredSpeedPowerByAreaId[v56.Name] = v57
            end
        end
    end
    v52.Trove:Connect(GuardAreas.ChildAdded, function(v58) -- line 262 | captures: v52, resolveRequiredSpeedPower
        if v58:IsA("Model") then
            local v59 = resolveRequiredSpeedPower(v58)
            if v59 ~= nil then
                v52.RequiredSpeedPowerByAreaId[v58.Name] = v59
            end
        end
    end)
    v52.Trove:Connect(GuardAreas.ChildRemoved, function(v60) -- line 270 | captures: v52
        v52.RequiredSpeedPowerByAreaId[v60.Name] = nil
    end)
    v52.Trove:Add(EggState.CarryChanged:Connect(function(v61) -- line 273 | captures: v52, handleCarryState
        handleCarryState(v52, v61)
    end))
    v52.Trove:Add(EggState.OwnerRefreshed:Connect(function(v62) -- line 276 | captures: v52, LocalPlayer, scanReadyEggs
        if v62 == LocalPlayer.UserId then
            scanReadyEggs(v52)
        end
    end))
    v52.Trove:Add(Timer.Simple(0.25, function() -- line 281 | captures: v52, scanReadyEggs
        scanReadyEggs(v52)
    end))
    scanReadyEggs(v52)
end

function v51.Destroy(v63) -- line 286
    if v63.Destroyed then
        return
    end
    v63.Destroyed = true
    v63.CarryGeneration += 1
    v63.Trove:Destroy()
end

local v64 = freeze(v51)
local v65 = table.freeze({ __index = v64 })
local freeze_2 = table.freeze
local v66 = {}

function v66.new() -- line 297 | captures: Trove, v65
    local v67 = Trove.new()
    local v68 = {
        CarryGeneration = 0,
        Destroyed = false,
        Started = false,
        CarryTrove = v67:Extend(),
        ReadyPreloadedByUid = {},
        RequiredSpeedPowerByAreaId = {},
        Trove = v67
    }
    return (setmetatable(v68, v65))
end

function v66.IsA(v69) -- line 310 | captures: v65
    if type(v69) == "table" then
        return getmetatable(v69) == v65
    end
    return false
end

function v66.Assert(v70) -- line 318 | captures: v65
    local v71 = if type(v70) == "table" then getmetatable(v70) == v65 else false
    assert(v71, "Expected HotbarImagePreloadController")
    return v70
end

return freeze_2(v66)
