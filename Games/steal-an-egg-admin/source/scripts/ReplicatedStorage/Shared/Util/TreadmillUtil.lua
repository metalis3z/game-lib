-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.Interface)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trails = require(ReplicatedStorage.Data.Trails)
local t = require(ReplicatedStorage.Packages.t)
local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED
local v1 = {
    512,
    1024,
    2048,
    4096,
    8192,
    16384,
    32768,
    65536,
    131072,
    262144,
    524288,
    1048576
}
local v2 = {
    DEFAULT_BASE_SPEED_POWER = 10,
    DEFAULT_BASE_SPEED_POWER_PER_STEP = 1,
    DEFAULT_SPEED_STEP_MULTIPLIER = 1,
    TEMPORARY_SPEED_BOOST_MULTIPLIER = 2,
    TREADMILL_SPEED_GAIN_INTERVAL = 1,
    MAX_WALK_SPEED = 300,
    MAX_SPEED_BOOST_TIER_INDEX = #v1
}

local function resolveCurveLevelFromCurveProgress(v3) -- line 36
    if v3 <= 0 then
        return 0
    end
    local v4 = v3 * 0.1499999999999999 / 100 + 1
    if v4 <= 1 then
        return 0
    end
    return math.log(v4) / 0.13976194237515863
end

local function resolveReferenceWalkSpeed(v5) -- line 46
    if v5 <= 0 then
        return 10
    end
    local v6 = v5 * 2 + 10
    return (math.min(v6, 300))
end

local function resolveCurveProgress(v7) -- line 53
    local v8 = v7 - 10
    return (math.max(v8, 0))
end

local function resolveWalkSpeed(v9) -- line 56
    if v9 <= 0 then
        return 10
    end
    local v10
    if v9 > 0 then
        local v11 = v9 * 0.1499999999999999 / 100 + 1
        if v11 > 1 then
            v10 = math.log(v11) / 0.13976194237515863
        else
            v10 = 0
        end
    else
        v10 = 0
    end
    if v10 <= 0 then
        return 10
    end
    local v12 = v10 * 2 + 10
    return (math.min(v12, 300))
end

local function remapProgressionWalkSpeedToAppliedWalkSpeed(v13) -- line 77 | captures: BASE_WALK_SPEED
    local v14 = (v13 - 10) / 290
    local v15 = math.clamp(v14, 0, 1)
    return BASE_WALK_SPEED + v15 * (300 - BASE_WALK_SPEED)
end

local function remapAppliedWalkSpeedToProgressionWalkSpeed(v16) -- line 81 | captures: BASE_WALK_SPEED
    local v17 = (v16 - BASE_WALK_SPEED) / (300 - BASE_WALK_SPEED)
    return math.clamp(v17, 0, 1) * 290 + 10
end

local function formatDurationProductLabel(v18, v19) -- line 84 | captures: t
    t.strict(t.number)(v18)
    t.strict(t.boolean)(v19)
    local v20 = math.floor(v18)
    local v21 = math.max(v20, 0) // 60
    local v22 = if v21 == 1 then "Minute" else "Minutes"
    if v21 >= 60 and v21 % 60 == 0 then
        v21 //= 60
        if v21 == 1 then
            v22 = "Hour"
        else
            v22 = "Hours"
        end
    end
    if v19 then
        v22 = string.upper(v22)
    end
    return (("%* %*"):format(v21, v22))
end

function v2.NormalizeSpeedPower(v23) -- line 113 | captures: t, v2
    if v23 == nil then
        return v2.DEFAULT_BASE_SPEED_POWER
    end
    t.strict(t.number)(v23)
    return v23
end

function v2.SpeedPowerToWalkSpeed(v24) -- line 121 | captures: BASE_WALK_SPEED, v2
    local v25 = (v2.SpeedPowerToProgressionWalkSpeed(v24) - 10) / 290
    local v26 = math.clamp(v25, 0, 1)
    return BASE_WALK_SPEED + v26 * (300 - BASE_WALK_SPEED)
end

function v2.SpeedPowerToProgressionWalkSpeed(v27) -- line 126 | captures: v2
    local v28 = v2.NormalizeSpeedPower(v27) - 10
    local v29 = math.max(v28, 0)
    if v29 <= 0 then
        return 10
    end
    local v30
    if v29 > 0 then
        local v31 = v29 * 0.1499999999999999 / 100 + 1
        if v31 > 1 then
            v30 = math.log(v31) / 0.13976194237515863
        else
            v30 = 0
        end
    else
        v30 = 0
    end
    if v30 <= 0 then
        return 10
    end
    local v32 = v30 * 2 + 10
    return (math.min(v32, 300))
