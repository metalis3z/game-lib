-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MaterialService = game:GetService("MaterialService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u39 = {
    IGNORE_TRANSPARENCY_WHITELIST = {
        ["Riot Shield"] = true
    },
    RENAMED_COSMETICS = {
        Hexxed = "Vexed",
        ["Hexxed Flare Gun"] = "Vexed Flare Gun",
        ["Hexxed Candle"] = "Vexed Candle",
        Rivals = "RIVALS",
        ["Bone Crossbow"] = "Crossbone",
        Bonestone = "Warpbone",
        ["2025 Energy Rifle"] = "New Year Energy Rifle",
        ["2025 Energy Pistols"] = "New Year Energy Pistols",
        ["2025 Katana"] = "New Year Katana",
        ["New Year Rifle"] = "New Year Energy Rifle",
        Poop = "Chocolate Scoop",
        ["Devil\'s Trident"] = "Evil Trident",
        ["Arena Diorama"] = "Diorama Arena",
        ["Backrooms Diorama"] = "Diorama Backrooms",
        ["Battleground Diorama"] = "Diorama Battleground",
        ["Big Arena Diorama"] = "Diorama Big Arena",
        ["Big Backrooms Diorama"] = "Diorama Big Backrooms",
        ["Big Crossroads Diorama"] = "Diorama Big Crossroads",
        ["Big Graveyard Diorama"] = "Diorama Big Graveyard",
        ["Big Onyx Diorama"] = "Diorama Big Onyx",
        ["Big Splash Diorama"] = "Diorama Big Splash",
        ["Big Station Diorama"] = "Diorama Big Station",
        ["Bridge Diorama"] = "Diorama Bridge",
        ["Chess Diorama"] = "Diorama Chess",
        ["Construction Diorama"] = "Diorama Construction",
        ["Crossroads Diorama"] = "Diorama Crossroads",
        ["Dimension Diorama"] = "Diorama Dimension",
        ["Docks Diorama"] = "Diorama Docks",
        ["Graveyard Diorama"] = "Diorama Graveyard",
        ["Iceberg Diorama"] = "Diorama Iceberg",
        ["Onyx Diorama"] = "Diorama Onyx",
        ["Playground Diorama"] = "Diorama Playground",
        ["Shooting Range Diorama"] = "Diorama Shooting Range",
        ["Splash Diorama"] = "Diorama Splash",
        ["Station Diorama"] = "Diorama Station",
        ["Village Diorama"] = "Diorama Village",
        FAMAS = "Bullpup Burst",
        ["Sand FAMAS"] = "Sand Bullpup Burst",
        AUG = "Augmented Rifle",
        ["Gingerbread AUG"] = "Gingerbread Augmented Rifle",
        ["Tommy Gun"] = "Drum Gun",
        ["RIA25 Award"] = "RIA25 Best Shooter"
    },
    Rarities = {},
    Types = {},
    Cosmetics = {},
    CosmeticsAlphabetized = {},
    CosmeticNameToLootbox = {},
    Rewards = {},
    LootboxOrder = {},

    OwnsCosmeticForWeapon = function(p1, p2, p3, p4) -- Line: 38, Name: OwnsCosmeticForWeapon
        return p2 and p2[p3] and p2[p3][p4];
    end,

    OwnsCosmeticUniversally = function(p5, p6, p7) -- Line: 42, Name: OwnsCosmeticUniversally
        return p6 and p6[p7] and p6[p7].IsUniversal;
    end,

    OwnsCosmeticNormally = function(p8, p9, p10) -- Line: 46, Name: OwnsCosmeticNormally
        if p9 then
            p9 = p9[p10] == true;
        end;

        return p9;
    end,

    OwnsCosmetic = function(p11, p12, p13, p14) -- Line: 50, Name: OwnsCosmetic
        return p11:OwnsCosmeticNormally(p12, p13) or (p11:OwnsCosmeticUniversally(p12, p13) or p11:OwnsCosmeticForWeapon(p12, p13, p14));
    end,

    OwnsCosmeticForSomething = function(p15, p16, p17) -- Line: 56, Name: OwnsCosmeticForSomething
        if p15:OwnsCosmeticNormally(p16, p17) then
            return true;
        end;

        for _, v in pairs(p16 and p16[p17] or {}) do
            if v then
                return true;
            end;
        end;
    end,

    HasNotification = function(p18, p19, p20, p21) -- Line: 68, Name: HasNotification
        if p19 and p19[p20] then
            return p19[p20] == true and true or p19[p20][p21];
        end;

        return false;
    end,

    CountNotificationsByWeapon = function(p22, p23, p24) -- Line: 76, Name: CountNotificationsByWeapon
        local v25 = 0;

        for _, v in pairs(p23) do
            if typeof(v) == "table" then
                for i in pairs(v) do
                    if i == p24 then
                        v25 = v25 + 1;
                    end;
                end;
            end;
        end;

        return v25;
    end,

    CountNotificationsByCosmeticType = function(p26, p27, p28, p29, p30) -- Line: 96, Name: CountNotificationsByCosmeticType
        local v31 = 0;

        for i, v in pairs(p27) do
            local v32 = p26.Cosmetics[i];

            if v32 and v32.Type == p28 then
                if typeof(v) == "table" then
                    for i2 in pairs(v) do
                        if (not p30 or p30[i2]) and i2 == p29 then
                            v31 = v31 + 1;
                        end;
                    end;
                elseif v == true then
                    v31 = v31 + 1;
                end;
            end;
        end;

        return v31;
    end,

    CountNotifications = function(p33, p34, p35, p36) -- Line: 124, Name: CountNotifications
        if not p35 then
            local v37 = 0;

            for i in pairs(p34) do
                v37 = v37 + p33:CountNotifications(p34, i, p36);
            end;

            return v37;
        end;

        if not (p34 and p34[p35]) then
            return 0;
        end;

        if p34[p35] == true then
            return 1;
        end;

        local v38 = 0;

        for i in pairs(p34[p35]) do
            if not p36 or p36[i] then
                v38 = v38 + 1;
            end;
        end;

        return v38;
    end
};

function u39.IsNoneSpecificCosmeticName(p40, p41) -- Line: 156
    -- upvalues: u39 (copy)
    for i, v in pairs(u39.Types) do
        if v.IsWeaponCosmetic and p41 == p40:GetNoneSpecificCosmeticName("NONE_COSMETIC", i) then
            return true;
        end;
    end;

    return false;
end;

function u39.GetNoneSpecificCosmeticName(p42, p43, p44) -- Line: 172
    -- upvalues: u39 (copy)
    assert(not p44 or u39.Types[p44].IsWeaponCosmetic);

    if p43 == "NONE_COSMETIC" then
        return p43 .. "_" .. p44;
    end;

    return p43;
end;

function u39.ExternallySetCosmeticDescription(p45, p46, p47) -- Line: 177
    -- upvalues: u39 (copy)
    if #p46 >= 8 and string.sub(p46, 1, 8) == "MISSING_" then
        return;
    end;

    assert(u39.Cosmetics[p46] ~= nil, p46);
    local Description = u39.Cosmetics[p46].Description;
    assert(not Description or Description == p47, p46);
    u39.Cosmetics[p46].Description = p47;
end;

local u48 = {};

local function add_cosmetic_rarity(p49, p50, p51) -- Line: 190
    -- upvalues: u39 (copy)
    u39.Rarities[p49] = {
        Value = p50,
        Color = p51
    };
end;

local v52 = {
    Value = 0,
    Color = Color3.fromRGB(255, 255, 255)
};
u39.Rarities.None = v52;
local v53 = {
    Value = 1,
    Color = Color3.fromRGB(255, 140, 0)
};
u39.Rarities.Unique = v53;
local v54 = {
    Value = 2,
    Color = Color3.fromRGB(123, 255, 0)
};
u39.Rarities.Common = v54;
local v55 = {
    Value = 3,
    Color = Color3.fromRGB(0, 221, 255)
};
u39.Rarities.Rare = v55;
local v56 = {
    Value = 4,
    Color = Color3.fromRGB(255, 0, 0)
};
u39.Rarities.Legendary = v56;
local v57 = {
    Value = 5,
    Color = Color3.fromRGB(64, 68, 186)
};
u39.Rarities.Mythical = v57;
local v58 = {
    Value = 6,
    Color = Color3.fromRGB(56, 80, 33)
};
u39.Rarities.Genuine = v58;
local v59 = {
    Value = 7,
    Color = Color3.fromRGB(0, 0, 0)
};
u39.Rarities.Unobtainable = v59;

local function add_cosmetic_type(p60, p61, p62, p63, p64) -- Line: 208
    -- upvalues: u39 (copy)
    u39.Types[p60] = {
        Name = p60,
        Value = p61,
        Image = p62,
        IsWeaponCosmetic = p63,
        NotCosmetic = p64
    };
end;

u39.Types.Reward = {
    Name = "Reward",
    Value = 0,
    Image = nil,
    IsWeaponCosmetic = nil,
    NotCosmetic = true
};
u39.Types.Charm = {
    Name = "Charm",
    Value = 1,
    Image = "rbxassetid://133391928250838",
    IsWeaponCosmetic = true,
    NotCosmetic = nil
};
u39.Types.Wrap = {
    Name = "Wrap",
    Value = 2,
    Image = "rbxassetid://112715941288555",
    IsWeaponCosmetic = true,
    NotCosmetic = nil
};
u39.Types.Finisher = {
    Name = "Finisher",
    Value = 3,
    Image = "rbxassetid://77965589200390",
    IsWeaponCosmetic = true,
    NotCosmetic = nil
};
u39.Types.Skin = {
    Name = "Skin",
    Value = 4,
    Image = "rbxassetid://133714697763365",
    IsWeaponCosmetic = true,
    NotCosmetic = nil
};
u39.Types.Emote = {
    Name = "Emote",
    Value = 5,
    Image = "rbxassetid://130882808226687",
    IsWeaponCosmetic = nil,
    NotCosmetic = nil
};

local function add_cosmetic(p65, p66, p67, p68, p69, p70, p71, p72, p73) -- Line: 227
    -- upvalues: u39 (copy), CONSTANTS (copy), u48 (copy)
    assert(u39.Rarities[p66] ~= nil);
    assert(not u39.RENAMED_COSMETICS[p67]);
    local u74 = {
        GetDescription = nil,
        Rarity = p66,
        Type = p65,
        Image = p68 or "",
        ImageScale = p69 or 1,
        Hidden = p70,
        Description = p71,
        DescriptionSpecific = p72
    };

    function u74.GetDescription(p75) -- Line: 242
        -- upvalues: u74 (copy)
        local v76 = p75 and u74.DescriptionSpecific or u74.Description;

        if v76 then
            return tostring(v76);
        end;

        return nil;
    end;

    for i, v in pairs(p73 or {}) do
        u74[i] = v;
    end;

    u39.Cosmetics[p67] = u74;

    if CONSTANTS.IS_SERVER then
        if u48[p67] then
            error("[ITEM] Duplicate item name: " .. p67);

            return;
        end;

        u48[p67] = true;
    end;
end;

local function add_skin(p77, p78, p79, p80, p81, p82) -- Line: 259
    -- upvalues: ItemLibrary (copy), add_cosmetic (copy)
    local v83 = ItemLibrary.ViewModels[p79];
    assert(v83 ~= nil, p79);
    add_cosmetic("Skin", p77, p79, v83.Image, 3, p80, p81, p82, {
        ItemName = p78,
        ImageHighResolution = v83.ImageHighResolution
    });
end;

