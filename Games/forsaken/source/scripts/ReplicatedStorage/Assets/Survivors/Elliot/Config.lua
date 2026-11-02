-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayName = "Elliot", 
    Quote = "\"Pizza pizza!\"", 
    Credits = "", 
    Class = "Support", 
    RenderImage = "rbxassetid://76986932519997", 
    Price = 0, 
    Requests = {
        ElliotPizza = {
            Order = 1, 
            AbilityName = "ThrowPizza", 
            RequestTitle = "Request Pizza", 
            NotificationTitle = "PLAYERNAME wants a pizza!"
        }
    }, 
    Health = 80, 
    Speed = 12, 
    InjuredSurvivorAuraDuration = 12, 
    InjuredSurvivorDamageMinimum = 1, 
    ThrowPizzaCooldown = 45, 
    PizzaThrowForce = 60, 
    PizzaHealingAmount = 15, 
    PizzaHealingProgressively = 20, 
    PizzaHealingProgressivelyTime = 2.5, 
    PizzaLifetime = 25, 
    PizzaPingDistance = 200, 
    PizzaPingDuration = 25, 
    RushHourCooldown = 40, 
    RushHourSpeedLevel = 3, 
    RushHourSpeedDuration = 3, 
    HealingPercentDebuffPerElliot = 15, 
    HealingPercentAddedOnObjectiveCompletion = 5, 
    HealingPercentDebuffCap = 80, 
    HealingPercentCap = 25, 
    Expressions = {
        Happy = "rbxassetid://94482736799147", 
        SlightlyHappy = "rbxassetid://123777692657435", 
        Default = "rbxassetid://116435277326076", 
        Hurt = "rbxassetid://113881299753695", 
        Injured = "rbxassetid://123229131144789", 
        Dead = "rbxassetid://109721549384734", 
        Drinking = "rbxassetid://91931121620861"
    }, 
    Animations = {
		ThrowPizza = "rbxassetid://82716153510935"
    }, 
    Sounds = {
        PizzaEaten = "rbxassetid://18196908747", 
        PizzaThrown = "rbxassetid://114810361288106", 
        RushHourStart = "rbxassetid://84766394210518"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "I\226\128\153m fresh out and I really need a pizza..!", 
                "Can\226\128\153t hand pizzas yet, need one right now, though..!", 
                "Mind if I ask for a pizza..? Can\226\128\153t hand some out yet, eheh..", 
                "Can I have some of your pizza? I\226\128\153m out..", 
                "Really could go for a pizza.. Mind if I have one?", 
                "I could eat my own pizza, but I really wanna save it for the others.. Can I have some?", 
                "Mind if I have a slice..?"
            }, 
            BuildermanSentry = {
                "Mister Builder! Put one of those turrets here!", 
                "Quick! Place a sentry here!", 
                "Hurry, put down a sentry over here!", 
                "Put a sentry over here!", 
                "This spot is good for a sentry!"
            }, 
            BuildermanDispenser = {
                "Mister Builder! Put one of those dispensers here!", 
                "This spot\226\128\153s good for a dispenser!", 
                "Build a dispenser over here!", 
                "A dispenser would be good here, I think..", 
                "Putting a dispenser here should work!"
            }, 
            DusekkarProtection = {
                "Pumpkin guy! Need a little force field..!!", 
                "Force field needed!!", 
                "Cast your force field!!", 
                "Please cast a force field..!!", 
                "Force field urgently required!!"
            }
        }, 
        Thanks = {
            Regular = {
                "Whew.. thanks, man.", 
                "Another job well done, all thanks to you!", 
                "Thanks, buddy!", 
                "I\226\128\153m glad for the help!", 
                "Thanks for the help!", 
                "Thank you so much!"
            }
        }
    }
};
v0.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "ELLIOT", 
        Text = "Builder Brother's Pizza's best employee, now just wanting to help in any way he can. With his experience in rushing deliveries and making pizzas, he works as a support to help his team with his pizza slices.\n"
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\134\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v0.Health or 100) .. ("Regular Speed: %*\n"):format(v0.Speed or 12) .. ("Sprinting Speed: %*\n"):format(v0.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(v0.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(v0.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(v0.StaminaGain or 20)
    }, 
    {
        Separator = "PASSIVES"
    }, 
    {
        Header = "ORDER UP!", 
        Quote = "\"Pizza! Pizza! Pizza! Pizza! Pizza! Pizza!\226\128\157 - Satisfied Customer", 
        Text = ("%* feels proud seeing a task get done.\n"):format("Elliot") .. ("After any objective is contributed towards, %* gains a %*%% increase in how much he heals.\n"):format("Elliot", v0.HealingPercentAddedOnObjectiveCompletion) .. ("This percentage stacks, but caps at %*%%\n"):format(v0.HealingPercentCap)
    }, 
    {
        Header = "DELIVERER'S RESOLVE", 
        Quote = "\"Woah! That\226\128\153s some fast delivery!\226\128\157 - Satisfied Customer", 
        Text = ("Whenever any Survivor receives a noticable amount of damage (%* minimum), their aura becomes revealed to %* for %*s.\n"):format(v0.InjuredSurvivorDamageMinimum, "Elliot", v0.InjuredSurvivorAuraDuration)
    }, 
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://93578432067529", 
        Header = "PIZZA THROW", 
        Quote = "\"Nice to see you! What can I get ya?\" - Elliot", 
        Text = ("Cooldown: %*s\n"):format(v0.ThrowPizzaCooldown) .. ("%* tosses a pizza infront of him that can instantly heal other survivors for %* HP. It then progressively heals %* HP over %* seconds to whoever picks it up. The pizza despawns after %*s.\n"):format("Elliot", v0.PizzaHealingAmount, v0.PizzaHealingProgressively, v0.PizzaHealingProgressivelyTime, v0.PizzaLifetime) .. ("Survivors within %* studs of %* while the pizza's being thrown have the pizza highlighted for %*s.\n"):format(v0.PizzaPingDistance, "Elliot", v0.PizzaPingDuration) .. ("Pizzas thrown by %* cannot heal himself, and pizzas thrown by other %*s will give 50%% less healing.\n"):format("Elliot", "Elliot") .. ("The healing effect of the pizzas is decreased by %*%% for every additional %* that's ingame. This debuff is capped at %*%%.\n"):format(v0.HealingPercentDebuffPerElliot, "Elliot", v0.HealingPercentDebuffCap)
    }, 
    {
        Image = "rbxassetid://128250550180598", 
        Header = "RUSH HOUR", 
        Quote = "\"Wow, you should get a raise.\" - Satisfied Customer", 
        Text = ("Cooldown: %*s\n"):format(v0.RushHourCooldown) .. ("After %* heals any player, they gain a charge for this ability. Using a charge grants them <b>Speed III</b> for %*s.\n"):format("Elliot", v0.RushHourSpeedDuration) .. ("Healing another %* does not give a charge for this ability.\n"):format("Elliot") .. ("%* starts the round off with 1 charge for this ability.\n"):format("Elliot") .. "There cannot be more than 1 charge stored for this ability at a time.\n"
    }
};
return v0;