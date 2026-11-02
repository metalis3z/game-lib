-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local SchemaFields = require(script.Parent.SchemaFields)
return function(v1, v2) -- line 7 | captures: SchemaFields
    if typeof(v1) == "table" then
        local v3 = typeof(v2) ~= "table"
        for v4 in SchemaFields do
            local v5 = SchemaFields[v4]
            local v6 = v1[v4]
            if v5 ~= nil and (v3 or v6 ~= v2[v4]) then
                local v7, v8 = v5(v6)
                if not v7 then
                    return false, (("profile field %* was refused: %*"):format(v4, v8 or "shape does not match"))
                end
            end
        end
        return true
    end
    return false, "a profile update has to be a table"
end
