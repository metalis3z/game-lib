-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:47 2025 ]]
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
            Text = "..NEVER TASTE WATER WHEN ITS RED!"
        });
        v1:CreateDialog({
            Text = "ITS DISGUISTING."
        });
        return;
    else
        v1:CreateDialog({
            Text = "Atleast things look less... Spookier.."
        });
        return;
    end;
end;
return v0;