-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GamepadService = game:GetService("GamepadService");
local GuiService = game:GetService("GuiService");
game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.DebugLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"));
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"));
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local Queue = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"));
local PageSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PageSystem"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 23
    -- upvalues: u1 (copy), UILibrary (copy), PageSystem (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("MainFrame", "Pages");
    v2.PageSystem = PageSystem.new(v2.Frame);
    v2._welcomeback_popped_up = false;
    v2._patchnotes_popped_up = false;
    v2._mobileduels_popped_up = false;
    v2._delay_next_popup = nil;
    v2:_Init();

    return v2;
end;

function u1.GetDefaultElement(p3) -- Line: 44
    return p3.PageSystem:GetDefaultElement();
end;

function u1.CloseRequest(p4) -- Line: 48
    p4.PageSystem:CloseRequest();
end;

function u1.OpenPickWeaponsPage(p5) -- Line: 52
    -- upvalues: PlayerDataController (copy)
    p5.PageSystem:OpenPage(PlayerDataController:GetSetting("Pick Weapons List") == "List" and "PickWeaponsList" or "PickWeapons", true);
end;

function u1._UpdateVisibility(p6) -- Line: 60
    -- upvalues: GuiService (copy)
    p6.Frame.Visible = not GuiService.MenuIsOpen;
end;

function u1._CheckInterruption(p7) -- Line: 64
    -- upvalues: Queue (copy), Teleporting (copy), MobileInputs (copy)
    if not p7.PageSystem.CurrentPage then
        return;
    end;

    if Queue:IsVisible() and p7.PageSystem.CurrentPage.Name ~= "PickEmote" or (Teleporting.Enabled or MobileInputs.EditorEnabled) then
        p7.PageSystem:CloseCurrentPage();
    end;
end;

function u1._CheckPopUps(p8) -- Line: 74
    -- upvalues: DuelController (copy), Players (copy), PlayerDataController (copy), CONSTANTS (copy), ControlsController (copy), Utility (copy)
    if p8.PageSystem.CurrentPage then
        return;
    end;

    wait(1);

    if p8._delay_next_popup then
        local _ = p8._delay_next_popup;
        p8._delay_next_popup = nil;
        wait(p8._delay_next_popup);
    end;

    if DuelController:GetDuel(Players.LocalPlayer) then
        return;
    end;

    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsPlayed");

    if p8._welcomeback_popped_up or not PlayerDataController:Get("WelcomeBackGiftReady") then
        if p8._patchnotes_popped_up or (PlayerDataController:Get("LastPatchNotesVersion") == CONSTANTS.GAME_VERSION or Statistic <= 3) then
            if p8._mobileduels_popped_up or (CONSTANTS.IS_MOBILE_SERVER or (Statistic <= 0 or (Statistic > 3 or ControlsController.CurrentControls ~= "Touch"))) then
                if Statistic > 10 and CONSTANTS.IS_HUB_SERVER and not ((not Utility:IsAprilFools() or PlayerDataController:Get("AprilFoolsDialogAcknowledged") ~= -1) and (Utility:IsAprilFools() or PlayerDataController:Get("AprilFoolsDialogAcknowledged") == -1)) then
                    p8.PageSystem:OpenPage("DialogAprilFools", true);
                end;
            else
                p8._mobileduels_popped_up = true;
                p8.PageSystem:OpenPage("MobileDuels", true);
            end;
        else
            p8._patchnotes_popped_up = true;
            p8.PageSystem:OpenPage("PatchNotes", true);
        end;
    else
        p8._welcomeback_popped_up = true;
        p8._delay_next_popup = 9;
        p8.PageSystem:OpenPage("WelcomeBack", true);
    end;

    p8._patchnotes_popped_up = true;
end;

function u1._PickWeapons(p9) -- Line: 110
    -- upvalues: FighterController (copy), Players (copy), DuelController (copy)
    local Fighter = FighterController:GetFighter(Players.LocalPlayer);

    if not Fighter then
        return;
    end;

    local Duel = DuelController:GetDuel(Players.LocalPlayer);
    local v10;

    if #Fighter.Items == 0 then
        v10 = Fighter:Get("CanPickWeapons") and Fighter:IsAlive();
    else
        v10 = false;
    end;

    local v11 = Duel and Duel.LocalDueler and Duel.LocalDueler:GetStaggeredSpawnsTurn();

    if v10 then
        if not p9.PageSystem.CurrentPage then
            p9:OpenPickWeaponsPage();
        end;
    elseif not v11 then
        for _, v in pairs({ "PickWeapons", "PickWeaponsList" }) do
            local Page = p9.PageSystem:GetPage(v);

            if Page and Page:IsOpen() then
                p9.PageSystem:CloseCurrentPage();
            end;
        end;
    end;
end;

function u1._DuelAdded(u12, p13) -- Line: 136
    -- upvalues: Players (copy)
    if not p13:GetDueler(Players.LocalPlayer) then
        return;
    end;

    p13:GetDataChangedSignal("StaggeredSpawnsOrder"):Connect(function() -- Line: 141
        -- upvalues: u12 (copy)
        u12:_PickWeapons();
    end);
    u12:_PickWeapons();
end;

function u1._HookLocalFighter(u14) -- Line: 148
    -- upvalues: FighterController (copy)
    local u15 = FighterController:WaitForLocalFighter();
    u15:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 151
        -- upvalues: u15 (copy), u14 (copy)
        if u15:Get("IsInDuel") and u14.PageSystem.CurrentPage then
            u14.PageSystem:CloseCurrentPage();
        end;
    end);
    u15:GetDataChangedSignal("CanPickWeapons"):Connect(function() -- Line: 157
        -- upvalues: u14 (copy)
        u14:_PickWeapons();
    end);
    u15.EntityRemoved:Connect(function() -- Line: 161
        -- upvalues: u14 (copy)
        u14:_PickWeapons();
    end);
    u15.ItemRemoved:Connect(function() -- Line: 165
        -- upvalues: u14 (copy)
        u14:_PickWeapons();
    end);
    u15.ItemAdded:Connect(function() -- Line: 169
        -- upvalues: u14 (copy)
        u14:_PickWeapons();
    end);

    local function entity_added(p16) -- Line: 173
        -- upvalues: u14 (copy)
        p16.Died:Connect(function() -- Line: 174
            -- upvalues: u14 (ref)
            u14:_PickWeapons();
        end);
        u14:_PickWeapons();
    end;

    u15.EntityAdded:Connect(entity_added);

    if u15.Entity then
        task.defer(entity_added, u15.Entity);
    end;
