-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local ContractsLibrary = require(ReplicatedStorage.Modules.ContractsLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local script_Parent = require(script.Parent);
local u1 = setmetatable({}, script_Parent);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 12
    -- upvalues: script_Parent (copy), u1 (copy), ContractsLibrary (copy), PlayerDataController (copy)
    local v4 = script_Parent.new();
    local v5 = setmetatable(v4, u1);
    v5._statistics_directory_name = p2;
    v5._contract_name = p3;
    v5._contract_info = ContractsLibrary.Contracts[v5._contract_name];
    v5._progress = PlayerDataController:GetDirectoryStatistic(v5._statistics_directory_name, v5._contract_info.Identifier, v5._contract_info.StatisticName, v5._contract_info.ExtraStatisticNames);
    v5:_Init();

    return v5;
end;

function u1._Setup(p6) -- Line: 35
    -- upvalues: StatisticsLibrary (copy)
    local v7 = StatisticsLibrary.Info[p6._contract_info.StatisticName];
    local FullDisplayName = v7.FullDisplayName;

    for _, v in pairs(p6._contract_info.ExtraStatisticNames) do
        FullDisplayName = FullDisplayName .. " + " .. StatisticsLibrary.Info[v].FullDisplayName;
    end;

    p6:SetTitle(FullDisplayName);
    p6:SetImage(v7.Image);
    p6:SetProgress(p6._progress);

    for _, v in pairs(p6._contract_info.Milestones) do
        local table_unpack_ret, v8 = table.unpack(v);
        p6:AddMilestone(table_unpack_ret, v8, v7.TostringFunction);
    end;
end;

function u1._Init(p9) -- Line: 53
    p9:_Setup();
end;

return u1;