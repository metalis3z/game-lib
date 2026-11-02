local db = true


script.Parent.MouseButton1Click:Connect(function()
	if db == true then
		db = false
		script.Parent.Text = ("On")
		local d = game.Workspace:GetDescendants()
		
		for i, v in pairs(d) do
			if v:IsA("Sound") then
				if v.Parent.Parent.Name == ("Boombox") then
					v.Volume = 0
				end
			end
		end
		
		
	else
		db = true
		script.Parent.Text = ("Off")
		local d = game.Workspace:GetDescendants()

		for i, v in pairs(d) do
			if v:IsA("Sound") then
				if v.Parent.Parent.Name == ("Boombox") then
					v.Volume = 0.4
				end
			end
		end
		
	end
end)



while true do
	wait()
	if db == false then
		local d = game.Workspace:GetDescendants()

		for i, v in pairs(d) do
			if v:IsA("Sound") then
				if v.Parent.Parent.Name == ("Boombox") then
					v.Volume = 0
				end
			end
		end
	end
end
