-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Punk", 
    Description = "She said seeya later they/them.", 
    RenderImage = "rbxassetid://100774939749784", 
    Price = 600, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    ExpressionsTable = {
        [2] = {
            Happy = "rbxassetid://89925715283845", 
            Default = "rbxassetid://138471786190385", 
            Hurt = "rbxassetid://102869159286161", 
            Injured = "rbxassetid://99098730961393", 
            Dead = "rbxassetid://106095834261846", 
            Drinking = "rbxassetid://124552550885303"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;