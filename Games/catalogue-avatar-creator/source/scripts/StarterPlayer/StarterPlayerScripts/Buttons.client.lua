-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("StarterGui");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local Button = require(Modules.Elements.Button);
local CatalogController = require(Modules.Controllers.CatalogController);
local SettingsController = require(Modules.Controllers.SettingsController);
require(Modules.Controllers.HistoryController);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Events;
local LocalPlayer = Players.LocalPlayer;
local Buttons = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Buttons");
local left = Buttons.left;
local right = Buttons.right;
local bottom = Buttons.bottom;
local right2 = bottom.right;
local center = bottom.center;
local left2 = bottom.left;
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u2 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local u3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u4 = Color3.fromRGB(255, 236, 128);
local u5 = Color3.fromRGB(153, 231, 255);
local u6 = Color3.fromRGB(67, 255, 73);
local u7 = Color3.new(1, 1, 1);
local u8 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u9 = {
    B = {
        strokeThickness = 0.055,
        Dark = {
            fillTransparency = 0.35,
            hoverFillTransparency = 0.15,
            strokeTransparency = 0.3,
            hoverStrokeTransparency = 0.15,
            fill = Color3.fromRGB(21, 21, 24),
            hoverFill = Color3.fromRGB(39, 39, 44),
            stroke = Color3.fromRGB(0, 0, 0),
            hoverStroke = Color3.fromRGB(20, 20, 23),
            iconColor = Color3.new(1, 1, 1)
        },
        Light = {
            fillTransparency = 0.35,
            hoverFillTransparency = 0.2,
            strokeTransparency = 0.3,
            hoverStrokeTransparency = 0.15,
            fill = Color3.fromRGB(233, 233, 238),
            hoverFill = Color3.fromRGB(210, 210, 216),
            stroke = Color3.fromRGB(0, 0, 0),
            hoverStroke = Color3.fromRGB(95, 95, 102),
            iconColor = Color3.fromRGB(35, 35, 38)
        }
    },
    D = {
        strokeThickness = 0.06,
        Dark = {
            fillTransparency = 0.5,
            hoverFillTransparency = 0.15,
            strokeTransparency = 0.4,
            hoverStrokeTransparency = 0.15,
            fill = Color3.fromRGB(21, 21, 24),
            hoverFill = Color3.fromRGB(39, 39, 44),
            stroke = Color3.fromRGB(0, 0, 0),
            hoverStroke = Color3.fromRGB(20, 20, 23),
            iconColor = Color3.new(1, 1, 1)
        },
        Light = {
            fillTransparency = 0.5,
            hoverFillTransparency = 0.2,
            strokeTransparency = 0.4,
            hoverStrokeTransparency = 0.15,
            fill = Color3.fromRGB(233, 233, 238),
            hoverFill = Color3.fromRGB(210, 210, 216),
            stroke = Color3.fromRGB(0, 0, 0),
            hoverStroke = Color3.fromRGB(95, 95, 102),
            iconColor = Color3.fromRGB(35, 35, 38)
        }
    }
};
local u10 = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
local u11 = "A";
local u12 = nil;
local u13 = nil;
local u14 = u7;
local u15 = 0.5;
local u16 = 0.2;
local u17 = nil;

local function isLightTheme() -- Line: 119
    -- upvalues: ThemeController (copy)
    local v18 = ThemeController.GetColor(Color3.fromRGB(29, 29, 31));

    return (v18.R + v18.G + v18.B) / 3 > 0.5;
end;

local function rebuildCatalogShineGradient() -- Line: 124
    -- upvalues: left (copy), ThemeController (copy)
    local UIGradient = left.catalog:FindFirstChild("UIGradient");

    if not UIGradient then
        return;
    end;

    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ThemeController.GetColor(Color3.fromRGB(29, 29, 31))),
        ColorSequenceKeypoint.new(0.41, ThemeController.GetColor(Color3.fromRGB(53, 53, 57))),
        ColorSequenceKeypoint.new(0.51, ThemeController.GetColor(Color3.fromRGB(55, 55, 59))),
        ColorSequenceKeypoint.new(0.61, ThemeController.GetColor(Color3.fromRGB(54, 54, 58))),
        ColorSequenceKeypoint.new(1, ThemeController.GetColor(Color3.fromRGB(29, 29, 31)))
    });
end;

