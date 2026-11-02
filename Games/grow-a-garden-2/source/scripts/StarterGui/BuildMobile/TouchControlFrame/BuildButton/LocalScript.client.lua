--credit to leon games studio
script.Parent.MouseButton1Down:Connect(function() --[[ Line: 1 ]]
	script.Parent.ImageColor3 = Color3.new(255/255, 255/255, 255/255)
end)
script.Parent.MouseButton1Up:Connect(function() --[[ Line: 5 ]]
	script.Parent.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
end)
script.Parent.MouseLeave:Connect(function() --[[ Line: 9 ]]
	script.Parent.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
end)