script.Parent.MouseButton1Click:Connect(function()
	local codeName: string = script.Parent.Parent.TextBox.Text
	if(codeName ~= "") then
		game.ReplicatedStorage.Remotes.UseCode:FireServer(codeName)
	end
end)