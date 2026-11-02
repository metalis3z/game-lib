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
        DisplayName = v1,
        ServerTest = function(v5) -- ServerTest | line 22 | captures: ServerScriptService
            return require(ServerScriptService.Controllers.ServerLuck).GetState().Multiplier > 1
        end,
        ResolveFailedReceipt = function(v6, v7, v8) -- ResolveFailedReceipt | line 26 | captures: ServerScriptService
            if require(ServerScriptService.Library.Database).IsPlayerLoaded(v6) then
                return "Credit"
            end
            return "Retry"
        end
    }

    function v4.Callback(v9) -- line 32 | captures: v3, ServerScriptService
        return require(ServerScriptService.Controllers.ServerLuck).AddTime(v3 * 60, v9)
    end

    return v4
end
