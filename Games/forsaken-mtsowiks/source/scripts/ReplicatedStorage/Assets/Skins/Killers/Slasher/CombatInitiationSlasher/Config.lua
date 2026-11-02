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
				ID = "rbxassetid://131958744666935", 
                BPM = 170, 
                Volume = 0.6
            }, 
            [30] = {
				ID = "rbxassetid://96174967439445", 
                BPM = 170, 
                Volume = 0.6
            }, 
            [15] = {
				ID = "rbxassetid://76586957419172", 
                BPM = 170, 
                Volume = 0.6
            }, 
            [6] = {
				ID = "rbxassetid://105501179646221", 
				ID = "rbxassetid://105501179646221", 
                BPM = 170, 
                Chase = true, 
                Volume = 0.6
            }
        }
    }, 
    Animations = {
        Idle = "rbxassetid://86392823174336", 
        Walk = "rbxassetid://71824861276938", 
        Run = "rbxassetid://119287372734345", 
        EnragedIdle = "rbxassetid://82982261014563", 
        EnragedWalk = "rbxassetid://98255165799548"
    }
};