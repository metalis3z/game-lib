-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
return function(v1) -- line 7 | captures: HttpService
    v1:RegisterType("json", {
        Validate = function(v2) -- Validate | line 9 | captures: HttpService
            return pcall(HttpService.JSONDecode, HttpService, v2)
        end,
        Parse = function(v3) -- Parse | line 12 | captures: HttpService
            return HttpService:JSONDecode(v3)
        end
    })
end
