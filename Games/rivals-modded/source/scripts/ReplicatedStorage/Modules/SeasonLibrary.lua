-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local v1 = { { "ranked_1v1", "ranked" }, { "ranked_2v2", "ranked" }, { "ranked_3v3", "ranked" } };
local v2 = { { 1000, {
            Name = "Phoenix Rifle",
            Weapon = "Assault Rifle"
        } } };
local v3 = { { 50, {
            Name = "Mini Unstable Portal",
            Weapon = "IsUniversal"
        } }, { 100, {
            Name = "Glory",
            Quantity = 100
        } }, { 200, {
            Name = "Spiral",
            Weapon = "IsUniversal"
        } }, { 300, {
            Name = "Glory",
            Quantity = 150
        } }, { 500, {
            Name = "Warped Away",
            Weapon = "IsUniversal"
        } }, { 750, {
            Name = "Glory",
            Quantity = 250
        } }, { 1000, {
            Name = "Warp Handgun",
            Weapon = "Handgun"
        } } };
local v4 = { { 50, {
            Name = "Snowman",
            Weapon = "IsUniversal"
        } }, { 100, {
            Name = "Glory",
            Quantity = 100
        } }, { 200, {
            Name = "Tusky",
            Weapon = "IsUniversal"
        } }, { 300, {
            Name = "Glory",
            Quantity = 150
        } }, { 500, {
            Name = "Northern Light Show",
            Weapon = "IsUniversal"
        } }, { 750, {
            Name = "Glory",
            Quantity = 250
        } }, { 1000, {
            Name = "Frozen Grenade",
            Weapon = "Grenade"
        } } };
local v5 = { { 50, {
            Name = "Horseshoe",
            Weapon = "IsUniversal"
        } }, { 100, {
            Name = "Glory",
            Quantity = 50
        } }, { 200, {
            Name = "Mesa",
            Weapon = "IsUniversal"
        } }, { 300, {
            Name = "Glory",
            Quantity = 100
        } }, { 400, {
            Name = "Paparazzi Flash",
            Weapon = "IsUniversal"
        } }, { 500, {
            Name = "Glory",
            Quantity = 150
        } }, { 600, {
            Name = "Standoff"
        } }, { 750, {
            Name = "Glory",
            Quantity = 200
        } }, { 1000, {
            Name = "Spy Gloves",
            Weapon = "Fists"
        } } };
local u9 = {
    UNIVERSAL_ELO_NAME = "ranked",
    PASS_TRACK_IMAGES = { "rbxassetid://81577092220450", "rbxassetid://74965952714478" },
    SEASON_PASS_LEVELS_IN_SEASON_BUNDLE = 20,
    PASS_XP_PER_LEVEL_VISUAL = 10,
    Seasons = {},
    SeasonsByVersion = {},
    CurrentSeason = nil,
    RankProfiles = {},

    IsRankedQueue = function(p6, p7, p8) -- Line: 61, Name: IsRankedQueue
        for _, v in pairs(p6.Seasons[p8 or p6.CurrentSeason.Name].RankedQueues) do
            if v[1] == p7 then
                return v[2];
            end;
        end;
    end
};

function u9.GetCurrentSeasonWeek(p10) -- Line: 71
    -- upvalues: ServerOsTime (copy), u9 (copy)
    local v11 = (ServerOsTime:Get() - u9.CurrentSeason.StartTime) / 604800;

    return math.ceil(v11);
end;

function u9.GetTimeUntilNextSeasonWeek(p12) -- Line: 75
    -- upvalues: ServerOsTime (copy), u9 (copy)
    local v13 = (ServerOsTime:Get() - u9.CurrentSeason.StartTime) / 604800;

    return math.ceil(v13) * 7 * 24 * 60 * 60 + u9.CurrentSeason.StartTime - ServerOsTime:Get();
end;

function u9.GetHighestELOLeaderboardRanking(p14, p15, p16) -- Line: 79
    -- upvalues: CONSTANTS (copy), ServerStorage (copy), Players (copy)
    local v17;

    if CONSTANTS.IS_SERVER then
        v17 = require(ServerStorage.Services.LeaderboardService);
    else
        v17 = require(Players.LocalPlayer.PlayerScripts.Controllers.LeaderboardController);
    end;

    if p16 then
        return v17:GetRankingByUserID("Highest ELO", p16);
    end;

    if p15 then
        return v17:GetRankingByValue("Highest ELO", p15);
    end;
