-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
require(ReplicatedStorage.Modules.DuelLibrary);
require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {
    ["Assault Rifle"] = { "Blue", "Desert Camo", "Chibi Assault Rifle" },
    Bow = { "Red", "Forest Camo", "Chibi Bow" },
    ["Burst Rifle"] = { "Orange", "Arctic Camo", "Chibi Burst Rifle" },
    Flamethrower = { "Maize", "Scorched", "Chibi Flamethrower" },
    ["Grenade Launcher"] = { "Surge", "Glass", "Chibi Grenade Launcher" },
    Minigun = { "Spartan", "Malevolent", "Chibi Minigun" },
    ["Paintball Gun"] = { "Medium stone grey", "Omnisand", "Chibi Paintball Gun" },
    RPG = { "Teal", "Swirls", "Chibi RPG" },
    Shotgun = { "Purple", "Reptile", "Chibi Shotgun" },
    Sniper = { "Blush", "Patriot", "Chibi Sniper" },
    ["Flare Gun"] = { "Green", "PB & J", "Chibi Flare Gun" },
    Handgun = { "Yellow", "Digital Camo", "Chibi Handgun" },
    Exogun = { "Vile", "Quasar", "Chibi Exogun" },
    Revolver = { "Mint", "Street Camo", "Chibi Revolver" },
    Shorty = { "Sky", "Steel", "Chibi Shorty" },
    Slingshot = { "Studs", "Hesper", "Chibi Slingshot" },
    Uzi = { "Lemon", "Ocean Camo", "Chibi Uzi" },
    Chainsaw = { "Olive", "Circuit", "Chibi Chainsaw" },
    Fists = { "Salmon", "Rug", "Chibi Fists" },
    Katana = { "Crimson", "Clouds", "Chibi Katana" },
    Knife = { "Highlighter", "Urban Camo", "Chibi Knife" },
    Scythe = { "Navy", "Frosted", "Chibi Scythe" },
    Trowel = { "Inlets", "Slime", "Chibi Trowel" },
    Flashbang = { "Maroon", "Carpet", "Chibi Flashbang" },
    Grenade = { "Beige", "Brain", "Chibi Grenade" },
    Medkit = { "OranGG", "Water", "Chibi Medkit" },
    Molotov = { "Pink", "Mainframe", "Chibi Molotov" },
    ["Smoke Grenade"] = { "Brown", "Honeycomb", "Chibi Smoke Grenade" },
    ["Subspace Tripmine"] = { "Universal", "Black Opal", "Chibi Subspace Tripmine" },
    ["Freeze Ray"] = { "Cool", "Crossed", "Chibi Freeze Ray" },
    ["Energy Rifle"] = { "Termination", ".exe", "Chibi Energy Rifle" },
    ["Energy Pistols"] = { "Eco", "Sunset", "Chibi Energy Pistols" },
    Crossbow = { "Lumber", "Spellslinger", "Chibi Crossbow" },
    Daggers = { "Venom", "Fiery", "Chibi Daggers" },
    ["Battle Axe"] = { "MaGGenta", "Carmine", "Chibi Battle Axe" },
    ["War Horn"] = { "Ornate", "Voltaic", "Chibi War Horn" },
    Satchel = { "Cheese", "Money", "Chibi Satchel" },
    ["Riot Shield"] = { "Bluesteel", "Portal", "Chibi Riot Shield" },
    Spray = { "Stained", "Igneous", "Chibi Spray" },
    Gunblade = { "Gunmetal", "Celtic", "Chibi Gunblade" },
    ["Jump Pad"] = { "Olo", "Dawn", "Chibi Jump Pad" },
    Distortion = { "Bee", "Aegis", "Chibi Distortion" },
    Warper = { "Mint Choco Chip", "Fracture", "Chibi Warper" },
    Warpstone = { "Bliss", "Devourer", "Chibi Warpstone" },
    Maul = { "Cold Metal", "Plaid Pajama", "Chibi Maul" },
    Permafrost = { "Luxe", "Blizzard", "Chibi Permafrost" },
    Spear = { "Galvanized", "Mossy Stone", "Chibi Spear" },
    Grappler = { "Quartz", "Orichalcum", "Chibi Grappler" },
    Wildcat = { "Toxin", "Rafflesia", "Chibi Wildcat" }
};
local u17 = {
    Types = {},
    Contracts = {},
    WeaponContracts = {},
    MapContracts = {},

    GetWeaponContracts = function(p2, p3) -- Line: 117, Name: GetWeaponContracts
        return p2.WeaponContracts[p3] or {};
    end,

    GetMapContracts = function(p4, p5) -- Line: 121, Name: GetMapContracts
        return p4.MapContracts[p5] or {};
    end,

    GetContractNamesByStatistic = function(p6, p7, p8, p9) -- Line: 125, Name: GetContractNamesByStatistic
        local v10 = {};

        for i, v in pairs(p6.Contracts) do
            if v.Type == p7 and (v.Identifier == p8 and (v.StatisticName == p9 or table.find(v.ExtraStatisticNames, p9))) then
                table.insert(v10, i);
            end;
        end;

        return v10;
    end,

    GetWeaponContractNamesByStatistic = function(p11, p12, p13) -- Line: 137, Name: GetWeaponContractNamesByStatistic
        return p11:GetContractNameByStatistic("Weapon", p12, p13);
    end,

    GetMapContractNamesByStatistic = function(p14, p15, p16) -- Line: 141, Name: GetMapContractNamesByStatistic
        return p14:GetContractNameByStatistic("Map", p15, p16);
    end
};

