-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("AvatarEditorService");
local TweenService = game:GetService("TweenService");
game:GetService("CollectionService");
local Players = game:GetService("Players");
local Modules = require(script.Parent.Parent.Modules);
require(Modules.Shared.TimeUtilities);
require(Modules.Shared.CatalogUtilities);
require(Modules.Services.Cache);
require(Modules.Elements.ItemButton);
local LoadingController = require(Modules.Controllers.LoadingController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local ItemDetailsPageSetup = require(script:WaitForChild("ItemDetailsPageSetup"));
local GroupPageSetup = require(script:WaitForChild("GroupPageSetup"));
local UserProfilePageSetup = require(script:WaitForChild("UserProfilePageSetup"));
local SavedOutfitPageSetup = require(script:WaitForChild("SavedOutfitPageSetup"));
local CommunityOutfitPageSetup = require(script:WaitForChild("CommunityOutfitPageSetup"));
local Events = script.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local LocalPlayer = Players.LocalPlayer;

local function dprint(...) -- Line: 28
end;

local ContentPage = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ContentPage");
local overlay = ContentPage:WaitForChild("overlay");
local container = script:WaitForChild("container");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(overlay, u1, {
    BackgroundTransparency = 0.6
});
local u3 = TweenService:Create(overlay, u1, {
    BackgroundTransparency = 1
});

local function syncCloseButton(p4) -- Line: 49
    local v5;

    if p4 then
        v5 = p4:FindFirstChild("closeButton");
    else
        v5 = p4;
    end;

    if not v5 then
        return;
    end;

    local X = p4.AbsoluteSize.X;

    if X <= 0 then
        return;
    end;

    local v6 = math.round(X * 0.012);
    v5.Position = UDim2.new(1, -v6, 0, v6);
end;

local u7 = {
    Current = {},
    Changed = Instance.new("BindableEvent")
};
overlay.BackgroundTransparency = 1;
ContentPage.Enabled = false;

function u7.DisplayPage(p8) -- Line: 64
    -- upvalues: dprint (copy), ContentPage (copy), u2 (copy), container (copy), u7 (copy), TweenService (copy), u1 (copy), LoadingController (copy), ItemDetailsPageSetup (copy), GroupPageSetup (copy), UserProfilePageSetup (copy), SavedOutfitPageSetup (copy), CommunityOutfitPageSetup (copy)
    dprint("display content page:", p8);
    ContentPage.Enabled = true;
    u2:Play();
    local u9 = container:Clone();
    u9.GroupTransparency = 1;
    u9.UIStroke.Transparency = 1;
    u9.Parent = ContentPage;
    u9.closeButton.Activated:Connect(u7.ClosePage);
    local v10;

    if u9 then
        v10 = u9:FindFirstChild("closeButton");
    else
        v10 = u9;
    end;

    if v10 then
        local X = u9.AbsoluteSize.X;

        if X > 0 then
            local v11 = math.round(X * 0.012);
            v10.Position = UDim2.new(1, -v11, 0, v11);
        end;
    end;

    u9:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 78
        -- upvalues: u9 (copy)
        local v12 = u9;
        local v13;

        if v12 then
            v13 = v12:FindFirstChild("closeButton");
        else
            v13 = v12;
        end;

        if not v13 then
            return;
        end;

        local X = v12.AbsoluteSize.X;

        if X <= 0 then
            return;
        end;

        local v14 = math.round(X * 0.012);
        v13.Position = UDim2.new(1, -v14, 0, v14);
    end);

    if u7.Current.Page ~= nil then
        u7.Current.Page:Destroy();
        u7.SetAllScrollingFramesEnabled(true);
    end;

    u7.Current = {
        Page = u9,
        Type = p8.Type,
        Item = p8.Item,
        Objects = {},
        Threads = {}
    };
    u7.Changed:Fire();
    TweenService:Create(u9, u1, {
        GroupTransparency = 0
    }):Play();
    TweenService:Create(u9.UIStroke, u1, {
        Transparency = 0
    }):Play();
    LoadingController.DisplayLoading(u9, "overlay");
    local v15 = nil;
    local v16 = nil;

    if p8.Type == "ItemDetails" then
        v15, v16 = ItemDetailsPageSetup.SetupPage(u7, {
            Page = u9,
            Item = p8.Item
        });
    elseif p8.Type == "Group" then
        v15, v16 = GroupPageSetup.SetupPage(u7, {
            Page = u9,
            GroupId = p8.GroupId
        });
    elseif p8.Type == "UserProfile" then
        v15, v16 = UserProfilePageSetup.SetupPage(u7, {
            Page = u9,
            UserId = p8.UserId
        });
    elseif p8.Type == "SavedOutfit" then
        v15, v16 = SavedOutfitPageSetup.SetupPage(u7, {
            Page = u9,
            OutfitDetails = p8.OutfitDetails
        });
    elseif p8.Type == "CommunityOutfit" then
        v15, v16 = CommunityOutfitPageSetup.SetupPage(u7, {
            Page = u9,
            OutfitDetails = p8.OutfitDetails
        });
    end;

    if v15 == false then
        warn("error while loading item details page:", v16);
        u7.ClosePage();
    end;
end;

function u7.SetAllScrollingFramesEnabled(p17) -- Line: 139
    -- upvalues: LocalPlayer (copy)
    for _, child in LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("ScreenGui") then
            for _, descendant in child:GetDescendants() do
                if descendant:IsA("ScrollingFrame") then
                    descendant.ScrollingEnabled = p17;
                end;
            end;
        end;
    end;
end;

function u7.ClosePage() -- Line: 151
    -- upvalues: u7 (copy), TweenService (copy), u1 (copy), u3 (copy), ContentPage (copy)
    u7.SetAllScrollingFramesEnabled(true);
    local Current = u7.Current;

    if Current.Objects then
        for _, v in Current.Objects do
            pcall(v.Destroy, v);
        end;
    end;

    if Current.Threads then
        for _, v in Current.Threads do
            pcall(task.cancel, v);
        end;
    end;

    if Current.Page == nil then
        return;
    end;

    u7.Current = {};
    u7.Changed:Fire();
    TweenService:Create(Current.Page, u1, {
        GroupTransparency = 1
    }):Play();
    TweenService:Create(Current.Page.UIStroke, u1, {
        Transparency = 1
    }):Play();
    u3:Play();
    u3.Completed:Wait();
    Current.Page:Destroy();
    ContentPage.Enabled = false;
    u7.SetAllScrollingFramesEnabled(true);
end;

Events.DisplayContentPage.Event:Connect(function(...) -- Line: 185
    -- upvalues: u7 (copy)
    u7.DisplayPage(...);
end);
Remotes.DisplayContentPage.OnClientEvent:Connect(function(p18) -- Line: 189
    -- upvalues: HumanoidDescriptionController (copy), u7 (copy)
    if p18 and (p18.Type == "CommunityOutfit" and p18.OutfitDetails) then
        local OutfitDetails = p18.OutfitDetails;

        if typeof(OutfitDetails.HumanoidDescription) == "string" then
            local v19, v20 = HumanoidDescriptionController.DeserializeHumanoidDescription(OutfitDetails.HumanoidDescription);
            OutfitDetails.HumanoidDescription = v19;
            OutfitDetails.RigType = v20;
        end;
    end;

    u7.DisplayPage(p18);
end);

return u7;