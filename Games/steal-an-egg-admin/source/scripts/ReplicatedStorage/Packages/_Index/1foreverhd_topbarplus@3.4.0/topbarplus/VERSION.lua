-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    appVersion = "v3.4.0",
    latestVersion = nil
}

function v1.getLatestVersion() -- line 7 | captures: v1
    local latestVersion = v1.latestVersion
    if latestVersion then
        return latestVersion
    end
    local v2
    while true do
        local v3
        v3, v2 = pcall(function() -- line 14
            return game:GetService("MarketplaceService"):GetProductInfo(117501901079852)
        end)
        if not v3 then
            task.wait(1)
            continue
        end
        if v2 then
            break
        end
    end
    local v4 = string.match(v2.Name, "^TopbarPlus (.*)$")
    local v5 = v4 and v4:gsub("%s+", "")
    v1.latestVersion = v5
    return v5
end

function v1.getAppVersion() -- line 33 | captures: v1
    return v1.appVersion
end

function v1.isUpToDate() -- line 36 | captures: v1
    local v6 = v1.getLatestVersion()
    if v6 == nil then
        return false
    end
    return v6 == v1.getAppVersion()
end

return v1
