-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = require("./task")

return {
    exponential_backoff = function(v2) -- exponential_backoff | line 5 | captures: v1
        local v3
        local v4 = 3
        while true do
            local pcall_2 = pcall
            if pcall_2(function() -- line 10 | captures: v3, v2
                    v3 = { v2() }
                end) then
                break
            end
            v1.wait(v4)
            v4 *= 2
        end
        local v5 = v3
        return unpack(v5)
    end,
    regular_retry = function(v6, v7, v8) -- regular_retry | line 25 | captures: v1
        local v9 = 0
        local v10
        local v11
        while v10 ~= true do
            if v9 == v8 then
                break
            end
            v10, v11 = pcall(function() -- line 31 | captures: v6
                return { v6() }
            end)
            v9 += 1
            v1.wait(1)
        end
        return unpack(v11)
    end
}
