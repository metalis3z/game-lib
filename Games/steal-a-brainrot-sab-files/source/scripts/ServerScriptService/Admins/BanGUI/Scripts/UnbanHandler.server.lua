
local datastoreservice = game:GetService("DataStoreService") -- These two lines are the datastores
local bandata = datastoreservice:GetDataStore("TimedBans")


script.Parent.Parent.Unban.OnServerEvent:Connect(function(plr,plrtounban,status)
	local uid = game.Players:GetUserIdFromNameAsync(plrtounban) -- They won't be in the game so we get the id 
	bandata:SetAsync(uid,{".",".","."}) -- Sets it to something without the id in the first column in the datastore
	status.Text = "Unbanned: "..plrtounban.."" -- The status message in the gui
end)

-- Considerably shorter script as its more simpler to unban rather than ban