-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("StaticModel"):WaitForChild("StaticViewModel"));
local CosmeticViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticViewportFrame"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local EmoteViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("EmoteViewportFrame"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local CosmeticSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 20
    -- upvalues: u1 (copy), CosmeticLibrary (copy), CosmeticSlot (copy)
    local v5 = setmetatable({}, u1);
    v5.Name = p2;
    v5.Info = CosmeticLibrary.Cosmetics[v5.Name];
    v5.IsLocked = p3;
    v5.Frame = CosmeticSlot:Clone();
    v5._cleanup = {};
    v5._ignore_button_effects = p4;
    v5._quantity = 1;
    v5._name_text_override = nil;
    v5._emote_viewport_frame = nil;
    v5._cosmetic_viewport_frame = nil;
    v5:_Init();

    return v5;
end;

function u1.SetWeapon(p6, p7) -- Line: 44
    -- upvalues: ItemLibrary (copy), WeaponStatusHandler (copy)
    local v8 = ItemLibrary.Items[p7];
    local v9 = ItemLibrary.ViewModels[p7];
    local v10 = p7 == "IsUniversal" and true or p7 == "IsRandom";
    local v11;

    if p7 == "IsUniversal" then
        v11 = ItemLibrary.UNIVERSAL_WEAPON_ICON;
    elseif p7 == "IsRandom" then
        v11 = ItemLibrary.RANDOM_WEAPON_ICON;
    else
        v11 = not v9 and "" or (v9.ImageCentered or v9.Image);
    end;

    p6.Frame.Button.Weapon.Visible = not p6.IsLocked and p7;
    p6.Frame.Button.Weapon.Container.IconCanvas.Icon.Image = v11;
    p6.Frame.Button.Weapon.Container.IconCanvas.Icon.ImageTransparency = v10 and 0.25 or 0;
    p6.Frame.Button.Weapon.Container.IconCanvas.Icon.Size = v10 and UDim2.new(0.75, 0, 1, 0) or UDim2.new(4, 0, 4, 0);
    WeaponStatusHandler:ApplyItemStatusToBackground(p6.Frame.Button.Weapon.Container.Background, p6.Frame.Button.Weapon.Container.Outline.UIStroke, v8 and v8.Status or "Standard");
end;

function u1.SetQuantity(p12, p13) -- Line: 62
    p12._quantity = p13 or 1;
    p12:_UpdateNameText();
end;

function u1.SetInteractable(p14, p15) -- Line: 67
    p14.Frame.Button.Interactable = p15;
end;

function u1.OverrideNameText(p16, p17) -- Line: 71
    p16._name_text_override = p17;
    p16:_UpdateNameText();
end;

function u1.UseHighResolutionImage(p18) -- Line: 76
    -- upvalues: CONSTANTS (copy), ItemLibrary (copy)
    p18.Frame.Button.Icon.Image = CONSTANTS.COSMETIC_IMAGES[p18.Name] or ItemLibrary.ViewModels[p18.Name] and ItemLibrary.ViewModels[p18.Name].ImageHighResolution or p18.Info.Image;
end;

function u1.HideBackground(p19) -- Line: 80
    p19.Frame.Button.Background.Visible = false;

    if p19._cosmetic_viewport_frame then
        p19._cosmetic_viewport_frame.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    end;

    if p19._emote_viewport_frame then
        p19._emote_viewport_frame.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    end;
end;

function u1.ZoomOutViewportFrame(p20) -- Line: 92
    if p20._cosmetic_viewport_frame then
        p20._cosmetic_viewport_frame:ZoomOut();
    end;

    if p20._emote_viewport_frame then
        p20._emote_viewport_frame:ZoomOut();
    end;
end;

function u1.Destroy(p21) -- Line: 102
    p21.Frame:Destroy();

    if p21._cosmetic_viewport_frame then
        p21._cosmetic_viewport_frame:Destroy();
    end;

    if p21._emote_viewport_frame then
        p21._emote_viewport_frame:Destroy();
    end;
end;

