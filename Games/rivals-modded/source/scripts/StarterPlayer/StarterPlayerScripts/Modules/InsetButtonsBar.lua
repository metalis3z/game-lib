-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local InsetBarButton = require(script:WaitForChild("InsetBarButton"));
local InsetButtonsBar = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InsetButtonsBar");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5) -- Line: 13
    -- upvalues: u1 (copy), Signal (copy), InsetButtonsBar (copy)
    local v6 = setmetatable({}, u1);
    v6.OpenedChanged = Signal.new();
    v6.Frame = InsetButtonsBar:Clone();
    v6.Container = v6.Frame:WaitForChild("Container");
    v6.Layout = v6.Container:WaitForChild("Layout");
    v6.IsOpen = nil;
    v6.Buttons = {};
    v6._background_transparency = p2;
    v6._background_color = p3;
    v6._visual_color = p4;
    v6._is_mirrored = p5;
    v6._num_buttons_visible_while_closed = 1;
    v6:_Init();

    return v6;
end;

function u1.IsWithin(p7, p8, p9) -- Line: 40
    -- upvalues: UILibrary (copy)
    local Visible = p7.Frame.Visible;

    if Visible then
        if p7:GetNumVisibleButtons() > 0 then
            Visible = UILibrary:IsWithinBounds(p8, p9, p7.Frame.AbsolutePosition, p7.Frame.AbsoluteSize);
        else
            Visible = false;
        end;
    end;

    return Visible;
end;

function u1.GetVisualColor(p10) -- Line: 44
    return p10._visual_color;
end;

function u1.GetBackgroundColor(p11) -- Line: 48
    return p11._background_color;
end;

function u1.GetNumVisibleButtons(p12) -- Line: 52
    local v13 = 0;

    for _, v in pairs(p12.Buttons) do
        if v.Frame.Visible then
            v13 = v13 + 1;
        end;
    end;

    return v13;
end;

function u1.SetMirrored(p14, p15) -- Line: 64
    if p15 == p14._is_mirrored then
        return;
    end;

    p14._is_mirrored = p15;
    p14:_UpdateMirrored();
end;

function u1.Toggle(p16, p17, p18) -- Line: 73
    if p17 == nil then
        p17 = not p16.IsOpen;
    end;

    p16.IsOpen = p17;
    p16.OpenedChanged:Fire(p16.IsOpen);
end;

function u1.SetClosedButtonsVisible(p19, p20) -- Line: 78
    p19._num_buttons_visible_while_closed = p20;
    p19.OpenedChanged:Fire(p19.IsOpen);
end;

function u1.CreateButton(u21, p22, u23, p24, p25, p26, p27) -- Line: 83
    -- upvalues: InsetBarButton (copy)
    local v28 = InsetBarButton.new(u23, p24, p25, p26, p27, u21._visual_color, u21._is_mirrored);
    v28.Frame.LayoutOrder = p22 * (u21._is_mirrored and -1 or 1);
    v28.Frame.Parent = u21.Container;
    v28.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 88
        -- upvalues: u21 (copy)
        u21:Toggle(u21.IsOpen);
    end);
    v28.Entered:Connect(function() -- Line: 92
        -- upvalues: u21 (copy), u23 (copy)
        for i, v in pairs(u21.Buttons) do
            if i ~= u23 then
                v:PlayBubbleEffect(nil);
                v:Leave();
            end;
        end;
    end);
    u21.Buttons[v28.Name] = v28;

    return v28;
end;

function u1.RemoveButton(p29, p30) -- Line: 106
    local v31 = p29.Buttons[p30];

    if not v31 then
        return;
    end;

    p29.Buttons[p30] = nil;
    v31:Destroy();
    p29:Toggle(p29.IsOpen);
end;

function u1.Destroy(p32) -- Line: 118
    for _, v in pairs(p32.Buttons) do
        v:Destroy();
    end;

    p32.Frame:Destroy();
    p32.OpenedChanged:Destroy();
end;

function u1._UpdateMirrored(p33) -- Line: 131
    p33.Container.AnchorPoint = p33._is_mirrored and Vector2.new(1, 0) or Vector2.new(0, 0);
    p33.Container.Position = p33._is_mirrored and UDim2.new(1, 0, 0, 0) or UDim2.new(0, 0, 0, 0);
    p33.Layout.HorizontalAlignment = p33._is_mirrored and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left;

    for _, v in pairs(p33.Buttons) do
        v.Frame.LayoutOrder = math.abs(v.Frame.LayoutOrder) * (p33._is_mirrored and -1 or 1);
        v:SetMirrored(p33._is_mirrored);
    end;
end;

function u1._LeaveButtons(p34) -- Line: 142
    for _, v in pairs(p34.Buttons) do
        v:Leave();
    end;
end;

function u1._UpdateSize(p35) -- Line: 148
    -- upvalues: Players (copy)
    local v36 = p35.IsOpen and UDim2.new(p35:GetNumVisibleButtons(), 0, 1, 0) or UDim2.new(p35._num_buttons_visible_while_closed, 0, 1, 0);

    if p35.Frame:IsDescendantOf(Players) then
        p35.Frame:TweenSize(v36, "Out", "Quint", 0.25, true);

        return;
    end;

    p35.Frame.Size = v36;
end;

function u1._Setup(p37) -- Line: 158
    p37.Frame.BackgroundTransparency = p37._background_transparency;
    p37.Frame.BackgroundColor3 = p37._background_color;
    p37.Frame:AddTag("CoreGuiBackground");
end;

function u1._Init(u38) -- Line: 164
    u38.OpenedChanged:Connect(function() -- Line: 165
        -- upvalues: u38 (copy)
        u38:_UpdateSize();
        u38:_LeaveButtons();
    end);
    u38:_Setup();
    u38:_UpdateSize();
    u38:_UpdateMirrored();
    u38:Toggle(false);
end;

return u1;