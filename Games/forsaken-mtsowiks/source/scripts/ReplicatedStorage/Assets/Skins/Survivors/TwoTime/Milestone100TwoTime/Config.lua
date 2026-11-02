-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:10:05 2025 ]]
local v0 = {
    DisplayName = "Milestone IV", 
    Description = "\"im sorry.\"", 
    RenderImage = "rbxassetid://101877729013693", 
    Price = -8, 
    Exclusive = true, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }, 
    ExpressionsTable = {
        [1] = {
            Happy = "rbxassetid://100081868146027", 
            Default = "rbxassetid://122997300217527", 
            Hurt = "rbxassetid://96068134201022", 
            Injured = "rbxassetid://120755463690929", 
            Dead = "rbxassetid://103821172765374", 
            Drinking = "rbxassetid://102870335831035"
        }, 
        [2] = {
            Happy = "rbxassetid://90557137985216", 
            Default = "rbxassetid://105800773101443", 
            Hurt = "rbxassetid://80889323166477", 
            Injured = "rbxassetid://127648530379756", 
            Dead = "rbxassetid://81402891638823", 
            Drinking = "rbxassetid://128336080486102"
        }
    }
};
v0.Expressions = v0.ExpressionsTable[1];
return v0;