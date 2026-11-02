-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ContractsLibrary = require(ReplicatedStorage.Modules.ContractsLibrary);
require(ReplicatedStorage.Modules.ItemLibrary);
local ContractSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseContractSlot"):WaitForChild("ContractSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local ContractDivider = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ContractDivider");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 15
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3._weapon_name = nil;
    v3._contract_slots = {};
    v3:_Init();

    return v3;
end;

function u1.SetWeapon(p4, p5) -- Line: 35
    p4._weapon_name = p5;
    p4:_Update();
end;

function u1._Update(p6) -- Line: 44
    -- upvalues: ContractsLibrary (copy), ContractDivider (copy), ContractSlot (copy)
    for _, v in pairs(p6._contract_slots) do
        v:Destroy();
    end;

    p6._contract_slots = {};

    if not p6._weapon_name then
        return;
    end;

    local v7 = 0;

    for i, v in pairs(ContractsLibrary:GetWeaponContracts(p6._weapon_name)) do
        if i > 1 then
            local v8 = ContractDivider:Clone();
            v8.LayoutOrder = v7;
            v8.Parent = p6.Container;
            table.insert(p6._contract_slots, v8);
            v7 = v7 + 1;
        end;

        local WeaponStatistics = ContractSlot.new("WeaponStatistics", v);
        WeaponStatistics.Frame.LayoutOrder = v7;
        WeaponStatistics.Frame.Parent = p6.Container;
        table.insert(p6._contract_slots, WeaponStatistics);
        v7 = v7 + 1;
    end;
end;

function u1._Init(u9) -- Line: 74
    -- upvalues: ButtonEffect (copy)
    u9.CloseButton.MouseButton1Click:Connect(function() -- Line: 75
        -- upvalues: u9 (copy)
        u9:CloseRequest();
    end);
    u9.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 79
        -- upvalues: u9 (copy)
        u9.List.CanvasSize = UDim2.new(0, 0, 0, u9.Layout.AbsoluteContentSize.Y);
    end);
    u9:_Update();
    ButtonEffect:Add(u9.CloseButton);
end;

return u1._new();