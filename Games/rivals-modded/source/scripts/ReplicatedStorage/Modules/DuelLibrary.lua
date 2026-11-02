-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
require(ReplicatedStorage.Modules.EventLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {
    Color3.fromRGB(255, 50, 50),
    Color3.fromRGB(255, 150, 0),
    Color3.fromRGB(255, 215, 0),
    Color3.fromRGB(100, 255, 50),
    Color3.fromRGB(0, 150, 255),
    Color3.fromRGB(161, 53, 255),
    Color3.fromRGB(255, 140, 244)
};
local u27 = {
    MAX_TEAMS = 0,
    EMPTY_TEAM_COLOR = Color3.fromRGB(127, 127, 127),
    APRIL_FOOLS_QUEUES = { "ltm_easyexploits_2v2", "ltm_easyexploits_3v3" },
    NEW_MAP_RELEASE_DURATION = 1209600,
    Teams = {},
    TeamsByID = {},
    MapDifficulties = {},
    Maps = {},
    MapTags = {},
    MapOrder = {},
    HiddenMapOrder = {},
    PlaySourceTypes = {},
    PlaySources = {},
    PlaySourceOrder = {},
    MatchmakingQueues = {},
    MatchmakingQueueOrder = {},
    MatchmakingQueueDuelLogicToQueueName = {},
    MatchmakingQueueDisplayNameToQueueName = {},
    ArcadeModes = {},
    ArcadeModeOrder = {},
    ArcadeModeByPlaceID = {},
    _assigned_color_count = 0,
    _arcade_mode_display_names = nil,
    _arcade_mode_display_name_to_arcade_name = nil,

    GetArcadeModeDisplayNames = function(p2) -- Line: 48, Name: GetArcadeModeDisplayNames
        if not p2._arcade_mode_display_names then
            p2._arcade_mode_display_names = {};
            p2._arcade_mode_display_name_to_arcade_name = {};

            for _, v in pairs(p2.ArcadeModeOrder) do
                local DisplayName = p2.ArcadeModes[v].DisplayName;
                table.insert(p2._arcade_mode_display_names, p2.ArcadeModes[v].DisplayName);
                p2._arcade_mode_display_name_to_arcade_name[DisplayName] = v;
            end;
        end;

        return p2._arcade_mode_display_names, p2._arcade_mode_display_name_to_arcade_name;
    end,

    GetTeamColor = function(p3, p4, p5, p6) -- Line: 63, Name: GetTeamColor
        return p4 and p3.TeamsByID[p4] and p3.TeamsByID[p4][p6 or "Color"] or (p5 or p3.EMPTY_TEAM_COLOR);
    end,

    GetMaps = function(p7, p8, p9, p10, p11) -- Line: 67, Name: GetMaps
        -- upvalues: Utility (copy)
        local v12 = p7.PlaySources[p10];
        local v13;

        if v12 then
            v13 = v12.MapPool;
        else
            v13 = v12;
        end;

        local v14 = v12 and v12.IsRigidMapPool;

        if v14 then
            local v15;

            if p11 then
                if v12 then
                    v15 = v12.Type == "ArcadeMode";
                else
                    v15 = v12;
                end;
            else
                v15 = p11;
            end;

            v14 = not v15;
        end;

        if p11 then
            p11 = not v14;
        end;

        if not p11 and v13 then
            return Utility:CloneTable(v13);
        end;

        if v12 then
            v12 = v12.Type == "ArcadeMode";
        end;

        local v16 = {};

        for i, v in pairs(p7.Maps) do
            if not v.IsHidden then
                local v17;

                if p11 then
                    v17 = p11;
                elseif v.MinimumPlayersRequired <= p8 then
                    v17 = not v.DontAutomaticallyAddToMapPools;
                else
                    v17 = false;
                end;

                if v17 and (p9 <= v.MaximumTeamsSupported and (not v12 or v.SupportsArcadeMode)) then
                    table.insert(v16, i);
                elseif v17 and (v12 and p11) then
                    table.insert(v16, i);
                end;
            end;
        end;

        for _, v in pairs(v13 or {}) do
            if not table.find(v16, v) then
                table.insert(v16, v);
            end;
        end;

        return v16;
    end,

    GetFirstQueueNameByDuelLogic = function(p18, p19) -- Line: 105, Name: GetFirstQueueNameByDuelLogic
        for _, v in pairs(p18.PlaySourceOrder) do
            if p18.PlaySources[v].DuelLogic == p19 then
                return v;
            end;
        end;
    end,

    SortMaps = function(p20, p21, p22) -- Line: 113, Name: SortMaps
        -- upvalues: ServerOsTime (copy), Utility (copy)
        local v23 = ServerOsTime:Get() < p20.Maps[p21].ReleaseTime + p20.NEW_MAP_RELEASE_DURATION;
        local v24 = ServerOsTime:Get() < p20.Maps[p22].ReleaseTime + p20.NEW_MAP_RELEASE_DURATION;
        local v25 = not v23 and -1 or p20.Maps[p21].ReleaseTime;
        local v26 = not v24 and -1 or p20.Maps[p22].ReleaseTime;

        if v25 ~= v26 then
            return v26 < v25;
        end;

        local Value = p20.MapDifficulties[p20.Maps[p21].Difficulty].Value;
        local Value2 = p20.MapDifficulties[p20.Maps[p22].Difficulty].Value;

        if Value == Value2 then
            return Utility:StringLessThan(p21, p22);
        end;

        return Value < Value2;
    end
};

local function add_team(p28, p29, p30, p31, p32, p33) -- Line: 134
    -- upvalues: u27 (copy)
    local v34 = {
        TeamIndex = p28,
        TeamID = utf8.char(p28),
        TeamName = p29,
        Logo = p30 or "",
        Color = p31,
        PadColor = p32,
        PadColor2 = p33
    };
    u27.Teams[v34.TeamIndex] = v34;
    u27.TeamsByID[v34.TeamID] = v34;
    local v35 = u27;
    v35.MAX_TEAMS = v35.MAX_TEAMS + 1;
end;

add_team(1, "Sensei Global", "rbxassetid://97418037278150", Color3.fromRGB(255, 215, 0), Color3.fromRGB(163, 135, 51), Color3.fromRGB(194, 161, 61));
add_team(2, "Nosniy Inc.", "rbxassetid://114213660098262", Color3.fromRGB(116, 61, 255), Color3.fromRGB(125, 74, 162), Color3.fromRGB(180, 115, 255));
add_team(3, "Neko Labs", "rbxassetid://126657764282293", Color3.fromRGB(0, 150, 255), Color3.fromRGB(74, 112, 161), Color3.fromRGB(0, 115, 191));

local function add_map_difficulty(p36, p37, p38) -- Line: 154
    -- upvalues: u27 (copy)
    u27.MapDifficulties[p37] = {
        Value = p36,
        Color = p38
    };
end;

local v39 = {
    Value = 0,
    Color = Color3.fromRGB(60, 60, 60)
};
u27.MapDifficulties.None = v39;
local v40 = {
    Value = 1,
    Color = Color3.fromRGB(100, 255, 50)
};
u27.MapDifficulties.Easy = v40;
local v41 = {
    Value = 2,
    Color = Color3.fromRGB(255, 215, 0)
};
u27.MapDifficulties.Medium = v41;
local v42 = {
    Value = 3,
    Color = Color3.fromRGB(255, 50, 50)
};
u27.MapDifficulties.Hard = v42;
local v43 = {
    Value = 4,
    Color = Color3.fromRGB(255, 255, 255)
};
u27.MapDifficulties.Secret = v43;

local function add_map_tag(p44, p45, p46, p47) -- Line: 169
    -- upvalues: u27 (copy)
    local v48 = {
        Name = p44,
        DisplayName = p45,
        Color = p46,
        SecondaryColor = p47 or Color3.fromRGB(255, 255, 255)
    };
    u27.MapTags[p44] = v48;
end;

local Color3_fromRGB_ret, v49 = Color3.fromRGB(255, 50, 50);
local v50 = {
    Name = "tag_newrelease",
    DisplayName = "NEW RELEASE",
    Color = Color3_fromRGB_ret,
    SecondaryColor = v49 or Color3.fromRGB(255, 255, 255)
};
u27.MapTags.tag_newrelease = v50;
local v51 = {
    Name = "tag_experimental",
    DisplayName = "Experimental",
    Color = Color3.fromRGB(44, 255, 248),
    SecondaryColor = Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
};
u27.MapTags.tag_experimental = v51;

local function add_map(p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, p63, p64, p65) -- Line: 183
    -- upvalues: u27 (copy), CONSTANTS (copy)
    local v66 = {
        MinimumPlayersRequired = 1,
        IsHidden = p52,
        ReleaseTime = p53 or 0,
        Image = p55,
        Description = p65,
        Difficulty = p56,
        MaximumTeamsSupported = p58,
        ShuffleSpawnsUniversally = p59,
        DontAutomaticallyAddToMapPools = p60,
        SupportsArcadeMode = p61,
        Creators = p62 or {},
        Contributors = p63 or {},
        MapTag = p64,
        PlaySources = {}
    };
    u27.Maps[p54] = v66;
    table.insert(u27.HiddenMapOrder, p54);

    if not v66.IsHidden or CONSTANTS.IS_TESTING_SERVER then
        table.insert(u27.MapOrder, p54);
    end;
end;

add_map(
    nil,
    1766548800,
    "Village",
    "rbxassetid://78458667507109",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    1766548800,
    "Iceberg",
    "rbxassetid://110713820813038",
    "Medium",
    1,
    2,
    nil,
    nil,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Backrooms",
    "rbxassetid://78425568447137",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "Nosniy" },
    nil
);
add_map(nil, nil, "Arena", "rbxassetid://108088064658436", "Easy", 1, 2, nil, nil, nil, { "Nosniy" }, nil);
add_map(
    nil,
    nil,
    "Dimension",
    "rbxassetid://78851598956506",
    "Hard",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    nil,
    "Bridge",
    "rbxassetid://110835255645526",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    1777003200,
    "Museum",
    "rbxassetid://80495049076353",
    "Medium",
    5,
    3,
    nil,
    nil,
    true,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    nil,
    "Graveyard",
    "rbxassetid://129215409539945",
    "Medium",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    1777003200,
    "Studio",
    "rbxassetid://113589926222762",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    nil,
    "Playground",
    "rbxassetid://133164748672681",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Splash",
    "rbxassetid://73768743857232",
    "Medium",
    1,
    2,
    nil,
    nil,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    1770958800,
    "Chess",
    "rbxassetid://88015580366583",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Construction",
    "rbxassetid://92127692376940",
    "Hard",
    1,
    2,
    nil,
    nil,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Station",
    "rbxassetid://118067445717885",
    "Medium",
    1,
    2,
    nil,
    nil,
    true,
    { "Nosniy" },
    { "GreatGuyBoom" }
);
add_map(
    nil,
    nil,
    "Onyx",
    "rbxassetid://103965007372841",
    "Hard",
    1,
    3,
    nil,
    nil,
    nil,
    { "ShadowTrojan" },
    nil
);
add_map(
    nil,
    nil,
    "Crossroads",
    "rbxassetid://137051465958454",
    "Medium",
    1,
    3,
    true,
    nil,
    nil,
    { "ShadowTrojan" },
    nil
);
add_map(
    nil,
    nil,
    "Docks",
    "rbxassetid://118450909242865",
    "Medium",
    1,
    2,
    nil,
    nil,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    1777003200,
    "Westown",
    "rbxassetid://77717157639300",
    "Medium",
    1,
    2,
    nil,
    nil,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Big Arena",
    "rbxassetid://86783307295205",
    "Easy",
    5,
    3,
    nil,
    nil,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Big Onyx",
    "rbxassetid://102960591046810",
    "Hard",
    5,
    3,
    nil,
    nil,
    nil,
    { "ShadowTrojan" },
    nil
);
add_map(
    nil,
    nil,
    "Big Splash",
    "rbxassetid://129106276364955",
    "Medium",
    5,
    3,
    nil,
    nil,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Big Backrooms",
    "rbxassetid://70941797176675",
    "Easy",
    5,
    3,
    nil,
    nil,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Big Crossroads",
    "rbxassetid://73141606762048",
    "Medium",
    5,
    3,
    true,
    nil,
    true,
    { "ShadowTrojan" },
    nil
);
add_map(
    nil,
    nil,
    "Big Graveyard",
    "rbxassetid://93673011647821",
    "Medium",
    5,
    3,
    true,
    nil,
    true,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    1770958800,
    "Big Station",
    "rbxassetid://115320285934414",
    "Medium",
    5,
    3,
    true,
    nil,
    true,
    { "GreatGuyBoom" },
    nil
);
add_map(
    nil,
    nil,
    "Shooting Range",
    "rbxassetid://80094199312443",
    "Easy",
    9,
    2,
    nil,
    nil,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Battleground",
    "rbxassetid://102473488579867",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    { "ShadowTrojan" }
);
add_map(
    nil,
    1782446400,
    "Sandbox",
    "rbxassetid://129581948881572",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    { "ShadowTrojan" }
);
add_map(
    nil,
    nil,
    "Legacy Backrooms",
    "rbxassetid://16780257607",
    "Secret",
    1,
    2,
    nil,
    true,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Legacy Big Splash",
    "rbxassetid://112550674762781",
    "Secret",
    1,
    2,
    nil,
    true,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Legacy Splash",
    "rbxassetid://77611360382000",
    "Secret",
    1,
    2,
    nil,
    true,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Legacy Docks",
    "rbxassetid://17619338260",
    "Secret",
    1,
    2,
    nil,
    true,
    true,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Legacy Onyx",
    "rbxassetid://73585862572119",
    "Secret",
    1,
    2,
    nil,
    true,
    nil,
    { "ShadowTrojan" },
    nil
);
add_map(
    nil,
    nil,
    "Legacy Crossroads",
    "rbxassetid://75089226416040",
    "Secret",
    1,
    2,
    nil,
    true,
    nil,
    { "ShadowTrojan" },
    nil
);
add_map(
    nil,
    nil,
    "Legacy Battleground",
    "rbxassetid://92092855485574",
    "Secret",
    1,
    2,
    nil,
    true,
    nil,
    { "ShadowTrojan" },
    nil
);
add_map(
    nil,
    nil,
    "Legacy Sandbox",
    "rbxassetid://84468237347412",
    "Secret",
    1,
    2,
    nil,
    nil,
    nil,
    { "ShadowTrojan" },
    nil
);
add_map(nil, nil, "Baseplate", "rbxassetid://70533987337950", "Secret", 1, 3, nil, true, nil, nil, nil);
add_map(
    true,
    nil,
    "Boss Arena",
    "rbxassetid://75072389675461",
    "Secret",
    1,
    3,
    nil,
    true,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    true,
    nil,
    "Obby",
    "rbxassetid://84725536967912",
    "Secret",
    1,
    3,
    nil,
    true,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    true,
    nil,
    "Zombie Tower",
    "rbxassetid://129926572026365",
    "Secret",
    1,
    1,
    nil,
    true,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    true,
    nil,
    "Spleef",
    "rbxassetid://92639076087223",
    "Secret",
    1,
    1,
    nil,
    true,
    nil,
    { "Nosniy" },
    nil
);
add_map(
    nil,
    nil,
    "Factory",
    "rbxassetid://134218858341023",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "GreatGuyBoom" },
    nil,
    "tag_experimental"
);
add_map(
    nil,
    nil,
    "Gate",
    "rbxassetid://93979105537133",
    "Easy",
    1,
    2,
    nil,
    nil,
    nil,
    { "ShadowTrojan" },
    nil,
    "tag_experimental"
);

