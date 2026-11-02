local Command = "@korblox" or "/korblox"
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(chr)
		player.Chatted:Connect(function(msg)
			local Humanoid = chr:WaitForChild("Humanoid")
			local Desc = Humanoid:GetAppliedDescription()
			Desc.RightLeg = 139607718 -- KorbloxLeg
			--
			if msg:sub(1, Command:len()):lower() == Command:lower() then -- 
				Humanoid:ApplyDescription(Desc) 
			end
			-- 
			--
		end)
	end)
end)
