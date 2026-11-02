-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    new = function(v1) -- new | line 7
        local v2 = {}
        local v3 = {}
        v2.__index = v3
        if v1 then
            for v4, v5 in pairs(getmetatable(v1).__index) do
                v3[v4] = v5
            end
        end

        function v2.__newindex(v6, v7, v8) -- line 17 | captures: v3
            local function v9(v10, ...)
                assert(v10, ...)
            end

            v9(v3[v7] == nil, string.format("Cannot reassign %s in context", (tostring(v7))))
            v3[v7] = v8
        end

        local v11 = {}
        return (setmetatable(v11, v2))
    end
}
