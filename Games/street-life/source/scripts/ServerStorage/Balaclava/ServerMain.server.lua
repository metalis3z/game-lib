local data = require(game.ServerScriptService.ProfileCache)

script.Parent.RemoteEvent.OnServerEvent:Connect(function(Player, On, Humanoid)
	if On then
		local d = Humanoid.Parent:GetChildren() 
		for i=1, #d do 
			if (d[i].className == "Accessory") and d[i].Name ~= "DuffleBagAccessory" then
				if not string.find(d[i].Name, 'Normal Vest') then
					d[i].Handle.Transparency = 1
				end
			end
		end
		if Humanoid.Parent:FindFirstChild('TacticalBala') then
			Humanoid.Parent:FindFirstChild('TacticalBala'):Destroy()
		end
		
		game:FindService('ReplicatedStorage'):FindFirstChild('OutfitsOk'):FindFirstChild('TacticalBala'):Clone().Parent = Humanoid.Parent
		script.Parent.Handle.Transparency = 1
		Humanoid.Parent.Head:FindFirstChildOfClass('BillboardGui').TextLabel.Text = "*MASKED*"
	else
		local d = Humanoid.Parent:GetChildren() 
		for i=1, #d do 
			if (d[i].className == "Accessory") then 
				d[i].Handle.Transparency = 0
			end
		end
		if Humanoid.Parent:FindFirstChild('TacticalBala') then
			Humanoid.Parent:FindFirstChild('TacticalBala'):Destroy()
		end
		
		script.Parent.Handle.Transparency = 0
		local CurrentName = Player.DisplayName .. ' (@' .. Player.Name .. ')'

		if data.customname ~= nil and  data.customname ~= '' then
			CurrentName =  data.customname
		end
		if data.customemoji ~= nil and data.customemoji ~= '' then
			CurrentName = '[' .. data.customemoji .. '] ' .. CurrentName
		end
		
		local Name = data[Player].Data.customname
		local Emoji = data[Player].Data.customemoji

		local CurrentName = Player.DisplayName .. ' (@' .. Player.Name .. ')'

		if Name ~= nil and Name ~= '' then
			CurrentName = Name
		end

		if Emoji ~= nil and Emoji ~= '' then
			CurrentName = '[' .. Emoji .. '] ' .. CurrentName
		end

		Humanoid.Parent.Head:FindFirstChildOfClass('BillboardGui').TextLabel.Text = CurrentName
	end
end)