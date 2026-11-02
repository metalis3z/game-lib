-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Packages.Promise)
return function(v1, v2, v3, v4) -- line 8 | captures: Promise
    local v5 = v2 or 5
    local v6 = if v5 >= 1 then v5 % 1 == 0 else false
    assert(v6, "retry attempts must be a positive integer")
    local v7 = v3 == nil == (v4 == nil)
    assert(v7, "retry delay range needs both minimum and maximum")
    if v3 and v4 then
        local v8 = if v3 >= 0 then v3 <= v4 else false
        assert(v8, "invalid retry delay range")
    end
    return Promise.new(function(v9, v10) -- line 20 | captures: v1, v3, v4, v5
        local v11 = Random.new()
        local v12, v13
        for v14 = 1, v5 do
            local v15
            if v14 > 1 then
                local v16 = 2 ^ (v14 - 2)
                if v3 then
                    if v4 then
                        v16 = v11:NextNumber(v3 * v16, v4 * v16)
                    else
                        v16 = v12
                    end
                end
                task.wait(v16)
                v15 = v16
            else
                v15 = v12
            end
            local v17 = table.pack(pcall(v1))
            if v17[1] then
                local n = v17.n
                v9(table.unpack(v17, 2, n))
                return
            end
            v12 = v15
            v13 = v17[2]
        end
        v10((("gave up after %* attempts; last failure: %*"):format(v5, v13)))
    end)
end
