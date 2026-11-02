-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:07:44 2025 ]]
return {
    DisplayName = "Combat Initiation", 
    Description = "\"This is the Jason enemy, notable for his geometric-style face mask and, um, free chainsaw. His AI is a single-celled organism.\"", 
    RenderImage = "rbxassetid://135796883568004", 
    Price = 1250, 
    CollabInfo = "CombatInitiation", 
    Sounds = {
        EnragedStart = "rbxassetid://72985187238486", 
        Enraged = "rbxassetid://119717613419355", 
        EnragedEnd = "rbxassetid://132091893396922", 
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://129301543622452", 
                BPM = 170
            }, 
            [30] = {
                ID = "rbxassetid://79942603301248", 
                BPM = 170
            }, 
            [15] = {
                ID = "rbxassetid://124059239255607", 
                BPM = 170
            }, 
            [6] = {
                ID = "rbxassetid://90044331801233", 
                BPM = 170, 
                Chase = true
            }
        }
    }, 
    Animations = {
        Idle = "rbxassetid://75809946581956", 
        Walk = "rbxassetid://104179749090665", 
        Run = "rbxassetid://121692197638647", 
        EnragedIdle = "rbxassetid://133933112551369", 
        EnragedWalk = "rbxassetid://122584096559977"
    }
};