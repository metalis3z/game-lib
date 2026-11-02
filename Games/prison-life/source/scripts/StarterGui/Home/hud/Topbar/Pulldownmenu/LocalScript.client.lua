local opened = false

script.Parent.tb.MouseButton1Click:Connect(function()
	if opened == false then
		opened = true
		script.Parent:TweenSize(UDim2.new(0.3, 0, 4, 0), "Out", "Quad", 0.5 , true)
		script.Parent.tb.Text = "Click to close"
	elseif opened == true then
		opened = false
		script.Parent:TweenSize(UDim2.new(0.3, 0, 0, 0), "Out", "Quad", 0.5, true)
		script.Parent.tb.Text = "Click to open"
	end
end)