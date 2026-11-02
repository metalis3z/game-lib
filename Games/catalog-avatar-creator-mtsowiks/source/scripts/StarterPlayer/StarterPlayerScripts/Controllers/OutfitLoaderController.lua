-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local LocalPlayer = Players.LocalPlayer;
local OutfitLoader = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("OutfitLoader");
local container = OutfitLoader:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local outfitsSection = wrapper:WaitForChild("outfitsSection");
local container2 = outfitsSection:WaitForChild("outfits"):WaitForChild("container");
local searchContainer = wrapper:WaitForChild("searchContainer");
local searchInput = searchContainer.wrapper:WaitForChild("searchInput");
local clear = searchContainer:WaitForChild("clear");
searchInput.ClearTextOnFocus = false;
clear.Visible = false;
searchInput:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 26
    -- upvalues: clear (copy), searchInput (copy)
    clear.Visible = searchInput.Text ~= "";
end);
clear.Activated:Connect(function() -- Line: 30
    -- upvalues: searchInput (copy)
    searchInput.Text = "";
    searchInput:CaptureFocus();
end);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local ItemButton = require(Modules.Elements.ItemButton);
local LoadingController = require(script.Parent.LoadingController);
local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, v1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, v1, {
    GroupTransparency = 1
});
local Quad = Enum.EasingStyle.Quad;
local Out = Enum.EasingDirection.Out;
local u4 = 0;
local u5 = false;
local u6 = {
    IsOpen = false
};
local u7 = {};

local function clearConnections() -- Line: 61
    -- upvalues: u7 (copy)
    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
end;

local function tweenImage(p8) -- Line: 70
    -- upvalues: TweenService (copy), Quad (copy), Out (copy)
    if p8 and (p8.Parent and not p8:GetAttribute("Faded")) then
        TweenService:Create(p8, TweenInfo.new(0.16, Quad, Out), {
            ImageTransparency = 0
        }):Play();
        p8:SetAttribute("Faded", true);
    end;
end;

local function fadeOneImage(p9, p10) -- Line: 77
    -- upvalues: u4 (ref), tweenImage (copy)
    if not (p9 and p9.Parent) then
        return;
    end;

    if p9:GetAttribute("Faded") then
        return;
    end;

    local v11 = os.clock();

    while p10 == u4 and (p9.Parent and (not p9.IsLoaded and os.clock() - v11 < 1)) do
        task.wait(0.05);
    end;

    if p10 ~= u4 or (not p9 or (not p9.Parent or p9:GetAttribute("Faded"))) then
        return;
    end;

    tweenImage(p9);
end;

local function fadeAllItemsLeftToRight() -- Line: 88
    -- upvalues: u4 (ref), container2 (copy), fadeOneImage (copy)
    local u12 = u4;
    local v13 = {};

    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") == true and typeof(child.LayoutOrder) == "number" then
            local preview = child:FindFirstChild("preview");

            if preview then
                preview = preview:FindFirstChild("image");
            end;

            if preview and (preview:IsA("ImageLabel") and not preview:GetAttribute("Faded")) then
                table.insert(v13, child);
            end;
        end;
    end;

    table.sort(v13, function(p14, p15) -- Line: 101
        return (p14.LayoutOrder or 0) < (p15.LayoutOrder or 0);
    end);

    for i, v in v13 do
        task.delay((i - 1) * 0.035, function() -- Line: 106
            -- upvalues: v (copy), fadeOneImage (ref), u12 (copy)
            local preview = v:FindFirstChild("preview");

            if preview then
                preview = preview:FindFirstChild("image");
            end;

            if preview and preview:IsA("ImageLabel") then
                pcall(fadeOneImage, preview, u12);
            end;
        end);
    end;
end;

local function setCurrentlyLoaded(p16, p17) -- Line: 116
    -- upvalues: wrapper (copy), LocalPlayer (copy), u6 (copy)
    local currentLoadedContainer = wrapper.currentLoadedContainer;
    currentLoadedContainer.icon.Image = `rbxthumb://type=AvatarHeadShot&id={p16}&w=150&h=150`;
    currentLoadedContainer.username.Text = p16 == LocalPlayer.UserId and "You" or `@{p17 or "Not available"}`;
    u6.CurrentLoaded = p16;
end;

