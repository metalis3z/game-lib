-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage.Packages.t)
return function(v1, v2, v3) -- line 10 | captures: ServerScriptService, t
    t.strict(t.string)(v1)
    t.strict(t.number)(v2)
    t.strict(t.number)(v3)
    local v4 = {
        LockWhileProcessing = true,
        DisableNotification = true,
        ProductId = v2,
        DisplayName = v1
    }

    function v4.Callback(v5) -- line 22 | captures: v3, ServerScriptService
        require(ServerScriptService.Controllers.ServerLuck).HandlePurchase(v3, v5)
        return true
    end

    function v4.ServerTest(v6) -- line 26 | captures: v3, ServerScriptService
        if v3 <= require(ServerScriptService.Controllers.ServerLuck).GetState().Multiplier then
            return false, "Server already has equal or better luck"
        end
        return true
    end

    function v4.ResolveFailedReceipt(v7, v8, v9) -- line 32 | captures: ServerScriptService
        if require(ServerScriptService.Library.Database).IsPlayerLoaded(v7) then
            return "Credit"
        end
        return "Retry"
    end

    return v4
end
