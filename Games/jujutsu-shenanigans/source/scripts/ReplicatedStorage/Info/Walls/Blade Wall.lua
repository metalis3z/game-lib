-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    userAnimation = 103668729685937, 
    victimAnimation = 96314229133715, 
    grabWeapon = true, 
    sounds = {
        char = {
            {
                SoundId = "rbxassetid://15997645271", 
                Volume = 2
            }
        }, 
        hit = {
            {
                SoundId = "rbxassetid://15997641783", 
                Volume = 3
            }
        }
    }, 
    markers = {
        hit1 = {
            normal = true, 
            damage = 2, 
            slash = true
        }, 
        hit2 = {
            materialDependent = 1.5, 
            normal = true, 
            damage = 1
        }, 
        hit3 = {
            materialDependent = 1, 
            normal = true, 
            damage = 2
        }, 
        hit4 = {
            final = {
                offset = -6, 
                force = {
                    sideways = 52.5, 
                    pushback = 0, 
                    up = Vector3.new(0, 6, 0, 0)
                }
            }, 
            slash = true, 
            damage = 7
        }
    }
};