-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Herobrine", 
    Quote = "\"Heh, I quite like that name, you wouldn't mind if I take it?\"", 
    Credits = "By: AndrewD0tWeb", 
    RenderImage = "rbxassetid://112594187", 
    Price = 7, 
    Exclusive = true, 
    Health = 1100, 
    Speed = 8, 
    SprintSpeed = 24, 
    StaminaLoss = 10, 
    StaminaGain = 20, 
    MaxStamina = 500, 
    SeeYouDMG = 30, 
    FoundYouDMG = 40, 
    StopDMG = 25, 
    Error404 = 25, 
    StopSpeed = 90, 
    Error404Speed = 100, 
    Flick = 20, 
    PizzaDeliveryGuyLifetime = 30, 
    PizzaDeliveryGuyAttackRadius = 6, 
    PizzaDeliveryGuySpeed = math.random(20, 30), 
    PizzaDeliveryGuyHealth = 20, 
    PizzaDeliveryGuyDamage = 10, 
    SteveRig = script.SteveRig, 
    PizzaDeliveryAnimations = {
        Idle = "rbxassetid://130760415429140", 
        Walk = "rbxassetid://118769337542108", 
        Hit = "rbxassetid://96069121118113"
    }, 
    Animations = {
        Idle = "rbxassetid://130760415429140", 
        Walk = "rbxassetid://122131988592800", 
        Run = "rbxassetid://128464250966763", 
        BetterIdle = "rbxassetid://130760415429140", 
        BetterWalk = "rbxassetid://134585973499959", 
        BetterRun = "rbxassetid://89782403429100", 
        FoundYou = "rbxassetid://103328909801193", 
        SeeYou = "rbxassetid://96069121118113", 
        Stop = "rbxassetid://128650615641847", 
        Stunned = {
            Start = "rbxassetid://83408178546726", 
            Loop = "rbxassetid://103065427069152", 
            End = "rbxassetid://95560441400352"
		},
		["Introduction"] = {
			["CameraRig"] = "rbxassetid://72260148795208",
			["KillerRig"] = "rbxassetid://81999094850477"
		},
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://99809965759734", 
            "rbxassetid://79222929114377"
        }, 
        Swing = "rbxassetid://83336588073857", 
        Hit = "rbxassetid://133819228235701", 
        Hit2 = "rbxassetid://108809439689114", 
        Flick = "rbxassetid://121372260405316", 
        Stop = "rbxassetid://106841831666549", 
        TerrorRadiusThemes = {
            [45] = {
                ID = "rbxassetid://121292620130330", 
                BPM = 72
            }, 
            [30] = {
                ID = "rbxassetid://85477377169399", 
                BPM = 72
            }, 
            [15] = {
                ID = "rbxassetid://114692287462245", 
                BPM = 72
            }, 
            [6] = {
                ID = "rbxassetid://125611325245826", 
                BPM = 72, 
                Chase = true
            }
        }
	},
	IntroLighting = script.IntroLighting
};