local function computeCatalogBase(p19) -- Line: 138
    -- upvalues: left (copy)
    local UIGradient = left.catalog:FindFirstChild("UIGradient");

    if not UIGradient then
        return p19;
    end;

    local Keypoints = UIGradient.Color.Keypoints;
    local v20 = 0;
    local v21 = 0;
    local v22 = 0;

    for i = 1, #Keypoints - 1 do
        local v23 = Keypoints[i];
        local v24 = Keypoints[i + 1];
        local v25 = v24.Time - v23.Time;
        v20 = v20 + (v23.Value.R + v24.Value.R) * 0.5 * v25;
        v21 = v21 + (v23.Value.G + v24.Value.G) * 0.5 * v25;
        v22 = v22 + (v23.Value.B + v24.Value.B) * 0.5 * v25;
    end;

    local new = Color3.new;
    local v26 = p19.R / math.max(v20, 0.001);
    local v27 = math.min(v26, 1);
    local v28 = p19.G / math.max(v21, 0.001);
    local v29 = math.min(v28, 1);
    local v30 = p19.B / math.max(v22, 0.001);

    return new(v27, v29, (math.min(v30, 1)));
end;

Events.ThemeChanged.Event:Connect(function() -- Line: 156
    -- upvalues: rebuildCatalogShineGradient (copy), u12 (ref), u17 (ref), u11 (ref), left (copy), computeCatalogBase (copy), ThemeController (copy)
    rebuildCatalogShineGradient();

    if u12 then
        u17();

        return;
    end;

    if u11 == "C" then
        left.catalog.BackgroundColor3 = computeCatalogBase(ThemeController.GetColor(Color3.fromRGB(29, 29, 31)));

        return;
    end;

    left.catalog.BackgroundColor3 = Color3.new(1, 1, 1);
end);

local function strokeThicknessFor(p31, p32) -- Line: 171
    -- upvalues: right2 (copy)
    local Y = right2.settings.AbsoluteSize.Y;
    local Y2 = p31.AbsoluteSize.Y;

    if Y <= 0 or Y2 <= 0 then
        return p32;
    end;

    return p32 * (Y / Y2);
end;

u17 = function() -- Line: 178, Name: applyStyleVariant
    -- upvalues: u13 (ref), ThemeController (copy), u12 (ref), u14 (ref), u15 (ref), u16 (ref), computeCatalogBase (copy), Buttons (copy), left (copy), right2 (copy)
    local v33 = ThemeController.GetColor(Color3.fromRGB(29, 29, 31));
    local v34;

    if (v33.R + v33.G + v33.B) / 3 > 0.5 then
        v34 = u12.Light;
    else
        v34 = u12.Dark;
    end;

    u13 = v34;
    u14 = u13.stroke;
    u15 = u13.strokeTransparency;
    u16 = u13.fillTransparency;
    local v35 = computeCatalogBase(u13.fill);

    for _, descendant in Buttons:GetDescendants() do
        if descendant:IsA("TextButton") then
            local v36;

            if descendant == left.catalog then
                v36 = v35;
            else
                v36 = u13.fill;
            end;

            descendant.BackgroundColor3 = v36;
            descendant.BackgroundTransparency = u13.fillTransparency;
            local v37 = descendant:FindFirstChildWhichIsA("UIStroke");

            if v37 then
                v37.Color = u13.stroke;
                local strokeThickness = u12.strokeThickness;
                local Y = right2.settings.AbsoluteSize.Y;
                local Y2 = descendant.AbsoluteSize.Y;

                if Y > 0 and Y2 > 0 then
                    strokeThickness = strokeThickness * (Y / Y2);
                end;

                v37.Thickness = strokeThickness;
                v37.Transparency = u13.strokeTransparency;
            end;

            local icon = descendant:FindFirstChild("icon");

            if icon then
                icon:SetAttribute("SkipTheme", true);
                icon.ImageColor3 = u13.iconColor;
            end;

            local label = descendant:FindFirstChild("label");

            if label then
                label:SetAttribute("SkipTheme", true);
                label.TextColor3 = u13.iconColor;
            end;
        end;
    end;
end;

local function applyStrokeVariant(p38) -- Line: 209
    -- upvalues: u11 (ref), u12 (ref), u9 (copy), u17 (ref), left (copy), right (copy), u10 (copy), u15 (ref), Buttons (copy), computeCatalogBase (copy), ThemeController (copy)
    u11 = p38;
    local v39 = string.gsub(p38, "_font$", "");
    u12 = u9[v39];

    if u12 then
        u17();
    end;

    if v39 ~= p38 then
        for _, v in { left.catalog, left.outfits, right.emotes, right.admin } do
            local label = v:FindFirstChild("label");

            if label then
                label.FontFace = u10;
            end;
        end;
    end;

    if v39 == "C" then
        u15 = 0.5;

        for _, descendant in Buttons:GetDescendants() do
            if descendant:IsA("TextButton") then
                local v40 = descendant:FindFirstChildWhichIsA("UIStroke");

                if v40 then
                    v40.Thickness = 0.055;
                    v40.Transparency = 0.5;
                end;
            end;
        end;

        left.catalog.BackgroundColor3 = computeCatalogBase(ThemeController.GetColor(Color3.fromRGB(29, 29, 31)));
    end;
