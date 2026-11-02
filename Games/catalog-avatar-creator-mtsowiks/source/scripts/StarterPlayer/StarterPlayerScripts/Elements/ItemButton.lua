-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local UserInputService = game:GetService("UserInputService");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local ItemPreviewService = require(Modules.Services.ItemPreviewService);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local FavoriteController = require(Modules.Controllers.FavoriteController);
local FavoriteButton = require(Modules.Elements.FavoriteButton);
local Cache = require(Modules.Services.Cache);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
require(Modules.Controllers.ShoppingCartController);
local BezierMover = require(Modules.Utilities.BezierMover);
local ItemPurchaseService = require(Modules.Services.ItemPurchaseService);
local RecentController = require(Modules.Controllers.RecentController);
local ProfileBackgroundController = require(Modules.Controllers.ProfileBackgroundController);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local TryOnItem = Remotes:WaitForChild("TryOnItem");
local TakeOffItem = Remotes:WaitForChild("TakeOffItem");
local Events = script.Parent.Parent:WaitForChild("Events");

local function getSetting(p1) -- Line: 32
    -- upvalues: Events (copy)
    if not Events.GetSetting:GetAttribute("bound") then
        Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
    end;

    return Events.GetSetting:Invoke(p1);
end;

local LocalPlayer = Players.LocalPlayer;
local item = script:FindFirstChild("item");
local restriction = script:FindFirstChild("restriction");
local label = script:FindFirstChild("label");
local contextButtons = script:FindFirstChild("contextButtons");
local equipped = script:FindFirstChild("equipped");
local itemOnlyIcon = script:FindFirstChild("itemOnlyIcon");
local itemType = script:FindFirstChild("itemType");
local favorite = script:FindFirstChild("favorite");
local u2 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u4 = nil;
local u5 = nil;
local u6 = nil;

if UserInputService.TouchEnabled then
    local _ = not UserInputService.MouseEnabled;
end;

local u7 = nil;
UserInputService.InputEnded:Connect(function(p8) -- Line: 68
    -- upvalues: UserInputService (copy), u7 (ref)
    if p8.UserInputType == Enum.UserInputType.Touch then
        task.defer(function() -- Line: 70
            -- upvalues: UserInputService (ref), u7 (ref)
            if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                u7 = nil;
            end;
        end);
    end;
end);
local u9 = false;
local u10 = UDim2.fromScale(0.155, 0.776);

local function dprint(...) -- Line: 87
end;

local Readable = require(Modules.Utilities.Readable);

local function removeContextButtons(u11, p12) -- Line: 95
    -- upvalues: TweenService (copy)
    if not u11 then
        return;
    end;

    for _, descendant in u11:GetDescendants() do
        if descendant:IsA("TextButton") then
            TweenService:Create(descendant, p12, {
                BackgroundTransparency = 1
            }):Play();
            TweenService:Create(descendant, p12, {
                TextTransparency = 1
            }):Play();
        elseif descendant:IsA("ImageLabel") then
            TweenService:Create(descendant, p12, {
                ImageTransparency = 1
            }):Play();
        elseif descendant:IsA("UIStroke") then
            TweenService:Create(descendant, p12, {
                Transparency = 1
            }):Play();
        end;
    end;

    TweenService:Create(u11, p12, {
        BackgroundTransparency = 1
    }):Play();
    task.delay(p12.Time, function() -- Line: 112
        -- upvalues: u11 (copy)
        if u11 and u11.Parent then
            u11:Destroy();
        end;
    end);
end;

local function clearContextButtons() -- Line: 119
    -- upvalues: u5 (ref), u4 (ref), removeContextButtons (copy), u2 (copy), u9 (ref)
    if not u5 then
        return;
    end;

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    removeContextButtons(u5, u2);
    u5 = nil;
    u9 = false;
end;

local function beginShimmer(p13) -- Line: 132
    -- upvalues: TweenService (copy)
    for _, child in p13:GetChildren() do
        local UIGradient = child:FindFirstChild("UIGradient");

        if UIGradient then
            TweenService:Create(UIGradient, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, -1), {
                Offset = Vector2.new(1, 0)
            }):Play();
        end;
    end;
end;

local function removeShimmerPart(p14, p15) -- Line: 141
    -- upvalues: TweenService (copy), u3 (copy)
    local skeleton = p14:FindFirstChild("skeleton");

    if not skeleton then
        return;
    end;

    local u16 = skeleton:FindFirstChild(p15);

    if u16 then
        local v17 = TweenService:Create(u16, u3, {
            BackgroundTransparency = 1
        });
        v17:Play();
        v17.Completed:Once(function() -- Line: 149
            -- upvalues: u16 (copy), skeleton (copy)
            if u16 and u16.Parent then
                u16:Destroy();

                if #skeleton:GetChildren() == 0 then
                    skeleton:Destroy();
                end;
            end;
        end);
    end;
end;

local u18 = {
    Buttons = {}
};
local creditChip = script:FindFirstChild("creditChip");
local u19 = nil;
local u20 = 0;
local u21 = nil;

local function hideCreditChip() -- Line: 172
    -- upvalues: u20 (ref), u21 (ref), u19 (ref), TweenService (copy), u3 (copy)
    u20 = u20 + 1;
    local u22 = u20;

    if u21 then
        u21:Cancel();
        u21 = nil;
    end;

    local u23 = u19;

    if not (u23 and u23.Parent) then
        return;
    end;

    TweenService:Create(u23, u3, {
        BackgroundTransparency = 1
    }):Play();
    TweenService:Create(u23.shine, u3, {
        BackgroundTransparency = 1
    }):Play();
    TweenService:Create(u23.content.icon, u3, {
        ImageTransparency = 1
    }):Play();
    local v24 = TweenService:Create(u23.content.amount, u3, {
        TextTransparency = 1
    });
    v24:Play();
    v24.Completed:Once(function() -- Line: 186
        -- upvalues: u20 (ref), u22 (copy), u23 (copy)
        if u20 == u22 and u23.Parent then
            u23.Parent = nil;
        end;
    end);
end;

