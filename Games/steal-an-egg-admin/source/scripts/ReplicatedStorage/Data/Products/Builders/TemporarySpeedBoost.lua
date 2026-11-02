-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)

local function canPurchaseTemporarySpeedBoost(v1) -- line 12
    if v1 == nil then
        return false, "Data not loaded"
    end
    return true
end

return function(v2, v3, v4) -- line 18 | captures: ReplicatedStorage, ServerScriptService, TreadmillUtil, t, canPurchaseTemporarySpeedBoost
    t.strict(t.string)(v2)
    t.strict(t.number)(v3)
    t.strict(t.number)(v4)
    local v5 = v4 > 0
    assert(v5, "Temporary speed boost duration must be positive")
    local v6 = TreadmillUtil.FormatTemporarySpeedBoostProductDuration(v4)
    local v7 = {
        LockWhileProcessing = true,
        ProductId = v3,
        DisplayName = ("x2 Speed Boost (%*)"):format(v6),
        Desc = ("Double all speed gains for %*."):format(v6),
        TemporarySpeedBoostDurationSeconds = v4,
        TemporarySpeedBoostMultiplier = TreadmillUtil.TEMPORARY_SPEED_BOOST_MULTIPLIER,
        ServerTest = function(v8) -- ServerTest | line 35 | captures: ServerScriptService, t, canPurchaseTemporarySpeedBoost
            t.strict(t.instanceIsA("Player"))(v8)
            local v9, v10 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(v8)
            if not v9 or not v10 then
                return false, "Player profile not found"
            end
            return canPurchaseTemporarySpeedBoost(v10)
        end,
        ClientTest = function() -- ClientTest | line 45 | captures: ReplicatedStorage, canPurchaseTemporarySpeedBoost
            local Save = require(ReplicatedStorage.Shared.Save)
            return canPurchaseTemporarySpeedBoost(Save.Get())
        end
    }

    function v7.Callback(v11) -- line 49 | captures: v4, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v11)
        return require(ServerScriptService.Controllers.SpeedPowerService).AddTemporarySpeedBoostDuration(v11, v4)
    end

    return v7
end
