server = nil
service = nil

return function()	
	server.Logs.ListUpdaters.GetSafeData = function(player, target)
		local tab = {}
		
		for i,v in pairs(target:FindFirstChild("InvData"):GetChildren()) do
			table.insert(tab, {
				Text = v.Name,
				Desc = "Tool #"..i
			})
		end
		
		return tab
	end

	server.Commands.ViewSafe = {
		Prefix = server.Settings.Prefix;
		Commands = {"viewsafe","safe"};
		Args = {"player","autoupdate"};
		Description = "View a player's safe.";
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
					Title = v.Name.."'s Safe Data";
					Icon = server.MatIcons["Inventory 2"];
					Table = server.Logs.ListUpdaters.GetSafeData(plr, v);
					Dots = true; 
					Update = "GetSafeData";
					UpdateArg = v;
					Size = {280, 225};
					AutoUpdate = auto;
				})
			end
			
		end
	}
	
	local function shallowCopy(original)
		local copy = {}
		for key, value in pairs(original) do
			copy[key] = value
		end
		return copy
	end
	
	server.Commands.AddSafe = {
		Prefix = server.Settings.Prefix;
		Commands = {"asafe","addsafe"};
		Args = {"player","item"};
		Description = "Adds item to player's safe";
		Hidden = false;
		Fun = false;
		AdminLevel = "Supervisors";
		Function = function(plr,args)
			
			if not args[1] then return error("No player specified!") end
			if not args[2] then return error("No item specified!") end
			
			local item = shallowCopy(args)
			table.remove(item,1)
			
			item = table.concat(item," ")
			
			print("ADDING ITEM NAMED "..item)
			
			local found = game:GetService("ReplicatedStorage"):WaitForChild("Items"):FindFirstChild(item)
			
			if not found then return error("No item with that name found!") end
			
			for _, v in service.GetPlayers(plr, args[1]) do
				local x = Instance.new("IntValue", v:WaitForChild("InvData"))
				x.Name = item
				server.Admin.RunCommand(server.Settings.Prefix.."notify "..plr.Name .. " Added 1x "..item.." to "..v.Name.."'s safe")
			end
		end
	}
	
	server.Commands.ClearSafe = {
		Prefix = server.Settings.Prefix;
		Commands = {"csafe","clearsafe"};
		Args = {"player"};
		Description = "Clears a player's safe";
		Hidden = false;
		Fun = false;
		AdminLevel = "Supervisors";
		Function = function(plr,args)

			if not args[1] then return error("No player specified!") end

			for _, v in service.GetPlayers(plr, args[1]) do
				local inv = v:FindFirstChild("InvData")
				if inv and #inv:GetChildren() ~= 0 then
					inv:ClearAllChildren()
					server.Admin.RunCommand(server.Settings.Prefix.."notify "..plr.Name .. " Cleared "..v.Name.."'s safe")
				end
			end
		end
	}
	
	server.Commands.RemoveSafe = {
		Prefix = server.Settings.Prefix;
		Commands = {"rsafe","removesafe"};
		Args = {"player","item","removeAllCopies (optional)"};
		Description = "Removes an item from player's safe";
		Hidden = false;
		Fun = false;
		AdminLevel = "Supervisors";
		Function = function(plr,args)

			if not args[1] then return error("No player specified!") end
			if not args[2] then return error("No item specified!") end
			
			local removeAll = false
			
			if args[3] then
				if string.lower(args[3]) == "yes" or string.lower(args[3]) == "true" then
					removeAll = true
				end
			end
			
			local item = shallowCopy(args)
			table.remove(item,1)

			item = table.concat(item," ")

			print("REMOVING ITEM NAMED "..item)

			local found = game:GetService("ReplicatedStorage"):WaitForChild("Items"):FindFirstChild(item)

			if not found then return error("No item with that name found!") end

			for _, v in service.GetPlayers(plr, args[1]) do
				
				if v:FindFirstChild("InvData"):FindFirstChild(item) then
					local count = 0
					if removeAll then
						for i,v in pairs(v:FindFirstChild("InvData"):GetChildren()) do
							if v.Name == item then
								v:Destroy()
								count = count + 1
							end
						end
					else
						count = 1
						v:FindFirstChild("InvData"):FindFirstChild(item):Destroy()
					end
					
					server.Admin.RunCommand(server.Settings.Prefix.."notify "..plr.Name .. " Removed "..count.."x"..item.." from "..v.Name.."'s safe")
				end
				
			end
		end
	}
end