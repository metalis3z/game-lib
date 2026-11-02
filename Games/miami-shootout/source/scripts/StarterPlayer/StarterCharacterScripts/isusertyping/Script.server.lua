script.Parent.Typing.OnServerEvent:Connect(function(player,typingornot)
	if typingornot == "typing" then
		script.Parent.TextLabel.Text = tostring(player).." is typing"
		script.Parent.Parent.dots.one.Visible = true
		script.Parent.Parent.dots.two.Visible = true
		script.Parent.Parent.dots.three.Visible = true
		script.Parent.Parent.dots.Script.Disabled = false
	end
	if typingornot == "nottyping" then
		script.Parent.TextLabel.Text = ""
		script.Parent.Parent.dots.Script.Disabled = true
		script.Parent.Parent.dots.one.Size = UDim2.new(0.05,0,0.05,0)
		script.Parent.Parent.dots.two.Size = UDim2.new(0.05,0,0.05,0)
		script.Parent.Parent.dots.three.Size = UDim2.new(0.05,0,0.05,0)
		script.Parent.Parent.dots.one.ImageTransparency = 0.5
		script.Parent.Parent.dots.two.ImageTransparency = 0.5
		script.Parent.Parent.dots.three.ImageTransparency = 0.5
		script.Parent.Parent.dots.one.Visible = false
		script.Parent.Parent.dots.two.Visible = false
		script.Parent.Parent.dots.three.Visible = false
	end
end)