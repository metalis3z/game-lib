script.Parent.Parent.Changed:Connect(function(property)
	if property == "Transparency" then
		script.Parent.Transparency = script.Parent.Parent.Transparency
	end
end)