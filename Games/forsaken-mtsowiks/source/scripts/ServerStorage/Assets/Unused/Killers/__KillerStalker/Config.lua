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
		Idle = "rbxassetid://107126970221855", 
		Walk = "rbxassetid://133549629199668", 
		Run = "rbxassetid://100412548434240", 
		Stab1 = "rbxassetid://128317465123956", 
		Stab2 = "rbxassetid://134682464753960", 
		Scream = "rbxassetid://120346390001614", 
        Stunned = {
			Start = "rbxassetid://128657850698944", 
			Loop = "rbxassetid://71585324883199", 
			End = "rbxassetid://87812735792102"
        }, 
		Rage = "rbxassetid://78182010821308", 
		EnragedWalk = "rbxassetid://106808217688401", 
		EnragedRun = "rbxassetid://106808217688401", 
		EnragedIdle = "rbxassetid://114367529890014"
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