-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local u1 = {
    Kevin_DJiceninja = {
        UserID = 1544275061,
        Cosmetics = { "Hyper Sniper", "Apex Pistols", "Bat Daggers" }
    },
    SooHui_PH2 = {
        UserID = 1796756117,
        Cosmetics = { "Spaceship Launcher", "Boba Gun", "Riptide Katana" }
    },
    mozzywalkstheplank = {
        UserID = 10763717,
        Cosmetics = { "Keyttle Axe", "Spider Web", "Energy Shield", "Wrapped Freeze Ray", "Keyshot", "Waffle Cone", "Fish Scales", "Neapolitan", "Tidal", "Spectralized", "Sundae Launcher", "Coconut Launcher", "Palm Scythe", "Crab Claws", "Splattered", "Enerkey Rifle", "Enerkey Pistols" }
    },
    Invicibrow = {
        UserID = 7207159625,
        Cosmetics = { "Gearnade Launcher", "Squid Launcher", "Notebook Satchel", "Mega Drill", "Masterpiece" }
    },
    NPC2Z = {
        UserID = 446253736,
        Cosmetics = { "Water Balloon", "Soul Grenade", "Bounce House" }
    },
    NSK0815 = {
        UserID = 3746614610,
        Cosmetics = { "Bag o\' Money", "Ban Axe" }
    },
    tazd = {
        UserID = 343054539,
        Cosmetics = { "Medkitty" }
    },
    TheMonkeyMasterSeb = {
        UserID = 4830771682,
        Cosmetics = { "Hourglass" }
    },
    ayroyuusho123 = {
        UserID = 4382977409,
        Cosmetics = { "Fighter Jet" }
    },
    myxushi = {
        UserID = 436956865,
        Cosmetics = { "Mimic Axe" }
    },
    S3ntraMyst1c = {
        UserID = 3751863229,
        Cosmetics = { "Cerulean Axe", "Repulsor" }
    },
    StrangerHades0 = {
        UserID = 4942063762,
        Cosmetics = { "Event Horizon" }
    },
    ACrystalPirate = {
        UserID = 2592938109,
        Cosmetics = { "Neon Lights", "Regal" }
    },
    MunchFish = {
        UserID = 1544233658,
        Cosmetics = { "Candy Apple" }
    },
    BobbVX = {
        UserID = 301707243,
        Cosmetics = { "Cardboard" }
    },
    Z0Z_Gaming = {
        UserID = 874685655,
        Cosmetics = { "Diamond" }
    },
    nekoanims = {
        UserID = 780350915,
        Cosmetics = { "Hammered Copper", "Honeycomb" }
    },
    SpunkyKatane = {
        UserID = 1325102532,
        Cosmetics = { "Jolly Man", "Plasma Distortion" }
    },
    TylkonTylko = {
        UserID = 4192733792,
        Cosmetics = { "Beloved Bow" }
    },
    Salllu_78 = {
        UserID = 1142556567,
        Cosmetics = { "Key Spray" }
    },
    emiiluumii = {
        UserID = 5010662019,
        Cosmetics = { "Arch Molotov" }
    },
    Galaxywolfibrar = {
        UserID = 1511223890,
        Cosmetics = { "Lighthouse" }
    },
    bladesof_fir3 = {
        UserID = 5239484609,
        Cosmetics = { "Chark Kebab" }
    },
    ["99kRom"] = {
        UserID = 724399676,
        Cosmetics = { "Palmshot" }
    },
    Kisasage = {
        UserID = 7156056199,
        Cosmetics = { "Hazard Sign" }
    },
    T0Wa_chan = {
        UserID = 1442276929,
        Cosmetics = { "Snowblob" }
    },
    Juanicho2021 = {
        UserID = 2660279857,
        Cosmetics = { "Plunger" }
    },
    konenro = {
        UserID = 10960176795,
        Cosmetics = { "Arcade Claw" }
    },
    fertmeny = {
        UserID = 660553399,
        Cosmetics = { "Genie Lamp" }
    },
    FishingFlare = {
        UserID = 4163861479,
        Cosmetics = { "Starforge Maul", "Starforge Permafrost" }
    },
    ["0RAFO9"] = {
        UserID = 260550404,
        Cosmetics = { "Keythe" }
    }
};
local u2 = {
    CONCEPT_REWARD_NAME = "Scribble",
    Leaderboard = {},
    Conceptors = {}
};

function u2.GetConceptors(p3, p4) -- Line: 139
    -- upvalues: u2 (copy)
    local v5 = {};

    for i, v in pairs(u2.Conceptors) do
        if table.find(v.CosmeticConcepts, p4) then
            table.insert(v5, i);
        end;
    end;

    return v5;
end;

function u2.GetConceptScore(p6, p7) -- Line: 151
    -- upvalues: u2 (copy)
    local v8 = u2.Conceptors[tostring(p7)];

    if not v8 then
        return 0;
    end;

    local v9 = 0;

    for _, v in pairs(v8.CosmeticConcepts) do
        local v10 = #u2:GetConceptors(v);

        if v10 == 0 then
            warn("??? Conceptors for cosmetic " .. v .. " == 0");
        else
            v9 = v9 + 1 / v10;
        end;
    end;

    return v9;
end;

function u2.GetNextMilestone(p11, p12) -- Line: 174
    -- upvalues: u2 (copy)
    for i, v in pairs(u2.Milestones) do
        if p12 < v[1] then
            return v, u2.Milestones[i - 1];
        end;
    end;
end;

local function add_conceptor(p13, p14) -- Line: 182
    -- upvalues: CosmeticLibrary (copy), u2 (copy)
    local v15;

    if typeof(p13) == "number" then
        v15 = p13 ~= 0;
    else
        v15 = false;
    end;

    assert(v15);
    local v16 = {};

    for i = #p14, 1, -1 do
        local v17 = p14[i];
        local v18;

        if CosmeticLibrary.Cosmetics[v17] then
            assert(not v16[v17], "Item entered in more than once: " .. v17);
            v16[v17] = true;
            v18 = i;
        else
            table.remove(p14, i);
            task.spawn(error, "Item doesnt exist: " .. v17);
            v18 = i;
        end;
    end;

    local v19 = {
        UserID = p13,
        CosmeticConcepts = p14 or {}
    };
    u2.Conceptors[tostring(v19.UserID)] = v19;
    local v20 = {
        value = nil,
        key = tostring(p13)
    };
    table.insert(u2.Leaderboard, v20);
end;

for _, v in pairs(u1) do
    add_conceptor(v.UserID, v.Cosmetics);
end;

(function() -- Line: 219, Name: sort_leaderboard
    -- upvalues: u2 (copy), u1 (copy)
    for _, v in pairs(u2.Leaderboard) do
        v.value = u2:GetConceptScore(v.key);
    end;

    table.sort(u2.Leaderboard, function(p21, p22) -- Line: 224
        return p21.value > p22.value;
    end);
    local v23 = {};

    for _, v in pairs(u1) do
        if v23[v.UserID] then
            error("[CONCEPTS] Duplicate User ID:", v.UserID);
        end;

        v23[v.UserID] = true;
    end;
end)();

return u2;