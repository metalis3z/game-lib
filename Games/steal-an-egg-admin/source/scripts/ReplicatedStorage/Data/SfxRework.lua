-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    NewAnimalSfx = false,
    NewCherryBlossomSfx = false
}
local v2 = table.freeze({
    Jump = "rbxassetid://122570033096800",
    GreetingRun = "rbxassetid://131068359944219",
    GreetingLove = "rbxassetid://76994230083463"
})
local v3 = {
    Jump = "rbxassetid://83274995963170",
    GreetingRun = "rbxassetid://105114448549171",
    GreetingLove = "rbxassetid://118750922827836"
}
local v4 = table.freeze(v3)
local v5 = {
    ["Alabaster Whale"] = table.freeze({ Idle = 129096651245848 }),
    ["Alien Skeleton Boss"] = table.freeze({
        Walk = 109714058718761,
        Idle = 100242698004715
    }),
    Ankylosaurus = table.freeze({
        Walk = 88644290845697,
        Idle = 71041124063756
    }),
    ["Ascended Vermilion Phoenix"] = table.freeze({
        Walk = 109025156154052,
        Idle = 118544893570208
    }),
    ["Ash Gecko"] = table.freeze({
        Walk = 117441161028083,
        Idle = 103174077804237
    }),
    ["Baby Aurora Dragon"] = table.freeze({ Walk = 131092059995772 }),
    ["Bananita Dolphinita"] = table.freeze({
        Walk = 130064871318459,
        Idle = 86008876900749
    }),
    Basilisk = table.freeze({ Idle = 105584653658590 }),
    Bear = table.freeze({
        Walk = 76067183336117,
        Idle = 136544341456207
    }),
    ["Belula Beluga"] = table.freeze({
        Walk = 95798870197359,
        Idle = 76418224731174
    }),
    ["Bomboclat Crocolat"] = table.freeze({
        Walk = 95486255177501,
        Idle = 135302085303957
    }),
    Bronto = table.freeze({
        Walk = 106003135813859,
        Idle = 117894248191730
    }),
    ["Brr Brr Patapim"] = table.freeze({
        Walk = 87933562223576,
        Idle = 128649290099314
    }),
    ["Burrowing Owl"] = table.freeze({
        Walk = 96169640860368,
        Idle = 138462604797731
    }),
    Camel = table.freeze({ Walk = 75909864395296 }),
    Catfish = table.freeze({ Idle = 72308088798973 }),
    ["Cave Dragon"] = table.freeze({
        Walk = 126373015770883,
        Idle = 131024716406913
    }),
    Centapede = table.freeze({ Walk = 79059799275595 }),
    Cerberus = table.freeze({
        Walk = 115218701863479,
        Idle = 124189560966798
    }),
    Chicken = table.freeze({ Walk = 87548188344479 }),
    ["Chillin Chilli"] = table.freeze({
        Walk = 95798870197359,
        Idle = 73284257610335
    }),
    Chimpanzee = table.freeze({
        Walk = 113929337068070,
        Idle = 111051351659368
    }),
    ["Colossal Mammoth"] = table.freeze({
        Walk = 86875592400554,
        Idle = 104909601448680
    }),
    Crane = table.freeze({ Walk = 120588083674559 }),
    Crocodile = table.freeze({
        Walk = 95486255177501,
        Idle = 135302085303957
    }),
    ["Cyclops Gorilla"] = table.freeze({
        Walk = 91988920873880,
        Idle = 72064443452392
    }),
    DeathstalkerScorpion = table.freeze({
        Walk = 107380502781564,
        Idle = 131469970697843
    }),
    DesertLark = table.freeze({
        Walk = 89332981222961,
        Idle = 84794194207563
    }),
    Dodo = table.freeze({
        Walk = 106723880219118,
        Idle = 75672112373342
    }),
    Dog = table.freeze({ Walk = 114288253621011 }),
    Dragon = table.freeze({
        Walk = 109025156154052,
        Idle = 78694564728882
    }),
    ["Dream Axolotl"] = table.freeze({
        Walk = 103701289501655,
        Idle = 70434947323848
    }),
    Duckling = table.freeze({
        Walk = 131376217168921,
        Idle = 88053346548272
    }),
    ["El Maja"] = table.freeze({ Idle = 111108330394116 }),
    ["Ember Dragon"] = table.freeze({ Walk = 131092059995772 }),
    ["Eternal Lunar Dragon"] = table.freeze({
        Walk = 140319056697092,
        Idle = 97479392442156
    }),
    FennecFox = table.freeze({
        Walk = 128152104958956,
        Idle = 100455724808546
    }),
    ["Finned Thresher"] = table.freeze({ Idle = 103741054632110 }),
    ["Flaming Bull"] = table.freeze({
        Walk = 79844937872328,
        Idle = 72371795471884
    }),
    Frog = table.freeze({
        Walk = 77446124647730,
        Idle = 119337763543317
    }),
    ["Galaxy Gecko"] = table.freeze({
        Walk = 117441161028083,
        Idle = 103174077804237
    }),
    Gorilla = table.freeze({
        Walk = 91988920873880,
        Idle = 72064443452392
    }),
    ["Ice Dragon"] = table.freeze({
        Walk = 77526192727371,
        Idle = 74890181204849
    }),
    Irihorus = table.freeze({
        Walk = 85644686240866,
        Idle = 108618809785102
    }),
    Jerboa = table.freeze({
        Walk = 104829809240788,
        Idle = 122864669774068
    }),
    Kitsune = table.freeze({ Walk = 90982484045337 }),
    Koi = table.freeze({ Walk = 85648004797976 }),
    Kraken = table.freeze({
        Walk = 83803463546649,
        Idle = 85503880676062
    }),
    ["La Vacca Saturno Saturnita"] = table.freeze({
        Walk = 122882651423138,
        Idle = 130064871318459
    }),
    ["Lava Iguana"] = table.freeze({
        Walk = 89304866645321,
        Idle = 114496337968904
    }),
    ["Lava frog"] = table.freeze({
        Walk = 77446124647730,
        Idle = 119337763543317
    }),
    Mammoth = table.freeze({
        Walk = 86875592400554,
        Idle = 104909601448680
    }),
    ["Mangolini Parrochini"] = table.freeze({ Walk = 95798870197359 }),
    ["Mire Fox"] = table.freeze({
        Walk = 120873458847676,
        Idle = 78136934911287
    }),
    Mosasaurus = table.freeze({ Idle = 105584653658590 }),
    ["Oni Tiger"] = table.freeze({ Walk = 133901350799634 }),
    ["Orangutini Ananassini"] = table.freeze({
        Walk = 138250855252546,
        Idle = 131552829307949
    }),
    Orca = table.freeze({ Idle = 114867306839568 }),
    Parrotfish = table.freeze({ Idle = 72308088798973 }),
    Penguin = table.freeze({
        Walk = 85891089694813,
        Idle = 135048724468766
    }),
    ["Polar Bear"] = table.freeze({
        Walk = 76067183336117,
        Idle = 136544341456207
    }),
    Pterodactyl = table.freeze({
        Walk = 78564292241368,
        Idle = 126033988243515
    }),
    Raccoon = table.freeze({
        Walk = 126838319731878,
        Idle = 110999283168826
    }),
    Rattlesnake = table.freeze({
        Walk = 71687574249343,
        Idle = 116205296003011
    })
}

