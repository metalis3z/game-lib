-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local InterfaceController = require(script.Parent.InterfaceController);
local u2 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local callout = script:WaitForChild("callout");
local Buttons = PlayerGui:WaitForChild("Buttons");
local left = Buttons:WaitForChild("left");
local right = Buttons:WaitForChild("right");
local v3 = {
    catalog = left:WaitForChild("catalog"),
    outfits = left:WaitForChild("outfits"),
    emotes = right:WaitForChild("emotes")
};
local Onboarding = PlayerGui:WaitForChild("Onboarding");
local container = Onboarding:FindFirstChild("container");

if container and not container:IsA("Frame") then
    container:Destroy();
    container = nil;
end;

if not container then
    container = Instance.new("Frame");
    container.Name = "container";
    container.BackgroundTransparency = 1;
    container.BorderSizePixel = 0;
    container.Size = UDim2.fromScale(1, 1);
    container.Position = UDim2.fromScale(0, 0);
    container.ClipsDescendants = false;
    container.Parent = Onboarding;
end;

for _, child in Onboarding:GetChildren() do
    if child ~= container and (child:IsA("Frame") or child:IsA("CanvasGroup")) then
        child:Destroy();
    end;
end;

local function getScale() -- Line: 74
    -- upvalues: Onboarding (copy)
    local X = Onboarding.AbsoluteSize.X;

    if X <= 0 then
        local CurrentCamera = workspace.CurrentCamera;
        X = CurrentCamera and CurrentCamera.ViewportSize.X or 1831;
    end;

    return math.clamp(X / 1831, 0.4, 1.4);
end;

local u4 = nil;

local function fetchSeen() -- Line: 86
    -- upvalues: u4 (ref), Remotes (copy)
    if u4 then
        return u4;
    end;

    while true do
        local success, result = pcall(function() -- Line: 94
            -- upvalues: Remotes (ref)
            return Remotes.OnboardingAction:InvokeServer("Get");
        end);
        local v5 = success and result and result or nil;

        if v5 == nil then
            task.wait(0.5);
        end;

        if typeof(v5) == "table" then
            u4 = v5;

            return u4;
        end;
    end;
end;

function u1.IsSeen(p6) -- Line: 102
    -- upvalues: fetchSeen (copy)
    return fetchSeen()[p6] == true;
end;

function u1.MarkSeen(u7) -- Line: 106
    -- upvalues: fetchSeen (copy), Remotes (copy)
    if typeof(u7) ~= "string" then
        return;
    end;

    fetchSeen()[u7] = true;
    pcall(function() -- Line: 109
        -- upvalues: Remotes (ref), u7 (copy)
        Remotes.OnboardingAction:InvokeServer("MarkSeen", u7);
    end);
end;

local function configureCallout(p8, p9, p10, p11, p12) -- Line: 113
    local content = p8.content;
    local label = content.label;
    local closeButton = content.closeButton;
    local caret = p8.caret;
    local v13 = content:FindFirstChildOfClass("UIPadding");
    local v14 = math.round(24 * p12);
    local v15 = v14 + math.round(14 * p12);
    local v16 = math.round(24 * p12);
    local v17 = math.round(18 * p12);
    p8.AutomaticSize = Enum.AutomaticSize.Y;
    p8.Size = UDim2.fromOffset(math.round((p11 or 390) * p12), 0);
    p8.ClipsDescendants = false;
    local v18 = math.round(22 * p12);
    local v19 = math.round(11 * p12);
    caret.Size = UDim2.fromOffset(v18, v19);
    caret.AnchorPoint = Vector2.new(0.5, 0.5);
    closeButton.Size = UDim2.fromOffset(v14, v14);
    local v20;

    if p10 == "left" then
        v20 = Vector2.new(1, 0.5);
    else
        v20 = Vector2.new(0, 0.5);
    end;

    closeButton.AnchorPoint = v20;
    local v21;

    if p10 == "left" then
        v21 = UDim2.new(1, 0, 0.5, 0);
    else
        v21 = UDim2.new(0, 0, 0.5, 0);
    end;

    closeButton.Position = v21;
    content.AutomaticSize = Enum.AutomaticSize.Y;
    content.Size = UDim2.new(1, 0, 0, 0);
    label.AutomaticSize = Enum.AutomaticSize.Y;
    label.Size = UDim2.new(1, -v15, 0, 0);
    label.TextWrapped = true;
    label.TextYAlignment = Enum.TextYAlignment.Center;
    label.TextSize = math.round(38 * p12);
    label.Text = p9;
    v13.PaddingTop = UDim.new(0, (math.round(16 * p12)));
    v13.PaddingBottom = UDim.new(0, (math.round(18 * p12)));

    if p10 == "left" then
        p8.AnchorPoint = Vector2.new(0, 0.5);
        caret.Rotation = -90;
        caret.Position = UDim2.new(0, -math.round(v19 / 2) + 1, 0.5, 0);
        label.AnchorPoint = Vector2.new(0, 0);
        label.Position = UDim2.fromScale(0, 0);
        label.TextXAlignment = Enum.TextXAlignment.Left;
        v13.PaddingLeft = UDim.new(0, v16);
        v13.PaddingRight = UDim.new(0, v17);

        return;
    end;

    p8.AnchorPoint = Vector2.new(1, 0.5);
    caret.Rotation = 90;
    caret.Position = UDim2.new(1, math.round(v19 / 2) - 1, 0.5, 0);
    label.AnchorPoint = Vector2.new(1, 0);
    label.Position = UDim2.fromScale(1, 0);
    label.TextXAlignment = Enum.TextXAlignment.Center;
    v13.PaddingLeft = UDim.new(0, v17);
    v13.PaddingRight = UDim.new(0, v16);
