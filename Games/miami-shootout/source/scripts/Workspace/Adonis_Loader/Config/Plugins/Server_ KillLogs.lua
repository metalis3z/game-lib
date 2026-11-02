server = nil
service = nil

return function()
	server.Logs.Kills = {}
	server.Logs.Money = {}
	server.Logs.Arrests = {}

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
			Money = "Money";
			Arrests = "Arrests";
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
	
	server.Logs.ListUpdaters.GetMoneyLogs = function()
		return server.Logs.Money
	end
	
	server.Logs.ListUpdaters.GetArrestLogs = function()
		return server.Logs.Arrests
	end

	service.HookEvent("CharacterAdded", function(plr)
		local humanoid = plr.Character:WaitForChild("Humanoid")
		humanoid.Died:Connect(function()
			local killer = humanoid:FindFirstChild("creator")
			if killer and killer.Value then
				
				local desc = "Using unknown"
				local toolName = "Unknown"
				
				if killer.Value and killer.Value.Character then
					if killer.Value.Character:FindFirstChildWhichIsA("Tool") then
						desc = "Using "..killer.Value.Character:FindFirstChildWhichIsA("Tool").Name
						toolName = killer.Value.Character:FindFirstChildWhichIsA("Tool").Name
					end
				end
				
				-- BODYCAM
				spawn(function()
					if killer.Value and killer.Value.Team and killer.Value.Team == game.Teams.Police then
						print("police kill")
						local function Format(Int)
							return string.format("%02i", Int)
						end

						local function convertToHMS(Seconds)
							local Minutes = (Seconds - Seconds%60)/60
							Seconds = Seconds - Minutes*60
							local Hours = (Minutes - Minutes%60)/60
							Minutes = Minutes - Hours*60
							return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
						end

						game.ReplicatedStorage.SendEmbed:Fire("bcam","["..convertToHMS(time()).."] **"..killer.Value.Name.."** has killed **"..plr.Name.."** using **"..toolName.."**!")
					end
				end)
				
				spawn(function()
					if plr and plr.Team and plr.Team == game.Teams.Police then
						print("police killed")
						local function Format(Int)
							return string.format("%02i", Int)
						end

						local function convertToHMS(Seconds)
							local Minutes = (Seconds - Seconds%60)/60
							Seconds = Seconds - Minutes*60
							local Hours = (Minutes - Minutes%60)/60
							Minutes = Minutes - Hours*60
							return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
						end

						game.ReplicatedStorage.SendEmbed:Fire("bcam","["..convertToHMS(time()).."] **"..plr.Name.."** has died to **"..killer.Value.Name.."** using **"..toolName.."**!")
					end
				end)
				
				server.Logs.AddLog(server.Logs.Kills, {
					Text = killer.Value.Name .. " killed " .. plr.Name,
					Desc = desc,
				})
			end
		end)
	end)
	
	game.ReplicatedStorage.MoneyLog.Event:Connect(function(msg,desc)
		server.Logs.AddLog(server.Logs.Money, {
			Text = msg,
			Desc = desc,
		})
	end)
	
	game.ReplicatedStorage.ArrestLog.Event:Connect(function(msg,desc)
		server.Logs.AddLog(server.Logs.Arrests, {
			Text = msg,
			Desc = desc,
		})
	end)
	
	server.Commands.KillLogs = {
		Prefix = server.Settings.Prefix;
		Commands = {"killlogs","klogs"};
		Args = {"autoupdate"};
		Description = "Shows the kill logs.";
		Hidden = false;
		Fun = false;
		Agents = true;
		AdminLevel = 150;
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
	
	server.Commands.MoneyLogs = {
		Prefix = server.Settings.Prefix;
		Commands = {"moneylogs","mlogs"};
		Args = {"autoupdate"};
		Description = "Shows the money logs.";
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
				Title = "Money Logs";
				Tab = server.Logs.Money;
				Dots = true; 
				Update = "GetMoneyLogs";
				AutoUpdate = auto;
			})
		end
	}
	
	server.Commands.ArrestLogs = {
		Prefix = server.Settings.Prefix;
		Commands = {"arrestlogs","alogs"};
		Args = {"autoupdate"};
		Description = "Shows the arrest logs.";
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
				Title = "Arrest Logs";
				Tab = server.Logs.Arrests;
				Dots = true; 
				Update = "GetArrestLogs";
				AutoUpdate = auto;
			})
		end
	}
	
	local cache = require(game.ServerScriptService.ProfileCache)
	
	server.Commands.ClearArrests = {
		Prefix = server.Settings.Prefix;
		Commands = {"carrests","cleararrests"};
		Args = {"player"};
		Description = "Removes a player's arrests data";
		Hidden = false;
		Fun = false;
		Agents = true;
		AdminLevel = 500;
		Function = function(plr,args)
			for _, v in service.GetPlayers(plr, args[1]) do
				if cache[plr] and cache[plr].Data then
					cache[plr].Data.arrests = {}
					server.Admin.RunCommand(server.Settings.Prefix.."notify "..plr.Name.." Removed "..v.Name.."'s arrests!")
				end
			end
		end
	}
	
	server.Commands.Unsuspend = {
		Prefix = server.Settings.Prefix;
		Commands = {"unsuspend"};
		Args = {"player"};
		Description = "Unsuspends a player's job actions";
		Hidden = false;
		Fun = false;
		Agents = true;
		AdminLevel = "Moderators";
		Function = function(plr,args)
			for _, v in service.GetPlayers(plr, args[1]) do
				if _G.suspended[v.UserId] then
					_G.suspended[v.UserId] = nil
					server.Admin.RunCommand(server.Settings.Prefix.."notify "..plr.Name.." Unsuspended "..v.Name.."'s actions!")
				else
					server.Admin.RunCommand(server.Settings.Prefix.."notify "..plr.Name.." "..v.Name.." is not suspended.")
				end
			end
		end
	}
end