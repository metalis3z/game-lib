-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:07:59 2025 ]]
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
		ThemeID = "rbxassetid://107659828105652", 
        RoundTime = 77
    }, 
    Emotes = {
        Animations = {
            AnnhilationGuitar = {
                DisplayName = "Guitar", 
                Description = "Guitar", 
                AssetID = "rbxassetid://105650064942356", 
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
        Idle = "rbxassetid://100361444600211", 
        Walk = "rbxassetid://99922526906517", 
        Run = "rbxassetid://86586340009164", 
        Stunned = "rbxassetid://106512280413233", 
        Slash = "rbxassetid://93435625646632", 
        CorruptEnergy = "rbxassetid://130264633663102", 
        DigitalFootprint = "rbxassetid://116439941607183", 
        Execution = {
            KillerRig = "rbxassetid://126569708575208", 
            PlayerRig = "rbxassetid://96572621226908"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://76521548838727", 
            CameraRig = "rbxassetid://140712824833607"
        }
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [60] = {
				ID = "rbxassetid://128398374710629", 
                BPM = 90
            }, 
            [40] = {
				ID = "rbxassetid://102867270868374", 
                BPM = 90
            }, 
            [20] = {
				ID = "rbxassetid://80487078486520", 
                BPM = 90
            }, 
            [6] = {
				ID = "rbxassetid://86413331089426", 
                BPM = 90, 
                Chase = true
            }
        }, 
        Introduction = "rbxassetid://130684926926550"
    }
};