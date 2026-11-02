

local  CD = false


script.Parent.OnOff.TextButton.MouseButton1Click:Connect(function()
	
	if CD == false then
	local Plr = script.Parent.Parent.Parent
	
		if Plr.Character:FindFirstChild("Mask") then
			CD = true
			
			script.Parent.UpDown.Visible = false
		Plr.Character:FindFirstChild("Humanoid"):LoadAnimation(script.Off):Play()
		wait(0.5)
		Plr.Character:FindFirstChild("Mask").Middle.Equip.PlayOnRemove = true
		Plr.Character:FindFirstChild("Mask"):Destroy()
		Plr.Character.Hair.Handle.Transparency = 0
		
		if 	Plr.Character:FindFirstChild("Beard") then
			Plr.Character:FindFirstChild("Beard").Transparency = 0
			
		end
			Plr.Character.Head.Card.Frame.Namey.Text = Plr.CharacterStats.FirstName.Value.." "..Plr.CharacterStats.LastName.Value
			script.Parent.OnOff.TextButton.Text = "Mask On"
			Plr.Character:FindFirstChild("Thermal Mask").Handle.Transparency = 0
			CD = false
	else
		
			CD = true
		Plr.Character:FindFirstChild("Humanoid"):LoadAnimation(script.On):Play()
			wait(0.5)
		local g = game.ReplicatedStorage.Hats.Other.Mask:Clone()
		g.Parent = Plr.Character
		local C = g:GetChildren()
		for i=1, #C do

			local Y = Instance.new("Weld")
			Y.Part0 = Plr.Character.Head
			Y.Part1 = g.Middle
			Y.C0 = CFrame.new(0, 0, 0)
			Y.Parent = Y.Part0
		end
			if 	Plr.Character:FindFirstChild("Beard") then
				Plr.Character:FindFirstChild("Beard").Transparency = 1

			end
			Plr.Character.Hair.Handle.Transparency = 1
			g.Middle.Equip:Play()
			Plr.Character.Head.Card.Frame.Namey.Text = "Masked("..Plr.UserId..")"
			script.Parent.OnOff.TextButton.Text = "Mask Off"
			script.Parent.UpDown.Visible = true
			Plr.Character:FindFirstChild("Thermal Mask").Handle.Transparency = 1
			CD = false
	end
	end
	
	
end)

local CD2 = false


script.Parent.UpDown.TextButton.MouseButton1Click:Connect(function()
	if CD2 == false then
		local Plr = script.Parent.Parent.Parent
		
		if Plr.Character:FindFirstChild("Mask") then
			if Plr.Character:FindFirstChild("Mask").Down.Transparency == 1 then
				
				
				CD2 = true

				Plr.Character:FindFirstChild("Humanoid"):LoadAnimation(script.Down):Play()

				wait(0.5)
script.Parent.UpDown.TextButton.Text = "Mask Up"
				Plr.Character:FindFirstChild("Mask").Down.Transparency = 0
				Plr.Character:FindFirstChild("Mask").Up.Transparency = 1
				Plr.Character:FindFirstChild("Mask").Middle.Equip:Play()

				CD2 = false
				
			else
				if Plr.Character:FindFirstChild("Mask").Down.Transparency == 0 then


					CD2 = true

					Plr.Character:FindFirstChild("Humanoid"):LoadAnimation(script.Up):Play()

					wait(0.5)
					script.Parent.UpDown.TextButton.Text = "Mask Down"
					Plr.Character:FindFirstChild("Mask").Down.Transparency = 1
					Plr.Character:FindFirstChild("Mask").Up.Transparency = 0
					Plr.Character:FindFirstChild("Mask").Middle.Equip:Play()

					CD2 = false
					
					end
				
			end
		
		end		
		
		
		
		
	end
	
	
	
end)