local function getLocalOutfits() -- Line: 123
    -- upvalues: AvatarEditorService (copy), Events (copy)
    local v18 = {};
    local success, result = pcall(function() -- Line: 125
        -- upvalues: AvatarEditorService (ref)
        return AvatarEditorService:GetOutfitsAsync(Enum.OutfitSource.Created, Enum.OutfitType.All);
    end);

    if not success then
        warn("Failed to fetch outfits: " .. tostring(result));
        Events.Notify:Fire("⚠️ Failed to get your outfits.");

        return v18;
    end;

    while true do
        for _, v in result:GetCurrentPage() do
            table.insert(v18, v);
        end;

        if result.IsFinished then
            return v18;
        end;

        local success2, result2 = pcall(function() -- Line: 147
            -- upvalues: result (copy)
            result:AdvanceToNextPageAsync();
        end);

        if not success2 then
            warn("Error advancing pages: " .. tostring(result2));
            Events.Notify:Fire("⚠️ Something went wrong.");

            return v18;
        end;
    end;
end;

local function loadOutfitButtons(p19, u20, u21) -- Line: 161
    -- upvalues: container2 (copy), u4 (ref), ItemButton (copy), ThemeController (copy), LocalPlayer (copy), loadOutfitButtons (copy), getLocalOutfits (copy), fadeAllItemsLeftToRight (copy)
    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") then
            child:Destroy();
        end;
    end;

    u4 = u4 + 1;
    local v22 = ItemButton.newOutfit({
        OutfitType = "RobloxAvatar",
        OutfitDetails = {
            Name = "Current Avatar",
            UserId = u20,
            Username = u21
        }
    });
    v22.LayoutOrder = -1;
    v22.Parent = container2;
    local v23 = ItemButton.AddLabel(v22, "Currently Wearing");

    if v23 then
        v23.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(254, 254, 255));
        v23.value.TextColor3 = ThemeController.GetColor(Color3.fromRGB(18, 18, 21));
    end;

    local v24 = 1;

    for _, v in p19 do
        local v25 = ItemButton.newOutfit({
            OutfitType = "RobloxOutfit",
            OutfitDetails = v,
            CanEditOutfit = u20 == LocalPlayer.UserId,

            RefreshOutfits = function() -- Line: 192, Name: RefreshOutfits
                -- upvalues: loadOutfitButtons (ref), getLocalOutfits (ref), u20 (copy), u21 (copy)
                loadOutfitButtons(getLocalOutfits(), u20, u21);
            end
        });
        v25.LayoutOrder = v24;
        v25.Parent = container2;
        v24 = v24 + 1;
    end;

    task.spawn(fadeAllItemsLeftToRight);
end;

local function stopLoading() -- Line: 204
    -- upvalues: u5 (ref), LoadingController (copy)
    u5 = false;
    LoadingController.RemoveLoading();
end;

