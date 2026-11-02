-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local LoadingController = require(Modules.Controllers.LoadingController);
local Events = script.Parent.Parent.Events;
local CreateAvatarApply = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CreateAvatarApply");
local CreateAvatar = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CreateAvatar");
local container = CreateAvatar:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local closeButton = wrapper:WaitForChild("closeButton");
local bottomBar = wrapper:WaitForChild("bottomBar");
local stageIndicator = bottomBar:WaitForChild("stageIndicator");
local stageName = wrapper:WaitForChild("stageBadge"):WaitForChild("stageName");
local backButtonContainer = bottomBar:WaitForChild("left"):WaitForChild("backButtonContainer");
local continueButtonContainer = bottomBar:WaitForChild("right"):WaitForChild("continueButtonContainer");
local button = backButtonContainer:WaitForChild("button");
local button2 = continueButtonContainer:WaitForChild("button");
local label = continueButtonContainer:WaitForChild("label");
local back = continueButtonContainer:WaitForChild("back");
local viewport = wrapper:WaitForChild("previewColumn"):WaitForChild("viewport");
local stageContent = wrapper:WaitForChild("contentColumn"):WaitForChild("stageContent");
local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, v1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, v1, {
    GroupTransparency = 1
});
local ToggleBlue = ThemeController.BasePalette.ToggleBlue;
local PanelBackground = ThemeController.BasePalette.PanelBackground;
local TextPrimary = ThemeController.BasePalette.TextPrimary;
local TextMuted = ThemeController.BasePalette.TextMuted;
local SubtleStroke = ThemeController.BasePalette.SubtleStroke;
local ActionGreenAlt = ThemeController.BasePalette.ActionGreenAlt;
local SurfaceBackground = ThemeController.BasePalette.SurfaceBackground;
local u4 = Color3.fromRGB(228, 228, 230);
local u5 = {
    IsOpen = false,
    CurrentStage = 1,
    draftDescription = nil,
    mainPreviewObject = nil,
    hasChanges = false,
    stageCache = {},
    changes = {}
};
local u6 = { "Body", "Skin Tone", "Head", "Hair", "Body Scale" };
local u7 = #u6;
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = {};
local u13 = {};

local function clearConnections() -- Line: 75
    -- upvalues: u12 (copy)
    for _, v in u12 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u12);
end;

local function cancelThreads() -- Line: 80
    -- upvalues: u13 (copy)
    for _, v in u13 do
        pcall(task.cancel, v);
    end;

    table.clear(u13);
end;

local function getStageModule(p14) -- Line: 85
    -- upvalues: u6 (copy), u8 (ref)
    local v15 = u6[p14];

    if not v15 then
        return nil;
    end;

    if u8[p14] then
        return u8[p14];
    end;

    local v16 = string.gsub(v15, "%s", "") .. "Stage";
    local v17 = script:FindFirstChild(v16);

    if not v17 then
        return nil;
    end;

    local success, result = pcall(require, v17);

    if success then
        u8[p14] = result;

        return result;
    end;

    warn("[CreateAvatarController] failed to require", v16, result);

    return nil;
end;

local function updateStageIndicator() -- Line: 101
    -- upvalues: u7 (copy), stageIndicator (copy), u5 (copy), ToggleBlue (copy), PanelBackground (copy), SubtleStroke (copy), TextPrimary (copy), TextMuted (copy)
    for i = 1, u7 do
        local v18 = stageIndicator:FindFirstChild("segment" .. i);

        if v18 then
            local v19 = i == u5.CurrentStage;
            local v20 = i < u5.CurrentStage;
            v18.BackgroundColor3 = v20 and ToggleBlue or PanelBackground;
            local v21 = v18:FindFirstChildWhichIsA("UIStroke");

            if v21 then
                if v20 then
                    v21.Enabled = false;
                else
                    v21.Enabled = true;
                    v21.Color = v19 and ToggleBlue or SubtleStroke;
                    v21.Thickness = v19 and 2 or 1.5;
                end;
            end;

            if v18:FindFirstChild("label") then
                v18.label.TextColor3 = (v19 or v20) and TextPrimary or TextMuted;
            end;
        end;
    end;
end;

local function updateChrome() -- Line: 128
    -- upvalues: stageName (copy), u6 (copy), u5 (copy), backButtonContainer (copy), label (copy), u7 (copy), back (copy), ActionGreenAlt (copy), updateStageIndicator (copy)
    stageName.Text = u6[u5.CurrentStage] or "";
    stageName.TextScaled = true;
    backButtonContainer.Visible = u5.CurrentStage > 1;
    label.Text = u5.CurrentStage == u7 and "Apply" or "Continue";
    label.TextScaled = true;
    back.BackgroundColor3 = ActionGreenAlt;
    updateStageIndicator();
