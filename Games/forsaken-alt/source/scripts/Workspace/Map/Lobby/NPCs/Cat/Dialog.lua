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
            Text = "What u looking at punk."
        });
        v1:CreateDialog({
            Text = "Yeah I can talk. whats it to ya. punk."
        });
        return;
    else
        local l_v0_0 = v0;
        l_v0_0.TimesSpokenTo = l_v0_0.TimesSpokenTo + 1;
        if v0.TimesSpokenTo == 15 then
            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "ILoveCats");
            v1:CreateDialog({
                Text = "meow meow meow AGHHAGGAUGHUUGHGHGHG"
            });
            return;
        else
            l_v0_0 = {
                "meow", 
                "mew", 
                "mrow", 
                "myeow", 
                "miau", 
                "nyaw", 
                "nya", 
                "mmrrp", 
                "prrrr"
            };
            v1:CreateDialog({
                Text = l_v0_0[math.random(1, #l_v0_0)]
            });
            return;
        end;
    end;
end;
return v0;