v5["Red Panda"] = table.freeze({ Walk = 85810173012807 })
v5["Sabertooth Tiger"] = table.freeze({
    Walk = 71568755773112,
    Idle = 102301498010995
})
v5.Salamander = table.freeze({ Walk = 123189281925096 })
v5["Sand Spider"] = table.freeze({
    Walk = 80758942907630,
    Idle = 121933389766417
})
v5.ScorchedDragon = table.freeze({ Walk = 80955737198756 })
v5["Shadow Dragon"] = table.freeze({ Walk = 131092059995772 })
v5["Snowy Owl"] = table.freeze({ Walk = 112958966421431 })
v5.Spider = table.freeze({
    Walk = 81056698279247,
    Idle = 111850349943285
})
v5.Stag = table.freeze({ Walk = 127449225604986 })
v5["Strawberry Elephant"] = table.freeze({
    Walk = 86875592400554,
    Idle = 130232735871826
})
v5.Swan = table.freeze({
    Walk = 131376217168921,
    Idle = 128860233674087
})
v5.Swordfish = table.freeze({ Idle = 121063299135709 })
v5.Tiger = table.freeze({
    Walk = 71568755773112,
    Idle = 102301498010995
})
v5["Tob Tobi Tob Tob"] = table.freeze({
    Walk = 122614385494976,
    Idle = 92039711531325
})
v5.Toucan = table.freeze({ Walk = 89332981222961 })
v5.Tralaledon = table.freeze({
    Walk = 134496866512820,
    Idle = table.freeze({ 101608046028295, 98200903566486 })
})
v5.Triceratops = table.freeze({
    Walk = 100649489659651,
    Idle = 89794991889386
})
v5["Trulimero Trulicina"] = table.freeze({ Idle = 83563677974575 })
v5["Tung Tung Sahur"] = table.freeze({
    Walk = 87933562223576,
    Idle = 107747804720259
})
v5.Turtle = table.freeze({ Walk = 112920773194316 })
v5.TyrannosaurusRex = table.freeze({
    Walk = 112820906341272,
    Idle = table.freeze({ 109670444037890, 106221550420839 })
})
v5.Unicorn = table.freeze({
    Walk = 85978916861059,
    Idle = 87510872443811
})
v5["Void Dragon"] = table.freeze({ Walk = 131092059995772 })
v5.Walrus = table.freeze({ Walk = 93209551369966 })
v5.Warden = table.freeze({
    Walk = 71687574249343,
    Idle = 116205296003011
})
v5["Whale Shark"] = table.freeze({ Idle = 129096651245848 })
v5.Yeti = table.freeze({
    Walk = 117484856411882,
    Idle = 88192245037094
})

