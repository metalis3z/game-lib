-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Modules = require(script.Parent.Parent.Modules);
local LocalPlayer = Players.LocalPlayer;
local ConfirmationDialog = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ConfirmationDialog");
local Events = script.Parent.Parent.Events;
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local GetBatchItemDetails = require(Modules.Utilities.GetBatchItemDetails);
local ItemButton = require(Modules.Elements.ItemButton);
local ThemeController = require(Modules.Controllers.ThemeController);
local DraggablePanel = require(Modules.Utilities.DraggablePanel);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u2 = {
    IsDialogOpen = false,
    CurrentResetAvatarDialog = {}
};

local function genericPrompt(u3, p4, u5, p6, u7) -- Line: 27
    -- upvalues: u2 (copy), TweenService (copy), u1 (copy), Events (copy), ConfirmationDialog (copy)
    u2.IsDialogOpen = true;
    local BindableEvent = Instance.new("BindableEvent");
    local buttons = u3:WaitForChild("wrapper"):WaitForChild("buttons");
    local v8 = p4 or {};

    local function close(p9) -- Line: 35
        -- upvalues: TweenService (ref), u3 (copy), u1 (ref), Events (ref), u2 (ref), u5 (copy), BindableEvent (copy)
        local v10 = TweenService:Create(u3, u1, {
            GroupTransparency = 1
        });
        v10:Play();
        v10.Completed:Connect(function() -- Line: 40
            -- upvalues: u3 (ref)
            u3:Destroy();
        end);
        Events.InterfaceAction:Fire("Remove", script.Name);
        u2.IsDialogOpen = false;

        if u5 then
            u5();
        end;

        BindableEvent:Fire(p9);
    end;

    if p6 then
        p6.Close = close;
    end;

    Events.InterfaceAction:Fire("Add", script.Name, close, not u3.Name:match("resetAvatar"));

    if v8.IsCatalogQuickAction == true then
        task.defer(function() -- Line: 58
            -- upvalues: Events (ref)
            Events.SetButtonsVisible:Fire({ "Undo", "Redo" });
        end);
    end;

    buttons.no.Activated:Connect(function() -- Line: 63
        -- upvalues: close (copy)
        close(false);
    end);
    buttons.yes.Activated:Connect(function() -- Line: 64
        -- upvalues: u7 (copy), close (copy)
        close(typeof(u7) ~= "function" and true or u7());
    end);
    u3.GroupTransparency = 1;
    u3.Parent = ConfirmationDialog;
    TweenService:Create(u3, u1, {
        GroupTransparency = 0
    }):Play();
    local v11 = BindableEvent.Event:Wait();
    BindableEvent:Destroy();

    if v8.CustomCallback then
        v8.CustomCallback(v11);
    end;

    return v11;
end;

function u2.PromptDialog(p12) -- Line: 86
    -- upvalues: u2 (copy), genericPrompt (copy)
    if u2.IsDialogOpen then
        warn("a dialog is currently open!");

        return false;
    end;

    local v13 = script.basicDialog:Clone();

    if p12.Preset == "confirmYesNo" then
        p12.Title = "Confirm choice";
        p12.Description = "Are you sure?";
    end;

    local wrapper = v13:WaitForChild("wrapper");
    wrapper.description.value.Text = p12.Description;
    wrapper.title.Text = p12.Title;
    wrapper.buttons.no.Text = p12.NoText or "Cancel";
    wrapper.buttons.yes.Text = p12.YesText or "Confirm";

    return genericPrompt(v13);
end;

function u2.PromptInputDialog(p14) -- Line: 104
    -- upvalues: u2 (copy), genericPrompt (copy)
    if u2.IsDialogOpen then
        warn("a dialog is currently open!");

        return false;
    end;

    local v15 = script.inputDialog:Clone();
    local wrapper = v15:WaitForChild("wrapper");
    local input = wrapper:WaitForChild("input");
    wrapper.description.value.Text = p14.Description or "";
    wrapper.title.Text = p14.Title or "Input Required";
    wrapper.buttons.no.Text = p14.NoText or "Cancel";
    wrapper.buttons.yes.Text = p14.YesText or "Confirm";
    input.PlaceholderText = p14.PlaceholderText or "";
    input.Text = p14.DefaultText or "";

    if p14.ReadOnly then
        input.ClearTextOnFocus = false;
        input.TextEditable = false;
    end;

    return genericPrompt(v15, p14, nil, nil, function() -- Line: 124
        -- upvalues: input (copy)
        return input.Text;
    end);
