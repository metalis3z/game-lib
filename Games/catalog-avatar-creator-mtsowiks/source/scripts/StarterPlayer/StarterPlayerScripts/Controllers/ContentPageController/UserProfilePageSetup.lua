-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
game:GetService("GroupService");
local Modules = require(script.Parent.Parent.Parent.Modules);
require(Modules.Controllers.ThemeController);
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
Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ContentPage"):WaitForChild("overlay");
require(Modules.Utilities.Readable);
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
    -- upvalues: Players (copy), CollectionService (copy), Remotes (copy), u1 (copy), CatalogUtilities (copy), Events (copy), AvatarEditorService (copy), setupItemsList (copy), CatalogController (copy), LoadingController (copy)
    local success, result = pcall(function() -- Line: 83
        -- upvalues: u7 (copy), Players (ref), CollectionService (ref), Remotes (ref), u1 (ref), CatalogUtilities (ref), Events (ref), AvatarEditorService (ref), setupItemsList (ref), CatalogController (ref), u6 (copy), LoadingController (ref)
        local Page = u7.Page;
        local UserId = u7.UserId;
        local u8 = script.wrapper:Clone();
        u8.Visible = false;
        local container = u8.container;
        local store = u8.store;
        local v9 = nil;
        local success, result = pcall(function() -- Line: 97
            -- upvalues: Players (ref), UserId (copy)
            return Players:GetNameFromUserIdAsync(UserId);
        end);

        if success and typeof(result) == "string" then
            if result == "" then
                result = v9;
            end;
        else
            result = v9;
        end;

        local u10 = result and {
            Username = result
        } or nil;
        container.displayName.Text = result or "Unable to retrieve display name";
        container.username.Text = not result and "Unable to retrieve username" or "@" .. result;
        container.description.value.Text = "<i>Loading...</i>";
        container.icon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(UserId) .. "&w=150&h=150";
        container.avatar.Image = "rbxthumb://type=Avatar&id=" .. tostring(UserId) .. "&w=150&h=150";
        container.insights.followersCount.Visible = false;
        container.insights.friendsCount.Visible = false;
        CollectionService:AddTag(container.description.value, "ScaledTextSizeMultiLine");
        task.spawn(function() -- Line: 123
            -- upvalues: Remotes (ref), UserId (copy), u8 (copy), u1 (ref), container (copy), CatalogUtilities (ref), Events (ref)
            local success2, result2 = pcall(function() -- Line: 124
                -- upvalues: Remotes (ref), UserId (ref)
                return Remotes.GetUserProfileInfo:InvokeServer((tonumber(UserId)));
            end);

            if not success2 or typeof(result2) ~= "table" then
                return;
            end;

            if u8.Parent == nil then
                return;
            end;

            local UserInfo = result2.UserInfo;

            if UserInfo then
                local DisplayName = UserInfo.DisplayName;

                if typeof(DisplayName) == "string" and DisplayName ~= "" then
                    if UserInfo.HasVerifiedBadge == true then
                        DisplayName = DisplayName .. u1;
                    end;

                    container.displayName.Text = DisplayName;
                end;

                local Description = UserInfo.Description;

                if typeof(Description) == "string" and Description ~= "" then
                    container.description.value.Text = Description .. "\n ";
                else
                    container.description.value.Text = "<i>No description available.</i>";
                end;
            else
                container.description.value.Text = "<i>No description available.</i>";
            end;

            if typeof(result2.FollowerCount) == "number" then
                local FollowerCount = result2.FollowerCount;
                container.insights.followersCount.Text = CatalogUtilities.FormatNumber(FollowerCount) .. " Follower" .. (FollowerCount == 1 and "" or "s");
                container.insights.followersCount.Visible = true;
                Events.AddTooltipToObject:Fire(container.insights.followersCount, CatalogUtilities.FormatNumber(FollowerCount));
            end;

            if typeof(result2.FriendCount) == "number" then
                local FriendCount = result2.FriendCount;
                container.insights.friendsCount.Text = CatalogUtilities.FormatNumber(FriendCount) .. " Friend" .. (FriendCount == 1 and "" or "s");
                container.insights.friendsCount.Visible = true;
            end;
        end);
        task.spawn(function() -- Line: 169
            -- upvalues: store (copy), u8 (copy), UserId (copy), AvatarEditorService (ref), setupItemsList (ref), CatalogController (ref), Events (ref), u10 (copy), u6 (ref)
            store.Visible = false;
            u8.seeMoreItems.Visible = false;
            local u11 = CatalogSearchParams.new();
            u11.CreatorId = UserId;
            u11.CreatorType = Enum.CreatorTypeFilter.User;
            u11.SortType = Enum.CatalogSortType.Bestselling;
            u11.IncludeOffSale = true;

            while true do
                local success2, result2 = pcall(function() -- Line: 181
                    -- upvalues: AvatarEditorService (ref), u11 (copy)
                    return AvatarEditorService:SearchCatalogAsync(u11):GetCurrentPage();
                end);

                if not success2 then
                    task.wait(0.5);
                end;

                if success2 == true and result2 ~= nil then
                    setupItemsList(store, result2);
                    store.empty.Visible = #result2 == 0;

                    if #result2 == 0 then
                        u8.seeMoreItems:Destroy();
                    else
                        u8.seeMoreItems.button.Activated:Connect(function() -- Line: 193
                            -- upvalues: CatalogController (ref), Events (ref), u10 (ref), u6 (ref)
                            if CatalogController.IsOpen then
                                CatalogController.SetFrontPageVisible(false);
                            else
                                CatalogController.Open({
                                    SkipFrontPage = true
                                });
                            end;

                            Events.SetCatalogOptionsFilter:Fire({
                                CreatorName = u10.Username,
                                CreatorType = Enum.CreatorTypeFilter.User
                            });
                            u6.ClosePage();
                        end);
                        u8.seeMoreItems.Visible = true;
                    end;

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