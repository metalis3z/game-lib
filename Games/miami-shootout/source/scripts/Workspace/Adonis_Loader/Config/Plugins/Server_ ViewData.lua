server = nil
service = nil

return function()	

	local function comma_value(amount)
		local formatted = amount
		while true do  
			formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
			if (k==0) then
				break
			end
		end
		return formatted
	end

	server.Logs.ListUpdaters.GetStoredData = function(player, target)
		local tab = {}

		for i,v in pairs(target:FindFirstChild("stored"):GetChildren()) do
			table.insert(tab, {
				Text = v.Name..": "..comma_value(v.Value),
				Desc = "#"..i .. " - "..v.Value
			})
		end

		return tab
	end

	server.Commands.ViewData = {
		Prefix = server.Settings.Prefix;
		Commands = {"data","money","cash","bank","vdata","viewdata"};
		Args = {"player","autoupdate"};
		Description = "View a player's money data.";
		Hidden = false;
		Fun = false;
		Agents = true;
		AdminLevel = "Moderators";
		Function = function(plr,args)
			local auto

			if args[2] and type(args[2]) == "string" and (args[2]:lower() == "yes" or args[2]:lower() == "true") then
				auto = 1
			end

			for _, v in service.GetPlayers(plr, args[1]) do
				server.Remote.MakeGui(plr, "List", {
					Title = v.Name.."'s Money Data";
					Icon = server.MatIcons["Inventory 2"];
					Table = server.Logs.ListUpdaters.GetStoredData(plr, v);
					Dots = true; 
					Update = "GetStoredData";
					UpdateArg = v;
					Size = {280, 225};
					AutoUpdate = auto;
				})
			end

		end
	}

	server.Commands.Change = {
		Prefix = server.Settings.Prefix;
		Commands = {"change"};
		Args = {"player","stat","amount"};
		Description = "Changes a player's stat (FIXED)";
		Hidden = false;
		Fun = false;
		AdminLevel = "Supervisors";
		Function = function(plr,args)

			if not args[1] then return error("No player specified!") end
			if not args[2] then return error("No stat specified!") end
			if not args[3] then return error("No amount specified!") end
			if not tonumber(args[3]) then return error("Invalid amount specified!") end

			local stat = args[2]
			local amount = tonumber(args[3])

			for _, v in service.GetPlayers(plr, args[1]) do
				if v:FindFirstChild("stored"):FindFirstChild(args[2]) then
					v:FindFirstChild("stored"):FindFirstChild(args[2]).Value = amount
				end
			end
		end
	}

	server.Commands.Add = {
		Prefix = server.Settings.Prefix;
		Commands = {"add"};
		Args = {"player","stat","amount"};
		Description = "Add to a player's stat (FIXED)";
		Hidden = false;
		Fun = false;
		AdminLevel = "Supervisors";
		Function = function(plr,args)

			if not args[1] then return error("No player specified!") end
			if not args[2] then return error("No stat specified!") end
			if not args[3] then return error("No amount specified!") end
			if not tonumber(args[3]) then return error("Invalid amount specified!") end

			local stat = args[2]
			local amount = tonumber(args[3])

			for _, v in service.GetPlayers(plr, args[1]) do
				if v:FindFirstChild("stored"):FindFirstChild(args[2]) then
					v:FindFirstChild("stored"):FindFirstChild(args[2]).Value += amount
				end
			end
		end
	}

	server.Commands.Subtract = {
		Prefix = server.Settings.Prefix;
		Commands = {"subtract"};
		Args = {"player","stat","amount"};
		Description = "Add to a player's stat (FIXED)";
		Hidden = false;
		Fun = false;
		AdminLevel = "Supervisors";
		Function = function(plr,args)

			if not args[1] then return error("No player specified!") end
			if not args[2] then return error("No stat specified!") end
			if not args[3] then return error("No amount specified!") end
			if not tonumber(args[3]) then return error("Invalid amount specified!") end

			local stat = args[2]
			local amount = tonumber(args[3])

			for _, v in service.GetPlayers(plr, args[1]) do
				if v:FindFirstChild("stored"):FindFirstChild(args[2]) then
					v:FindFirstChild("stored"):FindFirstChild(args[2]).Value -= amount
				end
			end
		end
	}

	server.Commands.ResetStats = {
		Prefix = server.Settings.Prefix;
		Commands = {"resetstats"};
		Args = {"player"};
		Description = "Reset a player's stats (FIXED)";
		Hidden = false;
		Fun = false;
		AdminLevel = "Supervisors";
		Function = function(plr,args)

			if not args[1] then return error("No player specified!") end

			for _, v in service.GetPlayers(plr, args[1]) do
				for i,v in pairs(v:FindFirstChild("stored"):GetChildren()) do
					v.Value = 0
				end
			end
		end
	}
end