-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Config = {
        FacePlayer = false, 
        PlayIdleOutsideOfDialog = false, 
        VoiceSFX = "rbxassetid://107648255423077", 
        Poses = {
            Idle = "rbxassetid://180435571"
        }
    }, 
    Interacted = function(v0) --[[ Line: 12 ]]
        local l_FirstChild_0 = game.Players.LocalPlayer.PlayerData.Settings:FindFirstChild("AFK", true);
        if not l_FirstChild_0 then
            return;
        else
            local v2 = require(game.ReplicatedStorage.Modules.Network);
            v0:CreateDialog({
                Text = "You look at the hypnotizing movements of the grandfather clock. Even it can't tell the real time."
            });
            v0:ProcessResponse(v0:GetUserResponse({
                [1] = {
                    Choice = "Enable AFK Mode"
                }, 
                [2] = {
                    Choice = "Disable AFK Mode"
                }, 
                [3] = {
                    Choice = "Cancel"
                }
            }), {
                [1] = function() --[[ Line: 26 ]]
                    -- upvalues: v2 (copy), l_FirstChild_0 (copy), v0 (copy)
                    v2:FireServerConnection("UpdateSettings", "REMOTE_EVENT", l_FirstChild_0, true);
                    v0:CreateDialog({
                        Text = "You suddenly feel at peace."
                    });
                end, 
                [2] = function() --[[ Line: 30 ]]
                    -- upvalues: v2 (copy), l_FirstChild_0 (copy), v0 (copy)
                    v2:FireServerConnection("UpdateSettings", "REMOTE_EVENT", l_FirstChild_0, false);
                    v0:CreateDialog({
                        Text = "You suddenly start to feel worried."
                    });
                end, 
                [3] = function() --[[ Line: 34 ]]

                end
            });
            return;
        end;
    end
};