end;

task.spawn(function() -- Line: 240
    -- upvalues: LocalPlayer (copy), applyStrokeVariant (copy)
    local v41 = LocalPlayer:GetAttribute("HudStrokeVariant");

    if v41 == nil then
        LocalPlayer:GetAttributeChangedSignal("HudStrokeVariant"):Wait();
        v41 = LocalPlayer:GetAttribute("HudStrokeVariant");
    end;

    applyStrokeVariant(v41);
end);

local function tweenButtonColors(p42, p43) -- Line: 249
    -- upvalues: u12 (ref), u7 (copy), u13 (ref), ThemeController (copy), TweenService (copy), u8 (copy), u14 (ref)
    local v44;

    if u12 then
        if p43 == u7 then
            v44 = u13.iconColor;
        else
            v44 = p43;
        end;
    else
        v44 = ThemeController.GetColor(p43);
    end;

    local icon = p42:FindFirstChild("icon");
    local label = p42:FindFirstChild("label");
    local v45 = p42:FindFirstChildWhichIsA("UIStroke");

    if icon then
        TweenService:Create(icon, u8, {
            ImageColor3 = v44
        }):Play();
    end;

    if label then
        TweenService:Create(label, u8, {
            TextColor3 = v44
        }):Play();
    end;

    if v45 then
        if p43 == u7 then
            p43 = u14;
        end;

        if not u12 then
            p43 = ThemeController.GetColor(p43);
        end;

        TweenService:Create(v45, u8, {
            Color = p43
        }):Play();
    end;
end;

local function getUIScale(p46) -- Line: 274
    local v47 = p46:FindFirstChildWhichIsA("UIScale");

    if not v47 then
        v47 = Instance.new("UIScale");
        v47.Parent = p46;
    end;

    return v47;
end;

local function onButtonHover(p48) -- Line: 283
    -- upvalues: ThemeController (copy), u7 (copy), TweenService (copy), u1 (copy), u12 (ref), u13 (ref), left (copy), computeCatalogBase (copy), u2 (copy)
    local tooltip = p48:FindFirstChild("tooltip");

    if tooltip then
        tooltip.TextColor3 = ThemeController.GetColor(u7);
        tooltip.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(24, 25, 33));
        TweenService:Create(tooltip, u1, {
            BackgroundTransparency = 0.35,
            TextTransparency = 0
        }):Play();
    end;

    local v49 = p48:FindFirstChildWhichIsA("UIStroke");

    if v49 then
        if u12 then
            TweenService:Create(v49, u1, {
                Color = u13.hoverStroke,
                Transparency = u13.hoverStrokeTransparency
            }):Play();
        else
            TweenService:Create(v49, u1, {
                Transparency = 0
            }):Play();
        end;
    end;

    if u12 then
        local v50;

        if p48 == left.catalog then
            v50 = computeCatalogBase(u13.hoverFill);
        else
            v50 = u13.hoverFill;
        end;

        TweenService:Create(p48, u1, {
            BackgroundColor3 = v50,
            BackgroundTransparency = u13.hoverFillTransparency
        }):Play();
    else
        TweenService:Create(p48, u1, {
            BackgroundTransparency = 0.05
        }):Play();
    end;

    local v51 = p48:FindFirstChildWhichIsA("UIScale");

    if not v51 then
        v51 = Instance.new("UIScale");
        v51.Parent = p48;
    end;

    TweenService:Create(v51, u2, {
        Scale = 1.025
    }):Play();
end;

