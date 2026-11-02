-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.Types.AssetItem)
local RarityNumber = require(ReplicatedStorage.Data.Rarity).Rarities.Secret.RarityNumber
local v1 = {}
local v2 = CFrame.new(-17.4227905, 1.14494324, -23.6600342)
local v3 = CFrame.new(-13.1647339, 1.14494324, -28.0780945)
local v4 = CFrame.new(-7.01275635, 1.14494324, -31.1100464)
local v5 = CFrame.new(7.54925537, 1.79094315, -31.1380615)
local v6 = CFrame.new(13.3172607, 1.14494324, -28.1280518)

v1[1] = v2
v1[2] = v3
v1[3] = v4
v1[4] = v5
v1[5] = v6
v1[6] = CFrame.new(17.959259, 1.14494324, -24.9380493)

local v7 = {}

local function qualifies(v8) -- line 23 | captures: Assets
    local v9 = Assets.Directory[v8]
    local v10 = v9 and v9.LuckyBlockDropTable or nil
    if typeof(v10) == "table" then
        return #v10 > 0
    end
    return false
end

local function stampOf(v11, v12) -- line 37
    local SpecialLuckyBlockCapturedAt = v12.SpecialLuckyBlockCapturedAt
    if typeof(SpecialLuckyBlockCapturedAt) == "number" then
        return SpecialLuckyBlockCapturedAt
    end
    return string.byte(v11, 1) or 0
end

local function shelfOf(v13) -- line 44
    local SpecialLuckyBlockColumn = v13.SpecialLuckyBlockColumn
    if typeof(SpecialLuckyBlockColumn) == "number" and SpecialLuckyBlockColumn >= 1 and SpecialLuckyBlockColumn <= 6 then
        return SpecialLuckyBlockColumn
    end
    return nil
end

local function olderFirst(v14, v15) -- line 52
    local SpecialLuckyBlockCapturedAt = v14.data.SpecialLuckyBlockCapturedAt
    if typeof(SpecialLuckyBlockCapturedAt) ~= "number" then
        local uid = v14.uid
        SpecialLuckyBlockCapturedAt = string.byte(uid, 1) or 0
    end
    local SpecialLuckyBlockCapturedAt_2 = v15.data.SpecialLuckyBlockCapturedAt
    if typeof(SpecialLuckyBlockCapturedAt_2) ~= "number" then
        local uid = v15.uid
        SpecialLuckyBlockCapturedAt_2 = string.byte(uid, 1) or 0
    end
    if SpecialLuckyBlockCapturedAt == SpecialLuckyBlockCapturedAt_2 then
        return v14.uid < v15.uid
    end
    return SpecialLuckyBlockCapturedAt < SpecialLuckyBlockCapturedAt_2
end

function v7.MatchesCategory(v16) -- line 73 | captures: Assets
    local v17 = Assets.Directory[v16]
    local v18 = v17 and v17.LuckyBlockDropTable or nil
    if typeof(v18) == "table" then
        return #v18 > 0
    end
    return false
end

function v7.Matches(v19) -- line 87 | captures: Assets
    local v20 = Assets.Directory[v19.Category]
    local v21 = v20 and v20.LuckyBlockDropTable or nil
    if typeof(v21) == "table" then
        return #v21 > 0
    end
    return false
end

local function Capacity() -- line 101
    return 36
end

v7.Capacity = Capacity

function v7.ProgressGoalForCategory(v22) -- line 104 | captures: Assets, RarityNumber
    local Rarity = Assets.Directory[v22].Rarity
    local v23 = Rarity and Rarity.RarityNumber
    local v24 = typeof(v23) == "number"
    local v25 = ("Special lucky block \"%*\" has no rarity rank"):format(v22)
    assert(v24, v25)
    if v23 < RarityNumber then
        return 1
    end
    if v23 == RarityNumber then
        return 2
    end
    return 3
end

function v7.ProgressGoalFor(v26) -- line 120 | captures: v7
    return v7.ProgressGoalForCategory(v26.Category)
end

function v7.CountHeld(v27) -- line 123 | captures: v7
    local v28 = 0
    for v29, v30 in pairs(v27) do
        local v31 = if v7.Matches(v30) then 1 else 0
        v28 += v31
    end
    return v28
end

function v7.NextOpenColumn(v32, v33) -- line 136 | captures: v7
    local v34 = {}
    local SpecialLuckyBlockColumn
    for v35, v36 in pairs(v32) do
        if v35 == v33 then
            SpecialLuckyBlockColumn = nil
        elseif v7.Matches(v36) then
            SpecialLuckyBlockColumn = v36.SpecialLuckyBlockColumn
            if not (typeof(SpecialLuckyBlockColumn) == "number" and SpecialLuckyBlockColumn >= 1 and SpecialLuckyBlockColumn <= 6) then
                SpecialLuckyBlockColumn = nil
            end
        end
        if SpecialLuckyBlockColumn ~= nil then
            v34[SpecialLuckyBlockColumn] = (v34[SpecialLuckyBlockColumn] or 0) + 1
        end
    end
    local v37
    local v38 = (1/0)
    for v39 = 1, 6 do
        local v40 = v34[v39] or 0
        if v40 < 6 and v40 < v38 then
            v37 = v39
            v38 = v40
        end
    end
    return v37
end

function v7.BuildLayout(v41, v42) -- line 169 | captures: v1, v7, olderFirst
    local v43 = {}
    for v44, v45 in pairs(v41) do
        local SpecialLuckyBlockColumn
        if v7.Matches(v45) then
            SpecialLuckyBlockColumn = v45.SpecialLuckyBlockColumn
            if not (typeof(SpecialLuckyBlockColumn) == "number" and SpecialLuckyBlockColumn >= 1 and SpecialLuckyBlockColumn <= 6) then
                SpecialLuckyBlockColumn = nil
            end
        end
        if SpecialLuckyBlockColumn ~= nil then
            local v46 = v43[SpecialLuckyBlockColumn] or {}
            v43[SpecialLuckyBlockColumn] = v46
            v46[#v46 + 1] = {
                uid = v44,
                data = v45
            }
        end
    end
    local v47 = {}
    for v48 = 1, 6 do
        local v49 = v43[v48]
        if v49 ~= nil then
            table.sort(v49, olderFirst)
            local v50 = #v49
            local v51 = math.min(v50, 6)
            for v52 = 1, v51 do
                local v53 = Vector3.new(0, 1, 0) * ((v52 - 1) * 6)
                v47[#v47 + 1] = {
                    uid = v49[v52].uid,
                    data = v49[v52].data,
                    column = v48,
                    row = v52,
                    cframe = v42 * v1[v48] + v53
                }
            end
        end
    end
    return v47
end

return v7