end;

function u1._SweepFromFolder(p17) -- Line: 188
    -- upvalues: Players (copy)
    local function folder_added(u18) -- Line: 189
        -- upvalues: Players (ref)
        if not u18:IsA("SurfaceGui") or u18.Name ~= "PagesFromServer" then
            return;
        end;

        u18.ChildAdded:Connect(function() -- Line: 194, Name: sweep
            -- upvalues: u18 (copy), Players (ref)
            task.defer(function() -- Line: 195
                -- upvalues: u18 (ref), Players (ref)
                for _, child in pairs(u18:GetChildren()) do
                    child.Parent = Players.LocalPlayer.PlayerScripts.UserInterface.Pages;
                end;
            end);
        end);
        task.defer(function() -- Line: 195
            -- upvalues: u18 (copy), Players (ref)
            for _, child in pairs(u18:GetChildren()) do
                child.Parent = Players.LocalPlayer.PlayerScripts.UserInterface.Pages;
            end;
        end);
    end;

    Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(p19) -- Line: 206
        -- upvalues: folder_added (copy)
        folder_added(p19);
    end);

    for _, child in pairs(Players.LocalPlayer.PlayerGui:GetChildren()) do
        folder_added(child);
    end;
end;

function u1._Init(u20) -- Line: 215
    -- upvalues: GamepadService (copy), Queue (copy), Teleporting (copy), MobileInputs (copy), ControlsController (copy), PlayerDataController (copy), DuelController (copy), GuiService (copy)
    u20.PageSystem.PageOpened:Connect(function() -- Line: 216
        -- upvalues: GamepadService (ref), u20 (copy)
        GamepadService:EnableGamepadCursor(u20:GetDefaultElement());
    end);
    u20.PageSystem.PageClosed:Connect(function(p21) -- Line: 220
        -- upvalues: GamepadService (ref), u20 (copy)
        GamepadService:DisableGamepadCursor();
        task.defer(u20._CheckPopUps, u20);

        if p21 ~= u20.PageSystem:GetPage("PickWeapons") and p21 ~= u20.PageSystem:GetPage("PickWeaponsList") then
            task.defer(u20._PickWeapons, u20);
        end;
    end);
    Queue.VisibilityChanged:Connect(function() -- Line: 229
        -- upvalues: u20 (copy)
        u20:_CheckInterruption();
    end);
    Teleporting.EnabledChanged:Connect(function() -- Line: 233
        -- upvalues: u20 (copy)
        u20:_CheckInterruption();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 237
        -- upvalues: u20 (copy)
        u20:_CheckInterruption();
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 241
        -- upvalues: u20 (copy)
        u20:_CheckPopUps();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 245
        -- upvalues: u20 (copy)
        u20:_CheckPopUps();
    end);
    PlayerDataController:GetDataChangedSignal("AprilFoolsDialogAcknowledged"):Connect(function() -- Line: 249
        -- upvalues: u20 (copy)
        u20:_CheckPopUps();
    end);
    DuelController.LocalPlayerLeftDuel:Connect(function() -- Line: 253
        -- upvalues: u20 (copy)
        u20:_CheckPopUps();
    end);
    GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(function() -- Line: 257
        -- upvalues: u20 (copy)
        u20:_UpdateVisibility();
    end);
    u20:_UpdateVisibility();
    task.defer(u20._CheckPopUps, u20);
    task.defer(u20._SweepFromFolder, u20);
    task.defer(u20._HookLocalFighter, u20);
end;

return u1._new();