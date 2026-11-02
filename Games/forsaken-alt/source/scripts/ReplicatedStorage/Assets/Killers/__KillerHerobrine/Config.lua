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
		Idle = "rbxassetid://90917401310067", 
		Walk = "rbxassetid://85919129258802", 
		Hit = "rbxassetid://139674424931203"
    }, 
    Animations = {
		Idle = "rbxassetid://90917401310067", 
		Walk = "rbxassetid://85919129258802", 
		Run = "rbxassetid://139674424931203", 
        BetterIdle = "rbxassetid://121427501844120", 
        BetterWalk = "rbxassetid://136392249604185", 
        BetterRun = "rbxassetid://97569819625046", 
		FoundYou = "rbxassetid://89868200150226", 
		SeeYou = "rbxassetid://117406310973959", 
		Stop = "rbxassetid://86696459740276", 
        Stunned = {
            Start = "rbxassetid://71318840517357", 
            Loop = "rbxassetid://84521781438011", 
            End = "rbxassetid://118264066689908"
        }
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
            [30] = {
                ID = "rbxassetid://126022085662213", 
                BPM = 120.7, 
                Chase = true
            }
        }
    }
};