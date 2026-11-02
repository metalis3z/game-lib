-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local GlowyBackground = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy), UILibrary (copy), GlowyBackground (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "MainGlowyBackground");
    v2._glowy_background = GlowyBackground.new("MainGui");
    v2._current_duel_subject = nil;
    v2._current_duel_subject_connections = {};
    v2:_Init();

    return v2;
end;

function u1._Update(p3) -- Line: 37
    -- upvalues: MobileInputs (copy), Pages (copy), GuiService (copy)
    local v4 = p3._current_duel_subject and p3._current_duel_subject.DuelInterface and p3._current_duel_subject.DuelInterface.Voting:IsOpen();
    p3._glowy_background:SetBackdropTransparency(v4 and 0 or 1);
    p3._glowy_background:DisableElement("Black", MobileInputs.EditorEnabled);
    p3._glowy_background:SetEnabled(Pages.PageSystem.CurrentPage or MobileInputs.EditorEnabled or (GuiService.MenuIsOpen or v4));
    p3._glowy_background:SetBlurEnabled(not GuiService.MenuIsOpen);
end;

function u1._UpdateClientDuelSubject(u5) -- Line: 46
    -- upvalues: SpectateController (copy)
    for _, v in pairs(u5._current_duel_subject_connections) do
        v:Disconnect();
    end;

    u5._current_duel_subject_connections = {};
    u5._current_duel_subject = nil;

    if not SpectateController.CurrentDuelSubject then
        u5:_Update();

        return;
    end;

    u5._current_duel_subject = SpectateController.CurrentDuelSubject;
    table.insert(u5._current_duel_subject_connections, u5._current_duel_subject.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 61
        -- upvalues: u5 (copy)
        u5:_Update();
    end));
    u5:_Update();
end;

function u1._Setup(p6) -- Line: 68
    p6._glowy_background:SetParent(p6.Frame);
end;

function u1._Init(u7) -- Line: 72
    -- upvalues: Pages (copy), MobileInputs (copy), GuiService (copy), SpectateController (copy)
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 73
        -- upvalues: u7 (copy)
        u7:_Update();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 77
        -- upvalues: u7 (copy)
        u7:_Update();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 81
        -- upvalues: u7 (copy)
        u7:_Update();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 85
        -- upvalues: u7 (copy)
        u7:_UpdateClientDuelSubject();
    end);
    u7:_Setup();
    task.defer(u7._Update, u7);
    task.defer(u7._UpdateClientDuelSubject, u7);
end;

return u1._new();