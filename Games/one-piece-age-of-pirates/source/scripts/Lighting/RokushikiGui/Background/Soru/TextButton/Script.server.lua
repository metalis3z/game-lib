script.Parent.MouseButton1Click:connect(function(person)
	
	if script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value < 5000 then
		notenough = game.Lighting.NotEnoughMoney:Clone()
		notenough.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.PlayerGui
		game.Debris:AddItem(notenough, 2)
		return
	end
	
	if script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Soru.Value == true then
		alreadymastered = game.Lighting.AlreadyMastered:Clone()
		alreadymastered.Parent = script.Parent.Parent.Parent.Parent.Parent.Parent.PlayerGui
		game.Debris:AddItem(alreadymastered, 2)
		return
	end
	
	person = script.Parent.Parent.Parent.Parent.Parent.Parent
	
	soru = game.Lighting.Rokushiki.Soru:Clone()
	soru.Parent = person.Backpack
	soru.Disabled = false
	
	script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value = script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Money.Value - 5000
	script.Parent.Parent.Parent.Parent.Parent.Parent.Data.Soru.Value = true
	script.Parent.Parent.Parent.Parent:Destroy()
	
end)