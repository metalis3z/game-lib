-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function addToMap(v1, v2, v3) -- line 15
    local v4 = {}
    for v5, v6 in pairs(v1) do
        v4[v5] = v6
    end
    v4[v2] = v3
    return v4
end

local function removeFromMap(v7, v8) -- line 27
    local v9 = {}
    for v10, v11 in pairs(v7) do
        if v10 ~= v8 then
            v9[v10] = v11
        end
    end
    return v9
end

local function createSignal() -- line 39
    local v12 = {}
    return {
        subscribe = function(v13, v14) -- subscribe | line 42 | captures: v12
            local v15 = typeof(v14) == "function"
            assert(v15, "Can only subscribe to signals with a function.")
            local v16 = { callback = v14 }
            local v17 = v12
            local v18 = {}
            for v19, v20 in pairs(v17) do
                v18[v19] = v20
            end
            v18[v14] = v16
            v12 = v18

            local function disconnect() -- line 51 | captures: v14, v16, v12
                local v21 = not v16.disconnected
                assert(v21, "Listeners can only be disconnected once.")
                v16.disconnected = true
                local v22 = v12
                local v23 = {}
                for v24, v25 in pairs(v22) do
                    if v24 ~= v14 then
                        v23[v24] = v25
                    end
                end
                v12 = v23
            end

            return disconnect
        end,
        fire = function(v26, ...) -- fire | line 61 | captures: v12
            for v27, v28 in pairs(v12) do
                if not v28.disconnected then
                    v27(...)
                end
            end
        end
    }
end

return createSignal
