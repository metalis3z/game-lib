-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Mystic Jason", 
    Description = "\"Mystic Jason appears as the first major boss of the TEST.EXE campaign. He is also known for being mystical.\"", 
    RenderImage = "rbxassetid://75804535809261", 
    Price = 100000, 
    Exclusive = true, 
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
        Idle = "rbxassetid://86392823174336", 
        Walk = "rbxassetid://71824861276938", 
        Run = "rbxassetid://119287372734345", 
        EnragedIdle = "rbxassetid://82982261014563", 
        EnragedWalk = "rbxassetid://98255165799548"
    }
};