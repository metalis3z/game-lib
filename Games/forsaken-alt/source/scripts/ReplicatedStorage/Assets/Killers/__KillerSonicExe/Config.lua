-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Sonic.EXE", 
    Quote = "I AM GOD!!", 
    Credits = "Made By: sobbe & BruhMoment", 
    RenderImage = "rbxassetid://126745088439226", 
    Price = 400, 
    Exclusive = true, 
    Health = 900, 
    Speed = 6.5, 
    HipHeight = 2, 
    SprintSpeed = 34, 
    StaminaLoss = 10, 
    StaminaGain = 20, 
    MaxStamina = 110, 
    AttackDamage = 17.5, 
    GodspeedSpeedMultiplier = 25, 
    GodspeedTimeout = 16, 
    Animations = {
		Idle = "rbxassetid://82062474170598", 
		Walk = "rbxassetid://115388343395572", 
		Run = "rbxassetid://86812757482093", 
        Introduction = {
			KillerRig = "rbxassetid://116944063059174", 
			CameraRig = "rbxassetid://133067619294721"
        }, 
        Execution = {
			KillerRig = "rbxassetid://111258839996704", 
			PlayerRig = "rbxassetid://114855232514926", 
            PlayerCFrameOffset = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 2.5)
        }, 
		Attack = "rbxassetid://111620966224461", 
		Fly = "rbxassetid://122340079405745", 
		FoundYou = "rbxassetid://139341336967438", 
        Hallucinations = {
			"rbxassetid://85608431832861", 
			"rbxassetid://97372681070648", 
			"rbxassetid://70877211283656", 
			"rbxassetid://84178290886743"
        }
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://74143861617780", 
            "rbxassetid://108704374609564"
        }, 
        TerrorRadiusThemes = {
            [60] = {
				ID = "rbxassetid://117552760763934", 
                BPM = 120
            }, 
            [45] = {
				ID = "rbxassetid://86203188145044", 
                BPM = 120
            }, 
            [30] = {
				ID = "rbxassetid://80779197198326", 
                BPM = 120
            }, 
            [6] = {
				ID = "rbxassetid://137386873939073", 
                BPM = 120, 
                Chase = true
            }
        }, 
		Introduction = "rbxassetid://139606856733090", 
        Execution = "rbxassetid://102946562824825", 
        GodspeedLoop = "rbxassetid://110113824866574", 
        FoundYou = "rbxassetid://82532443067807", 
        Hit = "rbxassetid://115537810094042", 
        Swing = "rbxassetid://136695489790441"
    }
};