end;

function u5.SetContinueLabel(p22, p23) -- Line: 141
    -- upvalues: label (copy), back (copy), SurfaceBackground (copy), ActionGreenAlt (copy)
    label.Text = p22;
    label.TextScaled = true;
    back.BackgroundColor3 = p23 and SurfaceBackground or ActionGreenAlt;
end;

local function clearStageContent() -- Line: 147
    -- upvalues: stageContent (copy)
    for _, child in stageContent:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;
end;

local u24 = false;
local u25 = false;
local u26 = false;

local function onChange(p27) -- Line: 163
    -- upvalues: u5 (copy), u26 (ref), u24 (ref), u25 (ref)
    if not (p27 and p27.Silent) then
        u5.hasChanges = true;
    end;

    if not (u5.mainPreviewObject and u5.draftDescription) then
        return;
    end;

    if p27 and p27.Reset then
        u26 = true;
    end;

    if u24 then
        u25 = true;

        return;
    end;

    u24 = true;

    while true do
        u25 = false;
        local v28 = not u26;
        u26 = false;
        local mainPreviewObject = u5.mainPreviewObject;

        if not (mainPreviewObject and u5.draftDescription) then
            break;
        end;

        pcall(mainPreviewObject.Update, mainPreviewObject, u5.draftDescription, {
            BypassIsApplied = true,
            Quick = v28
        });

        if not u25 then
            break;
        end;
    end;

    u24 = false;
end;

local function enterStage(p29) -- Line: 189
    -- upvalues: u9 (ref), u10 (ref), u11 (ref), clearStageContent (copy), LoadingController (copy), u5 (copy), stageName (copy), u6 (copy), backButtonContainer (copy), label (copy), u7 (copy), back (copy), ActionGreenAlt (copy), updateStageIndicator (copy), getStageModule (copy), TextMuted (copy), stageContent (copy), onChange (copy)
    if u9 then
        pcall(u9);
        u9 = nil;
    end;

    u10 = nil;
    u11 = nil;
    clearStageContent();
    LoadingController.ClearGraphics("createAvatar");
    u5.CurrentStage = p29;
    stageName.Text = u6[u5.CurrentStage] or "";
    stageName.TextScaled = true;
    backButtonContainer.Visible = u5.CurrentStage > 1;
    label.Text = u5.CurrentStage == u7 and "Apply" or "Continue";
    label.TextScaled = true;
    back.BackgroundColor3 = ActionGreenAlt;
    updateStageIndicator();
    local v30 = u6[p29];
    u5.stageCache[v30] = u5.stageCache[v30] or {};
    local v31 = u5.stageCache[v30];
    local v32 = getStageModule(p29);

    if v32 then
        local success, result = pcall(v32.Open, stageContent, u5.draftDescription, u5.changes, u5.mainPreviewObject, v31, onChange);

        if not success then
            warn("[CreateAvatarController] stage open failed:", v30, result);

            return;
        end;

        if typeof(result) ~= "table" then
            u9 = result;

            return;
        end;

        u9 = result.cleanup;
        u10 = result.onContinue;
        u11 = result.onBack;

        return;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(0.7, 0.1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = v30 .. " (coming soon)";
    TextLabel.FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium);
    TextLabel.TextColor3 = TextMuted;
    TextLabel.TextScaled = true;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Parent = stageContent;
end;

local function applyDraft() -- Line: 240
    -- upvalues: LoadingController (copy), stageContent (copy), CreateAvatarApply (copy), u5 (copy), Events (copy)
    LoadingController.DisplayLoading(stageContent, "overlay");
    local success, result = pcall(function() -- Line: 244
        -- upvalues: CreateAvatarApply (ref), u5 (ref)
        return CreateAvatarApply:InvokeServer(u5.changes);
    end);
    LoadingController.RemoveLoading();

    if success and result == true then
        Events.Notify:Fire("✅ New avatar applied.");
        u5.Close();

        return;
    end;

    warn("[CreateAvatarController] apply failed:", success, result);
    Events.Notify:Fire("❌ Couldn\'t apply your new avatar. Try again.");
end;

