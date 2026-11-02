-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Id = "string",
    HasStarted = "boolean",
    HasEnded = "boolean"
}

local function coerce(v2) -- line 8 | captures: v1
    local v3 = {}
    for v4, v5 in v1 do
        local v6 = if type(v2) == "table" then v2[v4] else nil
        if type(v6) == v5 then
            v3[v4] = v6
        else
            return nil
        end
    end
    return v3
end

local function countKeys(v8) -- line 28
    local v9 = 0
    for v10 in v8 do
        v9 += 1
    end
    return v9
end

local v11 = {
    PromptDelaySeconds = 300,
    RetryDelaySeconds = 30,
    MaxAttempts = 5,
    IsValidEventId = function(v12) -- IsValidEventId | line 42
        if type(v12) == "string" and #v12 > 0 then
            return #v12 <= 128
        end
        return false
    end,
    IsSafeToPrompt = function(v13, v14) -- IsSafeToPrompt | line 46
        return v13 and not v14
    end
}

function v11.IsReturningPlayer(v15, v16, v17) -- line 54
    local v18 = if v15 > 1 and v16 >= 0 then v16 <= v17 else false
    return v18 and v16 // 86400 < v17 // 86400
end

function v11.GetSoonestUnseenEvent(v19, v20) -- line 62 | captures: coerce
    local v21 = if type(v19) == "table" then v19 else {}
    for v22, v23 in v21 do
        local v24 = coerce(v23)
        local v25 = if v24 == nil then false else not v24.HasStarted and not v24.HasEnded
        if v25 and not v7[v24.Id] then
            return v24
        end
    end
    return nil
end

function v11.TryMarkSeen(v26, v27, v28) -- line 87
    if type(v27) == "string" and #v27 > 0 and #v27 <= 128 then
        local v29 = type(v27) == "string"
        assert(v29)
        local v30 = v26[v27] == true
        if not v30 then
            local v31 = 0
            for v32 in v26 do
                v31 += 1
            end
            v30 = v31 < v28
        end
        if v30 then
            v26[v27] = true
        else
            v26[v27] = v26[v27]
        end
        return v30
    end
    return false
end

return table.freeze(v11)
