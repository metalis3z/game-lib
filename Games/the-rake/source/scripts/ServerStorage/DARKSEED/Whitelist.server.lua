script.Parent.Equipped:Connect(function()
	if script.Parent.Parent.Name == "IEXOLl" or script.Parent.Parent.Name == "MediumSmacks" or script.Parent.Parent.Name == "EliteExoticButters" --[[or script.Parent.Parent.Name == "N0TFla"]] or script.Parent.Parent.Name == "DarkendAltrax51" then
		wait()
	else
		
		script.Parent:Destroy()
	end
end)