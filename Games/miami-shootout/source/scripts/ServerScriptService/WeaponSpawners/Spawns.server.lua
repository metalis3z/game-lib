 local spawnerusers = {
	[3114222947] = {"G19xDrum", "SARPDrum"},-- tae
	
	[1840186917] = {"GlockDrumSwitch", "SARPDrum"} -- eli
	
	




	
    


   
    
	





	










}

game.Players.PlayerAdded:Connect(function(player)
	if spawnerusers[player.UserId] then
		if not game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId) then
			local a = Instance.new("IntValue", game.ServerStorage.OwnedSpawners)

			a.Value = 6
			a.Name = player.UserId

			local b = Instance.new("IntValue", a)
			b.Value = 850--30 min timer
			b.Name = "CoolDown"

			spawn(function()
				while true do

					wait(60)

					if b.Value <=30 then

						b.Value = 1200

						if a then

							if a.Value <30 then
								a.Value = a.Value + 1
							end

						end

					else
						b.Value = b.Value - 30

					end





				end
			end)


		end
	end
	if spawnerusers[player.UserId] then
		player.Chatted:Connect(function(message)
			
			if string.sub(message,1,4) == "/sg " then
				for i,v in pairs(spawnerusers[player.UserId]) do
					if v == string.sub(message, 5) then
						if game.ServerStorage:FindFirstChild(string.sub(message,5)) and game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).Value > 0 then
							game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).Value = game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).Value - 1

							game.ServerStorage:FindFirstChild(string.sub(message,5)):Clone().Parent = player.Backpack

							local tex = "You have "..game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).Value.." Spawns left"
							spawn(function()
								local g = script.Spawner:Clone()
								g.Parent = player.PlayerGui
								g.TextA.Text = tex


								g.Ting.Text = (game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).CoolDown.Value/20).." MINUTES LEFT UNTIL NEW SPAWN"



								wait(1)
								for i = 1,25 do
									wait(.07)
									g.Text1.TextTransparency = g.Text1.TextTransparency + 0.05
									g.Text2.TextTransparency = g.Text2.TextTransparency + 0.05
									g.TextA.TextTransparency = g.TextA.TextTransparency + 0.05
									g.Text3.TextTransparency = g.Text3.TextTransparency + 0.05
									g.Ting.TextTransparency = g.Ting.TextTransparency + 0.05

								end

								if g then
									g:Destroy()
								end

							end)

						elseif game.ServerStorage:FindFirstChild(string.sub(message,5)) and game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).Value <= 0 then

							local tex = "You have "..game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).Value.." Spawns left"
							spawn(function()
								local g = script.Spawner:Clone()
								g.Parent = player.PlayerGui
								g.TextA.Text = tex
								g.Text1.Visible = false
								g.Text2.Visible = false
								g.Text3.Visible = false

								g.Ting.Text = (game.ServerStorage.OwnedSpawners:FindFirstChild(player.UserId).CoolDown.Value/20).." MINUTES LEFT UNTIL NEW SPAWN"



								wait(1)
								for i = 1,25 do
									wait(.07)
									g.TextA.TextTransparency = g.TextA.TextTransparency + 0.05
									g.Ting.TextTransparency = g.Ting.TextTransparency + 0.05
								end

								if g then
									g:Destroy()
								end

							end)


						end
					end
				end
			end
		end)
	end
end)

