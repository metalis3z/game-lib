server = nil
service = nil

return function()	
	server.Logs.ListUpdaters.MoneyLB = function(player, target)
		local tab = {}
		
		if target == "Cash" then
			-----print("cash target")
			--local DataStore = game:GetService("DataStoreService")
			----local store = DataStore:GetDataStore("Stats2")
			--local pages = store:ListKeysAsync()

			--for i, v in pairs(pages:GetCurrentPage()) do
			--	local profile = store:GetAsync(v.KeyName);
			--	print(v.KeyName, profile)
			--end
		end
		
		if target == "Bank" then
			
		end
		
		return tab
	end

	server.Commands.MoneyLB = {
		Prefix = server.Settings.Prefix;
		Commands = {"moneylb","topmoney"};
		Args = {"player","autoupdate"};
		Description = "Shows the top money data.";
		Hidden = false;
		Fun = false;
		Agents = true;
		AdminLevel = "Moderators";
		Function = function(plr,args)
			local auto
			--[[
			
			if args[2] and type(args[2]) == "string" and (args[2]:lower() == "yes" or args[2]:lower() == "true") then
				auto = 1
			end
			
			for _, v in service.GetPlayers(plr, args[1]) do
				server.Remote.MakeGui(plr, "List", {
					Title = 'Money Leaderboard';
					Icon = server.MatIcons["Inventory 2"];
					Table = server.Logs.ListUpdaters.MoneyLB(plr, 'Cash');
					Dots = true; 
					Update = "MoneyLB";
					UpdateArg = 'Cash';
					Size = {280, 225};
					AutoUpdate = auto;
				})
			end
			--]]
		end
	}
end