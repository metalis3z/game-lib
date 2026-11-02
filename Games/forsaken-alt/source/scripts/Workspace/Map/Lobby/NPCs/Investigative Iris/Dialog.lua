-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
            Text = "Oh hey"
        });
        v1:CreateDialog({
            Text = "It seems you've caught me during my <Color=Blue>#Investigation<Color=/>"
        });
        local _ = v1:GetUserResponse({
            [1] = {
                Choice = "Your what now"
            }
        });
        v1:CreateDialog({
            Text = "You see this painting? I'm <Color=Blue>#Examining<Color=/> it rn"
        });
        v1:CreateDialog({
            Text = "Something's really off about it... but I can't rlly <Color=Blue>#ConfirmOrDeny<Color=/> anything yet... <Color=Blue>#ItsKindOfConfusing<Color=/>"
        });
        v1:CreateDialog({
            Text = "I might need some more <Color=Blue>#ResearchTime<Color=/> to put all of these clues together if I wanna be able to solve the <Color=Blue>#Mystery<Color=/> here"
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