local function showCreditChip(u25) -- Line: 194
    -- upvalues: creditChip (copy), ReplicatedStorage (copy), hideCreditChip (copy), u20 (ref), u19 (ref), CatalogUtilities (copy), TweenService (copy), u3 (copy), u21 (ref)
    if not creditChip then
        return;
    end;

    if ReplicatedStorage:GetAttribute("CreditChipEnabled") ~= true then
        return;
    end;

    if ReplicatedStorage:GetAttribute("ExclusiveShopEnabled") ~= true then
        return;
    end;

    local v26 = ReplicatedStorage:GetAttribute("CreditsEarnRate");
    local v27 = u25:GetAttribute("basePrice");

    if typeof(v26) ~= "number" or (typeof(v27) ~= "number" or v27 <= 0) then
        hideCreditChip();

        return;
    end;

    u20 = u20 + 1;
    local u28 = u20;
    local u29 = u19;

    if u29 and not pcall(function() -- Line: 212
        -- upvalues: u29 (ref), u25 (copy)
        u29.Parent = u25;
    end) then
        u29 = nil;
    end;

    if not u29 then
        u29 = creditChip:Clone();
        u19 = u29;
        u29.Parent = u25;
    end;

    local content = u29.content;
    content.amount.Text = "+" .. CatalogUtilities.FormatNumberDetailed(v27 * v26);
    local v30 = math.round(u25.AbsoluteSize.Y * 0.103);
    local u31 = math.clamp(v30, 20, 40);
    local u32 = math.round(u31 * 0.62);
    local u33 = math.round(u32 * 0.25);
    local u34 = math.round((u31 - u32) * 0.4);
    content.UIListLayout.Padding = UDim.new(0, u33);
    content.amount.Size = UDim2.new(0, u31 * 4, 0.62, 0);
    u29.Size = UDim2.fromOffset(u31 * 6, u31);
    u29.BackgroundTransparency = 1;
    u29.shine.BackgroundTransparency = 1;
    content.icon.ImageTransparency = 1;
    content.amount.TextTransparency = 1;
    task.spawn(function() -- Line: 238
        -- upvalues: u20 (ref), u28 (copy), u29 (ref), u25 (copy), content (copy), u32 (copy), u33 (copy), u34 (copy), u31 (copy), TweenService (ref), u3 (ref), u21 (ref)
        task.wait();
        task.wait();

        if u20 ~= u28 or u29.Parent ~= u25 then
            return;
        end;

        local v35 = math.ceil(content.amount.TextBounds.X);
        content.amount.Size = UDim2.new(0, v35, 0.62, 0);
        u29.Size = UDim2.fromOffset(u32 + u33 + v35 + u34 * 2, u31);
        TweenService:Create(u29, u3, {
            BackgroundTransparency = 0
        }):Play();
        TweenService:Create(u29.shine, u3, {
            BackgroundTransparency = 0
        }):Play();
        TweenService:Create(content.icon, u3, {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(content.amount, u3, {
            TextTransparency = 0
        }):Play();
        local UIGradient = u29.shine.UIGradient;
        UIGradient.Offset = Vector2.new(-0.8, 0);

        if u21 then
            u21:Cancel();
        end;

        u21 = TweenService:Create(UIGradient, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false, 1.6), {
            Offset = Vector2.new(0.8, 0)
        });
        u21:Play();
    end);
end;

local function setupInteractions(u36, u37, u38) -- Line: 264
    -- upvalues: u7 (ref), u6 (ref), showCreditChip (copy), hideCreditChip (copy), u5 (ref), u4 (ref), removeContextButtons (copy), u2 (copy), u9 (ref), Players (copy), Events (copy), AvatarEditorService (copy), LocalPlayer (copy), u18 (copy)
    local viewItem = u36:FindFirstChild("viewItem");

    if not viewItem then
        return;
    end;

    local function onHover() -- Line: 268
        -- upvalues: u7 (ref), u36 (copy), u6 (ref), showCreditChip (ref)
        if u7 and u7 ~= u36 then
            return;
        end;

        if u6 and u6 ~= u36 then
            u6:SetAttribute("isHovered", false);
        end;

        u6 = u36;
        u36:SetAttribute("isHovered", true);
        showCreditChip(u36);
    end;

    local function onUnhover() -- Line: 286
        -- upvalues: u6 (ref), u36 (copy), hideCreditChip (ref)
        if u6 == u36 then
            u6 = nil;
        end;

        u36:SetAttribute("isHovered", false);
        hideCreditChip();
    end;

    viewItem.SelectionGained:Connect(onHover);
    viewItem.SelectionLost:Connect(onUnhover);
    viewItem.MouseEnter:Connect(onHover);
    viewItem.MouseLeave:Connect(onUnhover);
    local u39 = false;
    local u40 = nil;
    local u41 = nil;

    local function cancelLongPress() -- Line: 303
        -- upvalues: u40 (ref), u41 (ref)
        u40 = nil;

        if u41 then
            pcall(task.cancel, u41);
            u41 = nil;
        end;
    end;

    local function triggerOutfitInspect() -- Line: 311
        -- upvalues: u38 (copy), u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), Players (ref), Events (ref), AvatarEditorService (ref), LocalPlayer (ref)
        if u38.ItemButtonType ~= "Outfit" then
            return;
        end;

        if u38.OutfitType ~= "RobloxOutfit" and u38.OutfitType ~= "RobloxAvatar" then
            return;
        end;

        if u5 then
            if u4 then
                u4:Disconnect();
                u4 = nil;
            end;

            removeContextButtons(u5, u2);
            u5 = nil;
            u9 = false;
        end;

        task.spawn(function() -- Line: 316
            -- upvalues: u38 (ref), Players (ref), Events (ref), AvatarEditorService (ref), LocalPlayer (ref)
            local OutfitDetails = u38.OutfitDetails;

            if u38.OutfitType == "RobloxOutfit" then
                local success, result = pcall(Players.GetHumanoidDescriptionFromOutfitIdAsync, Players, OutfitDetails.Id);

                if not (success and result) then
                    Events.Notify:Fire("⚠️ Couldn\'t load that outfit.");

                    return;
                end;

                local success2, result2 = pcall(AvatarEditorService.GetOutfitDetailsAsync, AvatarEditorService, OutfitDetails.Id);
                local v42;

                if success2 and (result2 and result2.PlayerAvatarType == "R6") then
                    v42 = Enum.HumanoidRigType.R6;
                else
                    v42 = Enum.HumanoidRigType.R15;
                end;

                Events.DisplayCurrentlyWearing:Fire(false, {
                    Source = "RobloxOutfit",
                    HumanoidDescription = result,
                    RigType = v42,
                    OutfitId = OutfitDetails.Id,
                    Title = OutfitDetails.Name or "Outfit"
                });

                return;
            end;

            local success, result = pcall(Players.GetHumanoidDescriptionFromUserId, Players, OutfitDetails.UserId);
            local success2, result2 = pcall(Players.GetCharacterAppearanceInfoAsync, Players, OutfitDetails.UserId);

            if not (success and result) then
                Events.Notify:Fire("⚠️ Couldn\'t load that avatar.");

                return;
            end;

            local v43 = success2 and (result2.playerAvatarType and Enum.HumanoidRigType:FromName(result2.playerAvatarType)) or Enum.HumanoidRigType.R15;
            Events.DisplayCurrentlyWearing:Fire(false, {
                Source = "RobloxAvatar",
                HumanoidDescription = result,
                RigType = v43,
                UserId = OutfitDetails.UserId,
                Title = OutfitDetails.UserId == LocalPlayer.UserId and "Your Avatar" or `@{OutfitDetails.Username or "user"}'s Avatar`
            });
        end);
    end;

    viewItem.Activated:Connect(function() -- Line: 348
        -- upvalues: u39 (ref), u7 (ref), u36 (copy), u38 (copy), u9 (ref), u5 (ref), u6 (ref), showCreditChip (ref), hideCreditChip (ref), u18 (ref), u37 (copy)
        if u39 then
            u39 = false;

            return;
        end;

        if u7 and u7 ~= u36 then
            return;
        end;

        if u38.CustomCallback then
            u38.CustomCallback();

            return;
        end;

        if u9 and (u5 and u5.Parent == u36) then
            if not u7 or u7 == u36 then
                if u6 and u6 ~= u36 then
                    u6:SetAttribute("isHovered", false);
                end;

                u6 = u36;
                u36:SetAttribute("isHovered", true);
                showCreditChip(u36);
            end;
        else
            if u6 == u36 then
                u6 = nil;
            end;

            u36:SetAttribute("isHovered", false);
            hideCreditChip();
        end;

        u18.ShowContextButtons(u36, u37, u38);
    end);
    viewItem.InputBegan:Connect(function(u44, p45) -- Line: 376
        -- upvalues: u38 (copy), u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), Players (ref), Events (ref), AvatarEditorService (ref), LocalPlayer (ref), u40 (ref), u41 (ref), u7 (ref), u36 (copy), u6 (ref), showCreditChip (ref), u39 (ref)
        if p45 then
            return;
        end;

        if u44.UserInputType ~= Enum.UserInputType.MouseButton2 then
            if u44.UserInputType == Enum.UserInputType.Touch then
                u40 = nil;

                if u41 then
                    pcall(task.cancel, u41);
                    u41 = nil;
                end;

                u40 = u44;

                if u7 == nil then
                    u7 = u36;
                end;

                if not u7 or u7 == u36 then
                    if u6 and u6 ~= u36 then
                        u6:SetAttribute("isHovered", false);
                    end;

                    u6 = u36;
                    u36:SetAttribute("isHovered", true);
                    showCreditChip(u36);
                end;

                u41 = task.delay(0.6, function() -- Line: 393
                    -- upvalues: u40 (ref), u44 (copy), u41 (ref), u39 (ref), u38 (ref), u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), Players (ref), Events (ref), AvatarEditorService (ref), LocalPlayer (ref)
                    if u40 ~= u44 then
                        return;
                    end;

                    u40 = nil;
                    u41 = nil;
                    u39 = true;

                    if u38.ItemButtonType ~= "Outfit" then
                        return;
                    end;

                    if u38.OutfitType ~= "RobloxOutfit" and u38.OutfitType ~= "RobloxAvatar" then
                        return;
                    end;

                    if u5 then
                        if u4 then
                            u4:Disconnect();
                            u4 = nil;
                        end;

                        removeContextButtons(u5, u2);
                        u5 = nil;
                        u9 = false;
                    end;

                    task.spawn(function() -- Line: 316
                        -- upvalues: u38 (ref), Players (ref), Events (ref), AvatarEditorService (ref), LocalPlayer (ref)
                        local OutfitDetails = u38.OutfitDetails;

                        if u38.OutfitType == "RobloxOutfit" then
                            local success, result = pcall(Players.GetHumanoidDescriptionFromOutfitIdAsync, Players, OutfitDetails.Id);

                            if not (success and result) then
                                Events.Notify:Fire("⚠️ Couldn\'t load that outfit.");

                                return;
                            end;

                            local success2, result2 = pcall(AvatarEditorService.GetOutfitDetailsAsync, AvatarEditorService, OutfitDetails.Id);
                            local v46;

                            if success2 and (result2 and result2.PlayerAvatarType == "R6") then
                                v46 = Enum.HumanoidRigType.R6;
                            else
                                v46 = Enum.HumanoidRigType.R15;
                            end;

                            Events.DisplayCurrentlyWearing:Fire(false, {
                                Source = "RobloxOutfit",
                                HumanoidDescription = result,
                                RigType = v46,
                                OutfitId = OutfitDetails.Id,
                                Title = OutfitDetails.Name or "Outfit"
                            });

                            return;
                        end;

                        local success, result = pcall(Players.GetHumanoidDescriptionFromUserId, Players, OutfitDetails.UserId);
                        local success2, result2 = pcall(Players.GetCharacterAppearanceInfoAsync, Players, OutfitDetails.UserId);

                        if not (success and result) then
                            Events.Notify:Fire("⚠️ Couldn\'t load that avatar.");

                            return;
                        end;

                        local v47 = success2 and (result2.playerAvatarType and Enum.HumanoidRigType:FromName(result2.playerAvatarType)) or Enum.HumanoidRigType.R15;
                        Events.DisplayCurrentlyWearing:Fire(false, {
                            Source = "RobloxAvatar",
                            HumanoidDescription = result,
                            RigType = v47,
                            UserId = OutfitDetails.UserId,
                            Title = OutfitDetails.UserId == LocalPlayer.UserId and "Your Avatar" or `@{OutfitDetails.Username or "user"}'s Avatar`
                        });
                    end);
                end);
            end;

            return;
        end;

        if u38.ItemButtonType ~= "Outfit" then
            return;
        end;

        if u38.OutfitType ~= "RobloxOutfit" and u38.OutfitType ~= "RobloxAvatar" then
            return;
        end;

        if u5 then
            if u4 then
                u4:Disconnect();
                u4 = nil;
            end;

            removeContextButtons(u5, u2);
            u5 = nil;
            u9 = false;
        end;

        task.spawn(function() -- Line: 316
            -- upvalues: u38 (ref), Players (ref), Events (ref), AvatarEditorService (ref), LocalPlayer (ref)
            local OutfitDetails = u38.OutfitDetails;

            if u38.OutfitType == "RobloxOutfit" then
                local success, result = pcall(Players.GetHumanoidDescriptionFromOutfitIdAsync, Players, OutfitDetails.Id);

                if not (success and result) then
                    Events.Notify:Fire("⚠️ Couldn\'t load that outfit.");

                    return;
                end;

                local success2, result2 = pcall(AvatarEditorService.GetOutfitDetailsAsync, AvatarEditorService, OutfitDetails.Id);
                local v48;

                if success2 and (result2 and result2.PlayerAvatarType == "R6") then
                    v48 = Enum.HumanoidRigType.R6;
                else
                    v48 = Enum.HumanoidRigType.R15;
                end;

                Events.DisplayCurrentlyWearing:Fire(false, {
                    Source = "RobloxOutfit",
                    HumanoidDescription = result,
                    RigType = v48,
                    OutfitId = OutfitDetails.Id,
                    Title = OutfitDetails.Name or "Outfit"
                });

                return;
            end;

            local success, result = pcall(Players.GetHumanoidDescriptionFromUserId, Players, OutfitDetails.UserId);
            local success2, result2 = pcall(Players.GetCharacterAppearanceInfoAsync, Players, OutfitDetails.UserId);

            if not (success and result) then
                Events.Notify:Fire("⚠️ Couldn\'t load that avatar.");

                return;
            end;

            local v49 = success2 and (result2.playerAvatarType and Enum.HumanoidRigType:FromName(result2.playerAvatarType)) or Enum.HumanoidRigType.R15;
            Events.DisplayCurrentlyWearing:Fire(false, {
                Source = "RobloxAvatar",
                HumanoidDescription = result,
                RigType = v49,
                UserId = OutfitDetails.UserId,
                Title = OutfitDetails.UserId == LocalPlayer.UserId and "Your Avatar" or `@{OutfitDetails.Username or "user"}'s Avatar`
            });
        end);
    end);
    viewItem.InputEnded:Connect(function(p50) -- Line: 403
        -- upvalues: u40 (ref), u41 (ref)
        if u40 == p50 then
            u40 = nil;

            if u41 then
                pcall(task.cancel, u41);
                u41 = nil;
            end;
        end;
    end);
    viewItem.MouseLeave:Connect(cancelLongPress);
