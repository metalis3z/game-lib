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
        Idle = "rbxassetid://81209243978168", 
        Walk = "rbxassetid://113910731816532", 
        Run = "rbxassetid://115518994437857", 
        Attack = "rbxassetid://132395213375112", 
        Summon = "rbxassetid://75268096477655"
    }, 
    Animations = {
        Idle = "rbxassetid://82915823845516", 
        Walk = "rbxassetid://116836295099636", 
        Run = "rbxassetid://86493839464294", 
        Slash = "rbxassetid://74359695446017", 
        Stunned = "rbxassetid://108487185259645"
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