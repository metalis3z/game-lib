local button = script.Parent

button.MouseButton1Click:Connect(function()
	do
		local message = Instance.new("Message", workspace)
		message.Text = "team c00lkidd join today!"
		game.Debris:AddItem(message, 5)
	end
end)
