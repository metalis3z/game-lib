-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Send Announcement", 
    LayoutOrder = 10, 
    Executable = true, 
    Parameters = {
        [1] = {
            Title = "Message", 
            Type = "Textbox", 
            DefaultValue = ""
        }
    }, 
    Executed = function(_, v1, v2) --[[ Line: 17 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "string" then
            return;
        else
            if not game["Run Service"]:IsStudio() then
                v2 = game:GetService("Chat"):FilterStringForBroadcast(v2, v1);
            end;
            require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("SendAnnouncement", "REMOTE_EVENT", v2, (("From: %*"):format(v1.DisplayName)));
            return;
        end;
    end
};