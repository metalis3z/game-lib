-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    userAnimation = 135499616418801, 
    victimAnimation = 111115550857952, 
    sounds = {
        char = {
            {
                SoundId = "rbxassetid://15943937672", 
                Volume = 1.5
            }
        }, 
        hit = {
            {
                SoundId = "rbxassetid://15943937560", 
                Volume = 2
            }
        }
    }, 
    markers = {
        hit1 = {
            materialDependent = 1, 
            normal = true, 
            damage = 1
        }, 
        hit2 = {
            materialDependent = 2, 
            normal = true, 
            damage = 4
        }, 
        hit3 = {
            materialDependent = 1, 
            normal = true, 
            damage = 1
        }, 
        hit4 = {
            final = {
                offset = 0.5, 
                force = {
                    sideways = -52.5, 
                    pushback = 0, 
                    up = Vector3.new(0, 6, 0, 0)
                }
            }, 
            damage = 6
        }
    }
};