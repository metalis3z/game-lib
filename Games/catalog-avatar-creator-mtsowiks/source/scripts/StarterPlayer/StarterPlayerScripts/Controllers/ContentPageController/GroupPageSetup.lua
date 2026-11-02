-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local GroupService = game:GetService("GroupService");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
require(Modules.Shared.TimeUtilities);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
require(Modules.Services.Cache);
local ItemButton = require(Modules.Elements.ItemButton);
local LoadingController = require(Modules.Controllers.LoadingController);
require(Modules.Utilities.OutsideClickDetector);
require(Modules.Controllers.FavoriteController);
local CarouselScrollingFrame = require(Modules.Elements.CarouselScrollingFrame);
require(Modules.Controllers.HumanoidDescriptionController);
require(Modules.Controllers.AvatarPreviewController);
require(Modules.Services.ItemPreviewService);
local CatalogController = require(Modules.Controllers.CatalogController);
local Events = script.Parent.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local LocalPlayer = Players.LocalPlayer;
LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ContentPage"):WaitForChild("overlay");
local Readable = require(Modules.Utilities.Readable);
TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u1 = utf8.char(57344);
local v2 = {};

local function setupItemsList(p3, p4, p5) -- Line: 41
    -- upvalues: ItemButton (copy), CarouselScrollingFrame (copy)
    for _, child in p3.items:GetChildren() do
        if child:GetAttribute("isItem") then
            child:Destroy();
        end;
    end;

    for _, v in p4 do
        if p5 ~= nil then
            v.ItemType = p5.ItemType;

            if v.ItemType == "Bundle" then
                v.BundleType = p5.AssetType;
            else
                v.AssetType = p5.AssetType;
            end;
        end;

        ItemButton.new({
            IsDetailsPageItem = true,
            AvatarPreviewOnHover = true,
            AddEquippedOverlay = true,
            IsFavoriteAvailable = true,
            ItemDetails = v
        }).Parent = p3.items;
    end;

    CarouselScrollingFrame.new({
        IncrementPercentage = 50,
        ScrollingFrame = p3.items,
        ScrollLeftButton = p3.scrollLeft,
        ScrollRightButton = p3.scrollRight,
        LeftFade = p3.leftFade,
        RightFade = p3.rightFade
    });
end;

