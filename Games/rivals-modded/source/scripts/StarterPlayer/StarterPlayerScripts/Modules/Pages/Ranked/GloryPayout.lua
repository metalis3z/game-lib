-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 15
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("GloryPayout");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Description = v3.Frame:WaitForChild("Description");
    v3.Description2 = v3.Frame:WaitForChild("Description2");
    v3._reward_slot = nil;
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 35
    p4:_Update();
end;

function u1.Close(p5) -- Line: 39
end;

function u1._Update(p6) -- Line: 47
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), Utility (copy), RewardSlot (copy)
    if p6._reward_slot then
        p6._reward_slot:Destroy();
        p6._reward_slot = nil;
    end;

    local v7 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];
    local v8;

    if v7 then
        v8 = v7.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    else
        v8 = v7;
    end;

    local v9;

    if v8 then
        v9 = v8.CurrentELO ~= nil;
    else
        v9 = v8;
    end;

    p6.Frame.Visible = v9;

    if not p6.Frame.Visible then
        return;
    end;

    local GloryPayout = SeasonLibrary:GetGloryPayout(SeasonLibrary.CurrentSeason.Name, v7);
    p6.Description.Text = string.format("You\'ll receive <font transparency=\"0\" weight=\"900\">%s Glory</font> when this season ends!", GloryPayout);
    p6.Description2.Text = string.format("Based on your total ranked wins (<font transparency=\"0\" weight=\"900\">%s</font> / %s) and your final ELO (<font transparency=\"0\" weight=\"900\">%s</font> / %s)", Utility:PrettyNumber((math.min(v8.DuelsWon, SeasonLibrary.CurrentSeason.GloryPayoutMaxWins))), Utility:PrettyNumber(SeasonLibrary.CurrentSeason.GloryPayoutMaxWins), Utility:PrettyNumber((math.min(v8.CurrentELO, SeasonLibrary.CurrentSeason.GloryPayoutMaxELO))), Utility:PrettyNumber(SeasonLibrary.CurrentSeason.GloryPayoutMaxELO));
    p6._reward_slot = RewardSlot.new({
        Name = "Glory",
        Quantity = GloryPayout
    });
    p6._reward_slot:SetParent(p6.Container);
end;

function u1._Init(p10) -- Line: 78
end;

return u1;