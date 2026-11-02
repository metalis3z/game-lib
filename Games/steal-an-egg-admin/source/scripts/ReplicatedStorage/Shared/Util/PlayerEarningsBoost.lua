-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Workspace = game:GetService("Workspace")
local v1 = {
    MULTIPLIER = 2,
    DURATION_SECONDS = 900,
    EXPIRES_AT_ATTRIBUTE = "EarningsBoostExpiresAt"
}

function v1.GetRemainingSecondsFromExpiry(v2, v3) -- line 11 | captures: Workspace
    if typeof(v2) == "number" then
        local v4 = v2 - (v3 or Workspace:GetServerTimeNow())
        return (math.max(0, v4))
    end
    return 0
end

function v1.GetRemainingSeconds(v5, v6) -- line 22 | captures: v1
    if v5 == nil then
        return 0
    end
    local EarningsBoostExpiresAt = v5:GetAttribute("EarningsBoostExpiresAt")
    return v1.GetRemainingSecondsFromExpiry(EarningsBoostExpiresAt, v6)
end

function v1.GetMultiplier(v7) -- line 29 | captures: v1
    if v1.GetRemainingSeconds(v7) > 0 then
        return v1.MULTIPLIER
    end
    return 1
end

local function GetChangedSignal(v8) -- line 36
    return v8:GetAttributeChangedSignal("EarningsBoostExpiresAt")
end

v1.GetChangedSignal = GetChangedSignal
return table.freeze(v1)
