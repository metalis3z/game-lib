-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local Keys = require(game.ReplicatedStorage.UserGenerated.Lang.Keys)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local JSONEncoder = require(game.ReplicatedStorage.UserGenerated.IO.JSONEncoder)
local v1 = {
    http = 80,
    https = 443
}
local v2 = Asserts.Optional(Asserts.Set(Keys(v1)))
local String = Asserts.String
local v4 = Asserts.Optional(Asserts.IntegerRange(0, 65535))

local function v3(v5) -- line 14
    if type(v5) ~= "string" then
        error("string", 2)
    end
    if not utf8.len(v5) then
        error("UTF8", 2)
    end
    if #v5 > 0 and string.byte(v5, 1) ~= 47 then
        error("PathPrefix", 2)
    end
    return v5
end

local v6 = Asserts.Map(Asserts.String, Asserts.Any)
local v7 = Asserts.Table({
    Protocol = v2,
    Host = String,
    Port = v4,
    Path = v3,
    Params = Asserts.Optional(v6),
    Fragment = Asserts.Optional(Asserts.String)
})
local v8 = {
    AssertProtocol = v2,
    AssertHost = String,
    AssertPort = v4,
    AssertPath = v3,
    AssertEncodeParams = v6,
    AssertParams = v7
}

function v8.EncodePath(v9) -- line 42 | captures: HttpService, Asserts
    Asserts.String(v9)
    return (v9:gsub("([^/]+)", function(v10) -- line 45 | captures: HttpService
        return HttpService:UrlEncode(v10)
    end))
end

function v8.EncodeParams(v11) -- line 50 | captures: HttpService, Keys, JSONEncoder, v6
    v6(v11)
    local v12 = Keys(v11)
    table.sort(v12)
    local v13 = {}
    for v14, v15 in ipairs(v12) do
        local v16 = HttpService:UrlEncode(v15) .. "=" .. HttpService:UrlEncode((JSONEncoder.Compact(v11[v15])))
        table.insert(v13, v16)
    end
    return table.concat(v13, "&")
end

function v8.Build(v17) -- line 63 | captures: HttpService, v1, v7, v8
    local function v18(v19, ...)
        table.insert(v19, ...)
    end

    local function v20(v21, ...)
        table.insert(v21, ...)
    end

    local function v22(v23, ...)
        table.insert(v23, ...)
    end

    v7(v17)
    local v24 = v17.Protocol or "https"
    local v25 = v1[v24] or 80
    local v26 = v17.Port or v25
    local v27 = {}
    table.insert(v27, v24)
    table.insert(v27, "://")
    local Host = v17.Host
    table.insert(v27, Host)
    if v26 ~= v25 then
        table.insert(v27, ":")
        local v28 = tostring(v26)
        table.insert(v27, v28)
    end
    v18(v27, v8.EncodePath(v17.Path))
    local Params = v17.Params
    if Params and next(Params) ~= nil then
        table.insert(v27, "?")
        v20(v27, v8.EncodeParams(Params))
    end
    if v17.Fragment then
        table.insert(v27, "#")
        v22(v27, HttpService:UrlEncode(v17.Fragment))
    end
    return table.concat(v27)
end

return table.freeze(v8)
