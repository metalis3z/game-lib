-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 10
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "Lobby");
    v2.Play = require(script:WaitForChild("Play"));
    v2.Party = require(script:WaitForChild("Party"));
    v2.Buttons = require(script:WaitForChild("Buttons"));
    v2.Currency = require(script:WaitForChild("Currency"));
    v2.Requests = require(script:WaitForChild("Requests"));
    v2.Matchmaking = require(script:WaitForChild("Matchmaking"));
    v2.LocalFighter = nil;
    v2._duel_connections = {};
    v2:_Init();

    return v2;
end;

function u1._UpdateVisibility(p3) -- Line: 39
    -- upvalues: SpectateController (copy)
    local v4 = p3.LocalFighter and not (p3.LocalFighter:Get("IsInShootingRange") or p3.LocalFighter:Get("IsInDuel")) and not SpectateController.CurrentDuelSubject;
    p3.Play.Frame.Visible = v4;
    p3.Buttons.Frame.Visible = v4;
    p3.Currency.Frame.Visible = v4;
    p3.Requests.Frame.Visible = v4;
    p3.Party.BottomDisplayFrame.Visible = v4;
end;

function u1._UpdateCurrentDuelSubject(p5) -- Line: 49
    -- upvalues: SpectateController (copy)
    for _, v in pairs(p5._duel_connections) do
        v:Disconnect();
    end;

    p5._duel_connections = {};

    if SpectateController.CurrentDuelSubject then
        p5:_UpdateVisibility();

        return;
    end;

    p5:_UpdateVisibility();
end;

function u1._HookLocalFighter(u6) -- Line: 66
    -- upvalues: FighterController (copy)
    u6.LocalFighter = FighterController:WaitForLocalFighter();
    u6.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 69
        -- upvalues: u6 (copy)
        u6:_UpdateVisibility();
    end);
    u6.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 73
        -- upvalues: u6 (copy)
        u6:_UpdateVisibility();
    end);
    u6:_UpdateVisibility();
end;

function u1._Init(u7) -- Line: 80
    -- upvalues: SpectateController (copy)
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 81
        -- upvalues: u7 (copy)
        u7:_UpdateCurrentDuelSubject();
    end);
    u7:_UpdateVisibility();
    u7:_UpdateCurrentDuelSubject();
    task.spawn(u7._HookLocalFighter, u7);
end;

return u1._new();