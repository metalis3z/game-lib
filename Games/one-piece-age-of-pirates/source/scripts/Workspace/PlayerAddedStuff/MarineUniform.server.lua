game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		
	wait(3)

	if player.Data.Side.Value == "Marine" then
		if player.Data.Bounty.Value <= 45000000 then
			if player.Character:FindFirstChild("Shirt") ~= nil then
				player.Character.Shirt:Destroy()
				player.Character.Pants:Destroy()
				local shirt = Instance.new("Shirt")
				shirt.Name = "Shirt"
				shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=187383126"
				shirt.Parent = player.Character
				wait(0.1)
				local pants = Instance.new("Pants")
				pants.Name = "Pants"
				pants.PantsTemplate = "http://www.roblox.com/asset/?id=149168051"
				pants.Parent = player.Character
			
			else
				local shirt = Instance.new("Shirt")
				shirt.Name = "Shirt"
				shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=187383126"
				shirt.Parent = player.Character
				wait(0.1)
				local pants = Instance.new("Pants")
				pants.Name = "Pants"
				pants.PantsTemplate = "http://www.roblox.com/asset/?id=149168051"
				pants.Parent = player.Character
				
			end
		end
	end
	
	if player.Data.Side.Value == "Marine" then
		if player.Data.Bounty.Value >= 45000001 then
			if player.Character.Shirt ~= nil then
				player.Character.Shirt:Destroy()
				player.Character.Pants:Destroy()
				local shirt2 = Instance.new("Shirt")
				shirt2.Name = "Shirt"
				shirt2.ShirtTemplate = "http://www.roblox.com/asset/?id=157167709"
				shirt2.Parent = player.Character
				wait(0.1)
				local pants2 = Instance.new("Pants")
				pants2.Name = "Pants"
				pants2.PantsTemplate = "http://www.roblox.com/asset/?id=157167741"
				pants2.Parent = player.Character
				
			else
				local shirt2 = Instance.new("Shirt")
				shirt2.Name = "Shirt"
				shirt2.ShirtTemplate = "http://www.roblox.com/asset/?id=157167709"
				shirt2.Parent = player.Character
				wait(0.1)
				local pants2 = Instance.new("Pants")
				pants2.Name = "Pants"
				pants2.PantsTemplate = "http://www.roblox.com/asset/?id=157167741"
				pants2.Parent = player.Character
			end
		end
	end
end)
end)