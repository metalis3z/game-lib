-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Modules = require(script.Parent.Parent.Modules);
local LocalPlayer = Players.LocalPlayer;

local function dprint(...) -- Line: 10
end;

local PublishOutfit = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PublishOutfit");
local container = PublishOutfit:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local buttons = wrapper:WaitForChild("buttons");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local ItemButton = require(Modules.Elements.ItemButton);
local GetBatchItemDetails = require(Modules.Utilities.GetBatchItemDetails);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local LoadingController = require(Modules.Controllers.LoadingController);
local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, v1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, v1, {
    GroupTransparency = 1
});
PublishOutfit.Enabled = false;
local u4 = {
    IsOpen = false
};
local u5 = {};
local u6 = {};
local u7 = nil;
local u8 = nil;
local u9 = nil;

local function clearItemsContainer() -- Line: 46
    -- upvalues: wrapper (copy)
    for _, child in wrapper.itemsSection.items.container:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;
end;

function u4.Close() -- Line: 54
    -- upvalues: u4 (copy), Events (copy), u6 (copy), LoadingController (copy), u5 (copy), u7 (ref), u3 (copy), PublishOutfit (copy), clearItemsContainer (copy)
    if not u4.IsOpen then
        return;
    end;

    u4.IsOpen = false;
    Events.InterfaceAction:Fire("Remove", script.Name);

    if avatarPreviewObject then
        pcall(avatarPreviewObject.Destroy, avatarPreviewObject);
        avatarPreviewObject = nil;
    end;

    for _, v in u6 do
        pcall(task.cancel, v);
    end;

    table.clear(u6);
    LoadingController.RemoveLoading();

    for _, v in u5 do
        pcall(v.Disconnect, v);
    end;

    table.clear(u5);

    if u7 then
        u7();
    end;

    u3:Play();
    u3.Completed:Once(function() -- Line: 81
        -- upvalues: u4 (ref), PublishOutfit (ref), clearItemsContainer (ref)
        if u4.IsOpen ~= true then
            PublishOutfit.Enabled = false;
            clearItemsContainer();
        end;
    end);
end;

function u4.Open(p10, p11, p12) -- Line: 89
    -- upvalues: u4 (copy), Events (copy), u7 (ref), u8 (ref), HumanoidDescriptionController (copy), u9 (ref), PublishOutfit (copy), container (copy), u2 (copy), wrapper (copy), clearItemsContainer (copy), LoadingController (copy), u6 (copy), AvatarPreviewController (copy), CatalogUtilities (copy), GetBatchItemDetails (copy), dprint (copy), ItemButton (copy), u5 (copy), buttons (copy), Remotes (copy), LocalPlayer (copy)
    local u13 = p12 or {};

    if u4.IsOpen then
        if p10 then
            u4.Close();
        end;

        return;
    end;

    u4.IsOpen = true;
    Events.InterfaceAction:Fire("Add", script.Name, u4.Close, true);
    u7 = p11 or nil;
    u8 = u13.HumanoidDescription or (u13.Description or HumanoidDescriptionController.GetCurrentDescription());
    local v14;

    if u13.RigType then
        v14 = u13.RigType;
    else
        v14 = nil;
    end;

    u9 = v14;
    PublishOutfit.Enabled = true;
    container.GroupTransparency = 1;
    u2:Play();
    wrapper.input.Text = "";
    Events.Notify:Fire("⚠️ <b>Warning!</b> Publishing inappropriate outfits is not allowed.", 5);
    clearItemsContainer();
    LoadingController.DisplayLoading(wrapper.itemsSection, "overlay");
    table.insert(u6, task.spawn(function() -- Line: 117
        -- upvalues: u13 (ref), u9 (ref), HumanoidDescriptionController (ref), u4 (ref), u8 (ref), AvatarPreviewController (ref), wrapper (ref)
        local v15;

        if u13.RigType then
            v15 = u9;
        else
            v15 = HumanoidDescriptionController.GetHumanoid().RigType;
        end;

        if not u4.IsOpen or avatarPreviewObject then
            return;
        end;

        local v16;

        if u13.HumanoidDescription == nil then
            v16 = u13.Description == nil;
        else
            v16 = false;
        end;

        avatarPreviewObject = AvatarPreviewController.new(wrapper.preview.viewport, u8, {
            AllowCameraAdjustment = true,
            RigType = v15,
            UseLiveAdjustments = v16
        });
    end));
    local v17 = GetBatchItemDetails((CatalogUtilities.GetEquippedAssetIdsFromDescription(u8, nil, true)));
    dprint("itemdetails:", v17);

    for _, v in v17 do
        local v18 = ItemButton.new({
            IsFavoriteAvailable = true,
            OnlyIcon = true,
            ItemData = v,

            CustomCallback = function() -- Line: 145, Name: CustomCallback
            end
        });
        v18.LayoutOrder = CatalogUtilities.GetLayoutOrderFromAssetType(v.AssetType or v.BundleType, v.ItemType);
        v18.Parent = wrapper.itemsSection.items.container;
    end;

    LoadingController.RemoveLoading();
    table.insert(u5, wrapper.closeButton.Activated:Connect(u4.Close));
    table.insert(u5, buttons.cancel.Activated:Connect(u4.Close));
    table.insert(u5, buttons.publish.Activated:Connect(function() -- Line: 157
        -- upvalues: Remotes (ref), wrapper (ref), u13 (ref), Events (ref), u4 (ref), u9 (ref), HumanoidDescriptionController (ref), u8 (ref), LocalPlayer (ref)
        local v19, v20, v21 = Remotes.CommunityOutfitsAction:InvokeServer("PublishOutfit", {
            Name = wrapper.input.Text,
            Source = u13.Source,
            Info = u13.Info
        });

        if v19 == false then
            if v20 and (typeof(v20) == "string" and v20 == "cooldown") then
                Events.Notify:Fire("⚠️ You are going too fast. Please wait and retry.");

                return;
            end;

            if typeof(v20) == "string" and (v20 ~= "Internal error" and v20 ~= "Internal error.") then
                Events.Notify:Fire("⚠️ " .. v20);

                return;
            end;

            Events.Notify:Fire("❌ Something went wrong. Please try again.");

            return;
        end;

        local Text = wrapper.input.Text;
        Events.Notify:Fire("✅ Successfully published your outfit!" .. (not v21 and "" or " Share Code: " .. v21));
        u4.Close();
        local v22 = u9 or HumanoidDescriptionController.GetHumanoid().RigType;
        Events.DisplayContentPage:Fire({
            Type = "CommunityOutfit",
            OutfitDetails = {
                FavoriteCount = 0,
                CommentCount = 0,
                ViewCount = 0,
                WornCount = 0,
                Name = Text,
                Id = v20,
                HumanoidDescription = u8,
                CreatorId = LocalPlayer.UserId,
                RigType = v22,
                Created = os.time(),
                ShareCode = v21
            }
        });
    end));
end;

Events.DisplayPublishOutfit.Event:Connect(u4.Open);

return u4;