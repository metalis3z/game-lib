-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local PlayerContextMenu = PlayerGui:WaitForChild("PlayerContextMenu");
local container = PlayerContextMenu:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local infoSection = wrapper:WaitForChild("infoSection");
local statistics = infoSection:WaitForChild("statistics");
local like = wrapper.preview:WaitForChild("like");
local fill = like:WaitForChild("fill");
local overflowMenu = PlayerContextMenu:WaitForChild("overflowMenu");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local CurrentlyWearingController = require(script.Parent.CurrentlyWearingController);
local ProfileBackgroundController = require(script.Parent.ProfileBackgroundController);
local u1 = utf8.char(57344);
local u2 = Color3.fromRGB(255, 100, 140);
local u3 = Color3.fromRGB(255, 255, 255);
local u4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u5 = {
    IsOpen = false
};
local Folder = ReplicatedStorage:FindFirstChild("HiddenPlayers");

if not Folder then
    Folder = Instance.new("Folder");
    Folder.Name = "HiddenPlayers";
    Folder.Parent = ReplicatedStorage;
end;
local u6 = nil;
local u7 = {};
local u8 = {};
local u9 = nil;
local u10 = false;
local u11 = false;
local u12 = 0;
local u13 = nil;
local u14 = 0;
local u15 = nil;

local function setLikeVisual(p16, p17) -- Line: 57
    -- upvalues: ThemeController (copy), u2 (copy), u3 (copy), fill (copy), TweenService (copy), u4 (copy)
    local v18;

    if p16 then
        v18 = u2;
    else
        v18 = u3;
    end;

    local v19 = ThemeController.GetColor(v18);

    if p17 then
        fill.ImageColor3 = v19;

        return;
    end;

    TweenService:Create(fill, u4, {
        ImageColor3 = v19
    }):Play();
end;

local function playLikeButtonPop() -- Line: 66
    -- upvalues: TweenService (copy), fill (copy), u2 (copy), like (copy)
    local v20 = TweenService:Create(fill, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0.5, 0, 0.5, 0)
    });
    v20:Play();
    v20.Completed:Once(function() -- Line: 72
        -- upvalues: TweenService (ref), fill (ref), u2 (ref), like (ref)
        TweenService:Create(fill, TweenInfo.new(0.65, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.75, 0, 0.75, 0)
        }):Play();
        local u21 = script.likeBurst:Clone();
        u21.ImageColor3 = u2;
        u21.ImageTransparency = 0.1;
        u21.Size = UDim2.new(0.3, 0, 0.3, 0);
        u21.Rotation = math.random(0, 360);
        u21.ZIndex = fill.ZIndex - 1;
        u21.Parent = like;
        TweenService:Create(u21, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(2.2, 0, 2.2, 0)
        }):Play();
        task.delay(0.15, function() -- Line: 93
            -- upvalues: TweenService (ref), u21 (copy)
            local v22 = TweenService:Create(u21, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1
            });
            v22:Play();
            v22.Completed:Once(function() -- Line: 98
                -- upvalues: u21 (ref)
                u21:Destroy();
            end);
        end);
    end);
end;

local function updateLikesLabel(p23) -- Line: 106
    -- upvalues: u12 (ref), u13 (ref), Events (copy)
    u12 = math.max(0, (u12 or 0) + p23);

    if u13 then
        u13.label.Text = "<font color=\'rgb(255, 100, 140)\'>" .. tostring(u12) .. "</font> Like" .. (u12 == 1 and "" or "s");
        Events.AddTooltipToObject:Fire(u13, tostring(u12) .. " Like" .. (u12 == 1 and "" or "s"));
    end;
end;

local function triggerLikeEffect() -- Line: 114
    -- upvalues: Events (copy)
    Events.PlayLikeEffect:Fire();
end;

