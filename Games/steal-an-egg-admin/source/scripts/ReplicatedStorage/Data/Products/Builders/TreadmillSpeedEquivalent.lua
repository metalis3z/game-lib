-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.Interface)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

local function canPurchase(v2) -- line 13
    if v2 == nil then
        return false, "Player data is not loaded yet."
    end
    return true, nil
end

function v1.Create(v3, v4) -- line 19 | captures: ReplicatedStorage, ServerScriptService, TreadmillUtil, t, canPurchase
    t.strict(t.number)(v3)
    t.strict(t.number)(v4)
    local v5 = v3 > 0
    assert(v5, "Treadmill equivalent product id must be positive")
    local v6 = v4 > 0
    assert(v6, "Treadmill equivalent duration must be positive")
    local v7 = {
        Desc = "Instantly gain the speed you currently earn on your treadmill.",
        LockWhileProcessing = true,
        ProductId = v3,
        DisplayName = ("Speed - %*"):format((TreadmillUtil.FormatTreadmillSpeedEquivalentDuration(v4))),
        TreadmillSpeedEquivalentDurationSeconds = v4,
        ServerTest = function(v8) -- ServerTest | line 35 | captures: ServerScriptService, t, canPurchase
            t.strict(t.instanceIsA("Player"))(v8)
            local v9, v10 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(v8)
            if v9 then
                return canPurchase(v10)
            end
            return false, "Player data is not loaded yet."
        end,
        ClientTest = function() -- ClientTest | line 45 | captures: ReplicatedStorage, canPurchase
            local Save = require(ReplicatedStorage.Shared.Save)
            return canPurchase(Save.Get())
        end
    }

    function v7.Callback(v11) -- line 49 | captures: v4, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v11)
        local v12, v13 = require(ServerScriptService.Controllers.SpeedPowerService).AddTreadmillEquivalentSpeedPower(v11, v4)
        if v12 then
            require(ServerScriptService.Library.Functions.NotifyItem)(v11, {
                Kind = "SpeedPower",
                Amount = v13
            })
            return true, v13
        end
        return false, 0
    end

    return v7
end

return v1
