local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local human = character.Humanoid
		wait(1)
		if human.RigType == Enum.HumanoidRigType.R15 then
			human:WaitForChild("BodyDepthScale").Value = 1.1
			human:WaitForChild("BodyHeightScale").Value = 0.5
			human:WaitForChild("BodyWidthScale").Value = 2.5
			human:WaitForChild("HeadScale").Value = 1.1
			human:WaitForChild("BodyProportionScale").Value = 0
			human:WaitForChild("BodyTypeScale").Value = 0.1
		end

	end)


end)

