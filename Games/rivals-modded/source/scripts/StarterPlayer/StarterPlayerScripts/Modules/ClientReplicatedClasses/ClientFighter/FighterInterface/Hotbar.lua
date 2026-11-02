-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local HotbarSlot = require(script:WaitForChild("HotbarSlot"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.Clicked = Signal.new();
    v3.FighterInterface = p2;
    v3.Frame = v3.FighterInterface.BottomRight.Container:WaitForChild("Hotbar");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.EquippedDisplayFrame = v3.Container:WaitForChild("EquippedDisplay");
    v3._hotbar_slots = {};
    v3:_Init();

    return v3;
end;

function u1.UpdateParent(u4) -- Line: 33
    -- upvalues: PlayerDataController (copy)
    task.defer(pcall, function() -- Line: 34
        -- upvalues: PlayerDataController (ref), u4 (copy)
        local v5 = PlayerDataController:GetSetting("Hotbar Display") == "Bottom Center";
        local v6 = PlayerDataController:GetSetting("Hotbar Display") == "Bottom Left";
        u4.EquippedDisplayFrame.LayoutOrder = v6 and 100000000 or -1;
        u4.Layout.HorizontalAlignment = v5 and Enum.HorizontalAlignment.Center or (v6 and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right);
        u4.Frame.Parent = v5 and u4.FighterInterface.BottomCenter.Container or (v6 and u4.FighterInterface.BottomLeft.Container or u4.FighterInterface.BottomRight.Container);
    end);
end;

function u1.EquipEffect(p7, p8, ...) -- Line: 48
    local v9 = p7._hotbar_slots[p8];

    if v9 then
        return v9:EquipEffect(...);
    end;
end;

function u1.RollEffect(p10, p11, ...) -- Line: 58
    local v12 = p10._hotbar_slots[p11];

    if v12 then
        return v12:RollEffect(...);
    end;
end;

function u1.CooldownEffect(p13, p14, ...) -- Line: 68
    local v15 = p13._hotbar_slots[p14];

    if v15 then
        return v15:CooldownEffect(...);
    end;
end;

function u1.UpdateAmmo(p16, ...) -- Line: 78
    for _, v in pairs(p16._hotbar_slots) do
        v:UpdateAmmo(...);
    end;
end;

function u1.UpdateVisuals(p17, ...) -- Line: 84
    for _, v in pairs(p17._hotbar_slots) do
        v:UpdateVisuals(...);
    end;
end;

function u1.UpdateVisibility(p18, ...) -- Line: 90
    -- upvalues: PlayerDataController (copy)
    p18.EquippedDisplayFrame.Visible = PlayerDataController:GetSetting("Equipped Weapon Display") == "Legacy";
    local Visible = p18.EquippedDisplayFrame.Visible;

    for _, v in pairs(p18._hotbar_slots) do
        v:UpdateVisibility(...);
        Visible = Visible or v.Frame.Visible;
    end;

    local Frame = p18.Frame;

    if Visible then
        Visible = PlayerDataController:GetSetting("Hotbar Display") ~= "Disabled";
    end;

    Frame.Visible = Visible;
end;

function u1.ItemRemoved(p19, p20, p21) -- Line: 103
    local v22 = p19._hotbar_slots[p20];

    if not v22 then
        return;
    end;

    v22:Destroy();
    p19._hotbar_slots[p20] = nil;
    p19:_UpdateSize();
    p19:UpdateVisibility();

    if not p21 then
        p19:UpdateLayouts();
    end;
end;

function u1.ItemAdded(u23, p24, p25) -- Line: 120
    -- upvalues: HotbarSlot (copy)
    u23:ItemRemoved(p24, p25);
    local u26 = HotbarSlot.new(u23, p24);
    u26.Frame.Parent = u23.Container;
    u23._hotbar_slots[p24] = u26;
    u26.Clicked:Connect(function(...) -- Line: 127
        -- upvalues: u23 (copy), u26 (copy)
        u23.Clicked:Fire(u26, ...);
    end);
    u26.CooldownsChanged:Connect(function() -- Line: 131
        -- upvalues: u23 (copy)
        u23:_UpdateSize();
    end);
    u23:_UpdateSize();
    u23:UpdateVisibility();

    if not p25 then
        u23:UpdateLayouts();
    end;
end;

function u1.UpdateLayouts(p27) -- Line: 143
    for i, v in pairs(p27.FighterInterface.ClientFighter.Items) do
        local v28 = p27._hotbar_slots[v];

        if v28 then
            v28.Frame.LayoutOrder = i;
        end;
    end;
end;

function u1.Update(p29, p30, p31) -- Line: 155
    for _, v in pairs(p29._hotbar_slots) do
        v:Update(p30, p31);
    end;
end;

function u1.Destroy(p32) -- Line: 161
    p32.Clicked:Destroy();

    for _, v in pairs(p32._hotbar_slots) do
        v:Destroy();
    end;
end;

function u1._UpdateSize(p33) -- Line: 173
    local v34 = 0;

    for _, v in pairs(p33._hotbar_slots) do
        v34 = math.max(v34, v:GetNumCooldownsActive());
    end;

    p33.Frame.Size = UDim2.new(0.275, 0, v34 * 0.05 + 0.275, 0);
end;

function u1._Init(p35) -- Line: 183
    for _, v in pairs(p35.FighterInterface.ClientFighter.Items) do
        p35:ItemAdded(v, true);
    end;

    p35:_UpdateSize();
    p35:UpdateLayouts();
    p35:UpdateParent();
    p35:UpdateVisibility();
end;

return u1;