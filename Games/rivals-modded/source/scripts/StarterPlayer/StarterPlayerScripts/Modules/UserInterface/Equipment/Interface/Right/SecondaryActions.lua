-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local EquipmentMetricActionSlot = Players.LocalPlayer.PlayerScripts.UserInterface.EquipmentMetricActionSlot;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Right = p2;
    v3.Frame = v3.Right.Container:WaitForChild("SecondaryActions");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3._last_state = nil;
    v3._metric_action_slots = {};
    v3:_Init();

    return v3;
end;

function u1.SetMetricActionVisible(p4, p5, p6) -- Line: 31
    if not p4._metric_action_slots[p5] then
        return;
    end;

    local v7 = p4._metric_action_slots[p5];

    if p6 then
        p6 = p4:_IsMetricActionVisible(p5);
    end;

    v7.Visible = p6;
    p4:_UpdateVisibility();
end;

function u1.CreateMetricAction(u8, u9, p10, p11, p12) -- Line: 40
    -- upvalues: EquipmentMetricActionSlot (copy), ButtonEffect (copy)
    local v13 = EquipmentMetricActionSlot:Clone();
    v13.Icon.Image = p10;
    v13.Title.Text = p11;
    v13.Description.Text = p12;
    v13.Name = u9;
    v13.Visible = false;
    v13.Parent = u8.Container;
    u8._metric_action_slots[u9] = v13;
    v13.Button.MouseButton1Click:Connect(function() -- Line: 50
        -- upvalues: u8 (copy), u9 (copy)
        u8.Right:SetMetricCardVisible(u9, true);
    end);
    ButtonEffect:Add(v13.Button, nil, {
        HoverRatio = UDim2.new(0, 10, 0, 10),
        ReleaseRatio = UDim2.new(0, 10, 0, 10)
    });
end;

function u1.OnStateChanged(p14) -- Line: 57
    task.defer(p14._UpdateInformation, p14);
end;

function u1.OnOpen(p15) -- Line: 61
    p15:_UpdateInformation(true);
end;

function u1._IsMetricActionVisible(p16, p17) -- Line: 69
    -- upvalues: PlayerDataController (copy)
    local v18 = p16.Right.Interface.Equipment:IsCareerPageOpen();
    PlayerDataController:GetWeaponData((p16.Right.Interface.Equipment:GetSelectedWeapon()));

    return (#p17 < 7 or string.sub(p17, 1, 7) ~= "season_") and true or v18;
end;

function u1._UpdateInformation(p19, p20) -- Line: 78
    -- upvalues: PlayerDataController (copy)
    p19.Right.Interface.Equipment:IsCareerPageOpen();
    PlayerDataController:GetWeaponData((p19.Right.Interface.Equipment:GetSelectedWeapon()));
    local StateID = p19.Right.Interface.Equipment:GetStateID();

    if p20 or StateID ~= p19._last_state then
        p19._last_state = StateID;
        p19.Right:ResetMetricCards();
    end;

    p19:_UpdateVisibility();
end;

function u1._UpdateVisibility(p21) -- Line: 94
    local v22 = false;

    for _, v in pairs(p21._metric_action_slots) do
        v22 = v22 or v.Visible;
    end;

    p21.Frame.Visible = v22;
end;

function u1._UpdateSize(p23) -- Line: 105
    p23.Frame.Size = UDim2.new(1, 0, 0, p23.Layout.AbsoluteContentSize.Y);
end;

function u1._Init(u24) -- Line: 109
    -- upvalues: PlayerDataController (copy)
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 110
        -- upvalues: u24 (copy)
        u24:_UpdateSize();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 114
        -- upvalues: u24 (copy)
        u24:_UpdateInformation();
    end);
    u24:_UpdateSize();
    u24:_UpdateVisibility();
end;

return u1;