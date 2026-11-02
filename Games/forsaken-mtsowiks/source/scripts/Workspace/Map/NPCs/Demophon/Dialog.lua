-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = {}
game:GetService("TweenService")
v_u_1.Config = {
    ["FacePlayer"] = false,
    ["PlayIdleOutsideOfDialog"] = false
}
function v_u_1.Interacted(p_u_2)
    -- upvalues: (copy) v_u_1
    if v_u_1.SpokenToBefore then
        p_u_2:CreateDialog({
            ["Text"] = "..."
        })
        p_u_2:CreateDialog({
            ["Text"] = "I have no more stories to tell you. I wish to swim now."
        })
    else
        v_u_1.SpokenToBefore = true
        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "MeetDemophon")
        v_u_1.SpokenToBefore = true
        p_u_2:CreateDialog({
            ["Text"] = "Congratulations. You have found me."
        })
        p_u_2:CreateDialog({
            ["Text"] = "I am hidden in the water. Away from prying eyes."
        })
        p_u_2:CreateDialog({
            ["Text"] = "..."
        })
        p_u_2:CreateDialog({
            ["Text"] = "Come, stay here for a moment and listen to my tale."
        })
        p_u_2:CreateDialog({
            ["Text"] = "Are you familiar with the story of a Captain and his ship?"
        })
        p_u_2:CreateDialog({
            ["Text"] = "Each rotting board of the ship was replaced with newer boards."
        })
        p_u_2:CreateDialog({
            ["Text"] = "The repaired ship would be beautiful; full and complete."
        })
        p_u_2:CreateDialog({
            ["Text"] = "Many wonder if it is still the same ship."
        })
        p_u_2:CreateDialog({
            ["Text"] = "It is correct to assume that the Captain now has a brand new ship."
        })
        p_u_2:CreateDialog({
            ["Text"] = "Now I want you to wonder for a moment."
        })
        p_u_2:CreateDialog({
            ["Text"] = "What if there was no ship. Just a Captain, building his own ship?"
        })
        p_u_2:CreateDialog({
            ["Text"] = "What if this Captain was malicious and depraved. Stealing parts from others ships."
        })
        p_u_2:CreateDialog({
            ["Text"] = "Is it his ship now, or is it an amalgamation of stolen parts?"
        })
        local v3 = {
            {
                ["Choice"] = "what?"
            }
        }
        p_u_2:ProcessResponse(p_u_2:GetUserResponse(v3), { function()
                -- upvalues: (copy) p_u_2
                p_u_2:CreateDialog({
                    ["Text"] = "In time you will understand."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "For it is always here. Listening. Watching."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "The captain will never stop in his quest. His ship will be complete."
                })
                p_u_2:CreateDialog({
                    ["Text"] = "Goodbye now."
                })
            end })
    end
end
return v_u_1