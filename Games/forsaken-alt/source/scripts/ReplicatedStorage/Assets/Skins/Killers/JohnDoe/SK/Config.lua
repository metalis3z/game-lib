-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Sir Kadee", 
    Description = "he likes to mess up around and stuff", 
    RenderImage = "rbxassetid://119506885077177", 
    Price = 9999999, 
    Exclusive = true, 
    Animations = {
        Idle = "rbxassetid://92922236590270", 
        Walk = "rbxassetid://134454012130932", 
        Run = "rbxassetid://100351974985081", 
        Stunned = "rbxassetid://74204930667265", 
        Execution = {
            KillerRig = "rbxassetid://90233016623020", 
            PlayerRig = "rbxassetid://127002697448590", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 3)
        }, 
        Slash = "rbxassetid://109275094000102,rbxassetid://117730139864273", 
        CorruptEnergy = "rbxassetid://103704520260057", 
        DigitalFootprint = "rbxassetid://73204424721930"
    }, 
    Sounds = {
        Ambience = "rbxassetid://94207556272752", 
        Footsteps = {
            "rbxassetid://126872882914955", 
            "rbxassetid://81544212102472"
        }, 
        TerrorRadiusThemes = {
            [60] = {
                ID = "rbxassetid://139214890630385", 
                BPM = 105
            }, 
            [37.5] = {
                ID = "rbxassetid://109439521238878", 
                BPM = 105
            }, 
            [15] = {
                ID = "rbxassetid://109439521238878", 
                BPM = 105
            }, 
            [6] = {
                ID = "rbxassetid://133253385157738", 
                BPM = 105, 
                Chase = true
            }
        }, 
        CorruptEnergy = "rbxassetid://109525294317144", 
        CorruptEnergySummon = "rbxassetid://111388466508150", 
        CorruptEnergyDesummon = "rbxassetid://112806895489970", 
        DigitalFootprint = "rbxassetid://84544783681866", 
        ["404Error"] = "rbxassetid://125897321587591", 
        ["404ErrorError"] = "rbxassetid://90307135163105", 
        Execution = "rbxassetid://91088178573563", 
        Swing = "rbxassetid://140242176732868", 
        Hit = "rbxassetid://90819435118493", 
        StunEnded = "rbxassetid://121488248566083"
    }, 
    Spike = script.Spike, 
    Shadow = script.Shadow, 
    Trail = script.Trail
};