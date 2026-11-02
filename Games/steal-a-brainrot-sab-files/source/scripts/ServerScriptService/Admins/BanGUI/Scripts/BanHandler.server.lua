
local datastoreservice = game:GetService("DataStoreService") -- These two lines are the datastores
local bandata = datastoreservice:GetDataStore("TimedBans")

script.Parent.Parent.Ban.OnServerEvent:Connect(function(plr,plrtoban,reason,days,status) -- When you fire the server
	local uid = game.Players:GetUserIdFromNameAsync(plrtoban) -- If they aren't in the server, it gets the id anyway with no error unless it's an invalid name
	local ostime = os.time() -- Time
	local days = tonumber(days) -- Because we used a string, we need to convert it into a number for the multiplication to work
	local d = days * 86400 -- Multiplies by how many seconds are in a day
	local length = d + ostime -- Lengh of the ban
	local table2 = {uid,length,reason} -- I made a table here but you could of done bandata:SetAsync(uid,{uid,length,reason})
	bandata:SetAsync(uid,table2) -- Store the data
	status.Text = "Banned: "..plrtoban..""
	if game.Players:FindFirstChild(plrtoban) == nil then
		print("Not in server")
	else
		game.Players:FindFirstChild(plrtoban):Kick("You have been banned\n For: "..reason.."") -- Kick if they are in the server
	end
end)

