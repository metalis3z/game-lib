-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Slenderman", 
    Quote = "*really loud static noise*", 
    Credits = "idk", 
    RenderImage = "rbxassetid://120175686066490", 
    Price = 500, 
    Exclusive = true, 
    Health = 500, 
    Speed = 4, 
    SprintSpeed = 8, 
    StaminaLoss = 1.5, 
    StaminaGain = 1, 
    MaxStamina = 15, 
    InvisibleSpeed = 32, 
    InvisibleSprintSpeed = 64, 
    InvisibleStaminaLoss = 0.75, 
    InvisibleStaminaGain = 0.75, 
    StaticRange = 60, 
    DamageFormula = function(v0) --[[ Line: 30 ]] --[[ Name: DamageFormula ]]
        return (60 - v0) / 60;
    end, 
    Animations = {
		Idle = "rbxassetid://99985501757727", 
		Walk = "rbxassetid://84612721018929", 
		Run = "rbxassetid://84612721018929"
    }, 
    Sounds = {}
};