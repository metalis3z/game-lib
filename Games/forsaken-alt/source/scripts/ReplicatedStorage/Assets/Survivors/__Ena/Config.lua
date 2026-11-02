-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Ena", 
    Quote = "\"Find the boss.\"", 
    Credits = "Nextix (Meow)", 
    Class = "Sentinel", 
	RenderImage = "rbxassetid://117896890210672", 
	Price = 120, 
	Exclusive = true, 
    Speed = 100, 
    HealthMin = 600, 
    HealthMax = 12000, 
    CameraShakeMagnitude = 1.5, 
    CameraShakeDuration = 0.4, 
    Expressions = {
        Happy = "", 
        Default = "", 
        Hurt = "", 
        Injured = "", 
        Dead = "", 
        Drinking = "", 
        Gambling = "", 
        Sad = "", 
        Uhoh = ""
    }, 
    Animations = {
    }, 
    Sounds = {

    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                'Gimme pizza !!'
            }, 
            BuildermanSentry = {
               'oooo nice sentry :3'
            }, 
            BuildermanDispenser = {
               'FAST FAST !'
            }, 
            DusekkarProtection = {
               'MAGIC ? WHAT IS WHAT ?'
            }
        }, 
        Thanks = {
            Regular = {
              'Thank you !'
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "THE BOSS.", 
        Text = "She has the quest.. What do I say the mission to find the boss.\n"
    }, 
    {
        Header = "STATS", 
		Text = "No difficulty, just find the boss !" .. ("Health: %*-%*\n"):format(v0.HealthMin, v0.HealthMax) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 24) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "ABILITIES"
    }
};
return v0;