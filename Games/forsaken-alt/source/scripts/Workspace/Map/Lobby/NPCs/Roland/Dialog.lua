-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
v0.Config = {
    PlayIdleOutsideOfDialog = true, 
    VoiceSFX = "rbxassetid://95263724367762", 
    Poses = {
        Idle = "rbxassetid://180435571"
    }
};
v0.Interacted = function(v2) --[[ Line: 14 ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0.TimesInteracted then
        v0.TimesInteracted = 0;
    end;
    local l_v0_0 = v0;
    l_v0_0.TimesInteracted = l_v0_0.TimesInteracted + 1;
    if v0.TimesInteracted == 9 then
        script.Parent.Name = "Roland?";
    elseif v0.TimesInteracted == 10 then
        script.Parent.Name = "Roland Cosplayer";
    end;
    if v0.TimesInteracted < 10 then
        l_v0_0 = v1:Play("rbxassetid://73136812934449", {
            PlaybackSpeed = math.clamp((10 - v0.TimesInteracted / 2 + 2) / 10, 0.5, 1)
        });
        local v4 = "..";
        for _ = 1, v0.TimesInteracted do
            v4 = v4 .. ".";
        end;
        v2:CreateDialog({
            Text = v4
        });
        game.TweenService:Create(l_v0_0, TweenInfo.new(0.25), {
            Volume = 0
        }):Play();
        game.Debris:AddItem(l_v0_0, 0.25);
        return;
    elseif v0.TimesInteracted == 10 then
        v2:CreateDialog({
            Text = "i dont rlly know how i got here to be honest with you"
        });
        return;
    else
        v2:CreateDialog({
            Text = "i wanna go back to the cosplay contest"
        });
        return;
    end;
end;
return v0;