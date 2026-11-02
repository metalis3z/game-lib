-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:10:13 2025 ]]
local v0 = {
    DisplayName = "Boss", 
    Description = "Now they're completely non-canon!", 
    RenderImage = "rbxassetid://138013524699143", 
    Price = 750, 
    LifeAppearances = {
        [1] = script.Life1, 
        [2] = script.Life2
    }
};
Sounds = {
    Respawn = "rbxassetid://139764118536184"
};
v0.ExpressionsTable = {
    [1] = {
        Happy = "rbxassetid://132008979879784", 
        Default = "rbxassetid://116503377801902", 
        Hurt = "rbxassetid://111233810334889", 
        Injured = "rbxassetid://134096798241991", 
        Dead = "rbxassetid://112520501901724", 
        Drinking = "rbxassetid://75473965449746"
    }, 
    [2] = {
        Happy = "rbxassetid://99057720834769", 
        Default = "rbxassetid://112800782813581", 
        Hurt = "rbxassetid://135443428492623", 
        Injured = "rbxassetid://132342323797254", 
        Dead = "rbxassetid://82602923999115", 
        Drinking = "rbxassetid://73958195721400"
    }
};
return v0;