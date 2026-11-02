-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local v1 = require(ReplicatedStorage.Shared.Modules.BetterRandom).new()
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local PickWeightedWith = require(ReplicatedStorage.Shared.Utils.Numeric).PickWeightedWith
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local AssetRollScaleWeights = require(script.Parent.AssetRollScaleWeights)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local t = require(ReplicatedStorage.Packages.t)
local v2 = t.numberMinExclusive((-1/0))
local v3 = t.intersection(v2, t.numberMaxExclusive((1/0)))
local v4 = t.numberMin(0)
local v5 = t.intersection(v4, t.numberMaxExclusive((1/0)))
local NO_MUTATION = Mutations.NO_MUTATION
local v6 = Random.new()
local v7 = Random.new()
local v8 = t.strict(v3)
local v9 = t.strict(v5)
local v10 = t.strict(t.number)
local v11 = t.strict(t.table)
local v13 = {}
local Warning = Log.new():LimitUnderLevel("Warning")
local v14 = {}
for v15, v16 in ipairs(AssetRollScaleWeights) do
    local v17 = {
        {
            v16.low,
            v16.high
        },
        v16.weight
    }
    table.insert(v14, v17)
end
local v18 = {}
local v19 = ""
local v20 = ""
for v21, v22 in pairs(Assets.Directory) do
    if v20 == "" then
        v19 = v21
        v20 = v21
    end
    local DropWeight = v22.DropWeight
    if DropWeight > 0 and not v22.DontRoll and v22.Rarity ~= Rarity.Rarities.Eternal then
        local v23 = { v21, DropWeight }
        table.insert(v18, v23)
    end
end
local v24 = #v18 > 0
assert(v24, "Asset catalog yielded nothing rollable")
local v25 = Mutations.RollTable()
local v26 = Mutations.All()

local function shiftedTowardsFlat(v27, v28) -- line 53 | captures: TableUtil, Warning
    if v28 <= 0 then
        return TableUtil.Copy(v27, true)
    end
    local v29 = v28 / 100
    local v30 = v29 / (v29 + 1) * 0.49
    local v31 = (1/0)
    local v32 = 0
    for v33, v34 in ipairs(v27) do
        local v35 = v34[2]
        if v35 < v31 then
            v31 = v35
        end
        v32 += v35
    end
    local v36 = {}
    local v37 = 0
    for v38, v39 in ipairs(v27) do
        local v40 = v39[2]
        local v41 = v40 - (v40 - v31) * v30
        local v42 = {
            v39[1],
            v41
        }
        table.insert(v36, v42)
        v37 += v41
    end
    local v43 = if v37 == 0 then 1 else v32 / v37
    for v44, v45 in ipairs(v36) do
        v45[2] *= v43
    end
    Warning:AtTrace():Log((("weight shift luck=%* pull=%* norm=%*"):format(v12, v30, v43)))
    return v36
end

local function amplifyMutations(v46, v47) -- line 89 | captures: NO_MUTATION
    local v48 = {}
    for v49, v50 in ipairs(v46) do
        local v51 = v50[1]
        local v52 = v50[2]
        if v51 ~= NO_MUTATION then
            v52 *= v47
        end
        local v53 = { v51, v52 }
        table.insert(v48, v53)
    end
    return v48
end

local function entriesAtRarity(v54, v55) -- line 105 | captures: Assets
    local v56 = Assets.ByRarity[v55]
    local v57 = v56 ~= nil
    local v58 = ("%*: no assets indexed under rarity %*"):format(v54, v55)
    assert(v57, v58)
    local v59 = {}
    for v60, v61 in pairs(v56) do
        local DropWeight = v61.DropWeight
        if typeof(DropWeight) == "number" and DropWeight > 0 then
            local v62 = { v60, DropWeight }
            table.insert(v59, v62)
        end
    end
    local v63 = #v59 > 0
    local v64 = ("%*: rarity %* has no asset with a drop weight"):format(v54, v55)
    assert(v63, v64)
    return v59
end

local function usableWeight(v65) -- line 121
    if typeof(v65) == "number" and v65 > 0 and v65 == v65 then
        return v65 ~= (1/0)
    end
    return false
end

local function tokenOf(v66) -- line 128
    local v67 = v66[1]
    if typeof(v67) == "string" then
        return v66[1]
    end
    return ""
end

