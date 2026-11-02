local Remote = game.ReplicatedStorage:WaitForChild("HomeConfig"):WaitForChild("JoinNeutral")

script.Parent.MouseButton1Click:Connect(function()
	Remote:FireServer()
end)
