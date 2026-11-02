-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
        isSensitiveTerrorRadius = true, 
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://129301543622452", 
                BPM = 170, 
                Volume = 0.6
            }, 
            [30] = {
                ID = "rbxassetid://79942603301248", 
                BPM = 170, 
                Volume = 0.6
            }, 
            [15] = {
                ID = "rbxassetid://124059239255607", 
                BPM = 170, 
                Volume = 0.6
            }, 
            [6] = {
                ID = "rbxassetid://90044331801233", 
                BPM = 170, 
                Chase = true, 
                Volume = 0.6
            }
        }
    }, 
    Animations = {
        Idle = "rbxassetid://130617133444179", 
        Walk = "rbxassetid://129641639423852", 
        Run = "rbxassetid://112125106001107", 
        EnragedIdle = "rbxassetid://111964393642274", 
        EnragedWalk = "rbxassetid://70772295413703"
    }
};