-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:50 2025 ]]
local v0 = {
    Config = {
        PlayIdleOutsideOfDialog = true, 
        VoiceSFX = "rbxassetid://5416513331", 
        Poses = {
            Idle = "rbxassetid://136839259317251"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 11 ]]
    -- upvalues: v0 (copy)
    if not v0.TimesInteracted then
        v0.TimesInteracted = 0;
    end;
    local l_v0_0 = v0;
    l_v0_0.TimesInteracted = l_v0_0.TimesInteracted + 1;
    if v0.TimesInteracted == 1 then
        v1:CreateDialog({
            Text = "gleeb"
        });
        v1:CreateDialog({
            Text = "haha wasn't that a good one"
        });
        return;
    elseif v0.TimesInteracted == 2 then
        v1:CreateDialog({
            Text = "gleeb"
        });
        v1:CreateDialog({
            Text = "haha that one was good too wasn't it"
        });
        return;
    elseif v0.TimesInteracted == 3 then
        v1:CreateDialog({
            Text = "gleeb"
        });
        v1:CreateDialog({
            Text = "haha did i get you with that one"
        });
        return;
    elseif v0.TimesInteracted == 4 then
        v1:CreateDialog({
            Text = "gleeb"
        });
        v1:CreateDialog({
            Text = "haha that one's gotta be my funniest one yet"
        });
        return;
    elseif v0.TimesInteracted == 5 then
        v1:CreateDialog({
            Text = "okay dude now you're just dragging it on"
        });
        return;
    else
        v1:CreateDialog({
            Text = "..."
        });
        return;
    end;
end;
return v0;