function u5.Open(u24) -- Line: 118
    -- upvalues: ContentProvider (copy), u5 (copy), u9 (ref), u1 (copy), u6 (ref), wrapper (copy), ProfileBackgroundController (copy), u8 (copy), statistics (copy), u10 (ref), fill (copy), ThemeController (copy), u3 (copy), u15 (ref), u13 (ref), u12 (ref), u14 (ref), u7 (copy), Remotes (copy), Events (copy), CatalogUtilities (copy), infoSection (copy), u2 (copy), overflowMenu (copy), StarterGui (copy), LocalPlayer (copy), Folder (copy), TweenService (copy), u4 (copy), OutsideClickDetector (copy), CurrentlyWearingController (copy), Players (copy), container (copy), PlayerContextMenu (copy), AvatarPreviewController (copy)
    task.spawn(ContentProvider.PreloadAsync, ContentProvider, { script.likeBurst });

    if u5.IsOpen then
        if u9 == u24 then
            return;
        end;

        u5.Close();
    end;

    u9 = u24;
    local v25 = (u24.Character or u24.CharacterAdded:Wait()):FindFirstChildWhichIsA("Humanoid").RigType or Enum.HumanoidRigType.R15;
    local UserId = u24.UserId;
    local v26 = not u24.HasVerifiedBadge and "" or u1;

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    local background = wrapper.preview:FindFirstChild("background");

    local function updatePreviewBackground() -- Line: 144
        -- upvalues: background (copy), u24 (copy), ProfileBackgroundController (ref)
        if not background then
            return;
        end;

        local v27 = u24:GetAttribute(ProfileBackgroundController.Attribute);
        local ApplyToImage = ProfileBackgroundController.ApplyToImage;
        local v28;

        if v27 then
            v28 = tostring(v27);
        else
            v28 = nil;
        end;

        ApplyToImage(background, v28);
    end;

    if background then
        local v29 = u24:GetAttribute(ProfileBackgroundController.Attribute);
        local ApplyToImage = ProfileBackgroundController.ApplyToImage;
        local v30;

        if v29 then
            v30 = tostring(v29);
        else
            v30 = nil;
        end;

        ApplyToImage(background, v30);
    end;

    local v31 = u24:GetAttributeChangedSignal(ProfileBackgroundController.Attribute);
    table.insert(u8, v31:Connect(updatePreviewBackground));

    for _, child in statistics:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    local function addStatisticLabel(p32, p33) -- Line: 158
        -- upvalues: statistics (ref)
        local v34 = script.statistic:Clone();
        v34.label.Text = p32;
        v34.LayoutOrder = p33 or #statistics:GetChildren();
        v34.Parent = statistics;

        return v34;
    end;

    u10 = false;
    fill.ImageColor3 = ThemeController.GetColor(u3);
    u15 = nil;
    u13 = nil;
    u12 = 0;
    u14 = 0;
    table.insert(u7, task.spawn(function() -- Line: 175
        -- upvalues: Remotes (ref), UserId (copy), u9 (ref), u24 (copy), Events (ref), u14 (ref), u15 (ref), CatalogUtilities (ref), statistics (ref), infoSection (ref)
        local v35 = Remotes.GetUserProfileInfo:InvokeServer((tonumber(UserId)));

        if u9 ~= u24 then
            return;
        end;

        if v35 == nil then
            Events.Notify:Fire("⚠️ Couldn\'t get user details. Please contact support if this persists!");

            return;
        end;

        if typeof(v35.FollowerCount) == "number" then
            u14 = v35.FollowerCount;
            local v36 = CatalogUtilities.FormatNumberCompact(u14) .. " Followers";
            local v37 = script.statistic:Clone();
            v37.label.Text = v36;
            v37.LayoutOrder = 1;
            v37.Parent = statistics;
            u15 = v37;
            Events.AddTooltipToObject:Fire(u15, tostring(u14) .. " Followers");
        end;

        v35.UserInfo = v35.UserInfo or {};
        local Description = v35.UserInfo.Description;
        local v38 = (not Description or Description == "") and "<i>No bio available.</i>" or string.gsub(string.gsub(Description, "&", "&amp;"), "<", "&lt;");
        infoSection.descriptionContainer.label.Text = "<b>About Me</b>\n" .. v38;
    end));
    table.insert(u7, task.spawn(function() -- Line: 198
        -- upvalues: Remotes (ref), u24 (copy), u9 (ref), u12 (ref), u13 (ref), statistics (ref), Events (ref)
        local v39 = Remotes.LikeAction:InvokeServer("GetLikes", u24);

        if u9 ~= u24 then
            return;
        end;

        u12 = v39 or 0;
        local v40 = "<font color=\'rgb(255, 100, 140)\'>" .. tostring(u12) .. "</font> Like" .. (u12 == 1 and "" or "s");
        local v41 = script.statistic:Clone();
        v41.label.Text = v40;
        v41.LayoutOrder = 2;
        v41.Parent = statistics;
        u13 = v41;
        Events.AddTooltipToObject:Fire(u13, tostring(u12) .. " Like" .. (u12 == 1 and "" or "s"));
    end));
    table.insert(u7, task.spawn(function() -- Line: 207
        -- upvalues: Remotes (ref), u24 (copy), u9 (ref), u10 (ref), ThemeController (ref), u2 (ref), u3 (ref), fill (ref)
        local v42 = Remotes.LikeAction:InvokeServer("IsLiked", u24);

        if u9 == u24 then
            u10 = v42 == true;
            local v43;

            if u10 then
                v43 = u2;
            else
                v43 = u3;
            end;

            fill.ImageColor3 = ThemeController.GetColor(v43);
        end;
    end));
    table.insert(u8, wrapper.closeButton.Activated:Connect(function() -- Line: 215
        -- upvalues: u5 (ref)
        u5.Close();
    end));
    local u44 = false;
    local u45 = false;
    task.spawn(function() -- Line: 221
        -- upvalues: Remotes (ref), u44 (ref), u45 (ref), overflowMenu (ref)
        local v46, v47 = Remotes.GetFlag:InvokeServer("IsContentModerator");
        local v48, v49 = Remotes.GetFlag:InvokeServer("IsTrialModerator");
        local v50;

        if v46 == true and v47 == true then
            v50 = true;
        elseif v48 == true then
            v50 = v49 == true;
        else
            v50 = false;
        end;

        u44 = v50;
        local v51;

        if v48 == true and v49 == true then
            local v52;

            if v46 == true then
                v52 = v47 == true;
            else
                v52 = false;
            end;

            v51 = not v52;
        else
            v51 = false;
        end;

        u45 = v51;
        local v53 = u44 and overflowMenu.wrapper:FindFirstChild("reportOutfit");

        if v53 then
            v53.label.Text = "Moderate Outfit";
        end;
    end);
    local success, result = pcall(function() -- Line: 235
        -- upvalues: StarterGui (ref)
        return StarterGui:GetCore("GetBlockedUserIds");
    end);
    local u54 = table.find(success == false and {} or result, UserId) ~= nil;

    for _, child in overflowMenu.wrapper:GetChildren() do
        if child:IsA("TextButton") ~= false then
            local Name = child.Name;

            if Name == "addFriend" then
                task.spawn(function() -- Line: 249
                    -- upvalues: LocalPlayer (ref), u24 (copy), child (copy)
                    if LocalPlayer:IsFriendsWithAsync(u24.UserId) == false then
                        child.label.Text = "Add Friend";

                        return;
                    end;

                    child.label.Text = "Unfriend User";
                end);
            elseif Name == "blockUser" then
                if u54 then
                    child.label.Text = "Unblock User";
                else
                    child.label.Text = "Block User";
                end;
            end;

            table.insert(u8, child.MouseEnter:Connect(function() -- Line: 266
                -- upvalues: child (copy)
                child.BackgroundTransparency = 0.9;
            end));
            table.insert(u8, child.MouseLeave:Connect(function() -- Line: 269
                -- upvalues: child (copy)
                child.BackgroundTransparency = 1;
            end));
            table.insert(u8, child.Activated:Connect(function() -- Line: 272
                -- upvalues: Name (copy), LocalPlayer (ref), u24 (copy), StarterGui (ref), u54 (ref), u5 (ref), Events (ref), u9 (ref), u44 (ref), u45 (ref), Remotes (ref), Folder (ref), overflowMenu (ref), child (copy)
                if Name == "addFriend" then
                    task.spawn(function() -- Line: 274
                        -- upvalues: LocalPlayer (ref), u24 (ref), StarterGui (ref)
                        if LocalPlayer:IsFriendsWithAsync(u24.UserId) == false then
                            StarterGui:SetCore("PromptSendFriendRequest", u24);

                            return;
                        end;

                        StarterGui:SetCore("PromptUnfriend", u24);
                    end);

                    return;
                end;

                if Name == "blockUser" then
                    if u54 then
                        StarterGui:SetCore("PromptUnblockPlayer", u24);

                        return;
                    end;

                    StarterGui:SetCore("PromptBlockPlayer", u24);

                    return;
                end;

                if Name ~= "viewProfile" then
                    if Name == "reportOutfit" then
                        if not u9 then
                            return;
                        end;

                        local v55 = u9;

                        if u44 then
                            local v56 = { {
                                    label = "Reset Outfit"
                                }, {
                                    label = "Ban 1 Day"
                                }, {
                                    label = "Ban 3 Days"
                                }, {
                                    label = "Ban 7 Days"
                                }, {
                                    label = "Ban 30 Days"
                                } };

                            if not u45 then
                                table.insert(v56, {
                                    label = "Permanent Ban"
                                });
                            end;

                            local v57 = Events.PromptChoice:Invoke({
                                subtitle = "Actions their current outfit directly. Every action is recorded.",
                                allowCustom = false,
                                title = "Moderate " .. v55.DisplayName,
                                options = v56
                            });

                            if not v57 then
                                return;
                            end;

                            local v58 = ({
                                ["Reset Outfit"] = "Reset",
                                ["Ban 1 Day"] = "ban1Day",
                                ["Ban 3 Days"] = "ban3Days",
                                ["Ban 7 Days"] = "ban7Days",
                                ["Ban 30 Days"] = "ban30Days",
                                ["Permanent Ban"] = "permBan"
                            })[v57.value];

                            if not v58 then
                                return;
                            end;

                            local v59 = Events.PromptChoice:Invoke({
                                title = "Reason",
                                subtitle = "Be concise and accurate. This is shown to the player.",
                                allowCustom = true,
                                placeholder = "Type a custom reason…",
                                options = { {
                                        label = "Inappropriate or offensive content."
                                    }, {
                                        label = "Explicit or suggestive content."
                                    }, {
                                        label = "Violation of our content guidelines."
                                    } }
                            });

                            if not v59 then
                                return;
                            end;

                            local value = v59.value;
                            local v60;

                            if v58 == "Reset" then
                                v60 = "This resets <b>" .. v55.DisplayName .. "</b>\'s outfit. They will not be banned.";
                            else
                                v60 = "This bans <b>" .. v55.DisplayName .. "</b> (" .. v57.value .. ") and resets their outfit.";
                            end;

                            if Events.PromptConfirmationDialog:Invoke({
                                Title = "Confirm moderation",
                                YesText = "Confirm",
                                NoText = "Cancel",
                                Description = v60 .. "\n\nReason: " .. value
                            }) ~= true then
                                return;
                            end;

                            local v61, v62, v63 = Remotes.CommunityOutfitsAction:InvokeServer("DirectModeratePlayer", v55.UserId, v58, value);

                            if v61 == true then
                                Events.Notify:Fire("✅ Action applied and recorded.");

                                return;
                            end;

                            if v63 == "AlreadyBanned" then
                                Events.Notify:Fire("⚠️ " .. tostring(v62));

                                return;
                            end;

                            Events.Notify:Fire("❌ Something went wrong: " .. tostring(v62));

                            return;
                        end;

                        local v64 = Events.PromptInputDialog:Invoke({
                            Title = "Report Player Outfit",
                            PlaceholderText = "Describe the issue",
                            YesText = "Submit",
                            Description = "Describe the issue with <b>" .. v55.DisplayName .. "</b>\'s outfit.\n\n<i>ⓘ Misusing the Reports system <b>will</b> result in punishment.</i>"
                        });

                        if v64 ~= false then
                            local v65, v66 = Remotes.CommunityOutfitsAction:InvokeServer("ReportPlayer", v55.UserId, v64);

                            if v65 ~= true then
                                Events.Notify:Fire("❌ Report failed: " .. tostring(v66));

                                return;
                            end;

                            Events.Notify:Fire("✅ Thank you for helping keep the community safe.");

                            if Events.PromptConfirmationDialog:Invoke({
                                Title = "Hide Outfit",
                                YesText = "Yes",
                                NoText = "No",
                                Description = "Would you like to also hide <b>" .. u24.DisplayName .. "</b>\'s outfit?"
                            }) then
                                u24:SetAttribute("isHidden", true);
                                u24.Character.Parent = Folder;
                                overflowMenu.wrapper.hideOutfit.label.Text = "Show Outfit";
                                Events.Notify:Fire("✅ Successfully hid <b>" .. u24.DisplayName .. "</b>\'s outfit.");

                                return;
                            end;
                        end;
                    elseif Name == "hideOutfit" then
                        if u24:GetAttribute("isHidden") then
                            child.label.Text = "Hide Outfit";
                            u24:SetAttribute("isHidden", nil);
                            u24.Character.Parent = workspace;
                            Events.Notify:Fire("✅ Successfully shown <b>" .. u24.DisplayName .. "</b>\'s outfit.");

                            return;
                        end;

                        if Events.PromptConfirmationDialog:Invoke({
                            Title = "Hide Outfit",
                            YesText = "Confirm",
                            NoText = "Cancel",
                            Description = "Are you sure you want to hide <b>" .. u24.DisplayName .. "</b>\'s outfit?"
                        }) then
                            u24:SetAttribute("isHidden", true);
                            u24.Character.Parent = Folder;
                            child.label.Text = "Show Outfit";
                            Events.Notify:Fire("✅ Successfully hid <b>" .. u24.DisplayName .. "</b>\'s outfit.");
                        end;
                    end;

                    return;
                end;

                u5.Close();
                Events.DisplayContentPage:Fire({
                    Type = "UserProfile",
                    UserId = u24.UserId
                });
            end));
        end;
    end;

    local function getOverflowButton(p67) -- Line: 417
        -- upvalues: overflowMenu (ref)
        for _, child in overflowMenu.wrapper:GetChildren() do
            if child:IsA("TextButton") and child.Name == p67 then
                return child;
            end;
        end;

        return nil;
    end;

    local Event = StarterGui:GetCore("PlayerBlockedEvent").Event;
    table.insert(u8, Event:Connect(function(p68) -- Line: 427
        -- upvalues: u24 (copy), u54 (ref), getOverflowButton (copy)
        if p68 == u24 then
            u54 = true;
            local v69 = getOverflowButton("blockUser");

            if v69 then
                v69.label.Text = "Unblock User";
            end;
        end;
    end));
    local Event2 = StarterGui:GetCore("PlayerUnblockedEvent").Event;
    table.insert(u8, Event2:Connect(function(p70) -- Line: 436
        -- upvalues: u24 (copy), u54 (ref), getOverflowButton (copy)
        if p70 == u24 then
            u54 = false;
            local v71 = getOverflowButton("blockUser");

            if v71 then
                v71.label.Text = "Block User";
            end;
        end;
    end));
    local Event3 = StarterGui:GetCore("PlayerFriendedEvent").Event;
    table.insert(u8, Event3:Connect(function(p72) -- Line: 445
        -- upvalues: u24 (copy), getOverflowButton (copy)
        local v73 = p72 == u24 and getOverflowButton("addFriend");

        if v73 then
            v73.label.Text = "Unfriend User";
        end;
    end));
    local Event4 = StarterGui:GetCore("PlayerUnfriendedEvent").Event;
    table.insert(u8, Event4:Connect(function(p74) -- Line: 453
        -- upvalues: u24 (copy), getOverflowButton (copy)
        local v75 = p74 == u24 and getOverflowButton("addFriend");

        if v75 then
            v75.label.Text = "Add Friend";
        end;
    end));

    local function updateOverflowPosition() -- Line: 460
        -- upvalues: infoSection (ref), overflowMenu (ref)
        local AbsolutePosition = infoSection.moreButtons.AbsolutePosition;
        overflowMenu.Position = UDim2.fromOffset(AbsolutePosition.X + infoSection.moreButtons.AbsoluteSize.X / 2, AbsolutePosition.Y);
    end;

    local u76 = false;
    local u77 = nil;

    local function setOverflowOpen(p78) -- Line: 469
        -- upvalues: u77 (ref), overflowMenu (ref), infoSection (ref), TweenService (ref), u4 (ref), u76 (ref), OutsideClickDetector (ref), setOverflowOpen (copy), u8 (ref)
        if u77 then
            u77:Disconnect();
            u77 = nil;
        end;

        if not p78 then
            u76 = false;
            TweenService:Create(overflowMenu, u4, {
                GroupTransparency = 1
            }):Play();
            task.delay(u4.Time, function() -- Line: 489
                -- upvalues: u76 (ref), overflowMenu (ref)
                if not u76 then
                    overflowMenu.Visible = false;
                end;
            end);

            return;
        end;

        overflowMenu.GroupTransparency = 1;
        overflowMenu.Visible = true;
        local AbsolutePosition = infoSection.moreButtons.AbsolutePosition;
        overflowMenu.Position = UDim2.fromOffset(AbsolutePosition.X + infoSection.moreButtons.AbsoluteSize.X / 2, AbsolutePosition.Y);
        TweenService:Create(overflowMenu, u4, {
            GroupTransparency = 0
        }):Play();
        u76 = true;
        u77 = OutsideClickDetector(overflowMenu, function() -- Line: 482
            -- upvalues: setOverflowOpen (ref)
            setOverflowOpen(false);
        end, {
            include = { infoSection.moreButtons }
        });
        table.insert(u8, u77);
    end;

    table.insert(u8, infoSection.moreButtons.Activated:Connect(function() -- Line: 497
        -- upvalues: setOverflowOpen (copy), u76 (ref)
        setOverflowOpen(not u76);
    end));
    table.insert(u8, infoSection.viewOutfit.Activated:Connect(function() -- Line: 501
        -- upvalues: Remotes (ref), u24 (copy), u5 (ref), CurrentlyWearingController (ref)
        if not Remotes.CheckOutfitPrivacy:InvokeServer(u24, "ViewOutfit") then
            return;
        end;

        u5.Close();
        CurrentlyWearingController.Open(false, u24);
    end));
    table.insert(u8, infoSection.tryOnOutfit.Activated:Connect(function() -- Line: 508
        -- upvalues: Remotes (ref), u24 (copy), Events (ref)
        if not Remotes.CheckOutfitPrivacy:InvokeServer(u24, "TryOnOutfit") then
            return;
        end;

        if Remotes.TryOnPlayerOutfit:InvokeServer(u24) == false then
            Events.Notify:Fire("❌ Something went wrong. Please try again.");

            return;
        end;

        Events.Notify:Fire("✅ Successfully equipped <b>" .. u24.DisplayName .. "</b>\'s outfit!");
    end));
    local v79 = infoSection.moreButtons:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(u8, v79:Connect(function() -- Line: 519
        -- upvalues: u76 (ref), infoSection (ref), overflowMenu (ref)
        if u76 then
            local AbsolutePosition = infoSection.moreButtons.AbsolutePosition;
            overflowMenu.Position = UDim2.fromOffset(AbsolutePosition.X + infoSection.moreButtons.AbsoluteSize.X / 2, AbsolutePosition.Y);
        end;
    end));
    table.insert(u8, Players.PlayerRemoving:Connect(function(p80) -- Line: 525
        -- upvalues: u24 (copy), Events (ref), u5 (ref)
        if p80 == u24 then
            Events.Notify:Fire("❌ Selected player has left the game.");
            u5.Close();
        end;
    end));
    Events.InterfaceAction:Fire("Add", script.Name, u5.Close);
    Events.SetButtonsVisible:Fire("All", { "resetAvatar", "saveOutfit", "adjustAccessories", "currentlyWearing" });
    Events.AddTooltipToObject:Fire(wrapper.preview.like, "Like this outfit");
    infoSection.username.Text = "@" .. u24.Name;
    infoSection.displayName.Text = u24.DisplayName .. v26;
    infoSection.image.Image = `rbxthumb://type=AvatarHeadShot&id={UserId}&w=100&h=100`;
    infoSection.descriptionContainer.label.Text = "<b>About Me</b>\n<i>Loading...</i>";
    container.GroupTransparency = 1;
    PlayerContextMenu.Enabled = true;
    u5.IsOpen = true;
    TweenService:Create(container, u4, {
        GroupTransparency = 0
    }):Play();
    u6 = AvatarPreviewController.new(wrapper.preview.viewport, nil, {
        UpdateOnDescriptionApplied = true,
        AllowCameraAdjustment = true,
        Target = u24,
        RigType = v25
    });
