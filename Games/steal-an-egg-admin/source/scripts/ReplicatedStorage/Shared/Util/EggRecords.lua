-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local Areas = require(ReplicatedStorage.Data.Areas)
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Util.AssetGender)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetLottery = require(ReplicatedStorage.Shared.Util.AssetLottery)
local AssetPalette = require(ReplicatedStorage.Shared.Util.AssetPalette)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local t = require(ReplicatedStorage.Packages.t)
local ComponentsFromCFrame = require(ReplicatedStorage.Shared.Utils.Codec).ComponentsFromCFrame
local CFrameFromComponents = require(ReplicatedStorage.Shared.Utils.Codec).CFrameFromComponents
local v1 = t.numberMinExclusive((-1/0))
local v2 = t.intersection(v1, t.numberMaxExclusive((1/0)))
local v3 = t.numberMin(0)
local v4 = t.intersection(v3, t.numberMaxExclusive((1/0)))
local v5 = t.intersection(t.integer, t.numberMin(0))
local v7 = {
    {
        min = 0.85,
        max = 1.05,
        weight = 2000
    },
    {
        min = 1.45,
        max = 1.55,
        weight = 2500
    },
    {
        min = 1.9,
        max = 2.1,
        weight = 1250
    },
    {
        min = 2.85,
        max = 3.15,
        weight = 625
    },
    {
        min = 3.8,
        max = 4.2,
        weight = 312.5
    },
    {
        min = 0.3,
        max = 0.45,
        weight = 18
    },
    {
        min = 0.1,
        max = 0.2,
        weight = 5
    },
    {
        min = 5.8,
        max = 6.2,
        weight = 156.25
    },
    {
        min = 9.5,
        max = 12.5,
        weight = 30
    },
    {
        min = 12,
        max = 17,
        weight = 0.5
    },
    {
        min = 20,
        max = 35,
        weight = 0.001
    }
}
local v8 = t.strict(t.boolean)
local v9 = t.strict(v2)
local v10 = t.strict(t.optional(v4))
local v11 = t.strict(t.optional(v5))
local v12 = t.strict(v4)
local v13 = t.strict(t.string)
local v14 = t.strict(v5)
local v15 = t.strict(t.optional(t.callback))
local v16 = t.strict(t.optional(t.number))
local v17 = t.strict(t.number)
local v18 = t.strict(t.table)
local v19 = {}
local v20 = Random.new()
local v21 = {}

local function reloadGrowthBoosts() -- line 56 | captures: v21, HttpService
    local TemporaryGrowthBoosts = workspace:GetAttribute("TemporaryGrowthBoosts")
    if type(TemporaryGrowthBoosts) == "string" and TemporaryGrowthBoosts ~= "" then
        xpcall(function() -- line 61 | captures: TemporaryGrowthBoosts, v21, HttpService
            v21 = HttpService:JSONDecode(TemporaryGrowthBoosts)
        end, function() -- line 63 | captures: v21
            v21 = {}
        end)
    end
end

workspace:GetAttributeChangedSignal("TemporaryGrowthBoosts"):Connect(reloadGrowthBoosts)
task.spawn(reloadGrowthBoosts)

local function bandBias(v22, v23) -- line 70 | captures: v9
    local v24
    if v23 then
        v24 = v23(v22.min, v22.max)
    else
        v24 = 1
    end
    v9(v24)
    local v25 = v24 > 0
    assert(v25, "A scale band bias has to be a positive multiplier")
    return v24
end

local function growthCurve(v26) -- line 82
    if v26 <= 2 then
        return 1
    end
    if v26 <= 6 then
        return (v26 / 2) ^ 1.389
    end
    local v27 = (v26 / 6) ^ 0.72 * 4.6
    return (math.min(v27, 20))
end

local function boostedSecondsFor(v28) -- line 91 | captures: v21
    local v29
    if v28 then
        v29 = v28:GetAttribute("JoinTick")
    end
    if type(v29) == "number" then
        local v30 = 0
        for v31, v32 in v21 do
            local StartedAt = v32.StartedAt
            local v33 = math.max(StartedAt, v29)
            local v34 = workspace:GetServerTimeNow()
            local EndsAt = v32.EndsAt
            local v35 = (math.min(v34, EndsAt) - v33) * v32.Multiplier
            v30 += math.floor(v35)
        end
        return v30
    end
    return 0
end

local function eggConfig(v36) -- line 112 | captures: Assets
    local v37 = Assets.Directory[v36]
    local v38 = v37 ~= nil
    local v39 = ("Asset catalog carries no entry named %*"):format(v36)
    assert(v38, v39)
    return v37
