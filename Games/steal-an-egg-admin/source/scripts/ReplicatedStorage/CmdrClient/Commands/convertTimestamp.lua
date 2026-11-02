-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Name = "convertTimestamp",
    Description = "Convert a timestamp to a human-readable format.",
    Group = "DefaultUtil",
    Aliases = { "date" }
}
local v2 = {}

v2[1] = {
    Type = "number",
    Name = "timestamp",
    Description = "A numerical representation of a specific moment in time.",
    Optional = true
}
v1.Args = v2

function v1.ClientRun(v3, v4) -- line 16
    local v5 = v4 or os.time()
    return (("%* %*"):format(os.date("%x", v5), (os.date("%X", v5))))
end

return v1