end;

local function positionCallout(p22, p23, p24) -- Line: 178
    -- upvalues: container (ref), Onboarding (copy)
    if not (p23 and p23.Parent) then
        return;
    end;

    local AbsolutePosition = p23.AbsolutePosition;
    local AbsoluteSize = p23.AbsoluteSize;
    local AbsolutePosition2 = container.AbsolutePosition;
    local X = Onboarding.AbsoluteSize.X;

    if X <= 0 then
        local CurrentCamera = workspace.CurrentCamera;
        X = CurrentCamera and CurrentCamera.ViewportSize.X or 1831;
    end;

    local v25 = 30 * math.clamp(X / 1831, 0.4, 1.4);
    local v26 = math.round(v25);
    local v27 = AbsolutePosition.Y + AbsoluteSize.Y / 2 - AbsolutePosition2.Y;

    if p24 == "left" then
        p22.Position = UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X + v26 - AbsolutePosition2.X, v27);

        return;
    end;

    p22.Position = UDim2.fromOffset(AbsolutePosition.X - v26 - AbsolutePosition2.X, v27);
end;

local function setCalloutAlpha(p28, p29) -- Line: 192
    p28.BackgroundTransparency = p29;
    p28.caret.ImageTransparency = p29;
    p28.content.label.TextTransparency = p29;
    local v30 = p28.content.closeButton:FindFirstChildWhichIsA("ImageLabel");

    if v30 then
        v30.ImageTransparency = p29;
    end;
end;

local function fadeCallout(p31, p32) -- Line: 200
    -- upvalues: TweenService (copy), u2 (copy)
    local v33 = p32 and 0 or 1;
    local v34 = p31.content.closeButton:FindFirstChildWhichIsA("ImageLabel");
    TweenService:Create(p31, u2, {
        BackgroundTransparency = v33
    }):Play();
    TweenService:Create(p31.caret, u2, {
        ImageTransparency = v33
    }):Play();
    TweenService:Create(p31.content.label, u2, {
        TextTransparency = v33
    }):Play();

    if v34 then
        TweenService:Create(v34, u2, {
            ImageTransparency = v33
        }):Play();
    end;
end;

local u35 = false;

local function resolveTarget(p36) -- Line: 214
    local target = p36.target;

    if typeof(target) == "function" then
        target = target();
    end;

    return target;
end;

local function resolveSide(p37, p38) -- Line: 220
    -- upvalues: Onboarding (copy)
    return p37.side ~= "left" and p37.side ~= "right" and (p38.AbsolutePosition.X + p38.AbsoluteSize.X / 2 < Onboarding.AbsoluteSize.X / 2 and "left" or "right") or p37.side;
end;

