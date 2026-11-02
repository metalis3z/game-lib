local IsOn = false

script.Parent.MouseButton1Click:Connect(function()
	if IsOn == false then
		IsOn = true 	
		script.Parent.MenuFrame:TweenSize(UDim2.new(-4, 0, 1, 0), "Out", "Quad", 0.5 , true)
	else
		IsOn = false 
		script.Parent.MenuFrame:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.5 , true)
	end
end)
