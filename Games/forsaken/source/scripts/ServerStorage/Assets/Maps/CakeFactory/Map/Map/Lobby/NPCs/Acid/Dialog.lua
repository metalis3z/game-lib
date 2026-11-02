-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:55 2025 ]]
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
            Text = "I feel like each different pumpkin is supposed to mock the wizard."
        });
        v1:CreateDialog({
            Text = "Like why him specifically? Is he calling him stupid? "
        });
        return;
    else
        v1:CreateDialog({
            Text = "Why do you have... so many?"
        });
        return;
    end;
end;
return v0;