end

function v2.WalkSpeedToSpeedPower(v33) -- line 148 | captures: t, BASE_WALK_SPEED
    t.strict(t.number)(v33)
    local v34 = (v33 - BASE_WALK_SPEED) / (300 - BASE_WALK_SPEED)
    local v35 = math.clamp(v34, 0, 1) * 290 + 10 - 10
    return (1.15 ^ (math.max(v35, 0) / 2) - 1) * 100 / 0.1499999999999999 + 10
end

function v2.RoundSpeedPowerRequirement(v36) -- line 153 | captures: t
    t.strict(t.number)(v36)
    if v36 <= 0 then
        return 0
    end
    local v37 = math.log10(v36)
    local v38 = 10 ^ math.floor(v37)
    local v39 = v36 / v38
    local v40
    if v39 < 2 then
        v40 = 0.1
    elseif v39 >= 5 then
        v40 = 1
    else
        v40 = 0.5
    end
    local v41 = v39 / v40
    return math.ceil(v41) * v40 * v38
end

function v2.FormatSpeedPower(v42) -- line 171 | captures: v2
    local function v43(v44, ...)
        return (math.max(v44, ...))
    end

    local v45 = v43(0, v2.NormalizeSpeedPower(v42))
    local v46 = {
        { 1000000000000, "T" },
        { 1000000000, "B" },
        { 1000000, "M" },
        { 1000, "K" }
    }
    for v47, v48 in ipairs(v46) do
        if v48[1] <= v45 then
            return string.format("%.1f", v45 / v48[1]):gsub("%.0$", "") .. v48[2]
        end
    end
    local v49 = math.floor(v45)
    return (tostring(v49))
end

function v2.FormatSpeedPowerPerStep(v50) -- line 187 | captures: Simple, t
    t.strict(t.number)(v50)
    return (("+%*/step"):format((Simple.FormatCompact(v50, ".#"))))
end

function v2.ResolveEquippedTrailSpeedStepMultiplier(v51) -- line 192 | captures: Trails
    if v51 ~= nil then
        local EquippedTrail = v51.EquippedTrail
        if EquippedTrail ~= nil and v51.TrailInventory[EquippedTrail] == true and Trails.TrailNameExists(EquippedTrail) then
            local SpeedMultiplier = Trails.Directory[EquippedTrail].SpeedMultiplier
            return (math.max(SpeedMultiplier, 1))
        end
    end
    return 1
end

function v2.ResolveFinalWalkSpeed(v52, v53) -- line 202 | captures: t, v2
    t.strict(t.optional(t.number))(v52)
    t.strict(t.optional(t.number))(v53)
    local v54 = v53 or 1
    local v55 = if v54 > 0 then v54 <= 1 else false
    assert(v55)
    return v2.SpeedPowerToWalkSpeed(v52) * v54
end

function v2.ResolveEffectiveSpeedPower(v56, v57) -- line 212 | captures: t, v2
    t.strict(t.optional(t.number))(v57)
    local v58 = v2.NormalizeSpeedPower(v56)
    local v59 = v57 or 1
    local v60 = if v59 > 0 then v59 <= 1 else false
    assert(v60)
    if v59 == 1 then
        return v58
    end
    return v2.WalkSpeedToSpeedPower(v2.ResolveFinalWalkSpeed(v58, v59))
end

function v2.FormatSpeedMultiplierValue(v61) -- line 224 | captures: t
    t.strict(t.number)(v61)
    local v62 = v61 * 100
    local v63 = math.round(v62) / 100
    return "x" .. string.format("%.2f", v63):gsub("0+$", ""):gsub("%.$", "")
end

function v2.FormatSpeedMultiplier(v64) -- line 232 | captures: t, v2
    t.strict(t.number)(v64)
    return (("%* Speed"):format((v2.FormatSpeedMultiplierValue(v64))))
end

function v2.FormatTemporarySpeedBoostProductDuration(v65) -- line 237 | captures: formatDurationProductLabel
    return (formatDurationProductLabel(v65, true))
end

function v2.FormatTreadmillSpeedEquivalentDuration(v66) -- line 240 | captures: formatDurationProductLabel
    return (formatDurationProductLabel(v66, false))
end

function v2.GetSpeedBoostMultiplierForTierIndex(v67) -- line 243 | captures: t, v1
    t.strict(t.number)(v67)
    return v1[v67] or 1