local function onButtonUnhover(p52) -- Line: 310
    -- upvalues: TweenService (copy), u1 (copy), u12 (ref), u14 (ref), u15 (ref), left (copy), computeCatalogBase (copy), u13 (ref), u16 (ref), u3 (copy)
    local tooltip = p52:FindFirstChild("tooltip");

    if tooltip then
        TweenService:Create(tooltip, u1, {
            BackgroundTransparency = 1,
            TextTransparency = 1
        }):Play();
    end;

    local v53 = p52:FindFirstChildWhichIsA("UIStroke");

    if v53 then
        if u12 then
            TweenService:Create(v53, u1, {
                Color = u14,
                Transparency = u15
            }):Play();
        else
            TweenService:Create(v53, u1, {
                Transparency = u15
            }):Play();
        end;
    end;

    if u12 then
        local v54;

        if p52 == left.catalog then
            v54 = computeCatalogBase(u13.fill);
        else
            v54 = u13.fill;
        end;

        TweenService:Create(p52, u1, {
            BackgroundColor3 = v54,
            BackgroundTransparency = u16
        }):Play();
    else
        TweenService:Create(p52, u1, {
            BackgroundTransparency = u16
        }):Play();
    end;

    local v55 = p52:FindFirstChildWhichIsA("UIScale");

    if not v55 then
        v55 = Instance.new("UIScale");
        v55.Parent = p52;
    end;

    TweenService:Create(v55, u3, {
        Scale = 1
    }):Play();
    p52.AutoButtonColor = false;
end;

local function updateTooltip(p56) -- Line: 337
    local tooltip = p56:FindFirstChild("tooltip");

    if tooltip then
        tooltip.Position = UDim2.fromScale(0.5, -0.125);
        tooltip.AnchorPoint = Vector2.new(0.5, 1);
        local Name = p56.Parent:FindFirstChildWhichIsA("UIListLayout").HorizontalAlignment.Name;

        if Name == "Left" then
            if p56.LayoutOrder == 0 then
                tooltip.Position = UDim2.fromScale(0, -0.125);
                tooltip.AnchorPoint = Vector2.new(0, 1);
            end;
        elseif Name == "Right" then
            local v57 = 0;

            for _, child in p56.Parent:GetChildren() do
                if child:IsA("TextButton") ~= false and v57 < child.LayoutOrder then
                    v57 = child.LayoutOrder;
                end;
            end;

            if p56.LayoutOrder == v57 then
                tooltip.Position = UDim2.fromScale(1, -0.125);
                tooltip.AnchorPoint = Vector2.new(1, 1);
            end;
        end;
    end;
end;

