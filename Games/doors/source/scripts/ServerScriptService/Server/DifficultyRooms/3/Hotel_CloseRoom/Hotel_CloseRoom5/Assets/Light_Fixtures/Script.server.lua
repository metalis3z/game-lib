for i, v in pairs(script.Parent:GetDescendants()) do
	if v:IsA("Light") then
		v.Enabled = true
	end
end