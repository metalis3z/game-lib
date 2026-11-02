-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local v1 = {
    Name = "json-array-encode",
    Description = "Encodes a comma-separated list into a JSON array",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "string",
            Name = "CSV",
            Description = "The comma-separated list"
        }
    }
}

function v1.Run(v2, v3) -- line 15 | captures: HttpService
    return HttpService:JSONEncode(v3:split(","))
end

return v1
