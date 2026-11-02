-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function deepEqual(v1, v2) -- line 9 | captures: deepEqual
    if typeof(v1) == typeof(v2) then
        if typeof(v1) == "table" then
            local v3 = {}
            for v4, v5 in pairs(v1) do
                v3[v4] = true
                local v6, v7 = deepEqual(v5, v2[v4])
                if not v6 then
                    return false, (v7:gsub("{1}", ("{1}[%s]"):format((tostring(v4)))):gsub("{2}", ("{2}[%s]"):format((tostring(v4)))))
                end
            end
            for v8, v9 in pairs(v2) do
                if not v3[v8] then
                    local v10, v11 = deepEqual(v9, v1[v8])
                    if not v10 then
                        return false, (v11:gsub("{1}", ("{1}[%s]"):format((tostring(v8)))):gsub("{2}", ("{2}[%s]"):format((tostring(v8)))))
                    end
                end
            end
            return true
        end
        if v1 == v2 then
            return true
        end
        return false, "{1} ~= {2}"
    end
    return false, (("{1} is of type %s, but {2} is of type %s"):format(typeof(v1), (typeof(v2))))
end

local function assertDeepEqual(v12, v13) -- line 59 | captures: deepEqual
    local v14, v15 = deepEqual(v12, v13)
    if not v14 then
        local v16 = ("Values were not deep-equal.\n%s"):format((v15:gsub("{1}", "first"):gsub("{2}", "second")))
        error(v16, 2)
    end
end

return assertDeepEqual