add_skin(
    "Unique",
    "Assault Rifle",
    "10B Visits",
    nil,
    "Earned by redeeming a code when the game (RIVALS) reaches 10,000,000,000 visits"
);
add_skin("Common", "Bow", "Compound Bow");
add_skin("Common", "Slingshot", "Goalpost");
add_skin("Common", "Slingshot", "Stick");
add_skin("Common", "Knife", "Chancla");
add_skin("Common", "Molotov", "Coffee");
add_skin("Common", "Shorty", "Too Shorty", nil, "Included in the Starter Bundle");
add_skin("Common", "Shorty", "Not So Shorty");
add_skin("Common", "Shorty", "Lovely Shorty");
add_skin("Common", "Flamethrower", "Lamethrower");
add_skin("Common", "Fists", "Brass Knuckles");
add_skin("Common", "Smoke Grenade", "Balance");
add_skin("Common", "Molotov", "Torch");
add_skin("Common", "Knife", "Machete");
add_skin("Common", "Fists", "Pumpkin Claws");
add_skin("Common", "Sniper", "Eyething Sniper");
add_skin("Common", "Handgun", "Pumpkin Handgun");
add_skin("Common", "Burst Rifle", "Spectral Burst");
add_skin("Common", "Minigun", "Pumpkin Minigun");
add_skin("Common", "Flashbang", "Skullbang");
add_skin("Common", "Subspace Tripmine", "Trick or Treat");
add_skin("Common", "Riot Shield", "Door");
add_skin("Common", "Spray", "Lovely Spray");
add_skin("Common", "Shotgun", "Wrapped Shotgun");
add_skin("Common", "Shorty", "Wrapped Shorty");
add_skin("Common", "Flare Gun", "Wrapped Flare Gun");
add_skin("Common", "Minigun", "Wrapped Minigun");
add_skin("Common", "Freeze Ray", "Wrapped Freeze Ray");
add_skin("Common", "War Horn", "Mammoth Horn");
add_skin("Common", "Fists", "Festive Fists");
add_skin("Common", "Exogun", "Midnight Festive Exogun");
add_skin("Common", "Riot Shield", "Sled");
add_skin("Common", "Battle Axe", "Nordic Axe");
add_skin("Common", "Satchel", "Suspicious Gift");
add_skin("Common", "Burst Rifle", "Pine Burst");
add_skin("Common", "Uzi", "Pine Uzi");
add_skin("Common", "Spray", "Pine Spray");
add_skin("Common", "Gunblade", "Elf\'s Gunblade");
add_skin("Common", "Assault Rifle", "Phoenix Rifle");
add_skin("Common", "Jump Pad", "Trampoline");
add_skin("Common", "Battle Axe", "Ban Axe");
add_skin("Common", "Shotgun", "Cactus Shotgun");
add_skin("Common", "Gunblade", "Crude Gunblade");
add_skin("Common", "Subspace Tripmine", "DIY Tripmine");
add_skin("Common", "Grenade", "Dynamite");
add_skin("Common", "Handgun", "Gumball Handgun");
add_skin("Common", "Paintball Gun", "Ketchup Gun");
add_skin("Common", "Flashbang", "Lightbulb");
add_skin("Common", "War Horn", "Megaphone");
add_skin("Common", "Spray", "Nail Gun");
add_skin("Common", "Satchel", "Notebook Satchel");
add_skin("Common", "Daggers", "Paper Planes");
add_skin("Common", "RPG", "Pencil Launcher", nil, "Included in the RPG Bundle");
add_skin("Common", "Satchel", "Bag o\' Money");
add_skin("Common", "Daggers", "Shurikens");
add_skin("Common", "Assault Rifle", "Glorious Assault Rifle", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Battle Axe", "Glorious Battle Axe", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Bow", "Glorious Bow", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Burst Rifle", "Glorious Burst Rifle", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Chainsaw", "Glorious Chainsaw", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Crossbow", "Glorious Crossbow", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Daggers", "Glorious Daggers", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Energy Pistols", "Glorious Energy Pistols", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Energy Rifle", "Glorious Energy Rifle", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Exogun", "Glorious Exogun", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Fists", "Glorious Fists", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Flamethrower", "Glorious Flamethrower", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Flare Gun", "Glorious Flare Gun", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Flashbang", "Glorious Flashbang", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Freeze Ray", "Glorious Freeze Ray", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Grenade", "Glorious Grenade", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Grenade Launcher", "Glorious Grenade Launcher", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Gunblade", "Glorious Gunblade", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Handgun", "Glorious Handgun", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Jump Pad", "Glorious Jump Pad", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Katana", "Glorious Katana", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Knife", "Glorious Knife", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Medkit", "Glorious Medkit", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Minigun", "Glorious Minigun", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Molotov", "Glorious Molotov", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Paintball Gun", "Glorious Paintball Gun", nil, "Purchased from the Ranked Shop");
add_skin("Common", "RPG", "Glorious RPG", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Revolver", "Glorious Revolver", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Riot Shield", "Glorious Riot Shield", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Satchel", "Glorious Satchel", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Scythe", "Glorious Scythe", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Shorty", "Glorious Shorty", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Shotgun", "Glorious Shotgun", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Slingshot", "Glorious Slingshot", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Smoke Grenade", "Glorious Smoke Grenade", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Sniper", "Glorious Sniper", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Spray", "Glorious Spray", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Subspace Tripmine", "Glorious Subspace Tripmine", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Trowel", "Glorious Trowel", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Uzi", "Glorious Uzi", nil, "Purchased from the Ranked Shop");
add_skin("Common", "War Horn", "Glorious War Horn", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Distortion", "Glorious Distortion", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Warper", "Glorious Warper", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Warpstone", "Glorious Warpstone", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Maul", "Glorious Maul", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Permafrost", "Glorious Permafrost", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Grappler", "Glorious Grappler", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Spear", "Glorious Spear", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Wildcat", "Glorious Wildcat", nil, "Purchased from the Ranked Shop");
add_skin("Common", "Handgun", "Warp Handgun");
add_skin("Common", "Jump Pad", "Spider Web");
add_skin("Common", "Riot Shield", "Tombstone Shield");
add_skin("Common", "Gunblade", "Boneblade");
add_skin("Common", "Crossbow", "Crossbone");
add_skin("Common", "Warpstone", "Warpbone");
add_skin("Common", "Handgun", "Towerstone Handgun", nil, "Earned by escaping the Zombie Tower solo");
add_skin("Common", "Warpstone", "Cyber Warpstone");
add_skin("Common", "Distortion", "Cyber Distortion");
add_skin("Common", "Grenade", "Frozen Grenade");
add_skin("Common", "Maul", "Ice Maul");
add_skin("Common", "Permafrost", "Ice Permafrost");
add_skin("Common", "Permafrost", "Snowman Permafrost");
add_skin("Common", "Fists", "Spy Gloves");
add_skin("Common", "Spear", "Giant Pencil");
add_skin("Common", "Spear", "Studio Light");
add_skin("Common", "Knife", "Birthday Candle", nil, "Earned from the 2nd RIVALS Birthday Party");
add_skin("Common", "Riot Shield", "Broken Surfboard");
add_skin("Common", "Smoke Grenade", "Beach Ball");
add_skin("Common", "Spear", "Chark Kebab");
add_skin("Common", "Jump Pad", "Flamingo Floatie");
add_skin("Common", "Chainsaw", "Sharksaw");
add_skin("Common", "Knife", "Shark Tooth");
add_skin("Common", "Maul", "Giant Popsicle");
add_skin("Common", "Slingshot", "Palmshot");
add_skin("Common", "Grappler", "Lifeguard Grappler");
add_skin("Common", "Satchel", "Lifeguard Satchel");
add_skin("Common", "Gunblade", "Sharkbite");
add_skin("Common", "Paintball Gun", "Lemonade Gun");
add_skin("Common", "Katana", "Swordfish");
add_skin("Common", "Molotov", "Campfire Stick");
add_skin("Common", "Crossbow", "Campfire Crossbow");
add_skin("Common", "Sniper", "Campfire Sniper");
add_skin("Common", "Uzi", "Ducky Uzi");
add_skin("Common", "Scythe", "Plastic Flamingo");
add_skin("Common", "Daggers", "Starfish");
add_skin("Common", "Spear", "Fork");
add_skin("Common", "Maul", "Excalibur");
add_skin("Rare", "Paintball Gun", "Slime Gun");
add_skin("Rare", "Chainsaw", "Blobsaw");
add_skin("Rare", "Trowel", "Plastic Shovel");
add_skin("Rare", "Exogun", "Wondergun", nil, "Included in the Exogun Bundle");
add_skin("Rare", "Fists", "Boxing Gloves");
add_skin("Rare", "Assault Rifle", "AK-47");
add_skin("Rare", "Medkit", "Briefcase", nil, "Included in the Medkit Bundle");
add_skin("Rare", "Scythe", "Scythe of Death");
add_skin("Rare", "Handgun", "Blaster");
add_skin("Rare", "Uzi", "Water Uzi");
add_skin("Rare", "Revolver", "Desert Eagle");
add_skin("Rare", "Flare Gun", "Dynamite Gun");
add_skin("Rare", "Bow", "Raven Bow");
add_skin("Rare", "Scythe", "Anchor");
add_skin("Rare", "Grenade", "Water Balloon");
add_skin("Rare", "Trowel", "Garden Shovel");
add_skin("Rare", "Grenade Launcher", "Uranium Launcher");
add_skin("Rare", "Exogun", "Ray Gun");
add_skin("Rare", "Subspace Tripmine", "Spring");
add_skin("Rare", "Freeze Ray", "Bubble Ray");
add_skin("Rare", "Burst Rifle", "Aqua Burst");
add_skin("Rare", "Katana", "Lightning Bolt");
add_skin("Rare", "Scythe", "Bat Scythe");
add_skin("Rare", "Bow", "Bat Bow");
add_skin("Rare", "Katana", "Evil Trident");
add_skin("Rare", "Slingshot", "Boneshot");
add_skin("Rare", "Exogun", "Exogourd");
add_skin("Rare", "Trowel", "Pumpkin Carver");
add_skin("Rare", "Shorty", "Demon Shorty");
add_skin("Rare", "Shotgun", "Broomstick");
add_skin("Rare", "Uzi", "Demon Uzi");
add_skin("Rare", "Paintball Gun", "Brain Gun");
add_skin("Rare", "Flamethrower", "Jack O\'Thrower");
add_skin("Rare", "Revolver", "Boneclaw Revolver");
add_skin("Rare", "Assault Rifle", "Boneclaw Rifle");
add_skin("Rare", "Energy Rifle", "Hacker Rifle");
add_skin("Rare", "Energy Pistols", "Hacker Pistols");
add_skin("Rare", "War Horn", "Trumpet");
add_skin("Rare", "Satchel", "Advanced Satchel");
add_skin("Rare", "Daggers", "Aces");
add_skin("Rare", "Energy Pistols", "Apex Pistols", nil, "Included in the Energy Bundle");
add_skin("Rare", "Energy Rifle", "Apex Rifle", nil, "Included in the Energy Bundle");
add_skin("Rare", "Handgun", "Gingerbread Handgun");
add_skin("Rare", "Sniper", "Gingerbread Sniper");
add_skin("Rare", "Flashbang", "Shining Star");
add_skin("Rare", "Smoke Grenade", "Snowglobe");
add_skin("Rare", "Grenade", "Jingle Grenade");
add_skin("Rare", "Slingshot", "Reindeer Slingshot");
add_skin("Rare", "Trowel", "Snow Shovel");
add_skin("Rare", "Paintball Gun", "Snowball Gun");
add_skin("Rare", "Daggers", "Cookies");
add_skin("Rare", "Bow", "Frostbite Bow");
add_skin("Rare", "Crossbow", "Frostbite Crossbow");
add_skin("Rare", "Energy Pistols", "New Year Energy Pistols");
add_skin("Rare", "Energy Rifle", "New Year Energy Rifle");
add_skin("Rare", "Katana", "New Year Katana");
add_skin("Rare", "Flamethrower", "Snowblower");
add_skin("Rare", "Scythe", "Cryo Scythe");
add_skin("Rare", "Grenade Launcher", "Snowball Launcher");
add_skin("Rare", "Jump Pad", "Bounce House");
add_skin("Rare", "Bow", "Dream Bow");
add_skin("Rare", "Riot Shield", "Energy Shield");
add_skin("Rare", "Fists", "Fists of Hurt");
add_skin("Rare", "Grenade Launcher", "Gearnade Launcher");
add_skin("Rare", "Flamethrower", "Glitterthrower");
add_skin("Rare", "Freeze Ray", "Gum Ray");
add_skin("Rare", "Crossbow", "Harpoon Crossbow");
add_skin("Rare", "Smoke Grenade", "Hourglass");
add_skin("Rare", "Energy Rifle", "Hydro Rifle");
add_skin("Rare", "Molotov", "Lava Lamp");
add_skin("Rare", "Trowel", "Paintbrush");
add_skin("Rare", "Scythe", "Sakura Scythe");
add_skin("Rare", "RPG", "Squid Launcher");
add_skin("Rare", "Katana", "Stellar Katana");
add_skin("Rare", "War Horn", "Air Horn");
add_skin("Rare", "Riot Shield", "Masterpiece");
add_skin("Rare", "Battle Axe", "Cerulean Axe");
add_skin("Rare", "Energy Pistols", "Hydro Pistols");
add_skin("Rare", "Jump Pad", "Shady Chicken Sandwich");
add_skin("Rare", "Crossbow", "Violin Crossbow");
add_skin("Rare", "Distortion", "Electropunk Distortion");
add_skin("Rare", "Warper", "Electropunk Warper");
add_skin("Rare", "Warpstone", "Unstable Warpstone");
add_skin("Rare", "Spray", "Boneclaw Spray");
add_skin("Rare", "War Horn", "Boneclaw Horn");
add_skin("Rare", "Daggers", "Bat Daggers");
add_skin("Rare", "Satchel", "Potion Satchel");
add_skin("Rare", "Jump Pad", "Jolly Man");
add_skin("Rare", "Distortion", "Plasma Distortion");
add_skin("Rare", "Distortion", "Magma Distortion");
add_skin("Rare", "Distortion", "Sleighstortion");
add_skin("Rare", "Warper", "Glitter Warper");
add_skin("Rare", "Warper", "Frost Warper");
add_skin("Rare", "Warpstone", "Electropunk Warpstone");
add_skin("Rare", "Maul", "Sleigh Maul");
add_skin("Rare", "Shorty", "Bubble Shorty");
add_skin("Rare", "Flamethrower", "Bubblethrower");
add_skin("Rare", "Distortion", "Bubble Distortion");
add_skin("Rare", "Warper", "Bubbler");
add_skin("Rare", "Assault Rifle", "Pearl Rifle");
add_skin("Rare", "Exogun", "Pearl Exogun");
add_skin("Rare", "Battle Axe", "Tiki Axe");
add_skin("Rare", "Handgun", "Sandgun");
add_skin("Rare", "Minigun", "Shark Minigun");
add_skin("Rare", "Trowel", "Scooper");
add_skin("Rare", "Energy Pistols", "Sol Pistols");
add_skin("Rare", "Energy Rifle", "Sol Rifle");
add_skin("Rare", "Warpstone", "Warp Juice");
add_skin("Rare", "Permafrost", "Permasand");
add_skin("Rare", "Bow", "Palm Bow");
add_skin("Rare", "RPG", "Sundae Launcher");
add_skin("Rare", "Grenade Launcher", "Coconut Launcher");
add_skin("Rare", "Spear", "Plunger");
add_skin("Rare", "Spear", "Thunderpike");
add_skin("Rare", "Maul", "Starforge Maul");
add_skin("Rare", "Maul", "Clown Hammer");
add_skin("Rare", "Permafrost", "Permafrost.rbxm");
add_skin("Rare", "Permafrost", "Starforge Permafrost");
add_skin("Rare", "Wildcat", "Plasma Wildcat");
add_skin("Legendary", "Katana", "Saber");
add_skin("Legendary", "RPG", "Nuke Launcher");
add_skin("Legendary", "Grenade", "Whoopee Cushion");
add_skin("Legendary", "Flashbang", "Disco Ball");
add_skin("Legendary", "Exogun", "Singularity");
add_skin("Legendary", "Sniper", "Pixel Sniper");
add_skin("Legendary", "Subspace Tripmine", "Don\'t Press");
add_skin("Legendary", "Minigun", "Lasergun 3000");
add_skin("Legendary", "Flare Gun", "Firework Gun");
add_skin("Legendary", "Flamethrower", "Pixel Flamethrower");
add_skin("Legendary", "Grenade Launcher", "Swashbuckler");
add_skin("Legendary", "Burst Rifle", "Electro Rifle");
add_skin("Legendary", "Shotgun", "Balloon Shotgun");
add_skin("Legendary", "Smoke Grenade", "Emoji Cloud");
add_skin("Legendary", "Medkit", "Sandwich");
add_skin("Legendary", "Freeze Ray", "Temporal Ray");
add_skin("Legendary", "Uzi", "Electro Uzi");
add_skin("Legendary", "Handgun", "Hand Gun");
add_skin("Legendary", "Revolver", "Sheriff");
add_skin("Legendary", "Knife", "Karambit");
add_skin("Legendary", "RPG", "Spaceship Launcher");
add_skin("Legendary", "Chainsaw", "Handsaws");
add_skin("Legendary", "Flashbang", "Camera");
add_skin("Legendary", "Paintball Gun", "Boba Gun");
add_skin("Legendary", "Sniper", "Hyper Sniper");
add_skin("Legendary", "Shotgun", "Hyper Shotgun");
add_skin("Legendary", "Medkit", "Laptop");
add_skin("Legendary", "Minigun", "Pixel Minigun");
add_skin("Legendary", "Assault Rifle", "Augmented Rifle");
add_skin("Legendary", "Burst Rifle", "Pixel Burst");
add_skin("Legendary", "Handgun", "Pixel Handgun");
add_skin("Legendary", "Katana", "Pixel Katana");
add_skin("Legendary", "Flashbang", "Pixel Flashbang");
add_skin("Legendary", "Smoke Grenade", "Eyeball");
add_skin("Legendary", "Freeze Ray", "Spider Ray");
add_skin("Legendary", "Medkit", "Bucket of Candy");
add_skin("Legendary", "RPG", "Pumpkin Launcher");
add_skin("Legendary", "Flare Gun", "Vexed Flare Gun");
add_skin("Legendary", "Molotov", "Vexed Candle");
add_skin("Legendary", "Grenade", "Soul Grenade");
add_skin("Legendary", "Grenade Launcher", "Skull Launcher");
add_skin("Legendary", "Chainsaw", "Buzzsaw");
add_skin("Legendary", "Crossbow", "Pixel Crossbow");
add_skin("Legendary", "Gunblade", "Hyper Gunblade");
add_skin("Legendary", "Battle Axe", "The Shred");
add_skin("Legendary", "Assault Rifle", "Gingerbread Augmented Rifle");
add_skin("Legendary", "Revolver", "Peppermint Sheriff");
add_skin("Legendary", "RPG", "Firework Launcher");
add_skin("Legendary", "Chainsaw", "Festive Buzzsaw");
add_skin("Legendary", "Medkit", "Milk & Cookies");
add_skin("Legendary", "Molotov", "Hot Coals");
add_skin("Legendary", "Subspace Tripmine", "Dev-in-the-Box");
add_skin("Legendary", "Knife", "Candy Cane");
add_skin("Legendary", "Shorty", "Balloon Shorty");
add_skin("Legendary", "Energy Pistols", "Void Pistols");
add_skin("Legendary", "Uzi", "Money Gun");
add_skin("Legendary", "Medkit", "Medkitty");
add_skin("Legendary", "Knife", "Balisong");
add_skin("Legendary", "Sniper", "Event Horizon");
add_skin("Legendary", "Flare Gun", "Banana Flare");
add_skin("Legendary", "Minigun", "Fighter Jet");
add_skin("Legendary", "Slingshot", "Harp");
add_skin("Legendary", "Exogun", "Repulsor");
add_skin("Legendary", "Assault Rifle", "Drum Gun");
add_skin("Legendary", "Burst Rifle", "Bullpup Burst");
add_skin("Legendary", "Revolver", "Peppergun");
add_skin("Legendary", "Chainsaw", "Mega Drill");
add_skin("Legendary", "Spray", "Spray Bottle");
add_skin("Legendary", "Energy Rifle", "Void Rifle");
add_skin("Legendary", "Gunblade", "Gunsaw");
add_skin("Legendary", "Energy Pistols", "Soul Pistols");
add_skin("Legendary", "Energy Rifle", "Soul Rifle");
add_skin("Legendary", "Battle Axe", "Mimic Axe");
add_skin("Legendary", "Warper", "Experiment W4");
add_skin("Legendary", "Distortion", "Experiment D15");
add_skin("Legendary", "Warper", "Hotel Bell");
add_skin("Legendary", "Warpstone", "Teleport Disc");
add_skin("Legendary", "Warper", "Arcane Warper");
add_skin("Legendary", "Warpstone", "Warpstar");
add_skin("Legendary", "Maul", "Ban Hammer");
add_skin("Legendary", "RPG", "Rocket Launcher");
add_skin("Legendary", "Energy Pistols", "Hyperlaser Guns");
add_skin("Legendary", "Katana", "Linked Sword");
add_skin("Legendary", "Grenade Launcher", "Balloon Launcher");
add_skin("Legendary", "Paintball Gun", "Paintballoon Gun");
add_skin("Legendary", "Bow", "Balloon Bow");
add_skin("Legendary", "Battle Axe", "Balloon Axe");
add_skin("Legendary", "Bow", "Beloved Bow");
add_skin("Legendary", "Daggers", "Broken Hearts");
add_skin("Legendary", "Grenade", "Cuddle Bomb");
add_skin("Legendary", "Medkit", "Box of Chocolates");
add_skin("Legendary", "Fists", "Fist");
add_skin("Legendary", "Flamethrower", "Rainbowthrower");
add_skin("Legendary", "Slingshot", "Lucky Horseshoe");
add_skin("Legendary", "Knife", "Caladbolg");
add_skin("Legendary", "Subspace Tripmine", "Pot o\' Keys");
add_skin("Legendary", "Flamethrower", "Extinguisher");
add_skin("Legendary", "Daggers", "Toaster");
add_skin("Legendary", "Battle Axe", "Street Sign");
add_skin("Legendary", "Satchel", "Pizza Box");
add_skin("Legendary", "Knife", "Pencil");
add_skin("Legendary", "Grappler", "Lasso");
add_skin("Legendary", "Scythe", "Palm Scythe", nil, "Used to be purchased from the Shop");
add_skin(
    "Legendary",
    "RPG",
    "Cupcake Launcher",
    nil,
    "Used to be purchased from the Shop during the 2nd RIVALS Birthday Party"
);
add_skin("Legendary", "Fists", "Pirate Hook");
add_skin("Legendary", "Katana", "Cutlass");
add_skin("Legendary", "Shorty", "Cannon Shorty");
add_skin("Legendary", "Sniper", "Kraken Sniper");
add_skin("Legendary", "Molotov", "Ship In A Bottle");
add_skin("Legendary", "Medkit", "Ice Cream");
add_skin("Legendary", "Fists", "Crab Claws");
add_skin("Legendary", "Shotgun", "Shark Shotgun");
add_skin("Legendary", "Freeze Ray", "Cooler");
add_skin("Legendary", "Flare Gun", "Pocket Volcano");
add_skin("Legendary", "Revolver", "Cruise Revolver");
add_skin("Legendary", "Spray", "Campfire Spray");
add_skin("Legendary", "War Horn", "Lifeguard Whistle");
add_skin("Legendary", "Burst Rifle", "Sand Bullpup Burst");
add_skin("Legendary", "Subspace Tripmine", "Hazard Sign");
add_skin("Legendary", "Flashbang", "Sol");
add_skin("Legendary", "Grenade", "Fizz Bomb");
add_skin("Legendary", "Permafrost", "Temporal Permafrost");
add_skin("Legendary", "Grappler", "Arcade Claw");
add_skin("Legendary", "Grappler", "Genie Lamp");
add_skin("Legendary", "Grappler", "Fishing Rod");
add_skin("Legendary", "Sniper", "Light Fifty");
add_skin("Mythical", "RPG", "RPKEY", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Scythe", "Keythe", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Sniper", "Keyper", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Assault Rifle", "AKEY-47", nil, "Used to be included in the Legendary Key Bundle");
add_skin(
    "Mythical",
    "Daggers",
    "Crystal Daggers",
    nil,
    "Used to be included in the Legendary Crystal Bundle"
);
add_skin("Mythical", "Katana", "Keytana", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Revolver", "Keyvolver", nil, "Used to be included in the Ultra Key Bundle");
add_skin("Mythical", "Shotgun", "Shotkey", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Uzi", "Keyzi", nil, "Used to be included in the Ultra Key Bundle");
add_skin("Mythical", "Bow", "Key Bow", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Grenade", "Keynade", nil, "Used to be included in the Ultra Key Bundle");
add_skin("Mythical", "Burst Rifle", "Keyst Rifle", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Battle Axe", "Keyttle Axe", nil, "Used to be included in the Ultra Key Bundle");
add_skin("Mythical", "Warpstone", "Warpeye", nil, "Used to be included in the Legendary Candy Bundle");
add_skin("Mythical", "Knife", "Keyrambit", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Knife", "Keylisong", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Daggers", "Keynais", nil, "Used to be included in the Ultra Key Bundle");
add_skin("Mythical", "Katana", "Crystal Katana", nil, "Used to be included in the Legendary Crystal Bundle");
add_skin("Mythical", "Spray", "Key Spray", nil, "Used to be included in the Ultra Key Bundle");
add_skin("Mythical", "Flamethrower", "Keythrower", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Slingshot", "Keyshot", nil, "Used to be included in the Ultra Key Bundle");
add_skin("Mythical", "Gunblade", "Keyblade", nil, "Used to be included in the Legendary Key Bundle");
add_skin("Mythical", "Scythe", "Crystal Scythe", nil, "Used to be included in the 2025 Festive Flash Sale");
add_skin("Mythical", "Katana", "Riptide Katana", nil, "Used to be included in the Legendary Pearl Bundle");
add_skin("Mythical", "Katana", "Arch Katana");
add_skin("Mythical", "Crossbow", "Arch Crossbow");
add_skin("Mythical", "Molotov", "Arch Molotov");
add_skin("Mythical", "Uzi", "Arch Uzi", true);
add_skin("Mythical", "Energy Pistols", "Enerkey Pistols", nil, "Included in the Legendary Key Bundle");
add_skin("Mythical", "Energy Rifle", "Enerkey Rifle", nil, "Included in the Ultra Key Bundle");
add_skin(
    "Genuine",
    "Scythe",
    "Bug Net",
    true,
    "Given to the best bug hunters, thank you for helping us improve the game (RIVALS)"
);
add_skin(
    "Genuine",
    "Knife",
    "Trophy Knife",
    true,
    "Given to winners of tournaments that are officially hosted, sponsored, endorsed, or recognized by the group (Nosniy Games)"
);
add_skin(
    "Genuine",
    "Knife",
    "Armature.001",
    true,
    "if this is leaked neko will be waterboarded and hit by a car 628 times"
);
add_skin("Unobtainable", "MISSING_WEAPON", "MISSING_SKIN", true, "-- TODO: placeholder");
add_skin("Unobtainable", "Handgun", "Stealth Handgun", true, "sneaky beaky like");

local function add_wrap(p84, p85, p86, p87, p88, p89, p90, p91) -- Line: 701
    -- upvalues: MaterialService (copy), add_cosmetic (copy)
    local v92 = {
        WrapGroups = {}
    };

    for _, v in pairs({ p86, p87, p88 }) do
        local table_unpack_ret, v93, v94, v95, v96, v97 = table.unpack(v);
        local v98 = typeof(table_unpack_ret) == "string";
        local v99;

        if v98 then
            v99 = MaterialService.Wraps:WaitForChild(table_unpack_ret);
        else
            v99 = v98;
        end;

        local v100 = {};
        local v101 = v99 and v99.BaseMaterial;

        if not v101 then
            if v98 or not table_unpack_ret then
                v101 = nil;
            else
                v101 = table_unpack_ret;
            end;
        end;

        v100.Material = v101;
        v100.MaterialVariant = v98 and table_unpack_ret and table_unpack_ret or "";
        v100.Color = v93 or nil;
        v100.Transparency = v94 or nil;
        v100.Reflectance = v95 or nil;
        v100.Textures = v96 or nil;
        v100.ObjectName = v97;
        table.insert(v92.WrapGroups, v100);
    end;

    add_cosmetic("Wrap", p84, p85, nil, nil, p89, p90, p91, v92);
end;

add_wrap("Unique", "Community", {
    Enum.Material.Glass,
    Color3.fromRGB(124, 17, 255),
    0,
    0.1,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 213, 0),
    0,
    0.1,
    nil
}, {
    nil,
    Color3.fromRGB(112, 181, 255),
    nil,
    nil,
    nil
}, nil, "Earned by redeeming codes");
add_wrap("Unique", "1B Visits", {
    Enum.Material.Glass,
    Color3.fromRGB(48, 38, 0),
    0,
    0.4,
    "1BVisits"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(127, 100, 0),
    0,
    0.4,
    "1BVisits"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(173, 155, 123),
    0,
    0,
    nil
}, nil, "Earned by redeeming a code when the game (RIVALS) reached 1,000,000,000 visits");
add_wrap("Unique", "Cream", {
    nil,
    Color3.fromRGB(255, 209, 157),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(62, 55, 48),
    0,
    0,
    nil
}, nil, nil, "Earned by inviting friends to the game (RIVALS)");
add_wrap("Unique", "Danger", {
    Enum.Material.Neon,
    Color3.fromRGB(168, 0, 0),
    0,
    0,
    "Danger1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Danger2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 47, 47),
    0,
    0,
    nil
}, nil, "Earned by completing a special challenge during the Roblox 2024 Winter Spotlight");
add_wrap("Unique", "Glacier", {
    "Glacier",
    Color3.fromRGB(175, 221, 255),
    0,
    0,
    nil
}, {
    "Glacier",
    Color3.fromRGB(231, 231, 236),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(130, 157, 166),
    0,
    0,
    nil
}, nil, "Earned from the 2024 Festive Event Advent Calendar");
add_wrap("Unique", "Pine", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(58, 115, 55),
    0,
    0,
    "Pine"
}, {
    "Pine",
    Color3.fromRGB(72, 51, 40),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(158, 162, 121),
    0,
    0,
    nil
}, nil, "Earned from the 2024 Festive Event Advent Calendar");
add_wrap("Unique", "Glamour", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(86, 36, 36),
    0,
    0,
    "Glamour"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(117, 0, 0),
    0,
    0.1,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(170, 128, 99),
    0,
    0,
    nil
}, nil, "Earned by watching a quick video ad in the Shop");
add_wrap("Unique", "Brimstone", {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Brimstone_1"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(196, 40, 48),
    0,
    0,
    "Brimstone_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 61, 74),
    0,
    0,
    nil
}, nil, "Earned by watching a quick video ad in the Hub");
add_wrap("Unique", "Sensite", {
    "Developore",
    Color3.fromRGB(255, 180, 30),
    0,
    0,
    nil
}, {
    "Developore",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 172, 99),
    nil,
    nil,
    nil
});
add_wrap("Unique", "Nosnite", {
    "Developore",
    Color3.fromRGB(180, 128, 255),
    0,
    0,
    nil
}, {
    "Developore",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(136, 114, 202),
    nil,
    nil,
    nil
});
add_wrap("Unique", "Nekore", {
    "Developore",
    Color3.fromRGB(6, 100, 150),
    0,
    0,
    nil
}, {
    "Developore",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(102, 144, 236),
    nil,
    nil,
    nil
});
add_wrap("Unique", "Shadore", {
    "Developore",
    Color3.fromRGB(203, 51, 51),
    0,
    0,
    nil
}, {
    "Developore",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(248, 108, 108),
    nil,
    nil,
    nil
});
add_wrap("Unique", "Brianore", {
    "Developore",
    Color3.fromRGB(101, 255, 93),
    0,
    0,
    nil
}, {
    "Developore",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(157, 248, 163),
    nil,
    nil,
    nil
});
add_wrap("Unique", "Boomore", {
    "Developore",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Developore",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(175, 175, 175),
    nil,
    nil,
    nil
});
add_wrap("Unique", "Beggar", {
    Enum.Material.Pebble,
    Color3.fromRGB(255, 176, 0),
    0.05,
    0,
    "dude"
}, {
    Enum.Material.CorrodedMetal,
    Color3.fromRGB(255, 176, 0),
    0.1,
    0,
    "bruh"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(9, 137, 207),
    0,
    1000,
    "epic"
}, nil, "Beggars can\'t be choosers");
add_wrap("Unique", "Snowy Night", {
    Enum.Material.Neon,
    Color3.fromRGB(46, 52, 54),
    0,
    0,
    "Snowflakes_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(150, 169, 176),
    0,
    0,
    "Snowflakes_2"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(202, 246, 255),
    0.25,
    0.3,
    nil
}, nil, "Earned from the 2025 Festive Event Advent Calendar");
add_wrap("Common", "Red", {
    nil,
    Color3.fromRGB(255, 50, 50),
    0,
    0,
    nil
});
add_wrap("Common", "Orange", {
    nil,
    Color3.fromRGB(255, 110, 0),
    0,
    0,
    nil
});
add_wrap("Common", "Yellow", {
    nil,
    Color3.fromRGB(255, 215, 0),
    0,
    0,
    nil
});
add_wrap("Common", "Green", {
    nil,
    Color3.fromRGB(100, 255, 50),
    0,
    0,
    nil
});
add_wrap("Common", "Blue", {
    nil,
    Color3.fromRGB(0, 150, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Purple", {
    nil,
    Color3.fromRGB(136, 0, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Pink", {
    nil,
    Color3.fromRGB(255, 60, 236),
    0,
    0,
    nil
});
add_wrap("Common", "Salmon", {
    nil,
    Color3.fromRGB(255, 107, 107),
    0,
    0,
    nil
});
add_wrap("Common", "Brown", {
    nil,
    Color3.fromRGB(91, 54, 35),
    0,
    0,
    nil
});
add_wrap("Common", "Lemon", {
    nil,
    Color3.fromRGB(255, 230, 105),
    0,
    0,
    nil
});
add_wrap("Common", "Mint", {
    nil,
    Color3.fromRGB(167, 255, 135),
    0,
    0,
    nil
});
add_wrap("Common", "Sky", {
    nil,
    Color3.fromRGB(135, 207, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Olive", {
    nil,
    Color3.fromRGB(75, 79, 55),
    0,
    0,
    nil
});
add_wrap("Common", "Blush", {
    nil,
    Color3.fromRGB(255, 164, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Maroon", {
    nil,
    Color3.fromRGB(117, 33, 69),
    0,
    0,
    nil
});
add_wrap("Common", "Beige", {
    nil,
    Color3.fromRGB(184, 156, 110),
    0,
    0,
    nil
});
add_wrap("Common", "Navy", {
    nil,
    Color3.fromRGB(0, 18, 76),
    0,
    0,
    nil
});
add_wrap("Common", "Teal", {
    nil,
    Color3.fromRGB(0, 255, 225),
    0,
    0,
    nil
});
add_wrap("Common", "Highlighter", {
    nil,
    Color3.fromRGB(192, 255, 57),
    0,
    0,
    nil
});
add_wrap("Common", "Crimson", {
    nil,
    Color3.fromRGB(75, 14, 14),
    0,
    0,
    nil
});
add_wrap("Common", "Cool", {
    nil,
    Color3.fromRGB(97, 200, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Gunmetal", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(40, 40, 40),
    0,
    0.05,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    1,
    "Gunmetal"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(182, 116, 99),
    0,
    0,
    nil
});
add_wrap("Common", "Venom", {
    Enum.Material.Neon,
    Color3.fromRGB(136, 0, 255),
    0,
    0,
    "Venom"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(102, 0, 191),
    0.15,
    0,
    nil
});
add_wrap("Common", "MaGGenta", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(206, 206, 206),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(115, 40, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Bluesteel", {
    "Bluesteel",
    Color3.fromRGB(38, 96, 150),
    0,
    0,
    nil
}, {
    Enum.Material.Metal,
    Color3.fromRGB(159, 161, 172),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(37, 73, 173),
    0,
    0,
    nil
});
add_wrap("Common", "Cheese", {
    "Cheese",
    Color3.fromRGB(255, 221, 48),
    0,
    0,
    nil
}, {
    "Cheesecloth",
    Color3.fromRGB(248, 221, 194),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(172, 118, 0),
    0,
    0,
    nil
});
add_wrap("Common", "Stained", {
    "Stained",
    Color3.fromRGB(82, 126, 175),
    0,
    0,
    nil
}, {
    "Stained",
    Color3.fromRGB(120, 183, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Lumber", {
    "Lumber1",
    Color3.fromRGB(124, 92, 70),
    0,
    0,
    nil
}, {
    "Lumber2",
    Color3.fromRGB(105, 64, 40),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(198, 135, 114),
    0,
    0,
    nil
});
add_wrap("Common", "Ornate", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(27, 42, 53),
    0,
    0,
    nil
}, {
    Enum.Material.Metal,
    Color3.fromRGB(226, 155, 64),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 53, 53),
    0,
    0,
    nil
});
add_wrap("Common", "Mustard", {
    nil,
    Color3.fromRGB(136, 102, 0),
    0,
    0,
    nil
});
add_wrap("Common", "Violet", {
    nil,
    Color3.fromRGB(85, 43, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Jean", {
    nil,
    Color3.fromRGB(0, 76, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Copper", {
    Enum.Material.Glass,
    Color3.fromRGB(213, 115, 61),
    0,
    0.3,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(170, 85, 0),
    0,
    0.3,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(186, 143, 135),
    0,
    0,
    nil
});
add_wrap("Common", "Machine", {
    "BrushedMetal",
    Color3.fromRGB(202, 203, 209),
    0,
    0,
    nil
}, {
    "BrushedMetal",
    Color3.fromRGB(202, 203, 209),
    0,
    0,
    nil
}, {
    "BrushedMetal",
    Color3.fromRGB(202, 203, 209),
    0,
    0,
    nil
});
add_wrap("Common", "Titanium", {
    Enum.Material.Glass,
    Color3.fromRGB(205, 205, 205),
    0,
    0.3,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(248, 248, 248),
    0,
    0.3,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(171, 171, 171),
    0,
    0,
    nil
});
add_wrap("Common", "Tungsten", {
    Enum.Material.Glass,
    Color3.fromRGB(66, 67, 76),
    0,
    0.3,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(91, 93, 105),
    0,
    0.3,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(133, 141, 192),
    0,
    0,
    nil
});
add_wrap("Common", "Haunted", {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0.4,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 255, 238),
    0.5,
    0.2,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(110, 253, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Vexed", {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0.4,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(105, 46, 255),
    0.5,
    0.2,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(153, 133, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Cursed", {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0.4,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 0, 0),
    0.5,
    0.2,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 142, 142),
    0,
    0,
    nil
});
add_wrap("Common", "Frigid", { nil, nil, nil, nil, "Frigid" }, { nil, nil, nil, nil, "Frigid" });
add_wrap("Common", "Midnight", {
    "PBRSimpleMetallic",
    Color3.fromRGB(7, 25, 67),
    0,
    0,
    nil
}, {
    "PBRSimpleMetallic",
    Color3.fromRGB(77, 77, 77),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(82, 122, 255),
    0,
    0,
    nil
});
add_wrap("Common", "Slush", {
    Enum.Material.Neon,
    Color3.fromRGB(136, 168, 161),
    0,
    0,
    "Slush1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(128, 145, 158),
    0,
    0,
    "Slush2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(100, 155, 163),
    0,
    0,
    nil
});
add_wrap("Common", "Lavish Crystal", {
    "LavishCrystal",
    Color3.fromRGB(183, 149, 255),
    0,
    0,
    nil
}, {
    "LavishCrystal",
    Color3.fromRGB(219, 196, 236),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(142, 128, 166),
    0,
    0,
    nil
});
add_wrap("Common", "Noir", {
    Enum.Material.Neon,
    Color3.fromRGB(165, 165, 165),
    0,
    0,
    "Noir1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Noir2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(157, 157, 157),
    0,
    0,
    nil
});
add_wrap("Common", "Normal", {
    Enum.Material.Neon,
    Color3.fromRGB(138, 0, 148),
    0,
    0,
    "Normal1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 32, 96),
    0,
    0,
    "Normal2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(158, 58, 58),
    0,
    0,
    nil
});
add_wrap("Common", "Rust", {
    Enum.Material.CorrodedMetal,
    nil,
    0,
    0,
    nil
}, {
    Enum.Material.CorrodedMetal,
    nil,
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(159, 159, 159),
    0,
    0.1,
    nil
});
add_wrap("Common", "Tawny", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 233, 111),
    0,
    0,
    "Tawny1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(68, 44, 7),
    0,
    0,
    "Tawny2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(167, 118, 78),
    0,
    0,
    nil
});
add_wrap("Common", "Olo", {
    nil,
    Color3.fromRGB(0, 254, 202),
    0,
    0,
    nil
});
add_wrap(
    "Common",
    "Glorious",
    { "CandyGlossy" },
    { "CandyGlossy" },
    nil,
    nil,
    "Purchased from the Ranked Shop"
);
add_wrap("Common", "Spiral", {
    "Spiral1",
    Color3.fromRGB(180, 128, 255),
    0,
    0.3,
    "Spiral1"
}, {
    "Spiral2",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(110, 79, 177),
    0,
    0,
    "Spiral3"
});
add_wrap("Common", "Pink Lemonade", {
    nil,
    Color3.fromRGB(255, 96, 152),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 212, 57),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 212, 57),
    0,
    0,
    nil
});
add_wrap("Common", "Playful", {
    nil,
    Color3.fromRGB(20, 67, 176),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(234, 121, 23),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(234, 121, 23),
    0,
    0,
    nil
});
add_wrap("Common", "Lapis", {
    nil,
    Color3.fromRGB(65, 73, 114),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(106, 255, 203),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(106, 255, 203),
    0,
    0,
    nil
});
add_wrap("Common", "Zombie", {
    Enum.Material.Sand,
    Color3.fromRGB(101, 158, 89),
    0,
    0,
    "Zombie1"
}, {
    Enum.Material.Plastic,
    Color3.fromRGB(38, 39, 52),
    0,
    0,
    "Zombie2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(212, 214, 196),
    0,
    0,
    nil
}, nil, "Earned by escaping the Zombie Tower alive");
add_wrap("Common", "Tusky", {
    "MammothFur",
    Color3.fromRGB(129, 86, 65),
    0,
    0,
    "Tusky_1"
}, {
    "Wooly1",
    Color3.fromRGB(255, 247, 231),
    0,
    0,
    "Tusky_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 160, 155),
    0,
    0,
    nil
});
add_wrap("Common", "Sleet", {
    nil,
    Color3.fromRGB(83, 79, 106),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(154, 188, 236),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(154, 188, 236),
    0,
    0,
    nil
});
add_wrap("Common", "Hot Cocoa", {
    nil,
    Color3.fromRGB(81, 57, 45),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(217, 224, 236),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(217, 224, 236),
    0,
    0,
    nil
});
add_wrap("Common", "Cartoony Paint", {
    "CartoonPaint",
    Color3.fromRGB(225, 235, 248),
    0,
    0,
    "Cartoony_Paint_1"
}, {
    "CartoonPaint",
    Color3.fromRGB(54, 54, 68),
    0,
    0,
    "Cartoony_Paint_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(217, 224, 236),
    0,
    0,
    nil
});
add_wrap("Common", "Mesa", {
    "Mesa",
    Color3.fromRGB(108, 71, 49),
    0,
    0,
    "Mesa_1"
}, {
    "CarpetNoise",
    Color3.fromRGB(218, 162, 106),
    0,
    0,
    "Mesa_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(213, 146, 95),
    0,
    0,
    nil
});
add_wrap("Common", "Red Carpet", {
    "CarpetNoise",
    Color3.fromRGB(147, 24, 40),
    0,
    0,
    "Red_Carpet_1"
}, {
    "CandyGlossy",
    Color3.fromRGB(255, 178, 110),
    0,
    0,
    "Red_Carpet_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 187, 128),
    0,
    0.1,
    nil
});
add_wrap("Common", "Lemonade", {
    Enum.Material.Glass,
    Color3.fromRGB(248, 217, 109),
    0,
    0,
    "Lemonade_1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 243, 207),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(253, 234, 141),
    0,
    0,
    nil
});
add_wrap("Common", "Creamsicle", {
    "Popsicle",
    Color3.fromRGB(239, 119, 27),
    0,
    0,
    "Orange_Creamsicle_1"
}, {
    "IceCream",
    Color3.fromRGB(236, 212, 192),
    0,
    0,
    "Orange_Creamsicle_2"
}, {
    nil,
    Color3.fromRGB(255, 144, 70),
    0,
    0,
    nil
});
add_wrap("Common", "Waffle Cone", {
    "WaffleCone",
    Color3.fromRGB(204, 150, 92),
    0,
    0,
    "Waffle_Cone_1"
}, {
    "WaffleConeShiny",
    Color3.fromRGB(89, 53, 44),
    0,
    0,
    "Waffle_Cone_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(77, 47, 39),
    0,
    0,
    nil
});
add_wrap("Common", "Water Blaster", {
    "ToyPlastic",
    Color3.fromRGB(228, 236, 69),
    0,
    0,
    "Water_Blaster_1"
}, {
    "ToyPlastic",
    Color3.fromRGB(120, 213, 63),
    0,
    0,
    "Water_Blaster_2"
}, {
    "ToyPlastic",
    Color3.fromRGB(236, 82, 43),
    0,
    0,
    "Water_Blaster_3"
});
add_wrap("Common", "Confetti Cake", {
    "Cake",
    Color3.fromRGB(248, 229, 207),
    0,
    0,
    "Birthday_Cake_1"
}, {
    "IceCream",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Birthday_Cake_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(175, 139, 114),
    0,
    0,
    nil
}, nil, "Earned from the 2nd RIVALS Birthday Party");
add_wrap("Common", "Toxin", {
    Enum.Material.Neon,
    Color3.fromRGB(26, 165, 26),
    0,
    0,
    "Toxin_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(111, 175, 54),
    0,
    0,
    nil
});
add_wrap("Rare", "Gold", {
    Enum.Material.Glass,
    Color3.fromRGB(255, 170, 24),
    0,
    0.4,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 170, 24),
    0,
    0.4,
    nil
}, {
    nil,
    Color3.fromRGB(255, 165, 120),
    nil,
    nil,
    nil
}, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon");
add_wrap("Rare", "Forest Camo", {
    "Forest Camo",
    Color3.fromRGB(237, 234, 234),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(140, 255, 98),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Honeycomb", {
    "Honeycomb",
    Color3.fromRGB(255, 201, 74),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(170, 121, 72),
    0,
    0,
    nil
});
add_wrap("Rare", "Patriot", {
    "Patriot",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(168, 168, 168),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Clouds", {
    "Clouds",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 98, 148),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(123, 150, 163),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Swirls", {
    "Swirls",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(167, 167, 167),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Brain", {
    "Brain",
    Color3.fromRGB(255, 152, 220),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 106, 228),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Arctic Camo", {
    "Arctic Camo",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(154, 175, 194),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Carpet", {
    "Carpet",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(139, 139, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Circuit", {
    "Circuit",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(105, 206, 105),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Desert Camo", {
    "Desert Camo",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(163, 141, 116),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Digital Camo", {
    "Digital Camo",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(161, 161, 161),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Frosted", {
    "Frosted",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(161, 239, 255),
    0,
    0.4,
    nil
}, {
    nil,
    Color3.fromRGB(128, 163, 175),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Mainframe", {
    "Mainframe",
    Color3.fromRGB(255, 102, 204),
    0,
    0,
    nil
}, {
    "Mainframe",
    Color3.fromRGB(7, 14, 29),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(231, 135, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Ocean Camo", {
    "Ocean Camo",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(108, 130, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "PB & J", {
    "PB & J",
    Color3.fromRGB(212, 144, 189),
    0,
    0,
    nil
}, {
    "PB & J",
    Color3.fromRGB(212, 144, 189),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(143, 120, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Reptile", {
    "Reptile",
    Color3.fromRGB(103, 127, 51),
    0,
    0,
    nil
}, {
    "Reptile",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(146, 255, 106),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Rug", {
    "Rug",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(157, 157, 157),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(163, 163, 163),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Steel", {
    "Steel",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(54, 54, 54),
    0,
    0.4,
    nil
}, {
    nil,
    Color3.fromRGB(159, 159, 159),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Street Camo", {
    "Street Camo",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(180, 172, 112),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Urban Camo", {
    "Urban Camo",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 131, 131),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Medium stone grey", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(163, 162, 165),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(163, 162, 165),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(163, 162, 165),
    0,
    0,
    nil
});
add_wrap("Rare", "Studs", { nil, nil, 0, 0, "Studs" }, { nil, nil, 0, 0, "Studs" });
add_wrap("Rare", "Inlets", { nil, nil, 0, 0, "Inlets" }, { nil, nil, 0, 0, "Inlets" });
add_wrap("Rare", "Universal", { nil, nil, 0, 0, "Universal" }, { nil, nil, 0, 0, "Universal" });
add_wrap("Rare", "Surge", {
    nil,
    Color3.fromRGB(109, 25, 47),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(23, 59, 111),
    0,
    0,
    nil
});
add_wrap("Rare", "Vile", {
    nil,
    Color3.fromRGB(75, 35, 136),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(101, 147, 49),
    0,
    0,
    nil
});
add_wrap("Rare", "OranGG", {
    nil,
    Color3.fromRGB(206, 206, 206),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 106, 0),
    0,
    0,
    nil
});
add_wrap("Rare", "Maize", {
    nil,
    Color3.fromRGB(0, 39, 76),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 203, 5),
    0,
    0,
    nil
});
add_wrap("Rare", "Spartan", {
    nil,
    Color3.fromRGB(24, 69, 59),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
});
add_wrap("Rare", "Crossed", {
    "Crossed",
    Color3.fromRGB(0, 153, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 32, 54),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(76, 94, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Celtic", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(27, 39, 22),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(175, 142, 86),
    0,
    0,
    "Celtic"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(175, 142, 86),
    0,
    0,
    nil
});
add_wrap("Rare", "Dawn", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 204, 0),
    0,
    0,
    "Dawn1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(28, 52, 117),
    0,
    0,
    "Dawn2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 122, 90),
    0,
    0,
    nil
});
add_wrap("Rare", "Termination", {
    Enum.Material.Metal,
    Color3.fromRGB(117, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 255, 255),
    0,
    0.05,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(170, 57, 57),
    0,
    0,
    nil
});
add_wrap("Rare", "Fiery", {
    Enum.Material.Neon,
    Color3.fromRGB(159, 29, 29),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 145, 91),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(185, 34, 34),
    0,
    0,
    nil
});
add_wrap("Rare", "Portal", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 102, 204),
    0,
    0,
    "Portal"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 152, 220),
    0,
    0.4,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 152, 220),
    0,
    0,
    nil
});
add_wrap("Rare", "Voltaic", {
    "Voltaic",
    Color3.fromRGB(226, 155, 64),
    0,
    0,
    nil
}, {
    Enum.Material.Metal,
    Color3.fromRGB(226, 155, 64),
    0,
    0,
    nil
}, {
    Enum.Material.ForceField,
    Color3.fromRGB(226, 155, 64),
    0,
    0,
    nil
});
add_wrap("Rare", "Carmine", {
    Enum.Material.Glass,
    Color3.fromRGB(117, 0, 0),
    0.15,
    0,
    nil
}, {
    "Carmine",
    Color3.fromRGB(86, 36, 36),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(189, 0, 0),
    0,
    0,
    nil
});
add_wrap("Rare", "Money", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Money"
}, {
    Enum.Material.Plastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(102, 255, 99),
    0,
    0,
    nil
});
add_wrap("Rare", "Eco", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 163, 0),
    0,
    0,
    "Eco"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 163, 0),
    0,
    0,
    nil
});
add_wrap("Rare", "Igneous", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0.05,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 176, 111),
    0,
    0,
    "Igneous"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(168, 145, 93),
    0,
    0,
    nil
});
add_wrap("Rare", "Spellslinger", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Spellsling"
}, {
    "Spellslinger",
    Color3.fromRGB(12, 156, 127),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(101, 182, 159),
    0,
    0,
    nil
});
add_wrap("Rare", "White", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 255, 255),
    nil,
    nil,
    nil
}, nil, "Earned by reaching Level 50 on a weapon", "Earned by reaching Level 50 on this weapon");
add_wrap("Rare", "Black", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(0, 0, 0),
    nil,
    nil,
    nil
}, nil, "Earned by reaching Level 99 on a weapon", "Earned by reaching Level 99 on this weapon");
add_wrap("Rare", "Nova", {
    "Nova",
    Color3.fromRGB(19, 255, 224),
    0,
    0,
    nil
}, {
    "Nova",
    Color3.fromRGB(0, 120, 94),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(89, 255, 191),
    nil,
    nil,
    nil
}, nil, "Rare drop from Daily Tasks");
add_wrap("Rare", "Fire", {
    Enum.Material.Neon,
    Color3.fromRGB(102, 77, 0),
    0,
    0,
    "Fire"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 100, 0),
    0,
    0.1,
    nil
}, {
    nil,
    Color3.fromRGB(255, 106, 69),
    nil,
    nil,
    nil
}, nil, "Earned by winning 10 duels in a row");
add_wrap("Rare", "Trophy", {
    Enum.Material.Neon,
    Color3.fromRGB(168, 158, 66),
    0,
    0,
    "Trophy"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(252, 255, 96),
    0,
    0.1,
    nil
}, {
    nil,
    Color3.fromRGB(252, 255, 96),
    nil,
    nil,
    nil
}, nil, "Earned by winning 25 duels");
add_wrap("Rare", "Experience", {
    Enum.Material.Neon,
    Color3.fromRGB(94, 145, 157),
    0,
    0,
    "Experience"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(30, 150, 255),
    0,
    0.1,
    nil
}, {
    nil,
    Color3.fromRGB(106, 166, 191),
    nil,
    nil,
    nil
}, nil, "Earned every 10 career levels");
add_wrap("Rare", "Rage", {
    "Rage",
    Color3.fromRGB(255, 121, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(38, 14, 27),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(190, 72, 72),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Scales", {
    "Scales",
    Color3.fromRGB(255, 202, 128),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(47, 28, 7),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 143, 121),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Obsidian", {
    "Arabesque",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(25, 24, 36),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(143, 120, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Toy", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(55, 134, 37),
    0,
    0.1,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(55, 134, 37),
    0,
    0.1,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(55, 134, 37),
    0,
    0.1,
    nil
});
add_wrap("Rare", "Well Done", {
    "A5",
    Color3.fromRGB(72, 56, 40),
    0,
    0,
    nil
}, {
    Enum.Material.Concrete,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 163, 140),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Dunes", {
    "Dunes",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Dunes",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(171, 157, 125),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Glisten", {
    "Glisten",
    Color3.fromRGB(4, 175, 236),
    0,
    0,
    nil
}, {
    "Glisten",
    Color3.fromRGB(0, 88, 120),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(126, 154, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Glossy", {
    "Glossy",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Glossy",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 169, 218),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Storm", {
    "Storm",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    "Storm",
    Color3.fromRGB(44, 41, 70),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(150, 140, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Bunsen", {
    "Bunsen",
    Color3.fromRGB(33, 84, 185),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(5, 22, 59),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(17, 61, 255),
    nil,
    nil,
    nil
});
add_wrap("Rare", "Black Granite", {
    "Black Granite",
    Color3.fromRGB(223, 223, 222),
    0,
    0,
    nil
}, {
    "Black Granite",
    Color3.fromRGB(91, 93, 105),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0.75,
    0,
    nil
});
add_wrap("Rare", "Cerulean", {
    "Resolute",
    Color3.fromRGB(0, 255, 255),
    0,
    0,
    nil
}, {
    "Resolute",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(61, 255, 110),
    0,
    0,
    nil
});
add_wrap("Rare", "Clamshell", {
    "Clamshell",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 226, 212),
    0,
    0.3,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(233, 182, 213),
    0,
    0,
    nil
});
add_wrap("Rare", "Cool Crochet", {
    "Crochet",
    Color3.fromRGB(117, 127, 106),
    0,
    0,
    nil
}, {
    "Crochet",
    Color3.fromRGB(116, 134, 157),
    0,
    0,
    nil
}, {
    "Crochet",
    Color3.fromRGB(116, 134, 157),
    0,
    0,
    nil
});
add_wrap("Rare", "Cork", {
    "Cork",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    "Cork",
    Color3.fromRGB(163, 162, 165),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(203, 171, 149),
    0,
    0,
    nil
});
add_wrap("Rare", "Hammered Copper", {
    "Hammered",
    Color3.fromRGB(140, 96, 64),
    0,
    0,
    nil
}, {
    "Hammered",
    Color3.fromRGB(140, 96, 64),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(204, 117, 95),
    0,
    0,
    nil
});
add_wrap("Rare", "Hypnotic", {
    "Hypnotic 1",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    "Hypnotic 2",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(223, 143, 255),
    0,
    0,
    nil
});
add_wrap("Rare", "Leafy Grass", {
    "Leafy Grass",
    Color3.fromRGB(223, 223, 222),
    0,
    0,
    nil
}, {
    "Leafy Grass",
    Color3.fromRGB(163, 162, 165),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(132, 197, 104),
    0,
    0,
    nil
});
add_wrap("Rare", "Liquid Chrome", {
    "Liquid Chrome",
    Color3.fromRGB(193, 193, 193),
    0,
    0,
    nil
}, {
    "Liquid Chrome",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(155, 158, 193),
    0,
    0,
    nil
});
add_wrap("Rare", "Mahogany", {
    "Mahogany Wood",
    Color3.fromRGB(194, 124, 74),
    0,
    0,
    nil
}, {
    "Mahogany Wood",
    Color3.fromRGB(117, 62, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(199, 141, 107),
    0,
    0,
    nil
});
add_wrap("Rare", "Neo", {
    "Neo",
    Color3.fromRGB(4, 175, 236),
    0,
    0,
    nil
}, {
    "Neo",
    Color3.fromRGB(61, 21, 133),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(82, 124, 174),
    0,
    0,
    nil
});
add_wrap("Rare", "Pink Crochet", {
    "Crochet",
    Color3.fromRGB(255, 152, 220),
    0,
    0,
    nil
}, {
    "Crochet",
    Color3.fromRGB(172, 103, 149),
    0,
    0,
    nil
}, {
    "Crochet",
    Color3.fromRGB(255, 152, 220),
    0,
    0,
    nil
});
add_wrap("Rare", "Pink Glitter", {
    "Pink Glitter",
    Color3.fromRGB(255, 152, 220),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 152, 220),
    0,
    0.3,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(183, 113, 197),
    0,
    0,
    nil
});
add_wrap("Rare", "Studded", { "Studded", nil, 0, 0, nil }, { "Studded", nil, 0, 0, nil });
add_wrap("Rare", "Tempest", {
    Enum.Material.Neon,
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Tempest1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(167, 167, 167),
    0,
    0,
    "Tempest2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 138, 149),
    0,
    0,
    nil
});
add_wrap("Rare", "Yang", {
    "Yin Yang",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
});
add_wrap("Rare", "Yin", {
    "Yin Yang",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
});
add_wrap("Rare", "Ancient", {
    "Ancient2",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Ancient1",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(164, 189, 71),
    0,
    0,
    nil
});
add_wrap("Rare", "Grass", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(205, 205, 205),
    0,
    0,
    nil
}, {
    "Grass1",
    Color3.fromRGB(223, 223, 222),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(138, 171, 133),
    0,
    0,
    nil
});
add_wrap("Rare", "Rustic", {
    "RusticWood",
    Color3.fromRGB(124, 92, 70),
    0,
    0,
    nil
}, {
    "BrushedMetal",
    Color3.fromRGB(202, 203, 209),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(221, 177, 145),
    0,
    0,
    nil
});
add_wrap("Rare", "Chrome Webs", {
    "Chrome Webs",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    "Chrome Webs",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
});
add_wrap("Rare", "Green Goo", {
    Enum.Material.Neon,
    Color3.fromRGB(83, 161, 82),
    0,
    0,
    "GooWelds"
}, {
    Enum.Material.Plastic,
    Color3.fromRGB(76, 46, 29),
    0,
    0,
    "GooStudsG"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(83, 161, 82),
    0,
    0,
    "GooWelds"
});
add_wrap("Rare", "Purple Goo", {
    Enum.Material.Neon,
    Color3.fromRGB(88, 54, 163),
    0,
    0,
    "GooWelds"
}, {
    Enum.Material.Plastic,
    Color3.fromRGB(27, 42, 53),
    0,
    0,
    "GooStudsP"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(88, 54, 163),
    0,
    0,
    "GooWelds"
});
add_wrap("Rare", "Werewolf Fur", {
    "Werewolf Fur",
    Color3.fromRGB(111, 85, 34),
    0,
    0,
    nil
}, {
    "Werewolf Fur",
    Color3.fromRGB(74, 56, 23),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(170, 75, 75),
    0,
    0,
    nil
});
add_wrap("Rare", "Snowfall", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Snowfall"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(159, 159, 159),
    0,
    0,
    nil
});
add_wrap("Rare", "Ugly Sweater", {
    "UglySweater",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "UglySweater2",
    Color3.fromRGB(39, 70, 45),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(149, 167, 148),
    0,
    0,
    nil
});
add_wrap("Rare", "Jolly Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(20, 135, 77),
    0,
    0,
    "JollyWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(247, 42, 55),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(247, 71, 74),
    0,
    0,
    nil
});
add_wrap("Rare", "Forest Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(59, 93, 57),
    0,
    0,
    nil
}, {
    "WrappingPearlescent2",
    Color3.fromRGB(252, 252, 252),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(129, 172, 122),
    0,
    0,
    nil
});
add_wrap("Rare", "Peppermint Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(202, 56, 59),
    0,
    0,
    nil
}, {
    "WrappingPearlescent2",
    Color3.fromRGB(252, 252, 252),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(185, 95, 95),
    0,
    0,
    nil
});
add_wrap("Rare", "Winter Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(22, 78, 130),
    0,
    0,
    "WinterWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(252, 252, 252),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(135, 146, 177),
    0,
    0,
    nil
});
add_wrap("Rare", "Mocha Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(206, 176, 158),
    0,
    0,
    nil
}, {
    "WrappingPearlescent",
    Color3.fromRGB(116, 93, 87),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(179, 157, 135),
    0,
    0,
    nil
});
add_wrap("Rare", "Minty Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(38, 150, 126),
    0,
    0,
    "MintyWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(32, 144, 116),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(103, 179, 160),
    0,
    0,
    nil
});
add_wrap("Rare", "Frosty Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(194, 194, 194),
    0,
    0,
    "FrostyWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(217, 239, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(179, 179, 179),
    0,
    0,
    nil
});
add_wrap("Rare", "Creme Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(150, 47, 69),
    0,
    0,
    "CremeWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(184, 58, 85),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(184, 101, 119),
    0,
    0,
    nil
});
add_wrap("Rare", "Blush Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(247, 175, 218),
    0,
    0,
    "BlushWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(230, 140, 152),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(230, 140, 152),
    0,
    0,
    nil
});
add_wrap("Rare", "Cashmere Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(186, 135, 112),
    0,
    0,
    nil
}, {
    "WrappingPearlescent",
    Color3.fromRGB(255, 158, 128),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 149, 128),
    0,
    0,
    nil
});
add_wrap("Rare", "Carbon Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(56, 58, 59),
    0,
    0,
    "CarbonWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(83, 97, 103),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(151, 157, 179),
    0,
    0,
    nil
});
add_wrap("Rare", "Caned Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(181, 47, 65),
    0,
    0,
    "CanedWrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(150, 39, 56),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(171, 84, 98),
    0,
    0,
    nil
});
add_wrap("Rare", "Arbiter", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(36, 56, 70),
    0,
    0,
    "Arbiter"
}, {
    "Arbiter",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(120, 135, 171),
    0,
    0,
    nil
});
add_wrap("Rare", "Antimatter", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 0, 4),
    0,
    0,
    "Antimatter1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(71, 0, 0),
    0,
    0,
    "Antimatter2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(157, 0, 0),
    0,
    0,
    nil
});
add_wrap("Rare", "Crimson Art", {
    "CrimsonArt",
    Color3.fromRGB(213, 213, 213),
    0,
    0,
    "CrimsonArt1"
}, {
    "CrimsonArt",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(159, 73, 73),
    0,
    0,
    nil
});
add_wrap("Rare", "Model", {
    "RBLXPckge",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(163, 162, 165),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(88, 111, 166),
    0,
    0,
    nil
});
add_wrap("Rare", "Plasma", {
    Enum.Material.Neon,
    Color3.fromRGB(163, 137, 176),
    0,
    0,
    "Plasma1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(81, 0, 179),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(155, 130, 167),
    0,
    0,
    nil
});
add_wrap("Rare", "Purpleize", {
    "Purpleize",
    Color3.fromRGB(224, 178, 208),
    0,
    0,
    nil
}, {
    "Purpleize",
    Color3.fromRGB(167, 94, 155),
    0,
    0.05,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 122, 172),
    0,
    0,
    nil
});
add_wrap("Rare", "Regal", {
    "RegalFabric",
    Color3.fromRGB(186, 0, 0),
    0,
    0.3,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(243, 182, 0),
    0,
    0.6,
    "Regal"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(171, 125, 99),
    0,
    0,
    nil
});
add_wrap("Rare", "Sentinel", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0.5,
    "Sentinel"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0.5,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(168, 143, 124),
    0,
    0,
    nil
});
add_wrap("Rare", "Strobe", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Strobe1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Strobe2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(111, 158, 166),
    0,
    0,
    nil
});
add_wrap("Rare", "TIX", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(19, 21, 22),
    0,
    0,
    "TIXWRAP"
}, {
    Enum.Material.Plastic,
    Color3.fromRGB(71, 44, 12),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(166, 146, 85),
    0,
    0,
    nil
});
add_wrap("Rare", "Tealur", {
    Enum.Material.Neon,
    Color3.fromRGB(73, 166, 138),
    0,
    0,
    "Tealur"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(23, 23, 23),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(70, 159, 131),
    0,
    0,
    nil
});
add_wrap("Rare", "Waste", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 168, 67),
    0,
    0,
    "Waste1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Waste2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(58, 158, 58),
    0,
    0,
    nil
});
add_wrap("Rare", "Lovely Leopard", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "LovelyLeopard1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "LovelyLeopard2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 119, 162),
    0,
    0,
    nil
});
add_wrap("Rare", "Facility", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(57, 58, 72),
    0,
    0,
    "Facility"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(159, 163, 191),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(57, 58, 72),
    0,
    0,
    nil
});
add_wrap("Rare", "Vigor", {
    "Vigor",
    Color3.fromRGB(255, 71, 135),
    0,
    0,
    "Vigor1"
}, {
    "Vigor",
    Color3.fromRGB(231, 64, 123),
    0,
    0,
    "Vigor2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 37, 95),
    0.33,
    0.4,
    nil
});
add_wrap("Rare", "Bliss", {
    Enum.Material.Glass,
    Color3.fromRGB(164, 166, 255),
    0,
    0.3,
    nil
}, {
    "Bliss",
    Color3.fromRGB(132, 119, 173),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(133, 126, 206),
    0,
    0,
    nil
});
add_wrap("Rare", "Holly Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(135, 33, 33),
    0,
    0,
    "Holly_Wrapping_1"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(61, 149, 72),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(102, 180, 111),
    0,
    0,
    nil
});
add_wrap("Rare", "Fortune Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(45, 85, 55),
    0,
    0,
    "Wrapped_Fortune_1"
}, {
    "Pearlescent_01a",
    Color3.fromRGB(255, 196, 93),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(207, 169, 113),
    0,
    0,
    nil
});
add_wrap("Rare", "Pearly Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(218, 195, 173),
    0,
    0,
    "Pearly_Wrapping_1"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(255, 236, 220),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(167, 154, 144),
    0,
    0,
    nil
});
add_wrap("Rare", "Polar Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(15, 15, 15),
    0,
    0,
    "Polar_Wrapping_1"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(233, 241, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(155, 161, 170),
    0,
    0,
    nil
});
add_wrap("Rare", "Chilled Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(98, 221, 232),
    0,
    0,
    "Chilled_Wrapping_1"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(110, 212, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(112, 196, 204),
    0,
    0,
    nil
});
add_wrap("Rare", "Luxury Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(59, 58, 57),
    0,
    0,
    "Wrapped_Luxury_1"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(255, 233, 190),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(180, 170, 152),
    0,
    0,
    nil
});
add_wrap("Rare", "Regal Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(149, 30, 48),
    0,
    0,
    "Regal_Wrapping_1"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(255, 191, 87),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(207, 154, 113),
    0,
    0,
    nil
});
add_wrap("Rare", "Mousse Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(134, 98, 82),
    0,
    0,
    nil
}, {
    "Pearlescent_01b",
    Color3.fromRGB(117, 85, 72),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(166, 123, 106),
    0,
    0,
    nil
});
add_wrap("Rare", "Periwinkle Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(190, 187, 227),
    0,
    0,
    nil
}, {
    "Pearlescent_01a",
    Color3.fromRGB(95, 70, 107),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(159, 128, 174),
    0,
    0,
    nil
});
add_wrap("Rare", "Evergreen Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(59, 93, 57),
    0,
    0,
    nil
}, {
    "Pearlescent_01a",
    Color3.fromRGB(98, 153, 94),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(113, 170, 107),
    0,
    0,
    nil
});
add_wrap("Rare", "Dusky Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(64, 73, 107),
    0,
    0,
    nil
}, {
    "Pearlescent_01a",
    Color3.fromRGB(117, 134, 171),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(129, 144, 180),
    0,
    0,
    nil
});
add_wrap("Rare", "Merlot Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(143, 47, 65),
    0,
    0,
    nil
}, {
    "Pearlescent_01a",
    Color3.fromRGB(202, 67, 94),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(194, 118, 136),
    0,
    0,
    nil
});
add_wrap("Rare", "Indigo Wrapping", {
    "WrappingPaper_01a",
    Color3.fromRGB(56, 24, 161),
    0,
    0,
    "Indigo_Wrapping_1"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(78, 46, 184),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(135, 122, 184),
    0,
    0,
    nil
});
add_wrap("Rare", "Cold Metal", {
    Enum.Material.Metal,
    Color3.fromRGB(81, 88, 100),
    0,
    0,
    "Cold_Metal_1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(97, 104, 120),
    0,
    0.1,
    "Cold_Metal_2"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(130, 136, 153),
    0,
    0,
    nil
});
add_wrap("Rare", "Winter Solstice", {
    "CandyGlossy",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Winter_Solstice_1"
}, {
    "CandyGlossy",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Winter_Solstice_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(162, 218, 255),
    0,
    0.02,
    nil
});
add_wrap("Rare", "Mintbread", {
    Enum.Material.Sand,
    Color3.fromRGB(111, 76, 63),
    0,
    0,
    "Mintbread_1"
}, {
    "WrappingPaper",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Mintbread_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(135, 27, 19),
    0,
    0.1,
    nil
});
add_wrap("Rare", "Galvanized", {
    "Galvanized",
    Color3.fromRGB(102, 108, 112),
    0,
    0,
    nil
}, {
    "Galvanized",
    Color3.fromRGB(113, 124, 131),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(96, 103, 113),
    0,
    0,
    nil
});
add_wrap("Rare", "Ruined Pillars", {
    "Pillars",
    Color3.fromRGB(202, 194, 175),
    0,
    0,
    nil
}, {
    Enum.Material.Plaster,
    Color3.fromRGB(167, 160, 145),
    0,
    0,
    "Ruined_Pillars_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(245, 230, 200),
    0,
    0,
    nil
});
add_wrap("Rare", "Cactus", {
    "Cactus",
    Color3.fromRGB(117, 154, 61),
    0,
    0,
    "Cactus_1"
}, {
    "Cactus",
    Color3.fromRGB(51, 68, 26),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(229, 211, 171),
    0,
    0,
    nil
});
add_wrap("Rare", "Lighthouse", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(237, 244, 248),
    0,
    0,
    "Lighthouse_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(167, 154, 105),
    0,
    0,
    "Lighthouse_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(177, 162, 110),
    0,
    0,
    nil
});
add_wrap("Rare", "Neapolitan", {
    "IceCream",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Neapolitan_1"
}, {
    "WaffleCone",
    Color3.fromRGB(204, 137, 92),
    0,
    0,
    "Neapolitan_2"
}, {
    "IceCream",
    Color3.fromRGB(230, 215, 233),
    0,
    0,
    nil
});
add_wrap("Rare", "Shore", {
    "IceCream",
    Color3.fromRGB(238, 209, 158),
    0,
    0,
    "Shore_1"
}, {
    "IceCream",
    Color3.fromRGB(179, 147, 110),
    0,
    0,
    "Shore_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(128, 187, 219),
    0,
    0.2,
    nil
});
add_wrap("Rare", "Rafflesia", {
    "NatureTest",
    Color3.fromRGB(182, 71, 75),
    0,
    0,
    "Rafflesia_1"
}, {
    "PajamaFur",
    Color3.fromRGB(68, 24, 38),
    0,
    0,
    "Rafflesia_2"
}, {
    nil,
    Color3.fromRGB(255, 106, 92),
    0,
    0,
    nil
});
add_wrap("Legendary", "Diamond", {
    "Diamond",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 170, 24),
    0,
    0.4,
    nil
}, {
    nil,
    Color3.fromRGB(255, 165, 120),
    nil,
    nil,
    nil
}, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon");
add_wrap("Legendary", "Scorched", {
    "Scorched",
    Color3.fromRGB(171, 171, 171),
    0,
    0,
    nil
}, {
    "Scorched",
    Color3.fromRGB(43, 43, 43),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 79, 25),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Glass", {
    Enum.Material.Glass,
    Color3.fromRGB(255, 255, 255),
    0.5,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 255, 255),
    0.5,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 255, 255),
    0.5,
    0,
    nil
});
add_wrap("Legendary", "Malevolent", {
    "Malevolent",
    Color3.fromRGB(163, 162, 165),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(25, 15, 39),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(78, 43, 168),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Omnisand", {
    "Omnisand",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Omnisand",
    Color3.fromRGB(81, 81, 81),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(166, 97, 48),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Quasar", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 72, 0),
    0,
    0,
    "Quasar"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 72, 0),
    0,
    0,
    "Quasar"
}, {
    nil,
    Color3.fromRGB(255, 105, 94),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Slime", {
    "Slime",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    "Slime",
    Color3.fromRGB(70, 53, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(76, 255, 48),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Water", {
    Enum.Material.Neon,
    Color3.fromRGB(170, 170, 170),
    0,
    0,
    "Water1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(46, 89, 107),
    0,
    0,
    "Water2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(77, 129, 175),
    0,
    0,
    nil
});
add_wrap("Legendary", "Black Opal", {
    Enum.Material.Neon,
    Color3.fromRGB(96, 241, 96),
    0,
    0,
    "BlackOpal"
}, {
    "Black Opal",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(92, 163, 125),
    0,
    0,
    nil
});
add_wrap("Legendary", "Hesper", {
    "Hesper",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    "Hesper",
    Color3.fromRGB(11, 33, 48),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 118, 76),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Sunset", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(213, 115, 61),
    0,
    0,
    "Sunset"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(213, 115, 61),
    0,
    0,
    nil
});
add_wrap("Legendary", ".exe", {
    Enum.Material.Neon,
    Color3.fromRGB(138, 225, 118),
    0,
    0,
    ".exe"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(138, 225, 118),
    0,
    0,
    nil
});
add_wrap("Legendary", "Disco", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0.5,
    "Disco"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0.5,
    nil
}, {
    nil,
    Color3.fromRGB(255, 255, 255),
    nil,
    nil,
    nil
}, nil, "Included in the Standard Weapons Bundle");
add_wrap("Legendary", "Classic", {
    Enum.Material.Plastic,
    Color3.fromRGB(27, 42, 53),
    0,
    0,
    nil
}, {
    Enum.Material.Plastic,
    Color3.fromRGB(27, 42, 53),
    0,
    0,
    nil
}, {
    Enum.Material.Plastic,
    Color3.fromRGB(27, 42, 53),
    0.5,
    0,
    nil
}, nil, "Included in the Classic Bundle");
add_wrap("Legendary", "Magma", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 141, 75),
    0,
    0,
    "Magma"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 141, 75),
    0,
    0,
    "Magma"
}, {
    nil,
    Color3.fromRGB(255, 141, 75),
    nil,
    nil,
    nil
}, nil, "Included in the Heavy Duty Bundle");
add_wrap("Legendary", "Nebula", {
    Enum.Material.Neon,
    Color3.fromRGB(137, 100, 248),
    0,
    0,
    "Nebula1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(199, 171, 255),
    0,
    0,
    "Nebula2"
}, {
    nil,
    Color3.fromRGB(133, 103, 255),
    nil,
    nil,
    nil
}, nil, "Included in the Exogun Bundle");
add_wrap("Legendary", "Aurum", {
    Enum.Material.Neon,
    Color3.fromRGB(176, 130, 74),
    0,
    0,
    "Aurum"
}, {
    "Aurum",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(175, 128, 80),
    0,
    0,
    nil
}, nil, "Included in the Medkit Bundle");
add_wrap("Legendary", "Paint", {
    "Paint",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(212, 212, 212),
    0,
    0.1,
    nil
}, {
    nil,
    Color3.fromRGB(212, 212, 212),
    nil,
    nil,
    nil
}, nil, "Included in the Starter Bundle");
add_wrap(
    "Legendary",
    "Geometric",
    { "Geometric", nil, nil, nil, nil },
    { "Geometric", nil, nil, nil, nil },
    { "Geometric", nil, nil, nil, nil }
);
add_wrap("Legendary", ".dll", {
    Enum.Material.Neon,
    Color3.fromRGB(108, 134, 223),
    0,
    0,
    ".dll"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0.05,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(97, 123, 184),
    0,
    0,
    nil
}, nil, "Included in the Energy Bundle");
add_wrap("Legendary", "Cardboard", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(143, 121, 89),
    0,
    0,
    "Cardboard1"
}, {
    Enum.Material.Plaster,
    Color3.fromRGB(117, 98, 72),
    0,
    0,
    "Cardboard2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 130, 109),
    0,
    0,
    nil
}, nil, "Included in the RPG Bundle");
add_wrap("Legendary", "Wealth", {
    "Wealth",
    Color3.fromRGB(0, 255, 0),
    0,
    0,
    nil
}, {
    "Wealth",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(95, 252, 100),
    nil,
    nil,
    nil
}, nil, "Used to be included in Key Bundles");
add_wrap("Legendary", "Lucre", {
    "Wealth",
    Color3.fromRGB(255, 213, 0),
    0,
    0,
    nil
}, {
    "Wealth",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 140, 73),
    nil,
    nil,
    nil
}, nil, "Used to be included in Key Bundles");
add_wrap("Legendary", "Luxurious", {
    Enum.Material.Glass,
    Color3.fromRGB(255, 176, 0),
    0,
    0.6,
    "Luxurious"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 176, 0),
    0,
    0.6,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(167, 156, 117),
    0,
    0,
    nil
}, nil, "Included in Key Bundles");
add_wrap("Legendary", "Supernova", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Supernova"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Supernova"
}, {
    nil,
    Color3.fromRGB(84, 246, 255),
    nil,
    nil,
    nil
}, nil, "Legendary drop from Daily Tasks");
add_wrap("Legendary", "Groove", {
    "Groove",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Groove",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 99, 99),
    nil,
    nil,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Blaze", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 0, 0),
    0,
    0,
    "Blaze1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(154, 85, 32),
    0,
    0,
    "Blaze2"
}, {
    nil,
    Color3.fromRGB(255, 106, 69),
    nil,
    nil,
    nil
}, nil, "Earned by winning 100 duels in a row");
add_wrap("Legendary", "Beach", {
    nil,
    Color3.fromRGB(42, 157, 143),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(233, 196, 106),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(119, 207, 255),
    nil,
    nil,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Malachite", {
    "Malachite",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(94, 255, 148),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Arabesque", {
    "Arabesque",
    Color3.fromRGB(98, 77, 0),
    0,
    0.2,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(98, 77, 0),
    0,
    0.4,
    nil
}, {
    nil,
    Color3.fromRGB(170, 154, 115),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Webbed", {
    "Webbed",
    Color3.fromRGB(117, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(27, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 69, 69),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Lightning", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 125, 92),
    0,
    0,
    "Lightning"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(72, 34, 14),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(166, 123, 94),
    0,
    0,
    nil
});
add_wrap("Legendary", "Plastic", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0.5,
    0.5,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0.5,
    0.5,
    nil
}, {
    nil,
    Color3.fromRGB(255, 255, 255),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Chrome", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    1,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    1,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    1,
    nil
});
add_wrap("Legendary", "A5", {
    "A5",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Concrete,
    Color3.fromRGB(255, 220, 192),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 139, 139),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Amber", {
    "Amber",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Amber",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 158, 93),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Insidious", {
    "Insidious",
    Color3.fromRGB(190, 104, 98),
    0,
    0,
    nil
}, {
    "Insidious",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(255, 111, 111),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Iridescent", {
    Enum.Material.Neon,
    Color3.fromRGB(166, 145, 211),
    0,
    0,
    "Iridescent1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(166, 145, 211),
    0,
    0,
    "Iridescent2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(156, 143, 163),
    0,
    0,
    nil
});
add_wrap("Legendary", "Moonstone", {
    "Moonstone",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "Moonstone",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(146, 160, 190),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Bright", {
    Enum.Material.Neon,
    Color3.fromRGB(160, 160, 160),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(160, 160, 160),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(160, 160, 160),
    0,
    0,
    nil
});
add_wrap("Legendary", "Dark", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
});
add_wrap("Legendary", "Mischief", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Mischief"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(53, 39, 94),
    0,
    0,
    nil
}, {
    nil,
    Color3.fromRGB(139, 131, 255),
    nil,
    nil,
    nil
});
add_wrap("Legendary", "Carbon Fiber", {
    "Carbon Fiber",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    "Carbon Fiber",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
});
add_wrap("Legendary", "Hyperdrive", {
    "Hyperdrive",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(143, 156, 173),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(159, 173, 192),
    0,
    0,
    nil
});
add_wrap("Legendary", "Insignia", {
    "Insignia",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    "Insignia",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(199, 172, 120),
    0,
    0,
    nil
});
add_wrap("Legendary", "Liquid Gold", {
    "Liquid Gold",
    Color3.fromRGB(180, 123, 0),
    0,
    0,
    nil
}, {
    "Liquid Gold",
    Color3.fromRGB(255, 176, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(199, 172, 120),
    0,
    0,
    nil
});
add_wrap("Legendary", "Cardinal", {
    "Cardinal",
    Color3.fromRGB(255, 175, 175),
    0,
    0,
    nil
}, {
    "Cardinal",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(227, 74, 76),
    0,
    0,
    nil
});
add_wrap("Legendary", "Starblaze", {
    "Starblaze 2",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    nil
}, {
    "Starblaze 1",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(177, 35, 25),
    0,
    0,
    nil
});
add_wrap("Legendary", "Starfall", {
    "Hyperdrive",
    Color3.fromRGB(9, 137, 207),
    0,
    0,
    nil
}, {
    "Starblaze 1",
    Color3.fromRGB(0, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(24, 74, 255),
    0,
    0,
    nil
});
add_wrap("Legendary", "Tiger", {
    "Tiger",
    Color3.fromRGB(255, 114, 14),
    0,
    0,
    nil
}, {
    "Tiger",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 86, 7),
    0,
    0,
    nil
});
add_wrap("Legendary", "Watermelon", {
    "Watermelon Red",
    Color3.fromRGB(255, 131, 131),
    0,
    0,
    nil
}, {
    "Watermelon Green",
    Color3.fromRGB(204, 255, 204),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 75, 75),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Damascus", {
    "Damascus",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(195, 195, 195),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Black Damascus", {
    "BlackDamascus",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Pixel Blight", {
    Enum.Material.Neon,
    nil,
    0,
    0,
    "PixelBlight",
    "Pixel Blight"
}, {
    Enum.Material.Neon,
    nil,
    0,
    0,
    "PixelBlight",
    "Pixel Blight"
}, {
    Enum.Material.Neon,
    nil,
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Empress", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Empress"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Empress"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(172, 150, 181),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Arena", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(151, 153, 163),
    0,
    0,
    "ArenaTex"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(132, 134, 143),
    0,
    0,
    "ArenaTex"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(151, 153, 163),
    0,
    0,
    nil
}, nil, "Purchased from the Shop");
add_wrap("Legendary", "Simulation", {
    Enum.Material.Neon,
    Color3.fromRGB(30, 98, 153),
    0,
    0,
    "Simulation_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(16, 51, 81),
    0,
    0,
    "Simulation_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(80, 122, 170),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Sunset Sparkle", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 137, 137),
    0,
    0,
    "SunsetSparkle1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(88, 0, 117),
    0,
    0,
    "SunsetSparkle2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 122, 90),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Messis", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Messis1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Messis2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(82, 159, 72),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Birthday Wrapping", {
    "WrappingPaper_01c",
    Color3.fromRGB(68, 117, 223),
    0,
    0,
    nil
}, {
    "Pearlescent_01c",
    Color3.fromRGB(255, 173, 32),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(173, 150, 110),
    0,
    0,
    nil
}, nil, "Purchased from the Shop during the RIVALS Birthday Party");
add_wrap("Legendary", "RIVALS Wrapping", {
    "WrappingPaper_01c",
    Color3.fromRGB(255, 148, 26),
    0,
    0,
    "RivalsWrapping"
}, {
    "Pearlescent_01d",
    Color3.fromRGB(161, 18, 166),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(145, 114, 172),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop during the 1st RIVALS Birthday Party");
add_wrap("Legendary", "Shadow Ink", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "ShadowInk1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "ShadowInk2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(91, 76, 171),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Triplaser", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0.5,
    "Tripwire1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(199, 199, 199),
    0,
    0.5,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 73, 73),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Hologram Arena", {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0.7,
    0,
    "HologramArena1"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "HologramArena2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(96, 155, 176),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Honey", {
    "Honey",
    Color3.fromRGB(255, 159, 42),
    0,
    0,
    "Honey1"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(212, 119, 19),
    0.25,
    0,
    "Honey2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(166, 110, 61),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Ornamented", {
    Enum.Material.Glass,
    Color3.fromRGB(151, 25, 42),
    0,
    0.2,
    "Ornament_1"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(190, 149, 115),
    0,
    -1.5,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(173, 28, 50),
    0.2,
    0.1,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Frostbite", {
    Enum.Material.Neon,
    Color3.fromRGB(109, 113, 172),
    0,
    0,
    "Frostbite_1"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(67, 78, 95),
    0,
    0,
    "Frostbite_2"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(46, 54, 65),
    0.1,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Fire Horse", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 89, 34),
    0,
    0,
    "Fire_Horse_1"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(176, 0, 0),
    0,
    0,
    "Fire_Horse_2"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(193, 137, 42),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Serenity", {
    "CupidFluff",
    Color3.fromRGB(255, 143, 173),
    0,
    0,
    "Serenity_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(162, 91, 107),
    0,
    0,
    "Serenity_2"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 142, 187),
    0.5,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Ladybug", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(117, 14, 0),
    0,
    0.05,
    "Ladybug_1"
}, {
    "Ladybug1",
    Color3.fromRGB(27, 42, 53),
    0,
    0,
    nil
}, {
    "Ladybug2",
    Color3.fromRGB(152, 194, 219),
    0.4,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Woven", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(238, 180, 255),
    0,
    0,
    "Easter_Basket_1"
}, {
    "Basket",
    Color3.fromRGB(147, 99, 73),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(238, 180, 255),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Resolute", {
    "Resolute",
    Color3.fromRGB(0, 16, 176),
    0,
    0,
    nil
}, {
    "Resolute",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 255),
    0,
    0,
    nil
});
add_wrap("Legendary", "Thunderburst", {
    Enum.Material.Neon,
    Color3.fromRGB(253, 234, 141),
    0,
    0,
    "Thunderburst"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0.05,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 160, 130),
    0,
    0,
    nil
});
add_wrap("Legendary", "Encrypt", {
    "Encrypt",
    Color3.fromRGB(0, 172, 57),
    0,
    0,
    nil
}, {
    "Encrypt",
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(131, 255, 129),
    0,
    0,
    nil
});
add_wrap("Legendary", "Mummy", {
    Enum.Material.Neon,
    Color3.fromRGB(121, 171, 96),
    0,
    0,
    "Mummy"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(121, 171, 96),
    0,
    0,
    "MummyDark"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(121, 171, 96),
    0,
    0,
    nil
});
add_wrap("Legendary", "Scourge", {
    "Scourge",
    Color3.fromRGB(170, 85, 0),
    0,
    0,
    nil
}, {
    "Scourge",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(168, 90, 0),
    0,
    0,
    nil
});
add_wrap("Legendary", "Frankenstein", {
    "Frankenstein",
    Color3.fromRGB(83, 135, 0),
    0,
    0,
    nil
}, {
    "Frankenstein Metal",
    Color3.fromRGB(145, 161, 168),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(104, 163, 109),
    0,
    0,
    nil
});
add_wrap("Legendary", "Hallow", {
    nil,
    Color3.fromRGB(0, 0, 0),
    0,
    0.05,
    nil
}, {
    nil,
    Color3.fromRGB(255, 119, 0),
    0,
    0.1,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 119, 0),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Greenflame", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 255, 0),
    0,
    0,
    "Greenflame1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(117, 162, 48),
    0,
    0,
    "Greenflame2"
}, {
    nil,
    Color3.fromRGB(122, 255, 14),
    nil,
    nil,
    nil
}, nil, "Included in Candy Bundles");
add_wrap("Legendary", "Aurora", {
    Enum.Material.Neon,
    Color3.fromRGB(129, 255, 110),
    0,
    0,
    "Aurora"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(129, 255, 110),
    0,
    0,
    nil
});
add_wrap("Legendary", "Wintergreen", {
    "GlossyCandyCane2",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "GlossyGeneric",
    Color3.fromRGB(0, 134, 19),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(102, 167, 104),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Gingerbread", {
    "Gingerbread",
    Color3.fromRGB(225, 156, 107),
    0,
    0,
    "Gingerbread"
}, {
    "Gingerbread",
    Color3.fromRGB(86, 66, 54),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(167, 153, 130),
    0,
    0,
    nil
});
add_wrap("Legendary", "Peppermint", {
    "GlossyCandyCane",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    "GlossyGeneric",
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 52, 52),
    0,
    0,
    nil
});
add_wrap("Legendary", "Crystallized", {
    Enum.Material.Glass,
    Color3.fromRGB(18, 238, 212),
    0.85,
    0,
    "Crystallized"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(18, 238, 212),
    0.85,
    0,
    "Crystallized"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(175, 221, 255),
    0.5,
    0,
    nil
}, nil, "Included in Crystal Bundles");
add_wrap("Legendary", "2025 Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(59, 58, 57),
    0,
    0,
    "2025Wrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(255, 191, 87),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(179, 173, 88),
    0,
    0,
    nil
});
add_wrap("Legendary", "2026 Wrapping", {
    "WrappingPaper",
    Color3.fromRGB(59, 58, 57),
    0,
    0,
    "2026Wrapping"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(255, 191, 87),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(179, 173, 88),
    0,
    0,
    nil
});
add_wrap("Legendary", "Bombastic", {
    Enum.Material.Neon,
    Color3.fromRGB(220, 97, 40),
    0,
    0,
    "Bombastic1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(53, 53, 53),
    0,
    0,
    "Bombastic2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 93, 47),
    0,
    0,
    nil
});
add_wrap("Legendary", "Candy Apple", {
    "CandyGlossy",
    Color3.fromRGB(23, 152, 0),
    0,
    0,
    "CandyGlossy"
}, {
    "CandyGlossy",
    Color3.fromRGB(255, 128, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(133, 161, 68),
    0,
    0.1,
    nil
});
add_wrap("Legendary", "Dark Arena", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(35, 35, 35),
    0,
    0,
    "DarkArena1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "DarkArena2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    1,
    0,
    "DarkArena3"
});
add_wrap("Legendary", "Green Sparkle", {
    Enum.Material.Neon,
    Color3.fromRGB(39, 70, 45),
    0,
    0,
    "GreenSparkle1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "GreenSparkle2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(124, 161, 64),
    0,
    0,
    nil
});
add_wrap("Legendary", "Indigo Sparkle", {
    Enum.Material.Neon,
    Color3.fromRGB(104, 35, 207),
    0,
    0,
    "IndigoSparkle1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "IndigoSparkle2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(78, 60, 177),
    0,
    0,
    nil
});
add_wrap("Legendary", "Mesh", {
    Enum.Material.ForceField,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "DarkMesh"
}, {
    Enum.Material.ForceField,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "DarkMesh"
}, {
    Enum.Material.ForceField,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "LightMesh"
});
add_wrap("Legendary", "Rift", {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Rift"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(172, 99, 156),
    0,
    0,
    nil
});
add_wrap("Legendary", "Spectral", {
    Enum.Material.Neon,
    Color3.fromRGB(55, 255, 95),
    0,
    0,
    "Spectral"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(71, 255, 203),
    0,
    0.4,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(92, 158, 119),
    0,
    0,
    nil
});
add_wrap("Legendary", "Hologram", {
    Enum.Material.Neon,
    Color3.fromRGB(84, 138, 255),
    0.6,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(84, 138, 255),
    0.6,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(84, 138, 255),
    0.6,
    0,
    nil
});
add_wrap("Legendary", "Bubbles", {
    Enum.Material.ForceField,
    Color3.fromRGB(255, 255, 255),
    0.9,
    0,
    "Bubbles"
}, {
    Enum.Material.ForceField,
    Color3.fromRGB(255, 255, 255),
    0.9,
    0,
    "Bubbles"
}, {
    Enum.Material.ForceField,
    Color3.fromRGB(255, 255, 255),
    0.9,
    0,
    "Bubbles"
}, nil, "Earned by gifting other players");
add_wrap("Legendary", "Black Glass", {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0.6,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0.6,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(0, 0, 0),
    0.6,
    0,
    nil
}, nil, "Purchased from the Ranked Shop");
add_wrap("Legendary", "Magnetite", {
    Enum.Material.Glass,
    Color3.fromRGB(130, 80, 255),
    0,
    -2,
    "Magnetite"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(55, 33, 108),
    0,
    -2,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(81, 21, 166),
    0,
    0,
    nil
});
add_wrap("Legendary", "Devourer", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(82, 84, 111),
    0,
    0,
    "Devourer1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(159, 95, 175),
    0,
    0,
    "Devourer2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(171, 108, 175),
    0,
    0,
    nil
});
add_wrap("Legendary", "Bee", {
    "Bee",
    Color3.fromRGB(255, 217, 103),
    0,
    0,
    "Bee1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(42, 38, 16),
    0,
    0,
    nil
}, {
    "BeeWing",
    Color3.fromRGB(152, 194, 219),
    0.4,
    0,
    nil
});
add_wrap("Legendary", "Mint Choco Chip", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(225, 255, 164),
    0,
    0,
    "MintChocoChip1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(48, 40, 31),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(225, 255, 164),
    0,
    0,
    nil
});
add_wrap("Legendary", "Necromancer", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(27, 42, 53),
    0,
    0,
    "Necromancer1"
}, {
    "NecromancerGlossy",
    Color3.fromRGB(48, 52, 80),
    0,
    0,
    "Necromancer2"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(98, 78, 151),
    0.5,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Stocking Fur", {
    Enum.Material.Sand,
    Color3.fromRGB(151, 0, 0),
    0,
    0,
    "Stocking_1"
}, {
    "StockingFur",
    Color3.fromRGB(234, 242, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Snow,
    Color3.fromRGB(31, 31, 31),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Luxe", {
    Enum.Material.Metal,
    Color3.fromRGB(255, 211, 161),
    0,
    0,
    "Luxe_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(184, 154, 121),
    0,
    0,
    "Luxe_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(171, 149, 125),
    0,
    0,
    nil
});
add_wrap("Legendary", "Peril", {
    "Peril",
    Color3.fromRGB(34, 255, 167),
    0,
    0,
    "Peril1"
}, {
    "Peril",
    Color3.fromRGB(37, 158, 116),
    0,
    0,
    "Peril2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(66, 255, 170),
    0.33,
    0.4,
    nil
});
add_wrap("Legendary", "Wintry", {
    Enum.Material.Glass,
    Color3.fromRGB(210, 249, 255),
    0.3,
    0,
    "Wintry_1"
}, {
    Enum.Material.Glacier,
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Wintry_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(138, 155, 162),
    0,
    0,
    nil
});
add_wrap("Legendary", "Plaid Pajama", {
    "PajamaFur",
    Color3.fromRGB(180, 23, 23),
    0,
    0,
    "Plaid_Pajama_1"
}, {
    Enum.Material.Granite,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(113, 15, 15),
    0,
    0,
    nil
});
add_wrap("Legendary", "Candlelight", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(254, 249, 219),
    0,
    0,
    "Candle_1"
}, {
    "CandyGlossy",
    Color3.fromRGB(255, 179, 103),
    0,
    0,
    "Candle_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(181, 149, 117),
    0,
    0,
    nil
});
add_wrap("Legendary", "Red Rubber", {
    "Balloon",
    Color3.fromRGB(117, 0, 0),
    0,
    0,
    nil
}, {
    "Balloon",
    Color3.fromRGB(86, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(65, 0, 0),
    0,
    -0.75,
    nil
});
add_wrap("Legendary", "Clovers", {
    Enum.Material.Foil,
    Color3.fromRGB(107, 191, 94),
    0,
    0,
    "Clovers_1"
}, {
    "CloverWrappingPearlescent",
    Color3.fromRGB(39, 79, 32),
    0,
    0,
    "Clovers_2"
}, {
    "CloverWrappingPearlescent",
    Color3.fromRGB(91, 165, 78),
    0,
    0,
    nil
});
add_wrap("Legendary", "Heirloom", {
    "AncientRelicBone1",
    Color3.fromRGB(255, 238, 170),
    0,
    0,
    "Ancient_Relic_1"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(239, 179, 118),
    0,
    0,
    "Ancient_Relic_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(179, 161, 119),
    0,
    0,
    nil
});
add_wrap("Legendary", "Mossy Stone", {
    Enum.Material.Cobblestone,
    Color3.fromRGB(67, 74, 83),
    0,
    0,
    "Mossy_Stone_1"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(28, 42, 21),
    0,
    0,
    "Mossy_Stone_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(68, 104, 45),
    0,
    0,
    nil
});
add_wrap("Legendary", "Quartz", {
    "Quartz",
    Color3.fromRGB(163, 157, 154),
    0,
    0,
    "Quartz_1"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(163, 138, 126),
    0.2,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(163, 145, 139),
    0,
    0,
    nil
});
add_wrap("Legendary", "Lucid Halftone", {
    Enum.Material.Neon,
    Color3.fromRGB(177, 167, 255),
    0,
    0,
    "Cool_Halftone_1"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(255, 89, 89),
    0,
    0,
    "Cool_Halftone_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(92, 82, 172),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Shadow Halftone", {
    Enum.Material.Neon,
    Color3.fromRGB(177, 167, 255),
    0,
    0,
    "Warm_Halftone_1"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(255, 89, 89),
    0,
    0,
    "Warm_Halftone_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(197, 108, 170),
    0,
    0,
    nil
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Fame Stars", {
    "RobloxMarble",
    Color3.fromRGB(62, 62, 71),
    0,
    0,
    "Fame_Stars_1"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(113, 83, 56),
    0,
    0,
    "Fame_Stars_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(166, 135, 97),
    0,
    0,
    nil
});
add_wrap("Legendary", "Popcorn", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(240, 240, 240),
    0,
    0,
    "Popcorn_1"
}, {
    "Popcorn",
    Color3.fromRGB(254, 233, 155),
    0,
    0,
    "Popcorn_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(254, 233, 155),
    0,
    0,
    nil
});
add_wrap("Legendary", "Popsicle", {
    "CandyGlossy",
    Color3.fromRGB(248, 138, 186),
    0,
    0,
    "Popsicle_1"
}, {
    "CandyGlossy",
    Color3.fromRGB(149, 72, 128),
    0,
    0,
    nil
}, {
    "PopsicleStick",
    Color3.fromRGB(226, 173, 136),
    0,
    0,
    nil
});
add_wrap("Legendary", "Sea Glass", {
    Enum.Material.Glass,
    Color3.fromRGB(11, 255, 206),
    0.15,
    0,
    "Sea_Glass_1"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(16, 120, 255),
    0.15,
    0,
    "Sea_Glass_2"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(87, 255, 241),
    0.25,
    0,
    "Sea_Glass_3"
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Heatwave", {
    Enum.Material.Neon,
    Color3.fromRGB(165, 106, 54),
    0,
    0,
    "Heatwave_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(150, 85, 55),
    0,
    0,
    "Heatwave_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(173, 111, 75),
    0,
    0,
    "Heatwave_3"
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Synthwave", {
    Enum.Material.Neon,
    Color3.fromRGB(43, 0, 76),
    0,
    0,
    "Vaporwave_Sunset_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(22, 0, 76),
    0,
    0,
    "Vaporwave_Sunset_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(68, 28, 125),
    0,
    0,
    "Vaporwave_Sunset_3"
}, nil, "Used to be purchased from the Shop");
add_wrap("Legendary", "Pearlescent", {
    "Pearlescent_01a",
    Color3.fromRGB(255, 233, 247),
    0,
    0,
    nil,
    "Pearlescent"
}, {
    "Pearlescent_01b",
    Color3.fromRGB(255, 215, 241),
    0,
    0,
    "Pearlescent_2",
    "Pearlescent"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(163, 142, 156),
    0,
    0,
    nil,
    "Pearlescent"
}, nil, "Included in Pearl Bundles");
add_wrap("Legendary", "Fish Scales", {
    "FishScales",
    Color3.fromRGB(50, 92, 99),
    0,
    0,
    nil,
    "Fish Scales"
}, {
    "FishScales",
    Color3.fromRGB(34, 56, 58),
    0,
    0,
    nil,
    "Fish Scales"
}, {
    nil,
    Color3.fromRGB(68, 147, 156),
    0,
    0,
    nil,
    "Fish Scales"
});
add_wrap("Legendary", "Overseer", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Overseer_1"
}, {
    "OverseerCrystal",
    Color3.fromRGB(0, 255, 89),
    0,
    0,
    "Overseer_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(85, 167, 112),
    0,
    0,
    nil
}, nil, "Purchased from the Shop");
add_wrap(
    "Legendary",
    "Splattered",
    { nil, nil, 0, 0, "Splattered_1" },
    { nil, nil, 0, 0, "Splattered_2" },
    { nil, nil, 0, 0, nil },
    nil,
    "Purchased from the Shop"
);
add_wrap("Mythical", "Dark Matter", {
    "CandyGlossy",
    Color3.fromRGB(129, 107, 255),
    0,
    0,
    "DarkMatter1",
    "Dark Matter"
}, {
    "CandyGlossy",
    Color3.fromRGB(129, 107, 255),
    0,
    0,
    "DarkMatter2",
    "Dark Matter"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(142, 98, 238),
    0,
    0,
    "DarkMatter3",
    "Dark Matter"
}, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon");
add_wrap("Mythical", "Neon Lights", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(42, 46, 49),
    0,
    0,
    "NeonLights1",
    "Neon Lights"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(21, 0, 65),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(125, 111, 165),
    0,
    0,
    nil
});
add_wrap("Mythical", "Solar", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(98, 15, 0),
    0,
    0,
    "Solar1",
    "Solar"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(120, 52, 21),
    0,
    0,
    "Solar2",
    "Solar"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(168, 116, 78),
    0,
    0,
    nil
});
add_wrap("Mythical", "Speed", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Speed2",
    "Speed"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(161, 105, 73),
    0,
    0,
    nil
});
add_wrap("Mythical", "Celestial", {
    Enum.Material.Glass,
    Color3.fromRGB(0, 32, 96),
    0.25,
    0,
    "Celestial",
    "Celestial"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(110, 116, 141),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(77, 114, 173),
    0,
    0,
    nil
}, nil, "Earned by completing your Daily Tasks with a 7 day Task Streak");
add_wrap("Mythical", "Encroached", {
    Enum.Material.Neon,
    Color3.fromRGB(96, 92, 209),
    0,
    0,
    "Encroached1",
    "Encroached"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(91, 93, 163),
    0,
    0,
    "Encroached2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(106, 101, 231),
    0,
    0,
    nil
});
add_wrap("Mythical", "Fracture", {
    Enum.Material.Neon,
    Color3.fromRGB(105, 226, 161),
    0,
    0,
    "Fracture1",
    "Fracture"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Fracture2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(114, 255, 180),
    0.5,
    0,
    nil
});
add_wrap("Mythical", "Aegis", {
    "Aegis",
    Color3.fromRGB(134, 207, 255),
    0,
    0,
    "Aegis1",
    "Aegis"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(239, 184, 56),
    0,
    0,
    "Aegis2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 160, 116),
    0,
    0,
    nil
});
add_wrap("Mythical", "Soul Scourge", {
    Enum.Material.Neon,
    Color3.fromRGB(93, 179, 255),
    0,
    0,
    "SoulScourge1",
    "Soul Scourge"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(18, 42, 48),
    0,
    0,
    "SoulScourge2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(84, 241, 255),
    0.5,
    0.5,
    nil
});
add_wrap("Mythical", "Blizzard", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(210, 234, 255),
    0,
    0.1,
    "Blizzard_1",
    "Blizzard"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(179, 199, 221),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(140, 153, 162),
    0,
    0,
    nil
});
add_wrap("Mythical", "Festive Lights", {
    Enum.Material.Glass,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Festive_Lights_1",
    "Festive Lights"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Festive_Lights_2",
    "Festive Lights"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(54, 54, 54),
    0.1,
    0,
    nil
});
add_wrap("Mythical", "Ice Queen", {
    Enum.Material.Neon,
    Color3.fromRGB(102, 142, 162),
    0,
    0,
    "Ice_Queen_1",
    "Ice Queen"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(102, 190, 203),
    0,
    -3,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(123, 174, 207),
    0.2,
    0,
    nil
});
add_wrap("Mythical", "Borealis", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 255),
    0,
    0,
    "Borealis_1",
    "Borealis"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(17, 17, 17),
    0,
    0.05,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(75, 181, 105),
    0,
    0,
    nil
});
add_wrap("Mythical", "Polaris", {
    Enum.Material.Neon,
    Color3.fromRGB(55, 108, 168),
    0,
    0,
    "Polaris_1",
    "Polaris"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(17, 21, 52),
    0,
    0,
    "Polaris_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(113, 101, 209),
    0.2,
    0,
    "Polaris_3"
}, nil, "Included in the 2025 Festive Flash Sale");
add_wrap("Mythical", "Heartfelt", {
    Enum.Material.Neon,
    Color3.fromRGB(167, 90, 149),
    0,
    0,
    "Heartfelt1",
    "Heartfelt"
}, {
    "Heartfelt1",
    Color3.fromRGB(121, 25, 75),
    0,
    0,
    "Heartfelt2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(216, 97, 145),
    0,
    0,
    nil
});
add_wrap("Mythical", "The Heights", {
    "WrappingPearlescent",
    Color3.fromRGB(106, 57, 9),
    0,
    0,
    "SFOTH_1",
    "The Heights"
}, {
    "WrappingPearlescent",
    Color3.fromRGB(196, 40, 28),
    0,
    0,
    "SFOTH_2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(172, 134, 72),
    0,
    0,
    "SFOTH_3"
});
add_wrap("Mythical", "Orichalcum", {
    "WeirdPaint",
    Color3.fromRGB(255, 154, 53),
    0,
    0,
    "Orichalcum_1",
    "Orichalcum"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(216, 150, 44),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(168, 128, 73),
    0,
    0,
    nil
});
add_wrap("Mythical", "Crime Scene", {
    "CrimeScene1",
    Color3.fromRGB(53, 56, 62),
    0,
    0,
    "Crime_Scene_1",
    "Crime Scene"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(106, 114, 127),
    0,
    0,
    "Crime_Scene_2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(232, 232, 232),
    0,
    0,
    nil,
    "Crime Scene"
});
add_wrap("Mythical", "TV Error", {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "TV_Error_1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "TV_Error_2",
    "TV Error"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
});
add_wrap("Mythical", "Paparazzi", {
    "CarpetNoise",
    Color3.fromRGB(7, 9, 30),
    0,
    0,
    "Paparazzi_1",
    "Paparazzi"
}, {
    Enum.Material.Metal,
    Color3.fromRGB(24, 24, 59),
    0,
    0,
    "Paparazzi_2",
    "Paparazzi"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(155, 158, 168),
    0,
    0,
    nil,
    "Paparazzi"
});
add_wrap("Mythical", "Tidal", {
    "RobloxSand",
    Color3.fromRGB(188, 160, 103),
    0,
    0,
    "Tidal_1",
    "Tidal"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(69, 137, 161),
    0,
    0.1,
    "Tidal_2",
    "Tidal"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(109, 150, 168),
    0,
    0,
    nil
});
add_wrap("Mythical", "Dutchman", {
    Enum.Material.Neon,
    Color3.fromRGB(89, 171, 123),
    0.9,
    0,
    "Dutchman_1",
    "Dutchman"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(22, 53, 36),
    0,
    0,
    "Dutchman_2",
    "Dutchman"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(89, 171, 123),
    0.15,
    0,
    "Dutchman_3",
    "Dutchman"
});
add_wrap("Genuine", "Rivalry", {
    "RivalryMaterial",
    Color3.fromRGB(126, 52, 255),
    0,
    0,
    "Rivalry2",
    "Rivalry"
}, {
    "RivalryMaterial",
    Color3.fromRGB(126, 52, 255),
    0,
    0,
    "Rivalry2",
    "Rivalry"
}, {
    "RivalryMaterial",
    Color3.fromRGB(126, 52, 255),
    0,
    0,
    "Rivalry2",
    "Rivalry"
}, true, "Given to team members of the group (Nosniy Games)");
add_wrap("Genuine", "Scribble", {
    "ScribbleWrapping",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Scribble1",
    "Scribble"
}, {
    "ScribbleWrapping",
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Scribble2",
    "Scribble"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, true, "Obtained by submitting a concept that makes it into the game (RIVALS)");
add_wrap("Genuine", "Net", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0.75,
    0,
    "Net1",
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(165, 114, 55),
    0,
    0,
    "Net2"
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 255, 255),
    0.75,
    0,
    "Net3"
}, true, "Given to bug hunters, thank you for helping us improve the game (RIVALS)");
add_wrap("Genuine", "Egg Fried Rice", {
    "EggFriedRice",
    Color3.fromRGB(216, 157, 91),
    0,
    0,
    "Egg_Fried_Rice_1"
}, {
    "EggFriedRice",
    Color3.fromRGB(165, 110, 63),
    0,
    0,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(185, 133, 78),
    0,
    0,
    nil
}, true, "are u telling me an egg fried this wrap");
add_wrap("Genuine", "Only Six", {
    "K_Material",
    Color3.fromRGB(221, 199, 255),
    0.2,
    1,
    "K_Textures",
    "Only Six"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(42, 42, 42),
    0.5,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(159, 161, 172),
    0,
    0,
    nil
}, true, "Given to the winners of the tournament in the Ready, Set, Roblox Korea Event");
add_wrap("Unobtainable", "MISSING_WRAP", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 0, 255),
    0,
    0,
    "MISSING_WRAP",
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, nil, true, "-- TODO: placeholder");
add_wrap("Unobtainable", "Accretion", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(149, 167, 248),
    0,
    0.4,
    nil,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Accretion2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Accretion3"
}, true, "im like hey whats up hello");
add_wrap("Unobtainable", "Eruption", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 112, 69),
    0,
    0,
    "Eruption1",
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(218, 96, 9),
    0,
    0,
    "Eruption2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(168, 92, 69),
    0,
    0,
    nil
}, true, "RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
add_wrap("Unobtainable", "Ultrablue", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 213, 0),
    0,
    10,
    nil,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(255, 213, 0),
    0,
    10,
    nil
}, {
    Enum.Material.Glass,
    Color3.fromRGB(255, 255, 255),
    0.5,
    0,
    nil
}, true, "idk");
add_wrap("Unobtainable", "Arcane", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Arcane1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(95, 102, 176),
    0,
    0,
    nil
}, true, "i was forced to add this by a chicken");
add_wrap("Unobtainable", "Invisible", {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    1,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    1,
    0,
    nil
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    1,
    0,
    nil
}, true, "i was forced to add this by a chicken");
add_wrap("Unobtainable", "Limefire", {
    "LimefireMat",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Limefire1"
}, {
    "LimefireMat",
    Color3.fromRGB(248, 248, 248),
    0,
    0,
    "Limefire2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(97, 174, 81),
    0,
    0,
    nil
}, true, "i was forced to add this by a chicken");
add_wrap("Unobtainable", "Peridot", {
    "PeridotMat",
    Color3.fromRGB(40, 127, 71),
    0,
    0,
    "Peridot1"
}, {
    "PeridotMat",
    Color3.fromRGB(40, 127, 71),
    0,
    0,
    "Peridot2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(114, 171, 90),
    0,
    0,
    nil
}, true, "i was forced to add this by a chicken");
add_wrap("Unobtainable", "Pixel Light", {
    Enum.Material.Neon,
    Color3.fromRGB(255, 152, 220),
    0,
    1,
    "PixelLight1"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 152, 220),
    0,
    1,
    "PixelLight2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(217, 129, 188),
    0,
    0,
    nil
}, true, "i was forced to add this by a chicken");
add_wrap("Unobtainable", "Ultra Zed", {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(206, 255, 255),
    0,
    10,
    nil
}, {
    Enum.Material.SmoothPlastic,
    Color3.fromRGB(206, 255, 255),
    0,
    10,
    "UltraZed2"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(206, 255, 255),
    0,
    10,
    nil
}, true, "i was forced to add this by a chicken");
add_wrap("Unobtainable", "Virus", {
    "VirusMat",
    Color3.fromRGB(204, 142, 105),
    0,
    0,
    "Virus1"
}, {
    Enum.Material.ForceField,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "Virus2"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(130, 179, 117),
    0,
    0,
    nil
}, true, "i was forced to add this by a chicken");
add_wrap("Unobtainable", "Chromatic", {
    Enum.Material.Metal,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    "Chromatic_1",
    "Chromatic"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(255, 255, 255),
    0,
    0,
    "Chromatic_2",
    "Chromatic"
}, {
    Enum.Material.Glass,
    Color3.fromRGB(248, 248, 248),
    0.25,
    0,
    nil,
    "Chromatic"
}, true, "idk");
add_wrap("Unobtainable", "TV Static", {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "TV_Static_1",
    "TV Static"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(17, 17, 17),
    0,
    0,
    "TV_Static_2",
    "TV Static"
}, {
    Enum.Material.Neon,
    Color3.fromRGB(0, 0, 0),
    0,
    0,
    nil
}, true, "tv error v2");

