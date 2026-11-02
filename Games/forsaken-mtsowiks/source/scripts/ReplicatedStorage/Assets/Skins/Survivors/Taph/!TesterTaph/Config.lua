-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:09:47 2025 ]]
return {
    DisplayName = "Tester", 
    Description = "tester exclusive skin", 
    RenderImage = "rbxassetid://75356450551706", 
    Price = 70000000000, 
    Exclusive = true, 
    NotReplicated = false, 
    Expressions = false, 
    TripwireTemplate = script.TripwireHook, 
    SubspaceExplosionVFX = script.ExplosionVFX, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "pizza."
            }, 
            BuildermanSentry = {
                "sentry."
            }, 
            BuildermanDispenser = {
                "dispenser."
            }, 
            DusekkarProtection = {
                "shield."
            }
        }, 
        Thanks = {
            Regular = {
                "thanks."
            }
        }
    }
};