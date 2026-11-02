-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 14
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.MainFrame = UILibrary:GetTo("MainFrame");
    v2:_Init();

    return v2;
end;

function u1._UpdateSize(p3) -- Line: 34
    -- upvalues: PlayerDataController (copy), Pages (copy), ControlsController (copy), Players (copy)
    local Setting = PlayerDataController:GetSetting("Padded HUD");
    local v4 = not Pages.PageSystem.CurrentPage;

    if v4 then
        if Setting == "Always On" then
            v4 = true;
        elseif Setting == "Using Controller" then
            v4 = ControlsController.CurrentControls == "Gamepad";
        else
            v4 = false;
        end;
    end;

    local v5 = v4 and UDim2.new(0.9, 0, 0.9, 0) or UDim2.new(1, 0, 1, 0);

    if p3.MainFrame:IsDescendantOf(Players) then
        p3.MainFrame:TweenSize(v5, "Out", "Quint", 0.25, true);

        return;
    end;

    p3.MainFrame.Size = v5;
end;

function u1._Update(p6) -- Line: 46
    -- upvalues: FighterController (copy), PlayerDataController (copy), SpectateController (copy), GuiService (copy)
    local v7 = not (FighterController.LocalFighter and FighterController.LocalFighter:Get("IsHiddenByCutscene")) and not PlayerDataController:GetSetting("Hide HUD");
    local v8 = SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject:Get("Status") == "Voting";
    local v9 = not GuiService.MenuIsOpen;
    p6.MainFrame.BottomStack.Visible = v7;
    p6.MainFrame.Notifications.Visible = v7;

    if v7 or v8 then
        v8 = v9;
    end;

    p6.MainFrame.DuelInterfaces.Visible = v8;
    p6.MainFrame.EliminatedEffect.Visible = v7;
    p6.MainFrame.FighterInterfaces.Visible = v7 and v9;
    p6.MainFrame.Lobby.Visible = v7;
end;

function u1._HookLocalFighter(u10) -- Line: 59
    -- upvalues: FighterController (copy)
    FighterController:WaitForLocalFighter():GetDataChangedSignal("IsHiddenByCutscene"):Connect(function() -- Line: 62
        -- upvalues: u10 (copy)
        u10:_Update();
    end);
    task.defer(u10._Update, u10);
end;

function u1._Init(u11) -- Line: 69
    -- upvalues: PlayerDataController (copy), SpectateController (copy), ControlsController (copy), Pages (copy), GuiService (copy)
    PlayerDataController:GetSettingChangedSignal("Hide HUD"):Connect(function() -- Line: 70
        -- upvalues: u11 (copy)
        u11:_Update();
    end);
    PlayerDataController:GetSettingChangedSignal("Padded HUD"):Connect(function() -- Line: 74
        -- upvalues: u11 (copy)
        u11:_UpdateSize();
    end);
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 78
        -- upvalues: u11 (copy)
        u11:_Update();
    end);
    SpectateController.DuelSubjectStatusChanged:Connect(function() -- Line: 82
        -- upvalues: u11 (copy)
        u11:_Update();
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 86
        -- upvalues: u11 (copy)
        u11:_UpdateSize();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 90
        -- upvalues: u11 (copy)
        u11:_UpdateSize();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 94
        -- upvalues: u11 (copy)
        u11:_Update();
    end);
    u11:_Update();
    u11:_UpdateSize();
    task.defer(u11._HookLocalFighter, u11);
end;

return u1._new();