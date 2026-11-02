if script.Parent.Transparency == 1 then
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Texture") then
			v.Transparency = 1
		end
	end
else
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Texture") then
			v.Transparency = 0.6
		end
	end
end

script.Parent:GetPropertyChangedSignal("Transparency"):Connect(function()
	if script.Parent.Transparency == 1 then
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("Texture") then
				v.Transparency = 1
			end
		end
	else
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("Texture") then
				v.Transparency = 0.6
			end
		end
	end
end)