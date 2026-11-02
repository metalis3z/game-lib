-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(...)
    assert(...)
end

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local JobId = game.JobId

if #JobId == 0 then
    v1(RunService:IsStudio())
    if RunService:IsServer() then
        local v2 = HttpService:GenerateGUID(false):lower()
        script:SetAttribute("Studio", v2)
        return v2
    end
    local Studio
    while true do
        Studio = script:GetAttribute("Studio")
        if type(Studio) == "string" then
            break
        end
        task.wait()
    end
    return Studio
end

if JobId == "00000000-0000-0000-0000-000000000000" then
    return
end
return JobId