end;

function u5.Close(p81) -- Line: 560
    -- upvalues: u5 (copy), overflowMenu (copy), TweenService (copy), container (copy), u4 (copy), Events (copy), u9 (ref), u7 (copy), u8 (copy), PlayerContextMenu (copy), u6 (ref)
    if not u5.IsOpen then
        return;
    end;

    overflowMenu.Visible = false;
    overflowMenu.GroupTransparency = 1;
    TweenService:Create(container, u4, {
        GroupTransparency = 1
    }):Play();
    Events.InterfaceAction:Fire("Remove", script.Name);

    if p81 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    u5.IsOpen = false;
    u9 = nil;

    for _, v in u7 do
        pcall(task.cancel, v);
    end;

    for _, v in u8 do
        v:Disconnect();
    end;

    table.clear(u8);
    table.clear(u7);
    task.delay(u4.Time, function() -- Line: 585
        -- upvalues: u5 (ref), PlayerContextMenu (ref), u6 (ref)
        if u5.IsOpen then
            return;
        end;

        PlayerContextMenu.Enabled = false;

        if u6 then
            u6:Destroy();
            u6 = nil;
        end;
    end);
end;

local u82 = UDim2.new(0.75, 0, 0.75, 0);
local u83 = UDim2.new(0.79, 0, 0.79, 0);
local u84 = UDim2.new(0.71, 0, 0.71, 0);
like.MouseEnter:Connect(function() -- Line: 600
    -- upvalues: TweenService (copy), fill (copy), u4 (copy), u83 (copy)
    TweenService:Create(fill, u4, {
        Size = u83
    }):Play();
end);
like.MouseLeave:Connect(function() -- Line: 604
    -- upvalues: TweenService (copy), fill (copy), u4 (copy), u82 (copy)
    TweenService:Create(fill, u4, {
        Size = u82
    }):Play();
end);
like.MouseButton1Down:Connect(function() -- Line: 608
    -- upvalues: TweenService (copy), fill (copy), u4 (copy), u84 (copy)
    TweenService:Create(fill, u4, {
        Size = u84
    }):Play();
end);
like.MouseButton1Click:Connect(function() -- Line: 613
    -- upvalues: u9 (ref), u11 (ref), Events (copy), u10 (ref), ThemeController (copy), u2 (copy), u3 (copy), TweenService (copy), fill (copy), u4 (copy), updateLikesLabel (copy), playLikeButtonPop (copy), Remotes (copy)
    if not u9 then
        return;
    end;

    if u11 then
        Events.Notify:Fire("⚠️ You are going too fast! Please slow down and try again.");

        return;
    end;

    u11 = true;
    local v85 = u9;
    u10 = not u10;
    local v86;

    if u10 then
        v86 = u2;
    else
        v86 = u3;
    end;

    TweenService:Create(fill, u4, {
        ImageColor3 = ThemeController.GetColor(v86)
    }):Play();

    if u10 then
        updateLikesLabel(1);
        Events.PlayLikeEffect:Fire();
        playLikeButtonPop();
    else
        updateLikesLabel(-1);
    end;

    local v87 = Remotes.LikeAction:InvokeServer("ToggleLike", v85);

    if v87 == true then
        if u9 == v85 then
            u10 = true;
            TweenService:Create(fill, u4, {
                ImageColor3 = ThemeController.GetColor(u2)
            }):Play();
        end;

        Events.Notify:Fire("❤️ Liked " .. v85.DisplayName .. "!");
    elseif v87 == false then
        if u9 == v85 then
            u10 = false;
            TweenService:Create(fill, u4, {
                ImageColor3 = ThemeController.GetColor(u3)
            }):Play();
        end;

        Events.Notify:Fire("💔 Unliked " .. v85.DisplayName .. ".");
    elseif u9 == v85 then
        u10 = not u10;
        local v88;

        if u10 then
            v88 = u2;
        else
            v88 = u3;
        end;

        TweenService:Create(fill, u4, {
            ImageColor3 = ThemeController.GetColor(v88)
        }):Play();
        updateLikesLabel(u10 and 1 or -1);
    end;

    u11 = false;
end);
local u89 = Color3.fromRGB(255, 255, 255);
local u90 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u91 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local u92 = {};

