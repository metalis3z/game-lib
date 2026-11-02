server = nil
service = nil

local ranks = {
	[0] = "Players",
	[100] = "Police Officer",
	[150] = "Game Mod",
	[200] = "Moderator",
	[300] = "Admin",
	[400] = "Head Admin",
	[500] = "Supervisor",
	[900] = "Owner",
	[1000] = "Owner"
}

return function()
		
	server.Commands.ShowRank = {
		Prefix = server.Settings.Prefix;
		Commands = {"showrank"};
		Args = {"player"};
		Description = "Toggles overhead admin rank GUI";
		Hidden = false;
		Fun = false;
		Agents = true;
		AdminLevel = 150;
		Function = function(plr,args)
			for _, v in service.GetPlayers(plr, args[1]) do
				local plrLevel = _G.Adonis.GetLevel(v)
				if plrLevel >= 150 and ranks[plrLevel] then
					if not v.Character.Head:FindFirstChild("ADMINRANK") then
						local gui = script.Gui:Clone()
						gui.Parent = v.Character.Head
						gui.MainFrame.rank.Text = "("..string.upper(ranks[plrLevel])..")"
						gui.Name = "ADMINRANK"
					else
						v.Character.Head:FindFirstChild("ADMINRANK"):Destroy()
					end
				end
			end
		end
	}

end