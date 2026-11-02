-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = { "Created", "Initialized", "Started", "Destroyed" }

local function NewBootloader(v2) -- line 8 | captures: v1
    local v3 = {
        Stage = v1[1],
        Systems = {}
    }

    function v3.Destroy(v4) -- line 14 | captures: v3, v1
        local v5 = v3.Stage == v1[3]
        local v6 = ("Must be at stage %*."):format(v1[3])
        assert(v5, v6)
        v3.Stage = v1[4]
        for v7, v8 in ipairs(v3.Systems) do
            if v8.Destroy ~= nil then
                local spawn = task.spawn
                local v9 = v8
                spawn(function() -- line 20 | captures: v9
                    v9:Destroy()
                end)
            end
        end
    end

    function v3.Start(v10) -- line 27 | captures: v3, v1
        local v11 = v3.Stage == v1[2]
        local v12 = ("Must be at stage %*."):format(v1[2])
        assert(v11, v12)
        v3.Stage = v1[3]
        for v13, v14 in ipairs(v3.Systems) do
            if v14.Start ~= nil then
                local spawn = task.spawn
                local v15 = v14
                spawn(function() -- line 33 | captures: v15
                    v15:Start()
                end)
            end
        end
    end

    function v3.Initialize(v16) -- line 40 | captures: v2, v3, v1
        local function v17(v18, ...)
            table.insert(v18, ...)
        end

        local v19 = v3.Stage == v1[1]
        local v20 = ("Must be at stage %*."):format(v1[1])
        assert(v19, v20)
        v3.Stage = v1[2]
        for v21, v22 in ipairs(v2) do
            v17(v3.Systems, require(v22))
        end
    end

    return v3
end

return NewBootloader
