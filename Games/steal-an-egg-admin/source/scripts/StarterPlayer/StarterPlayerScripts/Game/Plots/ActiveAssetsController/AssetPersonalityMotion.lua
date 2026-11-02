-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetWanderArea = require(script.Parent.AssetWanderArea)
require(ReplicatedStorage.Data.Assets)
local Player = require(ReplicatedStorage.Shared.Player)
local v1 = {}

local function isolatedPointFromOwner(v2, v3, v4) -- line 11 | captures: AssetWanderArea
    local v5, v6 = AssetWanderArea.HalfExtents(v2)
    local v7 = v2.CFrame:PointToObjectSpace(v4)
    local v8
    if v7.X < 0 then
        v8 = v3:NextNumber(0, v5)
    else
        v8 = v3:NextNumber(-v5, 0)
    end
    local v9
    if v7.Z < 0 then
        v9 = v3:NextNumber(0, v6)
    else
        v9 = v3:NextNumber(-v6, 0)
    end
    return (v2.CFrame * CFrame.new(v8, 0, v9)).Position
end

local function StepIdle(v10, v11, v12, v13, v14) -- line 27
    local v15 = v11 - v10
    local v16 = math.max(v15, 0)
    local v17 = v12 + v10
    local v18
    if v14 == nil then
        v18 = v13
    elseif v16 > 0 then
        local v19 = v17 / 0.2
        local v20 = math.clamp(v19, 0, 1)
        local v21 = v16 / 0.2
        local v22 = math.clamp(v21, 0, 1)
        local v23 = v14.Amplitude * math.min(v20, v22)
        local v24 = v17 * v14.CyclesPerSecond * 3.141592653589793 * 2
        local v25 = math.sin(v24) * v23
        local v26 = v24 * 1.37 + 1.0471975511965976
        local v27 = math.sin(v26) * v23
        v18 = v13 * CFrame.new(v25, 0, v27)
    else
        v18 = v13
    end
    return v18, v16, v17, v16 <= 0
end

v1.StepIdle = StepIdle

function v1.ChooseDestination(v28, v29, v30, v31) -- line 44 | captures: AssetWanderArea, isolatedPointFromOwner
    if v31 ~= nil and v29:NextNumber() < v30.IsolationPreference then
        return (isolatedPointFromOwner(v28, v29, v31))
    end
    if v31 ~= nil and v29:NextNumber() < v30.NearOwnerPreference then
        return AssetWanderArea.ClampedPointToward(v28, v31)
    end
    return AssetWanderArea.RandomPoint(v28, v29)
end

local function RandomOwnerOffset(v32, v33, v34) -- line 69
    local v35 = v33:NextNumber(0, 6.283185307179586)
    local v36 = math.cos(v35) * v34
    local v37 = math.sin(v35) * v34
    local v38 = Vector3.new(v36, 0, v37)
    return v32.CFrame:VectorToWorldSpace(v38)
end

v1.RandomOwnerOffset = RandomOwnerOffset

local function RollChance(v39, v40) -- line 75
    if v40 <= 0 then
        return false
    end
    if v40 >= 1 then
        return true
    end
    return v39:NextNumber() <= v40
end

v1.RollChance = RollChance

local function RandomConfiguredText(v41, v42, v43, v44) -- line 85
    local v45 = #v42 > 0
    local v46 = ("Personality %* requires at least one %* text"):format(v43, v44)
    assert(v45, v46)
    return v42[v41:NextInteger(1, #v42)]
end

v1.RandomConfiguredText = RandomConfiguredText

function v1.OwnerRootPosition(v47) -- line 90 | captures: Player
    local v48 = Player.Optional.PrimaryPart(v47)
    if v48 == nil then
        return nil
    end
    return v48.Position
end

function v1.DistanceFromPlayerToAreaCenter(v49, v50) -- line 97 | captures: v1
    local v51 = v1.OwnerRootPosition(v49)
    if v51 == nil then
        return nil
    end
    return (v51 - v50.Position).Magnitude
end

local function ShouldStartAmbientJump(v52, v53, v54, v55) -- line 104
    if v53 <= 0 or v55 then
        return false
    end
    local v56 = v52:NextNumber()
    local v57 = -v53 * v54
    return v56 <= 1 - math.exp(v57)
end

v1.ShouldStartAmbientJump = ShouldStartAmbientJump
return v1