local function loadPlayer(u26) -- Line: 209
    -- upvalues: u5 (ref), LoadingController (copy), outfitsSection (copy), Players (copy), Events (copy), u6 (copy), LocalPlayer (copy), AvatarEditorService (copy), getLocalOutfits (copy), loadOutfitButtons (copy), wrapper (copy), Remotes (copy)
    if u5 then
        return;
    end;

    u5 = true;
    LoadingController.DisplayLoading(outfitsSection, "overlay");
    local success, result = pcall(function() -- Line: 216
        -- upvalues: Players (ref), u26 (copy)
        return Players:GetUserIdFromNameAsync(u26);
    end);

    if success ~= false then
        if result then
            if u6.CurrentLoaded == result then
                u5 = false;
                LoadingController.RemoveLoading();

                return;
            end;

            if result == LocalPlayer.UserId then
                local u27 = nil;
                local v29 = AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Once(function(p28) -- Line: 244
                    -- upvalues: u27 (ref)
                    u27 = p28;
                end);
                AvatarEditorService:PromptAllowInventoryReadAccess();
                local v30 = task.spawn(function() -- Line: 248
                    -- upvalues: u27 (ref), AvatarEditorService (ref)
                    u27 = AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Wait();
                end);

                repeat
                    task.wait();
                until u27 ~= nil;

                pcall(task.cancel, v30);
                pcall(v29.Disconnect, v29);
                local Name = u27.Name;

                if Name == "Success" then
                    loadOutfitButtons(getLocalOutfits(), LocalPlayer.UserId, LocalPlayer.Name);
                    local currentLoadedContainer = wrapper.currentLoadedContainer;
                    currentLoadedContainer.icon.Image = `rbxthumb://type=AvatarHeadShot&id={result}&w=150&h=150`;
                    currentLoadedContainer.username.Text = result == LocalPlayer.UserId and "You" or "@Not available";
                    u6.CurrentLoaded = result;
                    u5 = false;
                    LoadingController.RemoveLoading();
                elseif Name == "PermissionDenied" then
                    Events.Notify:Fire("❌ Couldn\'t get your outfits without your permission.");
                elseif Name == "Failed" then
                    Events.Notify:Fire("❌ Something went wrong. Please try again.");
                end;

                u5 = false;
                LoadingController.RemoveLoading();

                return;
            end;

            local u31 = nil;
            local u32 = nil;
            local u33 = false;
            local v36 = task.spawn(function() -- Line: 276
                -- upvalues: u31 (ref), u32 (ref), Remotes (ref), result (copy), u33 (ref)
                local v34, v35 = Remotes.GetRobloxOutfits:InvokeServer(result);
                u31 = v34;
                u32 = v35;
                u33 = true;
            end);
            local v37 = os.clock();

            while not u33 and os.clock() - v37 < 15 do
                task.wait(0.1);
            end;

            if not u33 then
                pcall(task.cancel, v36);
                Events.Notify:Fire("⚠️ Request timed out. Please try again.");
                u5 = false;
                LoadingController.RemoveLoading();

                return;
            end;

            if u31 then
                loadOutfitButtons(u32, result, u26);
                local currentLoadedContainer = wrapper.currentLoadedContainer;
                currentLoadedContainer.icon.Image = `rbxthumb://type=AvatarHeadShot&id={result}&w=150&h=150`;
                currentLoadedContainer.username.Text = result == LocalPlayer.UserId and "You" or `@{u26 or "Not available"}`;
                u6.CurrentLoaded = result;
                u5 = false;
                LoadingController.RemoveLoading();
            else
                Events.Notify:Fire("❌ Something went wrong. Please try again.");
            end;

            u5 = false;
            LoadingController.RemoveLoading();
        end;

        return;
    end;

    if result:match("Unknown user") then
        Events.Notify:Fire("❌ Invalid username.");
    else
        Events.Notify:Fire("⚠️ Something went wrong.");
    end;

    u5 = false;
    LoadingController.RemoveLoading();
end;

function u6.Close() -- Line: 307
    -- upvalues: u6 (copy), u5 (ref), LoadingController (copy), u7 (copy), Events (copy), u3 (copy), OutfitLoader (copy)
    if not u6.IsOpen then
        return;
    end;

    u6.IsOpen = false;
    u5 = false;
    LoadingController.RemoveLoading();

    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
    Events.InterfaceAction:Fire("Remove", script.Name);
    u3:Play();
    u3.Completed:Once(function() -- Line: 316
        -- upvalues: u6 (ref), OutfitLoader (ref)
        if u6.IsOpen ~= true then
            OutfitLoader.Enabled = false;
        end;
    end);
end;

function u6.Open(p38) -- Line: 323
    -- upvalues: u6 (copy), OutfitLoader (copy), container (copy), u2 (copy), Events (copy), u7 (copy), wrapper (copy), LocalPlayer (copy), loadPlayer (copy), searchInput (copy), u5 (ref)
    if u6.IsOpen then
        if p38 then
            u6.Close();
        end;

        return;
    end;

    u6.IsOpen = true;
    OutfitLoader.Enabled = true;
    container.GroupTransparency = 1;
    u2:Play();
    Events.InterfaceAction:Fire("Add", script.Name, u6.Close);
    table.insert(u7, wrapper.closeButton.Activated:Connect(u6.Close));
    table.insert(u7, wrapper.returnButton.Activated:Connect(function() -- Line: 339
        -- upvalues: u6 (ref), Events (ref)
        u6.Close();
        Events.DisplayOutfits:Fire();
    end));

    if u6.CurrentLoaded == LocalPlayer.UserId or u6.CurrentLoaded == nil then
        task.spawn(loadPlayer, LocalPlayer.Name);
    end;

    table.insert(u7, searchInput.FocusLost:Connect(function(p39) -- Line: 348
        -- upvalues: u5 (ref), Events (ref), loadPlayer (ref), searchInput (ref)
        if p39 then
            if u5 then
                Events.Notify:Fire("⏳ Already loading outfits, please wait.");

                return;
            end;

            task.spawn(loadPlayer, searchInput.Text);
        end;
    end));
end;

Events.DisplayOutfitLoader.Event:Connect(u6.Open);

return u6;