if CONSTANTS.IS_TESTING_SERVER then
    add_map(
        nil,
        nil,
        "Front",
        "rbxassetid://110072622389604",
        "None",
        1,
        3,
        nil,
        nil,
        nil,
        nil,
        nil,
        "tag_experimental"
    );
end;

local function add_play_source_type(p67) -- Line: 258
    -- upvalues: u27 (copy)
    u27.PlaySourceTypes[p67] = {};
end;

u27.PlaySourceTypes.MatchmakingQueue = {};
u27.PlaySourceTypes.ArcadeMode = {};

local function verify_map_pool(p68) -- Line: 269
    -- upvalues: u27 (copy)
    if p68 then
        for i = #p68, 1, -1 do
            local v69;

            if u27.Maps[p68[i]] then
                v69 = i;
            else
                table.remove(p68, i);
                v69 = i;
            end;
        end;

        return p68;
    end;
end;

local function iaf() -- Line: 283
    -- upvalues: Utility (copy)
    return Utility:IsAprilFoolsGamemodesEnabled();
end;

local function add_play_source(p70, p71, p72, p73, p74, p75, p76) -- Line: 287
    -- upvalues: u27 (copy), u1 (copy), verify_map_pool (copy)
    assert(u27.PlaySourceTypes[p70]);
    assert(not u27.PlaySourceTypes[p71]);
    u27._assigned_color_count = u27._assigned_color_count % #u1 + 1;
    local v77 = {
        Type = p70,
        DisplayName = p73,
        DuelLogic = p72,
        DatabaseInfo = p74,
        IsRigidMapPool = p75,
        MapPool = verify_map_pool(p76),
        AssignedColor = u1[u27._assigned_color_count]
    };
    u27.PlaySources[p71] = v77;
    table.insert(u27.PlaySourceOrder, p71);

    if v77.Type ~= "MatchmakingQueue" or v77.DatabaseInfo.CanBeStartedFromClient then
        local v78;

        if v77.Type == "MatchmakingQueue" then
            v78 = u27:GetMaps(v77.DatabaseInfo.NumTeams * v77.DatabaseInfo.PlayersPerTeam, v77.DatabaseInfo.NumTeams, p71);
        elseif v77.Type == "ArcadeMode" then
            v78 = u27:GetMaps(nil, nil, p71);
        else
            v78 = assert(false, "???");
        end;

        for _, v in pairs(v78 or {}) do
            table.insert(u27.Maps[v].PlaySources, p71);
        end;
    end;
