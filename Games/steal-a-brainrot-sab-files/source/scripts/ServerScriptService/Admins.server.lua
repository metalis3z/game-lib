-- ░█████╗░░█████╗░██████╗░███████╗██████╗░  ██████╗░██╗░░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗  ██╔══██╗╚██╗░██╔╝
--██║░░╚═╝██║░░██║██║░░██║█████╗░░██║░░██║  ██████╦╝░╚████╔╝░
--██║░░██╗██║░░██║██║░░██║██╔══╝░░██║░░██║  ██╔══██╗░░╚██╔╝░░
--╚█████╔╝╚█████╔╝██████╔╝███████╗██████╔╝  ██████╦╝░░░██║░░░
--░╚════╝░░╚════╝░╚═════╝░╚══════╝╚═════╝░  ╚═════╝░░░░╚═╝░░░

--██╗░░██╗░█████╗░░██████╗███████╗███████╗██████╗░░█████╗░██╗░░░░░██╗░█████╗░░█████╗░
--██║░░██║██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗██╔══██╗██║░░░░░██║██╔══██╗██╔══██╗
--███████║███████║╚█████╗░█████╗░░█████╗░░██████╦╝███████║██║░░░░░██║╚█████╔╝██║░░██║
--██╔══██║██╔══██║░╚═══██╗██╔══╝░░██╔══╝░░██╔══██╗██╔══██║██║░░░░░██║██╔══██╗██║░░██║
--██║░░██║██║░░██║██████╔╝███████╗███████╗██████╦╝██║░░██║███████╗██║╚█████╔╝╚█████╔╝
--╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝╚══════╝╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░╚════╝░░╚════╝░

-- I've added some notes on what the specific lines/functions do
-- BanGUI is in this script, These all go to ServerScriptService. To get the ui, put your userid in the admins section where mine is
-- This system and ui is free to use
-- You can delete the folders when you have put the things in the right place

local admins = {1557378019,11465819882,4549104887}

game.Players.PlayerAdded:Connect(function(plr) -- When a player joins
	for i,v in pairs(admins) do -- Go through the values in the table called admins
		if v == plr.UserId then -- if the id in the table
			local cl = script.BanGUI:Clone() -- clone the gui
			cl.Parent = plr.PlayerGui -- put it in the player's gui
		end
	end
end)