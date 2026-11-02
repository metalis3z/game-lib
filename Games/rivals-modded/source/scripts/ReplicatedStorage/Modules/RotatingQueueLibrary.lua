-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local _ = CONSTANTS.IS_TESTING_SERVER;
local u1 = nil;
local u2 = u1 or 86400;
local math_floor_ret = math.floor(1755837328 / u2);
local u8 = {
    Info = {},
    Order = {},

    IsNewRelease = function(p3) -- Line: 17, Name: IsNewRelease
        return p3:GetCycle() <= 20539;
    end,

    GetOsTime = function(p4) -- Line: 21, Name: GetOsTime
        -- upvalues: ServerOsTime (copy)
        return ServerOsTime:Get() - -590400;
    end,

    GetCycle = function(p5) -- Line: 25, Name: GetCycle
        -- upvalues: u2 (copy)
        local v6 = p5:GetOsTime() / u2;

        return math.floor(v6);
    end,

    GetTimeUntilNext = function(p7) -- Line: 29, Name: GetTimeUntilNext
        -- upvalues: ServerOsTime (copy), u2 (copy)
        if p7:IsNewRelease() then
            return 1774065600 - ServerOsTime:Get();
        end;

        return (p7:GetCycle() + 1) * u2 - p7:GetOsTime();
    end
};

function u8.GetCurrent(p9) -- Line: 38
    -- upvalues: u8 (copy), CONSTANTS (copy), u1 (copy), math_floor_ret (copy)
    if p9:IsNewRelease() then
        return u8.Info.spleef;
    end;

    local v10 = CONSTANTS.IS_STUDIO and not u1 and 0 or (-1 / 0);
    local v11 = p9:GetCycle() - math_floor_ret;
    local math_max_ret = math.max(v10, v11);

    return u8.Info[u8.Order[math_max_ret % #u8.Order + 1]];
end;

function u8.IsValidQueueName(p12, p13) -- Line: 51
    return table.find(p12:GetCurrent().QueueNames, p13);
end;

local function add_rotating_queues(p14, ...) -- Line: 55
    -- upvalues: u8 (copy), DuelLibrary (copy)
    local v15 = {
        Name = p14,
        QueueNames = { ... }
    };
    u8.Info[p14] = v15;
    table.insert(u8.Order, p14);

    for _, v in pairs(v15.QueueNames) do
        assert(DuelLibrary.MatchmakingQueues[v] ~= nil, v);
    end;
end;

add_rotating_queues("juggernaut", "ltm_juggernaut_1v7");
add_rotating_queues("swiftstandoff", "ltm_swiftstandoff_1v1", "ltm_swiftstandoff_2v2", "ltm_swiftstandoff_3v3");
add_rotating_queues(
    "defaultduel_bunnysniping",
    "ltm_defaultduel_1v1",
    "ltm_defaultduel_2v2",
    "ltm_bunnysniping_2v2",
    "ltm_bunnysniping_3v3"
);
add_rotating_queues("tagteam", "ltm_tagteam_3v3", "ltm_tagteam_5v5");
add_rotating_queues(
    "chickengame",
    "ltm_chickengames_1v1",
    "ltm_chickengames_2v2",
    "ltm_chickengames_3v3",
    "ltm_chickengames_4v4"
);
add_rotating_queues("rivalsrng", "ltm_rivalsrng_1v1", "ltm_rivalsrng_2v2", "ltm_rivalsrng_3v3");
add_rotating_queues("headhoncho", "ltm_headhoncho_3v3", "ltm_headhoncho_4v4", "ltm_headhoncho_5v5");
add_rotating_queues("hardcoreparkour", "ltm_hardcoreparkour_1v1", "ltm_hardcoreparkour_2v2", "ltm_hardcoreparkour_5v5");
add_rotating_queues("doubletrouble", "ltm_doubletrouble_1v1", "ltm_doubletrouble", "ltm_doubletrouble_3v3");
add_rotating_queues("mirrormatchup", "ltm_mirrormatchup_1v1", "ltm_mirrormatchup_2v2", "ltm_mirrormatchup_3v3");
add_rotating_queues(
    "limitlessloadout",
    "ltm_limitlessloadout_1v1",
    "ltm_limitlessloadout_2v2",
    "ltm_limitlessloadout_3v3"
);
add_rotating_queues("threeteams", "1v1v1", "2v2v2", "3v3v3");
add_rotating_queues("spleef", "ltm_spleef_8v8");

return u8;