end

function v2.ResolveSpeedBoostTierIndex(v68) -- line 248 | captures: v2
    if v68 == nil then
        return 0
    end
    local SpeedBoostTierIndex = v68.SpeedBoostTierIndex
    local v69 = math.floor(SpeedBoostTierIndex)
    local MAX_SPEED_BOOST_TIER_INDEX = v2.MAX_SPEED_BOOST_TIER_INDEX
    return (math.clamp(v69, 0, MAX_SPEED_BOOST_TIER_INDEX))
end

function v2.ResolveSpeedBoostSpeedStepMultiplier(v70) -- line 255 | captures: v2
    return v2.GetSpeedBoostMultiplierForTierIndex(v2.ResolveSpeedBoostTierIndex(v70))
end

function v2.ResolveTemporarySpeedBoostRemainingSeconds(v71, v72) -- line 258 | captures: t
    t.strict(t.optional(t.number))(v72)
    if v71 == nil then
        return 0
    end
    local TemporarySpeedBoostRemainingSeconds = v71.TemporarySpeedBoostRemainingSeconds
    local v73 = math.max(TemporarySpeedBoostRemainingSeconds, 0)
    local TemporarySpeedBoostActiveStartedAt = v71.TemporarySpeedBoostActiveStartedAt
    local v74
    if TemporarySpeedBoostActiveStartedAt > 0 then
        local v75
        if v72 == nil then
            v75 = workspace:GetServerTimeNow()
        else
            v75 = v72
        end
        local v76 = v75 - TemporarySpeedBoostActiveStartedAt
        v74 = v73 - math.max(v76, 0)
    else
        v74 = v73
    end
    return (math.max(v74, 0))
end

function v2.ResolveTemporarySpeedBoostSpeedStepMultiplier(v77, v78) -- line 277 | captures: v2
    if v2.ResolveTemporarySpeedBoostRemainingSeconds(v77, v78) <= 0 then
        return 1
    end
    return 2
end

function v2.ResolveAdditiveSpeedStepMultiplier(v79, v80) -- line 284 | captures: t
    t.strict(t.optional(t.number))(v79)
    t.strict(t.optional(t.number))(v80)
    local v81 = if v79 == nil then 1 else v79
    local v82 = if v80 == nil then 1 else v80
    local v83 = v81 - 1
    local v84 = math.max(v83, 0)
    local v85 = v82 - 1
    local v86 = math.max(v85, 0)
    return v84 + 1 + v86
end

function v2.ResolveTreadmillSpeedPowerDelta(v87, v88, v89, v90) -- line 304 | captures: t, v2
    t.strict(t.number)(v87)
    t.strict(t.number)(v88)
    t.strict(t.optional(t.number))(v89)
    t.strict(t.optional(t.number))(v90)
    local v91
    if v90 == nil then
        v91 = 1
    else
        v91 = math.max(v90, 0)
    end
    return math.max(v87, 0) * v2.ResolveAdditiveSpeedStepMultiplier(v88, v89) * v91
end

function v2.ResolveSpeedPowerPerStep(v92, v93, v94) -- line 320 | captures: t, v2
    t.strict(t.optional(t.number))(v93)
    t.strict(t.optional(t.number))(v94)
    local v95 = v2.ResolveSpeedBoostSpeedStepMultiplier(v92)
    local v96 = v2.ResolveTemporarySpeedBoostSpeedStepMultiplier(v92, v94)
    local v97 = v2.ResolveEquippedTrailSpeedStepMultiplier(v92)
    local v98 = v2.ResolveTreadmillSpeedPowerDelta(1, v93 or 1, nil)
    local v99 = v2.ResolveAdditiveSpeedStepMultiplier(v95, v96)
    return v98 * v2.ResolveAdditiveSpeedStepMultiplier(v99, v97)
end

function v2.ResolveSpeedPowerPerSecond(v100, v101, v102) -- line 332 | captures: t, v2
    t.strict(t.table)(v100)
    t.strict(t.number)(v101)
    t.strict(t.optional(t.number))(v102)
    local v103 = v2.ResolveSpeedPowerPerStep(v100, v101, v102)
    local v104 = v2.SpeedPowerToProgressionWalkSpeed(v100.SpeedPower)
    return v103 / v2.ResolveWalkSpeedPowerAwardInterval(v104)
end