local function rarestFirst(v68) -- line 134
    local v69 = {}
    for v70, v71 in ipairs(v68) do
        table.insert(v69, v71)
    end
    table.sort(v69, function(v72, v73) -- line 139
        local v74 = v72[2]
        local v75 = if typeof(v74) == "number" and v74 > 0 and v74 == v74 then v74 ~= (1/0) else false
        local v76 = v73[2]
        local v77 = if typeof(v76) == "number" and v76 > 0 and v76 == v76 then v76 ~= (1/0) else false
        if v75 == v77 then
            if v75 then
                local v78 = v72[2]
                local v79 = v73[2]
                if v78 == v79 then
                    local v80 = v72[1]
                    local v81 = if typeof(v80) == "string" then v72[1] else ""
                    local v82 = v73[1]
                    local v83 = if typeof(v82) == "string" then v73[1] else ""
                    return v81 < v83
                end
                return v78 < v79
            end
            local v84 = v72[1]
            local v85 = if typeof(v84) == "string" then v72[1] else ""
            local v86 = v73[1]
            local v87 = if typeof(v86) == "string" then v73[1] else ""
            return v85 < v87
        end
        return v75
    end)
    return v69
end

local function usableWeightSum(v88) -- line 191
    local v89 = 0
    for v90, v91 in ipairs(v88) do
        local v92 = v91[2]
        if typeof(v92) == "number" and v92 > 0 and v92 == v92 and v92 ~= (1/0) then
            v89 += v91[2]
        end
    end
    return v89
end

local function cumulativeChance(v93, v94) -- line 207 | captures: v8, v9
    v8(v93)
    v9(v94)
    if v94 <= 1 then
        return v93
    end
    return 1 - (1 - v93) ^ v94
end

local function drawLuckyToken(v95, v96, v97) -- line 215 | captures: v10, v11, rarestFirst, usableWeightSum
    v11(v95)
    v10(v96)
    local v98 = if v97 == nil then true else typeof(v97) == "Random"
    assert(v98, "A token draw needs a Random or nil")
    local v99 = rarestFirst(v95)
    local v100 = usableWeightSum(v99)
    if v100 <= 0 then
        return nil
    end
    local v101 = (1 - (1 - (v97 or Random.new()):NextNumber()) ^ (1 / math.max(v96, 1))) * v100
    local v102
    for v103, v104 in ipairs(v99) do
        local v105 = v104[1]
        if typeof(v105) == "string" then
            local v106 = v104[2]
            if typeof(v106) == "number" and v106 > 0 and v106 == v106 and v106 ~= (1/0) then
                v102 = v104[1]
                v101 -= v104[2]
                if v101 <= 0 then
                    return v102
                end
            end
        end
    end
    return v102
end