end

local function adminScaleBias() -- line 118 | captures: AdminBoosts
    local v40 = AdminBoosts.ReadMultiplier(AdminBoosts.EGG_SIZE)
    if v40 <= 1 then
        return nil
    end
    return function(v41, v42) -- line 123 | captures: v40
        if v41 >= 1.45 then
            return v40
        end
        if v42 <= 0.45 then
            return 1 / v40
        end
        return 1
    end
end

local function requireSchema(v43) -- line 133 | captures: Eggs
    local v44 = Eggs.SchemaValidation.SavedEgg(v43)
    assert(v44, "Saved egg failed its schema check")
end

local function copyTiming(v45) -- line 137
    return {
        PlacedAt = v45.PlacedAt,
        ReadyAt = v45.ReadyAt,
        GrowthDuration = v45.GrowthDuration,
        GrowthCreditSeconds = v45.GrowthCreditSeconds,
        NightGrowthPeriodIndex = v45.NightGrowthPeriodIndex,
        NightGrowthCreditSeconds = v45.NightGrowthCreditSeconds
    }
end

local function copyIdentity(v46) -- line 147
    local v47 = {
        AssetCategory = v46.AssetCategory,
        AssetScale = v46.AssetScale,
        AssetEyeColor = v46.AssetEyeColor,
        AssetColorSeed = v46.AssetColorSeed,
        AssetColorIndex = v46.AssetColorIndex,
        AssetGender = v46.AssetGender,
        AssetPersonality = v46.AssetPersonality,
        BaseMutation = v46.BaseMutation
    }
    if v46.Mutations then
        v47.Mutations = table.clone(v46.Mutations)
    else
        v47.Mutations = nil
    end
    v47.IsStolenDNA = v46.IsStolenDNA
    v47.HasParasite = v46.HasParasite
    v47.ParasiteRemovedForHatch = v46.ParasiteRemovedForHatch
    v47.MechaRerollDone = v46.MechaRerollDone
    return v47
end

local function slotOf(v48) -- line 171
    return v48.Placement
end

function v19.DrawAssetScale(v49, v50) -- line 174 | captures: v7, v9, v15, v16, v17, v18
    v18(v7)
    v16(150)
    v16(0.01)
    v15(v50)
    local v51 = v49 or Random.new()
    local v52 = 0
    for v53, v54 in ipairs(v7) do
        v17(v54.min)
        v17(v54.max)
        v17(v54.weight)
        local v55 = v54.min <= v54.max
        assert(v55, "A scale band cannot end below where it starts")
        local v56 = v54.weight > 0
        assert(v56, "A scale band needs a weight above zero to be reachable")
        v9(1)
        local v57 = 0 < 1
        assert(v57, "A scale band bias has to be a positive multiplier")
        v52 += v54.weight * 1
    end
    local v58 = v52 > 0
    assert(v58, "No scale band is reachable: the weights total zero")
    local v59 = v7[1]
    local v60 = v51:NextNumber() * v52
    local v61 = 0
    for v62, v63 in ipairs(v7) do
        v9(1)
        local v64 = 0 < 1
        assert(v64, "A scale band bias has to be a positive multiplier")
        v61 += v63.weight * 1
        if v60 <= v61 then
            v59 = v63
            break
        end
    end
    local v65 = v51:NextNumber()
    local v66 = v59.min + v65 * (v59.max - v59.min)
    while v66 * 2 <= 150 do
        if v51:NextNumber() > 0.01 then
            break
        end
        v66 *= 2
    end
    return v66
end

function v19.EggModelName(v67, v68, v69) -- line 234 | captures: Assets, Mutations, v13
    v13(v67)
    local v70 = Assets.Directory[v67]
    local v71 = v70 ~= nil
    local v72 = ("Asset catalog carries no entry named %*"):format(v67)
    assert(v71, v72)
    local ModelName = v70.Egg.ModelName
    if ModelName == nil then
        return Mutations.EggModelName(v68, v69) or v67
    end
    return ModelName
end

function v19.EggModelTemplate(v73, v74, v75) -- line 245 | captures: ReplicatedStorage, v19
    local v76 = v19.EggModelName(v73, v74, v75)
    local v77 = ReplicatedStorage.Assets.Models.Eggs:FindFirstChild(v76)
    local v78 = v77 ~= nil
    local v79 = ("Egg model \"%*\" for asset %* is missing from ReplicatedStorage.Assets.Models.Eggs"):format(v76, v73)
    assert(v78, v79)
    local Model = v77:IsA("Model")
    local v80 = ("Egg model \"%*\" must be a Model"):format(v76)
    assert(Model, v80)
    return v77
