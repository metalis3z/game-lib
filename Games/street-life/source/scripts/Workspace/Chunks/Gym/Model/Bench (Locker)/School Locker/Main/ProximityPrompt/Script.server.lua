script.Parent.Triggered:Connect(function(Player)
	if not Player.Character then return end
	if not Player.Character:FindFirstChild('LeftHand') or not Player.Character:FindFirstChild('RightHand') then return end
	
	if not Player.Character.RightHand:FindFirstChild('RightGlove') then
		local Glove = game.ReplicatedStorage.Gloves.RightGlove:Clone()
		Glove.Parent = Player.Character.RightHand

		Player.Character.RightHand.Transparency = 1

		local Glove2 = game.ReplicatedStorage.Gloves.LeftGlove:Clone()
		Glove2.Parent = Player.Character.LeftHand

		Player.Character.LeftHand.Transparency = 1

		Glove.Weld.Part0 = Glove
		Glove.Weld.Part1 = Player.Character.RightHand
		Glove2.Weld.Part0 = Glove2
		Glove2.Weld.Part1 = Player.Character.LeftHand
	else
		Player.Character.RightHand:FindFirstChild('RightGlove'):Destroy()
		Player.Character.LeftHand:FindFirstChild('LeftGlove'):Destroy()
		Player.Character.RightHand.Transparency = 0
		Player.Character.LeftHand.Transparency = 0
	end
end)