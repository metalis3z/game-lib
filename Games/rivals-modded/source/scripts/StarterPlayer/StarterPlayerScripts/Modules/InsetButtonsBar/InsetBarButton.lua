-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local InsetBarButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InsetBarButton");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7, p8) -- Line: 14
    -- upvalues: u1 (copy), Signal (copy), InsetBarButton (copy)
    local v9 = setmetatable({}, u1);
    v9.Clicked = Signal.new();
    v9.Entered = Signal.new();
    v9.Name = p2;
    v9.Frame = InsetBarButton:Clone();
    v9._display_name = p3;
    v9._visual = p4;
    v9._visual_position = p5;
    v9._visual_size = p6;
    v9._visual_color = p7;
    v9._is_mirrored = p8;
    v9._bubble_effect_hash = 0;
    v9._bubble_effect_playing = false;
    v9._original_icon_size = nil;
    v9:_Init();

    return v9;
end;

function u1.SetMirrored(p10, p11) -- Line: 42
    if p11 == p10._is_mirrored then
        return;
    end;

    p10._is_mirrored = p11;
    p10:_UpdateMirrored();
end;

function u1.Enter(p12) -- Line: 51
    if p12._bubble_effect_playing then
        return;
    end;

    p12.Frame.Button.OnHover.Visible = true;
    p12.Entered:Fire();
end;

function u1.Leave(p13) -- Line: 60
    if p13._bubble_effect_playing then
        return;
    end;

    p13.Frame.Button.OnHover.Visible = false;
end;

function u1.SetBubbleText(p14, p15) -- Line: 68
    p14.Frame.Button.OnHover.Bubble.Container.Title.Text = p15;
end;

function u1.PlayJiggleEffect(p16) -- Line: 72
    p16.Frame.Button.Icon.Size = UDim2.new(p16._original_icon_size.X.Scale * 1.5, p16._original_icon_size.X.Offset * 1.5, p16._original_icon_size.Y.Scale * 1.5, p16._original_icon_size.Y.Offset * 1.5);
    p16.Frame.Button.Icon:TweenSize(p16._original_icon_size, "Out", "Back", 0.25, true);
end;

function u1.PlayBubbleEffect(u17, p18) -- Line: 83
    -- upvalues: Players (copy)
    u17._bubble_effect_hash = u17._bubble_effect_hash + 1;
    local _bubble_effect_hash = u17._bubble_effect_hash;

    if not p18 then
        u17:_DisableBubbleEffect();

        return;
    end;

    u17._bubble_effect_playing = true;
    u17.Frame.Button.OnHover.Visible = true;
    u17.Frame.Button.OnHover.Bubble.Visible = true;
    u17.Frame.Button.OnHover.Bubble.Container.Title.Text = p18;
    task.delay(3, function() -- Line: 97
        -- upvalues: _bubble_effect_hash (copy), u17 (copy), Players (ref)
        wait(3);

        if _bubble_effect_hash ~= u17._bubble_effect_hash or not u17.Frame:IsDescendantOf(Players) then
            return;
        end;

        u17:_DisableBubbleEffect();
    end);
end;

function u1.Destroy(u19) -- Line: 108
    u19.Clicked:Destroy();
    u19.Entered:Destroy();
    pcall(function() -- Line: 112
        -- upvalues: u19 (copy)
        u19.Frame:Destroy();
    end);
end;

function u1._DisableBubbleEffect(p20) -- Line: 121
    p20:_ResetBubbleVisibility();
    p20._bubble_effect_playing = false;
    p20:Leave();
end;

function u1._ResetBubbleVisibility(p21) -- Line: 127
    p21.Frame.Button.OnHover.Bubble.Visible = p21._display_name ~= nil;
end;

function u1._UpdateBubble(p22) -- Line: 131
    p22.Frame.Button.OnHover.Bubble.Container.Background.Size = UDim2.new(0.25, p22.Frame.Button.OnHover.Bubble.Container.Title.TextBounds.X, 1, 0);
end;

