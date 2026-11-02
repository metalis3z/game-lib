-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Spiral", 
    Description = "Swirly swirly swirly swirl", 
    RenderImage = "rbxassetid://106665727250445", 
    Price = 600, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
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
            Happy = "", 
            Default = "", 
            Hurt = "", 
            Injured = "", 
            Dead = "", 
            Drinking = ""
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;