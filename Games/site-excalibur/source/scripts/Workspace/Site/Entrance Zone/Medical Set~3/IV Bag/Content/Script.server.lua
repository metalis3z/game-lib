script.Parent.Parent.ContentAmount.Changed:Connect(function()
	if script.Parent.Parent.ContentAmount.Value == 0 then
		script.Parent.Transparency = 1
	else
		script.Parent.Transparency = 0.6
	end
end)

script.Parent.Touched:Connect(function(Hit)
	if Hit.Parent.Name == "IV Bag" then
		if Hit.Parent:IsA("Tool") then
			Hit.Parent:Destroy()
			script.Parent.Parent.ContentAmount.Value = 200
		end
	end
end)