end;

function u18.ShowContextButtons(u51, u52, u53) -- Line: 415
    -- upvalues: FavoriteButton (copy), u9 (ref), u5 (ref), u4 (ref), removeContextButtons (copy), u2 (copy), contextButtons (copy), Events (copy), ThemeController (copy), ProfileBackgroundController (copy), RecentController (copy), CatalogUtilities (copy), dprint (copy), TakeOffItem (copy), LocalPlayer (copy), HumanoidDescriptionController (copy), Cache (copy), TryOnItem (copy), ItemPurchaseService (copy), BezierMover (copy), u18 (copy), AvatarEditorService (copy), Remotes (copy), TweenService (copy), OutsideClickDetector (copy)
    FavoriteButton.DismissActiveTouchSticky();

    if u9 then
        if u5 and u5.Parent == u51 then
            if not u5 then
                return;
            end;

            if u4 then
                u4:Disconnect();
                u4 = nil;
            end;

            removeContextButtons(u5, u2);
            u5 = nil;
            u9 = false;

            return;
        end;

        if u5 then
            if u4 then
                u4:Disconnect();
                u4 = nil;
            end;

            removeContextButtons(u5, u2);
            u5 = nil;
            u9 = false;
        end;
    end;

    u9 = true;
    local v54;

    if u53.ItemButtonType == "Item" then
        v54 = u52.AssetType and u52.AssetType == "HeadShape";
    else
        v54 = false;
    end;

    local u55 = nil;

    if u53.ItemButtonType == "Item" then
        if u53.IsEmote then
            u55 = script.contextButtonsEmote:Clone();
        elseif v54 then
            u55 = script.contextButtonsHeadShape:Clone();
        else
            u55 = contextButtons:Clone();
        end;
    elseif u53.ItemButtonType == "Pose" then
        u55 = script.contextButtonsPose:Clone();
    elseif u53.ItemButtonType == "BodyPreset" then
        u55 = script.contextButtonsBodyPreset:Clone();
    elseif u53.ItemButtonType == "Outfit" then
        if u53.OutfitType == "RobloxOutfit" or u53.OutfitType == "RobloxAvatar" then
            if u53.CanEditOutfit then
                u55 = script.contextButtonsRobloxOutfitEditable:Clone();
            else
                u55 = script.contextButtonsRobloxOutfit:Clone();
            end;
        elseif u53.OutfitType == "SavedOutfit" then
            u55 = script.contextButtonsSavedOutfit:Clone();
        elseif u53.OutfitType == "CommunityOutfit" then
            u55 = script.contextButtonsCommunityOutfit:Clone();
        end;
    end;

    u5 = u55;

    local function getBtn(p56) -- Line: 456
        -- upvalues: u55 (ref)
        local v57 = u55:FindFirstChild(p56) or u55:FindFirstChild("row1") and u55.row1:FindFirstChild(p56) or u55:FindFirstChild("row2") and u55.row2:FindFirstChild(p56) or u55:FindFirstChild("bottomButtons") and u55.bottomButtons:FindFirstChild(p56);

        return v57;
    end;

    if u53.ItemButtonType == "Item" then
        local v58 = getBtn("tryOn");
        local v59 = getBtn("buy");
        local v60 = getBtn("inspect");
        local u61 = getBtn("addToCart");

        if u53.OnlyIcon then
            u55.Size = UDim2.fromScale(1, 1);
            u55.Position = UDim2.fromScale(0.5, 0.5);
        end;

        local u62 = Events.IsItemInCart:Invoke((tostring(u52.Id)));

        if u62 == true and (v54 ~= true and u61) then
            u61.image.Image = "rbxassetid://136928537809738";
        end;

        if (u51:GetAttribute("isEquipped") or u53.IsEquipped) == true and v58 then
            v58.Text = "Take Off";
            v58.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(255, 95, 92));
        end;

        v58.Activated:Connect(function() -- Line: 485
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u52 (copy), u51 (copy), u53 (copy), ProfileBackgroundController (ref), RecentController (ref), CatalogUtilities (ref), dprint (ref), TakeOffItem (ref), LocalPlayer (ref), Events (ref), HumanoidDescriptionController (ref), Cache (ref), TryOnItem (ref)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u52.AssetType == "AvatarBackground" then
                if u51:GetAttribute("isEquipped") == true or u53.IsEquipped then
                    ProfileBackgroundController.Unequip();

                    return;
                end;

                if ProfileBackgroundController.Equip(u52) then
                    RecentController.TrackItem(u52);
                end;

                return;
            end;

            local v63;

            if u52.AssetType == "HeadShape" then
                v63 = "HeadShape";
            elseif u52.AssetType then
                v63 = CatalogUtilities.GetAssetTypeName(u52.AssetType);
            else
                v63 = nil;
            end;

            local v64, v65;

            if u51:GetAttribute("isEquipped") == true or u53.IsEquipped then
                dprint("attempt to unequip item", u52.ItemType, v63);
                v64, v65 = TakeOffItem:InvokeServer(u52.Id, u52.ItemType, v63);
            else
                if v63 == "EmoteAnimation" then
                    local Character = LocalPlayer.Character;

                    if Character then
                        Character = Character:FindFirstChildWhichIsA("Humanoid");
                    end;

                    if Character and Character.RigType == Enum.HumanoidRigType.R6 then
                        Events.Notify:Fire("🕺 You must set your Rig Type to R15 for emotes.");

                        return;
                    end;
                end;

                if v63 == "HeadShape" and HumanoidDescriptionController.EquippedHeadSupportsHeadShapes() == false then
                    Events.Notify:Fire("❌ Your head does not support Head Shapes.");

                    return;
                end;

                dprint("attempt to equip item", u52.ItemType, v63);
                dprint("[CommandsDebug] TryOnItem args:", u52.Id, u52.ItemType, v63);
                Cache.Set(u52.ItemType .. "Name", tostring(u52.Id), u52.Name, 600);
                v64, v65 = TryOnItem:InvokeServer(u52.Id, u52.ItemType, v63);

                if v64 then
                    RecentController.TrackItem(u52);
                end;
            end;

            if v64 ~= true then
                warn("Something went wrong:", v65);
            end;
        end);

        if not v54 then
            v59.Activated:Connect(function() -- Line: 537
                -- upvalues: ItemPurchaseService (ref), u52 (copy), u53 (copy)
                ItemPurchaseService.PromptItemPurchase(u52, u53.PurchaseContext);
            end);
            v60.Activated:Connect(function() -- Line: 541
                -- upvalues: u52 (copy), Events (ref), u53 (copy)
                if u52.AssetType == "HeadShape" then
                    Events.Notify:Fire("This is a Head Shape. This can be edited under \'Adjust Body\' -> \'Head Shapes\'.");

                    return;
                end;

                Events.DisplayContentPage:Fire({
                    Type = "ItemDetails",
                    Item = u52,
                    PurchaseContext = u53.PurchaseContext
                });
            end);
            u61.Activated:Connect(function() -- Line: 558
                -- upvalues: u62 (ref), Events (ref), u52 (copy), BezierMover (ref), u51 (copy), u18 (ref), u61 (copy)
                local v66;

                if u62 then
                    local v67;
                    v66, v67 = Events.ShoppingCartRemoveItem:Invoke(u52.Id, u52.ItemType);
                else
                    local v68;
                    v66, v68 = Events.ShoppingCartAddItem:Invoke(u52.Id, u52.ItemType);
                end;

                if v66 then
                    if u62 then
                        BezierMover.Cancel((tostring(u52.Id)));
                    else
                        BezierMover.CurveTransition(u51.preview, u18.CartPosition, (tostring(u52.Id)));
                    end;

                    u61.image.Image = u62 and "rbxassetid://80442995407260" or "rbxassetid://136928537809738";
                    u62 = not u62;
                end;
            end);
        end;

        local v69 = u53.IsEmote and getBtn("pose");

        if v69 then
            v69.Activated:Connect(function() -- Line: 580
                -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), Events (ref), u52 (copy)
                if u5 then
                    if u4 then
                        u4:Disconnect();
                        u4 = nil;
                    end;

                    removeContextButtons(u5, u2);
                    u5 = nil;
                    u9 = false;
                end;

                Events.ApplyEmoteKeyframe:Fire(u52.Id);
            end);
        end;
    elseif u53.ItemButtonType == "Pose" then
        local PoseDetails = u53.PoseDetails;
        u55.tryOn.Activated:Connect(function() -- Line: 589
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), PoseDetails (copy)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u53.OnApply then
                u53.OnApply(PoseDetails);
            end;
        end);
        u55.delete.Activated:Connect(function() -- Line: 594
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), PoseDetails (copy)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u53.OnDelete then
                u53.OnDelete(PoseDetails);
            end;
        end);
        u55.update.Activated:Connect(function() -- Line: 599
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), PoseDetails (copy)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u53.OnUpdate then
                u53.OnUpdate(PoseDetails);
            end;
        end);
        u55.rename.Activated:Connect(function() -- Line: 604
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), PoseDetails (copy)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u53.OnRename then
                u53.OnRename(PoseDetails);
            end;
        end);
    elseif u53.ItemButtonType == "BodyPreset" then
        local PoseDetails = u53.PoseDetails;
        u55.update.Activated:Connect(function() -- Line: 611
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), PoseDetails (copy)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u53.OnUpdate then
                u53.OnUpdate(PoseDetails);
            end;
        end);
        u55.rename.Activated:Connect(function() -- Line: 616
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), PoseDetails (copy)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u53.OnRename then
                u53.OnRename(PoseDetails);
            end;
        end);
        u55.delete.Activated:Connect(function() -- Line: 621
            -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), PoseDetails (copy)
            if u5 then
                if u4 then
                    u4:Disconnect();
                    u4 = nil;
                end;

                removeContextButtons(u5, u2);
                u5 = nil;
                u9 = false;
            end;

            if u53.OnDelete then
                u53.OnDelete(PoseDetails);
            end;
        end);
    elseif u53.ItemButtonType == "Outfit" then
        local OutfitDetails = u53.OutfitDetails;

        local function handleAvatarEditorServicePrompt(p70, ...) -- Line: 628
            -- upvalues: AvatarEditorService (ref), Events (ref), u53 (copy), u51 (copy), OutfitDetails (copy), LocalPlayer (ref)
            AvatarEditorService[p70](AvatarEditorService, ...);
            local Name = AvatarEditorService[p70 .. "Completed"]:Wait().Name;

            if p70 == "PromptRenameOutfit" then
                if Name == "Success" then
                    Events.Notify:Fire("✅ Successfully renamed your outfit.");

                    if u53.RefreshOutfits then
                        u53.RefreshOutfits();
                    end;
                else
                    if Name == "PermissionDenied" then
                        Events.Notify:Fire("❌ Couldn\'t rename outfit without your permission.");

                        return;
                    end;

                    if Name == "Failed" then
                        Events.Notify:Fire("⚠️ Something went wrong. Please try again.");
                    end;
                end;
            elseif p70 == "PromptDeleteOutfit" then
                if Name == "Success" then
                    Events.Notify:Fire("✅ Successfully deleted your outfit.");
                    u51:Destroy();

                    return;
                end;

                if Name == "PermissionDenied" then
                    Events.Notify:Fire("❌ Couldn\'t delete outfit without your permission.");

                    return;
                end;

                if Name == "Failed" then
                    Events.Notify:Fire("⚠️ Something went wrong. Please try again.");
                end;
            elseif p70 == "PromptUpdateOutfit" then
                if Name == "Success" then
                    Events.Notify:Fire("✅ Successfully updated your outfit.");

                    if u53.RefreshOutfits then
                        u53.RefreshOutfits();
                    end;
                else
                    if Name == "PermissionDenied" then
                        Events.Notify:Fire("❌ Couldn\'t update outfit without your permission.");

                        return;
                    end;

                    if Name == "Failed" then
                        Events.Notify:Fire("⚠️ Something went wrong. Please try again.");
                        Events.Notify:Fire("This can happen when you don\'t own all items in your outfit.");
                    end;
                end;
            elseif p70 == "PromptSaveAvatar" then
                if Name == "Success" then
                    Events.Notify:Fire("✅ Successfully saved to your avatar.");

                    if OutfitDetails.UserId == LocalPlayer.UserId then
                        Events.Notify:Fire("💡Tip: You can do this by pressing the ⬆️ button on the bottom of your screen.");
                    end;
                else
                    if Name == "PermissionDenied" then
                        Events.Notify:Fire("❌ Couldn\'t save avatar without your permission.");

                        return;
                    end;

                    if Name == "Failed" then
                        Events.Notify:Fire("⚠️ Something went wrong. Please try again.");
                    end;
                end;
            end;
        end;

        if u53.OutfitType == "RobloxAvatar" or u53.OutfitType == "RobloxOutfit" then
            local v71 = OutfitDetails.UserId == LocalPlayer.UserId and true or u53.CanEditOutfit == true;

            if not v71 then
                u55.update:Destroy();
            end;

            if u53.OutfitType == "RobloxAvatar" and v71 then
                u55.update.Activated:Connect(function() -- Line: 684
                    -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), handleAvatarEditorServicePrompt (copy), HumanoidDescriptionController (ref)
                    if u5 then
                        if u4 then
                            u4:Disconnect();
                            u4 = nil;
                        end;

                        removeContextButtons(u5, u2);
                        u5 = nil;
                        u9 = false;
                    end;

                    handleAvatarEditorServicePrompt("PromptSaveAvatar", HumanoidDescriptionController.GetCurrentDescription(), HumanoidDescriptionController.GetRigType());
                end);
            end;

            u55.tryOn.Activated:Connect(function() -- Line: 693
                -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), Remotes (ref), OutfitDetails (copy), Events (ref), LocalPlayer (ref)
                if u5 then
                    if u4 then
                        u4:Disconnect();
                        u4 = nil;
                    end;

                    removeContextButtons(u5, u2);
                    u5 = nil;
                    u9 = false;
                end;

                if u53.OutfitType == "RobloxOutfit" then
                    local v72, _ = Remotes.TryOnOutfit:InvokeServer(OutfitDetails.Id);

                    if v72 then
                        Events.Notify:Fire("✅ Your outfit was set to \'<b>" .. OutfitDetails.Name .. "</b>\'");
                    end;
                elseif u53.OutfitType == "RobloxAvatar" then
                    local v73, _ = Remotes.TryOnRobloxAvatar:InvokeServer(OutfitDetails.UserId);

                    if v73 then
                        if OutfitDetails.UserId == LocalPlayer.UserId then
                            Events.Notify:Fire("✅ Your outfit was set to your avatar.");
                            Events.Notify:Fire("💡Tip: You can do this by pressing the 🔄 button on the bottom of your screen.");

                            return;
                        end;

                        Events.Notify:Fire("✅ Your outfit was set to " .. OutfitDetails.Username .. "\'s avatar");
                    end;
                end;
            end);

            if u53.CanEditOutfit then
                u55.update.Activated:Connect(function() -- Line: 714
                    -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), handleAvatarEditorServicePrompt (copy), OutfitDetails (copy), HumanoidDescriptionController (ref)
                    if u5 then
                        if u4 then
                            u4:Disconnect();
                            u4 = nil;
                        end;

                        removeContextButtons(u5, u2);
                        u5 = nil;
                        u9 = false;
                    end;

                    if u53.OutfitType == "RobloxOutfit" then
                        handleAvatarEditorServicePrompt("PromptUpdateOutfit", OutfitDetails.Id, HumanoidDescriptionController.GetCurrentDescription(), HumanoidDescriptionController.GetRigType());
                    end;
                end);
                u55.delete.Activated:Connect(function() -- Line: 722
                    -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), handleAvatarEditorServicePrompt (copy), OutfitDetails (copy)
                    if u5 then
                        if u4 then
                            u4:Disconnect();
                            u4 = nil;
                        end;

                        removeContextButtons(u5, u2);
                        u5 = nil;
                        u9 = false;
                    end;

                    if u53.OutfitType == "RobloxOutfit" then
                        handleAvatarEditorServicePrompt("PromptDeleteOutfit", OutfitDetails.Id);
                    end;
                end);
                u55.rename.Activated:Connect(function() -- Line: 730
                    -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), u53 (copy), handleAvatarEditorServicePrompt (copy), OutfitDetails (copy)
                    if u5 then
                        if u4 then
                            u4:Disconnect();
                            u4 = nil;
                        end;

                        removeContextButtons(u5, u2);
                        u5 = nil;
                        u9 = false;
                    end;

                    if u53.OutfitType == "RobloxOutfit" then
                        handleAvatarEditorServicePrompt("PromptRenameOutfit", OutfitDetails.Id);
                    end;
                end);
            end;
        elseif u53.OutfitType == "SavedOutfit" then
            u55.tryOn.Activated:Connect(function() -- Line: 739
                -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), Remotes (ref), OutfitDetails (copy), Events (ref)
                if u5 then
                    if u4 then
                        u4:Disconnect();
                        u4 = nil;
                    end;

                    removeContextButtons(u5, u2);
                    u5 = nil;
                    u9 = false;
                end;

                local v74, _ = Remotes.TryOnSavedOutfit:InvokeServer(OutfitDetails.Id);

                if v74 then
                    Events.Notify:Fire("✅ Successfully wore outfit \'<b>" .. OutfitDetails.Name .. "</b>\'!");

                    return;
                end;

                Events.Notify:Fire("❌ Something went wrong. Please try again.");
            end);
            u55.viewDetails.Activated:Connect(function() -- Line: 749
                -- upvalues: Events (ref), OutfitDetails (copy)
                Events.DisplayContentPage:Fire({
                    Type = "SavedOutfit",
                    OutfitDetails = OutfitDetails
                });
            end);
        elseif u53.OutfitType == "CommunityOutfit" then
            u55.tryOn.Activated:Connect(function() -- Line: 756
                -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref), Remotes (ref), OutfitDetails (copy), Events (ref), u53 (copy)
                if u5 then
                    if u4 then
                        u4:Disconnect();
                        u4 = nil;
                    end;

                    removeContextButtons(u5, u2);
                    u5 = nil;
                    u9 = false;
                end;

                local v75, _ = Remotes.CommunityOutfitsAction:InvokeServer("TryOnOutfit", OutfitDetails.Id);

                if v75 then
                    Events.Notify:Fire("✅ Successfully wore outfit \'<b>" .. OutfitDetails.Name .. "</b>\'!");

                    if u53.OnTryOn then
                        u53.OnTryOn();
                    end;
                else
                    Events.Notify:Fire("❌ Something went wrong. Please try again.");
                end;
            end);
            u55.viewDetails.Activated:Connect(function() -- Line: 767
                -- upvalues: Events (ref), OutfitDetails (copy)
                Events.DisplayContentPage:Fire({
                    Type = "CommunityOutfit",
                    OutfitDetails = OutfitDetails
                });
            end);
        end;
    end;

    u55.Parent = u51;
    local v76 = u55:GetDescendants();

    for _, v in v76 do
        if v:IsA("TextButton") then
            v.BackgroundTransparency = 1;
            v.TextTransparency = 1;
        elseif v:IsA("ImageLabel") then
            v.ImageTransparency = 1;
        elseif v:IsA("UIStroke") then
            v.Transparency = 1;
        end;
    end;

    u55.BackgroundTransparency = 1;

    for _, v in v76 do
        if v:IsA("TextButton") then
            local v77 = v:FindFirstChildWhichIsA("ImageLabel") ~= nil and 0.7 or 0;
            TweenService:Create(v, u2, {
                TextTransparency = v77
            }):Play();
            TweenService:Create(v, u2, {
                BackgroundTransparency = v77
            }):Play();
        elseif v:IsA("ImageLabel") then
            TweenService:Create(v, u2, {
                ImageTransparency = 0
            }):Play();
        elseif v:IsA("UIStroke") then
            TweenService:Create(v, u2, {
                Transparency = 0
            }):Play();
        end;
    end;

    TweenService:Create(u55, u2, {
        BackgroundTransparency = 0.75
    }):Play();

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    u4 = OutsideClickDetector({ u55 }, function() -- Line: 810
        -- upvalues: u5 (ref), u4 (ref), removeContextButtons (ref), u2 (ref), u9 (ref)
        if not u5 then
            return;
        end;

        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        removeContextButtons(u5, u2);
        u5 = nil;
        u9 = false;
    end);