local function setupCharacter(p93, p94) -- Line: 677
    -- upvalues: Folder (copy), ThemeController (copy), u89 (copy), u92 (copy)
    if p94:GetAttribute("isHidden") then
        p93.Parent = Folder;

        return;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = ThemeController.GetColor(u89);
    Highlight.OutlineColor = ThemeController.GetColor(u89);
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Adornee = p93;
    Highlight.Parent = p93;
    u92[p94] = {
        character = p93,
        highlight = Highlight
    };
end;

local function setupPlayer(u95) -- Line: 694
    -- upvalues: Players (copy), setupCharacter (copy)
    if u95 == Players.LocalPlayer then
        return;
    end;

    if u95.Character then
        setupCharacter(u95.Character, u95);
    end;

    u95.CharacterAdded:Connect(function(p96) -- Line: 700
        -- upvalues: setupCharacter (ref), u95 (copy)
        setupCharacter(p96, u95);
    end);
end;

for _, v in Players:GetPlayers() do
    if v ~= Players.LocalPlayer then
        if v.Character then
            setupCharacter(v.Character, v);
        end;

        v.CharacterAdded:Connect(function(p97) -- Line: 700
            -- upvalues: setupCharacter (copy), v (copy)
            setupCharacter(p97, v);
        end);
    end;
