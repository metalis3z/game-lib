-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:53 2025 ]]
local v0 = {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://180435571"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 10 ]]
    -- upvalues: v0 (copy)
    if v0.choice == 1 then
        v1:CreateDialog({
            Text = "How quiet it has gotten."
        });
        v1:CreateDialog({
            Text = "Crops have gone undisturbed as I ensured."
        });
        return;
    elseif v0.choice == 2 then
        v1:CreateDialog({
            Text = "Tread lightly."
        });
        return;
    else
        v1:CreateDialog({
            Text = "All are victim to its influence and live each day."
        });
        v1:CreateDialog({
            Text = "To see everything as it is will be when you are truly living."
        });
        v1:CreateDialog({
            Text = "With curiosity, there is reason."
        });
        v1:CreateDialog({
            Text = "A motivation to seek answers."
        });
        v1:ProcessResponse(v1:GetUserResponse({
            [1] = {
                Choice = "What's up with the mask?"
            }, 
            [2] = {
                Choice = "Huh?"
            }
        }), {
            [1] = function() --[[ Line: 32 ]]
                -- upvalues: v1 (copy), v0 (ref)
                v1:CreateDialog({
                    Text = "A figure that is representative of what I am."
                });
                v0.choice = 1;
            end, 
            [2] = function() --[[ Line: 36 ]]
                -- upvalues: v1 (copy), v0 (ref)
                v1:CreateDialog({
                    Text = "Influence will remain for as long as your presence does."
                });
                v1:CreateDialog({
                    Text = "It watches every moment."
                });
                v1:CreateDialog({
                    Text = "Stay for as long as you wish, only I can watch where we all stand."
                });
                v0.choice = 2;
            end
        });
        return;
    end;
end;
return v0;