end;

local function add_queue(p79, p80, p81, p82, p83, p84, u85, p86, u87, p88, p89, p90, p91, p92, p93, p94) -- Line: 318
    -- upvalues: CONSTANTS (copy), Utility (copy), u27 (copy), add_play_source (copy)
    local v95 = p79 and p79 < 0 and (1 / 0) or p79;
    local v97 = {
        TerminalsReleaseTime = CONSTANTS.IS_TESTING_SERVER and (not v95 or v95 < (1 / 0)) and 0 or (v95 or 0),
        Name = p80,
        NumTeams = p82,
        PlayersPerTeam = p83,
        CanBeStartedFromClient = p84,

        AreStreaksDisabled = function() -- Line: 327, Name: AreStreaksDisabled
            -- upvalues: u85 (copy), Utility (ref), u87 (copy)
            local v96 = u85 or Utility:IsAprilFools() and not u87;

            return v96;
        end,

        StatisticsDisabled = p86,
        IsSafeFromAprilFools = u87,
        DisplayName = p88 or "???",
        TitleName = p89,
        Image = p90 or "rbxassetid://18523763487",
        Thumbnail = p91 or "rbxassetid://117875704523935",
        Description = p92 or ""
    };
    u27.MatchmakingQueues[p80] = v97;
    u27.MatchmakingQueueDisplayNameToQueueName[p88] = p80;
    table.insert(u27.MatchmakingQueueOrder, p80);

    if p81 then
        u27.MatchmakingQueueDuelLogicToQueueName[p81] = u27.MatchmakingQueueDuelLogicToQueueName[p81] or v97;
    end;

    add_play_source("MatchmakingQueue", p80, p81, p88, v97, p93, p94);
