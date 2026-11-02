-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AdService = game:GetService("AdService");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local VideoAdRewards = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("VideoAdRewards");
local VideoAdRewardSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("VideoAdRewardSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy), Signal (copy), VideoAdRewards (copy)
    local v3 = setmetatable({}, u1);
    v3.PlayedAd = Signal.new();
    v3.AvailabilityChanged = Signal.new();
    v3.Frame = VideoAdRewards:Clone();
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Background = v3.Container:WaitForChild("Background");
    v3.WaitingFrame = v3.Container:WaitForChild("Waiting");
    v3.WaitingDotsFrame = v3.WaitingFrame:WaitForChild("Dots");
    v3.UnavailableFrame = v3.Container:WaitForChild("Unavailable");
    v3.UnavailableTitle = v3.UnavailableFrame:WaitForChild("Title");
    v3.UnavailableDescription = v3.UnavailableFrame:WaitForChild("Description");
    v3.UnavailableImage = v3.UnavailableFrame:WaitForChild("ImageLabel");
    v3.AvailableFrame = v3.Container:WaitForChild("Available");
    v3.AvailableTitle = v3.AvailableFrame:WaitForChild("Title");
    v3.AvailableDescription = v3.AvailableFrame:WaitForChild("Description");
    v3.RewardsFrame = v3.AvailableFrame:WaitForChild("Rewards");
    v3._connections = {};
    v3._cleanup = {};
    v3._update_hash = 0;
    v3._auto_update_task = nil;
    v3._buttons_position = nil;
    v3:_Init();

    return v3;
end;

function u1.IsAvailable(p4) -- Line: 54
    return p4.AvailableFrame.Visible;
end;

function u1.SetButtonsPositionY(p5, p6) -- Line: 58
    p5._buttons_position_y = p6;
end;

function u1.SetRewardsSize(p7, p8) -- Line: 62
    p7.RewardsFrame.Size = UDim2.new(0.9, 0, p8, 0);
end;

function u1.SetBackgroundVisible(p9, p10) -- Line: 66
    p9.Background.Visible = p10;
end;

function u1.SetWhiteColor(p11, p12) -- Line: 70
    p11.AvailableTitle.TextColor3 = p12;
    p11.AvailableDescription.TextColor3 = p12;
    p11.UnavailableTitle.TextColor3 = p12;
    p11.UnavailableDescription.TextColor3 = p12;
    p11.UnavailableImage.ImageColor3 = p12;

    for _, child in pairs(p11.WaitingDotsFrame:GetChildren()) do
        if child:IsA("ImageLabel") then
            child.ImageColor3 = p12;
        end;
    end;
end;

function u1.AutoUpdate(u13, u14) -- Line: 84
    u13._auto_update_task = task.spawn(function() -- Line: 85
        -- upvalues: u13 (copy), u14 (copy)
        while true do
            u13:Update();
            wait(u14 or 60);
        end;
    end);
end;

function u1.Update(p15) -- Line: 93
    task.spawn(p15._Update, p15);
end;

function u1.WeakUpdate(p16) -- Line: 97
    if p16.AvailableFrame.Visible then
        return;
    end;

    p16:Update();
end;

function u1.Destroy(p17) -- Line: 105
    for _, v in pairs(p17._connections) do
        v:Disconnect();
    end;

    if p17._auto_update_task then
        task.cancel(p17._auto_update_task);
    end;

    p17.AvailabilityChanged:Destroy();
    p17.PlayedAd:Destroy();
end;

function u1._Update(u18) -- Line: 122
    -- upvalues: AdService (copy), MonetizationLibrary (copy), PlayerDataController (copy), Utility (copy), VideoAdRewardSlot (copy), RewardSlot (copy), ReplicatedStorage (copy), ButtonEffect (copy)
    for _, v in pairs(u18._cleanup) do
        v:Destroy();
    end;

    u18._cleanup = {};
    u18._update_hash = u18._update_hash + 1;
    local _update_hash = u18._update_hash;
    u18.WaitingFrame.Visible = true;
    u18.WaitingDotsFrame:AddTag("UILoadingDots");
    u18.UnavailableFrame.Visible = false;
    u18.AvailableFrame.Visible = false;
    local success, result = pcall(AdService.GetAdAvailabilityNowAsync, AdService, Enum.AdFormat.RewardedVideo);

    if _update_hash ~= u18._update_hash then
        return;
    end;

    if success then
        success = result.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable;
    end;

    u18.WaitingFrame.Visible = false;
    u18.WaitingDotsFrame:RemoveTag("UILoadingDots");
    u18.UnavailableFrame.Visible = not success;
    u18.AvailableFrame.Visible = success;

    if not success then
        return;
    end;

    local v19 = 0;

    for i = 1, #MonetizationLibrary.VideoAdRewards do
        local v20 = PlayerDataController:Get("VideoAdRewardsClaimed") % #MonetizationLibrary.VideoAdRewards + i;
        local VIDEO_AD_REWARDS_MAX_SCALE_FACTOR = MonetizationLibrary.VIDEO_AD_REWARDS_MAX_SCALE_FACTOR;
        local v21 = (PlayerDataController:Get("VideoAdRewardsClaimed") + i) / #MonetizationLibrary.VideoAdRewards;
        local math_ceil_ret = math.ceil(v21);
        local math_min_ret = math.min(VIDEO_AD_REWARDS_MAX_SCALE_FACTOR, math_ceil_ret);
        local v22 = MonetizationLibrary.VideoAdRewards[(v20 - 1) % #MonetizationLibrary.VideoAdRewards + 1];
        local u23 = i == 1;

        if i > 1 then
            local v24 = u18:_CreateArrow();
            v24.LayoutOrder = v19;
            v24.Parent = u18.RewardsFrame;
            table.insert(u18._cleanup, v24);
            v19 = v19 + 1;
        end;

        local v25 = { v22.RewardDatas };

        if PlayerDataController:Get("VideoAdRewardsClaimed") + i <= #MonetizationLibrary.VideoAdRewards then
            table.insert(v25, v22.PreRepetitionRewardDatas);
        end;

        local _ = i;
        local v26 = 0;

        for _, v in pairs(v25) do
            v26 = v26 + #v;
        end;

        local v27 = 0;

        for _, v in pairs(v25) do
            for _, v2 in pairs(v) do
                v27 = v27 + 1;
                v19 = v19 + 1;
                local v28 = Utility:CloneTable(v2);
                v28.Quantity = (v28.Quantity or 1) * math_min_ret;
                local u29 = VideoAdRewardSlot:Clone();
                u29.Button.Visible = v27 == 1;
                u29.Button.Position = UDim2.new(v26 * 0.5, 0, u18._buttons_position_y or 1.25, 0);
                u29.Button.Unlocked.Title.Text = string.format("%s <font size=\"8\">/ %s</font>", PlayerDataController:Get("VideoAdsWatchedBeforeClaiming"), v22.NumAdsRequired);
                u29.Button.Unlocked.Visible = u23;
                u29.Button.Locked.Visible = not u23;
                u29.LayoutOrder = v19;
                u29.Parent = u18.RewardsFrame;
                table.insert(u18._cleanup, u29);
                local v30 = RewardSlot.new(v28);
                v30:SetParent(u29);
                table.insert(u18._cleanup, v30);

                local function update() -- Line: 205
                    -- upvalues: u29 (copy)
                    u29.Button.Unlocked.Title.Position = UDim2.new(0.5, u29.Button.Unlocked.Title.Icon.AbsoluteSize.X * 0.4, 0.5, 0);
                    u29.Button.Unlocked.Title.Icon.Position = UDim2.new(0.5, -u29.Button.Unlocked.Title.TextBounds.X / 2, 0.5, 0);
                end;

                u29.Button.Unlocked.Title.Icon:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
                u29.Button.Unlocked.Title:GetPropertyChangedSignal("TextBounds"):Connect(update);
                update();

                if u23 then
                    u29.Button.MouseButton1Click:Connect(function() -- Line: 215
                        -- upvalues: u23 (copy), u18 (copy), ReplicatedStorage (ref)
                        if not u23 then
                            return;
                        end;

                        u18.PlayedAd:Fire();
                        ReplicatedStorage.Remotes.Misc.PlayVideoAdShopOffer:FireServer();
                    end);
                    ButtonEffect:Add(u29.Button);
                end;
            end;
        end;
    end;
end;

function u1._CreateArrow(p31) -- Line: 232
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://133426948634565";
    ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    ImageLabel.Size = UDim2.new(0.5, 0, 0.25, 0);
    ImageLabel.ScaleType = Enum.ScaleType.Fit;

    return ImageLabel;
end;

function u1._Init(u32) -- Line: 243
    -- upvalues: PlayerDataController (copy)
    u32.AvailableFrame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 244
        -- upvalues: u32 (copy)
        u32.AvailabilityChanged:Fire();
    end);
    local _connections = u32._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("VideoAdRewardsClaimed");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 248
        -- upvalues: u32 (copy)
        u32:Update();
    end));
    local _connections2 = u32._connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("VideoAdsWatchedBeforeClaiming");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 252
        -- upvalues: u32 (copy)
        u32:Update();
    end));
end;

return u1;