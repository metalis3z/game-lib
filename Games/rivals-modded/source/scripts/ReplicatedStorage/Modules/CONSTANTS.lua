-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TestLibrary = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("TestLibrary"));
local u1 = { "PRIVATE_SERVER_ID", "PRIVATE_SERVER_OWNER_ID", "IS_PUBLIC_SERVER", "IS_RESERVED_SERVER", "IS_PRIVATE_SERVER", "IS_PRIVATE_HUB_SERVER" };
local RequestConstants = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Misc"):WaitForChild("RequestConstants");
local TestAttribute = TestLibrary:GetTestAttribute("StudioIsPrivateServerOwner");
local TestAttribute2 = TestLibrary:GetTestAttribute("StudioIsPrivateServer");
local TestAttribute3 = TestLibrary:GetTestAttribute("StudioPlaceID");
local u2 = {
    GAME_VERSION = 30,
    MAIN_HUB_PLACE_ID = 17625359962,
    MAIN_MOBILE_PLACE_ID = 18126510175,
    MAIN_MATCHMAKING_PLACE_ID = 117398147513099,
    MAIN_ARCADE_TEAMDEATHMATCH_PLACE_ID = 71874690745115,
    MAIN_ARCADE_FREEFORALL_PLACE_ID = 129604661913557,
    MAIN_ARCADE_GUNGAME_PLACE_ID = 133215910299950,
    TESTING_HUB_PLACE_ID = 12011504191,
    TESTING_MOBILE_PLACE_ID = 18126498684,
    TESTING_MATCHMAKING_PLACE_ID = 136907445582634,
    TESTING_ARCADE_TEAMDEATHMATCH_PLACE_ID = 139242311442282,
    TESTING_ARCADE_FREEFORALL_PLACE_ID = 83743252354420,
    TESTING_ARCADE_GUNGAME_PLACE_ID = 90728399170029,
    IS_RUNNING = RunService:IsRunning(),
    IS_STUDIO = RunService:IsStudio(),
    IS_SERVER = RunService:IsServer(),
    IS_CLIENT = RunService:IsClient(),
    DEVICE = "Server"
};

if not u2.IS_STUDIO or TestAttribute3 <= 0 then
    TestAttribute3 = game.PlaceId;
end;

-- This copy runs in a place of its own, not in one of the official places above, and has no
-- matchmaking or arcade places to send anyone to: any place it does not know is the main hub.
if not table.find({
    u2.MAIN_HUB_PLACE_ID, u2.MAIN_MOBILE_PLACE_ID, u2.MAIN_MATCHMAKING_PLACE_ID,
    u2.MAIN_ARCADE_TEAMDEATHMATCH_PLACE_ID, u2.MAIN_ARCADE_FREEFORALL_PLACE_ID, u2.MAIN_ARCADE_GUNGAME_PLACE_ID,
    u2.TESTING_HUB_PLACE_ID, u2.TESTING_MOBILE_PLACE_ID, u2.TESTING_MATCHMAKING_PLACE_ID,
    u2.TESTING_ARCADE_TEAMDEATHMATCH_PLACE_ID, u2.TESTING_ARCADE_FREEFORALL_PLACE_ID, u2.TESTING_ARCADE_GUNGAME_PLACE_ID,
}, TestAttribute3) then
    TestAttribute3 = u2.MAIN_HUB_PLACE_ID;
end;