function u1._UpdateBubbleContainer(p23) -- Line: 135
    local v24 = 1;

    for i = 1, #p23.Frame.Button.OnHover.Bubble.Container.Title.Text do
        local v25;

        if string.sub(p23.Frame.Button.OnHover.Bubble.Container.Title.Text, i, i) == "\n" then
            v24 = v24 + 1;
            v25 = i;
        else
            v25 = i;
        end;
    end;

    p23.Frame.Button.OnHover.Bubble.Container.Size = UDim2.new(3.25, 0, v24 * 0.75, 0);
    p23.Frame.Button.OnHover.Bubble.Container.Arrow.Size = UDim2.new(0.5 / v24, 0, 0.5 / v24, 0);
    p23:_UpdateBubble();
end;

function u1._UpdateMirrored(p26) -- Line: 149
    p26.Frame.Button.OnHover.Bubble.Container.Title.AnchorPoint = p26._is_mirrored and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
    p26.Frame.Button.OnHover.Bubble.Container.Title.Position = p26._is_mirrored and UDim2.new(0.875, 0, 0.5, 0) or UDim2.new(0.125, 0, 0.5, 0);
    p26.Frame.Button.OnHover.Bubble.Container.Title.TextXAlignment = p26._is_mirrored and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;
    p26.Frame.Button.OnHover.Bubble.Container.Background.AnchorPoint = p26._is_mirrored and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
    p26.Frame.Button.OnHover.Bubble.Container.Background.Position = p26._is_mirrored and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
    p26.Frame.Button.OnHover.Bubble.Container.Arrow.Position = p26._is_mirrored and UDim2.new(0.75, 0, 0, 2) or UDim2.new(0.25, 0, 0, 2);
    p26.Frame.Button.OnHover.Bubble.Container.AnchorPoint = p26._is_mirrored and Vector2.new(0.75, 0) or Vector2.new(0.25, 0);
end;

function u1._Setup(p27) -- Line: 159
    local v28;

    if typeof(p27._visual) == "string" and #p27._visual >= 13 then
        v28 = string.sub(p27._visual, 1, 13) == "rbxassetid://";
    else
        v28 = false;
    end;

    p27.Frame.Button.Icon.Image = v28 and (p27._visual or "") or "";
    p27.Frame.Button.Icon.Position = p27._visual_position or UDim2.new(0.5, 0, 0.5, 0);
    p27.Frame.Button.Icon.Size = p27._visual_size or UDim2.new(0.5, 0, 0.5, 0);
    p27.Frame.Button.Title.Position = p27._visual_position or UDim2.new(0.5, 0, 0.5, 0);
    p27.Frame.Button.Title.Size = p27._visual_size or UDim2.new(0.5, 0, 0.5, 0);
    p27.Frame.Button.Title.Text = v28 and "" or (p27._visual or "");
    p27.Frame.Button.Title.TextColor3 = p27._visual_color;
    p27.Frame.Button.Icon.ImageColor3 = p27._visual_color;
    p27.Frame.Button.OnHover.Visible = false;
    p27.Frame.Button.OnHover.BackgroundTransparency = 0.75;
    p27.Frame.Button.OnHover.Bubble.Container.Title.Text = p27._display_name or "";
    p27._original_icon_size = p27.Frame.Button.Icon.Size;
end;

function u1._Init(u29) -- Line: 177
    -- upvalues: ButtonEffect (copy)
    u29.Frame.Destroying:Connect(function() -- Line: 178
        -- upvalues: u29 (copy)
        u29:Destroy();
    end);
    u29.Frame.Button.MouseButton1Click:Connect(function() -- Line: 182
        -- upvalues: u29 (copy)
        u29.Clicked:Fire();
    end);
    u29.Frame.MouseEnter:Connect(function() -- Line: 186
        -- upvalues: u29 (copy)
        u29:Enter();
    end);
    u29.Frame.MouseLeave:Connect(function() -- Line: 190
        -- upvalues: u29 (copy)
        u29:Leave();
    end);
    u29.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 194
        -- upvalues: u29 (copy)
        u29:Leave();
    end);
    u29.Frame.Button.OnHover.Bubble.Container.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 198
        -- upvalues: u29 (copy)
        u29:_UpdateBubble();
    end);
    u29.Frame.Button.OnHover.Bubble.Container.Title:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 202
        -- upvalues: u29 (copy)
        u29:_UpdateBubbleContainer();
    end);
    u29:_Setup();
    u29:_UpdateMirrored();
    u29:_UpdateBubble();
    u29:_ResetBubbleVisibility();
    u29:_UpdateBubbleContainer();
    u29:Leave();
    ButtonEffect:Add(u29.Frame.Button, true);
end;

return u1;