local v6 = table.freeze(v5)
local v7 = { Kitsune = true }

v7["Snowy Owl"] = true
v7.Koi = true
v7.Salamander = true
v7["Oni Tiger"] = true
v7.Stag = true
v7["Red Panda"] = true
v7["Baby Aurora Dragon"] = true
v7["Shadow Dragon"] = true
v7["Ember Dragon"] = true
v7["Void Dragon"] = true
v7.ScorchedDragon = true

local v8 = table.freeze(v7)
local v9 = table.freeze({ Crane = 131376217168921 })

v1.GuardFootstepLegacy = "rbxassetid://109714058718761"
v1.GuardFootstepNew = "rbxassetid://133901350799634"

local function withId(v10, v11) -- line 119
    if v11 == nil or v10 == nil then
        return nil
    end
    if v11 == v10.SoundId then
        return v10
    end
    return table.freeze({
        Data = v10.Data,
        SoundId = v11
    })
end

function v1.Global(v12) -- line 128 | captures: v1, v2, v4
    local v13 = if v1.NewAnimalSfx then v2 else v4
    return v13[v12]
end

function v1.Resolve(v14, v15, v16) -- line 137 | captures: v1, v6, v8, v9
    if v14 == nil then
        return v16
    end
    local v17
    if v1.NewAnimalSfx then
        v17 = v16
    else
        local v18 = v6[v14]
        local v19 = if v18 then v18[v15] else nil
        if v19 == nil then
        elseif v16 == nil or v19 == v16.SoundId then
            v17 = v16
        else
            v17 = table.freeze({
                Data = v16.Data,
                SoundId = v19
            })
        end
    end
    if v1.NewCherryBlossomSfx or not (v15 == "Walk") then
        return v17
    end
    if v8[v14] then
        return nil
    end
    if v9[v14] == nil then
        return v17
    end
    local v20 = v9[v14]
    if v20 == nil or v16 == nil then
        return nil
    end
    if v20 == v16.SoundId then
        return v16
    end
    return (table.freeze({
        Data = v16.Data,
        SoundId = v20
    }))
end

return v1