function u5.Close(p33) -- Line: 257
    -- upvalues: u5 (copy), Events (copy), u9 (ref), clearStageContent (copy), LoadingController (copy), u8 (ref), cancelThreads (copy), u12 (copy), u3 (copy), CreateAvatar (copy)
    if not u5.IsOpen then
        return;
    end;

    u5.IsOpen = false;
    Events.InterfaceAction:Fire("Remove", script.Name);

    if p33 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    if u9 then
        pcall(u9);
        u9 = nil;
    end;

    clearStageContent();
    LoadingController.ClearGraphics("createAvatar");
    table.clear(u5.stageCache);
    u8 = {};
    u5.hasChanges = false;

    if u5.mainPreviewObject then
        pcall(u5.mainPreviewObject.Destroy, u5.mainPreviewObject);
        u5.mainPreviewObject = nil;
    end;

    cancelThreads();

    for _, v in u12 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u12);
    u3:Play();
    u3.Completed:Once(function() -- Line: 282
        -- upvalues: u5 (ref), CreateAvatar (ref)
        if u5.IsOpen ~= true then
            CreateAvatar.Enabled = false;
        end;
    end);
end;

function u5.Open(p34) -- Line: 289
    -- upvalues: u5 (copy), Events (copy), HumanoidDescriptionController (copy), u4 (copy), AvatarPreviewController (copy), viewport (copy), CreateAvatar (copy), container (copy), u2 (copy), u12 (copy), closeButton (copy), button (copy), u11 (ref), enterStage (copy), button2 (copy), u10 (ref), u7 (copy), applyDraft (copy)
    if u5.IsOpen then
        if p34 then
            u5.Close();
        end;

        return;
    end;

    u5.IsOpen = true;
    u5.CurrentStage = 1;
    u5.hasChanges = false;
    Events.InterfaceAction:Fire("Add", script.Name, u5.Close);
    Events.SetButtonsVisible:Fire({});
    local u35 = HumanoidDescriptionController.GetCurrentDescription();
    local HumanoidDescription = Instance.new("HumanoidDescription");

    if u35 then
        for _, v in { "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg" } do
            pcall(function() -- Line: 309
                -- upvalues: HumanoidDescription (copy), v (copy), u35 (copy)
                HumanoidDescription[v] = u35[v];
            end);
        end;

        for _, v in { "HeightScale", "WidthScale", "DepthScale", "ProportionScale", "BodyTypeScale", "HeadScale" } do
            pcall(function() -- Line: 315
                -- upvalues: HumanoidDescription (copy), v (copy), u35 (copy)
                HumanoidDescription[v] = u35[v];
            end);
        end;
    end;

    for _, v in { "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor" } do
        pcall(function() -- Line: 319
            -- upvalues: HumanoidDescription (copy), v (copy), u4 (ref)
            HumanoidDescription[v] = u4;
        end);
    end;

    pcall(function() -- Line: 322
        -- upvalues: HumanoidDescription (copy)
        HumanoidDescription.Shirt = 855760101;
        HumanoidDescription.Pants = 855780360;
    end);
    u5.draftDescription = HumanoidDescription;
    u5.changes = {};
    local v36 = HumanoidDescriptionController.GetHumanoid();
    u5.mainPreviewObject = AvatarPreviewController.new(viewport, HumanoidDescription, {
        AllowAnimations = false,
        AllowCameraAdjustment = true,
        IsOutfitPreview = true,
        Context = "CreateAvatarMain",
        RigType = v36 and v36.RigType or Enum.HumanoidRigType.R15
    });
    CreateAvatar.Enabled = true;
    container.GroupTransparency = 1;
    u2:Play();
    table.insert(u12, closeButton.Activated:Connect(function() -- Line: 344
        -- upvalues: u5 (ref), Events (ref)
        if u5.hasChanges and Events.PromptConfirmationDialog:Invoke({
            Title = "Discard new avatar?",
            Description = "Your changes haven\'t been applied yet. Close anyway?",
            NoText = "Cancel",
            YesText = "Discard"
        }) ~= true then
            return;
        end;

        u5.Close();
    end));
    table.insert(u12, button.Activated:Connect(function() -- Line: 357
        -- upvalues: u11 (ref), u5 (ref), enterStage (ref)
        if u11 and u11() then
            return;
        end;

        if u5.CurrentStage > 1 then
            enterStage(u5.CurrentStage - 1);
        end;
    end));
    table.insert(u12, button2.Activated:Connect(function() -- Line: 364
        -- upvalues: u10 (ref), u5 (ref), u7 (ref), applyDraft (ref), enterStage (ref)
        if u10 and u10() then
            return;
        end;

        if u5.CurrentStage == u7 then
            applyDraft();

            return;
        end;

        enterStage(u5.CurrentStage + 1);
    end));
    enterStage(1);
end;

Events.DisplayCreateAvatar.Event:Connect(u5.Open);

return u5;