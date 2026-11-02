_G.cellphoneSettings = {
	["background"] = "default"
}

script.Parent.MouseButton1Click:Connect(function()
	
	for i,v in pairs(script.Parent.Parent.running:GetChildren()) do
		v.Visible = false
	end
	for i,v in pairs(script.Parent.Parent.apps:GetChildren()) do
		if not v.Visible then
			v.Visible = true
		end
	end
end)