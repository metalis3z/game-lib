-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Subject_0", 
    Description = "Nil.", 
    RenderImage = "rbxassetid://120842017749280", 
    Price = 3000, 
    CollabInfo = "OutlawsOfRobloxiaPartyexe", 
    Exclusive = false, 
    GashingWoundHitData = function() --[[ Line: 1 ]] --[[ Name: getHitData ]]
        return {
            [0.333] = {
                DamageDivisor = 5, 
                Time = 0.15
            }, 
            [1.483] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.366] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.516] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }, 
            [2.683] = {
                DamageDivisor = 5, 
                Time = 0.15, 
                DoLunge = true
            }
        };
    end, 
    Animations = {
        Idle = "rbxassetid://85781851157656", 
        Walk = "rbxassetid://99294750488976", 
        Run = "rbxassetid://133887955520460", 
        Stunned = {
            Start = "rbxassetid://129836391985049", 
            Loop = "rbxassetid://93958405685149", 
            End = "rbxassetid://72513318802638"
        }, 
        EnragedStart = "rbxassetid://77950768985452", 
        EnragedIdle = "rbxassetid://108921035237764", 
        EnragedWalk = "rbxassetid://127156732149133", 
        EnragedRun = "rbxassetid://127156732149133", 
        Slash = "rbxassetid://101638948673812", 
        GashingWoundStart = "rbxassetid://118506887770038", 
        GashingWound = {
            KillerRig = "rbxassetid://131834617882360", 
            PlayerRig = "rbxassetid://121043188582126"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://94812471481903", 
            CameraRig = "rbxassetid://124272092904368"
        }
    }, 
    Sounds = {
        Footsteps = {
            "rbxassetid://123191843913756", 
            "rbxassetid://136021377051145"
        }, 
        Introduction = "rbxassetid://116217099683989", 
        Stunned = "rbxassetid://104459551297776", 
        EnragedStart = "rbxassetid://98885468408574", 
        GashingWoundHit = "rbxassetid://115968400767084"
    }
};