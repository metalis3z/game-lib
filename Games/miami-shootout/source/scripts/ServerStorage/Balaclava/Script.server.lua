







script.Parent.Equipped:Connect(function()
	
	 gui = script.Mask:Clone()
	gui.Parent = game.Players:FindFirstChild(script.Parent.Parent.Name).PlayerGui
	
	local char = script.Parent.Parent
	if char:FindFirstChild("Mask") then
		
		gui.OnOff.TextButton.Text = "Mask Off"
		gui.UpDown.Visible = true
		
		
		if char:FindFirstChild("Mask").Up.Transparency == 1 then
			
			gui.UpDown.TextButton.Text =  "Mask Up"
		end
		
		if char:FindFirstChild("Mask").Down.Transparency == 1 then

			gui.UpDown.TextButton.Text =  "Mask Down"
		end
	end
end)


script.Parent.Unequipped:Connect(function()
	gui:Destroy()
	
end)