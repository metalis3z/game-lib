-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:08 2025 ]]
return {
    DisplayName = "Screamer", 
    Description = "Back for more.", 
    RenderImage = "rbxassetid://110702078544291", 
    Price = 1000, 
    Exclusive = true, 
    Halloween = true, 
    CollabInfo = "RM", 
    JDFrame = script.ScreamerFrame, 
    Sounds = {
        Introduction = "rbxassetid://134807846766934", 
        StunEnded = "rbxassetid://94707595437617", 
        Execution = "rbxassetid://73996493947818"
    }, 
    Animations = {
        Idle = "rbxassetid://123361650039881", 
        Walk = "rbxassetid://70933032648667", 
        Run = "rbxassetid://135594583812915", 
        InjuredIdle = "rbxassetid://123361650039881", 
        InjuredWalk = "rbxassetid://70933032648667", 
        InjuredRun = "rbxassetid://120511859936118", 
        Slash = "rbxassetid://126462606523245", 
        Execution = {
            KillerRig = "rbxassetid://108163802018237", 
            PlayerRig = "rbxassetid://71496107877197", 
            PlayerCFrameOffset = CFrame.Angles(0, 0, 0) * CFrame.new(0, 0, 0)
        }, 
        Stunned = {
            Start = "rbxassetid://127653930855915", 
            Loop = "rbxassetid://80772951264039", 
            End = "rbxassetid://117459712056486", 
            Cancel = "rbxassetid://104164703748131"
        }, 
        Introduction = {
            CameraRig = "rbxassetid://130301129292574", 
            KillerRig = "rbxassetid://136873103419085"
        }
    }
};