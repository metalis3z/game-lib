local deb = false
script.Parent.MouseButton1Click:Connect(function() 
	if deb == false then
		deb = true
		for i,v in pairs(game.Workspace.Map.Nature:GetChildren()) do
			v:Destroy()
		end
	end
end)