-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local Players = game:GetService("Players");
require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local EliminationsDisplay = require(Players.LocalPlayer.PlayerScripts.Modules.EliminationsDisplay);
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

function u1._DisplayAdded(p4, p5) -- Line: 33
    -- upvalues: EliminationsDisplay (copy)
    table.insert(p4.Displays, EliminationsDisplay.new(p5));
end;

function u1._ClientFighterAdded(u6, p7) -- Line: 37
    p7.Elimination:Connect(function(...) -- Line: 38
        -- upvalues: u6 (copy)
        for _, v in pairs(u6.Displays) do
            v:NewElimination(...);
        end;
    end);
end;

function u1._Init(p8) -- Line: 45
end;

return u1._new();