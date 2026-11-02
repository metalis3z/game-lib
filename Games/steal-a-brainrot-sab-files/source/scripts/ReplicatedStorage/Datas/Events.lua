



local v1 = game:GetService("RunService")
local v2 = {
    ["KeyRate"] = 7200
}
local v3 = {
    ["10B Visits"] = {
        ["DisplayName"] = "10B Visits",
        ["Description"] = "Sky-drones swarm above as fireworks rain down in chaotic bursts, brainrots scatter beneath in wild jubilation.",
        ["Icon"] = "rbxassetid://134655415681926",
        ["Keys"] = 1
    },
    ["3 Roads"] = {
        ["DisplayName"] = "3 Roads",
        ["Description"] = "Three roads filled with brainrots with more paths more brainrots and more to collect than a single road.",
        ["Icon"] = "rbxassetid://110683846839545",
        ["Keys"] = 1,
        ["Duration"] = 900,
        ["New"] = true
    },
    ["Graveyard"] = {
        ["DisplayName"] = "Graveyard",
        ["Description"] = "Unearth cursed brainrots and candy corn from the haunted graveyard, where every shovel strike wakes the dead.",
        ["Icon"] = "rbxassetid://123115843719383",
        ["Keys"] = 1,
        ["New"] = true,
        ["LayoutOrder"] = -1,
        ["Duration"] = 300
    },
    ["Radioactive"] = {
        ["DisplayName"] = "Radioactive",
        ["Description"] = "Scavenge mutated brainrots inside the abandoned nuclear plant, where unstable reactors twist everything.",
        ["Icon"] = "rbxassetid://123850924447192",
        ["Keys"] = 1,
        ["New"] = true,
        ["LayoutOrder"] = -1,
        ["Duration"] = 900
    },
    ["Fishing"] = {
        ["DisplayName"] = "Fishing",
        ["Description"] = "Unearth cursed brainrots and candy corn from the haunted graveyard, where every shovel strike wakes the dead.",
        ["Icon"] = "rbxassetid://108816558045813",
        ["Keys"] = 1,
        ["New"] = true,
        ["LayoutOrder"] = -1,
        ["Duration"] = 900
    },
    ["Witching Hour"] = {
        ["DisplayName"] = "Witching Hour",
        ["Description"] = "At midnight the island becomes a tomb-lit graveyard, pumpkins glow and tombstones rise as dark magic strikes brainrots.",
        ["Icon"] = "rbxassetid://123964048606874",
        ["Keys"] = 1,
        ["New"] = false,
        ["LayoutOrder"] = -1,
        ["Duration"] = 300
    },
    ["YinYang"] = {
        ["DisplayName"] = "YinYang",
        ["Description"] = "Mutated brainrots balance darkness and light, twisting the battlefield into chaotic harmony under the Yin\226\128\147Yang surge.",
        ["Icon"] = "rbxassetid://92868288096441",
        ["Keys"] = 1,
        ["New"] = false,
        ["Duration"] = 900
    },
    ["Dul Dul Dul"] = {
        ["DisplayName"] = "Dul Dul Dul",
        ["Description"] = "Brainrots graduate en-masse! Dul Dul Dul appears, fitting ties and strutting models arc across the map in style.",
        ["Icon"] = "rbxassetid://103610037004911",
        ["Keys"] = 1,
        ["New"] = true,
        ["Duration"] = 180
    },
    ["Bubblegum"] = {
        ["DisplayName"] = "Bubblegum",
        ["Description"] = "Bubblegum dispensers pop up on roads, handing random brainrots a chewy bubblegum treat that sparks chaos.",
        ["Icon"] = "rbxassetid://100601425541874",
        ["Keys"] = 1,
        ["New"] = true,
        ["LayoutOrder"] = -1,
        ["Duration"] = 900
    },
    ["Trick or Treat"] = {
        ["DisplayName"] = "Trick or Treat",
        ["Description"] = "Bubblegum dispensers pop up on roads, handing random brainrots a chewy bubblegum treat that sparks chaos.",
        ["Icon"] = "rbxassetid://73015676943609",
        ["Keys"] = 1,
        ["New"] = true,
        ["DontShowOutsideStudio"] = true,
        ["LayoutOrder"] = -1,
        ["Duration"] = 300
    },
    ["Winter Hour"] = {
        ["DisplayName"] = "Winter Hour",
        ["Description"] = "Bubblegum dispensers pop up on roads, handing random brainrots a chewy bubblegum treat that sparks chaos.",
        ["Icon"] = "rbxassetid://88375043733582",
        ["Keys"] = 1,
        ["New"] = true,
        ["LayoutOrder"] = -1,
        ["Duration"] = 300
    },
    ["UFO"] = {
        ["DisplayName"] = "UFO",
        ["Description"] = "UFOs hover above and abduct brainrots, whisking them away in beams of chaotic, otherworldly energy.",
        ["Icon"] = "rbxassetid://110910518481052",
        ["Keys"] = 1,
        ["New"] = true,
        ["LayoutOrder"] = -1,
        ["Duration"] = 180
    },
    ["Crab Rave"] = {
        ["DisplayName"] = "Crab Rave",
        ["Description"] = "Beach-themed chaos erupts: dancing crabs scuttle across the map while brainrots and players alike begin to rave.",
        ["Icon"] = "rbxassetid://104964195846833",
        ["Keys"] = 1,
        ["New"] = false,
        ["Duration"] = 180
    },
    ["Rap Concert"] = {
        ["DisplayName"] = "Rap Concert",
        ["Description"] = "A giant disco ball descends, lights flash across the sky as a brainrot rap-anthem thunders and chaos follows the beat.",
        ["Icon"] = "rbxassetid://82620342632406",
        ["Keys"] = 1,
        ["New"] = false,
        ["Duration"] = 132
    },
    ["Rip My Granny"] = {
        ["DisplayName"] = "Rip My Granny",
        ["Description"] = "Flying grannies descend from the sky, hunting brainrots and transforming them into grannies in a chaotic aerial assault.",
        ["Icon"] = "rbxassetid://82620342632406",
        ["Keys"] = 1,
        ["New"] = false,
        ["Duration"] = 216
    },
    ["Rainbow"] = {
        ["DisplayName"] = "Rainbow",
        ["Description"] = "A brilliant rainbow arcs from cloud to road, shimmering with color as brainrots bask beneath its prismatic, radiant glow.",
        ["Icon"] = "rbxassetid://113083327432120",
        ["Keys"] = 1,
        ["New"] = false,
        ["Duration"] = 900
    },
    ["Sammyni Spyderini"] = {
        ["DisplayName"] = "Sammyni Spyderini",
        ["Description"] = "From sewer shadows the Spyderinios crawl, striking brainrots with venom, mutating limbs as webs blanket the battlefield.",
        ["Icon"] = "rbxassetid://117478971325696",
        ["Keys"] = 1,
        ["New"] = false,
        ["Duration"] = 180
    },
    ["Solar Flare"] = {
        ["DisplayName"] = "Solar Flare",
        ["Description"] = "A blinding solar flare pulses from the heavens, scorching brainrots and igniting the island into a fierce, searing blaze.",
        ["Icon"] = "rbxassetid://117317369032558",
        ["Keys"] = 1,
        ["New"] = true,
        ["Duration"] = 120
    },
    ["Bombardiro Crocodilo"] = {
        ["DisplayName"] = "Bombardiro Crocodilo",
        ["Description"] = "The airborne beast Crocodilo roars above, dropping bombs that shatter ground and fling brainrots into a fiery, shattered swamp.",
        ["Icon"] = "rbxassetid://97725744252608",
        ["Keys"] = 1,
        ["New"] = true,
        ["Duration"] = 180
    },
    ["Indonesia"] = {
        ["DisplayName"] = "Indonesia",
        ["Description"] = "Rain floods the island, boats rise amid chaos and brainrots struggle through surging tides in a soaked battlefield dance.",
        ["Icon"] = "rbxassetid://93350414974589",
        ["Keys"] = 1,
        ["New"] = true,
        ["Duration"] = 180
    },
    ["Meowl"] = {
        ["DisplayName"] = "Meowl",
        ["Description"] = "Silent owls swoop as brainrots are struck, feathers scatter and the Meowl trait spreads across the map in eerie precision.",
        ["Icon"] = "rbxassetid://114748221761549",
        ["Keys"] = 1,
        ["New"] = true,
        ["Duration"] = 180
    },
    ["Chicleteira Bicicleteira"] = {
        ["DisplayName"] = "Chicleteira Bicicleteira",
        ["Description"] = "Colorful machines roll beside the road, spraying sticky paint while brainrots march through trails of vibrant, chaotic color.",
        ["Icon"] = "rbxassetid://119591742504251",
        ["Keys"] = 1,
        ["New"] = false,
        ["Duration"] = 180
    },
    ["Phase 5: Sammy Snap"] = {
        ["DisplayName"] = "Phase 5: Sammy Snap",
        ["Description"] = "Sammy snaps and unleashes up to eight wild events in sequence, transforming the island into a frenzy of unexpected chaos.",
        ["Icon"] = "",
        ["Keys"] = 1
    },
    ["Rain"] = {
        ["DisplayName"] = "Rain",
        ["Description"] = "Storm clouds burst and rain pours relentlessly, brainrots drip beneath torrents as the ground quakes in watery assault.",
        ["Icon"] = "rbxassetid://78474194088770",
        ["Keys"] = 1,
        ["Duration"] = 300
    },
    ["Candy"] = {
        ["DisplayName"] = "Candy",
        ["Description"] = "Sweet skies glow pink as candy rains down and brainrots spill across the map in sugary, chaotic celebration and frenzy.",
        ["Icon"] = "rbxassetid://100760966396301",
        ["Keys"] = 1,
        ["Duration"] = 900
    },
    ["Bloodmoon"] = {
        ["DisplayName"] = "Bloodmoon",
        ["Description"] = "A crimson moon rises high, shadows stretch and brainrots glow under its omen as night turns to crimson terror.",
        ["Icon"] = "rbxassetid://76541861769347",
        ["Keys"] = 1,
        ["Duration"] = 900
    },
    ["Snow"] = {
        ["DisplayName"] = "Snow",
        ["Description"] = "Snow descends silently then brutally as brainrots freeze in place, and the map transforms into a vast white, biting wasteland.",
        ["Icon"] = "rbxassetid://83627475909869",
        ["Keys"] = 1,
        ["Duration"] = 300
    },
    ["Phase 4: Mygame43"] = {
        ["DisplayName"] = "Phase 4: Mygame43",
        ["Description"] = "Mygame43 awakens from slumber, orbs spark behind spawn and crackling lightning strikes brainrots in sudden, violent bursts.",
        ["Icon"] = "rbxassetid://139729696247144",
        ["Keys"] = 1
    },
    ["Extinct"] = {
        ["DisplayName"] = "Extinct",
        ["Description"] = "Fossils rise from earth as brainrots gain skeletal forms, frozen in time and weighed by the crushing inevitability of extinction.",
        ["Icon"] = "rbxassetid://89591838221335",
        ["Keys"] = 1,
        ["Duration"] = 180
    },
    ["Mexico"] = {
        ["DisplayName"] = "Mexico",
        ["Description"] = "Sombrero-cockroaches burst through alleys as Mexico erupts in riotous dance, brainrots collide in wild, chaotic force.",
        ["Icon"] = "rbxassetid://95128039793845",
        ["Keys"] = 1,
        ["New"] = true,
        ["Duration"] = 180
    },
    ["Strawberry"] = {
        ["DisplayName"] = "Strawberry",
        ["Description"] = "A crimson aura sweeps the land as the Strawberry Elephant awakens, sweetness floods the air then silence follows its steps.",
        ["Icon"] = "rbxassetid://84731118566493",
        ["Keys"] = 1,
        ["Duration"] = 900
    },
    ["Starfall"] = {
        ["DisplayName"] = "Starfall",
        ["Description"] = "Comets blaze across the sky, crashing in showers of light that scatter sparks and tremble the island beneath cosmic rain.",
        ["Icon"] = "rbxassetid://127455440418221",
        ["Keys"] = 1,
        ["Duration"] = 300
    },
    ["Glitch"] = {
        ["DisplayName"] = "Glitch",
        ["Description"] = "Reality fractures as a black-hole distortion rips open space, brainrots twist and flicker beneath the consuming glitch surge.",
        ["Icon"] = "rbxassetid://121332433272976",
        ["Keys"] = 1,
        ["Duration"] = 180
    },
    ["1x1x1x1"] = {
        ["DisplayName"] = "1x1x1x1",
        ["Description"] = "Reality fractures as a black-hole distortion rips open space, brainrots twist and flicker beneath the consuming glitch surge.",
        ["Icon"] = "rbxassetid://121332433272976",
        ["Keys"] = 1,
        ["LayoutOrder"] = -2,
        ["New"] = true,
        ["Duration"] = 600
    },
    ["4th of July"] = {
        ["DisplayName"] = "4th of July",
        ["Description"] = "Fireworks rain in wild bursts, brainrots light up and explosions echo across the conveyor in red, white and blue chaos.",
        ["Icon"] = "rbxassetid://121100427764858",
        ["Keys"] = 1,
        ["Duration"] = 180
    },
    ["Brazil"] = {
        ["DisplayName"] = "Brazil",
        ["Description"] = "Samba storms rage across the island as carnival lights flash and colors swirl in rhythmic, ecstatic, kaleidoscopic chaos.",
        ["Icon"] = "rbxassetid://75650816341229",
        ["Keys"] = 1,
        ["Duration"] = 180
    },
    ["Galaxy"] = {
        ["DisplayName"] = "Galaxy",
        ["Description"] = "Nebulas swirl and stars streak the sky as asteroids crash in cosmic symphony, brainrots glow with vast, radiant energy.",
        ["Icon"] = "rbxassetid://108195257551722",
        ["Keys"] = 1,
        ["Duration"] = 900
    },
    ["La Vacca Saturno Saturnita"] = {
        ["DisplayName"] = "La Vacca Saturno Saturnita",
        ["Description"] = "Three cosmic cows spin and ascend, igniting a meteor shower that lights up the sky in absurd celestial spectacle.",
        ["Icon"] = "rbxassetid://99181785766598",
        ["Keys"] = 1,
        ["Duration"] = 600
    },
    ["Molten"] = {
        ["DisplayName"] = "Molten",
        ["Description"] = "Magma erupts and lava geysers burst, the sky ignites in fiery orange and brainrots scramble across a burning, molten wasteland.",
        ["Icon"] = "rbxassetid://75623603340010",
        ["Keys"] = 1,
        ["Duration"] = 900
    },
    ["Raining Tacos"] = {
        ["DisplayName"] = "Raining Tacos",
        ["Description"] = "Tacos tumble from the sky in cheesy, crunchy waves, the island splattered in salsa-laden chaos as brainrots scatter.",
        ["Icon"] = "rbxassetid://89041930759464",
        ["Keys"] = 1,
        ["Duration"] = 180
    },
    ["Nyan Cats"] = {
        ["DisplayName"] = "Nyan Cats",
        ["Description"] = "Rainbow cats streak across the sky leaving trails of bright color and chaos, brainrots caught in the wild feline storm.",
        ["Icon"] = "rbxassetid://104229924295526",
        ["Keys"] = 1,
        ["Duration"] = 300
    },
    ["Water"] = {
        ["DisplayName"] = "Water",
        ["Description"] = "Torrents gush across the island, Orcalero and Tralalero swim through waves and drench everything in rushing, wild splashes.",
        ["Icon"] = "rbxassetid://104985313532149",
        ["Keys"] = 1,
        ["Duration"] = 300
    }
}
v2.Events = v3
if not v1:IsStudio() then
    local v4 = {}
    for v5, v6 in pairs(v2.Events) do
        if not v6.DontShowOutsideStudio then
            v4[v5] = v6
        end
    end
    v2.Events = v4
end
if game.PlaceId ~= 114477861598229 then
    local v7 = {}
    for v8, v9 in pairs(v2.Events) do
        if not v9.DontShowOutsideTestPlace then
            v7[v8] = v9
        end
    end
    v2.Events = v7
end
local v10 = {}
for v11, v12 in pairs(v2.Events) do
    if not v12.Disabled then
        v10[v11] = v12
    end
end
v2.Events = v10
return v2