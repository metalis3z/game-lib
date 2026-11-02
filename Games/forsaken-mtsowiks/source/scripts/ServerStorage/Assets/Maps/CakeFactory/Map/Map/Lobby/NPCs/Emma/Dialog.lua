-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:54 2025 ]]
local v0 = {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://180435571"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 11 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        v1:CreateDialog({
            Text = "Oh! Haha, You found me! Congrats!"
        });
        v1:CreateDialog({
            Text = "Don\226\128\153t tell Ethan yet, though! Okay?"
        });
        v1:ProcessResponse(v1:GetUserResponse({
            [1] = {
                Choice = "Okay"
            }, 
            [2] = {
                Choice = "Nah"
            }, 
            [3] = {
                Choice = "Bye"
            }
        }), {
            [1] = function() --[[ Line: 38 ]]
                -- upvalues: v1 (copy)
                local v2 = {
                    "Glad to have a pal, see ya\226\128\153 later!"
                };
                v1:CreateDialog({
                    Text = v2[math.random(1, #v2)]
                });
            end, 
            [2] = function() --[[ Line: 48 ]]
                -- upvalues: v1 (copy)
                local v3 = {
                    "H-Hey! Keep it down!", 
                    "I wanna win this!"
                };
                v1:CreateDialog({
                    Text = v3[math.random(1, #v3)]
                });
            end, 
            [3] = function() --[[ Line: 30 ]] --[[ Name: cancelDialog ]]
                -- upvalues: v1 (copy)
                local v4 = {
                    "Cya, don't be snitching!"
                };
                v1:CreateDialog({
                    Text = v4[math.random(1, #v4)]
                });
            end
        });
        return;
    else
        v1:CreateDialog({
            Text = "No snitching!"
        });
        return;
    end;
end;
return v0;