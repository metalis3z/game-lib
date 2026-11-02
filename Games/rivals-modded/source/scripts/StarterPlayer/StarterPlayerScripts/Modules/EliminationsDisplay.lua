-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local TeammateSlot = require(Players.LocalPlayer.PlayerScripts.Modules.TeammateSlot);
local EliminationBoardSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EliminationBoardSlot");
local EliminationBoardGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EliminationBoardGui");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 14
    -- upvalues: u1 (copy), EliminationBoardGui (copy)
    local v3 = setmetatable({}, u1);
    v3.Part = p2;
    v3.SurfaceGui = EliminationBoardGui:Clone();
    v3._slots = {};
    v3._layout_order = 0;
    v3:_Init();

    return v3;
end;

function u1.NewElimination(p4, p5, p6, p7, p8, p9) -- Line: 32
    -- upvalues: EliminationBoardSlot (copy), ItemLibrary (copy), TeammateSlot (copy)
    p4._layout_order = p4._layout_order - 1;
    local v10 = EliminationBoardSlot:Clone();
    v10.Weapon.Image = ItemLibrary.Items[p9] and ItemLibrary.Items[p9].Image or "";
    v10.LayoutOrder = p4._layout_order;
    local v11 = p5.Character and p5.Character:FindFirstChild("Humanoid");
    TeammateSlot.new(p5.UserId, p6, not v11 and 0 or v11.Health / v11.MaxHealth).SlotFrame.Parent = v10.Eliminator;
    local v12 = p7.Character and p7.Character:FindFirstChild("Humanoid");
    TeammateSlot.new(p7.UserId, p6, not v12 and 0 or v12.Health / v12.MaxHealth).SlotFrame.Parent = v10.Victim;
    v10.Parent = p4.SurfaceGui.List.Container;
    table.insert(p4._slots, 1, v10);
    local table_remove_ret = table.remove(p4._slots, 31);

    if table_remove_ret then
        table_remove_ret:Destroy();
    end;
end;

function u1._Setup(p13) -- Line: 61
    -- upvalues: Players (copy)
    p13.SurfaceGui.Adornee = p13.Part;
    p13.SurfaceGui.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u14) -- Line: 66
    u14.SurfaceGui.List.Container.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 67
        -- upvalues: u14 (copy)
        u14.SurfaceGui.List.CanvasSize = UDim2.new(0, 0, 0, u14.SurfaceGui.List.Container.Layout.AbsoluteContentSize.Y);
    end);
    u14:_Setup();
end;

return u1;