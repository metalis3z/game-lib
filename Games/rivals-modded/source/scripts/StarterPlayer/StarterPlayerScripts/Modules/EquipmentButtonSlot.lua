-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local EquipmentButtonSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentButtonSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7, p8) -- Line: 11
    -- upvalues: u1 (copy), EquipmentButtonSlot (copy)
    local v9 = setmetatable({}, u1);
    v9.Name = p2;
    v9.Frame = EquipmentButtonSlot:Clone();
    v9.Button = v9.Frame:WaitForChild("Button");
    v9.Background = v9.Button:WaitForChild("Background");
    v9.LockedLeft = v9.Button:WaitForChild("LockedLeft");
    v9.LockedRight = v9.Button:WaitForChild("LockedRight");
    v9.Icon = v9.Button:WaitForChild("Icon");
    v9.Title = v9.Button:WaitForChild("Title");
    v9.Notification = v9.Title:WaitForChild("Notification");
    v9.NotificationTitle = v9.Notification:WaitForChild("Title");
    v9._layout_order = p3;
    v9._is_unlocked = p4;
    v9._display_name = p5;
    v9._image = p6;
    v9._status = p7;
    v9._num_notifications = p8 or 0;
    v9._is_icon_locked = false;
    v9._is_active = false;
    v9:_Init();

    return v9;
end;

function u1.SetParent(p10, p11) -- Line: 43
    p10.Frame.Parent = p11;
end;

function u1.SetCareerIcon(p12) -- Line: 47
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = p12.Icon;
    p12.Icon.Size = UDim2.new(1.1, 0, 1.1, 0);
    p12._is_icon_locked = true;
end;

function u1.SetActive(p13, p14) -- Line: 56
    if p13._is_active == p14 then
        return;
    end;

    p13._is_active = p14;
    local Frame = p13.Frame;
    local v15;

    if p13._is_active then
        v15 = UDim2.new(1, 0, 0.25, 0);
    else
        v15 = UDim2.new(1, 0, 0.2, 0);
    end;

    Frame:TweenSize(v15, "Out", p13._is_active and "Back" or "Quint", 0.5, true);
    local Icon = p13.Icon;
    local v16;

    if p13._is_active and not p13._is_icon_locked then
        v16 = UDim2.new(0.8, 0, 0.5, 0);
    else
        v16 = UDim2.new(0.2, 0, 0.5, 0);
    end;

    Icon:TweenPosition(v16, "Out", "Quint", 0.5, true);
    p13.Background.Visible = p13._is_active;
    local LockedLeft = p13.LockedLeft;
    local v17;

    if p13._is_active then
        v17 = UDim2.new(0.5, 0, 0.375, 0);
    else
        v17 = UDim2.new(0.75, 0, 0.375, 0);
    end;

    LockedLeft.Size = v17;
    p13.LockedRight.Size = p13.LockedLeft.Size;
    p13.Icon.ImageTransparency = (p13._is_active or p13._is_unlocked) and 0 or 0.5;
    local Title = p13.Title;
    local v18;

    if p13._is_active or p13._is_unlocked then
        v18 = Color3.fromRGB(255, 255, 255);
    else
        v18 = Color3.fromRGB(0, 0, 0);
    end;

    Title.TextColor3 = v18;
    p13.Title.TextTransparency = p13._is_active and 0 or 0.5;
    p13.LockedLeft.ImageTransparency = p13._is_active and 0 or 0.5;
    local LockedLeft2 = p13.LockedLeft;
    local v19;

    if p13._is_active then
        v19 = Color3.fromRGB(255, 255, 255);
    else
        v19 = Color3.fromRGB(0, 0, 0);
    end;

    LockedLeft2.ImageColor3 = v19;
    p13.LockedRight.ImageTransparency = p13.LockedLeft.ImageTransparency;
    p13.LockedRight.ImageColor3 = p13.LockedLeft.ImageColor3;
    p13.Frame.ClipsDescendants = not p13._is_active;
    p13.Frame.ZIndex = p13._is_active and 2 or 1;
    p13.Notification.Visible = not p13._is_active and p13._num_notifications > 0;
end;

function u1.Destroy(p20) -- Line: 80
    p20.Frame:Destroy();
end;

function u1._Update(p21) -- Line: 88
    p21.LockedLeft.Position = UDim2.new(0.5, -p21.Title.TextBounds.X / 2, 0.5, 0);
    p21.LockedRight.Position = UDim2.new(0.5, p21.Title.TextBounds.X / 2, 0.5, 0);
    p21.Notification.Position = UDim2.new(0.5, p21.Title.TextBounds.X / 2 + p21.Notification.AbsoluteSize.X / 2, 0.5, 0);
end;

function u1._Setup(p22) -- Line: 94
    -- upvalues: WeaponStatusHandler (copy)
    p22.Frame.LayoutOrder = p22._layout_order;
    p22.LockedLeft.Visible = not p22._is_unlocked;
    p22.LockedRight.Visible = not p22._is_unlocked;
    p22.Title.Text = p22._display_name;
    local Title = p22.Title;
    local v23;

    if p22._is_unlocked then
        v23 = Color3.fromRGB(255, 255, 255);
    else
        v23 = Color3.fromRGB(0, 0, 0);
    end;

    Title.TextColor3 = v23;
    p22.Icon.Image = p22._image;
    p22.Icon.ImageColor3 = p22._is_unlocked and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    p22.Icon.ImageTransparency = p22._is_unlocked and 0 or 0.5;
    p22.Icon.Visible = p22._is_unlocked;
    p22.Notification.Visible = p22._num_notifications > 0;
    p22.NotificationTitle.Text = p22._num_notifications;
    WeaponStatusHandler:ApplyItemStatusToText(p22.Title, p22._status);
    WeaponStatusHandler:ApplyItemStatusToImage(p22.LockedLeft, p22._status);
    WeaponStatusHandler:ApplyItemStatusToImage(p22.LockedRight, p22._status);
end;

function u1._Init(u24) -- Line: 112
    -- upvalues: ButtonEffect (copy)
    u24.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 113
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24.Notification:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 117
        -- upvalues: u24 (copy)
        u24:_Update();
    end);
    u24:_Setup();
    u24:_Update();
    ButtonEffect:Add(u24.Button, nil, {
        ReleaseRatio = 0.95,
        HoverRatio = 0.95
    });
end;

return u1;