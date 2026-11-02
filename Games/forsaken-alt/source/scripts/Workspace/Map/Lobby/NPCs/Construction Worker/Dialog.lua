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
            Text = "2x2 said to not let anyone go past this point because of like evil monsters or something"
        });
        v1:CreateDialog({
            Text = "so you can't go past these planks i built"
        });
        v1:CreateDialog({
            Text = "unless you like climb over them"
        });
        v1:CreateDialog({
            Text = "but you wouldnt do that i think"
        });
        return;
    else
        v1:CreateDialog({
            Text = "pretty please dont go over my barrier"
        });
        v1:CreateDialog({
            Text = "i spent a lot of time making it just so that you dont go past it"
        });
        return;
    end;
end;
return v0;