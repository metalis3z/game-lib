-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local BaseContractSlot = require(Players.LocalPlayer.PlayerScripts.Modules.BaseContractSlot);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 14
    -- upvalues: u1 (copy), BaseContractSlot (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3._base_contract_slot = BaseContractSlot.new();
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 30
    p4:_Update();
end;

function u1.Close(p5) -- Line: 34
end;

function u1._Update(p6) -- Line: 42
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy)
    local v7 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v7 then
        v7 = v7.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    local v8;

    if v7 then
        v8 = v7.CurrentELO ~= nil;
    else
        v8 = v7;
    end;

    p6._base_contract_slot.Frame.Visible = v8;

    if not p6._base_contract_slot.Frame.Visible then
        return;
    end;

    p6._base_contract_slot:SetProgress(v7.DuelsWon * SeasonLibrary.CurrentSeason.ParticipationPointsPerWin + v7.DuelsLost * SeasonLibrary.CurrentSeason.ParticipationPointsPerLoss);
end;

function u1._Setup(p9) -- Line: 58
    -- upvalues: SeasonLibrary (copy)
    local ParticipationPointsPerWin = SeasonLibrary.CurrentSeason.ParticipationPointsPerWin;
    local ParticipationPointsPerLoss = SeasonLibrary.CurrentSeason.ParticipationPointsPerLoss;
    local string_format_ret = string.format("Earn %s point%s from every ranked win", ParticipationPointsPerWin, ParticipationPointsPerWin == 1 and "" or "s");
    local string_format_ret2 = string.format("Earn %s point%s from every ranked loss", ParticipationPointsPerLoss, ParticipationPointsPerLoss == 1 and "" or "s");

    if ParticipationPointsPerWin > 0 and ParticipationPointsPerLoss > 0 then
        string_format_ret = string_format_ret .. " • " .. string_format_ret2;
    elseif ParticipationPointsPerWin <= 0 then
        string_format_ret = ParticipationPointsPerLoss <= 0 and "???" or string_format_ret2;
    end;

    local v10 = string_format_ret .. "   •   Only available during Season " .. SeasonLibrary.CurrentSeason.Version;
    p9._base_contract_slot:SetImage("rbxassetid://117835427046796");
    p9._base_contract_slot:SetTitle("Ranked Contract");
    p9._base_contract_slot:SetDescription(v10);
    p9._base_contract_slot:SetScale(0.75);

    for _, v in pairs(SeasonLibrary.CurrentSeason.ParticipationPrizes) do
        local table_unpack_ret, v11 = table.unpack(v);
        p9._base_contract_slot:AddMilestone(table_unpack_ret, v11);
    end;

    p9._base_contract_slot.Frame.LayoutOrder = 30;
    p9._base_contract_slot.Frame.Parent = p9.Page.Container;
end;

function u1._Init(p12) -- Line: 83
    p12:_Setup();
end;

return u1;