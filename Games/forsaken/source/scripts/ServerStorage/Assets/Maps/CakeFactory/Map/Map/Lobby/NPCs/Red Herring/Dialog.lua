-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:52 2025 ]]
local v0 = {};
local _ = game:GetService("TweenService");
v0.Config = {
    FacePlayer = false, 
    PlayIdleOutsideOfDialog = false
};
v0.Interacted = function(v2) --[[ Line: 10 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        v2:CreateDialog({
            Text = "Heh! Hey! Long time no see!"
        });
        v2:CreateDialog({
            Text = "Look I'm a red herring haha!"
        });
        v2:CreateDialog({
            Text = "Haha! I have learnt instant transmission!"
        });
        v2:CreateDialog({
            Text = "heh..."
        });
        v2:CreateDialog({
            Text = "..."
        });
        v2:CreateDialog({
            Text = "please dont kill me"
        });
        v2:ProcessResponse(v2:GetUserResponse({
            [1] = {
                Choice = "kill"
            }, 
            [2] = {
                Choice = "Not today."
            }, 
            [3] = {
                Choice = "I won't"
            }
        }), {
            [1] = function() --[[ Line: 53 ]]
                -- upvalues: v2 (copy)
                local v3 = {
                    "awww mannn"
                };
                v2:CreateDialog({
                    Text = v3[math.random(1, #v3)]
                });
            end, 
            [2] = function() --[[ Line: 63 ]]
                -- upvalues: v2 (copy)
                local v4 = {
                    "Oh."
                };
                v2:CreateDialog({
                    Text = v4[math.random(1, #v4)]
                });
            end, 
            [3] = function() --[[ Line: 45 ]] --[[ Name: cancelDialog ]]
                -- upvalues: v2 (copy)
                local v5 = {
                    "bye"
                };
                v2:CreateDialog({
                    Text = v5[math.random(1, #v5)]
                });
            end
        });
        return;
    else
        v2:CreateDialog({
            Text = "hi"
        });
        return;
    end;
end;
return v0;