local function add_charm(p102, p103, p104, p105, p106) -- Line: 1116
    -- upvalues: add_cosmetic (copy)
    add_cosmetic("Charm", p102, p103, nil, nil, p104, p105, p106, {});
end;

add_cosmetic(
    "Charm",
    "Unique",
    "Day 1",
    nil,
    nil,
    nil,
    "Earned by redeeming a code when the game (RIVALS) released",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "100M Visits",
    nil,
    nil,
    nil,
    "Earned by redeeming a code when the game (RIVALS) reached 100,000,000 visits",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "Streamer Microphone",
    nil,
    nil,
    nil,
    "Earned by redeeming a special code",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "Frozen Gaming Chair",
    nil,
    nil,
    nil,
    "Earned by redeeming a special code",
    nil,
    {}
);
add_cosmetic("Charm", "Unique", "Gaming Headset", nil, nil, nil, "Earned by redeeming a special code", nil, {});
add_cosmetic("Charm", "Unique", "Nosniy Games", nil, nil, nil, "Join the group (Nosniy Games)", nil, {});
add_cosmetic("Charm", "Unique", "Shooting Star", nil, nil, nil, "Favorite the game (RIVALS)", nil, {});
add_cosmetic("Charm", "Unique", "RIVALS", nil, nil, nil, "Like the game (RIVALS)", nil, {});
add_cosmetic("Charm", "Unique", "Bell", nil, nil, nil, "Enable notifications for the game (RIVALS)", nil, {});
add_cosmetic("Charm", "Unique", "Mini Present", nil, nil, nil, "Earned during the 2024 Festive Event", nil, {});
add_cosmetic(
    "Charm",
    "Unique",
    "3D Glasses",
    nil,
    nil,
    nil,
    "Earned by watching a quick video ad in the Shop",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "Bungeoppang",
    nil,
    nil,
    nil,
    "Earned by completing a special challenge during the release of the Bridge map",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "Hunt Token",
    nil,
    nil,
    nil,
    "Earned by completing the Roblox 2025 The Hunt: Mega Edition",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "Mega Token",
    nil,
    nil,
    nil,
    "Earned by finding the Mega Token in the Roblox 2025 The Hunt: Mega Edition",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "I Survived Season 0",
    nil,
    nil,
    nil,
    "Given to players affected by the 3,400+ ELO reset during Ranked Season 0",
    nil,
    {}
);
add_cosmetic("Charm", "Unique", "Season 0", nil, nil, nil, "Earned by playing Ranked Season 0", nil, {});
add_cosmetic("Charm", "Unique", "Season 1", nil, nil, nil, "Earned by playing Ranked Season 1", nil, {});
add_cosmetic("Charm", "Unique", "Season 2", nil, nil, nil, "Earned by playing Ranked Season 2", nil, {});
add_cosmetic("Charm", "Unique", "Season 3", nil, nil, nil, "Earned by playing Ranked Season 3", nil, {});
add_cosmetic(
    "Charm",
    "Unique",
    "RIA25 Best Shooter",
    nil,
    nil,
    nil,
    "Earned by redeeming a code when the game (RIVALS) won the RIA25 Best Shooter award",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "RIA26 Best Shooter",
    nil,
    nil,
    nil,
    "Earned by redeeming a code when the game (RIVALS) won the RIA26 Best Shooter award",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "Fireplace",
    nil,
    nil,
    nil,
    "Earned from the 2025 Festive Event Advent Calendar",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "The Head of Sensei Bot",
    nil,
    nil,
    nil,
    "Earned by defeating the Sensei Bot simulation",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Unique",
    "The Head of Nosniy Bot",
    nil,
    nil,
    nil,
    "Earned by defeating the Nosniy Bot simulation",
    nil,
    {}
);
add_cosmetic("Charm", "Unique", "Nosniy", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "SenseiWarrior", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "nekoanims", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Blizmid", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Bandites", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "CarbonMeister", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "DV", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "oPixel", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "TanqR", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "BobbVX", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "MiniBloxia", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "enriquebruv", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Chex", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "hoppy819", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Hoopie", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Kaye", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Karful", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Brian1KB", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "GreatGuyBoom", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "ShadowTrojan", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Khayri", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "8sty", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Applino", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "viecti", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "SharkTactics", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "D_reamz", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "atorix", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "philhood", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Mud", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "KaiM", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Darktru", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Milo", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "elixir", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Kashy", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "WE1RD", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Cruz", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Stefan", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "Mixedify", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "SlingshotBwai", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Unique", "TinyDude", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Hook", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Cookie", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Cupcake", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Ninja Star", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Lemon Slice", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Ship Wheel", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Star", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Heart", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Bowling Pin", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Life Buoy", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Cage", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Magnet", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Potted Cactus", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Potted Flower", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Fedora Stack", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Pawn", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Hammer", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Cog", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Dice", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Traffic Cone", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Bone", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Candy", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Candy Corn", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Cobweb", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Crystal", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Mini Candy Cane", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Ornament", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Mini Shining Star", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Snowflake", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Glory Coin", nil, nil, nil, "Purchased from the Ranked Shop", nil, {});
add_cosmetic("Charm", "Common", "Runes", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Rune Ring", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Armchair", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Table Lamp", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Spider", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Thorn Circle", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Witch Hat", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Chombie Head", nil, nil, nil, "Earned by escaping the Zombie Tower", nil, {});
add_cosmetic("Charm", "Common", "Snowflake Ring", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Firework", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Ice Cube", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Jolly Hat", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Elf Hat", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Peppermint Candy", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Snowman", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Happy Gingerbread", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Horseshoe", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Paparazzi Camera", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Ancient Stool", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Mini Beach Ball", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Flip Flop", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Snorkel Goggles", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Coconut", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Mini Starfish", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Common", "Watermelon Slice", nil, nil, nil, nil, nil, {});
add_cosmetic(
    "Charm",
    "Common",
    "1st Birthday Cake",
    nil,
    nil,
    nil,
    "Earned from the 1st RIVALS Birthday Party",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Common",
    "2nd Birthday Cake",
    nil,
    nil,
    nil,
    "Earned from the 2nd RIVALS Birthday Party",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Common",
    "Season 3 Stomp",
    nil,
    nil,
    nil,
    "Earned from winning an unfairly easy Ranked matchup that results in +0 ELO",
    nil,
    {}
);
add_cosmetic("Charm", "Rare", "Blobfish", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Pufferfish", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Bitster", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Mystery Block", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Anvil", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Basketball", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Money Bag", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Rubber Duck", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "10 Gallon Hat", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "UFO", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Emoji: Weary", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Chocolate Scoop", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Rocket Ship", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Hotdog", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Moai", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Golf Ball", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Football", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Tennis Ball", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Rainbow", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Potion", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Caramel Apple", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Devious Pumpkin", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Gravestone", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Festive Light", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Hot Chocolate", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Stocking", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Mini Portal", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Mini Unstable Portal", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Melonkin", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Candy Bucket", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Jolly Chair", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Snowflakes", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Decorated Tree", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Cactus Buddy", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Fame Star", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Money Duffle", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Surfboard", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Lemon Juice", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Mini Flamingo Floatie", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Sand Bucket", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Rocket Popsicle", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Rare", "Hidden Pearl", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Mini Ban Hammer", nil, nil, nil, "Included in the Classic Bundle", nil, {});
add_cosmetic(
    "Charm",
    "Legendary",
    "Mini Disco Ball",
    nil,
    nil,
    nil,
    "Included in the Standard Weapons Bundle",
    nil,
    {}
);
add_cosmetic("Charm", "Legendary", "Alien Head", nil, nil, nil, "Included in the Exogun Bundle", nil, {});
add_cosmetic("Charm", "Legendary", "First Aid", nil, nil, nil, "Included in the Medkit Bundle", nil, {});
add_cosmetic("Charm", "Legendary", "Mini Key", nil, nil, nil, "Included in Key Bundles", nil, {});
add_cosmetic("Charm", "Legendary", "Emoji: Nauseated", nil, nil, nil, "Included in the Starter Bundle", nil, {});
add_cosmetic("Charm", "Legendary", "Explosion", nil, nil, nil, "Included in the Heavy Duty Bundle", nil, {});
add_cosmetic("Charm", "Legendary", "EZ", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Energy Cell", nil, nil, nil, "Included in the Energy Bundle", nil, {});
add_cosmetic("Charm", "Legendary", "Emoji: Nerd", nil, nil, nil, "Included in the RPG Bundle", nil, {});
add_cosmetic("Charm", "Legendary", "Skull", nil, nil, nil, "Used to be purchased from the Shop", nil, {});
add_cosmetic("Charm", "Legendary", "Cauldron", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Eyeclipse", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Frankenblob", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Skullgourd", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Dumbkin", nil, nil, nil, "Included in Candy Bundles", nil, {});
add_cosmetic("Charm", "Legendary", "Chillman", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Gingerbread Cat", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Wreath", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Jingle Bell", nil, nil, nil, "Used to be purchased from the Shop", nil, {});
add_cosmetic("Charm", "Legendary", "Mini Snowglobe", nil, nil, nil, "Included in Crystal Bundles", nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Bow", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Burst Rifle", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Chainsaw", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Daggers", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Energy Pistols", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Exogun", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Fists", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Flamethrower", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Grenade", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Grenade Launcher", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Handgun", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Flare Gun", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Jump Pad", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Katana", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Knife", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Medkit", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Minigun", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Molotov", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Paintball Gun", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi RPG", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Revolver", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Satchel", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Assault Rifle", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Scythe", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Shorty", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Shotgun", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Slingshot", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Smoke Grenade", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Subspace Tripmine", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Sniper", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Spray", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Trowel", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Uzi", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi War Horn", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Battle Axe", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Crossbow", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Riot Shield", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Freeze Ray", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Energy Rifle", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Gunblade", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Flashbang", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Distortion", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Warper", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Warpstone", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Maul", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Permafrost", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Grappler", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Spear", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Chibi Wildcat", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Arena", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Crossroads", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Backrooms", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Battleground", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Big Arena", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Big Backrooms", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Big Crossroads", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Big Graveyard", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Big Onyx", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Big Splash", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Bridge", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Construction", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Docks", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Graveyard", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Onyx", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Playground", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Shooting Range", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Splash", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Station", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Dimension", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Village", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Iceberg", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Chess", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Big Station", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Westown", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Museum", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Studio", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Diorama Sandbox", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Emoji: Imp", nil, nil, nil, "Purchased from the Ranked Shop", nil, {});
add_cosmetic("Charm", "Legendary", "Keycard 3", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Warp Disc", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Ghost", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Black Cat", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Pumpkin Cat", nil, nil, nil, "Used to be purchased from the Shop", nil, {});
add_cosmetic("Charm", "Legendary", "Snowblob", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Gingerbread Man", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Yeti", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Cryo Capsule", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Penguin", nil, nil, nil, "Used to be purchased from the Shop", nil, {});
add_cosmetic(
    "Charm",
    "Legendary",
    "Crystal Heart",
    nil,
    nil,
    nil,
    "Included in the 2025 Festive Flash Sale",
    nil,
    {}
);
add_cosmetic("Charm", "Legendary", "Balloon Dog", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Happy Home", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Pierced Heart", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Four-Leaf Clover", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Sneaker", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Box TV", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Duely Award", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Police Siren", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Shredding Artwork", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Soda Can", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Emoji: Hot", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Jellyfish", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Summer Cooler", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Sand Castle", nil, nil, nil, nil, nil, {});
add_cosmetic("Charm", "Legendary", "Shark", nil, nil, nil, "Used to be purchased from the Shop", nil, {});
add_cosmetic("Charm", "Legendary", "Shiny Pearl", nil, nil, nil, "Included in the Pearl Bundles", nil, {});
add_cosmetic(
    "Charm",
    "Legendary",
    "Long Lost Treasure",
    nil,
    nil,
    nil,
    "Included in the Pirate Bundle",
    nil,
    {}
);
add_cosmetic(
    "Charm",
    "Genuine",
    "Team Crown",
    nil,
    nil,
    true,
    "Given to the winners of the tournament in the Ready, Set, Roblox Korea Event",
    nil,
    {}
);
add_cosmetic("Charm", "Genuine", "Alpha Coin", nil, nil, true, "Thanks for helping us test :3", nil, {});
add_cosmetic("Charm", "Genuine", "Coinbama", nil, nil, true, "Friends & Family", nil, {});
add_cosmetic(
    "Charm",
    "Genuine",
    "Participation Trophy",
    nil,
    nil,
    true,
    "Given to participants of tournaments that are officially hosted, sponsored, endorsed, or recognized by the group (Nosniy Games)",
    nil,
    {}
);
add_cosmetic("Charm", "Unobtainable", "MISSING_CHARM", nil, nil, true, "-- TODO: placeholder", nil, {});

local function add_finisher(p107, p108, p109, p110, p111, p112) -- Line: 1427
    -- upvalues: add_cosmetic (copy)
    add_cosmetic("Finisher", p107, p108, p109, nil, p110, p111, p112, {});
end;

add_cosmetic(
    "Finisher",
    "Unique",
    "Jolly Judgement",
    "rbxassetid://90321419599834",
    nil,
    nil,
    "Earned from the 2024 Festive Event Advent Calendar",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unique",
    "5B Visits",
    "rbxassetid://114699226490363",
    nil,
    nil,
    "Earned by redeeming a code when the game (RIVALS) reached 5,000,000,000 visits",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unique",
    "Director\'s Cut",
    "rbxassetid://103223520666152",
    nil,
    nil,
    "Earned by watching a quick video ad in the Shop",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unique",
    "Elfify",
    "rbxassetid://78997438310487",
    nil,
    nil,
    "Earned from the 2025 Festive Event Advent Calendar",
    nil,
    {}
);
add_cosmetic("Finisher", "Common", "Yoink", "rbxassetid://102829647142590", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Confetti", "rbxassetid://104741243211980", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Hacked", "rbxassetid://82426114825564", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Petrify", "rbxassetid://112332768984387", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Flop", "rbxassetid://96328091359909", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Toot", "rbxassetid://140560743648551", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Spooky Confetti", "rbxassetid://86811497624542", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Batsplosion", "rbxassetid://122057521256858", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Bite", "rbxassetid://82133383488216", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Festive Confetti", "rbxassetid://70544145329602", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Wrapped", "rbxassetid://72445331312364", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Delete", "rbxassetid://115854076287500", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Squawk", "rbxassetid://74088341062653", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Digitize", "rbxassetid://108813637747773", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Chalked", "rbxassetid://97485080586138", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Folded", "rbxassetid://77198370089806", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Common",
    "Very Tragic Banana Peel Accident",
    "rbxassetid://83991814770184",
    nil,
    nil,
    nil,
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Common",
    "For Glory",
    "rbxassetid://118264756096342",
    nil,
    nil,
    "Purchased from the Ranked Shop",
    nil,
    {}
);
add_cosmetic("Finisher", "Common", "Warped Away", "rbxassetid://77918264482510", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Blip", "rbxassetid://94841086478106", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Faceplant", "rbxassetid://88948574020907", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Common",
    "Northern Light Show",
    "rbxassetid://131193643081878",
    nil,
    nil,
    nil,
    nil,
    {}
);
add_cosmetic("Finisher", "Common", "Coalify", "rbxassetid://137288972288796", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Chill Out", "rbxassetid://128662396670227", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Paparazzi Flash", "rbxassetid://115459985337202", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Spotlight", "rbxassetid://115915796108003", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Sun Rays", "rbxassetid://83566863919981", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Water Balloons", "rbxassetid://125829428252147", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Common", "Sizzled", "rbxassetid://107854089679944", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Common",
    "Caked",
    "rbxassetid://131313620853228",
    nil,
    nil,
    "Earned from the 2nd RIVALS Birthday Party",
    nil,
    {}
);
add_cosmetic("Finisher", "Rare", "Freeze", "rbxassetid://98529191510110", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "High Gravity", "rbxassetid://96732292347041", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Collapse", "rbxassetid://73392477829194", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Splatter", "rbxassetid://102973927915607", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Tremble", "rbxassetid://95468028863260", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Rush", "rbxassetid://126499829143959", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Rare",
    "Midas Touch",
    "rbxassetid://114357416172786",
    nil,
    nil,
    "Earned from weapon contracts",
    "Earned from a weapon contract for this weapon",
    {}
);
add_cosmetic("Finisher", "Rare", "Bonesplosion", "rbxassetid://130788066745511", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Lost Soul", "rbxassetid://118248684115036", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Reaper", "rbxassetid://127213865323328", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Frozen", "rbxassetid://134114034173010", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Gingerbreadify", "rbxassetid://139642060967648", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Flick", "rbxassetid://91644072854680", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Heavy Head", "rbxassetid://78860800597917", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Bad Mood", "rbxassetid://99622848264737", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Ascend", "rbxassetid://108671357927051", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Roadrunner", "rbxassetid://123109101762106", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Hooked", "rbxassetid://135161057713623", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Bogey", "rbxassetid://78461567525312", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Warp Sickness", "rbxassetid://95052578441962", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Decorated Player", "rbxassetid://105447700906346", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Snowmanify", "rbxassetid://86007852568653", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Grapple Hooked", "rbxassetid://130558454147591", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Curtain Call", "rbxassetid://98383652505998", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Tumbleweed", "rbxassetid://107589458207197", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Impact Frame", "rbxassetid://140448744575617", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Rising Star", "rbxassetid://106582358983229", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Swept Away", "rbxassetid://127179356644083", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Kiddie Pool", "rbxassetid://118146142186862", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Rare", "Beach Day", "rbxassetid://135822676403654", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "OOF",
    "rbxassetid://126776522933695",
    nil,
    nil,
    "Included in the Classic Bundle",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Ignite",
    "rbxassetid://134442726960420",
    nil,
    nil,
    "Included in the Heavy Duty Bundle",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Boogie",
    "rbxassetid://73791204303375",
    nil,
    nil,
    "Included in the Standard Weapons Bundle",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Low Gravity",
    "rbxassetid://82935062788662",
    nil,
    nil,
    "Included in the Exogun Bundle",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Stiff",
    "rbxassetid://115882469899440",
    nil,
    nil,
    "Included in the Starter Bundle",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Heartbeat",
    "rbxassetid://87519063117594",
    nil,
    nil,
    "Included in the Medkit Bundle",
    nil,
    {}
);
add_cosmetic("Finisher", "Legendary", "Pixel Coins", "rbxassetid://92644850029616", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "Beacon",
    "rbxassetid://98809320060817",
    nil,
    nil,
    "Included in the Energy Bundle",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Erased",
    "rbxassetid://88556189232995",
    nil,
    nil,
    "Included in the RPG Bundle",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Opulent",
    "rbxassetid://101696122903986",
    nil,
    nil,
    "Included in Key Bundles",
    nil,
    {}
);
add_cosmetic("Finisher", "Legendary", "Orbital Strike", "rbxassetid://109881673283194", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Tough Crowd", "rbxassetid://114669648248372", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "BONK!", "rbxassetid://99051381910214", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Darkheart", "rbxassetid://108380782682249", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Balloons", "rbxassetid://136702616652550", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Electrocute", "rbxassetid://73752311595809", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "Diamond Hands",
    "rbxassetid://82379000922589",
    nil,
    nil,
    "Earned from weapon contracts",
    "Earned from a weapon contract for this weapon",
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "RIP",
    "rbxassetid://125413876114976",
    nil,
    nil,
    "Used to be purchased from the Shop",
    nil,
    {}
);
add_cosmetic("Finisher", "Legendary", "Disintegrate", "rbxassetid://122124911858258", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Broom Ride", "rbxassetid://94004294239279", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Zombified", "rbxassetid://118642793984362", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "DRIP",
    "rbxassetid://72617401862034",
    nil,
    nil,
    "Included in Candy Bundles",
    nil,
    {}
);
add_cosmetic("Finisher", "Legendary", "Snowballed", "rbxassetid://134500016062172", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "David", "rbxassetid://118078924229498", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "Giant Ice Spike",
    "rbxassetid://83215636937328",
    nil,
    nil,
    "Included in Crystal Bundles",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Falling Icicles",
    "rbxassetid://110649955330233",
    nil,
    nil,
    "Used to be purchased from the Shop",
    nil,
    {}
);
add_cosmetic("Finisher", "Legendary", "Chark Attack", "rbxassetid://129157579936707", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "GOOAAALLLL", "rbxassetid://84624379263977", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Crushed", "rbxassetid://106966455049956", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Clapped", "rbxassetid://123917282718123", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Enlightened", "rbxassetid://127327248433603", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Rainbow Barf", "rbxassetid://132045014783492", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "Impaled",
    "rbxassetid://138149693939922",
    nil,
    nil,
    "Purchased from the Ranked Shop",
    nil,
    {}
);
add_cosmetic("Finisher", "Legendary", "Spaghettified", "rbxassetid://77679769061256", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Instability", "rbxassetid://106971261547575", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "Those Who Know",
    "rbxassetid://87255165853264",
    nil,
    nil,
    "Used to be purchased from the Shop",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Sleigh Away",
    "rbxassetid://77610232388349",
    nil,
    nil,
    "Used to be purchased from the Shop",
    nil,
    {}
);
add_cosmetic("Finisher", "Legendary", "Giant Snowball", "rbxassetid://133610440023169", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Firework Show", "rbxassetid://109941967577830", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Inflate", "rbxassetid://97761422504755", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Dematerialize", "rbxassetid://74226415965130", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Poof", "rbxassetid://113497644121357", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Leprechaunify", "rbxassetid://96845292635339", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Plushify", "rbxassetid://135472987617182", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "BANG!", "rbxassetid://118036788686497", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Goofy Brawl", "rbxassetid://102633358539415", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Standing Ovation", "rbxassetid://72165736224034", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Whack A Mole", "rbxassetid://102591155581733", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Spectralized", "rbxassetid://120984959862618", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Loose Coconut", "rbxassetid://102463478300973", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Mow Them Down", "rbxassetid://99423466020720", nil, nil, nil, nil, {});
add_cosmetic("Finisher", "Legendary", "Bubble Ball", "rbxassetid://136356314854589", nil, nil, nil, nil, {});
add_cosmetic(
    "Finisher",
    "Legendary",
    "Whirlpool",
    "rbxassetid://115769602518941",
    nil,
    nil,
    "Used to be purchased from the Shop",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Legendary",
    "Clammed",
    "rbxassetid://125453394404112",
    nil,
    nil,
    "Included in Pearl Bundles",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unobtainable",
    "Ragdoll",
    "rbxassetid://131997354939473",
    nil,
    true,
    "Used internally when no finisher is equipped",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unobtainable",
    "Fall Apart",
    "rbxassetid://131997354939473",
    nil,
    true,
    "Used internally for skeleton deaths",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unobtainable",
    "Every Finisher Ever",
    "rbxassetid://131997354939473",
    nil,
    true,
    "play super golf",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unobtainable",
    "Bubblegum",
    "rbxassetid://95870163076585",
    nil,
    true,
    "data mining detected, you will be banned shortly",
    nil,
    {}
);
add_cosmetic(
    "Finisher",
    "Unobtainable",
    "MISSING_FINISHER",
    "rbxassetid://112664260315062",
    nil,
    true,
    "-- TODO: placeholder",
    nil,
    {}
);

local function add_emote(p113, p114, p115, p116, p117, p118, p119, p120, p121) -- Line: 1563
    -- upvalues: add_cosmetic (copy)
    add_cosmetic("Emote", p113, p114, nil, nil, p118, p121, nil, {
        IsAudioIntrusive = p115,
        IsTraversal = p116 ~= nil,
        TraversalWalkSpeedMultiplier = p116,
        HideFootsteps = p117,
        EmoteDescription = p120,
        ViewportCFrameOffset = p119 or CFrame.identity
    });
end;

add_emote(
    "Unique",
    "RIA26 Best Studio",
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    "Earned by redeeming a code when the group (Nosniy Games) won the RIA26 Best Studio award"
);
add_emote("Common", "Shoulder Brush", nil, nil, nil, nil, nil, "No big deal, man");
add_emote("Common", "Coo Coo", nil, nil, nil, nil, nil, "Someone\'s tilted");
add_emote("Common", "Denial", nil, nil, nil, nil, nil, "No, no, not me!");
add_emote("Common", "Facepalm", nil, nil, nil, nil, nil, "Are you serious right now?");
add_emote("Common", "Kneel", nil, nil, nil, nil, nil, "That was an honorable try");
add_emote("Common", "Agree", nil, nil, nil, nil, nil, "Yeah! Yeah!");
add_emote("Common", "Think", nil, nil, nil, nil, nil, "Think, " .. (CONSTANTS.IS_CLIENT and Players.LocalPlayer.Name or "Server") .. "!");
add_emote("Common", "Salty", nil, nil, nil, nil, nil, "If you weren\'t salty already, now you are!");
add_emote("Common", "AAAND.. CUT!");
add_emote("Common", "Standoff", true);
add_emote("Common", "Giant Camera");
add_emote("Common", "Yummy Cake", nil, nil, nil, nil, nil, nil, "Earned from the 2nd RIVALS Birthday Party");
add_emote("Rare", "Superhero", true, nil, nil, nil, nil, "Nobody panic! I\'m here now");
add_emote(
    "Rare",
    "Cream Cheese Honey",
    true,
    nil,
    nil,
    nil,
    nil,
    "It\'s cream cheese and honey sandwich time"
);
add_emote("Rare", "Smile", true, nil, nil, nil, nil, "What a joyful and whimsical day! =)");
add_emote("Rare", "Vegetable", true, nil);
add_emote("Rare", "Criss Cross", true, nil);
add_emote("Rare", "Side To Side", true, nil);
add_emote("Rare", "Off of You", true, nil);
add_emote("Rare", "Round & Round", true, nil);
add_emote("Rare", "Warpmaker", nil, nil, nil, nil, CFrame.Angles(0, 3.141592653589793, 0));
add_emote("Rare", "Shivering");
add_emote("Rare", "Horsey");
add_emote("Rare", "Bad Feeling", true);
add_emote("Legendary", "Take The L", true, nil, nil, nil, nil, "I promise not to be toxic");
add_emote("Legendary", "Selfie", nil, nil, nil, nil, nil, "But first..");
add_emote("Legendary", "Flex", nil, nil, nil, nil, nil, nil, "Purchased from the Ranked Shop");
add_emote("Legendary", "ROFL", nil, nil);
add_emote("Legendary", "Portal Glitch", nil, nil);
add_emote("Legendary", "Witch Waltz", nil, 0.5, true, nil, nil, nil, "Used to be purchased from the Shop");
add_emote("Legendary", "Sleigh Ride", nil, 0.5, true, nil, nil, nil, "Used to be purchased from the Shop");
add_emote("Legendary", "It\'s Time");
add_emote("Legendary", "New Year Sparklers");
add_emote("Legendary", "Whimsical", true, 0.5);
add_emote("Legendary", "Illumina Storm", nil, 0.5);
add_emote("Legendary", "Tango", true);
add_emote("Legendary", "Coin Block");
add_emote("Legendary", "Step Dancing", true);
add_emote("Legendary", "Busting A Move", true, 0.25);
add_emote("Legendary", "Tiptoe", nil, 0.5);
add_emote("Legendary", "Scoot", nil, 0.5);
add_emote("Legendary", "Police Car", nil, 0.5);
add_emote("Legendary", "Hollywoodin\'", true, nil);
add_emote("Legendary", "Bad Boy", true, nil);
add_emote("Legendary", "Old Timer", true, nil);
add_emote("Legendary", "Summer Days", true, nil);
add_emote("Legendary", "X Marks The Spot", nil, nil);
add_emote("Legendary", "Surfing", nil, 0.5, true, nil, nil, nil, "Used to be purchased from the Shop");
add_emote(
    "Unobtainable",
    "MISSING_EMOTE",
    nil,
    nil,
    nil,
    true,
    nil,
    "-- TODO: placeholder",
    "-- TODO: placeholder"
);
add_emote("Unobtainable", "Snow Angels", nil, nil, nil, true, nil, nil, "Environment emote");
add_emote("Unobtainable", "Candy Dance", true, nil, nil, true);
add_emote("Unobtainable", "Runner", true, nil, nil, true);
add_emote("Unobtainable", "Stomp Stomp", true, nil, nil, true);
add_emote("Unobtainable", "Do That Thang", true, nil, nil, true);

local function add_reward(p122, p123, p124, p125, p126, p127, p128) -- Line: 1636
    -- upvalues: u39 (copy)
    local v129 = {
        Name = p123,
        Type = p122,
        Image = p126 or "",
        ImageScale = p127 or 1,
        DisplayName = p124,
        DisplayNamePlural = p125
    };

    for i, v in pairs(p128 or {}) do
        v129[i] = v;
    end;

    u39.Rewards[p123] = v129;
end;

local function add_custom_reward(p130, p131, p132, p133, p134, p135, p136, p137) -- Line: 1654
    -- upvalues: add_reward (copy)
    add_reward("Custom", p130, p131, p132, p134, nil, {
        PrioritizeNameOverQuantity = p133,
        BubbleTitle = p135,
        BubbleDescription = p136,
        NameStatus = p137
    });
end;

add_reward(
    "Custom",
    "Prime Season Pass",
    "Upgrade",
    "Upgrades",
    "rbxassetid://74965952714478",
    nil,
    {
        PrioritizeNameOverQuantity = true,
        BubbleTitle = "Prime Season Pass",
        BubbleDescription = "Upgrades your Season Pass!",
        NameStatus = nil
    }
);
add_reward(
    "Custom",
    "Season Pass XP",
    "Pass XP",
    "Pass XP",
    "rbxassetid://139822751337484",
    nil,
    {
        PrioritizeNameOverQuantity = false,
        BubbleTitle = "Pass XP",
        BubbleDescription = "Can level up your Season Pass!",
        NameStatus = nil
    }
);
add_reward(
    "Custom",
    "Season Pass Level",
    "Pass Level",
    "Pass Levels",
    "rbxassetid://140314292934986",
    nil,
    {
        PrioritizeNameOverQuantity = false,
        BubbleTitle = "Pass Levels",
        BubbleDescription = "Levels up your Season Pass!",
        NameStatus = nil
    }
);
add_reward(
    "Custom",
    "Prime Nametag",
    "Shiny Name",
    "Shiny Name",
    "rbxassetid://100303529770645",
    nil,
    {
        PrioritizeNameOverQuantity = true,
        BubbleTitle = "Shiny Name",
        BubbleDescription = "Makes your name shiny and gold!",
        NameStatus = "Prime"
    }
);
add_reward(
    "Custom",
    "Contraband Nametag",
    "Glitchy Name",
    "Glitchy Name",
    "rbxassetid://75221071226274",
    nil,
    {
        PrioritizeNameOverQuantity = true,
        BubbleTitle = "Glitchy Name",
        BubbleDescription = "Makes your name glitchy and purple!",
        NameStatus = "Contraband"
    }
);

local function add_currency_reward(p138, p139, p140) -- Line: 1671
    -- upvalues: CurrencyLibrary (copy), add_reward (copy)
    local v141 = CurrencyLibrary.Info[p139];
    local _ = {
        DataName = v141.DataName,
        BubbleDescription = p140
    };
    add_reward("Currency", p138, v141.DisplayName, v141.DisplayNamePlural, v141.Image, 1, {
        DataName = v141.DataName,
        BubbleDescription = p140
    });
end;

add_currency_reward("Key", "WeaponKeys", "Can unlock weapons!");
add_currency_reward("Unlock Token", "UnlockTokens", "Can unlock weapons!");
add_currency_reward("EventCurrency", "EventCurrency", "Only here for a limited time!");
add_currency_reward("Glory", "Glory", "Earned by playing Ranked!");
add_currency_reward("Skin Ticket", "SkinTickets", "Can purchase skin cases!");

local function add_lootbox(u142, p143, p144, p145, p146, p147, u148, p149) -- Line: 1688
    -- upvalues: add_reward (copy), u39 (copy), Utility (copy), ItemLibrary (copy)
    add_reward("Lootbox", p144, p144, p145, p147, nil, {
        GetContents = nil,
        HasWeaponCosmetics = false,
        SmartRestrictionsEnabled = not p143,
        LootboxDescription = p149 or "Contains special items!",
        SoundProfile = p146
    });
    local v150 = u39.Rewards[p144];
    table.insert(u39.LootboxOrder, p144);

    function v150.GetContents(p151) -- Line: 1705
        -- upvalues: Utility (ref), u148 (copy), u142 (copy), u39 (ref)
        local v152 = Utility:CloneTable(u148);

        if not u142 then
            -- A plain list of names: each becomes a weight-1 entry. (Decompiled as a loop over
            -- the freshly emptied table, which left every such lootbox with no contents.)
            v152 = {};

            for _, v in pairs(u148) do
                table.insert(v152, {
                    Weight = 1,
                    Reward = {
                        Quantity = 1,
                        Name = v,
                        Weapon = u39.Cosmetics[v] and u39.Cosmetics[v].ItemName or (u39.Cosmetics[v] and u39.Types[u39.Cosmetics[v].Type].IsWeaponCosmetic and "IsRandom" or (u39.Rewards[v] and u39.Rewards[v].Type == "Lootbox" and "IsRandom" or nil))
                    }
                });
            end;
        end;

        local v153 = 0;

        for _, v in pairs(v152) do
            v153 = v153 + v.Weight;

            if p151 and v.Reward.Weapon == "IsRandom" then
                v.Reward.Weapon = p151;
            end;
        end;

        return v152, v153;
    end;

    local v154 = {};

    for _, v in pairs(v150.GetContents()) do
        local Name = v.Reward.Name;

        if not u142 then
            assert(not v154[Name], Name);
            v154[Name] = true;
        end;

        local v155 = u39.Cosmetics[Name];
        local v156 = ItemLibrary.Items[Name];
        local v157 = u39.Rewards[Name];

        if v155 then
            u39.Cosmetics[Name].Description = "Unboxed from the " .. p144;
            u39.CosmeticNameToLootbox[Name] = p144;

            if u39.Types[v155.Type].IsWeaponCosmetic then
                v150.HasWeaponCosmetics = true;
            end;
        elseif not v156 then
            if v157 then
                if v157.Type == "Lootbox" and v157.HasWeaponCosmetics then
                    v150.HasWeaponCosmetics = true;
                end;
            else
                assert(false, p144 .. ", " .. Name);
            end;
        end;
    end;
end;

add_lootbox(
    nil,
    nil,
    "Skin Case",
    "Skin Cases",
    "Case",
    "rbxassetid://18185475009",
    { "Sandwich", "Saber", "Nuke Launcher", "Whoopee Cushion", "Disco Ball", "Singularity", "Pixel Sniper", "Don\'t Press", "Lasergun 3000", "Firework Gun", "Pixel Flamethrower", "Swashbuckler", "Electro Rifle", "Balloon Shotgun", "Emoji Cloud", "Pixel Crossbow", "Hyper Gunblade", "The Shred", "Temporal Ray", "Arcade Claw", "Plasma Distortion", "Glitter Warper", "Slime Gun", "Blobsaw", "Plastic Shovel", "Boxing Gloves", "AK-47", "Scythe of Death", "Blaster", "Water Uzi", "Desert Eagle", "Hacker Rifle", "Hacker Pistols", "Aces", "Trumpet", "Advanced Satchel", "Thunderpike", "Starforge Maul", "Starforge Permafrost", "Plasma Wildcat", "Cyber Warpstone", "Compound Bow", "Not So Shorty", "Stick", "Chancla", "Coffee", "Door", "Lovely Spray", "Trampoline" }
);
add_lootbox(
    nil,
    nil,
    "Skin Case 2",
    "Skin Case 2s",
    "Case",
    "rbxassetid://18763894913",
    { "Hyper Sniper", "Hyper Shotgun", "Karambit", "Augmented Rifle", "Hand Gun", "Sheriff", "Laptop", "Handsaws", "Teleport Disc", "Arcane Warper", "Electro Uzi", "Spaceship Launcher", "Camera", "Boba Gun", "Pixel Minigun", "Void Pistols", "Temporal Permafrost", "Fishing Rod", "Magma Distortion", "Aqua Burst", "Dynamite Gun", "Raven Bow", "Anchor", "Lightning Bolt", "Water Balloon", "Garden Shovel", "Uranium Launcher", "Ray Gun", "Bubble Ray", "Spring", "Energy Shield", "Harpoon Crossbow", "Hydro Rifle", "Bounce House", "Clown Hammer", "Lovely Shorty", "Lamethrower", "Brass Knuckles", "Balance", "Goalpost", "Torch", "Ban Axe", "Crude Gunblade", "Megaphone", "Nail Gun", "Notebook Satchel", "Paper Planes", "Fork" }
);
add_lootbox(
    nil,
    nil,
    "Skin Case 3",
    "Skin Case 3s",
    "Case",
    "rbxassetid://109359591947074",
    { "Hotel Bell", "Money Gun", "Medkitty", "Balisong", "Event Horizon", "Banana Flare", "Fighter Jet", "Harp", "Repulsor", "Drum Gun", "Bullpup Burst", "Peppergun", "Mega Drill", "Balloon Shorty", "Spray Bottle", "Void Rifle", "Gunsaw", "Genie Lamp", "Electropunk Warpstone", "Dream Bow", "Fists of Hurt", "Gearnade Launcher", "Glitterthrower", "Gum Ray", "Hourglass", "Lava Lamp", "Paintbrush", "Sakura Scythe", "Squid Launcher", "Stellar Katana", "Cerulean Axe", "Air Horn", "Masterpiece", "Hydro Pistols", "Shady Chicken Sandwich", "Violin Crossbow", "Plunger", "Permafrost.rbxm", "Cyber Distortion", "Cactus Shotgun", "DIY Tripmine", "Dynamite", "Gumball Handgun", "Ketchup Gun", "Lightbulb", "Bag o\' Money", "Shurikens", "Excalibur" }
);
add_lootbox(
    nil,
    nil,
    "Wrap Box",
    "Wrap Boxes",
    "Box",
    "rbxassetid://18185503558",
    { "Solar", "Malachite", "Lightning", "Arabesque", "Webbed", "Plastic", "Chrome", "A5", "Amber", "Insidious", "Iridescent", "Moonstone", "Bright", "Dark", "Mischief", "Rage", "Obsidian", "Toy", "Scales", "Well Done", "Dunes", "Glisten", "Glossy", "Bunsen", "Storm", "Mustard", "Violet", "Jean" }
);
add_lootbox(
    nil,
    nil,
    "Wrap Box 2",
    "Wrap Box 2s",
    "Box",
    "rbxassetid://18763894596",
    { "Speed", "Hologram", "Thunderburst", "Encrypt", "Starblaze", "Carbon Fiber", "Hyperdrive", "Insignia", "Cardinal", "Starfall", "Resolute", "Liquid Gold", "Tiger", "Black Granite", "Cerulean", "Clamshell", "Cool Crochet", "Cork", "Hammered Copper", "Hypnotic", "Leafy Grass", "Liquid Chrome", "Mahogany", "Neo", "Pink Crochet", "Pink Glitter", "Studded", "Tempest", "Yang", "Yin", "Ancient", "Grass", "Rustic", "Copper", "Machine", "Titanium", "Tungsten" }
);
add_lootbox(
    nil,
    nil,
    "Wrap Box 3",
    "Wrap Box 3s",
    "Box",
    "rbxassetid://77468549139941",
    { "Neon Lights", "Mesh", "Bombastic", "Candy Apple", "Dark Arena", "Green Sparkle", "Indigo Sparkle", "Rift", "Spectral", "Lovely Leopard", "Arbiter", "Antimatter", "Crimson Art", "Model", "Plasma", "Waste", "Purpleize", "Regal", "Sentinel", "Strobe", "TIX", "Tealur", "Lavish Crystal", "Noir", "Normal", "Rust", "Tawny" }
);
add_lootbox(
    nil,
    nil,
    "Charm Capsule",
    "Charm Capsules",
    "Capsule",
    "rbxassetid://18212803422",
    { "Blobfish", "Pufferfish", "Bitster", "Mystery Block", "Anvil", "Basketball", "Money Bag", "Rubber Duck", "10 Gallon Hat", "UFO", "Emoji: Weary", "Chocolate Scoop", "Rocket Ship", "Hotdog", "Moai", "Golf Ball", "Football", "Tennis Ball", "Rainbow", "Potion", "Hook", "Cookie", "Cupcake", "Ninja Star", "Lemon Slice", "Ship Wheel", "Star", "Heart", "Bowling Pin", "Life Buoy", "Cage", "Magnet", "Potted Cactus", "Potted Flower", "Fedora Stack", "Pawn", "Hammer", "Cog", "Dice", "Traffic Cone" }
);
add_lootbox(
    nil,
    nil,
    "Finisher Pack",
    "Finisher Packs",
    "Pack",
    "rbxassetid://106634436973187",
    { "Orbital Strike", "Darkheart", "BONK!", "Tough Crowd", "Balloons", "Electrocute", "Collapse", "Splatter", "High Gravity", "Freeze", "Tremble", "Rush", "Confetti", "Petrify", "Hacked", "Flop", "Toot", "Yoink" }
);
add_lootbox(
    nil,
    nil,
    "Finisher Pack 2",
    "Finisher Pack 2s",
    "Pack",
    "rbxassetid://80810630965566",
    { "Chark Attack", "GOOAAALLLL", "Crushed", "Enlightened", "Clapped", "Rainbow Barf", "Flick", "Ascend", "Roadrunner", "Heavy Head", "Bad Mood", "Hooked", "Delete", "Squawk", "Digitize", "Chalked", "Folded", "Very Tragic Banana Peel Accident" }
);
add_lootbox(
    nil,
    nil,
    "Spooky Skin Case",
    "Spooky Skin Cases",
    "CaseSpooky",
    "rbxassetid://89050335387917",
    { "Mimic Axe", "Soul Rifle", "Soul Pistols", "Experiment D15", "Experiment W4", "Pumpkin Launcher", "Skull Launcher", "Vexed Flare Gun", "Buzzsaw", "Bucket of Candy", "Spider Ray", "Vexed Candle", "Soul Grenade", "Eyeball", "Bat Daggers", "Potion Satchel", "Boneclaw Spray", "Boneclaw Horn", "Bat Scythe", "Bat Bow", "Boneclaw Rifle", "Boneclaw Revolver", "Jack O\'Thrower", "Brain Gun", "Broomstick", "Boneshot", "Exogourd", "Demon Uzi", "Demon Shorty", "Evil Trident", "Pumpkin Carver", "Spider Web", "Tombstone Shield", "Boneblade", "Crossbone", "Warpbone", "Eyething Sniper", "Spectral Burst", "Pumpkin Minigun", "Pumpkin Handgun", "Pumpkin Claws", "Machete", "Skullbang", "Trick or Treat" }
);
add_lootbox(
    nil,
    nil,
    "Haunted Chest",
    "Haunted Chests",
    "Chest",
    "rbxassetid://113101268671045",
    { "Soul Scourge", "Disintegrate", "Broom Ride", "Zombified", "Mummy", "Scourge", "Frankenstein", "Frankenblob", "Skullgourd", "Eyeclipse", "Cauldron", "Ghost", "Black Cat", "Reaper", "Bonesplosion", "Lost Soul", "Purple Goo", "Green Goo", "Chrome Webs", "Werewolf Fur", "Caramel Apple", "Devious Pumpkin", "Gravestone", "Melonkin", "Candy Bucket", "Spooky Confetti", "Batsplosion", "Bite", "Haunted", "Vexed", "Cursed", "Bone", "Candy", "Candy Corn", "Cobweb", "Spider", "Thorn Circle", "Witch Hat" }
);
add_lootbox(
    nil,
    nil,
    "Festive Skin Case",
    "Festive Skin Cases",
    "CaseFestive",
    "rbxassetid://122567993958308",
    { "Gingerbread Augmented Rifle", "Firework Launcher", "Peppermint Sheriff", "Candy Cane", "Festive Buzzsaw", "Milk & Cookies", "Hot Coals", "Dev-in-the-Box", "Warpstar", "Sleigh Maul", "Sleighstortion", "Frost Warper", "Jolly Man", "Gingerbread Sniper", "Frostbite Crossbow", "Frostbite Bow", "Snowblower", "Snowball Gun", "New Year Energy Rifle", "Snowball Launcher", "Cookies", "Gingerbread Handgun", "Reindeer Slingshot", "New Year Energy Pistols", "Cryo Scythe", "New Year Katana", "Snow Shovel", "Shining Star", "Snowglobe", "Jingle Grenade", "Snowman Permafrost", "Wrapped Minigun", "Wrapped Shotgun", "Pine Burst", "Elf\'s Gunblade", "Midnight Festive Exogun", "Pine Uzi", "Wrapped Shorty", "Pine Spray", "Wrapped Flare Gun", "Sled", "Nordic Axe", "Festive Fists", "Suspicious Gift", "Wrapped Freeze Ray", "Mammoth Horn" }
);
add_lootbox(
    nil,
    nil,
    "Jolly Chest",
    "Jolly Chests",
    "ChestFestive",
    "rbxassetid://125958746511820",
    { "Festive Lights", "Snowballed", "David", "Aurora", "Peppermint", "Gingerbread", "Yeti", "Gingerbread Man", "Gingerbread Cat", "Chillman", "Wreath", "Frozen", "Gingerbreadify", "Jolly Wrapping", "Snowfall", "Ugly Sweater", "Jolly Chair", "Stocking", "Festive Light", "Hot Chocolate", "Festive Confetti", "Wrapped", "Midnight", "Slush", "Frigid", "Firework", "Jolly Hat", "Elf Hat", "Peppermint Candy", "Crystal", "Mini Candy Cane", "Snowflake", "Mini Shining Star", "Ornament" }
);
add_lootbox(
    nil,
    nil,
    "Festive Wrap Box",
    "Festive Wrap Boxes",
    "Box",
    "rbxassetid://85450469885400",
    { "2025 Wrapping", "Forest Wrapping", "Peppermint Wrapping", "Winter Wrapping", "Mocha Wrapping", "Minty Wrapping", "Frosty Wrapping", "Creme Wrapping", "Blush Wrapping", "Cashmere Wrapping", "Carbon Wrapping", "Caned Wrapping" }
);
add_lootbox(
    nil,
    nil,
    "Festive Wrap Box 2",
    "Festive Wrap Box 2s",
    "Box",
    "rbxassetid://96554434133288",
    { "2026 Wrapping", "Chilled Wrapping", "Luxury Wrapping", "Regal Wrapping", "Holly Wrapping", "Fortune Wrapping", "Pearly Wrapping", "Polar Wrapping", "Mousse Wrapping", "Periwinkle Wrapping", "Evergreen Wrapping", "Dusky Wrapping", "Merlot Wrapping", "Indigo Wrapping" }
);
add_lootbox(
    nil,
    nil,
    "Goodie Bag",
    "Goodie Bags",
    nil,
    "rbxassetid://97975295792185",
    { "Charm Capsule", "Wrap Box", "Wrap Box 2", "Wrap Box 3", "Finisher Pack", "Finisher Pack 2" }
);
add_lootbox(
    nil,
    nil,
    "Prime Goodie Bag",
    "Prime Goodie Bags",
    nil,
    "rbxassetid://123579272651325",
    { "Skin Ticket", "Charm Capsule", "Wrap Box", "Wrap Box 2", "Wrap Box 3", "Finisher Pack", "Finisher Pack 2" },
    "May contain skin tickets!"
);
add_lootbox(
    nil,
    nil,
    "Summer Skin Case",
    "Summer Skin Cases",
    "CaseSummer",
    "rbxassetid://75952684698581",
    { "Shark Shotgun", "Sand Bullpup Burst", "Ice Cream", "Cooler", "Crab Claws", "Fizz Bomb", "Pocket Volcano", "Cruise Revolver", "Campfire Spray", "Lifeguard Whistle", "Hazard Sign", "Sol", "Shark Minigun", "Permasand", "Bubblethrower", "Bubble Shorty", "Bubble Distortion", "Bubbler", "Tiki Axe", "Scooper", "Sandgun", "Pearl Rifle", "Pearl Exogun", "Warp Juice", "Palm Bow", "Sundae Launcher", "Coconut Launcher", "Sol Pistols", "Sol Rifle", "Chark Kebab", "Broken Surfboard", "Beach Ball", "Flamingo Floatie", "Sharksaw", "Giant Popsicle", "Lifeguard Satchel", "Lifeguard Grappler", "Palmshot", "Shark Tooth", "Sharkbite", "Lemonade Gun", "Swordfish", "Campfire Stick", "Campfire Crossbow", "Campfire Sniper", "Plastic Flamingo", "Ducky Uzi", "Starfish" }
);
add_lootbox(
    nil,
    nil,
    "Tropical Chest",
    "Tropical Chests",
    "ChestSummer",
    "rbxassetid://93495411534770",
    { "Tidal", "Summer Days", "Loose Coconut", "Mow Them Down", "Bubble Ball", "Popsicle", "Fish Scales", "Emoji: Hot", "Jellyfish", "Summer Cooler", "Sand Castle", "Soda Can", "Swept Away", "Kiddie Pool", "Beach Day", "Lighthouse", "Neapolitan", "Shore", "Mini Flamingo Floatie", "Sand Bucket", "Hidden Pearl", "Rocket Popsicle", "Lemon Juice", "Surfboard", "Sun Rays", "Water Balloons", "Sizzled", "Lemonade", "Creamsicle", "Waffle Cone", "Water Blaster", "Mini Beach Ball", "Flip Flop", "Snorkel Goggles", "Coconut", "Mini Starfish", "Watermelon Slice" }
);
add_lootbox(
    true,
    true,
    "Prize Wheel",
    "Prize Wheels",
    "PrizeWheel",
    "rbxassetid://84152087387410",
    { {
            Weight = 35.5,
            Reward = {
                Name = "Key",
                Quantity = 4
            }
        }, {
            Weight = 25,
            Reward = {
                Name = "Goodie Bag",
                Quantity = 2,
                Weapon = "IsRandom"
            }
        }, {
            Weight = 20,
            Reward = {
                Name = "Key",
                Quantity = 10
            }
        }, {
            Weight = 15,
            Reward = {
                Name = "Celestial",
                Quantity = 1,
                Weapon = "IsRandom"
            }
        }, {
            Weight = 4,
            Reward = {
                Name = "Skin Ticket",
                Quantity = 1
            }
        }, {
            Weight = 0.5,
            Reward = {
                Name = "Light Fifty",
                Quantity = 1,
                Weapon = "Sniper"
            }
        } }
);
(function() -- Line: 1926, Name: add_weapons
    -- upvalues: ItemLibrary (copy), add_reward (copy), ShopLibrary (copy), Utility (copy), add_lootbox (copy)
    local function add_weapon(p158) -- Line: 1928
        -- upvalues: ItemLibrary (ref), add_reward (ref)
        add_reward("Weapon", p158, p158, p158, ItemLibrary.Items[p158].Image, 3, {
            ImageHighResolution = ItemLibrary.ViewModels[p158].ImageHighResolution
        });
    end;

    for _, v in pairs(ShopLibrary.OwnableWeapons) do
        add_reward("Weapon", v, v, v, ItemLibrary.Items[v].Image, 3, {
            ImageHighResolution = ItemLibrary.ViewModels[v].ImageHighResolution
        });
    end;

    add_reward("Weapon", "MISSING_WEAPON", "MISSING_WEAPON", "MISSING_WEAPON", ItemLibrary.Items.MISSING_WEAPON.Image, 3, {
        ImageHighResolution = ItemLibrary.ViewModels.MISSING_WEAPON.ImageHighResolution
    });
    local v164, v165 = (function() -- Line: 1943, Name: get_contents
        -- upvalues: ShopLibrary (ref), ItemLibrary (ref), Utility (ref)
        local v159 = {};

        for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons()) do
            if ShopLibrary.Weapons[v].KeyPrice then
                table.insert(v159, v);
            end;
        end;

        table.sort(v159, function(p160, p161) -- Line: 1954
            -- upvalues: ItemLibrary (ref), Utility (ref)
            local Value = ItemLibrary.Statuses[ItemLibrary.Items[p160].Status].Value;
            local Value2 = ItemLibrary.Statuses[ItemLibrary.Items[p161].Status].Value;

            if Value == Value2 then
                return Utility:StringLessThan(p160, p161);
            end;

            return Value2 < Value;
        end);
        local v162 = {};

        for _, v in pairs(v159) do
            local v163 = ItemLibrary.Items[v];
            v162[v163.Status] = v162[v163.Status] or {};
            table.insert(v162[v163.Status], v);
        end;

        return v159, v162;
    end)();
    local v166 = {};

    for _, v in pairs(v164) do
        table.insert(v166, {
            Weight = 1,
            Reward = {
                Name = v
            }
        });
    end;

    add_lootbox(true, nil, "Weapon Crate", "Weapon Crates", "Crate", "rbxassetid://134795947609872", v166);

    for i in pairs(ItemLibrary.Statuses) do
        local v167 = i;
        local v168 = {};

        for _, v in pairs(v165[i]) do
            table.insert(v168, {
                Weight = 1,
                Reward = {
                    Name = v
                }
            });
        end;

        add_lootbox(true, nil, v167 .. " Weapon Crate", v167 .. " Weapon Crates", "Crate", "rbxassetid://134795947609872", v168);
    end;
end)();
(function() -- Line: 2001, Name: alphabetize
    -- upvalues: u39 (copy), Utility (copy)
    for i in pairs(u39.Cosmetics) do
        table.insert(u39.CosmeticsAlphabetized, i);
    end;

    table.sort(u39.CosmeticsAlphabetized, function(p169, p170) -- Line: 2006
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(string.lower(p169), string.lower(p170));
    end);
    task.delay(5, function() -- Line: 2010
        -- upvalues: u39 (ref)
        for i, v in pairs(u39.Cosmetics) do
            if not v.Description and v.Rarity ~= "Unobtainable" then
                warn("Missing description:", i);
            end;
        end;
    end);
end)();

return u39;