end;

local u16 = false;
u2.CurrentConfirmAvatarDialog = {};

function u2.PromptConfirmAvatar(p17) -- Line: 135
    -- upvalues: u16 (ref), u2 (copy), DraggablePanel (copy), ConfirmationDialog (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), genericPrompt (copy)
    local u18 = p17 or {};

    if u16 then
        return false;
    end;

    u16 = true;
    local CurrentConfirmAvatarDialog = u2.CurrentConfirmAvatarDialog;

    if CurrentConfirmAvatarDialog and CurrentConfirmAvatarDialog.Container then
        CurrentConfirmAvatarDialog.Container:Destroy();

        if CurrentConfirmAvatarDialog.AvatarPreviewObject then
            CurrentConfirmAvatarDialog.AvatarPreviewObject:Destroy();
        end;

        if CurrentConfirmAvatarDialog.DragHandle then
            CurrentConfirmAvatarDialog.DragHandle:Destroy();
        end;

        u2.CurrentConfirmAvatarDialog = {};
    end;

    local u19 = script.resetAvatar:Clone();
    u19.Name = "confirmAvatar";
    local wrapper = u19:WaitForChild("wrapper");
    local title = wrapper:FindFirstChild("title");

    if title and title:IsA("TextLabel") then
        title.Text = u18.Title or "Confirm";
    end;

    local buttons = wrapper:WaitForChild("buttons");
    buttons.yes.Text = u18.YesText or "Confirm";
    buttons.no.Text = u18.NoText or "Cancel";
    local title2 = wrapper:FindFirstChild("title");
    local v20;

    if title2 then
        v20 = DraggablePanel.new(title2, u19, {
            ScreenGui = ConfirmationDialog
        }) or nil;
    else
        v20 = nil;
    end;

    u2.CurrentConfirmAvatarDialog = {
        Container = u19,
        DragHandle = v20
    };
    task.spawn(function() -- Line: 166
        -- upvalues: u18 (ref), HumanoidDescriptionController (ref), u19 (copy), u2 (ref), AvatarPreviewController (ref), wrapper (copy)
        local v21 = u18.RigType or HumanoidDescriptionController.GetRigType();
        local HumanoidDescription = u18.HumanoidDescription;

        if typeof(HumanoidDescription) ~= "Instance" then
            return;
        end;

        for _ = 1, 120 do
            if u19:IsDescendantOf(game) then
                break;
            end;

            task.wait();
        end;

        if not u19:IsDescendantOf(game) or u2.CurrentConfirmAvatarDialog.Container ~= u19 then
            return;
        end;

        local v22 = AvatarPreviewController.new(wrapper.preview.viewport, HumanoidDescription, {
            AllowCameraAdjustment = true,
            RigType = v21
        });

        if u2.CurrentConfirmAvatarDialog.Container == u19 then
            u2.CurrentConfirmAvatarDialog.AvatarPreviewObject = v22;

            return;
        end;

        v22:Destroy();
    end);
    u16 = false;

    return genericPrompt(u19, u18, function() -- Line: 191
        -- upvalues: u2 (ref)
        local CurrentConfirmAvatarDialog2 = u2.CurrentConfirmAvatarDialog;

        if CurrentConfirmAvatarDialog2.AvatarPreviewObject then
            CurrentConfirmAvatarDialog2.AvatarPreviewObject:Destroy();
        end;

        if CurrentConfirmAvatarDialog2.DragHandle then
            CurrentConfirmAvatarDialog2.DragHandle:Destroy();
        end;

        u2.CurrentConfirmAvatarDialog = {};
    end, u2.CurrentConfirmAvatarDialog);
end;

local u23 = false;

