-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

return {
    userAnimation = 77318292883122, 
    victimAnimation = 99181363052019, 
    grabWeapon = true, 
    sounds = {
        char = {
            {
                SoundId = "rbxassetid://15944339740", 
                Volume = 2
            }
        }, 
        hit = {
            {
                SoundId = "rbxassetid://15944339899", 
                Volume = 4
            }
        }
    }, 
    markers = {
        hit1 = {
            materialDependent = 3.5, 
            normal = true, 
            damage = 2
        }, 
        hit2 = {
            normal = true, 
            damage = 1
        }, 
        hit3 = {
            materialDependent = 3.5, 
            normal = true, 
            damage = 3
        }, 
        hit4 = {
            final = {
                offset = -3.5, 
                force = {
                    sideways = -60, 
                    pushback = 0, 
                    up = Vector3.new(0, 6, 0, 0)
                }
            }, 
            damage = 6
        }
    }
};