script.Parent.MouseButton1Click:connect(function(person)
	
	script.Parent.Parent.Visible = false
	
	wait(0.5)
	
	x = game.Lighting.SwordGui:Clone()
	
	x.Parent = script.Parent.Parent.Parent.Parent
	
	script.Parent.Parent.Parent:Destroy()
	
end)