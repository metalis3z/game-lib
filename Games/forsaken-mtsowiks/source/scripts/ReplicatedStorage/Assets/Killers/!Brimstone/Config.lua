-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_workspace_Attribute_0 = workspace:GetAttribute("JohnDoeSpecialDay");
return {
    DisplayName = "BRIMSTONE", 
    Quote = "Genesis 19:24", 
    Credits = "Made by: me", 
    RenderImage = l_workspace_Attribute_0 and "rbxassetid://131855624243843" or "rbxassetid://109027143315601", 
    Price = 0, 
    Exclusive = true, 
    Health = 14100, 
    Speed = 10, 
    SprintSpeed = 28, 
    StaminaLoss = 1, 
    StaminaGain = 10, 
    MaxStamina = 115, 
    SlashDamage = 20, 
    LastManStandingData = {
        ThemeID = "rbxassetid://138740386053898", 
        ThemeProperties = {
            Volume = 0.75
        }, 
        RoundTime = 74
    }, 
    Trail = script.Trail, 
    WindSlashProjectile = script.WindSlashProjectile, 
    TrailLength = 25, 
    UnstoppableDuration = 0.5, 
    Animations = {
        Idle = "rbxassetid://119025386218656", 
        Walk = "rbxassetid://133160834349034", 
        Run = "rbxassetid://89316524918795", 
        InjuredIdle = "rbxassetid://119025386218656", 
        InjuredWalk = "rbxassetid://133160834349034", 
        InjuredRun = "rbxassetid://89316524918795", 
        Stunned = {
            Cancel = "rbxassetid://128718975706582"
        }, 
        Slash = "rbxassetid://79829480617735", 
        Dash = "rbxassetid://133149359889866", 
        Fire = "rbxassetid://118086219920352", 
        Combo = "rbxassetid://132054193746940", 
        ForsakenSlash = "rbxassetid://123582644369464", 
        Ashes = "rbxassetid://137407254003780"
    }, 
    Sounds = {
        Ambience = "rbxassetid://94207556272752", 
        Footsteps = {
            "rbxassetid://126872882914955", 
            "rbxassetid://81544212102472"
        }, 
        TerrorRadiusThemes = {
            [100] = {
                ID = "rbxassetid://83496790534252", 
                BPM = 100, 
                Chase = true, 
                Volume = 1.5
            }
        }
    }
};