end

function v19.Normalize(v81) -- line 254 | captures: AssetPalette
    local v82 = AssetPalette.SettleFields(v81.AssetCategory, v81.AssetEyeColor, v81.AssetColorSeed, v81.AssetColorIndex)
    local v83 = table.clone(v81)
    v83.AssetEyeColor = v82.EyeColor
    v83.AssetColorSeed = v82.ColorSeed
    v83.AssetColorIndex = v82.ColorIndex
    return v83
end

local function cframeToComponents(value)
	if typeof(value) == "CFrame" then
		return ComponentsFromCFrame(value)
	end
	if type(value) == "table" and #value == 12 and typeof(value[1]) == "number" and typeof(value[12]) == "number" then
		return { table.unpack(value, 1, 12) }
	end
	return nil
end

local function componentsToCFrame(value)
	if typeof(value) == "CFrame" then
		return value
	end
	if type(value) == "table" and #value == 12 then
		return CFrameFromComponents(value)
	end
	return nil
end

function v19.EncodePlacement(v84) -- line 262 | captures: ComponentsFromCFrame
	local components = cframeToComponents(v84.LocalCFrame)
	assert(components, "Placement.LocalCFrame must be a CFrame or a 12-number component array")
	return {
        PlacedAt = v84.PlacedAt,
        ReadyAt = v84.ReadyAt,
        GrowthDuration = v84.GrowthDuration,
        GrowthCreditSeconds = v84.GrowthCreditSeconds,
        NightGrowthPeriodIndex = v84.NightGrowthPeriodIndex,
        NightGrowthCreditSeconds = v84.NightGrowthCreditSeconds,
        LocalCFrame = components
    }
end

function v19.DecodePlacement(v85) -- line 273 | captures: CFrameFromComponents
	local cframe = componentsToCFrame(v85.LocalCFrame)
	assert(cframe, "Placement.LocalCFrame must be a CFrame or a 12-number component array")
	return {
        PlacedAt = v85.PlacedAt,
        ReadyAt = v85.ReadyAt,
        GrowthDuration = v85.GrowthDuration,
        GrowthCreditSeconds = v85.GrowthCreditSeconds,
        NightGrowthPeriodIndex = v85.NightGrowthPeriodIndex,
        NightGrowthCreditSeconds = v85.NightGrowthCreditSeconds,
        LocalCFrame = cframe
    }
end

function v19.Encode(v86) -- line 284 | captures: v19, copyIdentity
    local v87 = v19.Normalize(v86)
    local v88 = copyIdentity(v87)
    local Placement = v87.Placement
    if Placement then
        v88.Placement = v19.EncodePlacement(Placement)
    else
        v88.Placement = nil
    end
    return v88
end

function v19.Decode(v89) -- line 297 | captures: v19, copyIdentity
    local v90 = copyIdentity(v89)
    local Placement = v89.Placement
    if Placement then
        v90.Placement = v19.DecodePlacement(Placement)
    else
        v90.Placement = nil
    end
    return v19.Normalize(v90)
end

function v19.GrowthSpeedMultiplier(v91) -- line 309 | captures: v8
    v8(v91)
    if v91 then
        return 2
    end
    return 1
end

function v19.GrowthDuration(v92) -- line 316 | captures: Assets, Eggs, v9
    local v93 = Eggs.SchemaValidation.SavedEgg(v92)
    assert(v93, "Saved egg failed its schema check")
    local Placement = v92.Placement
    local v94 = assert(Placement, "Growth duration is only defined for a placed egg")
    if v94.GrowthDuration == nil then
        v9(v92.AssetScale)
        local v95 = v92.AssetScale > 0
        assert(v95, "Growth duration needs a positive asset scale")
        local AssetCategory = v92.AssetCategory
        local v96 = Assets.Directory[AssetCategory]
        local v97 = v96 ~= nil
        local v98 = ("Asset catalog carries no entry named %*"):format(AssetCategory)
        assert(v97, v98)
        local Egg = v96.Egg
        if Egg.IgnoreSizeGrowthMultiplier then
            return Egg.GrowthTime
        end
        local AssetScale = v92.AssetScale
        local v99
        if AssetScale <= 2 then
            v99 = 1
        elseif AssetScale > 6 then
            local v100 = (AssetScale / 6) ^ 0.72 * 4.6
            v99 = math.min(v100, 20)
        else
            v99 = (AssetScale / 2) ^ 1.389
        end
        return Egg.GrowthTime * v99
    end
    return v94.GrowthDuration
