-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Name = "json-array-decode",
    Description = "Decodes a JSON Array into a comma-separated list",
    Group = "DefaultUtil",
    Aliases = {}
}

v1.Args = {
    {
        Type = "json",
        Name = "JSON",
        Description = "The JSON array."
    }
}

function v1.ClientRun(v2, v3) -- line 11
    local v4 = if type(v3) == "table" then v3 else { v3 }
    return table.concat(v4, ",")
end

return v1