local function add_type(p18) -- Line: 145
    -- upvalues: u17 (copy)
    u17.Types[p18] = {};
end;

u17.Types.Weapon = {};
u17.Types.Map = {};

local function add_contract(p19, p20, p21, p22, p23, p24, p25) -- Line: 156
    -- upvalues: u17 (copy), StatisticsLibrary (copy)
    assert(u17.Types[p19]);
    assert(not u17.Contracts[p20]);

    for _, v in pairs(p23) do
        v[1] = math.ceil(v[1]);
    end;

    local v26 = {
        FullDisplayName = "",
        Type = p19,
        Name = p20,
        Identifier = p21,
        StatisticName = p22,
        Milestones = p23,
        ExtraStatisticNames = p24 or {}
    };

    for _, v in pairs({
        { v26.StatisticName },
        v26.ExtraStatisticNames
    }) do
        for _, v2 in pairs(v) do
            v26.FullDisplayName = v26.FullDisplayName .. (v26.FullDisplayName == "" and "" or " + ") .. StatisticsLibrary.Info[v2].FullDisplayName;
        end;
    end;

    for i, v in pairs(p25) do
        v26[i] = v;
    end;

    u17.Contracts[p20] = v26;

    return v26;
end;

local function add_weapon_contract(p27, p28, p29, p30, p31) -- Line: 192
    -- upvalues: ShopLibrary (copy), Utility (copy), u1 (copy), CosmeticLibrary (copy), add_contract (copy), u17 (copy)
    local v32 = p27 == "MISSING_WEAPON" and p27 and p27 or (ShopLibrary:IsWeaponReleased(p27) and p27 and p27 or "unreleased weapon");
    local string_format_ret = string.format("Earned from %s %s weapon contract", Utility:GetProperArticle(v32), v32);

    for _, v in pairs(u1[p27]) do
        CosmeticLibrary:ExternallySetCosmeticDescription(v, string_format_ret);
    end;

    add_contract("Weapon", p28, p27, p29, p30, p31, {});
    u17.WeaponContracts[p27] = u17.WeaponContracts[p27] or {};
    table.insert(u17.WeaponContracts[p27], p28);
end;

local function get_weapon_contract_reward(p33, p34, p35) -- Line: 210
    -- upvalues: u1 (copy)
    if p33 == "Performance" then
        return ({
            {
                Name = "Key",
                Quantity = 1
            },
            {
                Name = "Charm Capsule",
                Quantity = 1,
                Weapon = p35
            },
            {
                Name = "Charm Capsule",
                Quantity = 1,
                Weapon = p35
            },
            {
                Name = "Wrap Box",
                Quantity = 1,
                Weapon = p35
            },
            {
                Name = "Gold",
                Weapon = p35
            },
            {
                Name = "Diamond",
                Weapon = p35
            },
            {
                Name = "Midas Touch",
                Weapon = p35
            },
            {
                Name = "Diamond Hands",
                Weapon = p35
            },
            {
                Name = "Dark Matter",
                Weapon = p35
            }
        })[p34];
    end;

    if p33 == "Playtime" then
        return ({
            {
                Name = "Key",
                Quantity = 1
            },
            {
                Name = "Charm Capsule",
                Quantity = 1,
                Weapon = p35
            },
            {
                Weapon = "IsUniversal",
                Name = u1[p35][1]
            },
            {
                Name = "Charm Capsule",
                Quantity = 1,
                Weapon = p35
            },
            {
                Name = "Wrap Box",
                Quantity = 1,
                Weapon = p35
            },
            {
                Weapon = "IsUniversal",
                Name = u1[p35][2]
            },
            {
                Name = "Wrap Box 2",
                Quantity = 1,
                Weapon = p35
            },
            {
                Weapon = "IsUniversal",
                Name = u1[p35][3]
            }
        })[p34];
    end;

    assert(false, "???");
