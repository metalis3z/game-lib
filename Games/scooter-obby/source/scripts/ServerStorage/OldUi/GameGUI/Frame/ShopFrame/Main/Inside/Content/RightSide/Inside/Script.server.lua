local tabString = script.Parent.Tab

tabString.Changed:Connect(function()
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:GetAttribute("Tab") then
			v.Visible = false
		end
	end
	script.Parent[tabString.Value].Visible = true
end)