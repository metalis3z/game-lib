-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local TestLibrary = require(ReplicatedStorage.Modules.TestLibrary);
local ShopEntry = require(ReplicatedStorage.Modules.ShopEntry);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1;

if CONSTANTS.IS_STUDIO then
    u1 = TestLibrary:GetTestAttribute("StudioTestUnreleasedWeapons");
else
    u1 = CONSTANTS.IS_TESTING_SERVER;
end;

local TestAttribute = TestLibrary:GetTestAttribute("StudioEnableFlashSales");
local u20 = {
    NUM_GLORIOUS_COSMETICS = {},
    Entries = {},
    Weapons = {},
    OwnableWeapons = {},
    OwnableWeaponsAlphabetized = {},
    OwnableWeaponsCanEliminate = {},
    OwnableWeaponReleaseSchedule = {},
    DailyShopCosmeticTypes = {},
    FlashSales = {},
    Lootboxes = {},

    GetWeaponKeyPriceInfo = function(p2, p3, p4, p5) -- Line: 30, Name: GetWeaponKeyPriceInfo
        -- upvalues: ItemLibrary (copy)
        local v6 = p5[p3];
        local v7;

        if v6 then
            v7 = v6;
        elseif p4 > 0 then
            v7 = ItemLibrary.Items[p3] and ItemLibrary.Items[p3].Status == "Standard";
        else
            v7 = false;
        end;

        return v7 and 0 or (p2.Weapons[p3] and p2.Weapons[p3].KeyPrice or (1 / 0)), v7, v6, p4;
    end,

    GetReleasedOwnableWeapons = function(p8, p9, p10) -- Line: 38, Name: GetReleasedOwnableWeapons
        local v11 = {};

        for _, v in pairs(p10 or p8.OwnableWeapons) do
            if p8:IsWeaponReleased(v, p9) then
                table.insert(v11, v);
            end;
        end;

        return v11;
    end,

    GetTimeUntilWeaponRelease = function(p12, p13) -- Line: 50, Name: GetTimeUntilWeaponRelease
        -- upvalues: ServerOsTime (copy)
        local v14 = p12.Weapons[p13];

        return (v14 and v14.ReleaseTime or 0) - ServerOsTime:GetRounded();
    end,

    IsWeaponReleased = function(p15, p16, p17) -- Line: 56, Name: IsWeaponReleased
        local v18 = p15.Weapons[p16] and p15:GetTimeUntilWeaponRelease(p16) <= (p17 or 0);

        return v18;
    end,

    GetUpcomingWeapon = function(p19) -- Line: 60, Name: GetUpcomingWeapon
        for i, v in pairs(p19.OwnableWeaponReleaseSchedule) do
            if p19:GetTimeUntilWeaponRelease(v) > 0 then
                return v, i;
            end;
        end;
    end
};

local function add_weapon(p21, p22, p23) -- Line: 68
    -- upvalues: ItemLibrary (copy), u1 (copy), u20 (copy), Utility (copy)
    local v24 = ItemLibrary.Items[p21];
    u20.Weapons[p21] = {
        Weapon = p21,
        KeyPrice = p22,
        ReleaseTime = u1 and #u20.OwnableWeapons or (p23 or 0)
    };
    table.insert(u20.OwnableWeapons, p21);
    table.insert(u20.OwnableWeaponsAlphabetized, p21);

    if v24.CanEliminate then
        table.insert(u20.OwnableWeaponsCanEliminate, p21);
    end;

    table.sort(u20.OwnableWeaponsAlphabetized, function(p25, p26) -- Line: 86
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(string.lower(p25), string.lower(p26));
    end);
end;

