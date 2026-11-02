local var = math.random(1,6)

script.Parent.Zombie.Died:connect(function()
	game.ReplicatedStorage.Values.zombiesAlive.Value = game.ReplicatedStorage.Values.zombiesAlive.Value - 1
	math.randomseed(tick())
	script.Disabled = true
	math.random(1,6)
		if var == 1 then
			script.Parent.Head.Death1:Play()
		end
		if var == 2 then
			script.Parent.Head.Death2:Play()
		end
		if var == 3 then
			script.Parent.Head.Death3:Play()
		end
		if var == 4 then
			script.Parent.Head.Death4:Play()
		end
		if var == 5 then
			script.Parent.Head.Death5:Play()
		end
		if var == 6 then
			script.Parent.Head.Death6:Play()
		end
	wait(1)
	script.Parent:Destroy()
	
end)