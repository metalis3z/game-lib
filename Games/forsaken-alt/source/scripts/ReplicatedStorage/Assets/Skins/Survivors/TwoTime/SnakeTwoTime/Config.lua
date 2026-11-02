-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Snake", 
    Description = "A strong man doesn't need to read the future, he makes his own.", 
    RenderImage = "rbxassetid://124535764537598", 
    Price = 900, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://92317200600526", 
            Default = "rbxassetid://119681176655449", 
            Hurt = "rbxassetid://86191620969470", 
            Injured = "rbxassetid://102115140831237", 
            Dead = "rbxassetid://86191620969470", 
            Drinking = "rbxassetid://127683480058548"
        }, 
        [2] = {
            Happy = "rbxassetid://130746088405205", 
            Default = "rbxassetid://98799720181504", 
            Hurt = "rbxassetid://81559636389968", 
            Injured = "rbxassetid://81579773553147", 
            Dead = "rbxassetid://110274952490633", 
            Drinking = "rbxassetid://73776620963624"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;