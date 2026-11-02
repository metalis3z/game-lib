-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.DebugLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"));
local InsetButtonsBar = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("InsetButtonsBar"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Inbox = require(Players.LocalPlayer.PlayerScripts.Modules.Pages:WaitForChild("Inbox"));
local InboxNotification = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InboxNotification");
local u1 = {
    { "Open", "See more", "rbxassetid://14641612286", nil, nil, nil },
    { "Settings", "Change your crosshair & hotkeys", "rbxassetid://14641612286", nil, nil, "Settings" },
    { "PatchNotes", "Read the latest news", "rbxassetid://18457336026", nil, nil, "PatchNotes" },
    { "Restrictions", "", "rbxassetid://120647688402991", nil, nil, nil },
    { "Inbox", "View your recent notifications", "rbxassetid://96509180790493", nil, nil, "Inbox" },
    { "PrivateServerControls", "Edit your private server", "rbxassetid://12343093905", nil, nil, "PrivateServerControls" },
    {
        "MobileEditor",
        "Move & resize your touch buttons",
        "rbxassetid://98757786697658",
        UDim2.new(0.525, 0, 0.525, 0),
        UDim2.new(0.55, 0, 0.55, 0),
        nil
    },
    { "Freecam", "Turn on freecam mode", "rbxassetid://17548980857", nil, nil, nil }
};
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 35
    -- upvalues: u2 (copy), InsetButtonsBar (copy), UILibrary (copy), InboxNotification (copy)
    local v4 = setmetatable({}, u2);
    v4.Inset = p3;
    v4.Bar = InsetButtonsBar.new(UILibrary.BUTTON_BACKGROUND_TRANSPARENCY, UILibrary.BUTTON_BACKGROUND_COLOR, UILibrary.BUTTON_ICON_COLOR, true);
    v4._inbox_notification_frame = InboxNotification:Clone();
    v4:_Init();

    return v4;
end;

function u2.GetNotificationGoal(p5) -- Line: 52
    if p5.Bar.IsOpen then
        return p5.Bar.Buttons.Inbox;
    end;

    return p5.Bar.Buttons.Open;
end;

function u2.SetVisible(p6, p7, p8) -- Line: 56
    p6.Bar.Frame.Visible = p7;
    p6.Bar.Frame.Size = p8 or p6.Bar.Frame.Size;
    local v9;

    if p6.Bar.Frame.Visible then
        v9 = p6.Bar.IsOpen;
    else
        v9 = false;
    end;

    p6.Bar:Toggle(v9);
end;

function u2._UpdateRestrictions(p10) -- Line: 66
    -- upvalues: PlayerDataController (copy), CONSTANTS (copy)
    local v11 = PlayerDataController:Get("WinsFromDuelPadsToday") >= CONSTANTS.MAX_DUEL_PAD_WINS_PER_DAY_BEFORE_BEING_BLOCKED;
    local v12 = PlayerDataController:Get("IsRestrictedFromCasualLeaderboards");
    local v13 = PlayerDataController:Get("IsRestrictedFromCompetitiveLeaderboards");
    local v14 = (("" .. (v11 and "You\'ve reached the max amount of wins from duel pads today\n" or "")) .. (v12 and "You\'ve been restricted from casual leaderboards due to your ban history\n" or "")) .. (v13 and "You\'ve been restricted from competitive leaderboards due to your ban history\n" or "");
    local v15 = v14 == "" and "" or string.sub(v14, 1, #v14 - 1);
    p10.Bar.Buttons.Restrictions:SetBubbleText(v15);
    p10.Bar.Buttons.Restrictions.Frame.Visible = v15 ~= "";
end;

function u2._UpdateFreecam(p16) -- Line: 81
    -- upvalues: CameraController (copy), ControlsController (copy)
    local v17 = CameraController.CameraState:HasFreecamAccess();
    local v18 = CameraController:GetPublicState() == CameraController.CameraState.States.CustomFreecam;
    p16.Bar.Buttons.Freecam.Frame.Visible = v17 and not v18 and ControlsController.CurrentControls == "MouseKeyboard";
end;

function u2._UpdateInbox(p19) -- Line: 88
    -- upvalues: Inbox (copy), Utility (copy)
    local NumNewNotifications = Inbox:GetNumNewNotifications();
    p19.Bar.Buttons.Inbox.Frame.Visible = Inbox:GetNumNotifications() > 0;
    p19._inbox_notification_frame.Title.Text = Utility:PrettyNumber(NumNewNotifications);
    local v20;

    if NumNewNotifications <= 0 then
        v20 = nil;
    elseif p19.Bar.IsOpen then
        v20 = p19.Bar.Buttons.Inbox.Frame.Button;
    else
        v20 = p19.Bar.Buttons.Open.Frame.Button;
    end;

    p19._inbox_notification_frame.Parent = v20;
end;

function u2._UpdateOpenButton(p21) -- Line: 96
    -- upvalues: Players (copy)
    local Open = p21.Bar.Buttons.Open;
    local Image = Open.Frame.Button.Icon.Image;
    Open.Frame.Button.OnHover.Bubble.Container.Title.Text = p21.Bar.IsOpen and "See less" or "See more";
    Open.Frame.Button.Icon.Image = p21.Bar.IsOpen and "rbxassetid://108220438104376" or "rbxassetid://14641612286";

    if Open.Frame.Button.Icon.Image ~= Image then
        if Open.Frame.Button:IsDescendantOf(Players) then
            Open.Frame.Button.Icon.Size = UDim2.new(0, 0, 0, 0);
            Open.Frame.Button.Icon:TweenSize(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);

            return;
        end;

        Open.Frame.Button.Icon.Size = UDim2.new(0.5, 0, 0.5, 0);
    end;
end;

function u2._UpdateMobileEditorVisibility(p22) -- Line: 113
    -- upvalues: ControlsController (copy)
    local v23 = ControlsController.CurrentControls == "Touch";
    p22.Bar.Buttons.MobileEditor.Frame.Visible = v23;

    if p22.Inset.MobileEditorBar.Bar.Frame.Visible and not v23 then
        p22.Inset.MobileEditorBar:SetVisible(false);
    end;
end;

function u2._Setup(u24) -- Line: 123
    -- upvalues: u1 (copy), Pages (copy), CameraController (copy), CONSTANTS (copy), Players (copy)
    for i, v in pairs(u1) do
        local table_unpack_ret, v25, v26, v27, v28, u29 = table.unpack(v);
        u24.Bar:CreateButton(i, table_unpack_ret, v25, v26, v27, v28).Clicked:Connect(function() -- Line: 128
            -- upvalues: u29 (copy), Pages (ref)
            if u29 then
                Pages.PageSystem:OpenPage(u29);
            end;
        end);
    end;

    u24.Bar.Buttons.Open.Clicked:Connect(function() -- Line: 135
        -- upvalues: u24 (copy)
        u24.Bar:Toggle();
    end);
    u24.Bar.Buttons.MobileEditor.Clicked:Connect(function() -- Line: 139
        -- upvalues: u24 (copy)
        u24.Inset.MobileEditorBar:SetVisible(true, u24.Bar.Frame.Size);
    end);
    u24.Bar.Buttons.Freecam.Clicked:Connect(function() -- Line: 143
        -- upvalues: CameraController (ref)
        CameraController.CameraState:SetCustomFreecamEnabled(CameraController:GetPublicState() ~= CameraController.CameraState.States.CustomFreecam);
    end);
    local Frame = u24.Bar.Buttons.PrivateServerControls.Frame;
    local v30 = CONSTANTS.IS_PRIVATE_HUB_SERVER and CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId);
    Frame.Visible = v30;
    u24.Bar.Buttons.Open.Frame.Visible = true;
end;

function u2._Init(u31) -- Line: 151
    -- upvalues: Inbox (copy), ControlsController (copy), CameraController (copy), PlayerDataController (copy)
    u31.Bar.OpenedChanged:Connect(function() -- Line: 152
        -- upvalues: u31 (copy)
        u31:_UpdateOpenButton();
        u31:_UpdateInbox();
    end);
    Inbox.NotificationAdded:Connect(function() -- Line: 157
        -- upvalues: u31 (copy)
        u31:_UpdateInbox();
    end);
    Inbox.NotificationQueued:Connect(function() -- Line: 161
        -- upvalues: u31 (copy)
        u31:_UpdateInbox();
    end);
    ControlsController.ControlsChanged:Connect(function() -- Line: 165
        -- upvalues: u31 (copy)
        u31:_UpdateMobileEditorVisibility();
        u31:_UpdateFreecam();
    end);
    CameraController.CustomFreecamStateChanged:Connect(function() -- Line: 170
        -- upvalues: u31 (copy)
        u31:_UpdateFreecam();
    end);
    CameraController.CameraState.FreecamAccessChanged:Connect(function() -- Line: 174
        -- upvalues: u31 (copy)
        u31:_UpdateFreecam();
    end);
    PlayerDataController:GetDataChangedSignal("IsBadGuy"):Connect(function() -- Line: 178
        -- upvalues: u31 (copy)
        u31:_UpdateRestrictions();
    end);
    PlayerDataController:GetDataChangedSignal("IsBadGuy2"):Connect(function() -- Line: 182
        -- upvalues: u31 (copy)
        u31:_UpdateRestrictions();
    end);
    PlayerDataController:GetDataChangedSignal("WinsFromDuelPadsToday"):Connect(function() -- Line: 186
        -- upvalues: u31 (copy)
        u31:_UpdateRestrictions();
    end);
    u31:_Setup();
    u31:_UpdateInbox();
    u31:_UpdateFreecam();
    u31:_UpdateOpenButton();
    u31:_UpdateRestrictions();
    u31:_UpdateMobileEditorVisibility();
    u31:SetVisible(true);
end;

return u2;