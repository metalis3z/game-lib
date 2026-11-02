-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Tester", 
    Description = "tester exclusive skin", 
    RenderImage = "rbxassetid://75356450551706", 
    Price = 70000000000, 
    Exclusive = true, 
    NotReplicated = false, 
    Expressions = false, 
    SentryTemplate = script.Sentry, 
    DispenserTemplate = script.Dispenser, 
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