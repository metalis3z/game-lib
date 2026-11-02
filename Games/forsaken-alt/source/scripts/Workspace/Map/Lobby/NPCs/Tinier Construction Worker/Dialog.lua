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
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        v1:CreateDialog({
            Text = "I made the fence here."
        });
        v1:CreateDialog({
            Text = "People just like taking credit for the things I do because I'm smaller than them."
        });
        return;
    else
        v1:CreateDialog({
            Text = "Don't go around that fence btw. kthx."
        });
        return;
    end;
end;
return v0;