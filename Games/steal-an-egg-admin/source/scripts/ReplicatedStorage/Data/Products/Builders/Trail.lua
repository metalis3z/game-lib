-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.Interface)
local Trails = require(ReplicatedStorage.Data.Trails)
local t = require(ReplicatedStorage.Packages.t)
return function(v1, v2, v3) -- line 12 | captures: ReplicatedStorage, ServerScriptService, Trails, t
    t.strict(t.string)(v1)
    t.strict(t.string)(v2)
    t.strict(t.number)(v3)
    local v4, v5 = Trails.TrailNameExists(v2)
    local v6 = v5 or ("Trail \"%*\" does not exist"):format(v2)
    assert(v4, v6)
    local v7 = Trails.Directory[v2]

    local function validateData(v8) -- line 27 | captures: v2
        if v8 then
            if v8.TrailInventory[v2] then
                return false, "You already own this trail"
            end
            return true
        end
        return false, "Player data not found"
    end

    local v9 = {
        SinglePurchase = true,
        LockWhileProcessing = true,
        ProductId = v3,
        DisplayName = v7.DisplayName,
        Icon = v7.Icon,
        Desc = ("Unlock the %* trail."):format(v7.DisplayName)
    }

    function v9.ServerTest(v10) -- line 43 | captures: validateData, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v10)
        local v11, v12 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(v10)
        if not v11 or not v12 then
            return false, "Player profile not found"
        end
        return validateData(v12)
    end

    function v9.ResolveFailedReceipt(v13, v14, v15) -- line 53 | captures: v2, ServerScriptService
        local Database = require(ServerScriptService.Library.Database)
        if Database.IsPlayerLoaded(v13) then
            local v16, v17 = Database.UnsafeGetProfileAwait(v13)
            if not (not v16 or not v17) and v17.TrailInventory[v2] then
                return "Satisfied"
            end
        end
        return "Retry"
    end

    function v9.ClientTest() -- line 68 | captures: validateData, ReplicatedStorage
        local v18 = require(ReplicatedStorage.Shared.Save).Get()
        if v18 then
            return validateData(v18)
        end
        return false, "Data not loaded"
    end

    function v9.Callback(v19) -- line 75 | captures: v2, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v19)
        return require(ServerScriptService.Controllers.TrailShop).GrantOwnedTrail(v19, v2, true)
    end

    return v9
end