end;

function u9.GetRank(p18, p19, p20, p21, p22) -- Line: 89
    if not p19 then
        return "Unranked";
    end;

    local v23 = p18.RankProfiles[p22 or p18.CurrentSeason.RankProfile.Name];
    assert(v23 ~= nil);
    local v24 = nil;

    for i, v in pairs(v23.RanksOrder) do
        local v25 = v23.Ranks[v];

        if p19 < v25.RequiredELO and not v25.RequiredELOLeaderboardRanking then
            v24 = i - 1;
            break;
        end;
    end;

    if not v24 then
        local v26 = p21 or p18:GetHighestELOLeaderboardRanking(p19, p20);

        for i = #v23.RanksOrder, 1, -1 do
            local v27 = v23.Ranks[v23.RanksOrder[i]];

            if not (v27.RequiredELOLeaderboardRanking and (v27.RequiredELO > p19 or (v26 or (1 / 0)) > v27.RequiredELOLeaderboardRanking)) then
                v24 = i;
                break;
            end;

            local _ = i;
        end;
    end;

    return v23.RanksOrder[math.clamp(v24, 1, #v23.RanksOrder)];
end;

function u9.GetGloryPayout(p28, p29, p30) -- Line: 129
    local v31 = p28.Seasons[p29];
    local v32 = 0;
    local v33 = 0;

    for _, v in pairs(p30.RankedPerformances or {}) do
        v32 = v32 + 1;

        if v.CurrentELO then
            local v34 = v31.GloryPayoutWinsInfluence * math.clamp(v.DuelsWon / v31.GloryPayoutMaxWins, 0, 1);
            local v35 = v31.GloryPayoutELOInfluence * math.clamp(v.CurrentELO / v31.GloryPayoutMaxELO, 0, 1);
            v33 = v33 + v31.MaxGloryPayout * (v35 + v34);
        end;
    end;

    if v32 <= 0 then
        return 0;
    end;

    local math_floor_ret = math.floor(v33 / v32);
    local math_sign_ret = math.sign(v33);
    local math_max_ret = math.max(math_sign_ret, math_floor_ret);

    return math.clamp(math_max_ret, 0, v31.MaxGloryPayout);
end;

function u9.GetRewardSeasonPassPosition(p36, p37) -- Line: 160
    -- upvalues: u9 (copy)
    for i = 1, u9.CurrentSeason.NumBattlePassTiers do
        local v38 = i;

        for i2 = 1, u9.CurrentSeason.NumBattlePassTracks do
            local v39 = u9.CurrentSeason.BattlePassRewards[v38] and u9.CurrentSeason.BattlePassRewards[v38][i2];

            if v39 and v39.Name == p37 then
                return v38, i2;
            end;

            local _ = i2;
        end;
    end;
end;

function u9.FormatSeasonRankCharm(p40, p41, p42, p43, p44) -- Line: 172
    -- upvalues: u9 (copy)
    assert(p42);
    local v45 = p44 and ("#" .. p44 or "") or "";
    local Rank = u9:GetRank(p43, nil, p44 or (1 / 0), p40.Seasons[p42].RankProfile.Name);

    for _, descendant in pairs(p41:GetDescendants()) do
        if descendant:HasTag("CharmLeaderboardRank") then
            descendant.Text = v45;
        end;
    end;

    if p41:FindFirstChild("Extra") then
        for _, child in pairs(p41.Extra:GetChildren()) do
            if child.Name ~= Rank then
                task.defer(child.Destroy, child);
            end;
        end;
    end;
end;

(function(p46, p47, p48, p49) -- Line: 193, Name: add_rank_profile
    -- upvalues: u9 (copy)
    u9.RankProfiles[p46] = {
        LowestRankELO = (1 / 0),
        HighestRankELO = (-1 / 0),
        Name = p46,
        NumPlacementDuels = p47,
        PlacementELOMin = p48,
        PlacementELOMax = p49,
        Ranks = {},
        RanksOrder = {},
        Groups = {},
        GroupsOrder = {}
    };
end)("ranks_version1", 10, 100, 2500);

local function add_rank_group(p50, p51, p52, p53, p54) -- Line: 214
    -- upvalues: u9 (copy)
    local v55 = {
        Name = p51,
        Color = p52,
        Image = p53,
        SecondaryColor = p54 or Color3.fromRGB(0, 0, 0),
        Ranks = {}
    };
    u9.RankProfiles[p50].Groups[p51] = v55;
    table.insert(u9.RankProfiles[p50].GroupsOrder, p51);
end;

add_rank_group("ranks_version1", "Unranked", Color3.fromRGB(255, 255, 255), "rbxassetid://111599878354131");
add_rank_group("ranks_version1", "Bronze", Color3.fromRGB(184, 117, 69), "rbxassetid://73543520622815");
add_rank_group("ranks_version1", "Silver", Color3.fromRGB(200, 200, 200), "rbxassetid://107898816876115");
add_rank_group("ranks_version1", "Gold", Color3.fromRGB(255, 215, 0), "rbxassetid://90039594400813");
add_rank_group("ranks_version1", "Platinum", Color3.fromRGB(65, 255, 248), "rbxassetid://73345783863790");
add_rank_group("ranks_version1", "Diamond", Color3.fromRGB(50, 159, 255), "rbxassetid://112183171942172");
add_rank_group("ranks_version1", "Onyx", Color3.fromRGB(255, 114, 0), "rbxassetid://127982903682334");
add_rank_group("ranks_version1", "Nemesis", Color3.fromRGB(191, 0, 255), "rbxassetid://116941545385923");
add_rank_group("ranks_version1", "Archnemesis", Color3.fromRGB(0, 0, 0), "rbxassetid://133793956251748", Color3.fromRGB(31, 81, 78));

local function add_rank(p56, p57, p58, p59, p60, p61, p62) -- Line: 239
    -- upvalues: u9 (copy)
    local v63 = u9.RankProfiles[p56];
    local v64 = {
        RankGroupName = p57,
        DisplayName = p58,
        RequiredELO = p59,
        RequiredELOLeaderboardRanking = p62,
        Image = p60
    };
    v63.Ranks[p58] = v64;
    table.insert(v63.RanksOrder, p58);

    if not p61 then
        v63.LowestRankELO = math.min(v63.LowestRankELO, v64.RequiredELO);
        v63.HighestRankELO = math.max(v63.HighestRankELO, v64.RequiredELO);
    end;

    if v64.RankGroupName then
        table.insert(v63.Groups[v64.RankGroupName].Ranks, p58);
    end;
end;

local ranks_version1 = u9.RankProfiles.ranks_version1;
local v65 = {
    RankGroupName = "Unranked",
    DisplayName = "Unranked",
    RequiredELO = -1,
    RequiredELOLeaderboardRanking = nil,
    Image = "rbxassetid://111599878354131"
};
ranks_version1.Ranks.Unranked = v65;
table.insert(ranks_version1.RanksOrder, "Unranked");

if v65.RankGroupName then
    table.insert(ranks_version1.Groups[v65.RankGroupName].Ranks, "Unranked");
end;

add_rank("ranks_version1", "Bronze", "Bronze 1", 0, "rbxassetid://106623367501544");
add_rank("ranks_version1", "Bronze", "Bronze 2", 200, "rbxassetid://131795064007344");
add_rank("ranks_version1", "Bronze", "Bronze 3", 400, "rbxassetid://73543520622815");
add_rank("ranks_version1", "Silver", "Silver 1", 600, "rbxassetid://80716950169934");
add_rank("ranks_version1", "Silver", "Silver 2", 800, "rbxassetid://136100661820261");
add_rank("ranks_version1", "Silver", "Silver 3", 1000, "rbxassetid://107898816876115");
add_rank("ranks_version1", "Gold", "Gold 1", 1200, "rbxassetid://134520747948636");
add_rank("ranks_version1", "Gold", "Gold 2", 1400, "rbxassetid://114166096331502");
add_rank("ranks_version1", "Gold", "Gold 3", 1600, "rbxassetid://90039594400813");
add_rank("ranks_version1", "Platinum", "Platinum 1", 1800, "rbxassetid://133903971285645");
add_rank("ranks_version1", "Platinum", "Platinum 2", 2000, "rbxassetid://82834564754747");
add_rank("ranks_version1", "Platinum", "Platinum 3", 2200, "rbxassetid://73345783863790");
add_rank("ranks_version1", "Diamond", "Diamond 1", 2400, "rbxassetid://113997689031026");
add_rank("ranks_version1", "Diamond", "Diamond 2", 2600, "rbxassetid://88059506918419");
add_rank("ranks_version1", "Diamond", "Diamond 3", 2800, "rbxassetid://112183171942172");
add_rank("ranks_version1", "Onyx", "Onyx 1", 3000, "rbxassetid://104871954739030");
add_rank("ranks_version1", "Onyx", "Onyx 2", 3200, "rbxassetid://109012386782238");
add_rank("ranks_version1", "Onyx", "Onyx 3", 3400, "rbxassetid://127982903682334");
local ranks_version12 = u9.RankProfiles.ranks_version1;
local v66 = {
    RankGroupName = "Nemesis",
    DisplayName = "Nemesis",
    RequiredELO = 3600,
    RequiredELOLeaderboardRanking = nil,
    Image = "rbxassetid://116941545385923"
};
ranks_version12.Ranks.Nemesis = v66;
table.insert(ranks_version12.RanksOrder, "Nemesis");

if v66.RankGroupName then
    table.insert(ranks_version12.Groups[v66.RankGroupName].Ranks, "Nemesis");
end;

local ranks_version13 = u9.RankProfiles.ranks_version1;
local v67 = {
    RankGroupName = "Archnemesis",
    DisplayName = "Archnemesis",
    RequiredELO = 3600,
    RequiredELOLeaderboardRanking = 200,
    Image = "rbxassetid://133793956251748"
};
ranks_version13.Ranks.Archnemesis = v67;
table.insert(ranks_version13.RanksOrder, "Archnemesis");

if v67.RankGroupName then
    table.insert(ranks_version13.Groups[v67.RankGroupName].Ranks, "Archnemesis");
end;

local function add_season(p68, p69, p70, p71, p72) -- Line: 284
    -- upvalues: ServerOsTime (copy), u9 (copy)
    local v73 = {
        ResetCounter = p69,
        Name = p70,
        Version = p71
    };

    if ServerOsTime:Get() < p72 then
        p72 = p72 - 604800;
    end;

    v73.StartTime = p72;
    v73.RankProfile = nil;
    v73.RankedQueues = nil;
    v73.BypassTrustworthySpendRequirement = nil;
    v73.AccountAgeRequirement = nil;
    v73.LevelRequirement = nil;
    v73.MaximumPartyELODifference = nil;
    v73.DailyELOShields = nil;
    v73.ELOShieldMaxELOAllowed = nil;
    v73.ELODecayThreshold = nil;
    v73.ELODecayPerInactiveDay = nil;
    v73.ELODecayInactivePeriodDays = nil;
    v73.ParticipationPrizes = nil;
    v73.ParticipationPointsPerWin = nil;
    v73.ParticipationPointsPerLoss = nil;
    v73.MatchmakingStompRewardName = nil;
    v73.GloryPayoutMaxWins = nil;
    v73.GloryPayoutWinsInfluence = nil;
    v73.GloryPayoutMaxELO = nil;
    v73.GloryPayoutELOInfluence = nil;
    v73.MaxGloryPayout = nil;
    v73.TopPlayerRewardSkinName = nil;
    v73.TopPlayerLeaderboardRank = nil;
    v73.ThumbnailRankedCoverPhoto = nil;
    v73.ThumbnailRanked1v1 = nil;
    v73.ThumbnailRanked2v2 = nil;
    v73.ThumbnailRanked3v3 = nil;
    v73.BattlePassActive = false;
    v73.BattlePassTasksPerWeek = nil;
    v73.BattlePassTaskRequirements = nil;
    v73.BattlePassRewards = nil;
    v73.NumBattlePassTiers = nil;
    v73.NumBattlePassTracks = nil;
    v73.ContrabandBundleSkinName = nil;
    v73.ContrabandBundleFinisherName = nil;
    v73.ContrabandBundleWrapName = nil;
    v73.ContrabandBundleCharmName = nil;
    v73.ContrabandBundleEmoteName = nil;
    u9.Seasons[p70] = v73;
    u9.SeasonsByVersion[p71] = v73;

    if p68 then
        assert(not u9.CurrentSeason);
        u9.CurrentSeason = v73;
    end;
end;

add_season(false, 5, "Zero", 0, 1740718800);
add_season(false, 0, "Warp", 1, 1758859200);
add_season(false, 0, "Polar", 2, 1765515600);
add_season(true, 0, "Fame", 3, 1777003200);

local function add_season_ranked_details(p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96, p97, p98, p99, p100, p101) -- Line: 347
    -- upvalues: u9 (copy), CosmeticLibrary (copy)
    local v102 = u9.Seasons[p74];

    for _, v in pairs(p89) do
        local Name = v[2].Name;
        local v103 = CosmeticLibrary.Cosmetics[Name];

        if v103 and not CosmeticLibrary.Types[v103.Type].NotCosmetic then
            CosmeticLibrary:ExternallySetCosmeticDescription(Name, "Earned by playing Ranked Season " .. v102.Version);
        end;
    end;

    if p96 and p97 then
        CosmeticLibrary:ExternallySetCosmeticDescription(p96, "Given to the Top " .. p97 .. " players from Ranked Season " .. v102.Version);
    end;

    v102.RankProfile = u9.RankProfiles[p75];
    v102.RankedQueues = p76;
    v102.BypassTrustworthySpendRequirement = p77;
    v102.AccountAgeRequirement = p78;
    v102.LevelRequirement = p79;
    v102.TasksCompletedRequirement = p80;
    v102.MaximumPartyELODifference = p81;
    v102.DailyELOShields = p82;
    v102.ELOShieldMaxELOAllowed = p83;
    v102.ELODecayThreshold = p84;
    v102.ELODecayPerInactiveDay = p85;
    v102.ELODecayInactivePeriodDays = p86;
    v102.ParticipationPrizes = p89;
    v102.ParticipationPointsPerWin = p87;
    v102.ParticipationPointsPerLoss = p88;
    v102.MatchmakingStompRewardName = p90;
    v102.GloryPayoutMaxWins = p91;
    v102.GloryPayoutWinsInfluence = p92;
    v102.GloryPayoutMaxELO = p93;
    v102.GloryPayoutELOInfluence = p94;
    v102.MaxGloryPayout = p95;
    v102.TopPlayerRewardSkinName = p96;
    v102.TopPlayerLeaderboardRank = p97;
    v102.ThumbnailRankedCoverPhoto = p98;
    v102.ThumbnailRanked1v1 = p99;
    v102.ThumbnailRanked2v2 = p100;
    v102.ThumbnailRanked3v3 = p101;
    assert(CosmeticLibrary.Cosmetics["Season " .. v102.Version] ~= nil);
end;

add_season_ranked_details("Zero", "ranks_version1", v1, 0, 14, 30, 0, 800, 1, 1800, 3000, 100, 7, 5, 0, v2, nil, 250, 0.5, 3600, 0.5, 2500, "Arch Katana", 200, "rbxassetid://103123155567436", "rbxassetid://103123155567436", "rbxassetid://94210614848859", "rbxassetid://136241323883086");
add_season_ranked_details("Warp", "ranks_version1", v1, 0, 14, 30, 0, 800, 1, 1800, 3000, 100, 7, 5, 0, v3, nil, 250, 0.5, 3600, 0.5, 2500, "Arch Crossbow", 200, "rbxassetid://108294156233914", "rbxassetid://108294156233914", "rbxassetid://74079396411050", "rbxassetid://131383109536840");
add_season_ranked_details("Polar", "ranks_version1", v1, 1, 14, 50, 30, 800, 1, 1800, 3000, 100, 7, 5, 0, v4, nil, 250, 0.5, 3600, 0.5, 2500, "Arch Molotov", 200, "rbxassetid://76786660109423", "rbxassetid://77500396480714", "rbxassetid://76786660109423", "rbxassetid://103544907023810");
add_season_ranked_details("Fame", "ranks_version1", v1, 200, 14, 100, 30, 800, 1, 1800, 3000, 100, 7, 5, 0, v5, "Season 3 Stomp", 250, 0.65, 3600, 0.35, 2500, "Arch Uzi", 200, "rbxassetid://105428897961077", "rbxassetid://76704907616030", "rbxassetid://96045696868067", "rbxassetid://73857466226252");

local function add_season_battlepass_details(p104, p105, p106, p107, p108, p109, p110, p111, p112) -- Line: 413
    -- upvalues: u9 (copy), CosmeticLibrary (copy)
    local v113 = u9.Seasons[p104];
    local v114 = require(script:WaitForChild("SeasonPasses"):WaitForChild(p104));
    local JunkRewards = v114.JunkRewards;
    local RawRewards = v114.RawRewards;

    for _, v in pairs(JunkRewards) do
        table.sort(v, function(p115, p116) -- Line: 423
            return p115.Chance < p116.Chance;
        end);
    end;

    local u117 = 0;

    local function get_junk_reward(p118) -- Line: 430
        -- upvalues: u117 (ref), JunkRewards (copy)
        u117 = u117 + 1;
        local v119 = Random.new(u117):NextNumber();
        local v120 = JunkRewards[p118];
        local v121 = v120[#v120];

        for _, v in pairs(v120) do
            if v119 <= v.Chance then
                v121 = v;
                break;
            end;
        end;

        return table.clone(v121.RewardData);
    end;

    local v122 = 0;
    local v123 = 0;

    for i, v in pairs(RawRewards) do
        v122 = math.max(v122, i);

        for i2 in pairs(v) do
            v123 = math.max(v123, i2);
        end;
    end;

    for i = 1, v122 do
        RawRewards[i] = RawRewards[i] or {};
        local v124 = i;

        for i2 = 1, v123 do
            local v125;

            if v124 == 1 and i2 == 1 then
                v125 = i2;
            else
                RawRewards[v124][i2] = RawRewards[v124][i2] or get_junk_reward(i2);
                v125 = i2;
            end;
        end;
    end;

    for _, v in pairs({
        p108,
        p109,
        p110,
        p111,
        p112
    }) do
        CosmeticLibrary:ExternallySetCosmeticDescription(v, "Included in the Contraband Bundle from Season " .. v113.Version);
    end;

    for i = 1, v122 do
        local v126 = i;

        for i2 = 1, v123 do
            local v127 = RawRewards[v126][i2];
            local v128;

            if v127 then
                v128 = CosmeticLibrary.Cosmetics[v127.Name];
            else
                v128 = v127;
            end;

            local v129;

            if v128 and not (v128.Description or v128.DescriptionSpecific) then
                CosmeticLibrary:ExternallySetCosmeticDescription(v127.Name, "Earned from the Season Pass during Season " .. v113.Version);
                v129 = i2;
            else
                v129 = i2;
            end;
        end;
    end;

    v113.BattlePassActive = true;
    v113.BattlePassTasksPerWeek = p105;
    v113.BattlePassTaskRequirements = {
        RoundsWon = p106,
        Playtime = p107
    };
    v113.BattlePassRewards = RawRewards;
    v113.NumBattlePassTiers = v122;
    v113.NumBattlePassTracks = v123;
    v113.ContrabandBundleSkinName = p108;
    v113.ContrabandBundleFinisherName = p109;
    v113.ContrabandBundleWrapName = p110;
    v113.ContrabandBundleCharmName = p111;
    v113.ContrabandBundleEmoteName = p112;
end;

add_season_battlepass_details(
    "Warp",
    7,
    25,
    1200,
    "Electropunk Warper",
    "Spaghettified",
    "Encroached",
    "Warp Disc",
    "Portal Glitch"
);
add_season_battlepass_details("Polar", 7, 25, 1200, nil, "Giant Snowball", "Ice Queen", "Cryo Capsule", "It\'s Time");
add_season_battlepass_details("Fame", 7, 25, 1200, "Giant Pencil", "BANG!", "Crime Scene", "Duely Award", "Police Car");

return u9;