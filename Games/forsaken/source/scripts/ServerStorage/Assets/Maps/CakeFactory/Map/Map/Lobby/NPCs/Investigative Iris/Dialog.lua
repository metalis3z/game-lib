-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:49 2025 ]]
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
    if not v0.first then
        v0.first = true;
        v1:CreateDialog({
            Text = "Hey again"
        });
        v1:CreateDialog({
            Text = "I recently came across this <Color=Blue>#Mysterious<Color=/> basement"
        });
        local _ = v1:GetUserResponse({
            [1] = {
                Choice = "Have you gone inside of it?"
            }
        });
        v1:CreateDialog({
            Text = "No, I'm still <Color=Blue>#InvestigatingIt<Color=/>"
        });
        v1:CreateDialog({
            Text = "If you could help me out here that would <Color=Blue>#BeAppreciated<Color=/>..."
        });
        v1:CreateDialog({
            Text = "My main suspicion is that this basement is <Color=Blue>#Temporary<Color=/>"
        });
        return;
    else
        v1:CreateDialog({
            Text = "<Color=Blue>#LookingIntoThis<Color=/>..."
        });
        return;
    end;
end;
return v0;