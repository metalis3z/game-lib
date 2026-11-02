local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

return {
    Desc = "Purchase the Strawberry Elephant CashGrab model!",
    LockWhileProcessing = true,
    ProductId = 3710700106,
    DisplayName = "Strawberry Elephant",
    ServerTest = function(player)
        local profile = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(player)
        if profile then
            return true
        end
        return false, "Player data is not loaded yet."
    end,
    ClientTest = function()
        local save = require(ReplicatedStorage.Library.Client.Save).Get()
        if save then
            return true
        end
        return false, "Save data is not loaded yet."
    end,
    Callback = function(player)
        -- Grant logic for CashGrab products is handled in Core_Purchases.grantProduct
        return true
    end,
}
