script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Visible = false
end)

script.Parent.MouseEnter:Connect(function()
	script.Parent.tl.Text = "I joke!"
end)


script.Parent.MouseLeave:Connect(function()
	script.Parent.tl.Text = "Kick a random player"
end)
