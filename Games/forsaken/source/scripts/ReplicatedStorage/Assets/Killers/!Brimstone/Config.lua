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
        Idle = "rbxassetid://130804965542077", 
        Walk = "rbxassetid://107447726449210", 
        Run = "rbxassetid://83887483979830", 
        InjuredIdle = "rbxassetid://130804965542077", 
        InjuredWalk = "rbxassetid://107447726449210", 
        InjuredRun = "rbxassetid://83887483979830", 
        Stunned = {
            Cancel = "rbxassetid://91679480631021"
        }, 
        Slash = "rbxassetid://103580993850153", 
        Dash = "rbxassetid://87624751662842", 
        Fire = "rbxassetid://123426668202345", 
        Combo = "rbxassetid://132054193746940", 
        ForsakenSlash = "rbxassetid://110270204308652", 
        Ashes = "rbxassetid://104905666581886"
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