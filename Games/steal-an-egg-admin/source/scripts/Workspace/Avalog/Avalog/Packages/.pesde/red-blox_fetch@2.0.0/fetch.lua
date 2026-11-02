-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local Future = require(script.Parent.Future)

local function Json(v1) -- line 22 | captures: HttpService
    return pcall(HttpService.JSONDecode, HttpService, v1.Body)
end

return function(v2, v3) -- line 26 | captures: HttpService, Future, Json
    local v4 = v3 or {}
    local Body = v4.Body
    local v5
    if type(Body) == "table" then
        v5 = HttpService:JSONEncode(v4.Body)
    else
        v5 = v4.Body
    end
    return Future.Try(function(v6, v7) -- line 32 | captures: v2, HttpService, Json
        local v8 = {
            Url = v2,
            Method = v6.Method or "GET"
        }
        v8.Headers = v6.Headers or {}
        v8.Body = v7
        local v9 = HttpService:RequestAsync(v8)
        return {
            Body = v9.Body,
            Headers = v9.Headers,
            Status = v9.StatusCode,
            StatusText = v9.StatusMessage,
            Ok = v9.Success,
            Url = v2,
            Json = Json
        }
    end, v4, v5)
end