add_weapon("Assault Rifle", 0);
add_weapon("Bow", 15);
add_weapon("Burst Rifle", 25);
add_weapon("Flamethrower", 400);
add_weapon("Grenade Launcher", 425);
add_weapon("Minigun", 450);
add_weapon("Paintball Gun", 475);
add_weapon("RPG", 25);
add_weapon("Shotgun", 20);
add_weapon("Sniper", 75);
add_weapon("Handgun", 0);
add_weapon("Flare Gun", 10);
add_weapon("Exogun", 350);
add_weapon("Revolver", 25);
add_weapon("Shorty", 20);
add_weapon("Slingshot", 300);
add_weapon("Uzi", 20);
add_weapon("Fists", 0);
add_weapon("Chainsaw", 15);
add_weapon("Katana", 45);
add_weapon("Knife", 20);
add_weapon("Scythe", 40);
add_weapon("Trowel", 200);
add_weapon("Grenade", 0);
add_weapon("Flashbang", 15);
add_weapon("Medkit", 300);
add_weapon("Molotov", 25);
add_weapon("Smoke Grenade", 10);
add_weapon("Subspace Tripmine", 250);
add_weapon("Freeze Ray", 45, 1720886400);
add_weapon("War Horn", 30, 1735275600);
add_weapon("Satchel", 35, 1734670800);
add_weapon("Battle Axe", 50, 1734066000);
add_weapon("Riot Shield", 45, 1735880400);
add_weapon("Daggers", 30, 1733461200);
add_weapon("Energy Pistols", 400);
add_weapon("Energy Rifle", 425);
add_weapon("Spray", 5, 1736485200);
add_weapon("Crossbow", 35, 1732770000);
add_weapon("Gunblade", 45, 1737090000);
add_weapon("Jump Pad", nil);
add_weapon("Distortion", 700);
add_weapon("Warper", 650);
add_weapon("Warpstone", 400);
add_weapon("Maul", 550);
add_weapon("Permafrost", 600);
add_weapon("Spear", nil);
add_weapon("Grappler", nil);
add_weapon("Wildcat", 35);

local function add_shop_entry(...) -- Line: 142
    -- upvalues: ShopEntry (copy), u20 (copy)
    local v27 = ShopEntry.new(...);
    u20.Entries[v27.EntryName] = v27;

    return v27;
end;

add_shop_entry("Loose", "loose_arena", { {
        Name = "Arena",
        Weapon = "IsRandom"
    } }, {
    WeaponKeys = 25
});
add_shop_entry(
    "Loose",
    "loose_randomwrap",
    { {
            Name = "Overseer",
            Weapon = "IsRandom"
        } },
    {
        WeaponKeys = 25
    },
    nil,
    nil,
    true
);
add_shop_entry(
    "Loose",
    "loose_universalwrap",
    { {
            Name = "Splattered",
            Weapon = "IsUniversal"
        } },
    {
        WeaponKeys = 250
    },
    nil,
    nil,
    true
);
add_shop_entry("Loose", "loose_glorycharm", { {
        Name = "Emoji: Imp",
        Weapon = "IsUniversal"
    } }, {
    Glory = 250
});
add_shop_entry("Loose", "loose_gloryfinisher", { {
        Name = "Impaled",
        Weapon = "IsUniversal"
    } }, {
    Glory = 500
});
add_shop_entry("Loose", "loose_gloryemote", { {
        Name = "Flex"
    } }, {
    Glory = 1000
});
add_shop_entry("Loose", "loose_glorywrap", { {
        Name = "Black Glass",
        Weapon = "IsUniversal"
    } }, {
    Glory = 2000
});

if EventLibrary.IS_ACTIVE then
    add_shop_entry("Loose", "loose_" .. EventLibrary.UNIVERSAL_SHOP_CHARM, {
        {
            Weapon = "IsUniversal",
            Name = EventLibrary.UNIVERSAL_SHOP_CHARM
        }
    }, {
        EventCurrency = 1000
    }, nil, nil, true);
    add_shop_entry("Loose", "loose_" .. EventLibrary.UNIVERSAL_SHOP_WRAP, {
        {
            Weapon = "IsUniversal",
            Name = EventLibrary.UNIVERSAL_SHOP_WRAP
        }
    }, {
        EventCurrency = 2000
    }, nil, nil, true);
    add_shop_entry("Loose", "loose_" .. EventLibrary.UNIVERSAL_SHOP_FINISHER, {
        {
            Weapon = "IsUniversal",
            Name = EventLibrary.UNIVERSAL_SHOP_FINISHER
        }
    }, {
        EventCurrency = 3000
    }, nil, nil, true);
    add_shop_entry("Loose", "loose_" .. EventLibrary.UNIVERSAL_SHOP_EMOTE, {
        {
            Name = EventLibrary.UNIVERSAL_SHOP_EMOTE
        }
    }, {
        EventCurrency = 5000
    }, nil, nil, true);
end;