u2.PLACE_ID = TestAttribute3;
u2.JOB_ID = game.JobId;
u2.PRIVATE_SERVER_ID = u2.IS_SERVER and game.PrivateServerId;
u2.PRIVATE_SERVER_OWNER_ID = u2.IS_SERVER and game.PrivateServerOwnerId;
u2.IS_MAIN_SERVER = (u2.PLACE_ID == u2.MAIN_HUB_PLACE_ID or (u2.PLACE_ID == u2.MAIN_MOBILE_PLACE_ID or (u2.PLACE_ID == u2.MAIN_MATCHMAKING_PLACE_ID or (u2.PLACE_ID == u2.MAIN_ARCADE_TEAMDEATHMATCH_PLACE_ID or u2.PLACE_ID == u2.MAIN_ARCADE_FREEFORALL_PLACE_ID)))) and true or u2.PLACE_ID == u2.MAIN_ARCADE_GUNGAME_PLACE_ID;
u2.IS_TESTING_SERVER = (u2.PLACE_ID == u2.TESTING_HUB_PLACE_ID or (u2.PLACE_ID == u2.TESTING_MOBILE_PLACE_ID or (u2.PLACE_ID == u2.TESTING_MATCHMAKING_PLACE_ID or (u2.PLACE_ID == u2.TESTING_ARCADE_TEAMDEATHMATCH_PLACE_ID or u2.PLACE_ID == u2.TESTING_ARCADE_FREEFORALL_PLACE_ID)))) and true or u2.PLACE_ID == u2.TESTING_ARCADE_GUNGAME_PLACE_ID;
u2.HUB_PLACE_ID = u2.IS_MAIN_SERVER and u2.MAIN_HUB_PLACE_ID or u2.TESTING_HUB_PLACE_ID;
u2.MOBILE_PLACE_ID = u2.IS_MAIN_SERVER and u2.MAIN_MOBILE_PLACE_ID or u2.TESTING_MOBILE_PLACE_ID;
u2.MATCHMAKING_PLACE_ID = u2.IS_MAIN_SERVER and u2.MAIN_MATCHMAKING_PLACE_ID or u2.TESTING_MATCHMAKING_PLACE_ID;
u2.ARCADE_TEAMDEATHMATCH_PLACE_ID = u2.IS_MAIN_SERVER and u2.MAIN_ARCADE_TEAMDEATHMATCH_PLACE_ID or u2.TESTING_ARCADE_TEAMDEATHMATCH_PLACE_ID;
u2.ARCADE_FREEFORALL_PLACE_ID = u2.IS_MAIN_SERVER and u2.MAIN_ARCADE_FREEFORALL_PLACE_ID or u2.TESTING_ARCADE_FREEFORALL_PLACE_ID;
u2.ARCADE_GUNGAME_PLACE_ID = u2.IS_MAIN_SERVER and u2.MAIN_ARCADE_GUNGAME_PLACE_ID or u2.TESTING_ARCADE_GUNGAME_PLACE_ID;
local v3;

if u2.IS_STUDIO then
    v3 = not TestAttribute2;
else
    v3 = u2.IS_SERVER and u2.PRIVATE_SERVER_ID == "";
end;

u2.IS_PUBLIC_SERVER = v3;
local v4;

if u2.IS_STUDIO then
    v4 = TestAttribute2;
else
    v4 = u2.IS_SERVER and not u2.IS_PUBLIC_SERVER and u2.PRIVATE_SERVER_OWNER_ID == 0;
end;

u2.IS_RESERVED_SERVER = v4;

if not u2.IS_STUDIO then
    TestAttribute2 = u2.IS_SERVER and not u2.IS_PUBLIC_SERVER and u2.PRIVATE_SERVER_OWNER_ID ~= 0;
end;

u2.IS_PRIVATE_SERVER = TestAttribute2;
u2.IS_HUB_SERVER = u2.PLACE_ID == u2.HUB_PLACE_ID and true or u2.PLACE_ID == u2.MOBILE_PLACE_ID;
u2.IS_MOBILE_SERVER = u2.PLACE_ID == u2.MOBILE_PLACE_ID;
u2.IS_ARCADE_SERVER = (u2.PLACE_ID == u2.ARCADE_TEAMDEATHMATCH_PLACE_ID or u2.PLACE_ID == u2.ARCADE_FREEFORALL_PLACE_ID) and true or u2.PLACE_ID == u2.ARCADE_GUNGAME_PLACE_ID;
u2.IS_MATCHMAKING_SERVER = u2.PLACE_ID == u2.MATCHMAKING_PLACE_ID;
u2.IS_PRIVATE_HUB_SERVER = u2.IS_HUB_SERVER and u2.IS_PRIVATE_SERVER;
u2.GROUP_ID = 3461453;
u2.TEAM_GROUP_ROLE_ID = 816494002;

function u2.IS_PRIVATE_SERVER_OWNER(p5) -- Line: 72
    -- upvalues: TestAttribute (copy), u2 (copy)
    return TestAttribute or u2.IS_TESTING_SERVER and not u2.IS_STUDIO or u2.IS_PRIVATE_HUB_SERVER and (u2.IS_STUDIO or u2.PRIVATE_SERVER_OWNER_ID == p5);
