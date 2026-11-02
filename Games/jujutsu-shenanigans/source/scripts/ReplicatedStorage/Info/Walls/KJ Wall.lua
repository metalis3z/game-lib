-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    userAnimation = 104865347280053, 
    victimAnimation = 81667598342800, 
    sounds = {
        char = {
            {
                SoundId = "rbxassetid://18443048724", 
                Volume = 10
            }
        }, 
        hit = {
            {
                SoundId = "rbxassetid://18443049348", 
                Volume = 10
            }
        }
    }, 
    markers = {
        hit1 = {
            materialDependent = 2, 
            normal = true, 
            damage = 6
        }, 
        hit2 = {
            normal = true, 
            damage = 6
        }, 
        hit3 = {
            final = {
                offset = -6, 
                force = {
                    sideways = -120, 
                    pushback = 0, 
                    up = Vector3.new(0, 25, 0, 0)
                }
            }, 
            damage = 10
        }
    }
};