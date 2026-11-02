-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local t = require(ReplicatedStorage.Packages.t)
return function(v1, v2, v3) -- line 11 | captures: ReplicatedStorage, ServerScriptService, Treadmills, t
    t.strict(t.string)(v1)
    t.strict(t.string)(v2)
    t.strict(t.number)(v3)
    local v4, v5 = Treadmills.TreadmillNameExists(v2)
    local v6 = v5 or ("Treadmill \"%*\" does not exist"):format(v2)
    assert(v4, v6)
    local v7 = Treadmills.Directory[v2]
    local v8 = Treadmills.GetUpgradeLevel(v2)
    local v9 = v8 ~= nil
    local v10 = ("Treadmill \"%*\" has no upgrade level"):format(v2)
    assert(v9, v10)

    local function canBuyNextUpgrade(v11) -- line 29 | captures: v8
        if v11 + 1 == v8 then
            return true
        end
        return false, "This is not your next treadmill upgrade"
    end

    local v12 = {
        SinglePurchase = true,
        LockWhileProcessing = true,
        ProductId = v3,
        DisplayName = v7.DisplayName,
        Icon = v7.Icon,
        Desc = ("Upgrade to the %* treadmill."):format(v7.DisplayName)
    }

    function v12.ServerTest(v13) -- line 42 | captures: canBuyNextUpgrade, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v13)
        local v14, v15 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(v13)
        if not v14 or not v15 then
            return false, "Player profile not found"
        end
        return canBuyNextUpgrade(v15.TreadmillUpgradeLevel)
    end

    function v12.ResolveFailedReceipt(v16, v17, v18) -- line 52 | captures: v8, ServerScriptService
        local Database = require(ServerScriptService.Library.Database)
        if Database.IsPlayerLoaded(v16) then
            local v19, v20 = Database.UnsafeGetProfileAwait(v16)
            if not v19 or not v20 then
                return "Retry"
            end
            if v8 <= v20.TreadmillUpgradeLevel then
                return "Satisfied"
            end
            return "Credit"
        end
        return "Retry"
    end

    function v12.ClientTest() -- line 67 | captures: canBuyNextUpgrade, ReplicatedStorage
        local v21 = require(ReplicatedStorage.Shared.Save).Get()
        if v21 then
            return canBuyNextUpgrade(v21.TreadmillUpgradeLevel)
        end
        return false, "Data not loaded"
    end

    function v12.Callback(v22) -- line 74 | captures: v2, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v22)
        return require(ServerScriptService.Controllers.TreadmillService).UpgradeTreadmill(v22, v2, true)
    end

    return v12
end
