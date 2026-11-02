-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local PartyDisplay = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PartyDisplay"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: u1 (copy), UILibrary (copy), PartyDisplay (copy)
    local v2 = setmetatable({}, u1);
    v2.IsVisible = false;
    v2.Frame = UILibrary:GetTo("MainFrame", "Pages", "SideParty");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.LocalFighter = nil;
    v2.SidePartyDisplay = PartyDisplay.new(v2.Container, true);
    v2:_Init();

    return v2;
end;

function u1._UpdateVisibility(p3) -- Line: 36
    -- upvalues: Pages (copy)
    local v4 = Pages.PageSystem.CurrentPage and not Pages.PageSystem.CurrentPage.HidePartyDisplay and (p3.LocalFighter and not p3.LocalFighter:Get("IsInDuel")) and not p3.LocalFighter:Get("IsInShootingRange");
    p3.IsVisible = v4;
    p3.Container:TweenPosition(p3.IsVisible and UDim2.new(0.05, 0, 0.95, 0) or UDim2.new(-0.15, 0, 0.95, 0), "Out", "Quint", 0.25, true);
end;

function u1._HookLocalFighter(u5) -- Line: 43
    -- upvalues: FighterController (copy)
    u5.LocalFighter = FighterController:WaitForLocalFighter();
    u5.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 46
        -- upvalues: u5 (copy)
        u5:_UpdateVisibility();
    end);
    u5.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 50
        -- upvalues: u5 (copy)
        u5:_UpdateVisibility();
    end);
    u5:_UpdateVisibility();
end;

function u1._Init(u6) -- Line: 57
    -- upvalues: Pages (copy)
    Pages.PageSystem.PageOpened:Connect(function() -- Line: 58
        -- upvalues: u6 (copy)
        u6:_UpdateVisibility();
    end);
    Pages.PageSystem.PageClosed:Connect(function() -- Line: 62
        -- upvalues: u6 (copy)
        u6:_UpdateVisibility();
    end);
    u6:_UpdateVisibility();
    task.spawn(u6._HookLocalFighter, u6);
end;

return u1._new();