function v2.SetupPage(u6, u7) -- Line: 82
    -- upvalues: Remotes (copy), LocalPlayer (copy), u1 (copy), Readable (copy), CatalogUtilities (copy), CollectionService (copy), Events (copy), ThemeController (copy), GroupService (copy), AvatarEditorService (copy), setupItemsList (copy), CatalogController (copy), LoadingController (copy)
    local success, result = pcall(function() -- Line: 83
        -- upvalues: u7 (copy), Remotes (ref), LocalPlayer (ref), u1 (ref), Readable (ref), CatalogUtilities (ref), CollectionService (ref), Events (ref), ThemeController (ref), GroupService (ref), AvatarEditorService (ref), setupItemsList (ref), CatalogController (ref), u6 (copy), LoadingController (ref)
        local Page = u7.Page;
        local GroupId = u7.GroupId;
        local u8 = script.wrapper:Clone();
        u8.Visible = false;
        local container = u8.container;
        local store = u8.store;
        local v9, u10 = Remotes.GetGroupInfo:InvokeServer((tonumber(GroupId)));

        if not v9 then
            error("couldnt get groupinfo", u10);

            return;
        end;

        local v11 = nil;
        local v12 = LocalPlayer:GetRankInGroupAsync((tonumber(GroupId)));

        if v12 == 0 or u10.Roles == nil then
            container.insights.rank:Destroy();
        else
            for _, v in u10.Roles do
                if v.Rank == v12 then
                    v11 = v.Name;
                    break;
                end;
            end;

            if v11 == nil then
                container.insights.rank:Destroy();
            else
                container.insights.rank.Text = v11 .. " Rank";
            end;
        end;

        local u13 = u10.Owner == nil and "No One!" or (u10.Owner.DisplayName or u10.Owner.Username);

        if u10.Owner ~= nil and u10.Owner.HasVerifiedBadge == true then
            u13 = u13 .. u1;
        end;

        local v14 = u10.Name == nil and "Unable to retrieve group name" or u10.Name;

        if u10.HasVerifiedBadge then
            v14 = v14 .. u1;
        end;

        container.name.Text = v14;
        container.creator.Text = string.format(Readable.creator, u13);
        container.description.value.Text = (not u10.Description or u10.Description == "") and "<i>No description available.</i>" or u10.Description .. "\n ";
        container.groupIcon.Image = u10.GroupIconUrl or "";
        container.insights.memberCount.Text = CatalogUtilities.FormatMemberCount(u10.MemberCount) .. " Members";
        CollectionService:AddTag(container.description.value, "ScaledTextSizeMultiLine");
        Events.AddTooltipToObject:Fire(container.creator, "See creator\'s page", function() -- Line: 133
            -- upvalues: container (copy)
            return container.creator.TextBounds.X / 2 - container.creator.AbsoluteSize.X / 2;
        end);
        Events.AddTooltipToObject:Fire(container.insights.memberCount, CatalogUtilities.FormatNumber(u10.MemberCount));
        Events.AddTooltipToObject:Fire(container.insights:FindFirstChild("rank"), "Rank: " .. tostring(v12));
        local join = container.join;

        if v12 == 0 then
            if u10.IsManualApprovalOnly then
                join.label.Text = "Request to Join";
            else
                join.label.Text = "Join Community";
            end;

            join.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(51, 95, 255));
            local u15 = nil;
            u15 = join.Activated:Connect(function() -- Line: 151
                -- upvalues: GroupService (ref), GroupId (copy), Events (ref), join (copy), ThemeController (ref), u15 (ref)
                local v16 = GroupService:PromptJoinAsync(GroupId);

                if v16 == Enum.GroupMembershipStatus.Joined then
                    Events.Notify:Fire("✅ Successfully joined group!");
                    join.label.Text = "Joined";
                elseif v16 == Enum.GroupMembershipStatus.JoinRequestPending then
                    Events.Notify:Fire("✉️ Successfully sent join request!");
                    join.label.Text = "Request Pending";
                    join.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(70, 70, 70));
                else
                    if v16 ~= Enum.GroupMembershipStatus.AlreadyMember then
                        return;
                    end;

                    join.label.Text = "Joined";
                end;

                join.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(70, 70, 70));
                u15:Disconnect();
            end);
        else
            join.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(70, 70, 70));
            join.label.Text = "Joined";
        end;

        container.creator.MouseEnter:Connect(function() -- Line: 175
            -- upvalues: container (copy), Readable (ref), u13 (ref)
            container.creator.Text = string.format(Readable.creatorHovered, u13);
        end);
        container.creator.MouseLeave:Connect(function() -- Line: 179
            -- upvalues: container (copy), Readable (ref), u13 (ref)
            container.creator.Text = string.format(Readable.creator, u13);
        end);
        container.creator.Activated:Connect(function() -- Line: 183
            -- upvalues: u10 (copy), Events (ref)
            if u10.Owner then
                Events.DisplayContentPage:Fire({
                    Type = "UserProfile",
                    UserId = u10.Owner.UserId
                });
            end;
        end);
        task.spawn(function() -- Line: 193
            -- upvalues: store (copy), u8 (copy), GroupId (copy), AvatarEditorService (ref), setupItemsList (ref), CatalogController (ref), Events (ref), u10 (copy), u6 (ref)
            store.Visible = false;
            u8.seeMoreItems.Visible = false;
            local u17 = CatalogSearchParams.new();
            u17.CreatorId = GroupId;
            u17.CreatorType = Enum.CreatorTypeFilter.Group;
            u17.SortType = Enum.CatalogSortType.Bestselling;

            while true do
                local success, result = pcall(function() -- Line: 204
                    -- upvalues: AvatarEditorService (ref), u17 (copy)
                    return AvatarEditorService:SearchCatalogAsync(u17):GetCurrentPage();
                end);

                if not success then
                    task.wait(0.5);
                end;

                if success == true and result ~= nil then
                    setupItemsList(store, result);
                    u8.seeMoreItems.button.Activated:Connect(function() -- Line: 212
                        -- upvalues: CatalogController (ref), Events (ref), u10 (ref), u6 (ref)
                        if CatalogController.IsOpen then
                            CatalogController.SetFrontPageVisible(false);
                        else
                            CatalogController.Open({
                                SkipFrontPage = true
                            });
                        end;

                        Events.SetCatalogOptionsFilter:Fire({
                            CreatorName = u10.Name,
                            CreatorType = Enum.CreatorTypeFilter.Group
                        });
                        u6.ClosePage();
                    end);
                    u8.seeMoreItems.Visible = true;
                    store.Visible = true;

                    return;
                end;
            end;
        end);
        LoadingController.RemoveLoading();
        u8.Parent = Page;
        u8.Visible = true;
    end);

    return success, result;
end;

return v2;