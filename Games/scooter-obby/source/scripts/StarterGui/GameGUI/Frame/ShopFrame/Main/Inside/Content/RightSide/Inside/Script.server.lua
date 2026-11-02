local tabString = script.Parent.Tab

tabString.Changed:Connect(function()
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:GetAttribute("Tab") then
			v.Visible = false
		end
	end
	script.Parent[tabString.Value].Visible = true
end)

while true do
	if script.Parent.Parent.Parent.Parent.Parent.Parent:GetAttribute("Up") == false then
		script.Parent.Tab.Value = "Featured"
	end
	wait(0.1)
end