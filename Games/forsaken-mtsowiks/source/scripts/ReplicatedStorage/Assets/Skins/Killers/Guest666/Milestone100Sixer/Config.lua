-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:08:26 2025 ]]
local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = game:GetService("RunService"):IsServer() and l_ServerStorage_0 and require(l_ServerStorage_0.Assets.Rigs.Killers.Sixer.Config) or {};
return {
    DisplayName = "Milestone IV", 
    Description = "We meet once more, but I'm no longer afraid of who I am. The monster deep within.", 
    RenderImage = "rbxassetid://138542468029076", 
    Price = -4, 
    Exclusive = true, 
    Sounds = {
        TerrorRadiusThemes = {
            [90] = {
                ID = "rbxassetid://95196851693242", 
                BPM = 139
            }, 
            [60] = {
                ID = "rbxassetid://73354707016069", 
                BPM = 139
            }, 
            [30] = {
                ID = "rbxassetid://83019688966043", 
                BPM = 139
            }, 
            [9] = {
                ID = "rbxassetid://97189983462104", 
                BPM = 139, 
                Chase = true
            }
        }, 
        Ambience = "rbxassetid://115293576113349", 
        Stunned = {
            Start = "rbxassetid://126971570525921", 
            Loop = "rbxassetid://71372217037383", 
            End = "rbxassetid://105351093198067"
        }, 
        Swing = {
            "rbxassetid://127557531826290", 
            "rbxassetid://108651070773439", 
            "rbxassetid://74842815979546"
        }, 
        Chomp = "rbxassetid://119583605486352", 
        Hit = "rbxassetid://90819435118493", 
        DemonicPursuitPrepare = {
            SoundId = "rbxassetid://116527305931161", 
            RollOffMaxDistance = 100
        }, 
        DemonicPursuitPrepareWARN = {
            SoundId = "rbxassetid://78298577002481", 
            RollOffMaxDistance = 100
        }, 
        DemonicPursuitLunge = "rbxassetid://106647770195831", 
        DemonicPursuitHit = "rbxassetid://110877859670130", 
        DemonicPursuitCutscene = "rbxassetid://77962266535909", 
        Crashed = {
            SoundId = "rbxassetid://5148302439"
        }, 
        Landed = {
            SoundId = "rbxassetid://18782451032"
        }, 
        Slide = {
            SoundId = "rbxassetid://97251745910217"
        }, 
        CryWindup = {
            SoundId = "rbxassetid://90702494564513", 
            RollOffMaxDistance = v1 and v1.CryShockwaveDistance or 75
        }, 
        CryShockwave = {
            SoundId = "rbxassetid://136707707822626", 
            RollOffMaxDistance = v1 and v1.CryShockwaveDistance or 75
        }, 
        CryHit = "rbxassetid://118681146051975", 
        Echolocation = "rbxassetid://136866473463412", 
        BloodHunt = "rbxassetid://102348886223010", 
        BloodHuntStart = "rbxassetid://72985187238486", 
        BloodHuntLoop = "rbxassetid://119717613419355", 
        BloodHuntEnd = "rbxassetid://132091893396922"
    }
};