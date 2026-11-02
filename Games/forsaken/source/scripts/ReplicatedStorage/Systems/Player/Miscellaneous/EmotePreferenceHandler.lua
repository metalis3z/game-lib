-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 5 ]] --[[ Name: Start ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local v2 = require(game.ReplicatedStorage.Modules.Util);
        local v3 = require(game.ReplicatedStorage.Initializer);
        task.delay(3, function() --[[ Line: 13 ]]
            -- upvalues: v2 (copy), l_LocalPlayer_0 (copy), v3 (copy)
            v2.OnCharacterAdded(function(v4) --[[ Line: 14 ]]
                -- upvalues: l_LocalPlayer_0 (ref), v3 (ref)
                v4.DescendantAdded:Connect(function(v5) --[[ Line: 15 ]]
                    -- upvalues: l_LocalPlayer_0 (ref), v4 (copy), v3 (ref)
                    if l_LocalPlayer_0.Character == v4 and not v3.PlayerSettings.PlayerEmotesAffected.Value then
                        return;
                    elseif v5.Name == "PlayerEmoteHand" and v3.PlayerSettings.EmoteHandsDisabled.Value then
                        v5:Destroy();
                        return;
                    elseif v5.Name == "PlayerEmoteVFX" and v3.PlayerSettings.EmoteVFXDisabled.Value then
                        v5:Destroy();
                        return;
                    else
                        if v5.Name == "PlayerEmoteSFX" and v3.PlayerSettings.EmoteSFXDisabled.Value then
                            v5:Destroy();
                        end;
                        return;
                    end;
                end);
            end);
        end);
    end
};