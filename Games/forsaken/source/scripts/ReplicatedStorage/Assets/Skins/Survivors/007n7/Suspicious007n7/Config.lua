-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Suspicious Man", 
    Description = "\"You see, I have some unfinished business with the fish dude, and I'm willing to deal with it...\"", 
    RenderImage = "rbxassetid://77988843304286", 
    Price = 1000, 
    Exclusive = false, 
    CollabInfo = "Postmortem", 
    c00lguiTemplate = script.c00lgui, 
    Expressions = {
        Happy = "rbxassetid://77633165097789", 
        Default = "rbxassetid://74370180338432", 
        Hurt = "rbxassetid://134321455488512", 
        Injured = "rbxassetid://136186889626571", 
        Dead = "rbxassetid://128032827294976", 
        Drinking = "rbxassetid://74966755243741", 
        Concentrating = "rbxassetid://137085792144221"
    }, 
    Animations = {
        Idle = "rbxassetid://92135616191854", 
        Walk = "rbxassetid://82786257366373", 
        Run = "rbxassetid://87880602276526", 
        InjuredIdle = "rbxassetid://111984269708167", 
        InjuredWalk = "rbxassetid://106455560615433", 
        InjuredRun = "rbxassetid://93710008937994"
    }, 
    Sounds = {
        c00lguiActivated = "rbxassetid://96714063677177"
    }, 
    VoicelineVolume = 1.5, 
    Voicelines = {
        Died = {
            "rbxassetid://123571562223011"
        }
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "I need a little snack, buddy...", 
                "Can I get a bite of that pizza?", 
                "Got food?"
            }, 
            BuildermanSentry = {
                "We really need to land some shots on that beast...", 
                "Can you build me one of those big guns?", 
                "SHOOT!"
            }, 
            BuildermanDispenser = {
                "Heh, help me out buddy...", 
                "Some healing here...?", 
                "Perfect spot for one of those health thingamajigs, am I right?"
            }, 
            DusekkarProtection = {
                "How about you cast that cool magic of yours, huh...", 
                "Cover me, magic man.", 
                "Lend me a hand, will ya?"
            }
        }, 
        Thanks = {
            Regular = {
                "Hehe, thanks.", 
                "I'll repay you later...maybe....", 
                "Come back later... Hehe..."
            }
        }
    }
};