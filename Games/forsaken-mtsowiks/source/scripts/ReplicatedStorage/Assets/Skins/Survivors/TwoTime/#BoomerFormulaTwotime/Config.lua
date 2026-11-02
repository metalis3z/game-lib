-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:10:19 2025 ]]
local v0 = {
    DisplayName = "Boomer Formula", 
    Description = "you're so old man", 
    Credits = "", 
    RenderImage = "rbxassetid://75010378731203", 
    Price = 400, 
    Exclusive = true, 
    Dev = true, 
    Health = 80, 
    Speed = 12, 
    Lives = 2, 
    NextLifeHealthDivisor = 2, 
    InvincibilityDuration = 1.5, 
    LastSurvivorMaxHealth = 110, 
    LastSurvivorHealthBonus = 50, 
    LifeChangedFX = script.FX, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    Animations = {}, 
    Sounds = {
        Respawn = "rbxassetid://84260460113659"
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://81896815825257", 
            Default = "rbxassetid://73483634925418", 
            Hurt = "rbxassetid://93421870784694", 
            Injured = "rbxassetid://133089396665213", 
            Dead = "rbxassetid://133611309054814", 
            Drinking = "rbxassetid://99335439385081"
        }, 
        [2] = {
            Happy = "rbxassetid://79565455816327", 
            Default = "rbxassetid://131136664195288", 
            Hurt = "rbxassetid://120830873592415", 
            Injured = "rbxassetid://104452353265078", 
            Dead = "rbxassetid://123221349342396", 
            Drinking = "rbxassetid://127552301758353"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "TWO TIME", 
        Text = "A fragile uhh\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "UNDYING DEVOTION", 
        Quote = "\"what have you done..?\" - \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136", 
        Text = "Upon receiving fatal damage, Two Time's appearance changes & they're reborn into a second life!\n" .. "In their second life, they only have <b>half</b> as much health (40) as they usually do (80).\n" .. "Upon activation:\n" .. " * Stamina is restored by 40%\n" .. " * All status effects are removed\n" .. (" * Two Time is made invincible for %* seconds \n"):format(v0.InvincibilityDuration) .. " * <b>Speed II</b> is applied for 6 seconds\n" .. " * <b>Weakness V</b> is applied for 12 seconds\n" .. ("Becoming the last survivor alive forces Two Time to enter into their second life, but they are given %* max HP, +%* HP healed, and do not suffer from <b>Weakness V</b>\n"):format(v0.LastSurvivorMaxHealth, v0.LastSurvivorHealthBonus)
    }
};
return v0;