-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:47 2025 ]]
local v0 = {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        Poses = {
            Idle = "rbxassetid://180435571"
        }, 
        Actions = {
            Wave = "rbxassetid://128777973"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 13 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        v1:CreateDialog({
            Text = "i was called to deliver some pizza earlier but i dont think this is the right house"
        });
        v1:CreateDialog({
            Text = "and i lost my car on the way here so now idk how to get back home"
        });
        return;
    else
        v1:CreateDialog({
            Text = "i dont think im gonna get my paycheck after telling boss about this one"
        });
        return;
    end;
end;
return v0;