end;

Players.PlayerAdded:Connect(setupPlayer);
local CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 728
    -- upvalues: CurrentCamera (ref)
    CurrentCamera = workspace.CurrentCamera;
end);

local function pickPlayerAt(p98) -- Line: 732
    -- upvalues: CurrentCamera (ref), LocalPlayer (copy), Players (copy)
    local v99 = CurrentCamera:ScreenPointToRay(p98.X, p98.Y);
    local v100 = RaycastParams.new();
    v100.FilterType = Enum.RaycastFilterType.Exclude;
    v100.FilterDescendantsInstances = { LocalPlayer.Character };
    local v101 = workspace:Raycast(v99.Origin, v99.Direction * 512, v100);

    if v101 then
        local Instance2 = v101.Instance;

        while Instance2 and Instance2 ~= workspace do
            local v102 = Players:GetPlayerFromCharacter(Instance2);

            if v102 then
                return v102;
            end;

            Instance2 = Instance2.Parent;
        end;
    end;

    local v103 = nil;
    local v104 = nil;
    local v105 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            local Character = v.Character;
            local v106;

            if Character then
                v106 = Character:FindFirstChild("HumanoidRootPart");
            else
                v106 = Character;
            end;

            if v106 and Character:IsDescendantOf(workspace) then
                local Magnitude = (v106.Position - CurrentCamera.CFrame.Position).Magnitude;
                local v107, v108 = CurrentCamera:WorldToScreenPoint(v106.Position);

                if v108 and Magnitude <= 512 then
                    local Y = CurrentCamera.ViewportSize.Y;
                    local v109 = 2 * v107.Z;
                    local v110 = math.rad(CurrentCamera.FieldOfView) / 2;
                    local v111 = Y / (v109 * math.tan(v110));
                    local v112 = Character:GetExtentsSize();
                    local v113 = math.max(v112.X, v112.Z) / 2 * v111 + 25;
                    local v114 = v112.Y / 2 * v111 + 25;
                    local v115 = math.abs(p98.X - v107.X);
                    local v116 = math.abs(p98.Y - v107.Y);

                    if v115 <= v113 and v116 <= v114 then
                        local v117 = v115 / v113;
                        local v118 = v116 / v114;
                        local v119 = v117 * v117 + v118 * v118;

                        if not v103 or v119 < v104 then
                            v105 = v106;
                            v104 = v119;
                            v103 = v;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if not v103 then
        return nil;
    end;

    local v120 = RaycastParams.new();
    v120.FilterType = Enum.RaycastFilterType.Exclude;
    local v121 = {};

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v121, v.Character);
        end;
    end;

    v120.FilterDescendantsInstances = v121;

    if workspace:Raycast(CurrentCamera.CFrame.Position, v105.Position - CurrentCamera.CFrame.Position, v120) then
        return nil;
    end;

    return v103;
