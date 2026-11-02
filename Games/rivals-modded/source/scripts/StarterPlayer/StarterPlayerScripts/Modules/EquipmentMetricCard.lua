-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules.UILibrary);
local EquipmentMetricSeasonRewardsSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentMetricSeasonRewardsSlot");
local EquipmentMetricCard = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentMetricCard");
local EquipmentMetricSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentMetricSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 16
    -- upvalues: u1 (copy), Signal (copy), EquipmentMetricCard (copy)
    local v4 = setmetatable({}, u1);
    v4.Clicked = Signal.new();
    v4.Opened = Signal.new();
    v4.Frame = EquipmentMetricCard:Clone();
    v4.Container = v4.Frame:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.HeaderFrame = v4.Container:WaitForChild("Header");
    v4.CloseButton = v4.HeaderFrame:WaitForChild("Button");
    v4.Title = v4.HeaderFrame:WaitForChild("Title");
    v4.Icon = v4.HeaderFrame:WaitForChild("Icon");
    v4._title = p2;
    v4._icon = p3;
    v4._elements = {};
    v4._set_opened_hash = 0;
    v4._reward_slots = {};
    v4:_Init();

    return v4;
end;

function u1.GetScrollToElement(p5) -- Line: 45
    return p5.Container;
end;

function u1.SetParent(p6, p7) -- Line: 49
    p6.Frame.Parent = p7;
end;

function u1.SetOpened(u8, p9) -- Line: 53
    -- upvalues: Players (copy)
    u8._set_opened_hash = u8._set_opened_hash + 1;
    local _set_opened_hash = u8._set_opened_hash;
    u8.Container.Visible = p9;

    if p9 then
        u8.Frame.Visible = true;
        u8.Opened:Fire();

        return;
    end;

    if u8.Frame:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
        u8.Frame:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quint", 0.25, true, function() -- Line: 63
            -- upvalues: _set_opened_hash (copy), u8 (copy)
            if _set_opened_hash ~= u8._set_opened_hash then
                return;
            end;

            u8.Frame.Visible = false;
        end);

        return;
    end;

    u8.Frame.Visible = false;
end;

function u1.Add(p10, p11, p12) -- Line: 75
    -- upvalues: EquipmentMetricSlot (copy), UILibrary (copy)
    local v13 = EquipmentMetricSlot:Clone();
    v13.TitleContainer.Title.Text = p11;
    v13.Value.RichText = string.find(p12, "<");
    v13.Value.Text = p12;
    v13.LayoutOrder = #p10._elements;
    v13.Parent = p10.Container;
    table.insert(p10._elements, v13);
    UILibrary:ScrollingTextLabel(v13.TitleContainer, v13.TitleContainer.Title, v13.Value);
end;

function u1.AddSeasonRewards(p14, p15) -- Line: 86
    -- upvalues: EquipmentMetricSeasonRewardsSlot (copy), RewardSlot (copy)
    local v16 = EquipmentMetricSeasonRewardsSlot:Clone();
    v16.LayoutOrder = #p14._elements;

    for _, v in pairs(p15) do
        local v17 = RewardSlot.new(v);
        v17:SetParent(v16.RewardContainer);
        table.insert(p14._reward_slots, v17);
    end;

    v16.Parent = p14.Container;
    table.insert(p14._elements, v16);
end;

function u1.Clear(p18) -- Line: 100
    for _, v in pairs(p18._elements) do
        v:Destroy();
    end;

    p18._elements = {};
end;

function u1.Destroy(p19) -- Line: 108
    for _, v in pairs(p19._reward_slots) do
        v:Destroy();
    end;

    p19.Clicked:Destroy();
    p19.Opened:Destroy();
    p19.Frame:Destroy();
end;

function u1._Update(p20) -- Line: 122
    if not p20.Container.Visible then
        return;
    end;

    p20.Frame.Size = UDim2.new(1, 0, 0, p20.Layout.AbsoluteContentSize.Y + p20.Frame.AbsoluteSize.X * 0.05);
end;

function u1._Setup(p21) -- Line: 130
    p21.Title.Text = p21._title or "";
    p21.Icon.Image = p21._icon or "";
    p21.Frame.Visible = false;
end;

function u1._Init(u22) -- Line: 136
    -- upvalues: ButtonEffect (copy)
    u22.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 137
        -- upvalues: u22 (copy)
        u22:_Update();
    end);
    u22.Container:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 141
        -- upvalues: u22 (copy)
        u22:_Update();
    end);
    u22.CloseButton.MouseButton1Click:Connect(function() -- Line: 145
        -- upvalues: u22 (copy)
        u22.Clicked:Fire();
    end);
    u22:_Setup();
    u22:_Update();
    ButtonEffect:Add(u22.CloseButton, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

return u1;