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
        Idle = "rbxassetid://128332150514809", 
        Walk = "rbxassetid://107952988891703", 
        Run = "rbxassetid://123402003848455", 
        Stunned = {
            Start = "rbxassetid://72262740238625", 
            Loop = "rbxassetid://124632843845904", 
            End = "rbxassetid://113305962867606"
        }, 
        EnragedStart = "rbxassetid://87102358221968", 
        EnragedIdle = "rbxassetid://110766241286823", 
        EnragedWalk = "rbxassetid://126142650334354", 
        EnragedRun = "rbxassetid://126142650334354", 
        Slash = "rbxassetid://106823722904095", 
        GashingWoundStart = "rbxassetid://131835743186049", 
        GashingWound = {
            KillerRig = "rbxassetid://81873982728165", 
            PlayerRig = "rbxassetid://89992025909595"
        }, 
        Introduction = {
            KillerRig = "rbxassetid://132167786768699", 
            CameraRig = "rbxassetid://126299244839035"
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