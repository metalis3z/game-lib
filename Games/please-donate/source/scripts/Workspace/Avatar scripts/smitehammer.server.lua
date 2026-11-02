local Command = "/hammer" or "/hammer "

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(chr)
		player.Chatted:Connect(function(msg)

			local Humanoid = chr:WaitForChild("Humanoid")
			local Desc = Humanoid:GetAppliedDescription()
			Desc.BackAccessory = 13405734044

			if msg == Command then
				Humanoid:ApplyDescription(Desc)	
			end

		end)
	end)
end)
