for i, v in pairs(script.Parent:GetChildren()) do
	if v:IsA("HandleAdornment") then
		v:Destroy()
	end
end