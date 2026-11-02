-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = true, 
        VoiceSFX = "rbxassetid://140647479280509", 
        Poses = {
            Idle = "rbxassetid://180435571"
        }, 
        Actions = {
            Wave = "rbxassetid://128777973"
        }
    }
};
v0.Interacted = function(v1) --[[ Line: 15 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        v1:CreateDialog({
            Text = "<Color=Red>HELP<Color=/> I WAS STUCK ON THIS WALL AND I CANT GET OUT"
        });
        v1:CreateDialog({
            Text = "<Color=Red>DUDE<Color=/> AHHHHHHHHHHHH"
        });
        return;
    else
        require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://1007368252", {
            Parent = script.Parent.PrimaryPart
        });
        v1:CreateDialog({
            Text = "<Color=Red>AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHH<Color=/>"
        });
        return;
    end;
end;
return v0;