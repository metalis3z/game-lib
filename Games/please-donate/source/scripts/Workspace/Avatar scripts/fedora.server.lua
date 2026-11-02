local Command = "/fedora" or "/fedora "

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(chr)
		player.Chatted:Connect(function(msg)

			local Humanoid = chr:WaitForChild("Humanoid")
			local Desc = Humanoid:GetAppliedDescription()
			Desc.HatAccessory = 63043890

			if msg == Command then
				Humanoid:ApplyDescription(Desc)	
			end

		end)
	end)
end)