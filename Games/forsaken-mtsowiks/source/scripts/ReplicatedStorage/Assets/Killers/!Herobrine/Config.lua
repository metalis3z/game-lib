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
        Idle = "rbxassetid://108488385501981", 
        Walk = "rbxassetid://130415843385638", 
        Hit = "rbxassetid://136276680441792"
    }, 
    Animations = {
        Idle = "rbxassetid://108488385501981", 
        Walk = "rbxassetid://118622638195798", 
        Run = "rbxassetid://100078527555841", 
        BetterIdle = "rbxassetid://108488385501981", 
        BetterWalk = "rbxassetid://125204053209359", 
        BetterRun = "rbxassetid://130799924394507", 
        FoundYou = "rbxassetid://122219734226073", 
        SeeYou = "rbxassetid://136276680441792", 
        Stop = "rbxassetid://103480010145870", 
        Stunned = {
            Start = "rbxassetid://126052089339245", 
            Loop = "rbxassetid://79538322298451", 
            End = "rbxassetid://86871032274011"
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
    }
};