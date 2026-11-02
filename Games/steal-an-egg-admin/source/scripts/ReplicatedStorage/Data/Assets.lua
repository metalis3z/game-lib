-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersonalityCatalog = require(script.PersonalityCatalog)
local Rarity = require(ReplicatedStorage.Data.Rarity)
require(script.Types)

local function makeAnimation(v1) -- line 11
    local Animation = Instance.new("Animation")
    if not pcall(function() -- line 13 | captures: v1, Animation
            Animation.AnimationId = v1
        end) then
        warn((("Animation %* is not shared with this experience"):format(v1)))
    end
    return Animation
end

local v2 = {
    DisplayName = "Assets",
    EarningRate = 1,
    IndexSpeedReward = 0,
    DropWeight = 1,
    VisualOdds = 1,
    ModelWeight = 80,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({
        DisplayName = "Assets",
        Icon = "rbxassetid://116524274262912",
        GrowthTime = 60,
        WeightKg = 80
    })
}
local v3 = {}
local v4 = Instance.new("Animation")

if not pcall(function() -- line 36 | captures: v4
        v4.AnimationId = "rbxassetid://88190045758387"
    end) then
    warn("Animation rbxassetid://88190045758387 is not shared with this experience")
end
v3.Idle = v4
v2.Animations = table.freeze(v3)
v2.Rarity = Rarity.Rarities.Common
v2.BaseModelColor = Color3.fromRGB(86, 160, 61)

local v5 = {}
local v6 = {}

v6[1] = Color3.fromRGB(86, 160, 61)
v6[2] = 1

local v7 = table.freeze(v6)
local v8 = {}

v8[1] = Color3.fromRGB(96, 119, 82)
v8[2] = 1

local v9 = table.freeze(v8)
local v10 = {}

v10[1] = Color3.fromRGB(90, 100, 105)
v10[2] = 1

local v11 = table.freeze(v10)
local v12 = {}

v12[1] = Color3.fromRGB(93, 84, 67)
v12[2] = 1

local v13 = table.freeze(v12)
local v14 = {}

v14[1] = Color3.fromRGB(145, 122, 86)
v14[2] = 1
v5[1] = v7
v5[2] = v9
v5[3] = v11
v5[4] = v13
v5[5] = table.freeze(v14)
v2.PossibleModelColors = table.freeze(v5)

local v15 = table.freeze(v2)
local Configs = script.Configs
local v16 = {}