end;

function u18.newOutfit(p78) -- Line: 815
    -- upvalues: CatalogUtilities (copy), beginShimmer (copy), AvatarPreviewController (copy), TweenService (copy), u2 (copy), u18 (copy), removeShimmerPart (copy), FavoriteButton (copy), favorite (copy), FavoriteController (copy), u3 (copy), u9 (ref), u5 (ref), setupInteractions (copy)
    local u79 = p78 or {};
    u79.ItemButtonType = "Outfit";
    local u80 = u79.OutfitDetails or {};
    local IsFavoriteAvailable = u79.IsFavoriteAvailable;
    local SkeletonLoading = u79.SkeletonLoading;
    local v81 = {};
    local u82 = script[u79.OutfitType == "CommunityOutfit" and not u79.NoPrice and "communityOutfit" or "itemOnlyName"]:Clone();

    if not SkeletonLoading then
        u82:FindFirstChild("skeleton"):Destroy();
    end;

    local u83 = nil;

    if u79.OutfitType == "RobloxOutfit" then
        u80 = CatalogUtilities.NormalizeRobloxOutfitDetails(u80);
        u79.OutfitDetails = u80;
        u82.name.Text = u80.Name;
        u82.preview.image.Image = `rbxthumb://type=Outfit&id={u80.Id}&w=420&h=420`;
    elseif u79.OutfitType == "RobloxAvatar" then
        u82.name.Text = u80.Name;
        u82.preview.image.Image = `rbxthumb://type=Avatar&id={u80.UserId or 5955}&w=352&h=352`;
    elseif u79.OutfitType == "SavedOutfit" then
        u82.name.Text = u80.Name or "Outfit";
        u82:SetAttribute("outfitId", u80.Id);

        if SkeletonLoading then
            local skeleton = u82.skeleton;
            skeleton.nameShimmer:Destroy();
            beginShimmer(skeleton);
        end;

        function v81.Load() -- Line: 851
            -- upvalues: u83 (ref), u82 (copy), AvatarPreviewController (ref), u80 (ref), u79 (copy), TweenService (ref), u2 (ref), SkeletonLoading (copy)
            if u83 then
                return;
            end;

            if u82 == nil then
                return;
            end;

            task.spawn(function() -- Line: 858
                -- upvalues: u83 (ref), AvatarPreviewController (ref), u82 (ref), u80 (ref), u79 (ref), TweenService (ref), u2 (ref), SkeletonLoading (ref)
                u83 = AvatarPreviewController.new(u82.preview.viewport, u80.HumanoidDescription, {
                    IsOutfitPreview = true,
                    Context = "Outfit",
                    AccessoryAdjustments = u80.AccessoryAdjustments,
                    AccessoryAdjustments = u80.AccessoryAdjustments,
                    RigType = u80.RigType,
                    FitOutfit = u79.FitOutfit
                });

                if u82 and (u82:FindFirstChild("preview") and u82.Parent ~= nil) then
                    TweenService:Create(u82.preview.viewport, u2, {
                        ImageTransparency = 0
                    }):Play();
                    local v84 = SkeletonLoading and u82:FindFirstChild("skeleton");

                    if v84 then
                        v84:Destroy();
                    end;
                else
                    u83:Destroy();
                end;
            end);
        end;

        function v81.Unload() -- Line: 879
            -- upvalues: u83 (ref), u82 (copy)
            if not u83 then
                return;
            end;

            u82.preview.viewport.ImageTransparency = 1;

            if u83 then
                u83:Destroy();
                u83 = nil;
            end;
        end;

        u82.preview.image:Destroy();
        u82.Destroying:Connect(function() -- Line: 892
            -- upvalues: u83 (ref)
            if u83 then
                u83:Destroy();
                u83 = nil;
            end;
        end);
        v81.Load();
    elseif u79.OutfitType == "CommunityOutfit" then
        u82.name.Text = u80.Name or "Outfit";
        u82:SetAttribute("outfitId", u80.Id);

        if typeof(u80.TotalPrice) == "number" then
            u18.SetPriceLabel(u82, u80.TotalPrice == 0 and "Free" or u80.TotalPrice);

            if SkeletonLoading then
                removeShimmerPart(u82, "priceShimmer");
            end;
        end;

        if SkeletonLoading then
            beginShimmer(u82.skeleton);
        end;

        function v81.UpdateName(p85) -- Line: 919
            -- upvalues: u82 (copy), u80 (ref), SkeletonLoading (copy), removeShimmerPart (ref)
            if not (u82 and u82:FindFirstChild("preview")) then
                return;
            end;

            u80.Name = p85;
            u82.name.Text = p85 or "Outfit";

            if SkeletonLoading then
                removeShimmerPart(u82, "nameShimmer");
            end;
        end;

        function v81.UpdatePrice(p86) -- Line: 928
            -- upvalues: u82 (copy), u80 (ref), u18 (ref), SkeletonLoading (copy), removeShimmerPart (ref)
            if not (u82 and u82:FindFirstChild("price")) then
                return;
            end;

            u80.TotalPrice = p86;

            if typeof(p86) == "number" then
                u18.SetPriceLabel(u82, p86 == 0 and "Free" or p86);

                if SkeletonLoading then
                    removeShimmerPart(u82, "priceShimmer");
                end;
            end;
        end;

        function v81.Load() -- Line: 939
            -- upvalues: u83 (ref), u82 (copy), AvatarPreviewController (ref), u80 (ref), u79 (copy), TweenService (ref), u2 (ref), SkeletonLoading (copy), removeShimmerPart (ref)
            if u83 then
                return;
            end;

            if u82 == nil then
                return;
            end;

            task.defer(function() -- Line: 943
                -- upvalues: u83 (ref), u82 (ref), AvatarPreviewController (ref), u80 (ref), u79 (ref), TweenService (ref), u2 (ref), SkeletonLoading (ref), removeShimmerPart (ref)
                if u83 then
                    return;
                end;

                if not (u82 and u82:FindFirstChild("preview")) then
                    return;
                end;

                u83 = AvatarPreviewController.new(u82.preview.viewport, u80.HumanoidDescription, {
                    IsOutfitPreview = true,
                    Context = "Outfit",
                    RigType = u80.RigType,
                    FitOutfit = u79.FitOutfit
                });

                if u82.Parent == nil then
                    u83:Destroy();
                    u83 = nil;

                    return;
                end;

                TweenService:Create(u82.preview.viewport, u2, {
                    ImageTransparency = 0
                }):Play();

                if not SkeletonLoading then
                    return;
                end;

                removeShimmerPart(u82, "previewShimmer");
            end);
        end;

        function v81.Unload() -- Line: 966
            -- upvalues: u83 (ref), u82 (copy)
            if not u83 then
                return;
            end;

            u82.preview.viewport.ImageTransparency = 1;
            u83:Destroy();
            u83 = nil;
        end;

        u82.Destroying:Connect(function() -- Line: 973
            -- upvalues: u83 (ref)
            if u83 then
                u83:Destroy();
            end;
        end);
        v81.Load();

        if u82.preview:FindFirstChild("image") then
            u82.preview.image:Destroy();
        end;
    end;

    if u79.OutfitType == "SavedOutfit" or u79.OutfitType == "CommunityOutfit" then
        local u87;

        if IsFavoriteAvailable then
            u87 = FavoriteButton.Dynamic({
                Template = favorite,
                Parent = u82,
                StateHolder = u82,

                FavoriteAction = function(p88) -- Line: 991, Name: FavoriteAction
                    -- upvalues: u79 (copy), u82 (copy), FavoriteController (ref), u80 (ref)
                    if u79.OutfitType == "CommunityOutfit" then
                        u82:SetAttribute("isFavorited", p88);
                    end;

                    local v89 = FavoriteController.SetOutfitFavorited(u79.OutfitType, u80.Id, p88);

                    if not v89 and u79.OutfitType == "CommunityOutfit" then
                        u82:SetAttribute("isFavorited", not p88);
                    end;

                    return v89;
                end,

                TweenInfo = u3
            });

            if u80.IsFavorited then
                u87.Add(true, true);
            end;

            u82:SetAttribute("isFavorited", u80.IsFavorited);
        else
            u87 = nil;
        end;

        local function _() -- Line: 1008
            -- upvalues: IsFavoriteAvailable (copy), u87 (ref), u9 (ref), u5 (ref), u82 (copy), u83 (ref)
            if IsFavoriteAvailable and (u87 and (not u9 or (not u5 or u5.Parent ~= u82))) then
                u87.Add(u82:GetAttribute("isFavorited") == true);
            end;

            if u83 then
                u83:StartRotation(-0.75);
            end;
        end;

        local function _() -- Line: 1020
            -- upvalues: IsFavoriteAvailable (copy), u87 (ref), u82 (copy), u83 (ref)
            if IsFavoriteAvailable and u87 and (not u82:GetAttribute("isFavorited") and u82:GetAttribute("isHovered") ~= true) then
                u87.Remove();
            end;

            if u83 then
                u83:ResetRotation();
            end;
        end;

        u82:GetAttributeChangedSignal("isHovered"):Connect(function() -- Line: 1034
            -- upvalues: u82 (copy), IsFavoriteAvailable (copy), u87 (ref), u9 (ref), u5 (ref), u83 (ref)
            if u82:GetAttribute("isHovered") then
                if IsFavoriteAvailable and (u87 and (not u9 or (not u5 or u5.Parent ~= u82))) then
                    u87.Add(u82:GetAttribute("isFavorited") == true);
                end;

                if u83 then
                    u83:StartRotation(-0.75);
                end;
            else
                if IsFavoriteAvailable and u87 and (not u82:GetAttribute("isFavorited") and u82:GetAttribute("isHovered") ~= true) then
                    u87.Remove();
                end;

                if u83 then
                    u83:ResetRotation();
                end;
            end;
        end);
        u82:GetAttributeChangedSignal("isFavorited"):Connect(function() -- Line: 1038
            -- upvalues: u87 (ref), u82 (copy)
            if not u87 then
                return;
            end;

            if u82:GetAttribute("isFavorited") == true then
                u87.Add(true);

                return;
            end;

            if u82:FindFirstChild("favorite") then
                u87.Add(false);
            end;
        end);
    end;

    u82:SetAttribute("isItem", true);
    setupInteractions(u82, u79.OutfitDetails, u79);

    return u82, v81;
