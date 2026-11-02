-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local t = require(ReplicatedStorage.Packages.t)
return function(v1, v2) -- line 11 | captures: ReplicatedStorage, ServerScriptService, Simple, t
    t.strict(t.string)(v1)
    t.strict(t.number)(v2)
    local v3 = v1:gsub("SpeedPower_", ""):gsub("%D", "")
    local v4 = tonumber(v3)
    local v5 = v4 ~= nil
    assert(v5, "Speed power product name must include a numeric reward amount")
    local v6 = v4 > 0
    assert(v6, "Speed power reward must be positive")

    local function ensureDataLoaded(v7) -- line 22
        if v7 then
            return true
        end
        return false, "Player data is not loaded yet."
    end

    local v8 = {
        Desc = "Purchase bonus speed!",
        LockWhileProcessing = true,
        ProductId = v2,
        DisplayName = ("+%* Speed"):format((Simple.FormatCompact(v4, ".#"))),
        SpeedPowerReward = v4
    }

    function v8.ServerTest(v9) -- line 34 | captures: ensureDataLoaded, ServerScriptService
        local v10, v11 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(v9)
        if v10 then
            return ensureDataLoaded(v11)
        end
        return false, "Failed to retrieve player data."
    end

    function v8.ClientTest() -- line 42 | captures: ensureDataLoaded, ReplicatedStorage
        return ensureDataLoaded((require(ReplicatedStorage.Shared.Save).Get()))
    end

    function v8.Callback(v12) -- line 45 | captures: v4, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v12)
        local Instant, Instant_2 = require(ServerScriptService.Controllers.SpeedPowerService).AddSpeedPower(v12, v4, "Instant")
        if Instant then
            task.spawn(function() -- line 53 | captures: v12, Instant_2, ServerScriptService
                require(ServerScriptService.Library.Functions.NotifyItem)(v12, {
                    Kind = "SpeedPower",
                    Amount = Instant_2
                })
            end)
            return true, Instant_2
        end
        return false, 0
    end

    return v8
end
