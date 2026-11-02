-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:19 2025 ]]
return {
    DisplayName = "Mystic Slasher v2", 
    Description = "\"Mystic Slasher v2 appears as the first major boss of the TEST.EXE campaign. He is also known for being mystical.\"", 
    RenderImage = "rbxassetid://18310121871", 
    Price = 100000, 
    Exclusive = true, 
    CollabInfo = "CombatInitiation", 
    Sounds = {
        EnragedStart = "rbxassetid://72985187238486", 
        Enraged = "rbxassetid://119717613419355", 
        EnragedEnd = "rbxassetid://132091893396922", 
        GashingWoundHit = "rbxassetid://105158381336980", 
        GashingWoundSwing = "rbxassetid://80587845277702", 
        GashingWoundMiss = "rbxassetid://137234963819047", 
        Execution = "rbxassetid://133920638799807", 
        isSensitiveTerrorRadius = true, 
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
        EnragedWalk = "rbxassetid://122584096559977", 
        Execution = {
            KillerRig = "rbxassetid://117338054248666", 
            PlayerRig = "rbxassetid://108738673160369", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 3.75)
        }
    }
};