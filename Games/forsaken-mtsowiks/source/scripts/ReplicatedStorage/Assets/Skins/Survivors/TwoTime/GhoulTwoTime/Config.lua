-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:10:13 2025 ]]
return {
    DisplayName = "Ghoul", 
    Description = "Stuck in a web of cables and fire...", 
    RenderImage = "rbxassetid://139702189496311", 
    Price = 1500, 
    Exclusive = false, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    DaggerTemplate = script.GhostFire, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://90729100601725", 
            Default = "rbxassetid://81672144235651", 
            Hurt = "rbxassetid://77248769447531", 
            Injured = "rbxassetid://139863095909468", 
            Dead = "rbxassetid://98422778287695", 
            Drinking = "rbxassetid://117546281646839"
        }, 
        [2] = {
            Happy = "rbxassetid://78151692674483", 
            Default = "rbxassetid://131339191022922", 
            Hurt = "rbxassetid://88806767376302", 
            Injured = "rbxassetid://131674991644564", 
            Dead = "rbxassetid://124669946878929", 
            Drinking = "rbxassetid://130793877143807"
        }
    }
};