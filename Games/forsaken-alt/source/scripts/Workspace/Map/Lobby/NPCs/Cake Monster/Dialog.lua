-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = true, 
        VoiceSFX = "rbxassetid://107648255423077", 
        Poses = {
            Idle = "rbxassetid://180435571"
        }
    }, 
    Interacted = function(v0) --[[ Line: 12 ]]
        v0:CreateDialog({
            Text = "Mmarghh.. Mmmrgh.."
        });
        v0:CreateDialog({
            Text = "RRGH? Rrghh..."
        });
        v0:ProcessResponse(v0:GetUserResponse({
            [1] = {
                Choice = "Yuck"
            }, 
            [2] = {
                Choice = "What are you?"
            }, 
            [3] = {
                Choice = "You look yummy"
            }
        }), {
            [1] = function() --[[ Line: 31 ]]
                -- upvalues: v0 (copy)
                local v1 = {
                    "MMMMRAGGH", 
                    "MARRGHH! HAAARGHH!!!!", 
                    "AGHRGHHRAAAAHHH", 
                    "HHRGRRAHHH!!!", 
                    "NNRAHHGHHH! NHHRRAGGHH!!", 
                    "MMRRGHHHRHGG!!", 
                    "HHRAGGHHH! HRGGRHHHG!!"
                };
                v0:CreateDialog({
                    Text = v1[math.random(1, #v1)]
                });
            end, 
            [2] = function() --[[ Line: 44 ]]
                -- upvalues: v0 (copy)
                local v2 = {
                    "Mrrghh.. hhnghh..", 
                    "hhghhh.. gllrgrg..", 
                    "Ghhrggh...", 
                    "Hhrrhhrrghh.. gghhhhnn..", 
                    "Nnhhhrhhggghhh..."
                };
                v0:CreateDialog({
                    Text = v2[math.random(1, #v2)]
                });
            end, 
            [3] = function() --[[ Line: 55 ]]
                -- upvalues: v0 (copy)
                v0:CreateDialog({
                    Text = "!!!"
                });
                local v3 = {
                    "RRAGHGH! MARRGH!! HHAAARRGGH!!!!!", 
                    "RRAGHGH! HHAAARRGGH!! MARRGH!!!!!", 
                    "HHAAARRGGH! RRAGHGH!! MARRGH!!!!!", 
                    "HHAAARRGGH! MARRGH!! RRAGHGH!!!!!", 
                    "MARRGH! HHAAARRGGH!! RRAGHGH!!!!!", 
                    "MARRGH! RRAGHGH!! HHAAARRGGH!!!!!"
                };
                v0:CreateDialog({
                    Text = v3[math.random(1, #v3)]
                });
            end
        });
    end
};