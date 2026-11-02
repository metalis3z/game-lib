-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:07:56 2025 ]]
return {
    DisplayName = "Living Legend", 
    Description = "LEGENDS. NEVER. DIE.", 
    RenderImage = "rbxassetid://113104275485571", 
    Price = 3404, 
    Exclusive = false, 
    Spike = script.Spike, 
    Shadow = script.Shadow, 
    Trail = script.Trail, 
    SpikeNumbersColor = Color3.fromRGB(55, 255, 0), 
    IntroTextColor = Color3.fromRGB(0, 255, 0), 
    IntroText = "LEGENDS NEVER DIE", 
    AtmosphereColor = Color3.fromRGB(0, 135, 0), 
    AtmosphereDecay = Color3.fromRGB(0, 255, 0), 
    OutroTintColor = Color3.fromRGB(99, 57, 109), 
    useClouds = false, 
    IntroLighting = script.Lighting, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {
				ID = "rbxassetid://70417996981165", 
                BPM = 200
            }, 
            [40] = {
				ID = "rbxassetid://94210855100470", 
                BPM = 200
            }, 
            [20] = {
				ID = "rbxassetid://94210855100470", 
                BPM = 200
            }, 
            [6] = {
				ID = "rbxassetid://110833673190321", 
                BPM = 200, 
                Chase = true
            }
        }, 
        Ambience = "rbxassetid://119613018129779", 
        Footsteps = {
            "rbxassetid://124501447011298", 
            "rbxassetid://135481467913737"
        }, 
        Swing = "rbxassetid://81702359653578", 
        CorruptEnergy = "rbxassetid://129924298101197", 
        CorruptEnergySummon = "rbxassetid://88219591246801", 
        CorruptEnergyDesummon = "rbxassetid://100988339369548", 
        StunEnded = "rbxassetid://102212746943245", 
        DigitalFootprint = "rbxassetid://104361623352635", 
        DigitalFootprintAmbience = "rbxassetid://116661316719698", 
        ["404Error"] = {
            SoundId = "rbxassetid://88739574168742", 
            Volume = 2
        }, 
        ["404ErrorError"] = {
            SoundId = "rbxassetid://133034544766599", 
            Volume = 2
        }
    }
};