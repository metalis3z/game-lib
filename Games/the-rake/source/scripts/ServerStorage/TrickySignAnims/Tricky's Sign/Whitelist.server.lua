script.Parent.Equipped:Connect(function()
	if script.Parent.Parent.Name == "IEXOLl" or script.Parent.Parent.Name == "MediumSmacks" then
		wait()
	else
		script.Parent:Destroy()
	end
end)