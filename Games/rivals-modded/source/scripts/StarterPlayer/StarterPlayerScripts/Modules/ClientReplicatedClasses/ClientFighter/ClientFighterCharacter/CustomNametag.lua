-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local LeaderboardController = require(Players.LocalPlayer.PlayerScripts.Controllers.LeaderboardController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.MobileInputs);
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Teleporting);
local Shutdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Shutdown);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local Nametag = require(Players.LocalPlayer.PlayerScripts.Modules.Nametag);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._destroyed = false;
    v3._nametag = nil;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6) -- Line: 33
end;

function u1.Destroy(p7) -- Line: 37
    p7._destroyed = true;

    if p7._nametag then
        p7._nametag:Destroy();
    end;
end;

function u1._Refresh(p8) -- Line: 49
    -- upvalues: Pages (copy), MobileInputs (copy), Teleporting (copy), Shutdown (copy), GuiService (copy), PlayerDataController (copy), Nametag (copy)
    if p8._nametag then
        p8._nametag:Destroy();
        p8._nametag = nil;
    end;

    if Pages.PageSystem.CurrentPage or (MobileInputs.EditorEnabled or (Teleporting.Enabled or (Shutdown.Enabled or (GuiService.MenuIsOpen or PlayerDataController:GetSetting("Hide HUD"))))) then
        return;
    end;

    if p8._destroyed or (not p8.ClientFighterCharacter:IsInWorld() or (p8.ClientFighterCharacter.ClientFighter:IsActuallyFirstPerson() or p8.ClientFighterCharacter.ClientFighter:Get("IsInDuel"))) then
        return;
    end;

    p8._nametag = Nametag.new(p8.ClientFighterCharacter.Player, p8.ClientFighterCharacter.ClientFighter:Get("Controls"), p8.ClientFighterCharacter.ClientFighter.Player:GetAttribute("StatisticDuelsWinStreak"), p8.ClientFighterCharacter.ClientFighter.Player:GetAttribute("Level"), p8.ClientFighterCharacter.ClientFighter.Player:GetAttribute("DisplayELO"), p8.ClientFighterCharacter.ClientFighter.Player:GetAttribute("PlayerStatus"), p8.ClientFighterCharacter.ClientFighter:Get("IsMatchmaking"));
    p8._nametag:SetParent(p8.ClientFighterCharacter.RootPart);
end;

function u1._Init(u9) -- Line: 69
    -- upvalues: PlayerDataController (copy), LeaderboardController (copy), CameraController (copy), Pages (copy), MobileInputs (copy), Teleporting (copy), Shutdown (copy), GuiService (copy)
    u9.ClientFighterCharacter.EnteredWorld:Connect(function() -- Line: 70
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end);
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsSpectating"):Connect(function() -- Line: 74
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 78
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("Controls"):Connect(function() -- Line: 82
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 86
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsMatchmaking"):Connect(function() -- Line: 90
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter.Player:GetAttributeChangedSignal("StatisticDuelsWinStreak"):Connect(function() -- Line: 94
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter.Player:GetAttributeChangedSignal("Level"):Connect(function() -- Line: 98
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter.Player:GetAttributeChangedSignal("DisplayELO"):Connect(function() -- Line: 102
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(u9.ClientFighterCharacter.ClientFighter.Player:GetAttributeChangedSignal("PlayerStatus"):Connect(function() -- Line: 106
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(PlayerDataController:GetSettingChangedSignal("Hide HUD"):Connect(function() -- Line: 110
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(PlayerDataController:GetSettingChangedSignal("PlayerList Leaderstat"):Connect(function() -- Line: 114
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(LeaderboardController:GetLeaderboardRefreshedSignal("Highest ELO"):Connect(function() -- Line: 118
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(CameraController.StateChanged:Connect(function() -- Line: 122
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(Pages.PageSystem.PagesActivity:Connect(function() -- Line: 126
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 130
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(Teleporting.EnabledChanged:Connect(function() -- Line: 134
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(Shutdown.EnabledChanged:Connect(function() -- Line: 138
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9.ClientFighterCharacter:AddConnection(GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 142
        -- upvalues: u9 (copy)
        u9:_Refresh();
    end));
    u9:_Refresh();
end;

return u1;