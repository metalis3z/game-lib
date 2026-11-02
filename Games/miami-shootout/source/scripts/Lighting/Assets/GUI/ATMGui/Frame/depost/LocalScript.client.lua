local db = false

script.Parent.MouseButton1Click:Connect(function()
	local amount = script.Parent.Parent.TextBox.Text
	game.ReplicatedStorage.BankAction:FireServer("depo",amount)
end)