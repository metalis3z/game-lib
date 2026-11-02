-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Send Global Announcement", 
    LayoutOrder = 11, 
    Executable = true, 
	ResetOnExecution = true, 
	RequiredRank = "HeadModerator",
	AllowedInVIP = false,
    Parameters = {
        [1] = {
            Title = "Message", 
            Type = "Textbox", 
            DefaultValue = ""
        }
    }, 
    Executed = function(_, v1, v2) --[[ Line: 18 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "string" then
            return;
        else
            if not game["Run Service"]:IsStudio() then
                v2 = game:GetService("Chat"):FilterStringForBroadcast(v2, v1);
			end;
            game:GetService("MessagingService"):PublishAsync("GlobalMessages", (("%*||%*"):format(v2, v1.DisplayName)));
            return;
        end;
    end
};