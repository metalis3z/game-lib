-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local EquipmentMetricCard = require(Players.LocalPlayer.PlayerScripts.Modules.EquipmentMetricCard);
local StatisticsList = require(Players.LocalPlayer.PlayerScripts.Modules.StatisticsList);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy), EquipmentMetricCard (copy), StatisticsList (copy)
    local v3 = setmetatable({}, u1);
    v3.Right = p2;
    v3.MetricCard = EquipmentMetricCard.new("Statistics", "rbxassetid://17336063541");
    v3.StatisticsList = StatisticsList.new(v3.MetricCard.Container, 1, true);
    v3:_Init();

    return v3;
end;

function u1.OnStateChanged(p4) -- Line: 26
    p4:_UpdateInformation();
end;

function u1.OnOpen(p5) -- Line: 30
    p5:_UpdateInformation();
end;

function u1._UpdateInformation(p6) -- Line: 38
    -- upvalues: PlayerDataController (copy)
    if not p6.Right.Interface.Equipment.IsOpen or p6.Right.Interface.Equipment:IsCustomizing() then
        p6.StatisticsList:Clear();

        return;
    end;

    local v7 = p6.Right.Interface.Equipment:IsCareerPageOpen();
    local SelectedWeapon = p6.Right.Interface.Equipment:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

    if v7 then
        p6.StatisticsList:Generate(true, nil, nil);

        return;
    end;

    if WeaponData then
        p6.StatisticsList:Generate(false, "WeaponStatistics", SelectedWeapon);

        return;
    end;

    p6.StatisticsList:Clear();
end;

function u1._Init(u8) -- Line: 57
    -- upvalues: PlayerDataController (copy)
    u8.MetricCard.Clicked:Connect(function() -- Line: 58
        -- upvalues: u8 (copy)
        u8.Right:SetMetricCardVisible("Performance", false);
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 62
        -- upvalues: u8 (copy)
        u8:_UpdateInformation();
    end);
    u8.MetricCard:SetParent(u8.Right.Container);
end;

return u1;