local function bandCeiling(v107) -- line 252
    local v108 = v107[1]
    if typeof(v108) == "table" then
        v108 = v108[#v108]
    end
    if typeof(v108) == "number" then
        return v108
    end
    return nil
end

local function RollCountFor(v109, v110) -- line 265
    local v111 = if typeof(v109) == "number" then v109 else 0
    local v112 = 1 + v111 / 100
    local v113 = math.max(v112, 0)
    local v114
    if typeof(v110) == "number" then
        v114 = math.max(v110, 1)
    else
        v114 = 1
    end
    local v115 = v113 + (v114 - 1)
    return (math.max(v115, 1))
end

v13.RollCountFor = RollCountFor

function v13.TokenChances(v116, v117) -- line 282 | captures: v8, v9, v10, v11, rarestFirst, usableWeightSum
    v11(v116)
    v10(v117)
    local v118 = rarestFirst(v116)
    local v119 = usableWeightSum(v118)
    if v119 <= 0 then
        return {}
    end
    local v120 = math.max(v117, 1)
    local v121 = {}
    local v122 = 0
    for v123, v124 in ipairs(v118) do
        local v125 = v124[1]
        if typeof(v125) == "string" then
            local v126 = v124[2]
            if typeof(v126) == "number" and v126 > 0 and v126 == v126 and v126 ~= (1/0) then
                local v127 = v124[1]
                local v128 = v122 / v119
                v122 += v124[2]
                local v129 = v122 / v119
                v8(v129)
                v9(v120)
                if v120 > 1 then
                    v129 = 1 - (1 - v129) ^ v120
                end
                v8(v128)
                v9(v120)
                if v120 > 1 then
                    v128 = 1 - (1 - v128) ^ v120
                end
                local v130 = v129 - v128
                if v130 > 0 then
                    v121[v127] = (v121[v127] or 0) + v130
                end
            end
        end
    end
    return v121
end

function v13.DrawCategory(v131, v132, v133) -- line 330 | captures: v19, v7, v13, Warning, v18, drawLuckyToken
    local v134 = v13.RollCountFor(v132 or 0)
    local v135 = v133 or v7
    local v136 = drawLuckyToken(v18, v134, v135)
    if typeof(v136) == "string" then
        if v136 == "" then
            Warning:AtError():Log((("category draw came back empty, substituting %*"):format(v19)))
            return v19
        end
        return v136
    end
    Warning:AtError():Log((("category draw came back empty, substituting %*"):format(v19)))
    return v19
end

function v13.DrawCategoryForRarity(v137, v138, v139) -- line 347 | captures: PickWeightedWith, entriesAtRarity
    local v140 = PickWeightedWith(v139, (entriesAtRarity(v137, v138)))
    local v141 = if typeof(v140) == "string" then v140 ~= "" else false
    local v142 = ("%*: rarity %* produced no asset name"):format(v137, v138)
    assert(v141, v142)
    return v140
end

function v13.DrawCategoryFromRarityTable(v143, v144, v145) -- line 353 | captures: PickWeightedWith, v13
    local v146 = PickWeightedWith(v145, v144)
    local v147 = if typeof(v146) == "string" then v146 ~= "" else false
    local v148 = ("%*: rarity table produced no rarity token"):format(v143)
    assert(v147, v148)
    return v13.DrawCategoryForRarity(v143, v146, v145)
end

function v13.DrawCategoryFromTable(v149, v150, v151, v152) -- line 359 | captures: Assets, PickWeightedWith, v8, drawLuckyToken
    v8(v151)
    local v153 = v151 >= 1
    assert(v153, "A category draw needs at least one roll")
    local v154
    if v151 <= 1 then
        v154 = PickWeightedWith(v152, v150)
    else
        v154 = drawLuckyToken(v150, v151, v152)
    end
    local v155 = if typeof(v154) == "string" then v154 ~= "" else false
    local v156 = ("%*: drop table produced no name"):format(v149)
    assert(v155, v156)
    local v157 = Assets.AssetNameExists(v154)
    local v158 = ("%*: drop table named %*, which is not in the catalog"):format(v149, v154)
    assert(v157, v158)
    return v154
end

function v13.DrawMutations(v159, v160, v161, v162) -- line 375 | captures: PickWeightedWith, NO_MUTATION, v6, Warning, v25, v26, shiftedTowardsFlat, amplifyMutations
    local v163 = v161 or v6
    local v164 = shiftedTowardsFlat(v25, v160 or 0)
    if v162 ~= nil and v162 > 1 then
        v164 = amplifyMutations(v164, v162)
    end
    Warning:AtInfo():Log((("mutation draw, follow-up odds %*"):format(0.5)))
    local v165 = {}
    local v166 = PickWeightedWith(v163, v164)
    if typeof(v166) == "string" and v166 ~= NO_MUTATION then
        table.insert(v165, v166)
    end
    if #v165 > 0 and v163:NextNumber() < 0.5 then
        local v167 = PickWeightedWith(v163, v164)
        if typeof(v167) == "string" and v167 ~= NO_MUTATION and not table.find(v165, v167) then
            table.insert(v165, v167)
        end
    end
    table.sort(v165, function(v168, v169) -- line 399 | captures: v26
        return v26[v168].RollWeight < v26[v169].RollWeight
    end)
    return v165
end

function v13.DrawScale(v170, v171, v172, v173) -- line 405 | captures: v1, Constants, PickWeightedWith, AssetRollScaleWeights, v6, Warning, v14, shiftedTowardsFlat
    local v174 = shiftedTowardsFlat(v14, v171 or 0)
    local v175 = {}
    if v172 then
        if v173 then
            local v176 = {}
            local v177 = {}
            for v178, v179 in ipairs(v174) do
                local v180 = v179[1]
                if typeof(v180) == "table" then
                    v180 = v180[#v180]
                end
                if typeof(v180) ~= "number" then
                    v180 = nil
                end
                if v180 == nil then
                    local v181 = ("scale band %* has no numeric ceiling"):format(v178)
                    if Constants.IS_STUDIO then
                        error(v181)
                    else
                        Warning:AtWarning():Log(v181)
                    end
                elseif v172 <= v180 * v173 then
                    table.insert(v176, v179)
                    table.insert(v177, v178)
                end
            end
            if #v176 == 0 then
                return v172 / v173, #AssetRollScaleWeights
            end
            local v182
            if v6:NextInteger(1, 10) == 1 then
                if #v176 > 1 then
                    v182 = 2
                end
            else
                v182 = 1
            end
            local v183 = if v182 == 1 then 1 else #v176
            local v184 = {}
            for v185 = v182, v183 do
                local v186 = v176[v185]
                table.insert(v184, v186)
                local v187 = v177[v185]
                table.insert(v175, v187)
            end
        end
    else
        local v188, v189, v190, v191 = PickWeightedWith(nil, v174)
        _ = v189
        _ = v190
        if v188 then
            if typeof(v188) == "table" then
                v188 = v1:numberArray(v188)
            end
            if v175 then
                v191 = v175[v191] or v191
            end
            if typeof(v188) ~= "number" then
                v188 = 1
            end
            return v188, v191
        end
        Warning:AtError():Log("scale draw came back empty, substituting 1x")
        return 1, 1
    end
end

return v13