function v2.ResolveTreadmillEquivalentSpeedPower(v105, v106, v107, v108) -- line 343 | captures: t, v2
    t.strict(t.table)(v105)
    t.strict(t.number)(v106)
    t.strict(t.number)(v107)
    t.strict(t.optional(t.number))(v108)
    local v109 = v107 > 0
    assert(v109, "Treadmill equivalent duration must be positive")
    return v2.ResolveSpeedPowerPerSecond(v105, v106, v108) * v107
end

function v2.ResolveNextTreadmillSpeedGainAt(v110) -- line 356 | captures: t
    t.strict(t.number)(v110)
    return v110 + 1
end

function v2.ResolveElapsedTreadmillSpeedGainTicks(v111, v112) -- line 361 | captures: t
    t.strict(t.number)(v111)
    t.strict(t.number)(v112)
    if v112 < v111 then
        return 0
    end
    local v113 = (v112 - v111) / 1
    return math.floor(v113) + 1
end

function v2.ResolveWalkSpeedPowerAwardInterval(v114) -- line 371 | captures: t
    t.strict(t.number)(v114)
    local v115 = (v114 - 10) / 90
    return 0.25 - math.clamp(v115, 0, 1) * 0.15
end

local function findOptionalPresentationPart(v116, v117) -- line 376
    local v118 = v116:FindFirstChild(v117, true)
    if v118 == nil then
        return nil
    end
    local BasePart = v118:IsA("BasePart")
    local v119 = ("Treadmill \"%*\" %* must be a BasePart"):format(v116.Name, v117)
    assert(BasePart, v119)
    return v118
end

function v2.FindVideoFeedScreenPart(v120) -- line 385 | captures: t
    t.strict(t.instanceIsA("Tool"))(v120)
    local v121 = v120:FindFirstChild("VideoFeedScreen", true)
    if v121 == nil then
        return nil
    end
    local BasePart = v121:IsA("BasePart")
    local v122 = ("Treadmill \"%*\" VideoFeedScreen must be a BasePart"):format(v120.Name)
    assert(BasePart, v122)
    return v121
end

function v2.FindVideoPlayerFolder(v123) -- line 396 | captures: t, v2
    t.strict(t.instanceIsA("Tool"))(v123)
    local v124 = v2.FindVideoFeedScreenPart(v123)
    if v124 == nil then
        return nil
    end
    local Folder = v124:FindFirstAncestorOfClass("Folder")
    if not (Folder ~= nil and Folder:IsDescendantOf(v123)) then
        return nil
    end
    return Folder
end

function v2.FindVideoPresentationParts(v125) -- line 409 | captures: t, v2
    t.strict(t.instanceIsA("Tool"))(v125)
    local v126 = v2.FindVideoFeedScreenPart(v125)
    local v127 = v125:FindFirstChild("SwapLeft", true)
    if v127 ~= nil then
        local BasePart = v127:IsA("BasePart")
        local v128 = ("Treadmill \"%*\" SwapLeft must be a BasePart"):format(v125.Name)
        assert(BasePart, v128)
    end
    local v129 = v125:FindFirstChild("SwapRight", true)
    if v129 ~= nil then
        local BasePart = v129:IsA("BasePart")
        local v130 = ("Treadmill \"%*\" SwapRight must be a BasePart"):format(v125.Name)
        assert(BasePart, v130)
    end
    if v126 ~= nil and v127 ~= nil and v129 ~= nil then
        return v126, v127, v129
    end
    return nil, nil, nil
end

function v2.ResolveGroundedToolRootCFrameAtLocation(v131, v132) -- line 435 | captures: t
    t.strict(t.instanceIsA("BasePart"))(v131)
    t.strict(t.instanceIsA("Tool"))(v132)
    local Root = v132.Root
    local BasePart = Root:IsA("BasePart")
    local v133 = ("Treadmill \"%*\" Root must be a BasePart"):format(v132.Name)
    assert(BasePart, v133)
    local BoundingBoxPart = v132.BoundingBoxPart
    local BasePart_2 = BoundingBoxPart:IsA("BasePart")
    local v134 = ("Treadmill \"%*\" BoundingBoxPart must be a BasePart"):format(v132.Name)
    assert(BasePart_2, v134)
    local v135 = Root.CFrame:PointToObjectSpace(BoundingBoxPart.CFrame.Position)
    local v136 = BoundingBoxPart.Size.Y * 0.5 + (v132:GetAttribute("Offset") or 0)
    return CFrame.new(v131.Position + Vector3.new(0, v136, 0)) * v131.CFrame.Rotation * CFrame.new(-v135)
end

return v2