Button.Setup({
    Button = left.catalog,

    Callback = function() -- Line: 368, Name: Callback
        -- upvalues: CatalogController (copy)
        if CatalogController.IsOpen ~= true then
            CatalogController.Open();
        end;
    end,

    OnHover = function() -- Line: 373, Name: OnHover
        -- upvalues: onButtonHover (copy), left (copy), tweenButtonColors (copy), u4 (copy), TweenService (copy)
        onButtonHover(left.catalog);
        tweenButtonColors(left.catalog, u4);
        local UIGradient = left.catalog.UIGradient;
        local v58 = TweenService:Create(UIGradient, TweenInfo.new(0.15, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
            Offset = Vector2.new(1, 0)
        });
        local v59 = TweenService:Create(UIGradient, TweenInfo.new(0.35, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Offset = Vector2.new(0, 0)
        });
        v58:Play();
        v58.Completed:Wait();
        UIGradient.Offset = Vector2.new(-1, 0);
        v59:Play();
    end,

    OnUnhover = function() -- Line: 387, Name: OnUnhover
        -- upvalues: onButtonUnhover (copy), left (copy), tweenButtonColors (copy), u7 (copy)
        onButtonUnhover(left.catalog);
        tweenButtonColors(left.catalog, u7);
    end
});
Button.Setup({
    Button = left.outfits,

    Callback = function() -- Line: 395, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayOutfits:Fire(true);
    end,

    OnHover = function() -- Line: 398, Name: OnHover
        -- upvalues: onButtonHover (copy), left (copy), tweenButtonColors (copy), u5 (copy)
        onButtonHover(left.outfits);
        tweenButtonColors(left.outfits, u5);
    end,

    OnUnhover = function() -- Line: 402, Name: OnUnhover
        -- upvalues: onButtonUnhover (copy), left (copy), tweenButtonColors (copy), u7 (copy)
        onButtonUnhover(left.outfits);
        tweenButtonColors(left.outfits, u7);
    end
});
Button.Setup({
    Button = right.emotes,

    Callback = function() -- Line: 410, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayEmotes:Fire(true);
    end,

    OnHover = function() -- Line: 413, Name: OnHover
        -- upvalues: onButtonHover (copy), right (copy), tweenButtonColors (copy), u6 (copy)
        onButtonHover(right.emotes);
        tweenButtonColors(right.emotes, u6);
    end,

    OnUnhover = function() -- Line: 417, Name: OnUnhover
        -- upvalues: onButtonUnhover (copy), right (copy), tweenButtonColors (copy), u7 (copy)
        onButtonUnhover(right.emotes);
        tweenButtonColors(right.emotes, u7);
    end
});
Button.Setup({
    Button = right.admin,

    Callback = function() -- Line: 410, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayAdmin:Fire(true);
    end,

    OnHover = function() -- Line: 413, Name: OnHover
        -- upvalues: onButtonHover (copy), right (copy), tweenButtonColors (copy)
        onButtonHover(right.admin);
        tweenButtonColors(right.admin, Color3.fromRGB(255, 170, 0));
    end,

    OnUnhover = function() -- Line: 417, Name: OnUnhover
        -- upvalues: onButtonUnhover (copy), right (copy), tweenButtonColors (copy), u7 (copy)
        onButtonUnhover(right.admin);
        tweenButtonColors(right.admin, u7);
    end
});
Button.Setup({
    Button = right2.booth,

    Callback = function() -- Line: 425, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayBooth:Fire();
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
Button.Setup({
    Button = right2.settings,

    Callback = function() -- Line: 433, Name: Callback
        -- upvalues: SettingsController (copy)
        if SettingsController.IsOpen == true then
            SettingsController.Close();

            return;
        end;

        SettingsController.Open();
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
Button.Setup({
    Button = right2.pose,

    Callback = function() -- Line: 446, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayPose:Fire(true);
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
Button.Setup({
    Button = center.resetAvatar,

    Callback = function() -- Line: 455, Name: Callback
        -- upvalues: Events (copy), Remotes (copy)
        local v60 = Events.GetCurrentResetAvatarDialog:Invoke();

        if v60 and v60.Close then
            v60.Close(false);

            return;
        end;

        if Events.PromptResetAvatar:Invoke() == true then
            local v61, v62 = Remotes.ResetAvatar:InvokeServer();

            if v61 == false then
                warn("error resetting avatar:", v62);
            end;
        end;
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
Button.Setup({
    Button = center.saveOutfit,

    Callback = function() -- Line: 476, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplaySaveOutfit:Fire(true);
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
Button.Setup({
    Button = center.currentlyWearing,

    Callback = function() -- Line: 485, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayCurrentlyWearing:Fire(true);
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
Button.Setup({
    Button = center.adjustAccessories,

    Callback = function() -- Line: 494, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayAccessoryAdjustment:Fire(true);
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
Events.SetButtonsVisible.Event:Connect(function(p63, p64) -- Line: 501
    -- upvalues: Buttons (copy), ReplicatedStorage (copy)
    for _, descendant in Buttons:GetDescendants() do
        if descendant:IsA("TextButton") ~= false then
            if p64 and table.find(p64, descendant.Name) then
                descendant.Visible = false;
            elseif p63 == "All" or table.find(p63, "All") then
                descendant.Visible = true;
            else
                descendant.Visible = table.find(p63, descendant.Name) ~= nil;
            end;
        end;
    end;

    ReplicatedStorage.Purse.SetButtonsVisible:Fire(p63);
end);
Button.Setup({
    Button = left2.createAvatar,

    Callback = function() -- Line: 519, Name: Callback
        -- upvalues: Events (copy)
        Events.DisplayCreateAvatar:Fire(true);
    end,

    OnHover = onButtonHover,
    OnUnhover = onButtonUnhover
});
local v65, v66 = false, false;

for attempt = 1, 4 do
    local call1, success1, isModerator = pcall(function()
        return Remotes.GetFlag:InvokeServer("IsContentModerator");
    end);
    local call2, success2, isTrialModerator = pcall(function()
        return Remotes.GetFlag:InvokeServer("IsTrialModerator");
    end);

    if call1 and call2 and success1 == true and success2 == true then
        v65 = isModerator == true;
        v66 = isTrialModerator == true;
        break;
    end;

    if attempt < 4 then
        task.wait(0.5 * attempt);
    end;
end;

if v65 == true or v66 == true then
    left2.moderation.Visible = true;
    Button.Setup({
        Button = left2.moderation,

        Callback = function() -- Line: 541, Name: Callback
            -- upvalues: Events (copy)
            Events.DisplayModeration:Fire(true);
        end,

        OnHover = onButtonHover,
        OnUnhover = onButtonUnhover
    });
else
    left2.moderation:Destroy();
end;

task.spawn(function()
    local isAdmin = false;
    for attempt = 1, 4 do
        local callSuccess, requestOk, enabled = pcall(function()
            return Remotes.GetFlag:InvokeServer("IsAdministrator");
        end);
        if callSuccess and requestOk == true then
            isAdmin = enabled == true;
            break;
        end;
        if attempt < 4 then
            task.wait(0.5 * attempt);
        end;
    end;
    if not isAdmin then
        right.admin:Destroy();
    end;
end);