-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:07:51 2025 ]]
return {
    DisplayName = "Subject_0", 
    Description = "Nil.", 
    RenderImage = "rbxassetid://120842017749280", 
    Price = 3000, 
    CollabInfo = "OutlawsOfRobloxiaPartyexe", 
    Exclusive = true, 
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
        Idle = "rbxassetid://131024256137537", 
        Walk = "rbxassetid://101366379226633", 
        Run = "rbxassetid://120106426584665", 
        Stunned = {
            Start = "rbxassetid://114905885038218", 
            Loop = "rbxassetid://114685046580365", 
            End = "rbxassetid://82927176916560"
        }, 
        EnragedStart = "rbxassetid://88354664264032", 
        EnragedIdle = "rbxassetid://120563402498801", 
        EnragedWalk = "rbxassetid://125989092848172", 
        EnragedRun = "rbxassetid://125989092848172", 
        Slash = "rbxassetid://118056612259963", 
        GashingWoundStart = "rbxassetid://123848760921499", 
        GashingWound = {
            KillerRig = "rbxassetid://101290062851789", 
            PlayerRig = "rbxassetid://84834127167759"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://74032323085118", 
            CameraRig = "rbxassetid://108068541045423"
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