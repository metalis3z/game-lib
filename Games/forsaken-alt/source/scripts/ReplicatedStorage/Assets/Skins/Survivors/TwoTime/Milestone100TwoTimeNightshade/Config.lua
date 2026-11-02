-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Nightshade", 
    Description = "It\226\128\153s not that I can\226\128\153t remember, it\226\128\153s that I don\226\128\153t want to remember. ", 
    RenderImage = "rbxassetid://84646339458063", 
    Price = 0, 
    Exclusive = true, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://107373406815990", 
            Default = "rbxassetid://78529874926911", 
            Hurt = "rbxassetid://94147533931285", 
            Injured = "rbxassetid://94947623246188", 
            Dead = "rbxassetid://120354269801368", 
            Drinking = "rbxassetid://78003037092465"
        }, 
        [2] = {
            Happy = "rbxassetid://91814717165580", 
            Default = "rbxassetid://119334962407174", 
            Hurt = "rbxassetid://123297604838681", 
            Injured = "rbxassetid://131670668989528", 
            Dead = "rbxassetid://119958305378369", 
            Drinking = "rbxassetid://76654746338543"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;