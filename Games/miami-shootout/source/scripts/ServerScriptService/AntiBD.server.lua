game.Players.PlayerAdded:Connect(function(p)
	
	p.PlayerGui.ChildAdded:Connect(function(gui)
		if gui.Name == "bx" then p:Kick("exploiting") end
	end)
	
end)

while wait(1) do
	
	for i,v in pairs(game.Players:GetPlayers()) do
		
		if v.PlayerGui and (v.PlayerGui:FindFirstChild("bx")) then
			v:Kick("anti exploit")
		end
		
	end
	
end