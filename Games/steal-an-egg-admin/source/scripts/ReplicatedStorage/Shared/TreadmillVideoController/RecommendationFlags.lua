-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local t = require(ReplicatedStorage.Packages.t)

local function typecheckAssertion(v1) -- line 9
    return function(v2) -- line 10 | captures: v1
        local v3, v4 = v1(v2)
        assert(v3, v4)
        return v2
    end
end

local function typecheckChecker(v5) -- line 17
    return function(v6) -- line 18 | captures: v5
        local v7, v8 = pcall(v5, v6)
        if v7 then
            return v7, nil
        end
        return v7, (tostring(v8))
    end
end

local v9 = t.intersection(t.numberMinExclusive((-1/0)), t.numberMaxExclusive((1/0)))
local v10 = t.intersection(v9, t.numberMin(0))
local v11 = t.intersection(v9, t.numberPositive)
local v12 = t.intersection(t.integer, t.numberMin(1))

local function typecheckSetAssertion(v13) -- line 34 | captures: t
    local v14 = t.valueOf(v13)
    return function(v15) -- line 36 | captures: v14
        local v16, v17 = v14(v15)
        assert(v16, v17)
        return v15
    end
end

local boolean = t.boolean
local v18 = FastFlags.Replicated("Game.TreadmillRecommendations.Enabled", function(v19) -- line 44 | captures: boolean
    local v20, v21 = boolean(v19)
    assert(v20, v21)
    return v19
end, false)
local v22 = t.valueOf({ "MaximizeEngagement", "MaximizeTimespent", "MaximizeReactions", "RecentlyAdded", "TreadmillFeedV1", "TreadmillFeedV2" })
local MaximizeEngagement = FastFlags.Replicated("Game.TreadmillRecommendations.ConfigName", function(v23) -- line 58 | captures: v22
    local v24, v25 = v22(v23)
    assert(v24, v25)
    return v23
end, "MaximizeEngagement")
local v26 = FastFlags.Replicated("Game.TreadmillRecommendations.PageSize", function(v27) -- line 64 | captures: v12
    local v28, v29 = v12(v27)
    assert(v28, v29)
    return v27
end, 20)
local v30 = FastFlags.Replicated("Game.TreadmillRecommendations.PrefetchMargin", function(v31) -- line 70 | captures: v12
    local v32, v33 = v12(v31)
    assert(v32, v33)
    return v31
end, 5)
local v34 = FastFlags.Replicated("Game.TreadmillRecommendations.PrefetchJitterSeconds", function(v35) -- line 76 | captures: v10
    local v36, v37 = v10(v35)
    assert(v36, v37)
    return v35
end, 10)
local v38 = FastFlags.Replicated("Game.TreadmillRecommendations.ConfigSwapSpreadSeconds", function(v39) -- line 82 | captures: v10
    local v40, v41 = v10(v39)
    assert(v40, v41)
    return v39
end, 60)
local v42 = FastFlags.Replicated("Game.TreadmillRecommendations.StaleSeconds", function(v43) -- line 88 | captures: v11
    local v44, v45 = v11(v43)
    assert(v44, v45)
    return v43
end, 900)
local v46 = FastFlags.Replicated("Game.TreadmillRecommendations.FetchRetryDelaySeconds", function(v47) -- line 94 | captures: v11
    local v48, v49 = v11(v47)
    assert(v48, v49)
    return v47
end, 5)
local v50 = FastFlags.Replicated("Game.TreadmillRecommendations.FailureCooldownSeconds", function(v51) -- line 100 | captures: v11
    local v52, v53 = v11(v51)
    assert(v52, v53)
    return v51
end, 30)
return table.freeze({
    Enabled = v18,
    ConfigName = MaximizeEngagement,
    PageSize = v26,
    PrefetchMargin = v30,
    PrefetchJitterSeconds = v34,
    ConfigSwapSpreadSeconds = v38,
    StaleSeconds = v42,
    FetchRetryDelaySeconds = v46,
    FailureCooldownSeconds = v50
})
