-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local u2 = setmetatable({}, Emote);
u2.__index = u2;

function u2.new(...) -- Line: 17
    -- upvalues: Emote (copy), u2 (copy)
    local v3 = Emote.new(nil, script.Name, ...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayClient(p5, ...) -- Line: 29
    -- upvalues: Emote (copy), Players (copy), Utility (copy), u1 (copy)
    Emote.PlayClient(p5, ...);
    p5:_PlayAnimation("rbxassetid://110098633210491", "rbxassetid://125433333048429", 4.85);
    local v6 = p5._humanoid and p5._humanoid.Parent and Players:GetPlayerFromCharacter(p5._humanoid.Parent) or Players.LocalPlayer;
    local v7;

    if v6 then
        v7 = v6:GetAttribute("StatisticDuelsWinStreak");
    else
        v7 = v6;
    end;

    local v8;

    if v6 then
        v8 = v6:GetAttribute("Level");
    else
        v8 = v6;
    end;

    local v9;

    if v6 then
        v9 = v6:GetAttribute("DisplayELO");
    else
        v9 = v6;
    end;

    if v6 then
        v6 = v6.UserId;
    end;

    local v10 = p5:_SetupMultipleProps(script.FlexProp);
    v10.Pillow1.Attachment.BillboardGui.Streak.Value.Text = Utility:PrettyNumber(v7 or 0);
    v10.Pillow2.Attachment.BillboardGui.Level.Title.Text = Utility:PrettyNumber(v8 or 1);
    u1.new(v9, v6):SetParent(v10.Pillow3.Attachment.BillboardGui.Rank);
    p5:CreateSound("rbxassetid://97330697628857", 0.75, 1, nil, true);
end;

function u2._Init(p11) -- Line: 54
end;

return u2;