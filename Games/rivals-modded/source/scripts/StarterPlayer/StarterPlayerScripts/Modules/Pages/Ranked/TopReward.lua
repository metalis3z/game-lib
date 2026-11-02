-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules.RankIcon);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("TopReward");
    v3.RankContainer = v3.Frame:WaitForChild("RankContainer");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.Title = v3.Frame:WaitForChild("Title");
    v3.Description = v3.Frame:WaitForChild("Description");
    v3.Description2 = v3.Frame:WaitForChild("Description2");
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 33
    p4:_Update();
end;

function u1.Close(p5) -- Line: 37
end;

function u1._GetTopRankDetails(p6) -- Line: 45
    -- upvalues: SeasonLibrary (copy)
    local Rank = SeasonLibrary:GetRank((1 / 0), nil, SeasonLibrary.CurrentSeason.TopPlayerLeaderboardRank);

    return Rank, SeasonLibrary.CurrentSeason.RankProfile.Ranks[Rank].RequiredELO;
end;

function u1._Update(p7) -- Line: 52
    -- upvalues: SeasonLibrary (copy), PlayerDataController (copy)
    if not SeasonLibrary.CurrentSeason.TopPlayerRewardSkinName then
        p7.Frame.Visible = false;

        return;
    end;

    local v8 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v8 then
        v8 = v8.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    if v8 then
        v8 = v8.CurrentELO;
    end;

    local _, v9 = p7:_GetTopRankDetails();

    if v8 then
        v8 = v9 <= v8;
    end;

    p7.Frame.Visible = v8;
end;

function u1._Setup(p10) -- Line: 66
    -- upvalues: SeasonLibrary (copy), CosmeticLibrary (copy), RankIcon (copy), RewardSlot (copy)
    local v11, _ = p10:_GetTopRankDetails();
    local TopPlayerRewardSkinName = SeasonLibrary.CurrentSeason.TopPlayerRewardSkinName;

    if not TopPlayerRewardSkinName then
        return;
    end;

    local v12 = CosmeticLibrary.Cosmetics[TopPlayerRewardSkinName];
    p10.Title.Text = TopPlayerRewardSkinName;
    p10.Description.Text = string.format("Become %s by reaching top %s on the Ranked Leaderboard!", v11, SeasonLibrary.CurrentSeason.TopPlayerLeaderboardRank);
    p10.Description2.Text = string.format("The %s %s skin will be rewarded to %s players at season end!", v12.Rarity, TopPlayerRewardSkinName, v11);
    RankIcon.new((1 / 0), nil, SeasonLibrary.CurrentSeason.TopPlayerLeaderboardRank):SetParent(p10.RankContainer);
    RewardSlot.new({
        Name = TopPlayerRewardSkinName,
        Weapon = v12.ItemName
    }):SetParent(p10.Container);
end;

function u1._Init(p13) -- Line: 83
    p13:_Setup();
end;

return u1;