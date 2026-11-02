script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Visible = false
	game.ReplicatedStorage.Events.ClaimTycoon:FireServer(script.Parent.Parent.TycoonNumber.Value)
end)