-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        if workspace:GetAttribute("Testing") then
            return;
        else
            local function _(v1) --[[ Line: 10 ]] --[[ Name: ToggleChat ]]
                game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = v1;
            end;
            require(game.ReplicatedStorage.Modules.Util).OnPlayingStateChanged(function(v3) --[[ Line: 18 ]]
                local v4 = v3 == "Spectating";
                game:GetService("TextChatService"):FindFirstChildOfClass("ChatWindowConfiguration").Enabled = v4;
            end);
            return;
        end;
    end
};