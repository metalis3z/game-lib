-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CurrencyLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Pages = p2;
    v3.Frame = v3.Pages.Frame:WaitForChild("Currency");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.WeaponKeysFrame = v3.Container:WaitForChild("WeaponKeys");
    v3.EventCurrencyFrame = v3.Container:WaitForChild("EventCurrency");
    v3.EventCurrencyHeaderIcon = v3.EventCurrencyFrame:WaitForChild("Header"):WaitForChild("Icon");
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 30
end;

function u1.Close(p5) -- Line: 34
end;

function u1.Setup(p6) -- Line: 38
    -- upvalues: EventLibrary (copy)
    for i = 1, 5 do
        local v7 = "keybundle_" .. i;
        p6.Pages.Shop:CreateBundleSlot(v7):SetParent(p6.WeaponKeysFrame:WaitForChild(v7));
        local _ = i;
    end;

    if EventLibrary.IS_ACTIVE then
        for i = 1, 5 do
            local v8 = "eventcurrencybundle_" .. i;
            p6.Pages.Shop:CreateBundleSlot(v8):SetParent(p6.EventCurrencyFrame:WaitForChild(v8));
            local _ = i;
        end;
    end;
end;

function u1._UpdateEvent(p9) -- Line: 56
    -- upvalues: EventLibrary (copy), PlayerDataController (copy)
    local v10 = EventLibrary.IS_ACTIVE and PlayerDataController:GetStatistic("StatisticDuelsPlayed") >= EventLibrary.NUM_GAMES_NEEDED_TO_PARTICIPATE;
    p9.EventCurrencyFrame.Visible = v10;
    p9.Frame.Size = UDim2.new(1, 0, v10 and 2.35 or 1, 0);
end;

function u1._Setup(p11) -- Line: 63
    -- upvalues: EventLibrary (copy)
    p11.EventCurrencyHeaderIcon.Image = EventLibrary.EVENT_DETAILS.CURRENCY_IMAGE_FLAT;
end;

function u1._Init(u12) -- Line: 67
    -- upvalues: PlayerDataController (copy)
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 68
        -- upvalues: u12 (copy)
        u12:_UpdateEvent();
    end);
    u12:_Setup();
    u12:_UpdateEvent();
end;

return u1;