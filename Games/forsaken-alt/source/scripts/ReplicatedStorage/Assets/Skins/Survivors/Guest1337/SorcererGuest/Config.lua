-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function _() --[[ Line: 1 ]] --[[ Name: isBlackflash ]]
    return math.random(1, 125) == 1;
end;
return {
    DisplayName = "Sorcerer", 
    RenderImage = "rbxassetid://77646567346932", 
    Price = 2000, 
    Exclusive = true, 
    ParryKnockback = math.random(1, 125) == 1 and 25 or 10, 
    ParryDamage = math.random(1, 125) == 1 and 87.5 or 35, 
    Animations = {
        Block = "rbxassetid://72722244508749", 
        Punch = "rbxassetid://78488127886114", 
        ParryPunch = "rbxassetid://125943183450007", 
        Charge = "rbxassetid://139998635421401"
    }, 
    Sounds = {
        BlockStart = "rbxassetid://8028421882", 
        BlockSuccess = "rbxassetid://132298811847315", 
        PunchWindup = math.random(1, 125) == 1 and "rbxassetid://92831180929659" or "rbxassetid://81976396729343", 
        Punch = "rbxassetid://122560631718612", 
        Parry = math.random(1, 125) == 1 and "rbxassetid://112081768119093" or "rbxassetid://131523151782623", 
        ChargingStart = "rbxassetid://126814334954192", 
        ChargingHit = "rbxassetid://99002580763000", 
        ChargingCollide = "rbxassetid://9113225979", 
        ChargingTimeout = "rbxassetid://127506392754179"
    }
};