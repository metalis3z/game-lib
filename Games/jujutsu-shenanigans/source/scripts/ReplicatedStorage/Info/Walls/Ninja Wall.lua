-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    userAnimation = 94671308731592, 
    victimAnimation = 124696202879090, 
    grabWeapon = true, 
    sounds = {
        char = {
            {
                SoundId = "rbxassetid://16023181836", 
                Volume = 2
            }
        }, 
        hit = {
            {
                SoundId = "rbxassetid://16023181747", 
                Volume = 3
            }
        }
    }, 
    markers = {
        hit1 = {
            normal = true, 
            damage = 1, 
            slash = true
        }, 
        hit2 = {
            materialDependent = 1.5, 
            normal = true, 
            damage = 4
        }, 
        hit3 = {
            explosion = true, 
            normal = true, 
            materialDependent = 2, 
            damage = 4
        }, 
        hit4 = {
            final = {
                offset = -5.5, 
                force = {
                    sideways = -52.5, 
                    pushback = 0, 
                    up = Vector3.new(0, 6, 0, 0)
                }
            }, 
            damage = 2
        }
    }
};