end

function v19.GrowthCredit(v101) -- line 345 | captures: v12
    local Placement = v101.Placement
    local v102 = Placement ~= nil and Placement.GrowthCreditSeconds or 0
    v12(v102)
    return v102
end

function v19.GrowthAlpha(v103, v104, v105, v106, v107) -- line 356 | captures: v9, v10, v19, boostedSecondsFor
    v9(v104)
    v9(v105)
    v10(v106)
    local v108 = v105 > 0
    assert(v108, "The growth speed multiplier has to be above zero")
    local Placement = v103.Placement
    if Placement == nil then
        return 0
    end
    if Placement.ReadyAt == nil then
        local v109 = v19.GrowthDuration(v103)
        if v109 <= 0 then
            return 1
        end
        local v110 = v19.GrowthCredit(v103) + (v106 or 0) + boostedSecondsFor(v107)
        local v111 = ((v104 - Placement.PlacedAt) * v105 + v110) / v109
        return (math.clamp(v111, 0, 1))
    end
    return 1
end

function v19.GrowthSecondsRemaining(v112, v113, v114, v115, v116) -- line 377 | captures: v9, v10, v19, boostedSecondsFor
    v9(v113)
    v9(v114)
    v10(v115)
    local v117 = v114 > 0
    assert(v117, "The growth speed multiplier has to be above zero")
    local Placement = v112.Placement
    local v118 = assert(Placement, "Remaining growth is only defined for a placed egg")
    if v118.ReadyAt == nil then
        local v119 = v19.GrowthCredit(v112) + (v115 or 0) + boostedSecondsFor(v116)
        local v120 = v19.GrowthDuration(v112) - (v113 - v118.PlacedAt) * v114 - v119
        return (math.max(0, v120))
    end
    return 0
end

function v19.WallSecondsRemaining(v121, v122, v123, v124) -- line 391 | captures: v19
    local v125 = v19.GrowthSecondsRemaining(v121, v122, v123, v124)
    if v125 <= 0 then
        return 0
    end
    return v125 / v123
end

function v19.IsGrown(v126, v127, v128, v129, v130) -- line 398 | captures: v19
    return v19.GrowthAlpha(v126, v127, v128, v129, v130) >= 1
end

function v19.CommittedNightCredit(v131, v132) -- line 403 | captures: v11, v12, v14
    v14(v132)
    local Placement = v131.Placement
    if Placement == nil then
        return 0
    end
    v11(Placement.NightGrowthPeriodIndex)
    local v133 = Placement.NightGrowthPeriodIndex == v132 and Placement.NightGrowthCreditSeconds or 0
    v12(v133)
    return v133
end

function v19.NightCreditAt(v134, v135, v136, v137, v138) -- line 419 | captures: AreaEggCycle, v9, v14, v19
    v9(v135)
    v9(v136)
    v9(v137)
    v14(v138)
    local v139 = v136 > 0
    assert(v139, "The growth speed multiplier has to be above zero")
    local Placement = v134.Placement
    if Placement ~= nil and Placement.ReadyAt == nil and not (v137 < Placement.PlacedAt) then
        local v140 = v19.CommittedNightCredit(v134, v138)
        local v141 = v19.GrowthSecondsRemaining(v134, v137, v136) + v140
        local v142 = AreaEggCycle.NightGrowthCreditAt(v135, v137)
        local v143 = math.min(v142, v141) - v140
        return (math.max(0, v143))
    end
    return 0
end

function v19.CurrentNightCredit(v144, v145, v146) -- line 435 | captures: AreaEggCycle, v19
    if AreaEggCycle.IsNightPhase(v145) then
        local v147 = AreaEggCycle.NightStartTime(v145)
        local v148 = v147 + AreaEggCycle.NightLengthSeconds()
        local v149 = AreaEggCycle.PeriodIndexAt(v148)
        return v19.NightCreditAt(v144, v145, v146, v147, v149)
    end
    return 0
end

function v19.ServerGrowthBoostMultiplier() -- line 444 | captures: v21
    local v150 = 0
    for v151, v152 in v21 do
        v150 += v152.Multiplier
    end
    return v150
end

