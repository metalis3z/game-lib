-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "The Stalker", 
    Quote = "\"RAHHHHHHHHHHHHHHHHHH\"", 
    Credits = "By: AndrewD0tWeb", 
    RenderImage = "rbxassetid://97768888", 
    Price = 1100, 
    Exclusive = true, 
    Health = 1100, 
    Speed = 5, 
    SprintSpeed = 30, 
    StaminaLoss = 10, 
    StaminaGain = 45, 
    MaxStamina = 60, 
    AttackDamage = 40, 
    SlashDamage = 35, 
    EnragedSlashDamage = 35, 
    SlashCooldown = 0.75, 
    EnragedStaminaCap = 25, 
    EnragedStaminaCapLerpTime = 6.5, 
    EnragedTime = 20, 
    EnragedSlashLungeForce = 85, 
    RageCooldown = 10, 
    Animations = {
		Idle = "rbxassetid://127637563741319", 
		Walk = "rbxassetid://96094736308321", 
		Run = "rbxassetid://99352065620518", 
		Stab1 = "rbxassetid://137371556112421", 
		Stab2 = "rbxassetid://99051500038334", 
		Scream = "rbxassetid://120911152117912", 
        Stunned = {
			Start = "rbxassetid://88494199417069", 
			Loop = "rbxassetid://127767808399549", 
			End = "rbxassetid://76094000588010"
        }, 
		Rage = "rbxassetid://125545362863444", 
		EnragedWalk = "rbxassetid://126781995954609", 
		EnragedRun = "rbxassetid://126781995954609", 
		EnragedIdle = "rbxassetid://137659508398465"
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://99809965759734", 
            "rbxassetid://79222929114377"
        }, 
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://127017993628155", 
                BPM = 72
            }, 
            [30] = {
                ID = "rbxassetid://124064215515361", 
                BPM = 72
            }, 
            [15] = {
                ID = "rbxassetid://113795434267266", 
                BPM = 72
            }, 
            [6] = {
                ID = "rbxassetid://100218181834917", 
                BPM = 72, 
                Chase = true
            }
        }, 
        Swing = "rbxassetid://12222216", 
        Hit = "rbxassetid://110759725172567", 
        EnragedStart = "rbxassetid://18564431123", 
        Enraged = "rbxassetid://94207556272752"
    }
};