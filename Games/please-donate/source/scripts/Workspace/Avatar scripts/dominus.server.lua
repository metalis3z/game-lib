local Command = "/dominus" or "/dominus "

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(chr)
		player.Chatted:Connect(function(msg)

			local Humanoid = chr:WaitForChild("Humanoid")
			local Desc = Humanoid:GetAppliedDescription()
			Desc.HatAccessory = 138932314

			if msg == Command then
				Humanoid:ApplyDescription(Desc)	
			end

		end)
	end)
end)