end;

local function add_weapon_elimination_contract(p36, p37) -- Line: 252
    -- upvalues: add_weapon_contract (copy), get_weapon_contract_reward (copy)
    add_weapon_contract(p36, p36 .. " Eliminations", "StatisticEliminations", {
        { 5 * p37, get_weapon_contract_reward("Performance", 1, p36) },
        { 20 * p37, get_weapon_contract_reward("Performance", 2, p36) },
        { 100 * p37, get_weapon_contract_reward("Performance", 3, p36) },
        { 500 * p37, get_weapon_contract_reward("Performance", 4, p36) },
        { 2000 * p37, get_weapon_contract_reward("Performance", 5, p36) },
        { 10000 * p37, get_weapon_contract_reward("Performance", 6, p36) },
        { 20000 * p37, get_weapon_contract_reward("Performance", 7, p36) },
        { 30000 * p37, get_weapon_contract_reward("Performance", 8, p36) },
        { 40000 * p37, get_weapon_contract_reward("Performance", 9, p36) }
    });
end;

local function add_weapon_playtime_contract(p38) -- Line: 239
    -- upvalues: add_weapon_contract (copy), get_weapon_contract_reward (copy)
    add_weapon_contract(p38, p38 .. " Playtime", "StatisticPlaytime", {
        { 300, get_weapon_contract_reward("Playtime", 1, p38) },
        { 1200, get_weapon_contract_reward("Playtime", 2, p38) },
        { 3600, get_weapon_contract_reward("Playtime", 3, p38) },
        { 21600, get_weapon_contract_reward("Playtime", 4, p38) },
        { 43200, get_weapon_contract_reward("Playtime", 5, p38) },
        { 86400, get_weapon_contract_reward("Playtime", 6, p38) },
        { 172800, get_weapon_contract_reward("Playtime", 7, p38) },
        { 259200, get_weapon_contract_reward("Playtime", 8, p38) }
    });
end;

local v39 = { "Fists", "Knife", "Chainsaw", "Katana", "Scythe", "Trowel", "Battle Axe", "Maul", "Spear" };
local v40 = { "Arena", "Big Graveyard", "Docks", "Splash", "Bridge", "Crossroads", "Big Crossroads", "Shooting Range", "Big Backrooms", "Battleground", "Big Arena", "Construction", "Playground", "Onyx", "Graveyard", "Big Splash", "Big Onyx", "Backrooms", "Station", "Dimension", "Iceberg", "Village", "Chess", "Big Station", "Westown", "Studio", "Museum", "Sandbox" };
local u41 = {
    Arena = { "Diorama Arena" },
    ["Big Graveyard"] = { "Diorama Big Graveyard" },
    Docks = { "Diorama Docks" },
    Splash = { "Diorama Splash" },
    Bridge = { "Diorama Bridge" },
    Crossroads = { "Diorama Crossroads" },
    ["Big Crossroads"] = { "Diorama Big Crossroads" },
    ["Shooting Range"] = { "Diorama Shooting Range" },
    ["Big Backrooms"] = { "Diorama Big Backrooms" },
    Battleground = { "Diorama Battleground" },
    ["Big Arena"] = { "Diorama Big Arena" },
    Construction = { "Diorama Construction" },
    Playground = { "Diorama Playground" },
    Onyx = { "Diorama Onyx" },
    Graveyard = { "Diorama Graveyard" },
    ["Big Splash"] = { "Diorama Big Splash" },
    ["Big Onyx"] = { "Diorama Big Onyx" },
    Backrooms = { "Diorama Backrooms" },
    Station = { "Diorama Station" },
    Dimension = { "Diorama Dimension" },
    Iceberg = { "Diorama Iceberg" },
    Village = { "Diorama Village" },
    Chess = { "Diorama Chess" },
    ["Big Station"] = { "Diorama Big Station" },
    Westown = { "Diorama Westown" },
    Studio = { "Diorama Studio" },
    Museum = { "Diorama Museum" },
    Sandbox = { "Diorama Sandbox" }
};
local v42 = {};

