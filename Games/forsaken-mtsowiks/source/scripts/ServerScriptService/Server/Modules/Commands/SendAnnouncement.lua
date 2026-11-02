-- ReplicatedStorage Modules ModeratorCommands SendAnnouncement (paste in SendAnnouncement)
local Filter = true
return {
	LayoutOrder = 10,
	Title = "Send Announcement",
	Name = "SendAnnouncement",
	Parameters = {
		[1] = {
			Type = "Textbox",
			DefaultValue = "",
			Title = "Message",
		},
	},
	Executable = true,
	Executed = function(_, v1, v2) --[[ Line: 17 ]] --[[ Name: Executed ]]
		if typeof(v2) ~= "string" then
			return;
		else
			if Filter == true then
				v2 = game:GetService("Chat"):FilterStringForBroadcast(v2, v1);
			end;
			require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("SendAnnouncement", "REMOTE_EVENT", v2, (("From: %*"):format(v1.DisplayName)));
			return;
		end;
	end,
};