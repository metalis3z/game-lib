-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:09:38 2025 ]]
return {
    DisplayName = "Tester", 
    Description = "tester exclusive skin", 
    RenderImage = "rbxassetid://75356450551706", 
    Price = 70000000000, 
    Exclusive = true, 
    NotReplicated = false, 
    Expressions = false, 
    c00lguiTemplate = script.c00lgui, 
    InjectTemplate = script.InjectUI, 
    DexTemplate = script.DexUI, 
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