function u2.PromptResetAvatar(p24) -- Line: 200
    -- upvalues: u23 (ref), u2 (copy), DraggablePanel (copy), ConfirmationDialog (copy), HumanoidDescriptionController (copy), Players (copy), LocalPlayer (copy), AvatarPreviewController (copy), genericPrompt (copy)
    if not u23 then
        u23 = true;
        local CurrentResetAvatarDialog = u2.CurrentResetAvatarDialog;

        if CurrentResetAvatarDialog and CurrentResetAvatarDialog.Container then
            CurrentResetAvatarDialog.Container:Destroy();

            if CurrentResetAvatarDialog.AvatarPreviewObject then
                CurrentResetAvatarDialog.AvatarPreviewObject:Destroy();
            end;

            if CurrentResetAvatarDialog.DragHandle then
                CurrentResetAvatarDialog.DragHandle:Destroy();
            end;

            u2.CurrentResetAvatarDialog = {};
        end;

        local u25 = script.resetAvatar:Clone();
        local wrapper = u25:WaitForChild("wrapper");
        local title = wrapper:FindFirstChild("title");
        local v26;

        if title then
            v26 = DraggablePanel.new(title, u25, {
                ScreenGui = ConfirmationDialog
            }) or nil;
        else
            v26 = nil;
        end;

        u2.CurrentResetAvatarDialog = {
            Container = u25,
            DragHandle = v26
        };
        task.spawn(function() -- Line: 226
            -- upvalues: HumanoidDescriptionController (ref), Players (ref), LocalPlayer (ref), u25 (copy), AvatarPreviewController (ref), wrapper (copy), u2 (ref)
            local v27 = HumanoidDescriptionController.GetRigType();
            local success, result = pcall(function() -- Line: 228
                -- upvalues: Players (ref), LocalPlayer (ref)
                return Players:GetHumanoidDescriptionFromUserIdAsync(LocalPlayer.UserId);
            end);

            if not (success and u25:IsDescendantOf(game)) then
                return;
            end;

            local v28 = AvatarPreviewController.new(wrapper.preview.viewport, result, {
                AllowCameraAdjustment = true,
                RigType = v27
            });

            if u2.CurrentResetAvatarDialog.Container == u25 then
                u2.CurrentResetAvatarDialog.AvatarPreviewObject = v28;

                return;
            end;

            v28:Destroy();
        end);
        u23 = false;

        return genericPrompt(u25, p24, function() -- Line: 248
            -- upvalues: u2 (ref)
            local CurrentResetAvatarDialog2 = u2.CurrentResetAvatarDialog;

            if CurrentResetAvatarDialog2.AvatarPreviewObject then
                CurrentResetAvatarDialog2.AvatarPreviewObject:Destroy();
            end;

            if CurrentResetAvatarDialog2.DragHandle then
                CurrentResetAvatarDialog2.DragHandle:Destroy();
            end;

            u2.CurrentResetAvatarDialog = {};
        end, u2.CurrentResetAvatarDialog);
    end;
end;

local u29 = false;
u2.CurrentWearLatestOutfitDialog = {};

