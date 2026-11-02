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
            Text = "Hey, you look like a good seeker!"
        });
        v1:CreateDialog({
            Text = "Let me know if you spot a brown-haired girl around here with a black and blue sweater, okay?"
        });
        v1:CreateDialog({
            Text = "We were playing a game, but I haven\226\128\153t found her in a bit.."
        });
        v1:CreateDialog({
            Text = "I\226\128\153m sure she\226\128\153s around here though!"
        });
        return;
    else
        v1:CreateDialog({
            Text = "Again, let me know if you see her!"
        });
        return;
    end;
end;
return v0;