end;

local function isPointBlockedByUI(p122, p123) -- Line: 807
    -- upvalues: PlayerGui (copy)
    for _, v in PlayerGui:GetGuiObjectsAtPosition(p122, p123) do
        if v.Visible then
            if v.Active then
                return true;
            end;

            if v.BackgroundTransparency < 1 then
                return true;
            end;

            if (v:IsA("ImageLabel") or v:IsA("ImageButton")) and v.ImageTransparency < 1 then
                return true;
            end;

            if (v:IsA("TextLabel") or (v:IsA("TextButton") or v:IsA("TextBox"))) and v.TextTransparency < 1 then
                return true;
            end;
        end;
    end;

    return false;
end;

local function quickLike(u124) -- Line: 823
    -- upvalues: u11 (ref), u5 (copy), u9 (ref), u10 (ref), ThemeController (copy), u2 (copy), u3 (copy), TweenService (copy), fill (copy), u4 (copy), updateLikesLabel (copy), playLikeButtonPop (copy), Remotes (copy), Events (copy)
    if u11 then
        return;
    end;

    u11 = true;
    task.spawn(function() -- Line: 826
        -- upvalues: u5 (ref), u9 (ref), u124 (copy), u10 (ref), ThemeController (ref), u2 (ref), u3 (ref), TweenService (ref), fill (ref), u4 (ref), updateLikesLabel (ref), playLikeButtonPop (ref), Remotes (ref), Events (ref), u11 (ref)
        local v125 = u5.IsOpen and u9 == u124;

        if v125 then
            u10 = not u10;
            local v126;

            if u10 then
                v126 = u2;
            else
                v126 = u3;
            end;

            TweenService:Create(fill, u4, {
                ImageColor3 = ThemeController.GetColor(v126)
            }):Play();

            if u10 then
                updateLikesLabel(1);
                playLikeButtonPop();
            else
                updateLikesLabel(-1);
            end;
        end;

        local v127 = Remotes.LikeAction:InvokeServer("ToggleLike", u124);

        if v127 == true then
            Events.Notify:Fire("❤️ Liked " .. u124.DisplayName .. "!");
            Events.PlayLikeEffect:Fire();

            if u5.IsOpen and u9 == u124 then
                u10 = true;
                TweenService:Create(fill, u4, {
                    ImageColor3 = ThemeController.GetColor(u2)
                }):Play();
            end;
        elseif v127 == false then
            Events.Notify:Fire("💔 Unliked " .. u124.DisplayName .. ".");

            if u5.IsOpen and u9 == u124 then
                u10 = false;
                TweenService:Create(fill, u4, {
                    ImageColor3 = ThemeController.GetColor(u3)
                }):Play();
            end;
        elseif u5.IsOpen and (u9 == u124 and v125) then
            u10 = not u10;
            local v128;

            if u10 then
                v128 = u2;
            else
                v128 = u3;
            end;

            TweenService:Create(fill, u4, {
                ImageColor3 = ThemeController.GetColor(v128)
            }):Play();
            updateLikesLabel(u10 and 1 or -1);
        end;

        u11 = false;
    end);
