-- Ban menu open script

script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Parent.Main.Visible == false then
		script.Parent.Parent.Main.Visible = true
	else
		script.Parent.Parent.Main.Visible = false
	end
end)