for _, v in pairs({ "Assault Rifle", "Handgun", "Burst Rifle", "Sniper", "RPG", "Shorty", "Shotgun", "Bow", "Uzi", "Revolver", "Paintball Gun", "Slingshot", "Grenade Launcher", "Minigun", "Exogun", "Flamethrower", "Daggers", "Energy Pistols", "Energy Rifle", "Spray", "Crossbow", "Gunblade", "Distortion", "Permafrost", "Wildcat" }) do
    add_weapon_elimination_contract(v, 1);
    add_weapon_playtime_contract(v);
end;

for _, v in pairs(v39) do
    add_weapon_elimination_contract(v, 0.5);
    add_weapon_playtime_contract(v);
end;

add_weapon_contract("Smoke Grenade", "Smoke Grenade Smokeds", "StatisticSmokedsEnemies", {
    { 1, get_weapon_contract_reward("Performance", 1, "Smoke Grenade") },
    { 5, get_weapon_contract_reward("Performance", 2, "Smoke Grenade") },
    { 20, get_weapon_contract_reward("Performance", 3, "Smoke Grenade") },
    { 75, get_weapon_contract_reward("Performance", 4, "Smoke Grenade") },
    { 200, get_weapon_contract_reward("Performance", 5, "Smoke Grenade") },
    { 1000, get_weapon_contract_reward("Performance", 6, "Smoke Grenade") },
    { 4000, get_weapon_contract_reward("Performance", 9, "Smoke Grenade") }
});
add_weapon_playtime_contract("Smoke Grenade");
add_weapon_contract("Flashbang", "Flashbang Blinds", "StatisticBlindsEnemies", {
    { 1, get_weapon_contract_reward("Performance", 1, "Flashbang") },
    { 10, get_weapon_contract_reward("Performance", 2, "Flashbang") },
    { 50, get_weapon_contract_reward("Performance", 3, "Flashbang") },
    { 200, get_weapon_contract_reward("Performance", 4, "Flashbang") },
    { 500, get_weapon_contract_reward("Performance", 5, "Flashbang") },
    { 2500, get_weapon_contract_reward("Performance", 6, "Flashbang") },
    { 10000, get_weapon_contract_reward("Performance", 9, "Flashbang") }
});
add_weapon_playtime_contract("Flashbang");
add_weapon_contract("Medkit", "Medkit Heals", "StatisticHealsGiven", {
    { 150, get_weapon_contract_reward("Performance", 1, "Medkit") },
    { 500, get_weapon_contract_reward("Performance", 2, "Medkit") },
    { 2500, get_weapon_contract_reward("Performance", 3, "Medkit") },
    { 12000, get_weapon_contract_reward("Performance", 4, "Medkit") },
    { 50000, get_weapon_contract_reward("Performance", 5, "Medkit") },
    { 140000, get_weapon_contract_reward("Performance", 6, "Medkit") },
    { 560000, get_weapon_contract_reward("Performance", 9, "Medkit") }
});
add_weapon_playtime_contract("Medkit");
add_weapon_contract("Freeze Ray", "Freeze Ray Freezes", "StatisticFreezesEnemies", {
    { 1, get_weapon_contract_reward("Performance", 1, "Freeze Ray") },
    { 10, get_weapon_contract_reward("Performance", 2, "Freeze Ray") },
    { 50, get_weapon_contract_reward("Performance", 3, "Freeze Ray") },
    { 200, get_weapon_contract_reward("Performance", 4, "Freeze Ray") },
    { 500, get_weapon_contract_reward("Performance", 5, "Freeze Ray") },
    { 2500, get_weapon_contract_reward("Performance", 6, "Freeze Ray") },
    { 10000, get_weapon_contract_reward("Performance", 9, "Freeze Ray") }
});
add_weapon_playtime_contract("Freeze Ray");
add_weapon_contract("Flare Gun", "Flare Gun Damage Dealt", "StatisticDamageDealt", {
    { 100, get_weapon_contract_reward("Performance", 1, "Flare Gun") },
    { 500, get_weapon_contract_reward("Performance", 2, "Flare Gun") },
    { 2500, get_weapon_contract_reward("Performance", 3, "Flare Gun") },
    { 12000, get_weapon_contract_reward("Performance", 4, "Flare Gun") },
    { 50000, get_weapon_contract_reward("Performance", 5, "Flare Gun") },
    { 140000, get_weapon_contract_reward("Performance", 6, "Flare Gun") },
    { 280000, get_weapon_contract_reward("Performance", 7, "Flare Gun") },
    { 420000, get_weapon_contract_reward("Performance", 8, "Flare Gun") },
    { 560000, get_weapon_contract_reward("Performance", 9, "Flare Gun") }
});
add_weapon_playtime_contract("Flare Gun");
add_weapon_contract("Grenade", "Grenade Damage Dealt", "StatisticDamageDealt", {
    { 100, get_weapon_contract_reward("Performance", 1, "Grenade") },
    { 500, get_weapon_contract_reward("Performance", 2, "Grenade") },
    { 2500, get_weapon_contract_reward("Performance", 3, "Grenade") },
    { 12000, get_weapon_contract_reward("Performance", 4, "Grenade") },
    { 50000, get_weapon_contract_reward("Performance", 5, "Grenade") },
    { 140000, get_weapon_contract_reward("Performance", 6, "Grenade") },
    { 280000, get_weapon_contract_reward("Performance", 7, "Grenade") },
    { 420000, get_weapon_contract_reward("Performance", 8, "Grenade") },
    { 560000, get_weapon_contract_reward("Performance", 9, "Grenade") }
});
add_weapon_playtime_contract("Grenade");
add_weapon_contract("Molotov", "Molotov Damage Dealt", "StatisticDamageDealt", {
    { 100, get_weapon_contract_reward("Performance", 1, "Molotov") },
    { 500, get_weapon_contract_reward("Performance", 2, "Molotov") },
    { 2500, get_weapon_contract_reward("Performance", 3, "Molotov") },
    { 12000, get_weapon_contract_reward("Performance", 4, "Molotov") },
    { 50000, get_weapon_contract_reward("Performance", 5, "Molotov") },
    { 140000, get_weapon_contract_reward("Performance", 6, "Molotov") },
    { 280000, get_weapon_contract_reward("Performance", 7, "Molotov") },
    { 420000, get_weapon_contract_reward("Performance", 8, "Molotov") },
    { 560000, get_weapon_contract_reward("Performance", 9, "Molotov") }
});
add_weapon_playtime_contract("Molotov");
add_weapon_contract("Subspace Tripmine", "Subspace Tripmine Damage Dealt", "StatisticDamageDealt", {
    { 100, get_weapon_contract_reward("Performance", 1, "Subspace Tripmine") },
    { 500, get_weapon_contract_reward("Performance", 2, "Subspace Tripmine") },
    { 2500, get_weapon_contract_reward("Performance", 3, "Subspace Tripmine") },
    { 12000, get_weapon_contract_reward("Performance", 4, "Subspace Tripmine") },
    { 50000, get_weapon_contract_reward("Performance", 5, "Subspace Tripmine") },
    { 140000, get_weapon_contract_reward("Performance", 6, "Subspace Tripmine") },
    { 280000, get_weapon_contract_reward("Performance", 7, "Subspace Tripmine") },
    { 420000, get_weapon_contract_reward("Performance", 8, "Subspace Tripmine") },
    { 560000, get_weapon_contract_reward("Performance", 9, "Subspace Tripmine") }
});
add_weapon_playtime_contract("Subspace Tripmine");
add_weapon_contract("War Horn", "War Horn Empowers", "StatisticEmpowers", {
    { 3, get_weapon_contract_reward("Performance", 1, "War Horn") },
    { 50, get_weapon_contract_reward("Performance", 2, "War Horn") },
    { 250, get_weapon_contract_reward("Performance", 3, "War Horn") },
    { 1250, get_weapon_contract_reward("Performance", 4, "War Horn") },
    { 5000, get_weapon_contract_reward("Performance", 5, "War Horn") },
    { 10000, get_weapon_contract_reward("Performance", 6, "War Horn") },
    { 40000, get_weapon_contract_reward("Performance", 9, "War Horn") }
});
add_weapon_playtime_contract("War Horn");
add_weapon_contract("Satchel", "Satchel Damage Dealt", "StatisticDamageDealt", {
    { 100, get_weapon_contract_reward("Performance", 1, "Satchel") },
    { 500, get_weapon_contract_reward("Performance", 2, "Satchel") },
    { 2500, get_weapon_contract_reward("Performance", 3, "Satchel") },
    { 12000, get_weapon_contract_reward("Performance", 4, "Satchel") },
    { 50000, get_weapon_contract_reward("Performance", 5, "Satchel") },
    { 140000, get_weapon_contract_reward("Performance", 6, "Satchel") },
    { 280000, get_weapon_contract_reward("Performance", 7, "Satchel") },
    { 420000, get_weapon_contract_reward("Performance", 8, "Satchel") },
    { 560000, get_weapon_contract_reward("Performance", 9, "Satchel") }
});
add_weapon_playtime_contract("Satchel");
add_weapon_contract("Riot Shield", "Riot Shield Heals", "StatisticAbsorbs", {
    { 300, get_weapon_contract_reward("Performance", 1, "Riot Shield") },
    { 1000, get_weapon_contract_reward("Performance", 2, "Riot Shield") },
    { 5000, get_weapon_contract_reward("Performance", 3, "Riot Shield") },
    { 24000, get_weapon_contract_reward("Performance", 4, "Riot Shield") },
    { 100000, get_weapon_contract_reward("Performance", 5, "Riot Shield") },
    { 280000, get_weapon_contract_reward("Performance", 6, "Riot Shield") },
    { 560000, get_weapon_contract_reward("Performance", 7, "Riot Shield") },
    { 840000, get_weapon_contract_reward("Performance", 8, "Riot Shield") },
    { 1120000, get_weapon_contract_reward("Performance", 9, "Riot Shield") }
});
add_weapon_playtime_contract("Riot Shield");
add_weapon_contract("Jump Pad", "Jump Pad Bounces", "StatisticBounces", {
    { 1, get_weapon_contract_reward("Performance", 1, "Jump Pad") },
    { 25, get_weapon_contract_reward("Performance", 2, "Jump Pad") },
    { 120, get_weapon_contract_reward("Performance", 3, "Jump Pad") },
    { 500, get_weapon_contract_reward("Performance", 4, "Jump Pad") },
    { 1500, get_weapon_contract_reward("Performance", 5, "Jump Pad") },
    { 4500, get_weapon_contract_reward("Performance", 6, "Jump Pad") },
    { 18000, get_weapon_contract_reward("Performance", 9, "Jump Pad") }
});
add_weapon_playtime_contract("Jump Pad");
add_weapon_contract("Warper", "Warper Portals Spawned", "StatisticPortalsSpawned", {
    { 1, get_weapon_contract_reward("Performance", 1, "Warper") },
    { 10, get_weapon_contract_reward("Performance", 2, "Warper") },
    { 50, get_weapon_contract_reward("Performance", 3, "Warper") },
    { 200, get_weapon_contract_reward("Performance", 4, "Warper") },
    { 500, get_weapon_contract_reward("Performance", 5, "Warper") },
    { 2500, get_weapon_contract_reward("Performance", 6, "Warper") },
    { 10000, get_weapon_contract_reward("Performance", 9, "Warper") }
});
add_weapon_playtime_contract("Warper");
add_weapon_contract("Warpstone", "Warpstone Warps", "StatisticWarps", {
    { 1, get_weapon_contract_reward("Performance", 1, "Warpstone") },
    { 10, get_weapon_contract_reward("Performance", 2, "Warpstone") },
    { 50, get_weapon_contract_reward("Performance", 3, "Warpstone") },
    { 200, get_weapon_contract_reward("Performance", 4, "Warpstone") },
    { 500, get_weapon_contract_reward("Performance", 5, "Warpstone") },
    { 2500, get_weapon_contract_reward("Performance", 6, "Warpstone") },
    { 10000, get_weapon_contract_reward("Performance", 9, "Warpstone") }
});
add_weapon_playtime_contract("Warpstone");
add_weapon_contract("Grappler", "Grappler Hooks", "StatisticHooksEnemies", {
    { 1, get_weapon_contract_reward("Performance", 1, "Grappler") },
    { 10, get_weapon_contract_reward("Performance", 2, "Grappler") },
    { 50, get_weapon_contract_reward("Performance", 3, "Grappler") },
    { 200, get_weapon_contract_reward("Performance", 4, "Grappler") },
    { 500, get_weapon_contract_reward("Performance", 5, "Grappler") },
    { 2500, get_weapon_contract_reward("Performance", 6, "Grappler") },
    { 10000, get_weapon_contract_reward("Performance", 9, "Grappler") }
});
add_weapon_playtime_contract("Grappler");