end;

local u129 = 0;
local u130 = nil;

local function onCharacterClicked(u131) -- Line: 869
    -- upvalues: u130 (ref), u129 (ref), u11 (ref), u5 (copy), u9 (ref), u10 (ref), ThemeController (copy), u2 (copy), u3 (copy), TweenService (copy), fill (copy), u4 (copy), updateLikesLabel (copy), playLikeButtonPop (copy), Remotes (copy), Events (copy)
    local v132 = tick();
    local v133;

    if u130 == u131 then
        v133 = v132 - u129 <= 0.2;
    else
        v133 = false;
    end;

    u129 = v132;
    u130 = u131;

    if not v133 then
        if not u5.IsOpen or u9 ~= u131 then
            u5.Open(u131);
        end;

        return;
    end;

    if u11 then
        return;
    end;

    u11 = true;
    task.spawn(function() -- Line: 826
        -- upvalues: u5 (ref), u9 (ref), u131 (copy), u10 (ref), ThemeController (ref), u2 (ref), u3 (ref), TweenService (ref), fill (ref), u4 (ref), updateLikesLabel (ref), playLikeButtonPop (ref), Remotes (ref), Events (ref), u11 (ref)
        local v134 = u5.IsOpen and u9 == u131;

        if v134 then
            u10 = not u10;
            local v135;

            if u10 then
                v135 = u2;
            else
                v135 = u3;
            end;

            TweenService:Create(fill, u4, {
                ImageColor3 = ThemeController.GetColor(v135)
            }):Play();

            if u10 then
                updateLikesLabel(1);
                playLikeButtonPop();
            else
                updateLikesLabel(-1);
            end;
        end;

        local v136 = Remotes.LikeAction:InvokeServer("ToggleLike", u131);

        if v136 == true then
            Events.Notify:Fire("❤️ Liked " .. u131.DisplayName .. "!");
            Events.PlayLikeEffect:Fire();

            if u5.IsOpen and u9 == u131 then
                u10 = true;
                TweenService:Create(fill, u4, {
                    ImageColor3 = ThemeController.GetColor(u2)
                }):Play();
            end;
        elseif v136 == false then
            Events.Notify:Fire("💔 Unliked " .. u131.DisplayName .. ".");

            if u5.IsOpen and u9 == u131 then
                u10 = false;
                TweenService:Create(fill, u4, {
                    ImageColor3 = ThemeController.GetColor(u3)
                }):Play();
            end;
        elseif u5.IsOpen and (u9 == u131 and v134) then
            u10 = not u10;
            local v137;

            if u10 then
                v137 = u2;
            else
                v137 = u3;
            end;

            TweenService:Create(fill, u4, {
                ImageColor3 = ThemeController.GetColor(v137)
            }):Play();
            updateLikesLabel(u10 and 1 or -1);
        end;

        u11 = false;
    end);
