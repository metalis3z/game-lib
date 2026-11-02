-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u3 = {
    IS_ACTIVE = false,
    VERSION = 4,
    START_TIME = not CONSTANTS.IS_STUDIO and 1765515600 or os.time(),
    Rewards = {},
    NumRewards = 0,

    GetTimeUntilRefresh = function(p1) -- Line: 19, Name: GetTimeUntilRefresh
        -- upvalues: ServerOsTime (copy)
        local v2 = ServerOsTime:GetRounded() / 86400;

        return math.ceil(v2) * 86400 - ServerOsTime:GetRounded();
    end
};

function u3.GetReward(p4, p5) -- Line: 23
    -- upvalues: ServerOsTime (copy), u3 (copy)
    local v6 = (ServerOsTime:Get() - u3.START_TIME) / 86400;
    local v7 = math.floor(v6) + 1 + (p5 or 0);

    for _, v in pairs(u3.Rewards) do
        if v.Day == v7 then
            return v, v7;
        end;
    end;
end;

local function add_reward(...) -- Line: 33
    -- upvalues: u3 (copy), Utility (copy)
    local v8 = u3.NumRewards + 1;
    local v9 = { ... };

    for _, v in pairs({}) do
        table.insert(v9, Utility:CloneTable(v));
    end;

    u3.Rewards[v8] = {
        Day = v8,
        StartTime = u3.START_TIME + (v8 - 1) * 86400,
        Rewards = v9
    };
    local v10 = u3;
    v10.NumRewards = v10.NumRewards + 1;
end;

return u3;