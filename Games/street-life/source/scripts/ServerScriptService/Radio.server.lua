prmy = {
	["Line1"] = "",
	["Line2"] = "",
	["Line3"] = "",
	["Line4"] = "",
	["Line5"] = "",
}

local function filter(plr, msg)
	return game.Chat:FilterStringAsync(msg, plr, plr)
end

game.ReplicatedStorage.Radio.send.OnServerEvent:connect(function(plr, msg)
	if msg == "__*GET" then
		game.ReplicatedStorage.Radio.send:FireClient(plr, prmy, '__*GET')
	else
		msg = plr.Name .. " - "..filter(plr, msg)
		
		if msg == plr.Name .. " - **PANIC BUTTON**" then
			task.spawn(function()
				plr.Character.Head.Police.ImageLabel.ImageColor3 = Color3.new(1, 0, 0)
				task.wait(10)
				plr.Character.Head.Police.ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
			end)
		end
		
		if msg == plr.Name .. " - **PANIC BUTTON**" and prmy["Line5"] == msg then return end
		
		prmy["Line1"] = prmy["Line2"]
		prmy["Line2"] = prmy["Line3"]
		prmy["Line3"] = prmy["Line4"]
		prmy["Line4"] = prmy["Line5"]
		prmy["Line5"] = msg
		
		game.ReplicatedStorage.Radio.send:FireAllClients(prmy)
		return
	end
end)