end;

local u138 = {};
UserInputService.InputBegan:Connect(function(p139, p140) -- Line: 892
    -- upvalues: u138 (copy)
    if p139.UserInputType == Enum.UserInputType.MouseButton1 or p139.UserInputType == Enum.UserInputType.Touch then
        u138[p139] = {
            position = p139.Position,
            processed = p140
        };
    end;
end);
UserInputService.InputEnded:Connect(function(p141, p142) -- Line: 898
    -- upvalues: u138 (copy), isPointBlockedByUI (copy), pickPlayerAt (copy), u130 (ref), u129 (ref), u11 (ref), u5 (copy), u9 (ref), u10 (ref), ThemeController (copy), u2 (copy), u3 (copy), TweenService (copy), fill (copy), u4 (copy), updateLikesLabel (copy), playLikeButtonPop (copy), Remotes (copy), Events (copy)
    local v143 = u138[p141];
    u138[p141] = nil;

    if not v143 or v143.processed then
        return;
    end;

    if (Vector2.new(p141.Position.X, p141.Position.Y) - Vector2.new(v143.position.X, v143.position.Y)).Magnitude > 10 then
        return;
    end;

    if isPointBlockedByUI(p141.Position.X, p141.Position.Y) then
        return;
    end;

    local u144 = pickPlayerAt(Vector2.new(p141.Position.X, p141.Position.Y));

    if u144 then
        local v145 = tick();
        local v146;

        if u130 == u144 then
            v146 = v145 - u129 <= 0.2;
        else
            v146 = false;
        end;

        u129 = v145;
        u130 = u144;

        if v146 then
            if u11 then
                return;
            end;

            u11 = true;
            task.spawn(function() -- Line: 826
                -- upvalues: u5 (ref), u9 (ref), u144 (copy), u10 (ref), ThemeController (ref), u2 (ref), u3 (ref), TweenService (ref), fill (ref), u4 (ref), updateLikesLabel (ref), playLikeButtonPop (ref), Remotes (ref), Events (ref), u11 (ref)
                local v147 = u5.IsOpen and u9 == u144;

                if v147 then
                    u10 = not u10;
                    local v148;

                    if u10 then
                        v148 = u2;
                    else
                        v148 = u3;
                    end;

                    TweenService:Create(fill, u4, {
                        ImageColor3 = ThemeController.GetColor(v148)
                    }):Play();

                    if u10 then
                        updateLikesLabel(1);
                        playLikeButtonPop();
                    else
                        updateLikesLabel(-1);
                    end;
                end;

                local v149 = Remotes.LikeAction:InvokeServer("ToggleLike", u144);

                if v149 == true then
                    Events.Notify:Fire("❤️ Liked " .. u144.DisplayName .. "!");
                    Events.PlayLikeEffect:Fire();

                    if u5.IsOpen and u9 == u144 then
                        u10 = true;
                        TweenService:Create(fill, u4, {
                            ImageColor3 = ThemeController.GetColor(u2)
                        }):Play();
                    end;
                elseif v149 == false then
                    Events.Notify:Fire("💔 Unliked " .. u144.DisplayName .. ".");

                    if u5.IsOpen and u9 == u144 then
                        u10 = false;
                        TweenService:Create(fill, u4, {
                            ImageColor3 = ThemeController.GetColor(u3)
                        }):Play();
                    end;
                elseif u5.IsOpen and (u9 == u144 and v147) then
                    u10 = not u10;
                    local v150;

                    if u10 then
                        v150 = u2;
                    else
                        v150 = u3;
                    end;

                    TweenService:Create(fill, u4, {
                        ImageColor3 = ThemeController.GetColor(v150)
                    }):Play();
                    updateLikesLabel(u10 and 1 or -1);
                end;

                u11 = false;
            end);

            return;
        end;

        if not u5.IsOpen or u9 ~= u144 then
            u5.Open(u144);
        end;
    end;
end);
local u151 = nil;

local function setHoveredPlayer(p152) -- Line: 914
    -- upvalues: u151 (ref), u92 (copy), TweenService (copy), u91 (copy), u90 (copy)
    if u151 == p152 then
        return;
    end;

    local v153 = u151 and u92[u151];

    if v153 and v153.highlight.Parent then
        TweenService:Create(v153.highlight, u91, {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end;

    u151 = p152;
    local v154;

    if p152 then
        v154 = u92[p152];
    else
        v154 = p152;
    end;

    if v154 and (v154.highlight.Parent and v154.character == p152.Character) then
        TweenService:Create(v154.highlight, u90, {
            FillTransparency = 0.95,
            OutlineTransparency = 0.5
        }):Play();
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 933
    -- upvalues: UserInputService (copy), GuiService (copy), isPointBlockedByUI (copy), setHoveredPlayer (copy), pickPlayerAt (copy)
    if not UserInputService.MouseEnabled then
        return;
    end;

    local v155 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local v156;

    if isPointBlockedByUI(v155.X, v155.Y) then
        v156 = nil;
    else
        v156 = pickPlayerAt(Vector2.new(v155.X, v155.Y));
    end;

    setHoveredPlayer(v156);
end);
Players.PlayerRemoving:Connect(function(p157) -- Line: 942
    -- upvalues: u92 (copy), u151 (ref), u130 (ref)
    u92[p157] = nil;

    if u151 == p157 then
        u151 = nil;
    end;

    if u130 == p157 then
        u130 = nil;
    end;
end);

return u5;