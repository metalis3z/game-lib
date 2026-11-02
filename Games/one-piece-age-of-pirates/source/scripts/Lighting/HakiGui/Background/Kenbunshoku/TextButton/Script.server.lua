script.Parent.MouseButton1Click:connect(function(person)
	
	if script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value < 10000 then
		notenough = game.Lighting.NotEnoughMoney:Clone()
		notenough.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.PlayerGui
		game.Debris:AddItem(notenough, 2)
		return
	end
	
	if script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Kenbunshoku.Value == true then
		alreadymastered = game.Lighting.AlreadyMastered:Clone()
		alreadymastered.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.PlayerGui
		game.Debris:AddItem(alreadymastered, 2)
		return
	end
	
	ken = game.Lighting.Haki.KenbunshokuHaki:Clone()
	ken.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.Backpack
	ken.Disabled = false
	
	script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value = script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value - 10000
	script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Kenbunshoku.Value = true
	script.Parent.Parent.Parent.Parent:Destroy()
	
end)