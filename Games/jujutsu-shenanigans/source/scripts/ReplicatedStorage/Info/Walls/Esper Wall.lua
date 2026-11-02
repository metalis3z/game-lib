-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    userAnimation = 86621350311177, 
    victimAnimation = 113452624089338, 
    sounds = {
        char = {
            {
                SoundId = "rbxassetid://16310741248", 
                Volume = 3
            }
        }, 
        hit = {
            {
                SoundId = "rbxassetid://16310741455", 
                Volume = 3
            }
        }
    }, 
    markers = {
        hit1 = {
            normal = true, 
            damage = 3, 
            materialDependent = 2
        }, 
        hit2 = {
            final = {
                offset = -6, 
                force = {
                    sideways = 0, 
                    pushback = -45, 
                    up = Vector3.new(0, 25, 0, 0)
                }
            }, 
            materialDependent = 2, 
            damage = 9
        }
    }
};