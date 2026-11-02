-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)

local function validateTier(v1, v2) -- line 13 | captures: TreadmillUtil
    if v1 == nil then
        return false, "Data not loaded"
    end
    local v3 = TreadmillUtil.ResolveSpeedBoostTierIndex(v1)
    if TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX <= v3 then
        return false, "Max speed boost owned"
    end
    if v2 == v3 + 1 then
        return true
    end
    return false, "Purchase the previous speed boost first"
end

return function(v4, v5, v6, v7) -- line 26 | captures: ReplicatedStorage, ServerScriptService, Constants, TreadmillUtil, t, validateTier
    t.strict(t.string)(v4)
    t.strict(t.number)(v5)
    t.strict(t.number)(v6)
    t.strict(t.number)(v7)
    if Constants.IS_STUDIO then
        local v8 = if v6 >= 1 then v6 <= TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX else false
        local v9 = ("Invalid speed boost tier index %*"):format(v6)
        assert(v8, v9)
        local v10 = TreadmillUtil.GetSpeedBoostMultiplierForTierIndex(v6) == v7
        local v11 = ("Invalid speed boost multiplier %* for tier %*"):format(v7, v6)
        assert(v10, v11)
    end
    local v12 = TreadmillUtil.FormatSpeedMultiplierValue(v7)
    local v13 = {
        SinglePurchase = true,
        LockWhileProcessing = true,
        ProductId = v5,
        DisplayName = ("%* Speed Boost"):format(v12),
        Desc = ("Upgrade your permanent speed boost to %*."):format(v12),
        SpeedBoostTierIndex = v6,
        SpeedBoostMultiplier = v7
    }

    function v13.ServerTest(v14) -- line 51 | captures: v6, ServerScriptService, t, validateTier
        t.strict(t.instanceIsA("Player"))(v14)
        local v15, v16 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(v14)
        if not v15 or not v16 then
            return false, "Player profile not found"
        end
        return validateTier(v16, v6)
    end

    function v13.ResolveFailedReceipt(v17, v18, v19) -- line 61 | captures: v6, ServerScriptService, TreadmillUtil
        local Database = require(ServerScriptService.Library.Database)
        if Database.IsPlayerLoaded(v17) then
            local v20, v21 = Database.UnsafeGetProfileAwait(v17)
            if not v20 or not v21 then
                return "Retry"
            end
            local v22 = TreadmillUtil.ResolveSpeedBoostTierIndex(v21)
            if v6 <= v22 then
                return "Satisfied"
            end
            return "Credit"
        end
        return "Retry"
    end

    function v13.ClientTest() -- line 77 | captures: v6, ReplicatedStorage, validateTier
        local Save = require(ReplicatedStorage.Shared.Save)
        return validateTier(Save.Get(), v6)
    end

    function v13.Callback(v23) -- line 81 | captures: v6, ServerScriptService, TreadmillUtil, t
        t.strict(t.instanceIsA("Player"))(v23)
        local v24, v25 = require(ServerScriptService.Library.Database).UpdateProfileImmutable(v23, function(v26) -- line 85 | captures: v6, TreadmillUtil
            local v27
            if v26 == nil then
                v27 = false
            else
                local v28 = TreadmillUtil.ResolveSpeedBoostTierIndex(v26)
                if v28 < TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX then
                    v27 = v6 == v28 + 1
                else
                    v27 = false
                end
            end
            if v27 then
                local v29 = table.clone(v26)
                v29.SpeedBoostTierIndex = v6
                return v29
            end
            return false
        end):await()
        if not v24 or not v25 then
            return false, "Purchase the previous speed boost first"
        end
        return true
    end

    return v13
end