local function showTip(u39) -- Line: 227
    -- upvalues: u35 (ref), Onboarding (copy), callout (copy), configureCallout (copy), container (ref), positionCallout (copy), InterfaceController (copy), RunService (copy), fadeCallout (copy), u2 (copy)
    while u35 do
        task.wait(0.1);
    end;

    local target = u39.target;

    if typeof(target) == "function" then
        target = target();
    end;

    if not (target and target.Parent) then
        return false;
    end;

    u35 = true;
    local u40;

    if u39.side == "left" or u39.side == "right" then
        u40 = u39.side;
    else
        u40 = target.AbsolutePosition.X + target.AbsoluteSize.X / 2 < Onboarding.AbsoluteSize.X / 2 and "left" or "right";
    end;

    local u41 = callout:Clone();
    local X = Onboarding.AbsoluteSize.X;

    if X <= 0 then
        local CurrentCamera = workspace.CurrentCamera;
        X = CurrentCamera and CurrentCamera.ViewportSize.X or 1831;
    end;

    configureCallout(u41, u39.text, u40, u39.baseWidth, (math.clamp(X / 1831, 0.4, 1.4)));
    u41.BackgroundTransparency = 1;
    u41.caret.ImageTransparency = 1;
    u41.content.label.TextTransparency = 1;
    local v42 = u41.content.closeButton:FindFirstChildWhichIsA("ImageLabel");

    if v42 then
        v42.ImageTransparency = 1;
    end;

    u41.Parent = container;
    positionCallout(u41, target, u40);
    local v43 = {};
    local BindableEvent = Instance.new("BindableEvent");
    local u44 = false;

    local function dismiss() -- Line: 243
        -- upvalues: u44 (ref), BindableEvent (copy)
        if u44 then
            return;
        end;

        u44 = true;
        BindableEvent:Fire();
    end;

    table.insert(v43, u41.content.closeButton.Activated:Connect(dismiss));

    if u39.interface then
        table.insert(v43, InterfaceController.Changed.Event:Connect(function() -- Line: 251
            -- upvalues: InterfaceController (ref), u39 (copy), u44 (ref), BindableEvent (copy)
            if InterfaceController.CurrentlyOpenInterfaces[u39.interface] then
                if u44 then
                    return;
                end;

                u44 = true;
                BindableEvent:Fire();
            end;
        end));
    end;

    if typeof(u39.dismissWhen) == "function" then
        local v45 = u39.dismissWhen(dismiss);

        if typeof(v45) == "table" then
            for _, v in v45 do
                table.insert(v43, v);
            end;
        end;
    end;

    local u46 = nil;
    table.insert(v43, RunService.Heartbeat:Connect(function() -- Line: 263
        -- upvalues: u39 (copy), positionCallout (ref), u41 (copy), u40 (copy), u46 (ref), fadeCallout (ref)
        local target2 = u39.target;

        if typeof(target2) == "function" then
            target2 = target2();
        end;

        positionCallout(u41, target2, u40);
        local v47;

        if target2 == nil or target2.Parent == nil then
            v47 = false;
        else
            v47 = target2.Visible == true;
        end;

        if v47 ~= u46 then
            u46 = v47;
            fadeCallout(u41, v47);
        end;
    end));

    if u39.interface and (InterfaceController.CurrentlyOpenInterfaces[u39.interface] and not u44) then
        u44 = true;
        BindableEvent:Fire();
    end;

    BindableEvent.Event:Wait();
    BindableEvent:Destroy();

    for _, v in v43 do
        v:Disconnect();
    end;

    fadeCallout(u41, false);
    task.wait(u2.Time);
    u41:Destroy();
    u35 = false;

    return true;
end;

function u1.RunFlow(u48) -- Line: 292
    -- upvalues: u1 (copy), showTip (copy)
    task.spawn(function() -- Line: 293
        -- upvalues: u48 (copy), u1 (ref), showTip (ref)
        if typeof(u48.shouldStart) == "function" and not u48.shouldStart() then
            return;
        end;

        for _, v in u48.steps do
            if not u1.IsSeen(v.key) and showTip(v) then
                u1.MarkSeen(v.key);
            end;
        end;
    end);
end;

local u49 = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u50 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

