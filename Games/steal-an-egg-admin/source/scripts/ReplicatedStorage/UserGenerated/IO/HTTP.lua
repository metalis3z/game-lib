-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Asserts.Set({ "GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS", "TRACE", "PATCH" })
local v2 = Asserts.Optional(Asserts.Enum(Enum.HttpCompression))
local v3 = Asserts.Table({
    Url = Asserts.String,
    Method = v1,
    Headers = Asserts.Optional(Asserts.Map(Asserts.String, Asserts.String)),
    Body = Asserts.Optional(Asserts.RawString),
    Compress = v2,
    NoCache = Asserts.Optional(Asserts.Boolean)
})
local freeze = table.freeze
local v4 = {
    AssertCompress = v2,
    AssertMethod = v1,
    AssertParams = v3
}

function v4.Execute(v5) -- line 31 | captures: HttpService, v3
    v3(v5)
    local v6 = v5.Headers or {}
    if v5.NoCache then
        v6 = table.clone(v6)
        v6["Cache-Control"] = "no-cache, no-store, must-revalidate"
        v6.Pragma = "no-cache"
        v6.Expires = "0"
    end
    local v7, v8 = pcall(HttpService.RequestAsync, HttpService, {
        Url = v5.Url,
        Method = v5.Method,
        Headers = v6,
        Body = v5.Body,
        Compress = v5.Compress
    })
    if v7 then
        return v8
    end
    return {
        Success = false,
        StatusCode = 400,
        StatusMessage = tostring(v8),
        Headers = {}
    }
end

return freeze(v4)