for _, v in pairs(u20:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET, u20.OwnableWeaponsAlphabetized)) do
    local v28 = v;
    local v29 = 0;

    for i = 1, 4 do
        local v30;

        if i == 3 and not ItemLibrary.Items[v28].CanEliminate then
            v30 = i;
        else
            v29 = v29 + 1;
            local v31;

            if i == 1 then
                v31 = "Glory Coin";
            elseif i == 2 then
                v31 = "Glorious";
            elseif i == 3 then
                v31 = "For Glory";
            elseif i == 4 then
                v31 = "Glorious " .. v28;
            else
                v31 = assert(false, "???");
            end;

            add_shop_entry("Loose", "loose_gloriouscosmetic_" .. v29 .. "_" .. v28, {
                {
                    Name = v31,
                    Weapon = v28
                }
            }, {
                Glory = i == 1 and 100 or (i == 2 and 200 or (i == 3 and 300 or (i == 4 and 400 or assert(false, "???"))))
            });
            u20.NUM_GLORIOUS_COSMETICS[v28] = (u20.NUM_GLORIOUS_COSMETICS[v28] or 0) + 1;
            v30 = i;
        end;
    end;
end;

local function add_daily_shop_cosmetic_type(p32, p33) -- Line: 227
    -- upvalues: u20 (copy)
    u20.DailyShopCosmeticTypes[p32] = {
        PricesByRarity = p33,
        CosmeticNames = {}
    };
end;

u20.DailyShopCosmeticTypes.Emote = {
    PricesByRarity = {
        Common = {
            WeaponKeys = 50
        },
        Rare = {
            WeaponKeys = 75
        },
        Legendary = {
            WeaponKeys = 100
        }
    },
    CosmeticNames = {}
};

local function add_daily_shop_cosmetic(p34, u35) -- Line: 238
    -- upvalues: u20 (copy), ReplicatedStorage (copy)
    table.insert(u20.DailyShopCosmeticTypes[p34].CosmeticNames, u35);
    task.defer(function() -- Line: 241
        -- upvalues: ReplicatedStorage (ref), u35 (copy)
        require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u35, "Can be purchased from the Daily Shop");
    end);
end;

table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Shoulder Brush");
local u36 = "Shoulder Brush";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u36 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u36, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Vegetable");
local u37 = "Vegetable";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u37 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u37, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Coo Coo");
local u38 = "Coo Coo";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u38 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u38, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Denial");
local u39 = "Denial";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u39 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u39, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Facepalm");
local u40 = "Facepalm";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u40 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u40, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Kneel");
local u41 = "Kneel";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u41 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u41, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Agree");
local u42 = "Agree";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u42 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u42, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Think");
local u43 = "Think";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u43 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u43, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Salty");
local u44 = "Salty";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u44 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u44, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Superhero");
local u45 = "Superhero";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u45 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u45, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Cream Cheese Honey");
local u46 = "Cream Cheese Honey";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u46 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u46, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Criss Cross");
local u47 = "Criss Cross";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u47 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u47, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Side To Side");
local u48 = "Side To Side";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u48 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u48, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Off of You");
local u49 = "Off of You";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u49 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u49, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Round & Round");
local u50 = "Round & Round";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u50 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u50, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Smile");
local u51 = "Smile";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u51 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u51, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Take The L");
local u52 = "Take The L";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u52 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u52, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Selfie");
local u53 = "Selfie";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u53 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u53, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Giant Camera");
local u54 = "Giant Camera";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u54 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u54, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Horsey");
local u55 = "Horsey";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u55 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u55, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Bad Feeling");
local u56 = "Bad Feeling";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u56 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u56, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Hollywoodin\'");
local u57 = "Hollywoodin\'";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u57 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u57, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Bad Boy");
local u58 = "Bad Boy";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u58 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u58, "Can be purchased from the Daily Shop");
end);
table.insert(u20.DailyShopCosmeticTypes.Emote.CosmeticNames, "Old Timer");
local u59 = "Old Timer";
task.defer(function() -- Line: 241
    -- upvalues: ReplicatedStorage (copy), u59 (copy)
    require(ReplicatedStorage.Modules.CosmeticLibrary):ExternallySetCosmeticDescription(u59, "Can be purchased from the Daily Shop");
end);

local function add_flash_sale(p60, ...) -- Line: 272
    -- upvalues: add_shop_entry (copy), TestAttribute (copy), u20 (copy)
    local v61 = add_shop_entry("Flash Sale", ...);

    if TestAttribute then
        v61.PurchaseAppearTime = os.time() + 5;
        v61.PurchaseStartTime = os.time() + 10;
        v61.PurchaseDuration = 60;
    end;

    table.insert(u20.FlashSales, {
        ShopEntry = v61,
        DisplayName = p60
    });
end;

