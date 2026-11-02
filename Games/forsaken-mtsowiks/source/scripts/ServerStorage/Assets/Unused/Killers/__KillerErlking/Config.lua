-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Erlking", 
    Quote = "\"HEED MY CALL!\"", 
    Credits = "By: AndrewD0tWeb", 
    RenderImage = "rbxassetid://138972079846467", 
    Price = 700, 
    Exclusive = true, 
    Health = 1100, 
    Speed = 8, 
    LastManStandingData = {
        ThemeID = "rbxassetid://136084718610898", 
        ThemeProperties = {
            Volume = 0.75
        }, 
        RoundTime = 74
    }, 
    SprintSpeed = 30, 
    StaminaLoss = 10, 
    StaminaGain = 20, 
    MaxStamina = 1000, 
    AttackDamage = 40, 
    StunDuration = 0.5, 
    RejuvenateTheRottenCooldown = 20, 
    ZombieHealth = 30, 
    ZombieWalkSpeed = 6, 
    ZombieSprintSpeed = 17.5, 
    ZombieAttackCooldown = 3, 
    ZombieAttackDamage = 15, 
    ZombieAttackRange = 5, 
    ZombieTargetRange = 200, 
    ZombieLoseFocusRange = 200, 
    Zombies = {
        [1] = script.Zombie1, 
        [2] = script.Zombie2
    }, 
    ZombieAnimations = {
        Idle = "rbxassetid://76087890587264", 
        Walk = "rbxassetid://106002791624384", 
        Run = "rbxassetid://106648988460289", 
        Attack = "rbxassetid://134602001448777", 
        Summon = "rbxassetid://108019082733822"
    }, 
    Animations = {
        Idle = "rbxassetid://86475341605510", 
        Walk = "rbxassetid://103452402946778", 
        Run = "rbxassetid://106405200429535", 
        Slash = "rbxassetid://120109752649663", 
        Stunned = "rbxassetid://136090609667926"
    }, 
    Sounds = {
        TerrorRadiusThemes = {
            [70] = {
                ID = "rbxassetid://120625074849463", 
                BPM = 120
            }, 
            [45] = {
                ID = "rbxassetid://100850412971228", 
                BPM = 120
            }, 
            [15] = {
                ID = "rbxassetid://93363907907660", 
                BPM = 120
            }, 
            [10] = {
                ID = "rbxassetid://113081858218471", 
                BPM = 120, 
                Chase = true
            }
        }, 
        Footsteps = {
            "rbxassetid://99809965759734", 
            "rbxassetid://79222929114377"
        }, 
        Swing = "rbxassetid://106368806396221", 
        Hit = "rbxassetid://106583279178468"
    }, 
    Voicelines = {
        Idle = {
            "rbxassetid://132507946840421", 
            "rbxassetid://100428132938508", 
            "rbxassetid://75727695492657", 
            "rbxassetid://78809767612341"
        }, 
        Injured = {
            "rbxassetid://112139222041975", 
            "rbxassetid://106595769617073", 
            "rbxassetid://106131284872147"
        }, 
        Swing = {
            "rbxassetid://134919845317438", 
            "rbxassetid://100390568341289", 
            "rbxassetid://101937011678243"
        }
    }
};