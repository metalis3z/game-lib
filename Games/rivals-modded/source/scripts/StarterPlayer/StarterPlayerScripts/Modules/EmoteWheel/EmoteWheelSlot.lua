-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local EmoteViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules.EmoteViewportFrame);
local EmoteWheelSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EmoteWheelSlot");
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy), EmoteWheelSlot (copy), EmoteViewportFrame (copy)
    local v3 = setmetatable({}, u1);
    v3.EquippedData = p2;
    v3.Name = v3.EquippedData and v3.EquippedData.Name;
    v3.Frame = EmoteWheelSlot:Clone();
    local v4 = v3.Name and EmoteViewportFrame.new(v3.Name, 4);
    v3._emote_viewport_frame = v4;
    v3._is_highlighted = nil;
    v3._background = v3.Frame.Background;
    v3._highlight = v3._background.Highlight;
    v3._container = v3.Frame.Container;
    v3._title = v3._container.Title;
    v3._title_stroke = v3._title.UIStroke;
    v3._highlight_tweens = {};
    v3._equip_bounce_effect_ui_scale = Instance.new("UIScale");
    v3:_Init();

    return v3;
end;

function u1.GetContainerPosition(p5) -- Line: 41
    return p5._container.AbsolutePosition + p5._container.AbsoluteSize / 2;
end;

function u1.SetHighlighted(p6, p7) -- Line: 45
    -- upvalues: TweenService (copy), TweenInfo_new_ret2 (copy)
    if p6._is_highlighted == p7 then
        return;
    end;

    for _, v in pairs(p6._highlight_tweens) do
        v:Pause();
        v:Destroy();
    end;

    p6._highlight_tweens = {};
    p6._is_highlighted = p7;
    p6.Frame.ZIndex = p7 and 1 or 0;
    local v8 = TweenService:Create(p6.Frame, TweenInfo_new_ret2, {
        Size = p6._is_highlighted and UDim2.new(1.1, 0, 1.1, 0) or UDim2.new(1, 0, 1, 0)
    });
    v8:Play();
    table.insert(p6._highlight_tweens, v8);
    local v9 = TweenService:Create(p6._highlight, TweenInfo_new_ret2, {
        ImageTransparency = p6._is_highlighted and 0 or 1
    });
    v9:Play();
    table.insert(p6._highlight_tweens, v9);
    local v10 = TweenService:Create(p6._title, TweenInfo_new_ret2, {
        Size = p6._is_highlighted and UDim2.new(3, 0, 0.25, 0) or UDim2.new(3, 0, 0.175, 0),
        TextTransparency = p6._is_highlighted and 0 or 0.5
    });
    v10:Play();
    table.insert(p6._highlight_tweens, v10);
    local v11 = TweenService:Create(p6._title_stroke, TweenInfo_new_ret2, {
        Transparency = p6._is_highlighted and 0.75 or 0.875
    });
    v11:Play();
    table.insert(p6._highlight_tweens, v11);

    if p6._emote_viewport_frame then
        local v12 = TweenService:Create(p6._emote_viewport_frame.Frame, TweenInfo_new_ret2, {
            Size = p6._is_highlighted and UDim2.new(1.375, 0, 1.375, 0) or UDim2.new(1, 0, 1, 0)
        });
        v12:Play();
        table.insert(p6._highlight_tweens, v12);
    end;
end;

function u1.SetRotation(p13, p14) -- Line: 83
    p13.Frame.Rotation = p14;
    p13._container.Rotation = -p14;
end;

function u1.EquipBounceEffect(p15) -- Line: 88
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    p15._equip_bounce_effect_ui_scale.Scale = 1.25;
    TweenService:Create(p15._equip_bounce_effect_ui_scale, TweenInfo_new_ret, {
        Scale = 1
    }):Play();
end;

function u1.Destroy(p16) -- Line: 93
    if p16._emote_viewport_frame then
        p16._emote_viewport_frame:Destroy();
    end;

    p16.Frame:Destroy();
end;

function u1._Setup(p17) -- Line: 105
    -- upvalues: CosmeticLibrary (copy)
    if p17._emote_viewport_frame then
        p17._emote_viewport_frame:SetParent(p17._container);
    end;

    p17._background.ImageTransparency = p17.Name and 0.25 or 0.5;
    p17._title.Text = p17.Name or "";
    p17._highlight.ImageColor3 = not p17.Name and Color3.fromRGB(0, 0, 0) or CosmeticLibrary.Rarities[CosmeticLibrary.Cosmetics[p17.Name].Rarity].Color;
    p17._equip_bounce_effect_ui_scale.Parent = p17.Frame;
end;

function u1._Init(p18) -- Line: 116
    p18:_Setup();
    p18:SetHighlighted(false);
end;

return u1;