server = nil
service = nil

return function()
	server.Logs.Kills = {}
	
	-- Super hacky solution, please add a cleaner way to solve this problem :)
	server.Logs.TabToType = function(tab)
		local indToName = {
			Chats = "Chat";
			Joins = "Join";
			Script = "Script";
			Replications = "Replication";
			NetworkOwners = "NetworkOwner";
			RemoteFires = "RemoteFire";
			Commands = "Command";
			Exploit = "Exploit";
			Errors = "Error";
			Kills = "Kills";
		}
		
		for ind,t in next,server.Logs do
			if t == tab then
				return indToName[ind] or ind
			end
		end
	end;
	
	server.Logs.ListUpdaters.GetKillLogs = function()
		return server.Logs.Kills
	end

	service.HookEvent("CharacterAdded", function(plr)
		local humanoid = plr.Character:WaitForChild("Humanoid")
		humanoid.Died:Connect(function()
			local killer = humanoid:FindFirstChild("creator")
			if killer and killer.Value then
				server.Logs.AddLog(server.Logs.Kills, {
					Text = killer.Value.Name .. " killed " .. plr.Name,
					Desc = killer.Value.Name .. " killed " .. plr.Name,
				})
			end
		end)
	end)


	server.Commands.KillLogs = {
		Prefix = server.Settings.Prefix;
		Commands = {"killlogs","klogs"};
		Args = {"autoupdate"};
		Description = "Shows the kill logs.";
		Hidden = false;
		Fun = false;
		Agents = true;
		AdminLevel = "Moderators";
		Function = function(plr,args)
			local auto
			if args[1] and type(args[1]) == "string" and (args[1]:lower() == "yes" or args[1]:lower() == "true") then
				auto = 1
			end
			
			server.Remote.MakeGui(plr, "List", {
				Title = "Kill Logs";
				Tab = server.Logs.Kills;
				Dots = true; 
				Update = "GetKillLogs";
				AutoUpdate = auto;
			})
		end
	}
end