v16["Alabaster Whale"] = require(Configs["Alabaster Whale"])
v16["Alien Skeleton Boss"] = require(Configs["Alien Skeleton Boss"])
v16.Ankylosaurus = require(Configs.Ankylosaurus)
v16["Archdemon Dragon"] = require(Configs["Archdemon Dragon"])
v16["Ascended Vermilion Phoenix"] = require(Configs["Ascended Vermilion Phoenix"])
v16["Ash Gecko"] = require(Configs["Ash Gecko"])
v16["Baby Aurora Dragon"] = require(Configs["Baby Aurora Dragon"])
v16.Balrog = require(Configs.Balrog)
v16["Bananita Dolphinita"] = require(Configs["Bananita Dolphinita"])
v16.Basilisk = require(Configs.Basilisk)
v16.Bear = require(Configs.Bear)
v16["Belula Beluga"] = require(Configs["Belula Beluga"])
v16["Bomboclat Crocolat"] = require(Configs["Bomboclat Crocolat"])
v16.Bronto = require(Configs.Bronto)
v16["Brr Brr Patapim"] = require(Configs["Brr Brr Patapim"])
v16["Burrowing Owl"] = require(Configs["Burrowing Owl"])
v16.Camel = require(Configs.Camel)
v16.Catfish = require(Configs.Catfish)
v16["Cave Dragon"] = require(Configs["Cave Dragon"])
v16.Centapede = require(Configs.Centapede)
v16.Cerberus = require(Configs.Cerberus)
v16.Chicken = require(Configs.Chicken)
v16["Chillin Chilli"] = require(Configs["Chillin Chilli"])
v16.Chimpanzee = require(Configs.Chimpanzee)
v16["Colossal Mammoth"] = require(Configs["Colossal Mammoth"])
v16.Crane = require(Configs.Crane)
v16.Crocodile = require(Configs.Crocodile)
v16["Cyclops Gorilla"] = require(Configs["Cyclops Gorilla"])
v16.DeathstalkerScorpion = require(Configs.DeathstalkerScorpion)
v16["Demon Imp"] = require(Configs["Demon Imp"])
v16.DesertLark = require(Configs.DesertLark)
v16.Dodo = require(Configs.Dodo)
v16.Dog = require(Configs.Dog)
v16.Dragon = require(Configs.Dragon)
v16["Dream Axolotl"] = require(Configs["Dream Axolotl"])
v16["Drill Monster"] = require(Configs["Drill Monster"])
v16.Duckling = require(Configs.Duckling)
v16["El Maja"] = require(Configs["El Maja"])
v16["Ember Dragon"] = require(Configs["Ember Dragon"])
v16["Eternal Lunar Dragon"] = require(Configs["Eternal Lunar Dragon"])
v16.FennecFox = require(Configs.FennecFox)
v16["Finned Thresher"] = require(Configs["Finned Thresher"])
v16["Flaming Bull"] = require(Configs["Flaming Bull"])
v16.Frog = require(Configs.Frog)
v16["Galaxy Gecko"] = require(Configs["Galaxy Gecko"])
v16.Gargoyle = require(Configs.Gargoyle)
v16.Gorilla = require(Configs.Gorilla)
v16.Hellhound = require(Configs.Hellhound)
v16["Ice Dragon"] = require(Configs["Ice Dragon"])
v16.Irihorus = require(Configs.Irihorus)
v16.Jerboa = require(Configs.Jerboa)
v16.Kitsune = require(Configs.Kitsune)
v16.Koi = require(Configs.Koi)
v16.Kraken = require(Configs.Kraken)
v16["La Vacca Saturno Saturnita"] = require(Configs["La Vacca Saturno Saturnita"])
v16["Lava Iguana"] = require(Configs["Lava Iguana"])
v16["Lava frog"] = require(Configs["Lava frog"])
v16.Mammoth = require(Configs.Mammoth)
v16["Mangolini Parrochini"] = require(Configs["Mangolini Parrochini"])
v16["Mecha Scorpio"] = require(Configs["Mecha Scorpio"])
v16["Mecha Froggo"] = require(Configs["Mecha Froggo"])
v16["Mecha Crawler"] = require(Configs["Mecha Crawler"])
v16["Mecha Crocodon"] = require(Configs["Mecha Crocodon"])
v16["Mecha Krakenoid"] = require(Configs["Mecha Krakenoid"])
v16["Mecha Dreadscale"] = require(Configs["Mecha Dreadscale"])
v16.Minotaur = require(Configs.Minotaur)
v16["Mire Fox"] = require(Configs["Mire Fox"])
v16.Scorpio = require(Configs.Scorpio)
v16.Froggo = require(Configs.Froggo)
v16.Crawler = require(Configs.Crawler)
v16.Crocodon = require(Configs.Crocodon)
v16.Krakenoid = require(Configs.Krakenoid)
v16.Dreadscale = require(Configs.Dreadscale)
v16.Mosasaurus = require(Configs.Mosasaurus)
v16["Oni Tiger"] = require(Configs["Oni Tiger"])
v16["Orangutini Ananassini"] = require(Configs["Orangutini Ananassini"])
v16.Orca = require(Configs.Orca)
v16.Parrotfish = require(Configs.Parrotfish)
v16.Penguin = require(Configs.Penguin)
v16["Polar Bear"] = require(Configs["Polar Bear"])
v16.Pterodactyl = require(Configs.Pterodactyl)
v16.Raccoon = require(Configs.Raccoon)
v16.Rattlesnake = require(Configs.Rattlesnake)
v16["Red Panda"] = require(Configs["Red Panda"])
v16["Sabertooth Tiger"] = require(Configs["Sabertooth Tiger"])
v16.Salamander = require(Configs.Salamander)
v16["Sand Spider"] = require(Configs["Sand Spider"])
v16.ScorchedDragon = require(Configs.ScorchedDragon)
v16["Shadow Dragon"] = require(Configs["Shadow Dragon"])
v16["Snowy Owl"] = require(Configs["Snowy Owl"])
v16.Spider = require(Configs.Spider)
v16.Stag = require(Configs.Stag)
v16["Strawberry Elephant"] = require(Configs["Strawberry Elephant"])
v16.Swan = require(Configs.Swan)
v16.Swordfish = require(Configs.Swordfish)
v16.Tiger = require(Configs.Tiger)
v16["Tob Tobi Tob Tob"] = require(Configs["Tob Tobi Tob Tob"])
v16.Toucan = require(Configs.Toucan)
v16.Tralaledon = require(Configs.Tralaledon)
v16.Triceratops = require(Configs.Triceratops)
v16["Trulimero Trulicina"] = require(Configs["Trulimero Trulicina"])
v16["Tung Tung Sahur"] = require(Configs["Tung Tung Sahur"])
v16.Turtle = require(Configs.Turtle)
v16.TyrannosaurusRex = require(Configs.TyrannosaurusRex)
v16.Unicorn = require(Configs.Unicorn)
v16["Void Dragon"] = require(Configs["Void Dragon"])
v16.Walrus = require(Configs.Walrus)
v16.Warden = require(Configs.Warden)
v16["Whale Shark"] = require(Configs["Whale Shark"])
v16.Yeti = require(Configs.Yeti)
v16.Crab = require(Configs.Crab)
v16.Rhino = require(Configs.Rhino)
v16.Mantis = require(Configs.Mantis)
v16["Kaiju Spider"] = require(Configs["Kaiju Spider"])
v16.Shark = require(Configs.Shark)
v16["Blade Head"] = require(Configs["Blade Head"])
v16["King Kong"] = require(Configs["King Kong"])
v16.Godzilla = require(Configs.Godzilla)

local v17 = table.freeze(v16)
local v18 = {}
for v19, v20 in v17 do
    local _id = v20.Rarity._id
    local v21 = v18[_id]
    if v21 == nil then
        v21 = {}
        v18[_id] = v21
    end
    v21[v19] = v20
end
for v22, v23 in v18 do
    table.freeze(v23)
end
local v24 = table.freeze(v18)
local freeze = table.freeze
local v25 = {
    Directory = v17,
    ByRarity = v24,
    Personalities = PersonalityCatalog,
    BaseConfig = v15
}

function v25.AssetNameExists(v26) -- line 224 | captures: v17
    if v17[v26] == nil then
        return false, (("Asset name \"%*\" does not exist in the Assets directory."):format(v26))
    end
    return true
end

return freeze(v25)