end;

function u18.new(p90) -- Line: 1056
    -- upvalues: CatalogUtilities (copy), Events (copy), Cache (copy), itemOnlyIcon (copy), item (copy), beginShimmer (copy), restriction (copy), label (copy), Readable (copy), u10 (copy), LocalPlayer (copy), PriceDisplay (copy), itemType (copy), FavoriteButton (copy), favorite (copy), FavoriteController (copy), u3 (copy), TweenService (copy), removeShimmerPart (copy), u9 (ref), u5 (ref), ItemPreviewService (copy), getSetting (copy), ThemeController (copy), equipped (copy), Debris (copy), ProfileBackgroundController (copy), HumanoidDescriptionController (copy), setupInteractions (copy), u18 (copy)
    local v91 = p90 or {};
    v91.ItemButtonType = "Item";
    local u92 = v91.ItemData or CatalogUtilities.GetItemData(v91.ItemDetails);
    local AvatarPreviewOnHover = v91.AvatarPreviewOnHover;

    if AvatarPreviewOnHover then
        local v93 = { "Interface", "PreviewItemOnHover" };

        if not Events.GetSetting:GetAttribute("bound") then
            Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
        end;

        if Events.GetSetting:Invoke(v93) == false then
            AvatarPreviewOnHover = false;
        end;
    end;

    local u94 = nil;
    local AddEquippedOverlay = v91.AddEquippedOverlay;
    local OnlyIcon = v91.OnlyIcon;
    local IsCatalogItem = v91.IsCatalogItem;
    local IsDetailsPageItem = v91.IsDetailsPageItem;
    local IsFavoriteAvailable = v91.IsFavoriteAvailable;
    local IsLackingDetails = v91.IsLackingDetails;
    local _ = v91.CustomCallback;

    if IsLackingDetails then
        u92.IsLackingDetails = IsLackingDetails;
    end;

    if u92.IsLackingDetails ~= true then
        Cache.Set("ItemData", tostring(u92.Id), u92);
    end;

    local u95;

    if OnlyIcon then
        u95 = itemOnlyIcon:Clone();
    else
        u95 = item:Clone();
    end;

    u95.Name = u92.Id;
    u95:SetAttribute("isItem", true);
    local skeleton = u95:FindFirstChild("skeleton");

    if skeleton then
        if IsCatalogItem then
            beginShimmer(skeleton);
        else
            skeleton:Destroy();
            skeleton = nil;
        end;
    end;

    local preview = u95:FindFirstChild("preview");
    local u96;

    if preview then
        u96 = preview:FindFirstChild("labels");
    else
        u96 = preview;
    end;

    local u97;

    if preview then
        u97 = preview:FindFirstChild("image");
    else
        u97 = preview;
    end;

    local name = u95:FindFirstChild("name");
    local creator = u95:FindFirstChild("creator");
    local price = u95:FindFirstChild("price");
    local icon = u95:FindFirstChild("icon");
    u95:FindFirstChild("viewItem");

    if name then
        name.Text = u92.Name;
    end;

    if u92.RestrictionIcon then
        local v98 = restriction:Clone();
        v98.Image = u92.RestrictionIcon;
        v98.Parent = preview;
    end;

    if u92.StockString then
        local v99 = label:Clone();
        v99.value.Text = u92.StockString;
        v99.Parent = u96;
    end;

    if not OnlyIcon and creator then
        if u92.CreatorDisplay == "" then
            creator.Text = "";
        else
            creator.RichText = true;
            creator.Text = string.format(Readable.creator, CatalogUtilities.EscapeRichText(u92.CreatorDisplay));
        end;
    end;

    if IsDetailsPageItem then
        u95.Size = u10;
    end;

    if price then
        local Price = u92.Price;

        if Price == "Inventory" then
            if icon then
                icon.Visible = true;
            end;

            if creator then
                creator:Destroy();
            end;

            price.Size = UDim2.fromScale(0.86, 0.09);
            price.Position = UDim2.fromScale(0.14, 0.97);

            if name then
                name.Size = UDim2.fromScale(0.95, 0.113);
            end;

            local v100;

            if u92.CreatedDate then
                v100 = DateTime.fromIsoDate(u92.CreatedDate):FormatLocalTime("ll", LocalPlayer.LocaleId);
            else
                v100 = DateTime.now():FormatLocalTime("ll", LocalPlayer.LocaleId);
            end;

            price.Text = string.format(Readable.date, v100);
        elseif Price == "Free" then
            price.Text = Readable.free;
        elseif Price == "Offsale" then
            price.Text = Readable.offsale;
        elseif Price == "NoResellers" then
            price.Text = Readable.noResellers;
        elseif type(Price) == "number" then
            u95:SetAttribute("basePrice", Price);
            PriceDisplay.ApplyItemPriceText(price, Price);
        else
            u95:SetAttribute("basePrice", nil);
            price.Text = "";
        end;

        if not u92.IsInventory and icon then
            icon:Destroy();
        end;
    end;

    if OnlyIcon and (u92.ItemType == "Bundle" or u92.AssetType == "Gear") then
        local v101 = itemType:Clone();
        v101.Parent = u95;

        if u92.ItemType == "Bundle" then
            v101.Text = "Bundle";
        elseif u92.AssetType == "Gear" then
            v101.Text = "Gear";
            v101.Size = UDim2.fromScale(0.45, v101.Size.Y.Scale);
        end;

        u95.LayoutOrder = -1;
    end;

    if u97 and u97:IsA("ImageLabel") then
        u97.ImageTransparency = IsCatalogItem and 0.98 or 0;
        u97.Image = u92.Thumbnail;
    end;

    local u102;

    if IsFavoriteAvailable then
        u102 = FavoriteButton.Dynamic({
            Template = favorite,
            Parent = u95,
            StateHolder = u95,
            SizeFactor = OnlyIcon and 1.3 or nil,

            FavoriteAction = function(p103) -- Line: 1200, Name: FavoriteAction
                -- upvalues: FavoriteController (ref), u92 (copy)
                return FavoriteController.SetFavorited(u92, p103);
            end,

            TweenInfo = u3
        });
    else
        u102 = nil;
    end;

    u95:GetAttributeChangedSignal("isFavorited"):Connect(function() -- Line: 1207
        -- upvalues: u102 (ref), u95 (copy)
        if not u102 then
            return;
        end;

        if u95:GetAttribute("isFavorited") == true then
            u102.Add(true);

            return;
        end;

        if u95:FindFirstChild("favorite") then
            u102.Add(false);
        end;
    end);
    local u104 = TweenService:Create(u97, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ImageTransparency = 1
    });
    local u105 = TweenService:Create(u97, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ImageTransparency = 0
    });

    if skeleton and IsCatalogItem then
        u97:GetAttributeChangedSignal("Faded"):Once(function() -- Line: 1225
            -- upvalues: u97 (copy), removeShimmerPart (ref), u95 (copy)
            if u97:GetAttribute("Faded") == true then
                removeShimmerPart(u95, "previewShimmer");
            end;
        end);
    end;

    local function u111() -- Line: 1232
        -- upvalues: IsFavoriteAvailable (copy), u102 (ref), u9 (ref), u5 (ref), u95 (copy), AvatarPreviewOnHover (ref), u92 (copy), u96 (copy), IsCatalogItem (copy), u97 (copy), u104 (copy), u105 (copy), Events (ref), ItemPreviewService (ref), preview (copy), getSetting (ref), u94 (ref)
        if IsFavoriteAvailable and (u102 and (not u9 or (not u5 or u5.Parent ~= u95))) then
            u102.Add(u95:GetAttribute("isFavorited") == true, nil, true);
        end;

        if AvatarPreviewOnHover and (u92.ItemType ~= "Bundle" and u92.AssetType ~= "Gear" or u92.ItemType == "Bundle") then
            local function showPreview() -- Line: 1241
                -- upvalues: u95 (ref), u96 (ref), IsCatalogItem (ref), u97 (ref), u92 (ref), u104 (ref), u105 (ref), Events (ref), ItemPreviewService (ref), preview (ref)
                if u95:GetAttribute("isHovered") ~= true then
                    return;
                end;

                if u96 then
                    u96.Visible = false;
                end;

                if IsCatalogItem and u97:GetAttribute("Faded") ~= true then
                    local v106 = 0;

                    repeat
                        task.wait(0.1);
                        v106 = v106 + 1;
                    until u97:GetAttribute("Faded") or v106 == 5;

                    if u95:GetAttribute("isHovered") ~= true then
                        return;
                    end;
                end;

                u97:SetAttribute("IsDisplayingPreview", true);
                local v107;

                if u92.ItemType == "Bundle" then
                    v107 = u104;
                else
                    v107 = nil;
                end;

                if u92.AssetType == "AvatarBackground" then
                    u105:Play();
                elseif v107 == nil then
                    u104:Play();
                end;

                local v108 = { "Interface", "HideSameTypeOnPreview" };

                if not Events.GetSetting:GetAttribute("bound") then
                    Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
                end;

                local v109 = Events.GetSetting:Invoke(v108) ~= false;
                ItemPreviewService.AddPreview(preview, u92, v107, {
                    HideSameType = v109
                });
            end;

            local v110 = tonumber(getSetting({ "Interface", "ItemPreviewDelay" })) or 0;

            if v110 > 0 then
                if u94 then
                    task.cancel(u94);
                end;

                u94 = task.delay(v110, showPreview);

                return;
            end;

            showPreview();
        end;
    end;

    local function u112() -- Line: 1284
        -- upvalues: u96 (copy), IsFavoriteAvailable (copy), u102 (ref), u95 (copy), AvatarPreviewOnHover (ref), u94 (ref), u97 (copy), u105 (copy), ItemPreviewService (ref), preview (copy)
        if u96 then
            u96.Visible = true;
        end;

        if IsFavoriteAvailable and u102 and (not u95:GetAttribute("isFavorited") and u95:GetAttribute("isHovered") ~= true) then
            u102.Remove();
        end;

        if AvatarPreviewOnHover then
            if u94 then
                task.cancel(u94);
                u94 = nil;
            end;

            if u95:GetAttribute("isHovered") then
                return;
            end;

            u97:SetAttribute("IsDisplayingPreview", nil);
            u105:Play();
            ItemPreviewService.Cleanup(preview);
        end;
    end;

    local function setEquipped(p113) -- Line: 1310
        -- upvalues: u95 (copy), ThemeController (ref), preview (copy), AddEquippedOverlay (copy), equipped (ref), TweenService (ref), Debris (ref)
        local v114 = u95:FindFirstChild("contextButtons") or u95:FindFirstChild("contextButtonsEmote");
        local v115;

        if v114 then
            v115 = v114:FindFirstChild("tryOn") or v114:FindFirstChild("row1") and v114.row1:FindFirstChild("tryOn");
        else
            v115 = v114;
        end;

        if p113 then
            if v115 then
                v115.Text = "Take Off";
                v115.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(255, 95, 92));
            end;

            local v116 = nil;

            for _, child in preview:GetChildren() do
                if child.Name == "equipped" and not child:GetAttribute("isFading") then
                    v116 = child;
                    break;
                end;
            end;

            if AddEquippedOverlay and not v116 then
                local v117 = equipped:Clone();
                v117.Transparency = 1;
                v117.UIStroke.Transparency = 1;
                v117:WaitForChild("checkmark").ImageTransparency = 1;
                v117.Parent = preview;
                TweenService:Create(v117.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 0.15
                }):Play();
                TweenService:Create(v117, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 0.65
                }):Play();
                TweenService:Create(v117.checkmark, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    ImageTransparency = 0
                }):Play();
            end;
        else
            local v118 = nil;

            for _, child in preview:GetChildren() do
                if child.Name == "equipped" and not child:GetAttribute("isFading") then
                    v118 = child;
                    break;
                end;
            end;

            if v118 then
                v118:SetAttribute("isFading", true);
                Debris:AddItem(v118, 0.6);
                TweenService:Create(v118.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1
                }):Play();
                TweenService:Create(v118, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1
                }):Play();
                TweenService:Create(v118.checkmark, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    ImageTransparency = 1
                }):Play();
            end;

            if v115 then
                v115.Text = "Try On";
                v115.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(255, 255, 255));
            end;
        end;
    end;

    u95:GetAttributeChangedSignal("isHovered"):Connect(function() -- Line: 1362
        -- upvalues: u95 (copy), u111 (copy), u112 (copy)
        if u95:GetAttribute("isHovered") then
            u111();

            return;
        end;

        u112();
    end);
    u95:GetAttributeChangedSignal("isEquipped"):Connect(function() -- Line: 1366
        -- upvalues: setEquipped (copy), u95 (copy)
        setEquipped(u95:GetAttribute("isEquipped"));
    end);

    if u92.AssetType == "AvatarBackground" then
        u95:SetAttribute("isBackgroundItem", true);
        task.spawn(function() -- Line: 1373
            -- upvalues: u95 (copy), ProfileBackgroundController (ref), u92 (copy)
            u95:SetAttribute("isEquipped", ProfileBackgroundController.IsEquipped(u92.Id));
        end);
    else
        local EquippedDict = HumanoidDescriptionController.EquippedDict;

        if EquippedDict then
            u95:SetAttribute("isEquipped", EquippedDict[tostring(u92.Id)] ~= nil);
        end;
    end;

    setupInteractions(u95, u92, v91);
    tostring(u92.Id);
    local v119 = u18.Buttons[tostring(u92.Id)];

    if v119 then
        table.insert(v119, u95);
    else
        u18.Buttons[tostring(u92.Id)] = { u95 };
    end;

    u95.Destroying:Connect(function() -- Line: 1394
        -- upvalues: u18 (ref), u92 (copy), u95 (copy)
        local v120 = u18.Buttons[tostring(u92.Id)];
        local v121;

        if v120 then
            v121 = table.find(v120, u95);
        else
            v121 = v120;
        end;

        if v121 then
            table.remove(v120, v121);
        end;

        if #v120 == 0 then
            u18.Buttons[tostring(u92.Id)] = nil;
        end;
    end);

    return u95;
