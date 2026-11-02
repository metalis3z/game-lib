-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Annihilation", 
    Description = "gaminnggggggg.", 
    RenderImage = "rbxassetid://86869607861662", 
    Price = 2000, 
    Exclusive = false, 
    CollabInfo = "JSAB", 
    Spike = script.Spike, 
    Shadow = script.Shadow, 
    Trail = script.Trail, 
    OutroDummy = script.Friend, 
    Relations = {
        "FriendElliot"
    }, 
    LastManStandingEmotionalData = {
        ThemeID = "rbxassetid://90022574613230", 
        RoundTime = 77
    }, 
    Emotes = {
        Animations = {
            AnnhilationGuitar = {
                DisplayName = "Guitar", 
                Description = "Guitar", 
                AssetID = "rbxassetid://90965534550984", 
                SFX = "rbxassetid://101986282901846", 
                SFXProperties = {
                    Looped = false
                }, 
                Created = function(v0) --[[ Line: 34 ]] --[[ Name: Created ]]
                    local l_Character_0 = v0.Character;
                    if l_Character_0 then
                        local l_Guitar_0 = l_Character_0:FindFirstChild("Guitar");
                        if l_Guitar_0 then
                            l_Guitar_0.Transparency = 0;
                        end;
                    end;
                end, 
                Destroyed = function(v3) --[[ Line: 42 ]] --[[ Name: Destroyed ]]
                    local l_Character_1 = v3.Character;
                    if l_Character_1 then
                        local l_Guitar_1 = l_Character_1:FindFirstChild("Guitar");
                        if l_Guitar_1 then
                            l_Guitar_1.Transparency = 1;
                        end;
                    end;
                end
            }
        }
    }, 
    Animations = {
        Idle = "rbxassetid://129149654072562", 
        Walk = "rbxassetid://86859028134871", 
        Run = "rbxassetid://90809758089696", 
        Stunned = "rbxassetid://135197705320102", 
        Slash = "rbxassetid://105587945474055", 
        CorruptEnergy = "rbxassetid://136768946721735", 
        DigitalFootprint = "rbxassetid://114346019103723", 
        Execution = {
            KillerRig = "rbxassetid://90615427368248", 
            PlayerRig = "rbxassetid://95716232259748"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://101111740742444", 
            CameraRig = "rbxassetid://124127227342544"
        }
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://111767637350170", 
                BPM = 90
            }, 
            [40] = {
                ID = "rbxassetid://126430999676388", 
                BPM = 90
            }, 
            [20] = {
                ID = "rbxassetid://75170611478832", 
                BPM = 90
            }, 
            [6] = {
                ID = "rbxassetid://131883067723721", 
                BPM = 90, 
                Chase = true
            }
        }, 
        Introduction = "rbxassetid://130684926926550"
    }
};