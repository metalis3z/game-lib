








if script.Parent.Parent:IsA("Seat") then
	script.Parent.Parent.ChildAdded:connect(function(child)
		if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			
			
			game.ReplicatedStorage.cartings:FireClient(p,"IN CAR")
			
			
			
			
			
			local g=script.G:Clone()
			g.Parent=p.PlayerGui
			g:WaitForChild("src")
			g.src.Value=script.Parent
			g.Drv.Disabled=false		
		end
	end)
	script.Parent.Parent.ChildRemoved:connect(function(child)
		if child:IsA("Weld") then
			local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
			
			
			game.ReplicatedStorage.cartings:FireClient(p,"LEAVE CAR")
			
			
			
			
			wait(.1)
			if p.PlayerGui:FindFirstChild("G") then p.PlayerGui:FindFirstChild("G"):Destroy() end
			
			
	
		end
	end)
end