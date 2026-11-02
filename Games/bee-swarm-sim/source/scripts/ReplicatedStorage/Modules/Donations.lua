local Remotes = game.ReplicatedStorage.Remotes


local module2 = {
	["SilverPack"] = { -- 400R$
		ID = 1880267265,
		Type = "Product",

		String = "Silver Bundle\n\n+1 Silver Egg\n+100 Treats\n+50 Tickets\n+25 Caramel",

		Func = function(Player, PData)
			local Awards = {
				["Silver Egg"] = 1,
				["Treat"] = 100,
				["Ticket"] = 50,
				["Caramel"] = 25,
			}
			Remotes.AlertClient:FireClient(Player, {
				Color = "Blue",
				Msg = "Thank you for purchasing!"
			})
			for i,v in pairs(Awards) do
				PData.Inventory[i] += v
				Remotes.AlertClient:FireClient(Player, {
					Color = "Blue",
					Msg = "+"..v.." "..i
				})
			end
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
		end
	},
	["GoldenPack"] = { -- 800R$
		ID = 1881267381,
		Type = "Product",

		String = "Golden Bundle\n\n+1 Golden Egg\n+250 Tickets\n+10 Strawberry Juice\n+10 Blueberry Juice\n+3 Sprout Beans\n+10 Instant Converter",

		Func = function(Player, PData)
			local Awards = {
				["Golden Egg"] = 1,
				["Ticket"] = 250,
				["Strawberry Juice"] = 10,
				["Blueberry Juice"] = 10,
				["Sprout Bean"] = 3,
				["Instant Converter"] = 10,
			}
			Remotes.AlertClient:FireClient(Player, {
				Color = "Blue",
				Msg = "Thank you for purchasing!"
			})
			for i,v in pairs(Awards) do
				PData.Inventory[i] += v
				Remotes.AlertClient:FireClient(Player, {
					Color = "Blue",
					Msg = "+"..v.." "..i
				})
			end
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
		end
	},
	["DiamondPack"] = { -- 1700R$
		ID = 1881674852,
		Type = "Product",

		String = "Diamond Bundle\n\n+1 Diamond Egg\n+1000 Tickets\n+1000 Sugar\n+25 Energy Drink\n+25 Oil\n+25 Caramel Bottle\n+100 Bee Jar\n+1 Magic Treat\n+25 Sprout Beans\n+10 Instant Converter",

		Func = function(Player, PData)
			local Awards = {
				["Diamond Egg"] = 1,
				["Ticket"] = 1000,
				["Sugar"] = 1000,
				["Energy Drink"] = 25,
				["Oil"] = 25,
				["Caramel Bottle"] = 25,
				["Bee Jar"] = 100,
				["Magic Treat"] = 1,
				["Sprout Bean"] = 25,
				["Instant Converter"] = 50,
			}
			Remotes.AlertClient:FireClient(Player, {
				Color = "Blue",
				Msg = "Thank you for purchasing!"
			})
			for i,v in pairs(Awards) do
				PData.Inventory[i] += v
				Remotes.AlertClient:FireClient(Player, {
					Color = "Blue",
					Msg = "+"..v.." "..i
				})
			end
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
		end
	},
	["Ticket1"] = { -- 1700R$
		ID = 1900781708,
		Type = "Product",

		String = "10 Ticket\n\n+10 Ticket",

		Func = function(Player, PData)
			local Awards = {
				["Ticket"] = 10,
			}
			Remotes.AlertClient:FireClient(Player, {
				Color = "Blue",
				Msg = "Thank you for purchasing!"
			})
			for i,v in pairs(Awards) do
				PData.Inventory[i] += v
				Remotes.AlertClient:FireClient(Player, {
					Color = "Blue",
					Msg = "+"..v.." "..i
				})
			end
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
		end
	},
	["Ticket10"] = { -- 1700R$
		ID = 1900782098,
		Type = "Product",

		String = "100 Tickets\n\n+100 Tickets",

		Func = function(Player, PData)
			local Awards = {
				["Ticket"] = 100,
			}
			Remotes.AlertClient:FireClient(Player, {
				Color = "Blue",
				Msg = "Thank you for purchasing!"
			})
			for i,v in pairs(Awards) do
				PData.Inventory[i] += v
				Remotes.AlertClient:FireClient(Player, {
					Color = "Blue",
					Msg = "+"..v.." "..i
				})
			end
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
		end
	},
	["Ticket100"] = { -- 1700R$
		ID = 1900782099,
		Type = "Product",

		String = "800 Tickets\n\n+800 Tickets",

		Func = function(Player, PData)
			local Awards = {
				["Ticket"] = 800,
			}
			Remotes.AlertClient:FireClient(Player, {
				Color = "Blue",
				Msg = "Thank you for purchasing!"
			})
			for i,v in pairs(Awards) do
				PData.Inventory[i] += v
				Remotes.AlertClient:FireClient(Player, {
					Color = "Blue",
					Msg = "+"..v.." "..i
				})
			end
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
		end
	},
}

return module2