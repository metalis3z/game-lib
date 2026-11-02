-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        VoiceSFX = "rbxassetid://107715594645264", 
        Poses = {
            Idle = "rbxassetid://180435571"
        }, 
        Actions = {
            Wave = "rbxassetid://128777973"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 14 ]]
    -- upvalues: v0 (copy)
    if not v0.TimesSpokenTo then
        v0.TimesSpokenTo = 0;
        v1:CreateDialog({
            Text = "yo"
        });
        v1:CreateDialog({
            Text = "the tables here are free"
        });
        v1:CreateDialog({
            Text = "they'd cost more but there's no point in costing anything if i can't go to the store to spend my money"
        });
        v1:CreateDialog({
            Text = "because there are no stores here"
        });
        return;
    else
        local l_v0_0 = v0;
        l_v0_0.TimesSpokenTo = l_v0_0.TimesSpokenTo + 1;
        v1:CreateDialog({
            Text = "the tables here are free"
        });
        v1:CreateDialog({
            Text = "they'd cost more but there's no point in costing anything if i can't go to the store to spend my money"
        });
        v1:CreateDialog({
            Text = "because there are no stores here"
        });
        return;
    end;
end;
return v0;