local function add_lootbox(p62, p63, p64, p65, p66, p67) -- Line: 291
    -- upvalues: add_shop_entry (copy), u20 (copy)
    local v68 = {
        ShopEntry = add_shop_entry("Lootbox", "lootbox_" .. p62, {
            {
                Weapon = "IsRandom",
                Quantity = 1,
                Name = p62
            }
        }, p63, p64, p65, p66),
        PricesByRarity = p67
    };
    u20.Lootboxes[p62] = v68;
end;

add_lootbox("Skin Case", {
    SkinTickets = 10
}, 1852079505, 1861165031);
add_lootbox("Skin Case 2", {
    SkinTickets = 10
}, 1892542763, 1892543013);
add_lootbox("Skin Case 3", {
    SkinTickets = 10
}, 3251887315, 3251887576);
add_lootbox(
    "Wrap Box",
    {
        WeaponKeys = 5
    },
    nil,
    nil,
    nil,
    {
        Common = {
            WeaponKeys = 5
        },
        Rare = {
            WeaponKeys = 10
        },
        Legendary = {
            WeaponKeys = 15
        }
    }
);
add_lootbox(
    "Wrap Box 2",
    {
        WeaponKeys = 5
    },
    nil,
    nil,
    nil,
    {
        Common = {
            WeaponKeys = 5
        },
        Rare = {
            WeaponKeys = 10
        },
        Legendary = {
            WeaponKeys = 15
        }
    }
);
add_lootbox(
    "Wrap Box 3",
    {
        WeaponKeys = 5
    },
    nil,
    nil,
    nil,
    {
        Common = {
            WeaponKeys = 5
        },
        Rare = {
            WeaponKeys = 10
        },
        Legendary = {
            WeaponKeys = 15
        }
    }
);
add_lootbox(
    "Charm Capsule",
    {
        WeaponKeys = 3
    },
    nil,
    nil,
    nil,
    {
        Common = {
            WeaponKeys = 3
        },
        Rare = {
            WeaponKeys = 4
        },
        Legendary = {
            WeaponKeys = 5
        }
    }
);
add_lootbox(
    "Finisher Pack",
    {
        WeaponKeys = 10
    },
    nil,
    nil,
    nil,
    {
        Common = {
            WeaponKeys = 10
        },
        Rare = {
            WeaponKeys = 15
        },
        Legendary = {
            WeaponKeys = 20
        }
    }
);
add_lootbox(
    "Finisher Pack 2",
    {
        WeaponKeys = 10
    },
    nil,
    nil,
    nil,
    {
        Common = {
            WeaponKeys = 10
        },
        Rare = {
            WeaponKeys = 15
        },
        Legendary = {
            WeaponKeys = 20
        }
    }
);

if EventLibrary.IS_ACTIVE then
    add_lootbox(EventLibrary.SPECIAL_LOOTBOX_SKINS, {
        SkinTickets = 10
    }, 2154617424, 2154618109, true);
    add_lootbox(EventLibrary.SPECIAL_LOOTBOX_VARIETY, {
        EventCurrency = 30
    }, nil, nil, true, {
        Common = {
            EventCurrency = 30
        },
        Rare = {
            EventCurrency = 60
        },
        Legendary = {
            EventCurrency = 90
        }
    });
end;

(function() -- Line: 319, Name: setup_schedule
    -- upvalues: u20 (copy), Utility (copy)
    for _, v in pairs(u20.OwnableWeapons) do
        table.insert(u20.OwnableWeaponReleaseSchedule, v);
    end;

    table.sort(u20.OwnableWeaponReleaseSchedule, function(p69, p70) -- Line: 324
        -- upvalues: u20 (ref), Utility (ref)
        local v71 = u20.Weapons[p69].ReleaseTime or -1;
        local v72 = u20.Weapons[p70].ReleaseTime or -1;

        if v71 == v72 then
            return Utility:StringLessThan(p69, p70);
        end;

        return v71 < v72;
    end);
end)();

-- This place gives the whole shop away: every price is 0, so the buy buttons show "Free".
(function()
    for _, entry in pairs(u20.Entries) do
        for currency in pairs(entry.Prices or {}) do
            entry.Prices[currency] = 0;
        end;
    end;

    for _, stock in pairs(u20.DailyShopCosmeticTypes) do
        for _, prices in pairs(stock.PricesByRarity or {}) do
            for currency in pairs(prices) do
                prices[currency] = 0;
            end;
        end;
    end;
end)();

return u20;