local function add_map_contract(p43, p44, p45, p46, p47) -- Line: 471
    -- upvalues: add_contract (copy), u17 (copy)
    add_contract("Map", p44, p43, p45, p46, p47, {});
    u17.MapContracts[p43] = u17.MapContracts[p43] or {};
    table.insert(u17.MapContracts[p43], p44);
end;

local function get_map_contract_reward(p48, p49, p50) -- Line: 482
    -- upvalues: u41 (copy)
    if p48 == "Performance" then
        return ({
            {
                Name = "Key",
                Quantity = 1
            },
            {
                Name = "Charm Capsule",
                Weapon = "IsRandom",
                Quantity = 1
            },
            {
                Name = "Wrap Box",
                Weapon = "IsRandom",
                Quantity = 1
            },
            {
                Name = "Finisher Pack",
                Weapon = "IsRandom",
                Quantity = 1
            },
            {
                Name = "Key",
                Quantity = 4
            },
            {
                Weapon = "IsUniversal",
                Name = u41[p50][1]
            }
        })[p49];
    end;

    if p48 == "Playtime" then
        assert(false, "Not implemented yet");

        return;
    end;

    assert(false, "???");
end;

local function add_map_playtime_contract(p51) -- Line: 499
    -- upvalues: add_map_contract (copy), get_map_contract_reward (copy)
    add_map_contract(p51, p51 .. " Playtime", "StatisticPlaytime", {
        { 300, get_map_contract_reward("Playtime", 1, p51) },
        { 1200, get_map_contract_reward("Playtime", 2, p51) },
        { 3600, get_map_contract_reward("Playtime", 3, p51) },
        { 21600, get_map_contract_reward("Playtime", 4, p51) },
        { 43200, get_map_contract_reward("Playtime", 5, p51) },
        { 86400, get_map_contract_reward("Playtime", 6, p51) }
    });
