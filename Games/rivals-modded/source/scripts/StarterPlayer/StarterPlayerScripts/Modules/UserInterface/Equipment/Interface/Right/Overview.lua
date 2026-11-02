-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local EquipmentMetricCard = require(Players.LocalPlayer.PlayerScripts.Modules.EquipmentMetricCard);
local MetricsGuide = require(script:WaitForChild("MetricsGuide"));
Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EquipmentMetricSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 14
    -- upvalues: u1 (copy), EquipmentMetricCard (copy)
    local v3 = setmetatable({}, u1);
    v3.Right = p2;
    v3.MetricCard = EquipmentMetricCard.new("Overview", "rbxassetid://18404346057");
    v3._set_opened_hash = 0;
    v3._cleanup = {};
    v3._last_weapon_data = nil;
    v3:_Init();

    return v3;
end;

function u1.OnStateChanged(p4) -- Line: 33
    p4:_UpdateInformation();
end;

function u1.OnOpen(p5) -- Line: 37
    p5:_UpdateInformation();
end;

function u1._UpdateInformation(p6) -- Line: 45
    -- upvalues: PlayerDataController (copy), ItemLibrary (copy), MetricsGuide (copy)
    if not p6.Right.Interface.Equipment.IsOpen or p6.Right.Interface.Equipment:IsCustomizing() then
        return;
    end;

    local SelectedWeapon = p6.Right.Interface.Equipment:GetSelectedWeapon();
    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

    if WeaponData == p6._last_weapon_data then
        return;
    end;

    p6.MetricCard:Clear();
    p6._last_weapon_data = WeaponData;

    if not WeaponData then
        return;
    end;

    local v7 = ItemLibrary.Items[SelectedWeapon];

    for _, v in pairs(MetricsGuide) do
        local table_unpack_ret, v8, v9, v10 = table.unpack(v);
        local v11 = nil;

        for _, v2 in pairs(v8) do
            if v7[v2] then
                v11 = v7[v2];
                break;
            end;
        end;

        if v11 or #v8 <= 0 then
            local v12;

            if v9 == "Custom" then
                v12 = v10(SelectedWeapon, v11);
            elseif v9 == "Time" then
                v12 = string.format("%.2f", v11) .. "s";
            elseif v9 == nil then
                v12 = string.format("%.0f", v11);
            else
                v12 = assert(false, table_unpack_ret);
            end;

            if v12 then
                p6.MetricCard:Add(table_unpack_ret, v12);
            end;
        end;
    end;
end;

function u1._Init(u13) -- Line: 94
    -- upvalues: PlayerDataController (copy)
    u13.MetricCard.Clicked:Connect(function() -- Line: 95
        -- upvalues: u13 (copy)
        u13.Right:SetMetricCardVisible("Overview", false);
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 99
        -- upvalues: u13 (copy)
        u13:_UpdateInformation();
    end);
    u13.MetricCard:SetParent(u13.Right.Container);
end;

return u1;