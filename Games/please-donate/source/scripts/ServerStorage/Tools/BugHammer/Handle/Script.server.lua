while wait() do
	for i, v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Texture") then
			v.OffsetStudsU = v.OffsetStudsU + 0.005
			v.OffsetStudsV = v.OffsetStudsV + 0.005
		end
	end
end