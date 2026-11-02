-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ExperienceNotificationService = game:GetService("ExperienceNotificationService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("SocialService");
local GroupService = game:GetService("GroupService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local SocialController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = {
    HoverRatio = 1.05,
    ReleaseRatio = 1.05
};
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 24
    -- upvalues: Page (copy), u2 (copy), PromptSystem (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.CloseButton = v4.PageFrame:WaitForChild("Close");
    v4.PromptsFrame = v4.PageFrame:WaitForChild("Prompts");
    v4.List = v4.PageFrame:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.InviteFrame = v4.Container:WaitForChild("Invite");
    v4.InviteRewardFrame = v4.InviteFrame:WaitForChild("Reward");
    v4.InviteRewardButton = v4.InviteFrame:WaitForChild("Button");
    v4.FavoriteFrame = v4.Container:WaitForChild("Favorite");
    v4.FavoriteRewardClaimed = v4.FavoriteFrame:WaitForChild("Claimed");
    v4.FavoriteRewardFrame = v4.FavoriteFrame:WaitForChild("Reward");
    v4.FavoriteRewardButton = v4.FavoriteFrame:WaitForChild("Button");
    v4.NotificationsFrame = v4.Container:WaitForChild("Notifications");
    v4.NotificationsRewardClaimed = v4.NotificationsFrame:WaitForChild("Claimed");
    v4.NotificationsRewardFrame = v4.NotificationsFrame:WaitForChild("Reward");
    v4.NotificationsRewardButton = v4.NotificationsFrame:WaitForChild("Button");
    v4.LikeFrame = v4.Container:WaitForChild("Like");
    v4.LikeRewardFrame = v4.LikeFrame:WaitForChild("Reward");
    v4.LikeRewardClaimed = v4.LikeFrame:WaitForChild("Claimed");
    v4.LikeRewardButton = v4.LikeFrame:WaitForChild("Button");
    v4.LikeRewardReadyFrame = v4.LikeRewardButton:WaitForChild("Ready");
    v4.LikeRewardCountdownFrame = v4.LikeRewardButton:WaitForChild("Countdown");
    v4.LikeRewardCountdownText = v4.LikeRewardCountdownFrame:WaitForChild("Title");
    v4.GroupFrame = v4.Container:WaitForChild("Group");
    v4.GroupRewardFrame = v4.GroupFrame:WaitForChild("Reward");
    v4.GroupRewardClaimed = v4.GroupFrame:WaitForChild("Claimed");
    v4.GroupRewardButton = v4.GroupFrame:WaitForChild("Button");
    v4.GroupRewardReadyFrame = v4.GroupRewardButton:WaitForChild("Ready");
    v4.GroupRewardCountdownFrame = v4.GroupRewardButton:WaitForChild("Countdown");
    v4.GroupRewardJoinFrame = v4.GroupRewardButton:WaitForChild("Join");
    v4.GroupRewardCountdownText = v4.GroupRewardCountdownFrame:WaitForChild("Title");
    v4.CodesFrame = v4.Container:WaitForChild("Codes");
    v4.CodesVerifiedFrame = v4.CodesFrame:WaitForChild("Verified");
    v4.CodesVerifiedInputFrame = v4.CodesVerifiedFrame:WaitForChild("Input");
    v4.CodesVerifiedBox = v4.CodesVerifiedInputFrame:WaitForChild("Box");
    v4.CodesVerifiedButton = v4.CodesVerifiedInputFrame:WaitForChild("Button");
    v4.CodesVerifiedButtonReadyFrame = v4.CodesVerifiedButton:WaitForChild("Ready");
    v4.CodesVerifiedButtonCountdownFrame = v4.CodesVerifiedButton:WaitForChild("Countdown");
    v4.CodesVerifiedButtonCountdownText = v4.CodesVerifiedButtonCountdownFrame:WaitForChild("Title");
    v4.CodesUnverifiedFrame = v4.CodesFrame:WaitForChild("Unverified");
    v4.CodesUnverifiedButton = v4.CodesUnverifiedFrame:WaitForChild("Input"):WaitForChild("Button");
    v4.CodesUnverifiedButtonReadyFrame = v4.CodesUnverifiedButton:WaitForChild("Ready");
    v4.CodesUnverifiedButtonCountdownFrame = v4.CodesUnverifiedButton:WaitForChild("Countdown");
    v4.CodesUnverifiedButtonCountdownText = v4.CodesUnverifiedButtonCountdownFrame:WaitForChild("Title");
    v4.PromptSystem = PromptSystem.new(v4.PromptsFrame);
    v4._open_animation_disabled = true;
    v4._group_reward_countdown_hash = 0;
    v4._like_reward_countdown_hash = 0;
    v4._codes_verify_countdown_hash = 0;
    v4._window_focus_connection = nil;
    v4._is_enabling_notifications = false;
    v4._is_favoriting = false;
    v4._can_verify = false;
    v4._previous_verified_status = nil;
    v4._redirect_on_close = nil;
    v4:_Init();

    return v4;
end;

function u2.CloseRequest(p5) -- Line: 94
    -- upvalues: PlayerDataController (copy), Page (copy)
    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsPlayed");
    local Statistic2 = PlayerDataController:GetStatistic("StatisticDuelsWon");

    if Statistic >= 5 and Statistic2 < 10 then
        Page.CloseRequest(p5);

        return;
    end;

    p5.OpenPage:Fire("Shop", true);
end;

function u2._UpdateCodesVerified(p6) -- Line: 109
    -- upvalues: PlayerDataController (copy), Utility (copy)
    local v7 = PlayerDataController:Get("CodesVerified");

    if p6._previous_verified_status == false and v7 then
        Utility:CreateSound("rbxassetid://7715210658", 1, 1, script, true, 5);
    end;

    p6._previous_verified_status = v7;
    p6.CodesVerifiedFrame.Visible = v7;
    p6.CodesUnverifiedFrame.Visible = not v7;
end;

function u2._CountdownCodesVerify(u8) -- Line: 121
    u8._codes_verify_countdown_hash = u8._codes_verify_countdown_hash + 1;
    local _codes_verify_countdown_hash = u8._codes_verify_countdown_hash;
    u8.CodesUnverifiedButtonCountdownFrame.Visible = true;
    u8.CodesUnverifiedButtonReadyFrame.Visible = false;
    task.spawn(function() -- Line: 128
        -- upvalues: u8 (copy), _codes_verify_countdown_hash (copy)
        for i = 15, 1, -1 do
            u8.CodesUnverifiedButtonCountdownText.Text = i;
            wait(1);

            if _codes_verify_countdown_hash ~= u8._codes_verify_countdown_hash then
                return;
            end;

            local _ = i;
        end;

        u8.CodesUnverifiedButtonCountdownFrame.Visible = false;
        u8.CodesUnverifiedButtonReadyFrame.Visible = true;
    end);
end;

function u2._UpdateNotificationsReward(p9) -- Line: 144
    -- upvalues: PlayerDataController (copy)
    local v10 = PlayerDataController:Get("ClaimedNotificationsReward");
    p9.NotificationsRewardClaimed.Visible = v10;
    p9.NotificationsRewardButton.Visible = not v10;
end;

function u2._UpdateFavoriteReward(p11) -- Line: 151
    -- upvalues: PlayerDataController (copy)
    local v12 = PlayerDataController:Get("ClaimedFavoriteReward");
    p11.FavoriteRewardClaimed.Visible = v12;
    p11.FavoriteRewardButton.Visible = not v12;
end;

function u2._UpdateLikeReward(p13) -- Line: 158
    -- upvalues: PlayerDataController (copy)
    local v14 = PlayerDataController:Get("ClaimedLikeReward");
    p13.LikeRewardClaimed.Visible = v14;
    p13.LikeRewardButton.Visible = not v14;

    if v14 then
        p13._like_reward_countdown_hash = p13._like_reward_countdown_hash + 1;
    end;
end;

function u2._CountdownLikeReward(u15) -- Line: 169
    u15._like_reward_countdown_hash = u15._like_reward_countdown_hash + 1;
    local _like_reward_countdown_hash = u15._like_reward_countdown_hash;
    u15.LikeRewardCountdownFrame.Visible = true;
    u15.LikeRewardReadyFrame.Visible = false;
    task.spawn(function() -- Line: 176
        -- upvalues: u15 (copy), _like_reward_countdown_hash (copy)
        for i = 20, 1, -1 do
            u15.LikeRewardCountdownText.Text = i;
            wait(1);

            if _like_reward_countdown_hash ~= u15._like_reward_countdown_hash then
                return;
            end;

            local _ = i;
        end;

        u15.LikeRewardCountdownFrame.Visible = false;
        u15.LikeRewardReadyFrame.Visible = true;
    end);
end;

function u2._UpdateGroupReward(p16) -- Line: 192
    -- upvalues: PlayerDataController (copy)
    local v17 = PlayerDataController:Get("ClaimedGroupReward");
    p16.GroupRewardClaimed.Visible = v17;
    p16.GroupRewardButton.Visible = not v17;

    if v17 then
        p16._group_reward_countdown_hash = p16._group_reward_countdown_hash + 1;
    end;
end;

function u2._CountdownGroupReward(u18) -- Line: 203
    u18._group_reward_countdown_hash = u18._group_reward_countdown_hash + 1;
    local _group_reward_countdown_hash = u18._group_reward_countdown_hash;
    u18.GroupRewardCountdownFrame.Visible = true;
    u18.GroupRewardReadyFrame.Visible = false;
    task.spawn(function() -- Line: 210
        -- upvalues: u18 (copy), _group_reward_countdown_hash (copy)
        for i = 60, 1, -1 do
            u18.GroupRewardCountdownText.Text = i;
            wait(1);

            if _group_reward_countdown_hash ~= u18._group_reward_countdown_hash then
                return;
            end;

            local _ = i;
        end;

        u18.GroupRewardCountdownFrame.Visible = false;
        u18.GroupRewardReadyFrame.Visible = true;
    end);
end;

function u2._UpdateInviteFrame(p19) -- Line: 226
    -- upvalues: SocialController (copy)
    p19.InviteFrame.Visible = SocialController.CanSendGameInvite;
end;

function u2._Setup(u20) -- Line: 230
    -- upvalues: ComplianceController (copy), RewardSlot (copy), ExperienceNotificationService (copy)
    for _, v in pairs({ "Group", "Nosniy", "SenseiWarrior" }) do
        local v21 = u20.CodesFrame:WaitForChild(v);

        for _, v2 in pairs({ "X", "Discord", "YouTube" }) do
            local v22 = v21:WaitForChild("Details"):FindFirstChild(v2);

            if v22 then
                v22.Visible = ComplianceController:IsExternalReferencesAllowed(v2);
            end;
        end;
    end;

    RewardSlot.new({
        Name = "Cream",
        Weapon = "IsRandom"
    }):SetParent(u20.InviteRewardFrame);
    RewardSlot.new({
        Name = "Shooting Star",
        Weapon = "IsUniversal"
    }):SetParent(u20.FavoriteRewardFrame);
    RewardSlot.new({
        Name = "Bell",
        Weapon = "IsUniversal"
    }):SetParent(u20.NotificationsRewardFrame);
    RewardSlot.new({
        Name = "Nosniy Games",
        Weapon = "IsUniversal"
    }):SetParent(u20.GroupRewardFrame);
    RewardSlot.new({
        Name = "RIVALS",
        Weapon = "IsUniversal"
    }):SetParent(u20.LikeRewardFrame);
    local v23 = RewardSlot.new({
        Name = "Key",
        Quantity = 3
    });
    v23:SetParent(u20.LikeRewardFrame);
    v23.Frame.Position = UDim2.new(-0.5, 0, 0.5, 0);
    task.spawn(function() -- Line: 255
        -- upvalues: u20 (copy), ExperienceNotificationService (ref)
        u20.NotificationsFrame.Visible = false;
        local success, result = pcall(ExperienceNotificationService.CanPromptOptInAsync, ExperienceNotificationService);
        u20.NotificationsFrame.Visible = success and result;
    end);
end;

function u2._Init(u24) -- Line: 262
    -- upvalues: GroupService (copy), CONSTANTS (copy), ReplicatedStorage (copy), AvatarEditorService (copy), SocialController (copy), ExperienceNotificationService (copy), UserInputService (copy), PlayerDataController (copy), ButtonEffect (copy), u1 (copy)
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 263
        -- upvalues: u24 (copy)
        u24.List.CanvasSize = UDim2.new(0, 0, 0, u24.Layout.AbsoluteContentSize.Y);
    end);
    u24.CloseButton.MouseButton1Click:Connect(function() -- Line: 267
        -- upvalues: u24 (copy)
        u24:CloseRequest();
    end);
    u24.GroupRewardButton.MouseButton1Click:Connect(function() -- Line: 271
        -- upvalues: u24 (copy), GroupService (ref), CONSTANTS (ref), ReplicatedStorage (ref)
        if u24.GroupRewardJoinFrame.Visible then
            u24.GroupRewardJoinFrame.Visible = false;
            u24.GroupRewardReadyFrame.Visible = true;
            local success, result = pcall(GroupService.PromptJoinAsync, GroupService, CONSTANTS.GROUP_ID);

            if not success then
                u24.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to join, please try again another time!");
                warn("Failed to prompt group join, error:", result);
            end;
        elseif u24.GroupRewardReadyFrame.Visible then
            u24:_CountdownGroupReward();

            if not ReplicatedStorage.Remotes.Data.ClaimGroupReward:InvokeServer() then
                u24.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to verify, join the group before claiming your reward!");
            end;
        end;
    end);
    u24.LikeRewardButton.MouseButton1Click:Connect(function() -- Line: 293
        -- upvalues: u24 (copy), ReplicatedStorage (ref)
        if u24.LikeRewardReadyFrame.Visible then
            if u24._window_focus_connection then
                u24._window_focus_connection:Disconnect();
                u24._window_focus_connection = nil;
                u24.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to verify, like the game before claiming your reward!");
                u24:_CountdownLikeReward();

                return;
            end;

            ReplicatedStorage.Remotes.Data.ClaimLikeReward:FireServer();
        end;
    end);
    u24.FavoriteRewardButton.MouseButton1Click:Connect(function() -- Line: 307
        -- upvalues: AvatarEditorService (ref), CONSTANTS (ref), u24 (copy), ReplicatedStorage (ref)
        AvatarEditorService:PromptSetFavorite(CONSTANTS.HUB_PLACE_ID, Enum.AvatarItemType.Asset, true);

        if not u24._is_favoriting then
            u24._is_favoriting = true;
            wait(10);
            ReplicatedStorage.Remotes.Data.ClaimFavoriteReward:FireServer();
        end;
    end);
    u24.InviteRewardButton.MouseButton1Click:Connect(function() -- Line: 319
        -- upvalues: SocialController (ref)
        SocialController:PromptFriendInvite();
    end);
    u24.NotificationsRewardButton.MouseButton1Click:Connect(function() -- Line: 323
        -- upvalues: ExperienceNotificationService (ref), u24 (copy), ReplicatedStorage (ref)
        ExperienceNotificationService:PromptOptIn();

        if not u24._is_enabling_notifications then
            u24._is_enabling_notifications = true;
            wait(10);
            ReplicatedStorage.Remotes.Data.ClaimNotificationsReward:FireServer();
        end;
    end);
    u24.CodesUnverifiedButton.MouseButton1Click:Connect(function() -- Line: 335
        -- upvalues: u24 (copy), ReplicatedStorage (ref)
        if not u24.CodesUnverifiedButtonReadyFrame.Visible then
            return;
        end;

        if u24._can_verify then
            ReplicatedStorage.Remotes.Data.VerifyCodes:FireServer();

            return;
        end;

        u24._can_verify = true;
        u24.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to verify, follow the developers before verifying!");
        u24:_CountdownCodesVerify();
    end);
    u24.CodesVerifiedButton.MouseButton1Click:Connect(function() -- Line: 349
        -- upvalues: ReplicatedStorage (ref), u24 (copy)
        local v25 = ReplicatedStorage.Remotes.Data.RedeemCode:InvokeServer(string.lower(u24.CodesVerifiedBox.Text)) or "Something went wrong";

        if v25 ~= "Success" then
            u24.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to redeem code: " .. v25);
        end;
    end);
    u24._window_focus_connection = UserInputService.WindowFocusReleased:Connect(function() -- Line: 357
        -- upvalues: u24 (copy)
        u24._window_focus_connection:Disconnect();
        u24._window_focus_connection = nil;
    end);
    PlayerDataController:GetDataChangedSignal("ClaimedGroupReward"):Connect(function() -- Line: 362
        -- upvalues: u24 (copy)
        u24:_UpdateGroupReward();
    end);
    PlayerDataController:GetDataChangedSignal("ClaimedLikeReward"):Connect(function() -- Line: 366
        -- upvalues: u24 (copy)
        u24:_UpdateLikeReward();
    end);
    PlayerDataController:GetDataChangedSignal("ClaimedFavoriteReward"):Connect(function() -- Line: 370
        -- upvalues: u24 (copy)
        u24:_UpdateFavoriteReward();
    end);
    PlayerDataController:GetDataChangedSignal("ClaimedNotificationsReward"):Connect(function() -- Line: 374
        -- upvalues: u24 (copy)
        u24:_UpdateNotificationsReward();
    end);
    PlayerDataController:GetDataChangedSignal("CodesVerified"):Connect(function() -- Line: 378
        -- upvalues: u24 (copy)
        u24:_UpdateCodesVerified();
    end);
    SocialController.CanSendGameInviteChanged:Connect(function() -- Line: 382
        -- upvalues: u24 (copy)
        u24:_UpdateInviteFrame();
    end);
    u24:_Setup();
    u24:_UpdateInviteFrame();
    u24:_UpdateLikeReward();
    u24:_UpdateGroupReward();
    u24:_UpdateFavoriteReward();
    u24:_UpdateNotificationsReward();
    u24:_UpdateCodesVerified();
    ButtonEffect:Add(u24.CloseButton);
    ButtonEffect:Add(u24.InviteRewardButton, nil, u1);
    ButtonEffect:Add(u24.FavoriteRewardButton, nil, u1);
    ButtonEffect:Add(u24.NotificationsRewardButton, nil, u1);
    ButtonEffect:Add(u24.LikeRewardButton, nil, u1);
    ButtonEffect:Add(u24.GroupRewardButton, nil, u1);
    ButtonEffect:Add(u24.CodesVerifiedButton, nil, u1);
    ButtonEffect:Add(u24.CodesUnverifiedButton, nil, u1);
end;

return u2._new();