end;

function u18.GetButtons() -- Line: 1409
    -- upvalues: u18 (copy)
    return u18.Buttons;
end;

function u18.SetFavorited(p122, p123) -- Line: 1413
    if p122:GetAttribute("isItem") == true then
        p122:SetAttribute("isFavorited", p123);
    end;
end;

function u18.SetPriceLabel(p124, p125) -- Line: 1419
    -- upvalues: PriceDisplay (copy), Readable (copy)
    local price = p124:FindFirstChild("price");

    if not price then
        return;
    end;

    local v126 = p124:GetAttribute("priceSuffix");
    local v127 = typeof(v126) ~= "string" and "" or v126;

    if type(p125) == "number" then
        p124:SetAttribute("basePrice", p125);
        PriceDisplay.ApplyItemPriceText(price, p125, v127);

        return;
    end;

    p124:SetAttribute("basePrice", nil);

    if p125 == "Free" then
        price.Text = Readable.free .. v127;

        return;
    end;

    if p125 == "Offsale" or p125 == "OffSale" then
        price.Text = Readable.offsale .. v127;

        return;
    end;

    if p125 == "NoResellers" then
        price.Text = Readable.noResellers .. v127;

        return;
    end;

    price.Text = v127;
end;

function u18.RefreshAllPrices() -- Line: 1448
    -- upvalues: u18 (copy), PriceDisplay (copy)
    local v128 = {};

    for _, v in pairs(u18.Buttons) do
        for _, v2 in ipairs(v) do
            table.insert(v128, v2);
        end;
    end;

    for _, v in ipairs(v128) do
        if v and v.Parent then
            local v129 = v:GetAttribute("basePrice");

            if type(v129) == "number" then
                local price = v:FindFirstChild("price");

                if price then
                    local v130 = v:GetAttribute("priceSuffix");
                    PriceDisplay.ApplyItemPriceText(price, v129, v130);
                end;
            end;
        end;
    end;
