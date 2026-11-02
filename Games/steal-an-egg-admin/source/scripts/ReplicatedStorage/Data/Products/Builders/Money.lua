-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Internal.ProductTypes)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local t = require(ReplicatedStorage.Packages.t)
return function(v1, v2) -- line 10 | captures: ReplicatedStorage, ServerScriptService, t
    t.strict(t.string)(v1)
    t.strict(t.number)(v2)
    local v3 = v1:gsub("Money_", ""):gsub("%D", "")
    local v4 = tonumber(v3)
    local v5 = v4 ~= nil
    assert(v5, "Money product name must include a numeric reward amount")
    local v6 = v4 > 0
    assert(v6, "Money reward must be positive")

    local function ensureDataLoaded(v7) -- line 21
        if v7 then
            return true
        end
        return false, "Player data is not loaded yet."
    end

    local v8 = {
        Desc = "Purchase bonus money!",
        LockWhileProcessing = true,
        ProductId = v2,
        DisplayName = v1
    }

    function v8.ServerTest(v9) -- line 32 | captures: ensureDataLoaded, ServerScriptService
        local v10, v11 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(v9)
        if v10 then
            return ensureDataLoaded(v11)
        end
        return false, "Failed to retrieve player data."
    end

    function v8.ClientTest() -- line 40 | captures: ensureDataLoaded, ReplicatedStorage
        return ensureDataLoaded((require(ReplicatedStorage.Shared.Save).Get()))
    end

    function v8.Callback(v12) -- line 43 | captures: v4, ServerScriptService
        require(ServerScriptService.Controllers.MoneyService).AddMoney(v12, v4, { source = "DevProduct" })
        return true
    end

    return v8
end
