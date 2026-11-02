script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.Parent.Ban:FireServer(script.Parent.Parent.player.Text,script.Parent.Parent.reason.Text,script.Parent.Parent.time.Text,script.Parent.Parent.status)
end)