end;

function u18.AddLabel(p131, p132, p133) -- Line: 1466
    -- upvalues: label (copy)
    local labels = p131.preview:FindFirstChild("labels");

    if labels then
        local v134 = label:Clone();
        v134.value.Text = p132;
        v134.LayoutOrder = p133 or 0;
        v134.Parent = labels;

        return v134;
    end;
end;

local function updateEquipped(p135) -- Line: 1477
    -- upvalues: u18 (copy)
    for i, v in u18.Buttons do
        local v136 = p135[i] ~= nil;

        for _, v2 in v do
            if not v2:GetAttribute("isBackgroundItem") then
                v2:SetAttribute("isEquipped", v136);
            end;
        end;
    end;
end;

ProfileBackgroundController.Changed:Connect(function(p137) -- Line: 1489
    -- upvalues: u18 (copy)
    local v138;

    if p137 == nil then
        v138 = nil;
    else
        v138 = tostring(p137);
    end;

    local v139 = tonumber(p137);

    for i, v in u18.Buttons do
        for _, v2 in v do
            if v2:GetAttribute("isBackgroundItem") then
                local v140;

                if v139 then
                    v140 = tonumber(i) == v139;
                else
                    v140 = i == v138;
                end;

                v2:SetAttribute("isEquipped", v140);
            end;
        end;
    end;
end);

function u18.UpdateEquipped(p141) -- Line: 1504
    -- upvalues: HumanoidDescriptionController (copy), updateEquipped (copy)
    local v142 = p141 or HumanoidDescriptionController.EquippedDict;

    if v142 == nil then
        return;
    end;

    updateEquipped(v142);
end;

HumanoidDescriptionController.OnEquippedUpdated:Connect(updateEquipped);
PriceDisplay.OnChanged:Connect(u18.RefreshAllPrices);

return u18;