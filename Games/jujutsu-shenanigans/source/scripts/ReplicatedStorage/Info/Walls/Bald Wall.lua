-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    userAnimation = 91298087046226, 
    victimAnimation = 131850443974474, 
    sounds = {
        char = {
            {
                SoundId = "rbxassetid://15955357446", 
                Volume = 2, 
                TimePosition = 0.167
            }, 
            {
                SoundId = "rbxassetid://15955559676", 
                Volume = 2, 
                TimePosition = 0.2
            }
        }, 
        wall = {
            {
                SoundId = "rbxassetid://15955357060", 
                Volume = 2, 
                TimePosition = 0.167
            }
        }
    }, 
    markers = {
        hit1 = {
            materialDependent = 3.5, 
            normal = true, 
            damage = 6
        }, 
        hit2 = {
            materialDependent = 3.5, 
            final = {
                offset = -6, 
                force = {
                    sideways = 0, 
                    pushback = -45, 
                    up = Vector3.new(0, 25, 0, 0)
                }
            }, 
            damage = 6
        }
    }
};