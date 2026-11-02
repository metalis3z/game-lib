-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local RankIconLabel = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RankIconLabel");
local RankIcon = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RankIcon");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 13
    -- upvalues: u1 (copy), SeasonLibrary (copy), RankIcon (copy)
    local v5 = setmetatable({}, u1);
    v5.ELO = p2;
    v5.UserID = p3;
    v5.ELOLeaderboardRanking = p4 or SeasonLibrary:GetHighestELOLeaderboardRanking(v5.ELO, v5.UserID);
    v5.RankName = SeasonLibrary:GetRank(v5.ELO, v5.UserID, v5.ELOLeaderboardRanking);
    v5.RankInfo = SeasonLibrary.CurrentSeason.RankProfile.Ranks[v5.RankName];
    v5.Frame = RankIcon:Clone();
    v5.Icon = v5.Frame:WaitForChild("Icon");
    v5._destroyed = false;
    v5._label = nil;
    v5._label_text = nil;
    v5:_Init();

    return v5;
end;

function u1.GetLabelText(p6) -- Line: 37
    return p6._label_text;
end;

function u1.GetLabel(p7) -- Line: 41
    return p7._label;
end;

function u1.SetParent(u8, u9) -- Line: 45
    pcall(function() -- Line: 46
        -- upvalues: u8 (copy), u9 (copy)
        u8.Frame.Parent = u9;
    end);
end;

function u1.SetLabel(p10, p11, p12) -- Line: 51
    -- upvalues: RankIconLabel (copy)
    if not p10._label then
        p10._label = RankIconLabel:Clone();
        p10._label.Parent = p10.Frame;
        p10._label_text = p10._label:WaitForChild("Title");
    end;

    p10._label_text.Text = p11 or p10._label_text.Text;
    p10._label_text.TextColor3 = p12 or p10._label_text.TextColor3;
end;

function u1.SetLabelFromELOEvent(p13, p14, p15, p16) -- Line: 62
    -- upvalues: Utility (copy), SeasonLibrary (copy)
    if p14 and math.abs(p14) < 0.001 then
        p14 = math.abs(p14);
    end;

    p13:SetLabel(p14 and string.format("%s%s ", p14 >= 0 and "+" or "", p14) or p15 and Utility:PrettyNumber(p15) or (p16 and p16 .. "/" .. SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels or ""), not p14 and Color3.fromRGB(255, 255, 255) or p14 > 0 and Color3.fromRGB(100, 255, 50) or (p14 < 0 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 215, 0)));
end;

function u1.Destroy(u17) -- Line: 80
    if u17._destroyed then
        return;
    end;

    u17._destroyed = true;
    pcall(function() -- Line: 87
        -- upvalues: u17 (copy)
        u17.Frame:Destroy();
    end);
end;

function u1._Setup(p18) -- Line: 96
    p18.Icon.Image = p18.RankInfo.Image;
end;

function u1._Init(u19) -- Line: 100
    u19.Frame.Destroying:Connect(function() -- Line: 101
        -- upvalues: u19 (copy)
        u19:Destroy();
    end);
    u19:_Setup();
end;

return u1;