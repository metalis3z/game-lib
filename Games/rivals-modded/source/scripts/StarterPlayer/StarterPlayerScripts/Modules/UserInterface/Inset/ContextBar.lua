-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local ModerationLibrary = require(ReplicatedStorage.Modules.ModerationLibrary);
local DebugLibrary = require(ReplicatedStorage.Modules.DebugLibrary);
local ShootingRangeController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShootingRangeController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"));
local PlayerList = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("PlayerList"));
local InsetButtonsBar = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("InsetButtonsBar"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {
    { "StopFreecam", "Turn off freecam mode", "rbxassetid://17548980857", nil, nil, nil },
    { "LeaveShootingRange", "Leave the Shooting Range", "rbxassetid://17498605048", nil, nil, nil },
    { "PlayerList", "Open the player list", "rbxassetid://108950719202626", nil, nil, nil },
    { "HUD", "Enable your HUD", "rbxassetid://126633805196326", nil, nil, nil },
    {
        "Debug",
        "Test things out using commands",
        "rbxassetid://18223601855",
        nil,
        UDim2.new(0.6, 0, 0.6, 0),
        "Debug"
    },
    { "Moderation", "Search, join, & ban cheaters", "rbxassetid://118920750856778", nil, nil, "Moderation" },
    {
        "Permissions",
        "Promote & demote team members",
        "rbxassetid://95626460059631",
        nil,
        UDim2.new(0.75, 0, 0.75, 0),
        "Permissions"
    }
};
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 30
    -- upvalues: u2 (copy), InsetButtonsBar (copy), UILibrary (copy)
    local v4 = setmetatable({}, u2);
    v4.Inset = p3;
    v4.Bar = InsetButtonsBar.new(UILibrary.BUTTON_BACKGROUND_TRANSPARENCY, UILibrary.BUTTON_BACKGROUND_COLOR, UILibrary.BUTTON_ICON_COLOR, true);
    v4._local_fighter = nil;
    v4:_Init();

    return v4;
end;

function u2.SetVisible(p5, p6, p7) -- Line: 47
    p5.Bar.Frame.Visible = p6;
    p5.Bar.Frame.Size = p7 or p5.Bar.Frame.Size;
    p5.Bar:Toggle(true);
end;

function u2._UpdateVisibility(p8) -- Line: 57
    -- upvalues: CameraController (copy), PlayerList (copy), PlayerDataController (copy), DebugLibrary (copy), ModerationLibrary (copy), PermissionsLibrary (copy)
    p8.Bar.Buttons.StopFreecam.Frame.Visible = CameraController:GetPublicState() == CameraController.CameraState.States.CustomFreecam;
    local Frame = p8.Bar.Buttons.PlayerList.Frame;
    local v9 = PlayerList.ClosedByInputs and PlayerList:GetBaseVisibility();
    Frame.Visible = v9;
    p8.Bar.Buttons.HUD.Frame.Visible = PlayerDataController:GetSetting("Hide HUD");
    local Frame2 = p8.Bar.Buttons.LeaveShootingRange.Frame;
    local v10 = p8._local_fighter and p8._local_fighter:Get("IsInShootingRange");
    Frame2.Visible = v10;
    local Frame3 = p8.Bar.Buttons.Debug.Frame;
    local v11 = not PlayerDataController:GetSetting("Staff Team Tools Disabled") and DebugLibrary:CanViewDebugPage(PlayerDataController:Get("PermissionsRoles"));
    Frame3.Visible = v11;
    local Frame4 = p8.Bar.Buttons.Moderation.Frame;
    local v12 = not PlayerDataController:GetSetting("Staff Team Tools Disabled") and ModerationLibrary:CanViewModerationPage(PlayerDataController:Get("PermissionsRoles"));
    Frame4.Visible = v12;
    local Frame5 = p8.Bar.Buttons.Permissions.Frame;
    local v13 = not (PermissionsLibrary.USE_GROUP_ROLES_INSTEAD_OF_DATASTORES or PlayerDataController:GetSetting("Staff Team Tools Disabled Leads")) and PermissionsLibrary:CanViewPermissionsPage(PlayerDataController:Get("PermissionsRoles"));
    Frame5.Visible = v13;
    p8:SetVisible(p8.Bar.Frame.Visible);
end;

function u2._HookFighter(u14) -- Line: 69
    -- upvalues: FighterController (copy)
    u14._local_fighter = FighterController:WaitForLocalFighter();
    u14._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 72
        -- upvalues: u14 (copy)
        u14:_UpdateVisibility();
    end);
    u14:_UpdateVisibility();
end;

function u2._Setup(p15) -- Line: 79
    -- upvalues: u1 (copy), Pages (copy), CameraController (copy), ShootingRangeController (copy), PlayerList (copy), SettingsController (copy)
    for i, v in pairs(u1) do
        local table_unpack_ret, v16, v17, v18, v19, u20 = table.unpack(v);
        p15.Bar:CreateButton(i, table_unpack_ret, v16, v17, v18, v19).Clicked:Connect(function() -- Line: 84
            -- upvalues: u20 (copy), Pages (ref)
            if u20 then
                Pages.PageSystem:OpenPage(u20);
            end;
        end);
    end;

    p15.Bar.Buttons.StopFreecam.Clicked:Connect(function() -- Line: 91
        -- upvalues: CameraController (ref)
        CameraController.CameraState:SetCustomFreecamEnabled(false);
    end);
    p15.Bar.Buttons.LeaveShootingRange.Clicked:Connect(function() -- Line: 95
        -- upvalues: ShootingRangeController (ref)
        ShootingRangeController:Leave();
    end);
    p15.Bar.Buttons.PlayerList.Clicked:Connect(function() -- Line: 99
        -- upvalues: PlayerList (ref)
        PlayerList:SetClosedByInputs(not PlayerList.ClosedByInputs);
    end);
    p15.Bar.Buttons.HUD.Clicked:Connect(function() -- Line: 103
        -- upvalues: SettingsController (ref)
        SettingsController:ChangeSetting("Hide HUD", false);
    end);
    p15.Bar.Frame.Parent = p15.Inset.RightButtonsFrame;
end;

function u2._Init(u21) -- Line: 110
    -- upvalues: PlayerDataController (copy), PlayerList (copy), CameraController (copy)
    PlayerDataController:GetSettingChangedSignal("Staff Team Tools Disabled"):Connect(function() -- Line: 111
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    PlayerDataController:GetSettingChangedSignal("Staff Team Tools Disabled Leads"):Connect(function() -- Line: 115
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    PlayerDataController:GetSettingChangedSignal("Hide HUD"):Connect(function() -- Line: 119
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    PlayerDataController:GetDataChangedSignal("PermissionsRoles"):Connect(function() -- Line: 123
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    PlayerList.ClosedByInputsChanged:Connect(function() -- Line: 127
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    PlayerList.BaseVisibilityChanged:Connect(function() -- Line: 131
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    CameraController.CustomFreecamStateChanged:Connect(function() -- Line: 135
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    CameraController.CameraState.FreecamAccessChanged:Connect(function() -- Line: 139
        -- upvalues: u21 (copy)
        u21:_UpdateVisibility();
    end);
    u21:_Setup();
    u21:_UpdateVisibility();
    task.defer(u21._HookFighter, u21);
end;

return u2;