function u1._UpdateNameText(p22) -- Line: 118
    -- upvalues: Utility (copy)
    p22.Frame.Button.Title.Size = (p22._name_text_override or (p22._quantity == 1 or p22._quantity == 0)) and UDim2.new(0.9, 0, 0.2, 0) or UDim2.new(0.9, 0, 0.4, 0);
    p22.Frame.Button.Title.Text = p22._name_text_override or (p22.Name == "RANDOM_COSMETIC" and "Random" or (p22.Name == "NONE_COSMETIC" and "None" or ((p22._quantity == 1 or p22._quantity == 0) and p22.Name or "×" .. Utility:PrettyNumber(p22._quantity))));
end;

function u1._Setup(p23) -- Line: 127
    -- upvalues: CosmeticLibrary (copy), CONSTANTS (copy), ButtonEffect (copy), EmoteViewportFrame (copy), CosmeticViewportFrame (copy)
    local v24 = p23.Info and CosmeticLibrary.Rarities[p23.Info.Rarity].Color or Color3.fromRGB(0, 0, 0);
    p23.Frame.Button.Icon.ZIndex = p23.Info and (p23.Info.Type == "Skin" and not p23.IsLocked) and 3 or p23.Frame.Button.Icon.ZIndex;
    p23.Frame.Button.Icon.Size = (p23.Name == "RANDOM_COSMETIC" or p23.Name == "NONE_COSMETIC") and UDim2.new(0.45, 0, 0.45, 0) or UDim2.new(0.75 * p23.Info.ImageScale, 0, 0.75 * p23.Info.ImageScale, 0);
    p23.Frame.Button.Icon.Image = CONSTANTS.COSMETIC_IMAGES[p23.Name] or p23.Info.Image;
    p23.Frame.Button.Icon.ImageTransparency = (p23.Name == "RANDOM_COSMETIC" or p23.Name == "NONE_COSMETIC") and 0.875 or (p23.IsLocked and 0.5 or 0);
    p23.Frame.Button.Icon.ImageColor3 = p23.IsLocked and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p23.Frame.Button.Title.TextTransparency = p23.IsLocked and 0.5 or 0;
    p23.Frame.Button.Locked.Visible = p23.IsLocked;
    p23.Frame.Button.Background.UIStroke.Color = v24;
    p23.Frame.Button.Background.BackgroundColor3 = v24;

    if not p23._ignore_button_effects then
        ButtonEffect:Add(p23.Frame.Button);
    end;

    if not (p23.IsLocked and p23.Info) then
        if p23.Info then
            if p23.Info.Type == "Emote" then
                p23._emote_viewport_frame = EmoteViewportFrame.new(p23.Name);
                p23._emote_viewport_frame.Frame.ZIndex = p23.IsLocked and 0 or 1;
                p23._emote_viewport_frame:SetParent(p23.Frame.Button);
                p23._emote_viewport_frame:SetLocked(p23.IsLocked);

                return;
            end;

            p23._cosmetic_viewport_frame = CosmeticViewportFrame.new(p23.Name, p23.IsLocked);
            p23._cosmetic_viewport_frame.Frame.BackgroundColor3 = v24;
            p23._cosmetic_viewport_frame.Frame.Parent = p23.Frame.Button;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 8);
            UICorner.Parent = p23._cosmetic_viewport_frame.Frame;
        end;

        return;
    end;

    p23.Frame.Button.Icon.ZIndex = 1;
    p23.Frame.Button.Icon.Size = UDim2.new(0.6, 0, 0.6, 0);
    p23.Frame.Button.Icon.Image = CosmeticLibrary.Types[p23.Info.Type].Image;
    p23.Frame.Button.Icon.ImageTransparency = 0.5;
    p23.Frame.Button.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
end;

function u1._Init(u25) -- Line: 168
    u25.Frame.Destroying:Connect(function() -- Line: 169
        -- upvalues: u25 (copy)
        for _, v in pairs(u25._cleanup) do
            v:Destroy();
        end;
    end);
    u25:_Setup();
    u25:_UpdateNameText();
    u25:SetWeapon(nil);
    u25:SetQuantity(nil);
end;

return u1;