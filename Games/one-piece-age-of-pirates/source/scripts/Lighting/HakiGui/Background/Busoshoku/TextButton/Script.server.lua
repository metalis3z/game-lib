script.Parent.MouseButton1Click:connect(function(person)
	
	if script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value < 10000 then
		notenough = game.Lighting.NotEnoughMoney:Clone()
		notenough.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.PlayerGui
		game.Debris:AddItem(notenough, 2)
		return
	end
	
	if script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Busoshoku.Value == true then
		alreadymastered = game.Lighting.AlreadyMastered:Clone()
		alreadymastered.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.PlayerGui
		game.Debris:AddItem(alreadymastered, 2)
		return
	end
	
	buso = game.Lighting.Haki.BusoshokuHaki:Clone()
	buso.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.Backpack
	buso.Disabled = false
	
	script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value = script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value - 10000
	script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Busoshoku.Value = true
	script.Parent.Parent.Parent.Parent:Destroy()
	
end)