function u2.PromptWearLatestOutfit(p30) -- Line: 262
    -- upvalues: u29 (ref), u2 (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), CatalogUtilities (copy), GetBatchItemDetails (copy), ItemButton (copy), genericPrompt (copy)
    if not u29 then
        u29 = true;
        local CurrentWearLatestOutfitDialog = u2.CurrentWearLatestOutfitDialog;

        if CurrentWearLatestOutfitDialog and CurrentWearLatestOutfitDialog.Container then
            CurrentWearLatestOutfitDialog.Container:Destroy();

            if CurrentWearLatestOutfitDialog.AvatarPreviewObject then
                CurrentWearLatestOutfitDialog.AvatarPreviewObject:Destroy();
            end;

            u2.CurrentWearLatestOutfitDialog = {};
        end;

        local v31 = p30 or {};
        local SerializedDescription = v31.SerializedDescription;
        local u32 = script.wearLatestOutfit:Clone();
        local wrapper = u32:WaitForChild("wrapper");
        local container = wrapper.itemsSection.items.container;

        for _, child in container:GetChildren() do
            if child:IsA("Frame") and child.Name == "item" then
                child:Destroy();
            end;
        end;

        u2.CurrentWearLatestOutfitDialog = {
            Container = u32
        };
        wrapper.closeButton.Activated:Connect(function() -- Line: 292
            -- upvalues: u2 (ref)
            local CurrentWearLatestOutfitDialog2 = u2.CurrentWearLatestOutfitDialog;

            if CurrentWearLatestOutfitDialog2 and CurrentWearLatestOutfitDialog2.Close then
                CurrentWearLatestOutfitDialog2.Close(false);
            end;
        end);

        if SerializedDescription then
            local u33, u34 = HumanoidDescriptionController.DeserializeHumanoidDescription(SerializedDescription);

            if u33 then
                task.spawn(function() -- Line: 305
                    -- upvalues: AvatarPreviewController (ref), wrapper (copy), u33 (copy), u34 (copy), u2 (ref), u32 (copy)
                    local v35 = AvatarPreviewController.new(wrapper.preview.viewport, u33, {
                        AllowCameraAdjustment = true,
                        RigType = u34 or Enum.HumanoidRigType.R15
                    });

                    if u2.CurrentWearLatestOutfitDialog.Container == u32 then
                        u2.CurrentWearLatestOutfitDialog.AvatarPreviewObject = v35;

                        return;
                    end;

                    v35:Destroy();
                end);
                task.spawn(function() -- Line: 319
                    -- upvalues: CatalogUtilities (ref), u33 (copy), GetBatchItemDetails (ref), ItemButton (ref), container (copy)
                    local v36 = CatalogUtilities.GetEquippedAssetIdsFromDescription(u33);
                    warn("[WearLatest] equipped:", v36 and (#v36 or "nil") or "nil");

                    if not v36 then
                        return;
                    end;

                    local v37 = {};

                    for _, v in v36 do
                        v37[tostring(v.AssetId)] = {
                            ItemType = v.ItemType
                        };
                    end;

                    local v38 = 0;

                    for _ in v37 do
                        v38 = v38 + 1;
                    end;

                    warn("[WearLatest] itemsToFetch count:", v38);
                    local v39 = GetBatchItemDetails(v37);
                    local v40 = 0;

                    for _ in v39 do
                        v40 = v40 + 1;
                    end;

                    warn("[WearLatest] itemDetailsBatch count:", v40);

                    for _, v in v39 do
                        if v.ItemType ~= "Bundle" then
                            local v41 = ItemButton.new({
                                ItemData = v,
                                ItemDetails = {
                                    Id = v.Id,
                                    AssetType = v.AssetType,
                                    ItemType = v.ItemType,
                                    BundleType = v.BundleType
                                }
                            });
                            v41.LayoutOrder = CatalogUtilities.GetLayoutOrderFromAssetType(v.AssetType, v.ItemType);
                            v41.Name = tostring(v.Id);
                            v41.Parent = container;
                        end;
                    end;
                end);
            end;
        end;

        u29 = false;

        return genericPrompt(u32, v31, function() -- Line: 366
            -- upvalues: u2 (ref)
            local CurrentWearLatestOutfitDialog2 = u2.CurrentWearLatestOutfitDialog;

            if CurrentWearLatestOutfitDialog2.AvatarPreviewObject then
                CurrentWearLatestOutfitDialog2.AvatarPreviewObject:Destroy();
            end;

            u2.CurrentWearLatestOutfitDialog = {};
        end, u2.CurrentWearLatestOutfitDialog);
    end;
end;

Events.PromptResetAvatar.OnInvoke = u2.PromptResetAvatar;
Events.PromptConfirmationDialog.OnInvoke = u2.PromptDialog;
Events.PromptInputDialog.OnInvoke = u2.PromptInputDialog;

function Events.GetCurrentResetAvatarDialog.OnInvoke() -- Line: 378
    -- upvalues: u2 (copy)
    return u2.CurrentResetAvatarDialog;
end;

local Theme = require(Modules.Services.PriceDisplay.Theme);

function u2.PromptGetRobloxPlus(p42) -- Line: 384
    -- upvalues: u2 (copy), CatalogUtilities (copy), Theme (copy), ThemeController (copy), genericPrompt (copy)
    if u2.IsDialogOpen then
        warn("a dialog is currently open!");

        return {
            Yes = false,
            DismissedViaClose = false
        };
    end;

    local v43 = p42 or {};
    local v44 = typeof(v43.BaseTotal) ~= "number" and 0 or v43.BaseTotal;
    local v45 = typeof(v43.Savings) ~= "number" and 0 or v43.Savings;
    local v46 = v43.Color or "#00D886";
    local v47 = script.getRobloxPlus:Clone();
    local wrapper = v47:WaitForChild("wrapper");
    wrapper.title.Text = string.format("Save <b>%s</b> Robux?", CatalogUtilities.FormatNumber(v45));
    wrapper.before.RichText = true;
    wrapper.before.Text = string.format("%s%s <font color=\"%s\">(+%s)</font>", Theme.RobuxIcon, CatalogUtilities.FormatNumber(v44), ThemeController.GetHex("#FF5F5C"), CatalogUtilities.FormatNumber(v45));
    wrapper.after.RichText = true;
    wrapper.after.Text = string.format("<font color=\"%s\">%s%s</font>", v46, Theme.RobuxIcon, CatalogUtilities.FormatNumber(v44 - v45));
    local u48 = {
        _closedViaX = false
    };
    wrapper.closeButton.Activated:Connect(function() -- Line: 414
        -- upvalues: u48 (copy)
        u48._closedViaX = true;

        if u48.Close then
            u48.Close(false);
        end;
    end);

    return {
        Yes = genericPrompt(v47, v43, nil, u48) == true,
        DismissedViaClose = u48._closedViaX == true
    };
end;

Events.PromptWearLatestOutfit.OnInvoke = u2.PromptWearLatestOutfit;
Events.PromptGetRobloxPlus.OnInvoke = u2.PromptGetRobloxPlus;

function u2.PromptChoice(p49) -- Line: 437
    -- upvalues: u2 (copy), TweenService (copy), u1 (copy), Events (copy), ThemeController (copy), ConfirmationDialog (copy)
    if u2.IsDialogOpen then
        warn("a dialog is currently open!");

        return nil;
    end;

    local v50 = p49 or {};
    local v51 = v50.options or {};
    local v52 = v50.allowCustom ~= false;
    local v53 = Color3.fromRGB(61, 63, 69);
    local v54 = Color3.fromRGB(29, 29, 31);
    local u55 = script.choiceDialog:Clone();
    local wrapper = u55:WaitForChild("wrapper");
    local title = wrapper:WaitForChild("title");
    local subtitle = wrapper:WaitForChild("subtitle");
    local choices = wrapper:WaitForChild("choices");
    local input = wrapper:WaitForChild("input");
    local closeButton = u55:WaitForChild("closeButton");
    title.Text = v50.title or "Choose an option";
    local v56;

    if type(v50.subtitle) == "string" then
        v56 = v50.subtitle ~= "";
    else
        v56 = false;
    end;

    subtitle.Visible = v56;

    if v56 then
        subtitle.Text = v50.subtitle;
    end;

    input.Visible = v52;
    input.Text = "";

    if v52 then
        input.PlaceholderText = v50.placeholder or "Type your own…";
    end;

    for _, child in choices:GetChildren() do
        if child:IsA("Frame") and child.Name == "choiceRow" then
            child:Destroy();
        end;
    end;

    u2.IsDialogOpen = true;
    local BindableEvent = Instance.new("BindableEvent");
    local u57 = false;

    local function u60(p58) -- Line: 482
        -- upvalues: u57 (ref), TweenService (ref), u55 (copy), u1 (ref), Events (ref), u2 (ref), BindableEvent (copy)
        if u57 then
            return;
        end;

        u57 = true;
        local v59 = TweenService:Create(u55, u1, {
            GroupTransparency = 1
        });
        v59:Play();
        v59.Completed:Connect(function() -- Line: 487
            -- upvalues: u55 (ref)
            u55:Destroy();
        end);
        Events.InterfaceAction:Fire("Remove", script.Name);
        u2.IsDialogOpen = false;
        BindableEvent:Fire(p58);
    end;

    for i, v in ipairs(v51) do
        local u61 = script.rowTemplate:Clone();
        u61.Name = "choiceRow";
        u61.LayoutOrder = i;
        local content = u61:WaitForChild("content");
        content.label.Text = v.label or tostring(v.value or "");
        local v62;

        if v.description == nil then
            v62 = false;
        else
            v62 = v.description ~= "";
        end;

        content.description.Visible = v62;
        content.description.Text = v62 and (v.description or "") or "";
        local value = v.value;

        if value == nil then
            value = v.label;
        end;

        u61.clickTarget.Activated:Connect(function() -- Line: 506
            -- upvalues: u60 (copy), value (ref)
            u60({
                custom = false,
                value = value
            });
        end);
        local u63 = ThemeController.GetColor(v54);
        local u64 = ThemeController.GetColor(v53);
        u61.clickTarget.MouseEnter:Connect(function() -- Line: 513
            -- upvalues: TweenService (ref), u61 (copy), u1 (ref), u64 (copy)
            TweenService:Create(u61, u1, {
                BackgroundColor3 = u64
            }):Play();
        end);
        u61.clickTarget.MouseLeave:Connect(function() -- Line: 516
            -- upvalues: TweenService (ref), u61 (copy), u1 (ref), u63 (copy)
            TweenService:Create(u61, u1, {
                BackgroundColor3 = u63
            }):Play();
        end);
        u61.Parent = choices;
    end;

    local v65 = #v51;
    local v66 = 0.04 + (2 + (v56 and 1 or 0) + (v52 and 1 or 0) - 1) * 0.02 + 0.046 + (v56 and 0.05 or 0) + (v52 and 0.066 or 0);
    local v67 = v66 + 0.5209999999999999;
    local v68 = v65 * 0.076 + math.max(0, v65 - 1) * 0.013;
    local v69 = v66 + v68;
    local v70 = v67 < v69;

    if v70 then
        v69 = v67 or v69;
    end;

    if v70 then
        v68 = v69 - v66 or v68;
    end;

    local v71 = v69 - 0.04;
    u55.Size = UDim2.new(0.4, 0, v69, 0);
    wrapper.UIPadding.PaddingTop = UDim.new(0.02 / v69, 0);
    wrapper.UIPadding.PaddingBottom = UDim.new(0.02 / v69, 0);
    wrapper.UIListLayout.Padding = UDim.new(0.02 / v71, 0);
    title.Size = UDim2.new(1, 0, 0.046 / v71, 0);

    if v56 then
        subtitle.Size = UDim2.new(1, 0, 0.05 / v71, 0);
    end;

    choices.Size = UDim2.new(1, 0, v68 / v71, 0);

    if v52 then
        input.Size = UDim2.new(1, 0, 0.066 / v71, 0);
    end;

    if v68 > 0 then
        choices.UIListLayout.Padding = UDim.new(0.013 / v68, 0);

        for _, child in choices:GetChildren() do
            if child:IsA("Frame") and child.Name == "choiceRow" then
                child.Size = UDim2.new(1, 0, 0.076 / v68, 0);
            end;
        end;
    end;

    closeButton.Position = UDim2.new(closeButton.Position.X.Scale, 0, 0.01 / v69, 0);

    if v52 then
        input.FocusLost:Connect(function(p72) -- Line: 561
            -- upvalues: input (copy), u60 (copy)
            if not p72 then
                return;
            end;

            local v73 = string.match(input.Text, "^%s*(.-)%s*$");

            if v73 ~= "" then
                u60({
                    custom = true,
                    value = v73
                });
            end;
        end);
    end;

    closeButton.Activated:Connect(function() -- Line: 571
        -- upvalues: u60 (copy)
        u60(nil);
    end);
    Events.InterfaceAction:Fire("Add", script.Name, function() -- Line: 572
        -- upvalues: u60 (copy)
        u60(nil);
    end, true);
    u55.GroupTransparency = 1;
    u55.Parent = ConfirmationDialog;
    TweenService:Create(u55, u1, {
        GroupTransparency = 0
    }):Play();
    local v74 = BindableEvent.Event:Wait();
    BindableEvent:Destroy();

    return v74;
end;

Events.PromptChoice.OnInvoke = u2.PromptChoice;

return u2;