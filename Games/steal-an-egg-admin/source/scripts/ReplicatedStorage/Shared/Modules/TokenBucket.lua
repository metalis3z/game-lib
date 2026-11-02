-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

local function accrualsFor(v2, v3) -- line 7
    local v4 = v2.accruals[v3]
    if v4 then
        return v4
    end
    local v5 = {}
    for v6, v7 in ipairs(v2.accrualTemplate) do
        local v8 = {
            credit = 0,
            tokens = v7.tokens,
            interval = v7.interval
        }
        table.insert(v5, v8)
    end
    v2.accruals[v3] = v5
    return v5
end

local function harvest(v9, v10, v11) -- line 19
    local v12 = 0
    for v13, v14 in ipairs(v10) do
        local v15 = v14.credit + v11
        local v16 = v9.maxTokens / (v14.tokens / v14.interval)
        local v17 = math.min(v15, v16)
        local v18 = v17 / v14.interval
        local v19 = math.floor(v18)
        if v19 > 0 then
            v12 += v19 * v14.tokens
            local v20 = v19 * v14.interval
            v14.credit = math.fmod(v17, v20)
        else
            v14.credit = v17
        end
    end
    return v12
end

function v1.Build(v21, v22) -- line 34
    local MaximumTokens = v22.MaximumTokens
    local v23 = ("endpoint %* has no MaximumTokens"):format(v21)
    assert(MaximumTokens, v23)
    if v22.InitialTokens then
        local v24 = v22.InitialTokens <= v22.MaximumTokens
        local v25 = ("endpoint %* starts above its own ceiling"):format(v21)
        assert(v24, v25)
    end
    local v26 = {}
    local v27 = v22.Refresh or {}
    for v28, v29 in ipairs(v27) do
        local v30 = v29.Tokens > 0
        local v31 = ("a refresh rule on %* grants no tokens"):format(v21)
        assert(v30, v31)
        local v32 = v29.Interval > 0
        local v33 = ("a refresh rule on %* has no interval"):format(v21)
        assert(v32, v33)
        local v34 = {
            tokens = v29.Tokens,
            interval = v29.Interval
        }
        table.insert(v26, v34)
    end
    table.freeze(v26)
    local v35 = {
        name = v21,
        maxTokens = v22.MaximumTokens
    }
    v35.initialTokens = v22.InitialTokens or v22.MaximumTokens
    v35.causesBan = v22.Ban == true
    v35.accrualTemplate = v26
    v35.tokens = {}
    v35.stamps = {}
    v35.accruals = {}
    return v35
end

function v1.Spend(v36, v37) -- line 69 | captures: accrualsFor, harvest
    local v38 = workspace:GetServerTimeNow()
    if not v36.stamps[v37] then
        v36.stamps[v37] = v38
    end
    if not v36.tokens[v37] then
        v36.tokens[v37] = v36.initialTokens
    end
    local v39 = accrualsFor(v36, v37)
    local v40 = v36.tokens[v37]
    local v41 = v38 - v36.stamps[v37]
    local v42 = harvest(v36, v39, (math.max(v41, 0)))
    local v43 = v40 + v42 >= 1
    local v44 = v40 + v42
    local maxTokens = v36.maxTokens
    local v45 = math.min(v44, maxTokens)
    if v43 then
        v45 -= 1
    end
    local tokens = v36.tokens
    local maxTokens_2 = v36.maxTokens
    tokens[v37] = math.clamp(v45, -1, maxTokens_2)
    v36.stamps[v37] = v38
    return v43
end

function v1.Forget(v46, v47) -- line 90
    v46.stamps[v47] = nil
    v46.tokens[v47] = nil
    v46.accruals[v47] = nil
end

return v1
