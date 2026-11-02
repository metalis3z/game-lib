-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Combat Initiation", 
    Description = "\"This is the Jason enemy, notable for his geometric-style face mask and, um, free chainsaw. His AI is a single-celled organism.\"", 
    RenderImage = "rbxassetid://75804535809261", 
    Price = 1250, 
    Sounds = {
        EnragedStart = "rbxassetid://72985187238486", 
        Enraged = "rbxassetid://119717613419355", 
        EnragedEnd = "rbxassetid://132091893396922", 
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://138052857957479", 
                BPM = 170
            }, 
            [30] = {
                ID = "rbxassetid://114559760817398", 
                BPM = 170
            }, 
            [15] = {
                ID = "rbxassetid://115716280423434", 
                BPM = 170
            }, 
            [6] = {
                ID = "rbxassetid://76158140871806", 
                BPM = 170, 
                Chase = true
            }
        }
    }, 
    Animations = {
        Idle = "rbxassetid://72643713305179", 
        Walk = "rbxassetid://74882450248615", 
        Run = "rbxassetid://120516065665440", 
        EnragedIdle = "rbxassetid://96891812969669", 
        EnragedWalk = "rbxassetid://70772295413703"
    }
};