function u1.ShowScrollHint(u51, p52) -- Line: 315
    -- upvalues: u1 (copy), TweenService (copy), u2 (copy), u49 (copy), u50 (copy)
    local u53 = p52 or {};

    if u53.key and u1.IsSeen(u53.key) then
        return function() -- Line: 317
        end;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "scrollHint";
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2.new(1, 0.5);
    Frame.Position = UDim2.fromScale(0.99, 0.5);
    Frame.Size = UDim2.fromScale(0.26, 0.7);
    Frame.ZIndex = 50;
    Frame.Parent = u51.Parent;
    local u54 = {};

    for i = 1, 3 do
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "arrow" .. i;
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://100580366675094";
        ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
        ImageLabel.ImageTransparency = 1;
        ImageLabel.ScaleType = Enum.ScaleType.Fit;
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.Size = UDim2.fromScale(0.55, 1);
        ImageLabel.Position = UDim2.fromScale(0.85 - (3 - i) * 0.16, 0.5);
        ImageLabel.ZIndex = 50;
        ImageLabel:SetAttribute("SkipThemeImage", true);
        ImageLabel.Parent = Frame;
        u54[i] = ImageLabel;
    end;

    local u55 = false;
    local u56 = {};

    local function cleanup(p57) -- Line: 349
        -- upvalues: u55 (ref), u56 (copy), u53 (ref), u1 (ref), u54 (copy), TweenService (ref), u2 (ref), Frame (copy)
        if u55 then
            return;
        end;

        u55 = true;

        for _, v in u56 do
            v:Disconnect();
        end;

        if p57 and u53.key then
            u1.MarkSeen(u53.key);
        end;

        for _, v in u54 do
            TweenService:Create(v, u2, {
                ImageTransparency = 1
            }):Play();
        end;

        task.delay(u2.Time, function() -- Line: 355
            -- upvalues: Frame (ref)
            if Frame then
                Frame:Destroy();
            end;
        end);

        if u53.onCleanup then
            u53.onCleanup();
        end;
    end;

    task.spawn(function() -- Line: 360
        -- upvalues: u55 (ref), Frame (copy), u54 (copy), TweenService (ref), u49 (ref), u50 (ref)
        while not u55 and Frame.Parent ~= nil do
            for i, v in ipairs(u54) do
                task.delay((i - 1) * 0.07, function() -- Line: 363
                    -- upvalues: u55 (ref), Frame (ref), TweenService (ref), v (copy), u49 (ref), u50 (ref)
                    if u55 or Frame.Parent == nil then
                        return;
                    end;

                    TweenService:Create(v, u49, {
                        ImageTransparency = 0
                    }):Play();
                    task.delay(u49.Time, function() -- Line: 366
                        -- upvalues: u55 (ref), Frame (ref), TweenService (ref), v (ref), u50 (ref)
                        if u55 or Frame.Parent == nil then
                            return;
                        end;

                        TweenService:Create(v, u50, {
                            ImageTransparency = 1
                        }):Play();
                    end);
                end);
            end;

            task.wait(2);
        end;
    end);
    local v58 = (function() -- Line: 377, Name: oneItemWidth
        -- upvalues: u51 (copy)
        for _, child in u51:GetChildren() do
            if child:IsA("GuiObject") then
                return child.AbsoluteSize.X;
            end;
        end;

        return u51.AbsoluteSize.X * 0.4;
    end)();
    local u59 = math.max(20, v58);
    local v60 = u51:GetPropertyChangedSignal("CanvasPosition");
    table.insert(u56, v60:Connect(function() -- Line: 384
        -- upvalues: u51 (copy), u59 (copy), cleanup (copy)
        if u59 <= u51.CanvasPosition.X then
            cleanup(true);
        end;
    end));

    return function() -- Line: 390
        -- upvalues: cleanup (copy)
        cleanup(false);
    end;
end;

local u61 = {
    id = "hud",
    steps = {
        {
            key = "hud.catalog",
            side = "left",
            text = "Create your dream avatar here",
            interface = "CatalogController",
            target = v3.catalog
        },
        {
            key = "hud.outfits",
            side = "left",
            text = "Save, share and load outfits by the community",
            interface = "OutfitsController",
            target = v3.outfits
        },
        {
            key = "hud.emotes",
            side = "right",
            text = "Dance, pose, and express yourself",
            interface = "EmotesController",
            baseWidth = 330,
            target = v3.emotes
        }
    }
};
task.delay(1, function() -- Line: 405
    -- upvalues: u1 (copy), u61 (copy)
    u1.RunFlow(u61);
end);
local u62 = nil;
task.spawn(function() -- Line: 413
    -- upvalues: PlayerGui (copy), InterfaceController (copy), u62 (ref), u1 (copy)
    local itemsWrapper = PlayerGui:WaitForChild("Outfits"):WaitForChild("container"):WaitForChild("wrapper"):WaitForChild("buttons"):WaitForChild("communityOutfits"):WaitForChild("scrollWrapper"):WaitForChild("itemsWrapper");

    local function isOpen() -- Line: 419
        -- upvalues: InterfaceController (ref)
        return InterfaceController.CurrentlyOpenInterfaces.OutfitsController ~= nil;
    end;

    local function tryShow() -- Line: 423
        -- upvalues: u62 (ref), u1 (ref), InterfaceController (ref), itemsWrapper (copy)
        if u62 then
            return;
        end;

        if u1.IsSeen("outfits.communityScroll") then
            return;
        end;

        task.wait(0.3);

        if InterfaceController.CurrentlyOpenInterfaces.OutfitsController == nil then
            return;
        end;

        u62 = u1.ShowScrollHint(itemsWrapper, {
            key = "outfits.communityScroll",

            onCleanup = function() -- Line: 430, Name: onCleanup
                -- upvalues: u62 (ref)
                u62 = nil;
            end
        });
    end;

    InterfaceController.Changed.Event:Connect(function() -- Line: 434
        -- upvalues: InterfaceController (ref), tryShow (copy), u62 (ref)
        if InterfaceController.CurrentlyOpenInterfaces.OutfitsController ~= nil then
            task.spawn(tryShow);

            return;
        end;

        if u62 then
            u62();
        end;
    end);

    if InterfaceController.CurrentlyOpenInterfaces.OutfitsController ~= nil then
        task.spawn(tryShow);
    end;
end);

return u1;