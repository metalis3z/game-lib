-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local Asserts = require(ReplicatedStorage.Library.Asserts);
require(script:FindFirstAncestor("Products").Types.Interface);

local function GetAreaEggs() -- Line: 10
    -- upvalues: ServerScriptService (copy)
    return require(ServerScriptService.Library.Controllers.AreaEggs);
end;

return {
    ProductId = 3710829104,
    DisplayName = "Take Anyway",
    Desc = "Steal the egg despite dying. Lol.",
    LockWhileProcessing = true,
    DisableNotification = true,

    ServerTest = function(p1: userdata) -- Line: 20, Name: ServerTest
        -- upvalues: Asserts (copy), ServerScriptService (copy)
        Asserts.Player(p1);

        return require(ServerScriptService.Library.Controllers.AreaEggs).CanPurchaseTakeAnyway(p1);
    end,

    ClientTest = function() -- Line: 24, Name: ClientTest
        -- upvalues: ReplicatedStorage (copy)
        if require(ReplicatedStorage.Library.Client.Save).Get() == nil then
            return false, "Data not loaded";
        end;

        return true;
    end,

    ReservePrompt = function(p2: userdata) -- Line: 31, Name: ReservePrompt
        -- upvalues: Asserts (copy), ServerScriptService (copy)
        Asserts.Player(p2);

        return require(ServerScriptService.Library.Controllers.AreaEggs).ReserveTakeAnyway(p2);
    end,

    CancelPrompt = function(p3: userdata) -- Line: 35, Name: CancelPrompt
        -- upvalues: Asserts (copy), ServerScriptService (copy)
        Asserts.Player(p3);
        require(ServerScriptService.Library.Controllers.AreaEggs).CancelTakeAnyway(p3);
    end,

    Callback = function(p4: userdata) -- Line: 39, Name: Callback
        -- upvalues: Asserts (copy), ServerScriptService (copy)
        Asserts.Player(p4);

        return require(ServerScriptService.Library.Controllers.AreaEggs).PurchaseTakeAnyway(p4);
    end
};