end;

add_queue(
    -1,
    "2v2_beginner",
    nil,
    2,
    1,
    true,
    nil,
    nil,
    nil,
    "Beginner 2v2",
    "Beginner",
    nil,
    "rbxassetid://86693110079054",
    nil,
    nil,
    { "Arena" }
);
add_queue(
    nil,
    "1v1",
    nil,
    2,
    1,
    true,
    nil,
    nil,
    nil,
    "1v1",
    nil,
    "rbxassetid://18525954682",
    "rbxassetid://110648887575668",
    nil,
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Chess", "Sandbox", "Westown", "Museum", "Studio", "Gate" }
);
add_queue(
    nil,
    "2v2",
    nil,
    2,
    2,
    true,
    nil,
    nil,
    nil,
    "2v2",
    nil,
    "rbxassetid://18525954682",
    "rbxassetid://75765063500610",
    nil,
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Sandbox", "Westown", "Museum", "Studio", "Gate" }
);
add_queue(
    nil,
    "3v3",
    nil,
    2,
    3,
    true,
    nil,
    nil,
    nil,
    "3v3",
    nil,
    "rbxassetid://18525954682",
    "rbxassetid://115188828715635",
    nil,
    nil,
    { "Big Arena", "Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Factory", "Westown", "Museum" }
);
add_queue(
    nil,
    "4v4",
    nil,
    2,
    4,
    true,
    nil,
    nil,
    nil,
    "4v4",
    nil,
    "rbxassetid://18525954682",
    "rbxassetid://78144981625266",
    nil,
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Docks", "Station", "Big Onyx", "Big Splash", "Big Graveyard", "Battleground", "Iceberg", "Big Station", "Chess", "Factory", "Westown", "Museum" }
);
add_queue(
    nil,
    "5v5",
    nil,
    2,
    5,
    true,
    nil,
    nil,
    nil,
    "5v5",
    nil,
    "rbxassetid://18525954682",
    "rbxassetid://100769223566900",
    nil,
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Docks", "Big Onyx", "Big Splash", "Big Graveyard", "Shooting Range", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(nil, "ranked_1v1", "Ranked", 2, 1, true, true, nil, true, "Ranked 1v1", "Ranked", "rbxassetid://117835427046796", SeasonLibrary.CurrentSeason.ThumbnailRanked1v1, nil, nil, { "Arena", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Westown", "Studio", "Museum", "Battleground", "Village" });
add_queue(nil, "ranked_2v2", "Ranked", 2, 2, true, true, nil, true, "Ranked 2v2", "Ranked", "rbxassetid://117835427046796", SeasonLibrary.CurrentSeason.ThumbnailRanked2v2, nil, nil, { "Arena", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Battleground", "Westown", "Studio", "Museum", "Crossroads", "Village" });
add_queue(nil, "ranked_3v3", "Ranked", 2, 3, true, true, nil, true, "Ranked 3v3", "Ranked", "rbxassetid://117835427046796", SeasonLibrary.CurrentSeason.ThumbnailRanked3v3, nil, nil, { "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Battleground", "Big Arena", "Westown", "Museum" });
add_queue(
    nil,
    "ltm_doubletrouble_1v1",
    "Double Trouble",
    2,
    1,
    nil,
    true,
    nil,
    nil,
    "Double Trouble 1v1",
    "Double Trouble",
    "rbxassetid://132073690319347",
    "rbxassetid://137424181577897",
    "Dual wield your favorite weapons!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Iceberg", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    nil,
    "ltm_doubletrouble",
    "Double Trouble",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "Double Trouble 2v2",
    "Double Trouble",
    "rbxassetid://132073690319347",
    "rbxassetid://137424181577897",
    "Dual wield your favorite weapons!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    nil,
    "ltm_doubletrouble_3v3",
    "Double Trouble",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Double Trouble 3v3",
    "Double Trouble",
    "rbxassetid://132073690319347",
    "rbxassetid://137424181577897",
    "Dual wield your favorite weapons!",
    nil,
    { "Big Arena", "Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(
    nil,
    "ltm_mirrormatchup_1v1",
    "Mirror Matchup",
    2,
    1,
    nil,
    true,
    nil,
    nil,
    "Mirror Matchup 1v1",
    "Mirror Matchup",
    "rbxassetid://132073690319347",
    "rbxassetid://105092869907244",
    "Everyone has to use the same random weapons!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    nil,
    "ltm_mirrormatchup_2v2",
    "Mirror Matchup",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "Mirror Matchup 2v2",
    "Mirror Matchup",
    "rbxassetid://132073690319347",
    "rbxassetid://105092869907244",
    "Everyone has to use the same random weapons!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    nil,
    "ltm_mirrormatchup_3v3",
    "Mirror Matchup",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Mirror Matchup 3v3",
    "Mirror Matchup",
    "rbxassetid://132073690319347",
    "rbxassetid://105092869907244",
    "Everyone has to use the same random weapons!",
    nil,
    { "Big Arena", "Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(nil, "ltm_easyexploits_2v2", "Easy Exploits", 2, 2, iaf, true, nil, nil, "Easy Exploits 2v2", "Easy Exploits", "rbxassetid://132073690319347", "rbxassetid://131530572287607", "Fake cheating — actual cheaters get banned!", nil, { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" });
add_queue(nil, "ltm_easyexploits_3v3", "Easy Exploits", 2, 3, iaf, true, nil, nil, "Easy Exploits 3v3", "Easy Exploits", "rbxassetid://132073690319347", "rbxassetid://131530572287607", "Fake cheating — actual cheaters get banned!", nil, { "Big Arena", "Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Westown", "Museum" });
add_queue(
    nil,
    "ltm_limitlessloadout_1v1",
    "Limitless Loadout",
    2,
    1,
    nil,
    true,
    nil,
    nil,
    "Limitless Loadout 1v1",
    "Limitless Loadout",
    "rbxassetid://132073690319347",
    "rbxassetid://132019868240159",
    "Equip any weapon in any slot!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    nil,
    "ltm_limitlessloadout_2v2",
    "Limitless Loadout",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "Limitless Loadout 2v2",
    "Limitless Loadout",
    "rbxassetid://132073690319347",
    "rbxassetid://132019868240159",
    "Equip any weapon in any slot!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    nil,
    "ltm_limitlessloadout_3v3",
    "Limitless Loadout",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Limitless Loadout 3v3",
    "Limitless Loadout",
    "rbxassetid://132073690319347",
    "rbxassetid://132019868240159",
    "Equip any weapon in any slot!",
    nil,
    { "Big Arena", "Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(
    1749182400,
    "ltm_juggernaut_1v7",
    "Juggernaut",
    2,
    4,
    nil,
    true,
    nil,
    nil,
    "Juggernaut 1v7",
    "Juggernaut",
    "rbxassetid://132073690319347",
    "rbxassetid://111131964001261",
    "Will you be the raid boss?",
    nil,
    { "Big Arena", "Backrooms", "Bridge", "Graveyard", "Playground", "Construction", "Onyx", "Dimension", "Iceberg", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    1749787200,
    "ltm_swiftstandoff_1v1",
    "Swift Standoff",
    2,
    1,
    nil,
    true,
    nil,
    nil,
    "Swift Standoff 1v1",
    "Swift Standoff",
    "rbxassetid://132073690319347",
    "rbxassetid://97275583028575",
    "Slash & dash with just 1 bullet in the chamber!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    1749787200,
    "ltm_swiftstandoff_2v2",
    "Swift Standoff",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "Swift Standoff 2v2",
    "Swift Standoff",
    "rbxassetid://132073690319347",
    "rbxassetid://97275583028575",
    "Slash & dash with just 1 bullet in the chamber!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    1749787200,
    "ltm_swiftstandoff_3v3",
    "Swift Standoff",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Swift Standoff 3v3",
    "Swift Standoff",
    "rbxassetid://132073690319347",
    "rbxassetid://97275583028575",
    "Slash & dash with just 1 bullet in the chamber!",
    nil,
    { "Big Arena", "Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(
    1750392000,
    "ltm_defaultduel_1v1",
    "Default Duel",
    2,
    1,
    nil,
    nil,
    nil,
    nil,
    "Default Duel 1v1",
    "Default Duel",
    "rbxassetid://132073690319347",
    "rbxassetid://97514791083427",
    "A true test of skill — default weapons only!",
    nil,
    { "Arena", "Station", "Legacy Backrooms", "Legacy Docks", "Legacy Onyx", "Legacy Crossroads" }
);
add_queue(
    1750392000,
    "ltm_defaultduel_2v2",
    "Default Duel",
    2,
    2,
    nil,
    nil,
    nil,
    nil,
    "Default Duel 2v2",
    "Default Duel",
    "rbxassetid://132073690319347",
    "rbxassetid://97514791083427",
    "A true test of skill — default weapons only!",
    nil,
    { "Arena", "Station", "Legacy Backrooms", "Legacy Docks", "Legacy Onyx", "Legacy Crossroads" }
);
add_queue(
    1750392000,
    "ltm_bunnysniping_2v2",
    "Bunny Sniping",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "Bunny Sniping 2v2",
    "Bunny Sniping",
    "rbxassetid://132073690319347",
    "rbxassetid://111836104944441",
    "Snipe enemies in low gravity!",
    nil,
    { "Arena", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Iceberg", "Chess", "Westown", "Studio" }
);
add_queue(
    1750392000,
    "ltm_bunnysniping_3v3",
    "Bunny Sniping",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Bunny Sniping 3v3",
    "Bunny Sniping",
    "rbxassetid://132073690319347",
    "rbxassetid://81786315504458",
    "Snipe enemies in low gravity!",
    nil,
    { "Arena", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Iceberg", "Big Station", "Chess", "Westown" }
);
add_queue(
    1750996800,
    "ltm_tagteam_3v3",
    "Tag Team",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Tag Team 3v3",
    "Tag Team",
    "rbxassetid://132073690319347",
    "rbxassetid://98049823970129",
    "Sweep the enemy team as your teammates watch you!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Iceberg", "Chess", "Westown", "Museum" }
);
add_queue(
    1750996800,
    "ltm_tagteam_5v5",
    "Tag Team",
    2,
    5,
    nil,
    true,
    nil,
    nil,
    "Tag Team 5v5",
    "Tag Team",
    "rbxassetid://132073690319347",
    "rbxassetid://98049823970129",
    "Sweep the enemy team as your teammates watch you!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Iceberg", "Chess", "Westown", "Museum" }
);
add_queue(
    1751601600,
    "ltm_chickengames_1v1",
    "Chicken Game",
    2,
    1,
    nil,
    true,
    nil,
    nil,
    "Chicken Game 1v1",
    "Chicken Game",
    "rbxassetid://132073690319347",
    "rbxassetid://130631351253585",
    "Red Light 🚦 Green Light",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    1751601600,
    "ltm_chickengames_2v2",
    "Chicken Game",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "Chicken Game 2v2",
    "Chicken Game",
    "rbxassetid://132073690319347",
    "rbxassetid://130631351253585",
    "Red Light 🚦 Green Light",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    1751601600,
    "ltm_chickengames_3v3",
    "Chicken Game",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Chicken Game 3v3",
    "Chicken Game",
    "rbxassetid://132073690319347",
    "rbxassetid://130631351253585",
    "Red Light 🚦 Green Light",
    nil,
    { "Big Arena", "Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(
    1751601600,
    "ltm_chickengames_4v4",
    "Chicken Game",
    2,
    4,
    nil,
    true,
    nil,
    nil,
    "Chicken Game 4v4",
    "Chicken Game",
    "rbxassetid://132073690319347",
    "rbxassetid://130631351253585",
    "Red Light 🚦 Green Light",
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Docks", "Big Onyx", "Big Splash", "Station", "Big Graveyard", "Battleground", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(
    1752206400,
    "ltm_rivalsrng_1v1",
    "RIVALS RNG",
    2,
    1,
    nil,
    true,
    nil,
    nil,
    "RIVALS RNG 1v1",
    "RIVALS RNG",
    "rbxassetid://132073690319347",
    "rbxassetid://77265684173552",
    "Roll for a random weapon!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    1752206400,
    "ltm_rivalsrng_2v2",
    "RIVALS RNG",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "RIVALS RNG 2v2",
    "RIVALS RNG",
    "rbxassetid://132073690319347",
    "rbxassetid://77265684173552",
    "Roll for a random weapon!",
    nil,
    { "Arena", "Backrooms", "Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Dimension", "Village", "Chess", "Westown", "Museum", "Studio" }
);
add_queue(
    1752206400,
    "ltm_rivalsrng_3v3",
    "RIVALS RNG",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "RIVALS RNG 3v3",
    "RIVALS RNG",
    "rbxassetid://132073690319347",
    "rbxassetid://77265684173552",
    "Roll for a random weapon!",
    nil,
    { "Big Arena", "Big Backrooms", "Crossroads", "Big Crossroads", "Docks", "Splash", "Station", "Construction", "Onyx", "Bridge", "Playground", "Graveyard", "Battleground", "Village", "Iceberg", "Big Station", "Chess", "Westown", "Museum" }
);
add_queue(
    1752811200,
    "ltm_headhoncho_3v3",
    "Head Honcho",
    2,
    3,
    nil,
    true,
    nil,
    nil,
    "Head Honcho 3v3",
    "Head Honcho",
    "rbxassetid://132073690319347",
    "rbxassetid://129701707427431",
    "Assassinate the rival company\'s leader!",
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Docks", "Big Onyx", "Big Splash", "Big Graveyard", "Shooting Range", "Iceberg", "Big Station", "Westown", "Museum" }
);
add_queue(
    1752811200,
    "ltm_headhoncho_4v4",
    "Head Honcho",
    2,
    4,
    nil,
    true,
    nil,
    nil,
    "Head Honcho 4v4",
    "Head Honcho",
    "rbxassetid://132073690319347",
    "rbxassetid://129701707427431",
    "Assassinate the rival company\'s leader!",
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Docks", "Big Onyx", "Big Splash", "Big Graveyard", "Shooting Range", "Iceberg", "Big Station", "Westown", "Museum" }
);
add_queue(
    1752811200,
    "ltm_headhoncho_5v5",
    "Head Honcho",
    2,
    5,
    nil,
    true,
    nil,
    nil,
    "Head Honcho 5v5",
    "Head Honcho",
    "rbxassetid://132073690319347",
    "rbxassetid://111031080770975",
    "Assassinate the rival company\'s leader!",
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Docks", "Big Onyx", "Big Splash", "Big Graveyard", "Shooting Range", "Iceberg", "Big Station", "Westown", "Museum" }
);
add_queue(
    1753416000,
    "ltm_hardcoreparkour_1v1",
    "Hardcore Parkour",
    2,
    1,
    nil,
    true,
    nil,
    nil,
    "Hardcore Parkour 1v1",
    "Hardcore Parkour",
    "rbxassetid://132073690319347",
    "rbxassetid://104911032041491",
    "Obby but you\'re in RIVALS!",
    true,
    { "Obby" }
);
add_queue(
    1753416000,
    "ltm_hardcoreparkour_2v2",
    "Hardcore Parkour",
    2,
    2,
    nil,
    true,
    nil,
    nil,
    "Hardcore Parkour 2v2",
    "Hardcore Parkour",
    "rbxassetid://132073690319347",
    "rbxassetid://104911032041491",
    "Obby but you\'re in RIVALS!",
    true,
    { "Obby" }
);
add_queue(
    1753416000,
    "ltm_hardcoreparkour_5v5",
    "Hardcore Parkour",
    2,
    5,
    nil,
    true,
    nil,
    nil,
    "Hardcore Parkour 5v5",
    "Hardcore Parkour",
    "rbxassetid://132073690319347",
    "rbxassetid://104911032041491",
    "Obby but you\'re in RIVALS!",
    true,
    { "Obby" }
);
add_queue(
    nil,
    "1v1v1",
    nil,
    3,
    1,
    nil,
    true,
    nil,
    nil,
    "1v1v1",
    nil,
    "rbxassetid://132073690319347",
    "rbxassetid://105588944981527",
    "Classic duels but with 3 teams!",
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Shooting Range", "Onyx", "Big Graveyard", "Station", "Docks", "Crossroads", "Big Onyx", "Iceberg", "Big Station", "Museum", "Westown" }
);
add_queue(
    nil,
    "2v2v2",
    nil,
    3,
    2,
    nil,
    true,
    nil,
    nil,
    "2v2v2",
    nil,
    "rbxassetid://132073690319347",
    "rbxassetid://105588944981527",
    "Classic duels but with 3 teams!",
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Shooting Range", "Oynx", "Big Graveyard", "Station", "Docks", "Crossroads", "Big Onyx", "Iceberg", "Big Station", "Museum", "Westown" }
);
add_queue(
    nil,
    "3v3v3",
    nil,
    3,
    3,
    nil,
    true,
    nil,
    nil,
    "3v3v3",
    nil,
    "rbxassetid://132073690319347",
    "rbxassetid://105588944981527",
    "Classic duels but with 3 teams!",
    nil,
    { "Big Arena", "Big Backrooms", "Big Crossroads", "Shooting Range", "Oynx", "Big Graveyard", "Station", "Docks", "Crossroads", "Big Onyx", "Iceberg", "Big Station", "Museum", "Westown" }
);
add_queue(
    nil,
    "ltm_spleef_8v8",
    "Spleef",
    2,
    8,
    nil,
    true,
    nil,
    nil,
    "Spleef 8v8",
    "Spleef",
    "rbxassetid://132073690319347",
    "rbxassetid://136079282184880",
    "Don\'t fall into the chark-infested waters!",
    true,
    { "Spleef" }
);
add_queue(
    -1,
    "ltm_zombietower",
    "Zombie Tower",
    1,
    5,
    nil,
    true,
    true,
    nil,
    "Zombie Tower",
    "Zombie Tower",
    "rbxassetid://132073690319347",
    "rbxassetid://79328971751595",
    "Can you reach the top?",
    true,
    { "Zombie Tower" }
);
add_queue(
    -1,
    "ltm_zombietower_solo",
    "Zombie Tower",
    1,
    1,
    nil,
    true,
    true,
    nil,
    "Zombie Tower Solo",
    "Zombie Tower",
    "rbxassetid://132073690319347",
    "rbxassetid://72764838190885",
    "Can you reach the top.. by yourself?",
    true,
    { "Zombie Tower" }
);
add_queue(
    -1,
    "evt_senseibot",
    "Boss Battle",
    1,
    1,
    nil,
    true,
    true,
    true,
    "Sensei Bot",
    "Sensei Bot",
    "rbxassetid://132073690319347",
    "rbxassetid://110648887575668",
    nil,
    true,
    { "Boss Arena" }
);
add_queue(
    -1,
    "evt_nosniybot",
    "Boss Battle",
    1,
    1,
    nil,
    true,
    true,
    true,
    "Nosniy Bot",
    "Nosniy Bot",
    "rbxassetid://132073690319347",
    "rbxassetid://110648887575668",
    nil,
    true,
    { "Boss Arena" }
);

local function add_arcade_mode(p98, p99, p100, p101, p102, p103, p104) -- Line: 404
    -- upvalues: u27 (copy), add_play_source (copy)
    local v105 = {
        Name = p98,
        DisplayName = p100,
        Thumbnail = p101,
        Description = p102,
        PlaceID = p103
    };
    u27.ArcadeModes[p98] = v105;
    u27.ArcadeModeByPlaceID[tostring(v105.PlaceID)] = v105;
    table.insert(u27.ArcadeModeOrder, p98);
    add_play_source("ArcadeMode", p98, p99, p100, v105, true, p104);
end;

add_arcade_mode("arc_gungame", "Gun Game", "Gun Game", "rbxassetid://126712308378143", "Race to the final weapon to win!", CONSTANTS.ARCADE_GUNGAME_PLACE_ID, { "Big Crossroads", "Shooting Range", "Station", "Big Arena", "Big Backrooms", "Big Graveyard", "Big Splash", "Docks", "Iceberg", "Big Station", "Westown", "Museum" });
add_arcade_mode("arc_teamdeathmatch", "Deathmatch", "Team Deathmatch", "rbxassetid://117499628913182", "The team with the most points wins!", CONSTANTS.ARCADE_TEAMDEATHMATCH_PLACE_ID, { "Big Crossroads", "Shooting Range", "Station", "Big Arena", "Big Backrooms", "Big Graveyard", "Big Splash", "Docks", "Iceberg", "Chess", "Big Station", "Westown", "Museum" });
add_arcade_mode("arc_freeforall", "Deathmatch", "Free For All", "rbxassetid://86903206151694", "The player with the most points wins!", CONSTANTS.ARCADE_FREEFORALL_PLACE_ID, { "Big Crossroads", "Shooting Range", "Station", "Big Arena", "Big Backrooms", "Big Graveyard", "Big Splash", "Docks", "Iceberg", "Big Station", "Westown" });

return u27;