end;

local function add_map_roundswon_contract(p52, p53) -- Line: 510
    -- upvalues: CosmeticLibrary (copy), u41 (copy), Utility (copy), add_map_contract (copy), get_map_contract_reward (copy)
    CosmeticLibrary:ExternallySetCosmeticDescription(u41[p52][1], string.format("Earned from %s %s map contract", Utility:GetProperArticle(p52), p52));
    add_map_contract(p52, p52 .. " Rounds Won", "StatisticRoundsWon", {
        { 10 * p53, get_map_contract_reward("Performance", 1, p52) },
        { 40 * p53, get_map_contract_reward("Performance", 2, p52) },
        { 100 * p53, get_map_contract_reward("Performance", 3, p52) },
        { 300 * p53, get_map_contract_reward("Performance", 4, p52) },
        { 600 * p53, get_map_contract_reward("Performance", 5, p52) },
        { 1000 * p53, get_map_contract_reward("Performance", 6, p52) }
    }, { "StatisticRankedRoundsWon" });
end;

for _, v in pairs(v40) do
    add_map_roundswon_contract(v, 1);
end;

for _, v in pairs(v42) do
    add_map_roundswon_contract(v, 0.5);
end;

(function() -- Line: 531, Name: assert_weapon_contracts
    -- upvalues: ShopLibrary (copy), u17 (copy)
    for _, v in pairs(ShopLibrary.OwnableWeapons) do
        local v54 = v;
        local v55 = false;

        for _, v2 in pairs(u17.Contracts) do
            if v2.Identifier == v54 then
                v55 = true;
                break;
            end;
        end;

        assert(v55, v54);
    end;
end)();

return u17;