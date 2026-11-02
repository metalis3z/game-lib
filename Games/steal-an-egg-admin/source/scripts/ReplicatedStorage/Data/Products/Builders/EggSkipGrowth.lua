-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Timecode = require(ReplicatedStorage.Shared.Utils.Time).Timecode
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

function v1.Create(v2, v3, v4) -- line 12 | captures: ReplicatedStorage, ServerScriptService, Timecode, t
    t.strict(t.string)(v2)
    t.strict(t.number)(v3)
    t.strict(t.intersection(t.integer, t.numberPositive))(v4)
    local v5 = {
        LockWhileProcessing = true,
        DisableNotification = true,
        ProductId = v3,
        DisplayName = v2,
        Desc = ("Skip the growth of your egg by %*!"):format((Timecode(v4))),
        EggSkipGrowthMaxRemainingSeconds = v4
    }

    function v5.ReservePrompt(v6) -- line 26 | captures: v2, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v6)
        return require(ServerScriptService.Controllers.Eggs).ReserveSkipGrowthPrompt(v6, v2)
    end

    function v5.CancelPrompt(v7) -- line 31 | captures: v2, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v7)
        require(ServerScriptService.Controllers.Eggs).CancelSkipGrowthPrompt(v7, v2)
    end

    function v5.ServerTest(v8, v9) -- line 36 | captures: v2, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v8)
        local Eggs = require(ServerScriptService.Controllers.Eggs)
        if v9 == nil then
            return Eggs.CanPurchaseSkipGrowth(v8, v2)
        end
        return Eggs.CanRedeemSkipGrowth(v8, v2)
    end

    function v5.ResolveFailedReceipt(v10, v11, v12) -- line 45 | captures: ServerScriptService
        if require(ServerScriptService.Library.Database).IsPlayerLoaded(v10) then
            return "Credit"
        end
        return "Retry"
    end

    function v5.ClientTest() -- line 51 | captures: ReplicatedStorage
        return require(ReplicatedStorage.Client.EggState).MayBuyChosenSkip()
    end

    function v5.Callback(v13) -- line 54 | captures: v2, ServerScriptService, t
        t.strict(t.instanceIsA("Player"))(v13)
        return require(ServerScriptService.Controllers.Eggs).PurchaseSkipGrowth(v13, v2)
    end

    return v5
end

return v1
