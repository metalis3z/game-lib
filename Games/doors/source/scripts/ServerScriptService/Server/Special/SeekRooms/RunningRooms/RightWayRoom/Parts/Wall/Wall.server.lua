for i = 1, 1 do
	if script.Parent.Parent.Parent.Colors.Wall:FindFirstChild("colortrue").Value == true then
		script.Parent.Color = script.Parent.Parent.Parent.Colors.Wall:WaitForChild("color").Value
	end
end