function v19.ServerGrowthBoostEndsAt() -- line 454 | captures: v21
    local v153 = 0
    for v154, v155 in v21 do
        local EndsAt = v155.EndsAt
        v153 = math.max(v153, EndsAt)
    end
    return v153
end

function v19.NewEgg(v156, v157) -- line 464 | captures: AdminBoosts, AssetLottery, AssetPalette, Eggs, v13, v19, v20
    v13(v156)
    local v158 = v157 or v20
    local v159 = AssetLottery.DrawMutations(nil, nil, v158, AdminBoosts.ReadMultiplier(AdminBoosts.MUTATION_LUCK))
    local v160 = AssetPalette.DrawFields(v156, v158)
    local v161 = AdminBoosts.ReadMultiplier(AdminBoosts.EGG_SIZE)
    local v162
    if v161 > 1 then
        function v162(v163, v164) -- line 475 | captures: v161
            if v163 >= 1.45 then
                return v161
            end
            if v164 <= 0.45 then
                return 1 / v161
            end
            return 1
        end
    end
    local v165 = {
        AssetCategory = v156,
        AssetScale = v19.DrawAssetScale(v158, v162),
        AssetEyeColor = v160.EyeColor,
        AssetColorSeed = v160.ColorSeed,
        AssetColorIndex = v160.ColorIndex,
        Mutations = v159,
        BaseMutation = v159[1]
    }
    local v166, v167 = Eggs.SchemaValidation.SavedEgg(v165)
    assert(v166, v167)
    return v165
end

function v19.ToAssetItemData(v168) -- line 501 | captures: Eggs, Personalities
    local v169 = Eggs.SchemaValidation.SavedEgg(v168)
    assert(v169, "Saved egg failed its schema check")
    local v170 = {
        Category = v168.AssetCategory,
        Scale = v168.AssetScale,
        EyeColor = v168.AssetEyeColor,
        ColorSeed = v168.AssetColorSeed,
        ColorIndex = v168.AssetColorIndex
    }
    v170.Mutations = v168.Mutations or {}
    v170.BaseMutation = v168.BaseMutation
    v170.Gender = v168.AssetGender
    v170.Personality = v168.AssetPersonality
    v170.IsStolenDNA = v168.IsStolenDNA
    return (Personalities.CreateNewItemData(v170))
end

function v19.SellPrice(v171) -- line 522 | captures: AssetItems, Eggs, v19
    local v172 = Eggs.SchemaValidation.SavedEgg(v171)
    assert(v172, "Saved egg failed its schema check")
    local v173 = table.clone(v19.ToAssetItemData(v171))
    v173.Mutations = {}
    v173.BaseMutation = nil
    return AssetItems.SalePrice(v173) * 0.8
end

function v19.WeightKgForScale(v174, v175) -- line 530 | captures: AssetItems, v9, v13
    v13(v174)
    v9(v175)
    return AssetItems.WeightKg({
        Category = v174,
        Scale = v175,
        Mutations = {}
    })
end

function v19.WeightKg(v176) -- line 535 | captures: Eggs, v19
    local v177 = Eggs.SchemaValidation.SavedEgg(v176)
    assert(v177, "Saved egg failed its schema check")
    return v19.WeightKgForScale(v176.AssetCategory, v176.AssetScale)
end

function v19.WeightLabel(v178) -- line 540 | captures: AddCommas, v19
    return (("%*Kg"):format((AddCommas(v19.WeightKg(v178)))))
end

function v19.DisplayName(v179) -- line 543 | captures: Areas, Assets, Eggs, Mutations
    local v180 = Eggs.SchemaValidation.SavedEgg(v179)
    assert(v180, "Saved egg failed its schema check")
    local v181 = Mutations.EggDisplayName(v179.Mutations, v179.BaseMutation)
    if v181 then
        return v181
    end
    local AssetCategory = v179.AssetCategory
    local v182 = Assets.Directory[AssetCategory]
    local v183 = v182 ~= nil
    local v184 = ("Asset catalog carries no entry named %*"):format(AssetCategory)
    assert(v183, v184)
    local _id = v182.Rarity._id
    for v185, v186 in pairs(Areas.Directory) do
        for v187, v188 in ipairs(v186.DropTable) do
            local v189 = v188[1]
            if v189 == v6.AssetCategory or v189 == _id then
                return (("%* Egg"):format(v186.DisplayName))
            end
        end
    end
    return "Egg"
end

function v19.DisplayNameWithWeight(v190) -- line 567 | captures: v19
    return (("%* (%*)"):format(v19.DisplayName(v190), (v19.WeightLabel(v190))))
end

return v19