end;

function u2.SHOULD_ALWAYS_REPLICATE(p6) -- Line: 73
    -- upvalues: u2 (copy)
    return u2.IS_ARCADE_SERVER or u2.IS_MATCHMAKING_SERVER;
end;

u2.DEFAULT_WEAPONS = { "Assault Rifle", "Handgun", "Fists", "Grenade" };
u2.DEFAULT_MAPS = { "Arena", "Backrooms", "Construction", "Docks" };
u2.QUEUES_ACTIVE = u2.IS_HUB_SERVER;
u2.SHOOTING_RANGE_ACTIVE = u2.IS_HUB_SERVER or u2.IS_MATCHMAKING_SERVER;
u2.BASE_HEALTH = 150;
u2.BASE_WALKSPEED = 16;
u2.BASE_JUMPPOWER = 20;
u2.BASE_GRAVITY = 0.25;
u2.BASE_MASS = 14.381;
u2.SELF_DAMAGE_MULTIPLIER = 0;
u2.MAX_RAYCAST_DISTANCE = 400;
u2.RENDER_DISTANCE = 500;
u2.MAX_PARTY_SIZE = 5;
u2.BEGINNER_QUEUE_NAME = "2v2_beginner";
u2.BEGINNER_QUEUE_WINS = 10;
u2.WEAPON_REVEAL_TIME_OFFSET = 604800;
u2.WEAPON_EARLY_ACCESS_TIME_OFFSET = 86400;
u2.HEADSHOT_IMAGE = "https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=420&height=420&format=png";
u2.CONTROLS_IMAGES = {
    MouseKeyboard = "rbxassetid://17136633356",
    Touch = "rbxassetid://17136633510",
    Gamepad = "rbxassetid://17136633629",
    VR = "rbxassetid://17136765745"
};
u2.CONTROLS_IMAGES_CENTERED = {
    MouseKeyboard = "rbxassetid://88012714630436",
    Touch = "rbxassetid://113510944677126",
    Gamepad = "rbxassetid://110291144710849",
    VR = "rbxassetid://99115398611290"
};
u2.AIRBORNE_HUMANOID_STATES = {
    [Enum.HumanoidStateType.FallingDown] = true,
    [Enum.HumanoidStateType.Jumping] = true,
    [Enum.HumanoidStateType.Freefall] = true,
    [Enum.HumanoidStateType.Flying] = true,
    [Enum.HumanoidStateType.Jumping] = true,
    [Enum.HumanoidStateType.PlatformStanding] = true
};
u2.DUEL_HISTORY_MAX_SIZE = 20;
u2.MAX_BACKPACK_USE_QUANTITY = 100;
u2.MAX_EQUIPPABLE_WEAPONS = 4;
u2.MAX_EQUIPPABLE_EMOTES = 8;
u2.COSMETIC_IMAGES = {
    NONE_COSMETIC = "rbxassetid://17562770037",
    RANDOM_COSMETIC = "rbxassetid://94238795177693"
};
u2.MAX_DUEL_PAD_WINS_PER_DAY_BEFORE_BEING_BLOCKED = 25;
u2.DEFAULT_HEAD_ASSET_ID = 2432102561;
u2.LEVEL_REQUIRED_FOR_REWARDS_FROM_ARCADE_SERVERS = 100;
u2.MAX_STREAK_GAIN_FROM_DUEL_PADS = 50;

function u2.INIT() -- Line: 108
    -- upvalues: u2 (copy), u1 (copy), RequestConstants (copy)
    if u2.IS_SERVER then
        local u7 = {};

        for _, v in pairs(u1) do
            u7[v] = u2[v];
        end;

        function RequestConstants.OnServerInvoke() -- Line: 116
            -- upvalues: u7 (copy)
            return u7;
        end;

        return;
    end;

    if not u2.IS_CLIENT then
        return;
    end;

    local v8;

    while true do
        local v9;
        v9, v8 = pcall(RequestConstants.InvokeServer, RequestConstants);

        if v9 then
            break;
        end;

        warn("Constants failed to fetch, error:", v8);
        wait(1);
    end;

    for i, v in pairs(v8) do
        u2[i] = v;
    end;
end;

return u2;