-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Dialog, time of decompilation: Fri Nov 28 21:05:52 2025 ]]
local v0 = {};
local _ = game:GetService("TweenService");
v0.Config = {
    FacePlayer = false, 
    PlayIdleOutsideOfDialog = false
};
v0.Interacted = function(v2) --[[ Line: 10 ]]
    -- upvalues: v0 (copy)
    if not v0.SpokenToBefore then
        v0.SpokenToBefore = true;
        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "MeetDemophon");
        v0.SpokenToBefore = true;
        v2:CreateDialog({
            Text = "Congratulations. You have found me."
        });
        v2:CreateDialog({
            Text = "I am hidden in the water. Away from prying eyes."
        });
        v2:CreateDialog({
            Text = "..."
        });
        v2:CreateDialog({
            Text = "Come, stay here for a moment and listen to my tale."
        });
        v2:CreateDialog({
            Text = "Are you familiar with the story of a Captain and his ship?"
        });
        v2:CreateDialog({
            Text = "Each rotting board of the ship was replaced with newer boards."
        });
        v2:CreateDialog({
            Text = "The repaired ship would be beautiful; full and complete."
        });
        v2:CreateDialog({
            Text = "Many wonder if it is still the same ship."
        });
        v2:CreateDialog({
            Text = "It is correct to assume that the Captain now has a brand new ship."
        });
        v2:CreateDialog({
            Text = "Now I want you to wonder for a moment."
        });
        v2:CreateDialog({
            Text = "What if there was no ship. Just a Captain, building his own ship?"
        });
        v2:CreateDialog({
            Text = "What if this Captain was malicious and depraved. Stealing parts from others ships."
        });
        v2:CreateDialog({
            Text = "Is it his ship now, or is it an amalgamation of stolen parts?"
        });
        local l_v2_UserResponse_0 = v2:GetUserResponse({
            [1] = {
                Choice = "what?"
            }
        });
        local function _() --[[ Line: 67 ]] --[[ Name: cancelDialog ]]
            -- upvalues: v2 (copy)
            v2:CreateDialog({
                Text = "Farewell."
            });
        end;
        v2:ProcessResponse(l_v2_UserResponse_0, {
            [1] = function() --[[ Line: 74 ]]
                -- upvalues: v2 (copy)
                v2:CreateDialog({
                    Text = "In time you will understand."
                });
                v2:CreateDialog({
                    Text = "For it is always here. Listening. Watching."
                });
                v2:CreateDialog({
                    Text = "The captain will never stop in his quest. His ship will be complete."
                });
                v2:CreateDialog({
                    Text = "Goodbye now."
                });
            end
        });
        return;
    else
        v2:CreateDialog({
            Text = "..."
        });
        v2:CreateDialog({
            Text = "I have no more stories to tell you. I wish to swim now."
        });
        return;
    end;
end;
return v0;