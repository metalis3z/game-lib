-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "King", 
    Quote = "\"Through an iron fist, they redefined the term King to their favor.\"", 
    Credits = "Made By: BruhMoment", 
    RenderImage = "rbxassetid://75410738713127", 
    Price = 999999, 
    Exclusive = true, 
    Health = 5000, 
    Speed = 16, 
    HipHeight = 13.5, 
    CollisionHitbox = script.CollisionHitbox, 
    QueryHitbox = script.QueryHitbox, 
    SprintSpeed = 50, 
    StaminaLoss = 10, 
    StaminaGain = 2, 
    MaxStamina = 25, 
    Animations = {
		Idle = "rbxassetid://74765259553538", 
		Walk = "rbxassetid://87321264979246", 
		Run = "rbxassetid://90141540875829", 
		Slash = "rbxassetid://82800151568218", 
        Introduction = {
			KillerRig = "rbxassetid://80749677948422", 
			CameraRig = "rbxassetid://71936750856916"
        }
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://106029794447542", 
            "rbxassetid://96762479007469"
        }, 
        Introduction = "rbxassetid://72840035562748"
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "KING", 
        Text = "i love combat initiation man"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\133\n" .. ("Health: %*\n"):format(v0.Health) .. ("Regular Speed: %*\n"):format(v0.Speed) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed) .. ("Max Stamina: %*\n"):format(v0.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://93874368032471", 
        Header = "WIP", 
        Quote = "\"Let's play again sometime!\" - c00lkidd", 
        Text = "Cooldown: 2s\n" .. ("Damage: %*\n"):format(v0.AttackDamage) .. "<font color=\"rgb(200,20,20)\">c00lkidd</font> does a basic punch. That's all.\n"
    }
};
return v0;