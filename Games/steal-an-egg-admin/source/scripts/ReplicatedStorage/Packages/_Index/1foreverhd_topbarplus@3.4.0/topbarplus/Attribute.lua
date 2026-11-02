-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

task.defer(function() -- line 6
    local RunService = game:GetService("RunService")
    local VERSION = require(script.Parent.VERSION)
    local v1 = VERSION.getLatestVersion()
    if not RunService:IsStudio() then
        print((("\240\159\141\141 Running TopbarPlus %* by @ForeverHD & HD Admin"):format((VERSION.getAppVersion()))))
    end
    if not VERSION.isUpToDate() then
        warn((("A new version of TopbarPlus (%*) is available: https://devforum.roblox.com/t/topbarplus/1017485"):format(v1)))
    end
end)
return {}
