-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local DuelsDisplay = require(Players.LocalPlayer.PlayerScripts.Modules.DuelsDisplay);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 13
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Displays = {};
    v3:_Init();

    return v3;
end;

function u1._UpdateEnabled(p4) -- Line: 33
    -- upvalues: DuelController (copy), Players (copy)
    local v5 = not DuelController:GetDuel(Players.LocalPlayer);

    for _, v in pairs(p4.Displays) do
        v:SetEnabled(v5);
    end;
end;

function u1._DisplayAdded(p6, p7, p8) -- Line: 41
    -- upvalues: DuelsDisplay (copy)
    table.insert(p6.Displays, DuelsDisplay.new(p7));

    if not p8 then
        p6:_UpdateEnabled();
    end;
end;

function u1._Init(u9) -- Line: 49
    -- upvalues: DuelController (copy), CollectionService (copy)
    DuelController.LocalPlayerJoinedOrLeftDuel:Connect(function() -- Line: 54
        -- upvalues: u9 (copy)
        u9:_UpdateEnabled();
    end);
    CollectionService:GetInstanceAddedSignal("DuelsDisplay"):Connect(function(p10) -- Line: 58
        -- upvalues: u9 (copy)
        u9:_DisplayAdded(p10);
    end);

    for _, v in pairs(CollectionService:GetTagged("DuelsDisplay")) do
        u9:_DisplayAdded(v, true);
    end;

    u9:_UpdateEnabled();
end;

return u1._new();