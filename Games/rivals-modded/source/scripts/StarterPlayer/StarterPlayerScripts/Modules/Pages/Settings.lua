-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.SettingsInfo);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local Profiles = require(script:WaitForChild("Profiles"));
local Inspect = require(script:WaitForChild("Inspect"));
local List = require(script:WaitForChild("List"));
local Tabs = require(script:WaitForChild("Tabs"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 19
    -- upvalues: Page (copy), u1 (copy), Profiles (copy), Inspect (copy), Tabs (copy), List (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.Container = v3.PageFrame:WaitForChild("Container");
    v3.CloseButton = v3.Container:WaitForChild("Close");
    v3.HidePartyDisplay = true;
    v3.CurrentPage = nil;
    v3.Profiles = Profiles.new(v3);
    v3.Inspect = Inspect.new(v3);
    v3.Tabs = Tabs.new(v3);
    v3.List = List.new(v3);
    v3._open_animation_disabled = true;
    v3:_Init();

    return v3;
end;

function u1.SetPage(p4, p5) -- Line: 43
    p4.CurrentPage = p5;
    p4.Tabs:SetPage(p4.CurrentPage);
    p4.List:SetPage(p4.CurrentPage);
    p4.Inspect:SetPage(p4.CurrentPage);
    p4.Profiles:SetPage(p4.CurrentPage);
end;

function u1.Open(p6, ...) -- Line: 51
    -- upvalues: Page (copy)
    Page.Open(p6, ...);
    p6.Inspect:Open();
    p6.Profiles:Open();
end;

function u1.Close(p7, ...) -- Line: 57
    -- upvalues: Page (copy)
    p7.List:Close();
    p7.Inspect:Close();
    Page.Close(p7, ...);
end;

function u1._VerifyPage(p8) -- Line: 67
    -- upvalues: ControlsController (copy)
    local v9 = ControlsController.CurrentControls == "Touch";

    if v9 and p8.CurrentPage == "Hotkeys" then
        p8:SetPage("Touch");

        return;
    end;

    if not v9 and p8.CurrentPage == "Touch" then
        p8:SetPage("Hotkeys");
    end;
end;

function u1._UpdateSize(p10) -- Line: 77
    -- upvalues: GuiService (copy)
    p10.Container.Size = UDim2.new(1, 0, 1, -GuiService.TopbarInset.Height);
end;

function u1._Init(u11) -- Line: 81
    -- upvalues: SettingsController (copy), PlayerDataController (copy), ControlsController (copy), GuiService (copy), ButtonEffect (copy)
    u11.CloseButton.MouseButton1Click:Connect(function() -- Line: 82
        -- upvalues: u11 (copy)
        u11:CloseRequest();
    end);
    u11.List.ResetSettings:Connect(function() -- Line: 86
        -- upvalues: SettingsController (ref), u11 (copy)
        SettingsController:DefaultSettings(u11.CurrentPage);
    end);
    u11.List.Hovered:Connect(function(p12) -- Line: 90
        -- upvalues: u11 (copy)
        u11.Inspect:Inspect(p12.SettingsInfo);
    end);
    u11.Tabs.Clicked:Connect(function(p13) -- Line: 94
        -- upvalues: u11 (copy)
        u11:SetPage(p13);
    end);
    u11.Profiles.Clicked:Connect(function(p14) -- Line: 98
        -- upvalues: PlayerDataController (ref), u11 (copy), SettingsController (ref)
        if p14 == PlayerDataController:Get("SettingsProfile") then
            return;
        end;

        u11.Inspect:Inspect(nil);
        SettingsController:SwitchSettingsProfile(p14);
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 107
        -- upvalues: u11 (copy)
        u11:_VerifyPage();
    end);
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 111
        -- upvalues: u11 (copy)
        u11:_UpdateSize();
    end);
    u11:_UpdateSize();
    u11:SetPage("Audio");
    ButtonEffect:Add(u11.CloseButton);
end;

return u1._new();